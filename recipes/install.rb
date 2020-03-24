#
# Cookbook:: chef-lacework
# Recipe:: install
#
# Copyright:: 2020, Lacework, All Rights Reserved.

case node['chef-lacework']['install_method']
when 'install_script'
  include_recipe 'chef-lacework::_script'
when 'repo'
  include_recipe 'chef-lacework::repo'
when 'package'
  include_recipe 'chef-lacework::package'
end
