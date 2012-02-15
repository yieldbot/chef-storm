#
# Cookbook Name:: storm
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "unzip"

python_pip "psutil" do
  version "0.2.1"
  action :install
end

storm_zip = File.join(Chef::Config[:file_cache_path], "/", "#{node[:storm][:release_version]}.zip")
storm_jar = "#{node[:storm][:install_dir]}/#{node[:storm][:release_version]}.jar"
storm_conf = "#{node[:storm][:install_dir]}/conf/storm.yaml"

remote_file "#{storm_zip}" do
  source "#{node[:storm][:release_root]}/#{node[:storm][:release_version]}.zip"
end

bash "install storm" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    unzip #{storm_zip} -d #{node[:storm][:install_root]}
  EOH
  not_if { ::FileTest.exists?("#{storm_jar}") }
end

settings_variables = {
  :zookeepers => all_provider_private_ips("#{node[:cluster_name]}-zookeeper"),
  :nimbus     => provider_private_ip("#{node[:cluster_name]}-nimbus"),
  :drcp_hosts => all_provider_private_ips("#{node[:cluster_name]}-drcp-host"),
}

template "#{storm_conf}" do
  mode 0755
  variables(settings_variables)
  source "storm.yaml.erb"
end

template "#{node[:storm][:install_dir]}/bin/storm" do
  mode 0755
  source "storm.erb"
end

template "#{node[:storm][:install_dir]}/log4j/storm.log.properties" do
  mode 0644
  source "storm.log.properties.erb"
end

%w{log_dir data_dir}.each do |dir|
   directory node[:storm][dir] do
      mode 0755
      owner node[:storm]['user']
      group node[:storm]['group']
      action :create
   end
end
