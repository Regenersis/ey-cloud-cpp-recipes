#
# Cookbook Name:: hydra
# Recipe:: default
#

if !['db_master', 'db_slave'].include?(node[:instance_role])

template '/etc/monit.d/cpp_hydra_daemon.monitrc' do
  owner "root"
  group "root"
  mode "0755"
  source "cpp_hydra.monitrc.erb"
  variables({:environment =>  node[:environment][:framework_env]})
end

template "/etc/init.d/cpp_hydra" do
  source "cpp_hydra.init.d.erb"
  owner "root"
  group "root"
  mode "0755"
  variables({:environment =>  node[:environment][:framework_env]})
end

execute "ensure-hydra-is-setup-with-monit" do
  command %Q{
  monit reload
  }
end

#service "cpp_hydra" do
#  supports :restart => true
#  action [:stop, :start]
#end

#execute "restart-hydra" do
#  command %Q{
#    echo "sleep 20 && monit -g hydra restart" | at now
#  }
#end

end
