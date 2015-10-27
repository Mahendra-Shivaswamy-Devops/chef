default["DTelemetryZabbixClient"]["arch"] = node[:kernel][:machine] =~ /x86_64/ ? "x86_64" : "x86"
default["DTelemetryZabbixClient"]["install_dir"] = "/etc/zabbix"
default["DTelemetryZabbixClient"]["download_dir"] = "/tmp"
default["DTelemetryZabbixClient"]["config_file"] = "zabbix_agentd.conf" 
default["DTelemetryZabbixClient"]["config_file_path"] = "#{default["DTelemetryZabbixClient"]["install_dir"]}/#{default["DTelemetryZabbixClient"]["config_file"]}" 
default["DTelemetryZabbixClient"]["service_path"] = "/etc/init.d"
default["DTelemetryZabbixClient"]["service"] = default["DTelemetryZabbixClient"]["apt_package"]= "zabbix-agent"
default["DTelemetryZabbixClient"]["EnableRemoteCommand"] = "1"
default["DTelemetryZabbixClient"]["HostMetaDataItem"] = "system.uname"
default["DTelemetryZabbixClient"]["ListenPort"] = "10050"
default["DTelemetryZabbixClient"]["ListenIP"] = ""
default["DTelemetryZabbixClient"]["RefreshActiveChecks"] = "60"
#default["DTelemetryZabbixClient"]["Server"] = 
default["DTelemetryZabbixClient"]["init_dir"] = "/etc/init.d"
default["DTelemetryZabbixClient"]["agent_service"] = "zabbix-agent"


if platform?("ubuntu") 
	if node["platform_version"].to_f >= 14.04.to_f
		default["DTelemetryZabbixClient"]["version"] = "2.4"
		default["DTelemetryZabbixClient"]["flavor"] = "trusty"
    else
    	default["DTelemetryZabbixClient"]["version"] = "2.2"
		default["DTelemetryZabbixClient"]["flavor"] = "precise"
	end
end

if platform?("debian") 
	if node["platform_version"].to_f >= 7.0.to_f
		default["DTelemetryZabbixClient"]["version"] = "2.4"
	else
		default["DTelemetryZabbixClient"]["version"] = "2.2"
		default["DTelemetryZabbixClient"]["flavor"] = "squeeze"
	end
end


if platform?("ubuntu")
	default["DTelemetryZabbixClient"]["packagename"] = 
	"zabbix-release_#{default["DTelemetryZabbixClient"]["version"]}-1+#{default["DTelemetryZabbixClient"]["flavor"]}_all.deb"
	default["DTelemetryZabbixClient"]["downloadlocation"] = 
	"http://repo.zabbix.com/zabbix/#{default["DTelemetryZabbixClient"]["version"]}/#{node["platform"]}/pool/main/z/zabbix-release/#{default["DTelemetryZabbixClient"]["packagename"]}"
elsif platform?("debian")
	default["DTelemetryZabbixClient"]["packagename"] = 
	"zabbix-release_#{default["DTelemetryZabbixClient"]["version"]}-1+#{default["DTelemetryZabbixClient"]["flavor"]}_all.deb"
    default["DTelemetryZabbixClient"]["downloadlocation"] = 
    "http://repo.zabbix.com/zabbix/#{default["DTelemetryZabbixClient"]["version"]}/#{node["platform"]}/pool/main/z/zabbix-release/#{default["DTelemetryZabbixClient"]["packagename"]}"
end


if platform_family?("rhel") 
	if node["platform_version"].to_f >= 6.0.to_f
		default["DTelemetryZabbixClient"]["version"] = "2.4"
		default["DTelemetryZabbixClient"]["os_version"] = "6"
	else
		default["DTelemetryZabbixClient"]["version"] = "2.2"
		default["DTelemetryZabbixClient"]["os_version"] = "5"
	end
	default["DTelemetryZabbixClient"]["packagename"] = "zabbix-release-#{default["DTelemetryZabbixClient"]["version"]}-1.el#{default["DTelemetryZabbixClient"]["os_version"]}.noarch.rpm"
	default["DTelemetryZabbixClient"]["downloadlocation"] = 
	"http://repo.zabbix.com/zabbix/#{default["DTelemetryZabbixClient"]["version"]}/rhel/#{default["DTelemetryZabbixClient"]["os_version"]}/x86_64/#{default["DTelemetryZabbixClient"]["packagename"]}"
end

#rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
#rpm -ivh http://repo.zabbix.com/zabbix/2.2/rhel/5/x86_64/zabbix-release-2.2-1.el5.noarch.rpm


 default["DTelemetryZabbixClient"]["packagename-rpm"] = "#{default["DTelemetryZabbixClient"]["packagename"]}".chop.chop.chop.chop