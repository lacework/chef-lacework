#
# Cookbook:: chef-lacework
# Recipe:: _script
#
# Copyright:: 2019, The Authors, All Rights Reserved.
directory node['chef-lacework']['install_script']['dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template "#{node['chef-lacework']['install_script']['dir']}/install.sh" do
  source 'install.sh.erb'
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

execute "#{node['chef-lacework']['install_script']['dir']}/install.sh" do
  action :run
end
