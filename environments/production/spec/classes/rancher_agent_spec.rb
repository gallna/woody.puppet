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
  let(:params) { {
    'registration_url' => 'http://server',
    'host_labels' => {'foo'=>'bar','baz'=>'foobar'},
  } }
  it { is_expected.to compile }
  it { is_expected.to compile.with_all_deps }
  it { is_expected.to contain_package('docker').with_ensure('1.12.3-0~trusty') }
  it { is_expected.to contain_service('docker').with_ensure('running') }
  it { is_expected.to contain_exec('launch rancher agent')
      .with_command(/foo=bar&baz=foobar/)
      .with_command(/CATTLE_HOST_LABELS='foo=bar&baz=foobar'/)
  }
  
  context "with a custom image tag" do
    let(:params) { { 'registration_url' => 'http://server', image_tag: 'v1.0.1' } }
    it do
      is_expected.to compile.with_all_deps
      is_expected.to contain_exec('launch rancher agent')
        .with_command(/rancher\/agent:v1.0.1/)
    end
  end

  context "with required registration_url" do
    let(:params) { { 'registration_url' => 'http://server', } }
    it do
      is_expected.to compile.with_all_deps
      is_expected.to contain_class('rancher::params')
      is_expected.to contain_exec('launch rancher agent')
        .with_command(/rancher\/agent:latest/)
    end
  end
end
