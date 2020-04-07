#
# Cookbook:: chef-lacework
# Recipe:: _apt
#
# Copyright:: 2020, Lacework, All Rights Reserved.
case node['platform']
when 'ubuntu'
  apt_repository 'packages-lacework-prod' do
    uri "https://packages.lacework.net/DEB/#{node['platform']}/#{node['platform_version']}"
    arch 'amd64'
    key ['18E76630']
    keyserver 'keyserver.ubuntu.com'
    components ['main']
    action :add
  end
when 'debian'
  execute 'apt update --allow-releaseinfo-change'

  apt_repository 'packages-lacework-prod' do
    uri "https://packages.lacework.net/DEB/#{node['platform']}/#{node['platform_version'].to_i}"
    arch 'amd64'
    key ['18E76630']
    keyserver 'keyserver.ubuntu.com'
    components ['main']
    action :add
  end
end

apt_package 'lacework' do
  action :install
end
