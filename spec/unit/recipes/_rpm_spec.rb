#
# Cookbook:: chef-lacework
# Spec:: _rpm
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chef-lacework::_rpm' do
  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7'
    default_attributes['chef-lacework']['rpm_package']['url'] = 'https://mycompany.lacework.net/mgr/v1/download/fff/lacework-latest-1.x86_64.rpm'

    describe 'creates an rpm with the default action' do
      it { is_expected.to create_remote_file('/tmp/lacework-latest-1.x86_64.rpm') }
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
