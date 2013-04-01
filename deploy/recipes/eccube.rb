#
# Cookbook Name:: deploy
# Recipe:: eccube
#

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an PHP app")
    next
  end

  script "chmod_applicaton" do
    Chef::Log.info("tottokug-Log permission change ")
    interpreter "bash"
    cwd deploy[:deploy_to]
    user "root"
    code <<-EOH
    chmod -R 775 current/html current/data
    chown -R deploy:apache current/html current/data
    EOH
  end

end

