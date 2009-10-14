require 'pp'
#
# Cookbook Name:: timezones
# Recipe:: default

link "/etc/localtime" do
  to "/usr/share/zoneinfo/GMT"
end

