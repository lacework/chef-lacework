#
# Cookbook:: chef-lacework
# Recipe:: config
#
# Copyright:: 2020, Lacework, All Rights Reserved.
directory '/var/lib/lacework/config' do
  recursive true
end

template '/var/lib/lacework/config/config.json' do
  source 'config.json.erb'
  variables(
    config: node['chef-lacework']['config']
  )
end
