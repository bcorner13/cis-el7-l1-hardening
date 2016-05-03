#
# Cookbook Name:: cis-el7-l1-hardening
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Recipe includes
include_recipe 'cis-el7-l1-hardening::ssh'
include_recipe 'cis-el7-l1-hardening::avahi'
include_recipe 'cis-el7-l1-hardening::cron'
include_recipe 'cis-el7-l1-hardening::at_daemon'
include_recipe 'cis-el7-l1-hardening::user-mgmt'
include_recipe 'cis-el7-l1-hardening::network-packet-remediation'
include_recipe 'cis-el7-l1-hardening::login_banners'

# Fix for "xccdf_org.cisecurity.benchmarks_rule_4.7_Enable_firewalld"
package 'firewalld'

service 'firewalld' do
  supports :status => true
  action [ :enable, :start ]
end
# End fix for "xccdf_org.cisecurity.benchmarks_rule_4.7_Enable_firewalld"

# Start fix for xccdf_org.cisecurity.benchmarks_rule_1.5.2_Set_Permissions_on_bootgrub2grub.cfg
file '/boot/grub2/grub.cfg' do
  mode '0600'
  owner 'root'
  group 'root'
end
# End fix for xccdf_org.cisecurity.benchmarks_rule_1.5.2_Set_Permissions_on_bootgrub2grub.cfg

# Start fix for xccdf_org.cisecurity.benchmarks_rule_3.1_Set_Daemon_umask
replace_or_add "Set Daemon umask" do
  path "/etc/sysconfig/init"
  pattern "umask 027"
  line "umask 027"
end
# End fix for xccdf_org.cisecurity.benchmarks_rule_3.1_Set_Daemon_umask
