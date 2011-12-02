template '/usr/local/bin/db' do
  action :create_if_missing
  owner "root"
  group "root"
  mode "0755"
  source "db.erb"
  variables({:password =>  node[:users][0][:password], :host => node[:db_host] })
end
