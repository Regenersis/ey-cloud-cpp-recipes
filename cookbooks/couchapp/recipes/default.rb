#
# Cookbook Name:: couchapp
# Recipe:: default
#
execute "Download distribute_setup.py" do
  cwd "/home/deploy"
  creates "/home/deploy/distribute_setup.py"
  command %Q{
        curl -O http://python-distribute.org/distribute_setup.py
      }
end

execute "Install distribute_setup.py" do
  cwd "/home/deploy"
  creates "/usr/lib/python2.5/site-packages/setuptools-0.6c11-py2.5.egg-info"
  command %Q{
        python distribute_setup.py
      }
end

execute "Install pip" do
  creates "/usr/bin/pip"
  command %Q{
        easy_install pip
      }
end

execute "Install couchapp" do
  creates "/usr/bin/couchapp"
  command %Q{
        pip install couchapp
      }
end

execute "Install simplejson" do
  creates "/usr/lib/python2.5/site-packages/simplejson/ __init__.py"
  command %Q{
        pip install simplejson
      }
end