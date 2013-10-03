storm_name = "storm-#{node[:storm][:release_version]}"
install_dir = "#{node[:storm][:install_root]}/#{storm_name}"

runit_service "drpc" do
  template_name "storm"
  options :daemon => "drpc", :install_dir => install_dir
end
announce(:storm, :drpc)
