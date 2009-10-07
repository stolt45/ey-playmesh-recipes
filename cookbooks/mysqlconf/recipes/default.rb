require 'pp'
#
# Cookbook Name:: mysqlconf
# Recipe:: default
#

if (node[:instance_role] == 'db_master')
 remote_file "/etc/mysql/my.cnf" do
   owner "root"
   group "root"
   mode 0755
   source "my.cnf"
   action :create
 end
end

