repoproxy
=========

Script to proxy git and svn protocols via http proxy

Use socat to proxy common SCM protocols through HTTP CONNECT firewall.
Useful if you are trying to use svn or git where a http version of the repo
is not available for use. For svn, while it supports setting a http proxy in
the config file, I've not found it particularly reliable.

Save this file as repoproxy somewhere in your path (e.g., ~/bin), make it executable,
and then create the symlinks either gitproxy or svnproxy in the same location and
following the instructions appropriate to them.

("clone" form http://www.darraghbailey.com/wordpress/?p=23 )
