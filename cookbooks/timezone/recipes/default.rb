if !['db_master', 'db_slave'].include?(node[:instance_role])
  script "update timezone" do
    interpreter "bash"
    user "root"
    cwd "/engineyard/bin/"
    code <<-EOH
    cp /usr/share/zoneinfo/Europe/London /etc/localtime
    if grep -q "Europe/London" /etc/conf.d/clock
    then
      exit
    fi
    echo "TIMEZONE=\\"Europe/London\\"" >> /etc/conf.d/clock
    EOH
  end
end

