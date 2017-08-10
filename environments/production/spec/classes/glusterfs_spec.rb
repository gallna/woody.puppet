require 'spec_helper'

describe 'profiles::glusterfs::repo' do
  let(:title) { 'profiles::glusterfs::repo' }
  let(:node) { 'test.example.com' }
  let(:environment) { 'production' }
  let(:module_path) { 'site:modules' }
  let(:pre_condition) { 'include apt' }
  let(:facts) { {
    :lsbdistid       => 'Ubuntu',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'trusty',
    :lsbdistrelease  => '14.04',
    :puppetversion   => Puppet.version
  } }
  let(:params) { {'version' => '3.10'} }
  it { is_expected.to compile }
  it { is_expected.to compile.with_all_deps }
  it { is_expected.to contain_package('glusterfs-server').with_ensure('installed') }
  it { is_expected.to contain_service('glusterfs-server').with_ensure('running') }
  it { is_expected.to contain_package('glusterfs-client').with_ensure('installed') }
end
