runit_service "ui" do
  template_name "storm"
  options :daemon => "ui"
end