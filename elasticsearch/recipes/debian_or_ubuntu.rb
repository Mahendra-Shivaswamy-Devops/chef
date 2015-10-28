apt_repository 'elasticsearch' do
uri "http://packages.elastic.co/elasticsearch/#{node["elasticsearch"]["version"]}/debian"
components ['stable', 'main']
key 'https://packages.elastic.co/GPG-KEY-elasticsearch'
end

package "elasticsearch"




service "elasticsearch" do
action :restart
end
