runit_service "nimbus" do
  template_name "storm"
  options :daemon => "nimbus"
end
announce (:storm, :nimbus)