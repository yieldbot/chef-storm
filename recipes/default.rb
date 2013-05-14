#
# Cookbook Name:: storm
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "unzip"

storm_name = "storm-#{node[:storm][:release_version]}"
storm_zip = File.join(Chef::Config[:file_cache_path], "/", "#{storm_name}.zip")
storm_jar = "#{node[:storm][:install_dir]}/#{storm_name}.jar"
storm_conf = "#{node[:storm][:install_dir]}/conf/storm.yaml"

remote_file "#{storm_zip}" do
  source "#{node[:storm][:release_root]}/#{storm_name}.zip"
  not_if { ::FileTest.exists? storm_zip }
end

bash "install storm" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    unzip #{storm_zip} -d #{node[:storm][:install_root]}
  EOH
  not_if { ::FileTest.exists? storm_jar }
  not_if { ::FileTest.exists? node[:storm][:install_dir] }
end

nimbus = discover(:storm, :nimbus)

settings_variables = {
  :zookeepers => discover_all(:zookeeper, :server).map(&:private_ip).sort,
  :nimbus     => nimbus.nil? ? "localhost" : nimbus.private_ip,
  :drpc_hosts => discover_all(:storm, :drpc_host).map(&:private_ip).sort,
}

template "#{storm_conf}" do
  mode 0755
  variables(settings_variables)
  source "storm.yaml.erb"
end

template "#{node[:storm][:install_dir]}/log4j/storm.log.properties" do
  mode 0644
  source "storm.log.properties.erb"
end

%w{log_dir data_dir}.each do |dir|
   directory node[:storm][dir] do
      mode 0755
      recursive true
      owner node[:storm]['user']
      group node[:storm]['group']
      action :create
   end
end
