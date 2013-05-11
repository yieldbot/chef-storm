runit_service "drpc" do
  template_name "storm"
  options :daemon => "drpc"
end
announce(:storm, :drpc)
