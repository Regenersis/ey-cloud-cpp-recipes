template '/usr/local/bin/db' do
  owner "deploy"
  group "deploy"
  mode "0755"
  source "db.erb"
  variables({:password =>  node[:cron][:users][:password], :host => node[:db_host] })
end
