#
# Cookbook:: chef-lacework
# Recipe:: _script
#
# Copyright:: 2020, Lacework, All Rights Reserved.
remote_file "#{node['chef-lacework']['install_script']['dir']}/install.sh" do
  source 'https://packages.lacework.net/install.sh'
  mode '0500'
end

execute 'install.sh' do
  command "#{node['chef-lacework']['install_script']['dir']}/install.sh #{node['chef-lacework']['accesstoken']}"
  # does not prevent it from being exposed in the process table
  sensitive true

  not_if { ::File.exist?('/var/lib/lacework/datacollector') }
end
