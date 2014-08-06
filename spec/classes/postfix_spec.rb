#!/usr/bin/env rspec
require 'spec_helper'
require 'pry'

describe 'postfix', :type => :class do
  context 'input validation' do
    let (:facts){{
      'hostname' => 'mail',
      'domain' => 'example.com',
      'fqdn' => 'mail.example.com'
    }}

#    ['path'].each do |paths|
#      context "when the #{paths} parameter is not an absolute path" do
#        let (:params) {{ paths => 'foo' }}
#        it 'should fail' do
#          expect { subject }.to raise_error(Puppet::Error, /"foo" is not an absolute path/)
#        end
#      end
#    end#absolute path

    ['mynetworks','access','transport_maps','relay_domains','relay_recipients'].each do |arrays|
      context "when the #{arrays} parameter is not an array" do
        let (:params) {{ arrays => 'this is a string'}}
        it 'should fail' do
           expect { subject }.to raise_error(Puppet::Error, /is not an Array./)
        end
      end
    end#arrays

    ['listenipv6','ssl'].each do |bools|
      context "when the #{bools} parameter is not an boolean" do
        let (:params) {{bools => "BOGON"}}
        it 'should fail' do
          expect { subject }.to raise_error(Puppet::Error, /"BOGON" is not a boolean.  It looks to be a String/)
        end
      end
    end#bools

#    ['hash'].each do |hashes|
#      context "when the #{hashes} parameter is not an hash" do
#        let (:params) {{ hashes => 'this is a string'}}
#        it 'should fail' do
#           expect { subject }.to raise_error(Puppet::Error, /is not a Hash./)
#        end
#      end
#    end#hashes

    ['server_type','myhostname','mydomain','myorigin','mydestination','mynetworks_style','listen','message_size_limit','certhostname','root_destination','smtpd_timeout','smtpd_error_sleep_time'].each do |strings|
      context "when the #{strings} parameter is not a string" do
        let (:params) {{strings => false }}
        it 'should fail' do
          expect { subject }.to raise_error(Puppet::Error, /false is not a string./)
        end
      end
    end#strings

  end#input validation
  ['Debian','RedHat'].each do |osfam|
    context "When on an #{osfam} system" do
      let (:facts) {{'osfamily' => osfam}}
      context 'when fed no parameters' do
        it 'provide a generated catalog for testbuilding' do
          #binding.pry;
          p subject.resources
        end
      end#no params

    end
  end
end