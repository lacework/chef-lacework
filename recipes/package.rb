#
# Cookbook:: chef-lacework
# Recipe:: package
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'chef-lacework::config'

case node['platform_family']
when 'debian'
  include_recipe 'chef-lacework::_deb'
when 'rhel'
  include_recipe 'chef-lacework::_rpm'
end
