#
# Cookbook:: chef-lacework
# Recipe:: _deb
#
# Copyright:: 2019, The Authors, All Rights Reserved.
remote_file "#{node['chef-lacework']['package_dir']}/#{node['chef-lacework']['deb_package']['package_name']}" do
  source node['chef-lacework']['deb_package']['url']
  checksum node['chef-lacework']['deb_package']['shasum']
end

dpkg_package node['chef-lacework']['deb_package']['package_name'] do
  source "#{node['chef-lacework']['package_dir']}/#{node['chef-lacework']['deb_package']['package_name']}"
  action :install
end
