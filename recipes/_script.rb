#
# Cookbook:: chef-lacework
# Recipe:: _script
#
# Copyright:: 2020, The Authors, All Rights Reserved.
remote_file "#{node['chef-lacework']['install_script']['dir']}/install.sh" do
  source 'https://packages.lacework.net/install.sh'
  mode '0500'
end

execute 'install.sh' do
  command "#{node['chef-lacework']['install_script']['dir']}/install.sh #{node['chef-lacework']['accesstoken']}"

  not_if { ::File.exist?('/var/lib/lacework/datacollector') }
end
