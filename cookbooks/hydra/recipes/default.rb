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

#remote_file "/etc/monit.d/hydra_daemon.monitrc" do
#  source "hydra.monitrc.erb"
#  owner "root"
#  group "root"
#  mode "0755"
#end

execute "ensure-hydra-is-setup-with-monit" do
  command %Q{
  monit reload
  }
end

#execute "restart-hydra" do
#  command %Q{
#    echo "sleep 20 && monit -g hydra restart" | at now
#  }
#end

end
