runit_service "supervisor" do
  template_name "storm"
  options :daemon => "supervisor"
end