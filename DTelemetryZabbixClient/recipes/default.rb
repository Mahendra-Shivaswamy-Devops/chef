#
# Cookbook Name:: DTelemetryZabbixClient
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node["os"]
  when "linux"
    Chef::Log.info("Its Linux")
    case node["platform"]
        when "debian", "ubuntu"
	      # do debian/ubuntu things
        Chef::Log.info("Its #{node["platform"]} platform and #{node["platform_family"]}")
        include_recipe "DTelemetryZabbixClient::debian_or_ubuntu"
	      when "redhat", "centos", "fedora"
	      # do redhat/centos things
        Chef::Log.info("Its #{node["platform"]} platform and #{node["platform_family"]}")
        include_recipe "DTelemetryZabbixClient::rhel_or_centos"
      end
  when "windows"
  include_recipe "DTelemetryZabbixClient::windows"
  else
  Chef::Log.info("Oops...couldn't understand #{node.os} yet!!!")
end
