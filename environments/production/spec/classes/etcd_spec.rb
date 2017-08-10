require 'spec_helper'

describe 'profiles::etcd' do
  let(:title) { 'profiles::etcd' }
  let(:node) { 'test.example.com' }
  let(:environment) { 'production' }
  let(:module_path) { 'site:modules' }
  let(:facts) { {
    :osfamily => 'Debian',
    :operatingsystem => 'Ubuntu',
    :architecture => 'x86_64',
    :kernel => 'Linux'
  } }
  
  it { is_expected.to compile }
  it { is_expected.to compile.with_all_deps }
  # it { is_expected.to contain_file("/etc/fstab")
  #   .with( :content => /.*fs-5e1bed97.efs.eu-west-1.amazonaws.com.*/m )
  # }

end
