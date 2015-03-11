#
# Cookbook Name:: storm
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "unzip"

if node[:storm][:release_name]
  storm_name = node[:storm][:release_name]
else
  storm_name = "storm-#{node[:storm][:release_version]}"
end

storm_zip = File.join(Chef::Config[:file_cache_path], "/", "#{storm_name}.zip")
install_dir = "#{node[:storm][:install_root]}/#{storm_name}"
storm_jar = "#{install_dir}/#{storm_name}.jar"
storm_conf = "#{install_dir}/conf/storm.yaml"

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
  not_if { ::FileTest.exists? install_dir }
end

link "#{node[:storm][:executable_path]}/storm" do
  to "#{install_dir}/bin/storm"
end

nimbus = discover(:storm, :nimbus)
zookeepers = discover_all(:zookeeper, :server).map(&:private_hostname).sort

settings_variables = {
  :zookeepers => zookeepers.empty? ? ["localhost"] : zookeepers,
  :nimbus     => nimbus.nil? ? "localhost" : nimbus.private_hostname,
  :drpc_hosts => discover_all(:storm, :drpc).map(&:private_hostname).sort,
  :hostname => node[:fqdn].dup
}

template "#{storm_conf}" do
  mode 0755
  variables(settings_variables)
  source "storm.yaml.erb"
end

# at version 0.9 storm switched to logback for logging
if node[:storm][:release_version].include? "0.8"
  template "#{install_dir}/log4j/storm.log.properties" do
    mode 0644
    source "storm.log.properties.erb"
  end
end

if node[:storm][:release_version].include? "0.9"
  template "#{install_dir}/logback/cluster.xml" do
    mode 0644
    source "cluster.xml.erb"
  end
end

if node[:storm][:release_version].include? "0.9"
  template "#{install_dir}/logback/worker.xml" do
    mode 0644
    source "worker.xml.erb"
  end
end

if node[:storm][:release_version].include? "0.10"
  template "#{install_dir}/logback/cluster.xml" do
    mode 0644
    source "cluster.xml.erb"
  end
end

if node[:storm][:release_version].include? "0.10"
  template "#{install_dir}/logback/worker.xml" do
    mode 0644
    source "worker.xml.erb"
  end
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
