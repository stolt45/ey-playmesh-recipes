require 'pp'
#
# Cookbook Name:: memcached
# Recipe:: default
#

node[:applications].each do |app_name,data|
  user = node[:users].first

case node[:instance_role]
 when "app", "app_master", "Memcache"
   template "/data/#{app_name}/current/config/memcached.yml" do
     source "memcached.yml.erb"
     owner user[:username]
     group user[:username]
     mode 0744
     variables({
         :app_name => app_name,
         :server_names => node[:members]
     })
   end
 
   template "/etc/conf.d/memcached" do
     owner 'root'
     group 'root'
     mode 0644
     source "memcached.erb"
     variables :memusage => 512,
               :port     => 11211
   end

   remote_file "/etc/monit.d/memcached.monitrc" do
     owner "root"
     group "root"
     mode 0755
     source "memcached.monitrc"
     action :create
   end

   execute "restart monit" do
     command "pkill monit && telinit q"
     action :run
   end
 end
end
