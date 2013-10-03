runit_service "nimbus" do
  template_name "storm"
  options :daemon => "nimbus"
  options :install_dir => install_dir
end
announce(:storm, :nimbus)
