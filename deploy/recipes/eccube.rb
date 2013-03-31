#
# Cookbook Name:: deploy
# Recipe:: php
#

include_recipe "mod_php5_apache2"
include_recipe "mod_php5_apache2::php"

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an PHP app")
    next
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group] 
    Chef::Log.info("tottokug-Log deploy_to = #{deploy[:deploy_to]}  ")
    path deploy[:deploy_to]
    mode "0755"
  end

  opsworks_deploy do
    Chef::Log.info("tottokug-Log opsworks_deploy do ")
    deploy_data deploy
    app application
  end

  directory deploy[:deploy_to]+"/current/data" do

    Chef::Log.info("tottokug-Log parmission change #{deploy[:deploy_to]}/current/data")
    owner "deploy"
    group "apache"
    mode "0775"
    recursive true
  end

  directory deploy[:deploy_to]+"/current/html" do
    Chef::Log.info("tottokug-Log parmission change #{deploy[:deploy_to]}/current/html")
    owner "deploy"
    group "apache"
    mode "0775"
    recursive true
  end

end

