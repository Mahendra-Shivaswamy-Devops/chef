include_recipe "apt"

remote_file "#{node["DTelemetryZabbixClient"]["download_dir"]}/#{node["DTelemetryZabbixClient"]["packagename"]}" do
  action :create_if_missing
  owner "root"
  group "root"
  mode "0644"
  source "#{node["DTelemetryZabbixClient"]["downloadlocation"]}"
end

dpkg_package "#{node["DTelemetryZabbixClient"]["packagename"]}" do
  source "#{node["DTelemetryZabbixClient"]["download_dir"]}/#{node["DTelemetryZabbixClient"]["packagename"]}"
  action :install
end

execute "apt-get update" do
	command "sudo apt-get update"
	action :run
end

apt_package "#{node["DTelemetryZabbixClient"]["apt_package"]}" do
  action :install
end

file "#{node["DTelemetryZabbixClient"]["config_file_path"]}.backup" do
  lazy { content IO.read("#{node["DTelemetryZabbixClient"]["config_file_path"]}") }
  mode "0644"
  owner "root"
  group "root"
  action :create_if_missing
  only_if {File.exists?("#{node["DTelemetryZabbixClient"]["config_file_path"]}")}
  not_if {File.exists?("#{node["DTelemetryZabbixClient"]["config_file_path"]}.backup")}
end

#/etc/init.d/zabbix_agentd {start|stop|restart|force-reload}
service "#{node["DTelemetryZabbixClient"]["agent_service"]}" do
  #path "#{node["DTelemetryZabbixClient"]["init_dir"]}"
  supports :status => true, :restart => true, :reload => true
  action :nothing
end

template "#{node["DTelemetryZabbixClient"]["config_file_path"]}" do
  source 'zabbix_agentd.conf.erb'
  owner 'root'	
  group 'root'
  mode '0644'
  variables :ZabbixServerIP => node["ipaddress"]
  notifies :restart, "service[#{node["DTelemetryZabbixClient"]["agent_service"]}]", :immediately
end
