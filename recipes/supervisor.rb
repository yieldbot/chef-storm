directory "#{node[:storm][:log_dir]}/supervisor" do
  mode 0755
  owner node[:storm]['user']
  group node[:storm]['group']
  action :create
end
runit_service "supervisor" do
  template_name "storm"
  options :daemon => "supervisor"
end