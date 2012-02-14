runit_service "nimbus" do
  template_name "storm"
  options :daemon => "nimbus"
end
provide_service ("#{node[:cluster_name]}-nimbus")