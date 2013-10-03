storm_name = "storm-#{node[:storm][:release_version]}"
install_dir = "#{node[:storm][:install_root]}/#{storm_name}"

runit_service "supervisor" do
  template_name "storm"
  options :daemon => "supervisor", :install_dir => install_dir
end
