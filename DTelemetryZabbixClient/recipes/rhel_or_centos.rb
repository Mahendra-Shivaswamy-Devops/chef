service "#{node["DTelemetryZabbixClient"]["agent_service"]}" do
  #path "#{node["DTelemetryZabbixClient"]["init_dir"]}"
  supports :status => true, :restart => true, :reload => true
  action :nothing
  only_if {File.exists?("#{node["DTelemetryZabbixClient"]["init_dir"]}/#{node["DTelemetryZabbixClient"]["agent_service"]}")}
end

execute "install repo" do
  command "rpm -ivh #{node["DTelemetryZabbixClient"]["downloadlocation"]}"
  not_if "rpm -q #{node["DTelemetryZabbixClient"]["packagename-rpm"]}"
  #not_if {File.exists?("#{node["DTelemetryZabbixClient"]["init_dir"]}/#{node["DTelemetryZabbixClient"]["agent_service"]}")}
  #notifies :install, "yum_package[#{node["DTelemetryZabbixClient"]["agent_service"]}]", :immediately
  #notifies :restart, "service[#{node["DTelemetryZabbixClient"]["agent_service"]}]", :immediately
end

yum_package "#{node["DTelemetryZabbixClient"]["agent_service"]}" do
  action :install
  not_if {File.exists?("#{node["DTelemetryZabbixClient"]["init_dir"]}/#{node["DTelemetryZabbixClient"]["agent_service"]}")}
end

file "#{node["DTelemetryZabbixClient"]["config_file_path"]}.backup" do
  lazy { content IO.read("#{node["DTelemetryZabbixClient"]["config_file_path"]}") }
  mode "0644"
  owner "root"
  group "root"
  only_if {File.exists?("#{node["DTelemetryZabbixClient"]["config_file_path"]}")}
  not_if {File.exists?("#{node["DTelemetryZabbixClient"]["config_file_path"]}.backup")}
end

#/etc/init.d/zabbix_agentd {start|stop|restart|force-reload}

template "#{node["DTelemetryZabbixClient"]["config_file_path"]}" do
  source 'zabbix_agentd.conf.erb'
  owner 'root'  
  group 'root'
  mode '0644'
  variables :ZabbixServerIP => node["ipaddress"]
  notifies :restart, "service[#{node["DTelemetryZabbixClient"]["agent_service"]}]", :immediately
end
