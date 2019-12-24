#
# Cookbook:: chef-lacework
# Recipe:: repo
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'chef-lacework::config'

case node['platform_family']
when 'debian'
  include_recipe 'chef-lacework::_apt'
when 'rhel'
  include_recipe 'chef-lacework::_yum'
end
