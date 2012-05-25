#cron "my-cron-job" do
#  action :delete
#end

cron "my-cron-job" do
  minute   '10'
  hour     '1'
  day      '*'
  month    '*'
  weekday  '*'
  command  "/usr/local/ey_resin/bin/eybackup"
  not_if { node[:backup_window].to_s == '0' }
end
