#
# Cookbook:: chef-lacework
# Recipe:: _deb
#
# Copyright:: 2020, The Authors, All Rights Reserved.
remote_file "#{node['chef-lacework']['package_dir']}/#{node['chef-lacework']['deb_package']['package_name']}" do
  source node['chef-lacework']['deb_package']['url']
end

dpkg_package node['chef-lacework']['deb_package']['package_name'] do
  source "#{node['chef-lacework']['package_dir']}/#{node['chef-lacework']['deb_package']['package_name']}"
  action :install
end
