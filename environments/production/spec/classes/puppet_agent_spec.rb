require 'spec_helper'

describe 'profiles::puppet::agent' do
  let(:title) { 'profiles::puppet::agent' }
  let(:node) { 'test.example.com' }
  let(:environment) { 'production' }
  let(:module_path) { 'site:modules' }
  # let(:pre_condition) { 'include puppet' }
  let(:facts) { {
    :lsbdistid       => 'Ubuntu',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'trusty',
    :lsbdistrelease  => '14.04',
    :puppet_server   => 'puppet',
    :puppetversion   => Puppet.version
  } }
  it { is_expected.to compile }
  it { is_expected.to compile.with_all_deps }
  it { is_expected.to contain_package('puppet-agent').with_ensure('installed') }
end
