if node[:storm][:release_name]
  storm_name = node[:storm][:release_name]
else
  storm_name = "storm-#{node[:storm][:release_version]}"
end

install_dir = "#{node[:storm][:install_root]}/#{storm_name}"

runit_service "logviewer" do
  template_name "storm"
  options :daemon => "logviewer", :install_dir => install_dir
end
