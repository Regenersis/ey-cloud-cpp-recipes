if !['db_master', 'db_slave'].include?(node[:instance_role])
  script "modify passenger_monitor" do
    interpreter "bash"
    user "root"
    cwd "/engineyard/bin/"
    code <<-EOH
    cp passenger_monitor passenger_monitor.old
    sed -e 's/rss_limit=[0-9]*/rss_limit=921600/' passenger_monitor > passenger_monitor.new
    cp passenger_monitor.new passenger_monitor
    chmod +x passenger_monitor 
    EOH
  end
end
