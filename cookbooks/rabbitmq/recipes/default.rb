#download to temp, then extract then copy to /usr/sbin
#http://www.rabbitmq.com/releases/rabbitmq-server/v2.7.0/rabbitmq-server-generic-unix-2.7.0.tar.gz

if !['db_master', 'db_slave'].include?(node[:instance_role]) && node[:rabbitmq].nil?

  remote_file "/tmp/rabbitmq-server-generic-unix-2.7.0.tar.gz" do
    source "http://www.rabbitmq.com/releases/rabbitmq-server/v2.7.0/rabbitmq-server-generic-unix-2.7.0.tar.gz"
  end

  #package "net-misc/rabbitmq-server" do
  #  action :install
  #end

  directory "/etc/rabbitmq" do
    action :create
    owner "root"
    owner "root"
    mode 0755
    recursive true
  end

#  directory "/var/lib/rabbitmq" do
#    action :create
#    owner "root"
#    group "root"
#    mode 0755
#    recursive true
#  end

  script "install rabbitmq" do
    interpreter "bash"
    user "root"
    cwd node[:temp_folder]
    code <<-EOH
      tar xvfz /tmp/rabbitmq-server-generic-unix-2.7.0.tar.gz
      cd /tmp/rabbitmq_server-2.7.0
      cp -ra . /var/lib/rabbitmq
    EOH
  end

#  service "rabbitmq" do
#    start_command "/var/lib/rabbitmq/sbin/rabbitmq-server -detached"
#    stop_command "/var/lib/rabbitmq/sbin/rabbitmqctl stop"
#    supports [ :restart, :status ]
#    action [ :enable, :start ]
#  end

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
      /var/lib/rabbitmq/sbin/rabbitmq-server -detached
    }
  end
end
