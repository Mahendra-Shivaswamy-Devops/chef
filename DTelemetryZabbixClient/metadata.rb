name             'DTelemetryZabbixClient'
maintainer       'DevOps Ghost'
maintainer_email 'mahendra.shivaswamy@outlook.com'
license          'All rights reserved'
description      'Installs/Configures zabbix client which points to zabbix server whose ip and hostname available in data bag \'ZabbixServer\' '
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.0'

#%w{ ubuntu centos }.each do |os|
#	supports os
# end
depends "apt"
