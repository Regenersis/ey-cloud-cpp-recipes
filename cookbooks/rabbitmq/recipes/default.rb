if !['db_master', 'db_slave'].include?(node[:instance_role])
package "net-misc/rabbitmq-server" do
  action :install
end

directory "/etc/rabbitmq" do
  action :create
  owner "root"
  owner "root"
  mode 0755
  recursive true
end

directory "/var/lib/rabbitmq" do
  action :create
  owner "root"
  group "root"
  mode 0755
  recursive true
end

#service "rabbitmq" do
#  start_command "rabbitmq-server -detached"
#  stop_command "rabbitmqctl stop"
#  supports [ :restart, :status ]
#  action [ :enable, :start ]
#end

template "/etc/rabbitmq/rabbitmq.conf" do
  source "rabbitmq.config.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    :nodename => node[:rabbitmq][:nodename],
    :node_ip_address => node[:rabbitmq][:address],
    :node_port => node[:rabbitmq][:port],
    :server_erl_args => node[:rabbitmq][:erl_args],
    :cluster_config_file => node[:rabbitmq][:cluster_config],
    :log_base => node[:rabbitmq][:logdir],
    :mnesia_base => node[:rabbitmq][:mnesiadir],
    :server_start_args => node[:rabbitmq][:start_args]
  })
#  notifies :restart, resources(:service => "rabbitmq")
end

#execute "stop-rabbitmq" do
#  command "rabbitmq-server -detached"
#  action :run
#end

execute "start-rabbitmq" do
  command %Q{
    /usr/sbin/rabbitmq-server -detached
  }
end
end