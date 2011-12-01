#
# Cookbook Name:: cas_server
# Recipe:: default
#

  
  
if !['db_master', 'db_slave'].include?(node[:instance_role])
  if !node[:applications].has_key?("users")
    raise "Users application must be deployed for cas to work"
  end

  template "/data/cas/current/config.yml" do
    source "config.yml.erb"
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    variables({
        :username => node[:users][0][:username],
        :password => node[:users][0][:password],
        :dbhost => node[:db_host]
      })    
  end  

end