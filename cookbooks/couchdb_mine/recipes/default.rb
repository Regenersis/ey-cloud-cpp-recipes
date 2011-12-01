include_recipe "erlang"

package "dev-db/couchdb" do
  action :install
end

directory "/var/lib/couchdb" do
  owner "couchdb"
  group "couchdb"
  recursive true
end

remote_file "/etc/init.d/couchdb" do
  source "couchdb.init"
  owner "root"
  group "root"
  mode "0755"
end

execute "start-couchdb" do
  user "root"
  command %Q{
  echo "/etc/init.d/couchdb start" | at now
  }
end
 