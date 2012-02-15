directory "#{node[:storm][:log_dir]}/nimbus" do
  mode 0755
  owner node[:storm]['user']
  group node[:storm]['group']
  action :create
end
runit_service "nimbus" do
  template_name "storm"
  options :daemon => "nimbus"
end
provide_service ("#{node[:cluster_name]}-nimbus")