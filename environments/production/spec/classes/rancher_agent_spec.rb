require 'spec_helper'

describe 'profiles::rancher::agent' do
  let(:title) { 'profiles::rancher::agent' }
  let(:node) { 'test.example.com' }
  let(:environment) { 'production' }
  let(:module_path) { 'site:modules' }
  # let(:pre_condition) { 'include apt' }
  let(:facts) { {
    :operatingsystem => 'Ubuntu',
    :lsbdistid       => 'Ubuntu',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'trusty',
    :lsbdistrelease  => '14.04',
    :operatingsystemrelease  => '14.04',
    :kernelrelease  => 'Linux',
    :ipaddress      => '192.168.0.1',
    :puppetversion   => Puppet.version
  } }
  let(:params) { {'server_url' => 'http://server'} }
  it { is_expected.to compile }
  it { is_expected.to compile.with_all_deps }
  it { is_expected.to contain_package('docker').with_ensure('1.12.3-0~trusty') }
  it { is_expected.to contain_service('docker').with_ensure('running') }
end
