cron "download_forward_data" do
  minute 0
  hour 2
  command 'cd /data/forward/current && bundle exec ruby script/runner "DataDownload.download_shipment_data" -e production'
  only_if do File.exists?("/data/forward/current") end
end
