#
# Cookbook:: chef-lacework
# Recipe:: install
#
# Copyright:: 2019, The Authors, All Rights Reserved.

case node['chef-lacework']['install_method']
when 'script'
  include_recipe 'chef-lacework::_script'
when 'yum'
  include_recipe 'chef-lacework::_yum'
when 'apt'
  include_recipe 'chef-lacework::_apt'
end