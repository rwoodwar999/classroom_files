## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.
# exercise 7.1
node 'rwoodwar999.puppetlabs.vm' {
  include system_users::admins
  #exercise 8.1
  include hosts::init
  #exercise 8.2
  #include nginx
  #exercise 12.1
  #class nginx::vhost{ 'punch.puppetlabs.com':}
  #exercise 13.1
  class { 'nginx':
    root => 'root',
  }
}
node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  include role::classroom
}
