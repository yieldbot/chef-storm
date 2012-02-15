directory "#{node[:storm][:log_dir]}/ui" do
  mode 0755
  owner node[:storm]['user']
  group node[:storm]['group']
  action :create
end
runit_service "ui" do
  template_name "storm"
  options :daemon => "ui"
end