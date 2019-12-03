#
# Cookbook:: chef-lacework
# Recipe:: _yum
#
# Copyright:: 2019, The Authors, All Rights Reserved.
yum_repository 'packages-lacework-prod' do
  action :create
  baseurl 'https://packages.lacework.net/RPMS/x86_64'
  gpgkey 'https://packages.lacework.net/keys/RPM-GPG-KEY-lacework'
  gpgcheck true
  enabled true
end

package 'lacework' do
  action :install
end
