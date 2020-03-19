#
# Cookbook:: chef-lacework
# Recipe:: _rpm
#
# Copyright:: 2020, The Authors, All Rights Reserved.

remote_file "#{node['chef-lacework']['package_dir']}/#{node['chef-lacework']['rpm_package']['package_name']}" do
  source node['chef-lacework']['rpm_package']['url']
end

rpm_package node['chef-lacework']['rpm_package']['package_name'] do
  source "#{node['chef-lacework']['package_dir']}/#{node['chef-lacework']['rpm_package']['package_name']}"
end
