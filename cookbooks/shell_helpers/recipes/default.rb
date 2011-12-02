dna_script = JSON.parse(IO.read('/etc/chef/dna.json'))

template '/usr/local/bin/db' do
  owner "deploy"
  group "deploy"
  mode "0755"
  source "db.erb"
  variables({:password =>  dna_script[:cron][:users][:password]})
end
