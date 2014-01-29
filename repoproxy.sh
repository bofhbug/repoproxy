#!/bin/bash
#
# Use socat to proxy common SCM protocols through HTTP CONNECT firewall.
# Useful if you are trying to use svn or git where a http version of the repo
# is not available for use. For svn, while it supports setting a http proxy in
# the config file, I've not found it particularly reliable.
#
#
# Save this file as repoproxy somewhere in your path (e.g., ~/bin), make it executable,
# and then create the symlinks either gitproxy or svnproxy in the same location and
# following the instructions appropriate to them.
#
#	( form Darragh's Blog, http://www.darraghbailey.com/wordpress/?p=23 )
#

# GIT
#
# gitproxy
#  git config --global core.gitproxy gitproxy
#
# More details and original at
# http://www.emilsit.net/blog/archives/how-to-use-the-git-protocol-through-a-http-connect-proxy/
#

# SVN
#
# svnproxy
#  edit ~/.subversion/config and add "socat = <path to script>" under the tunnels section
#
# then whenever using svn, simply change the line "svn://" to read "svn+socat://"
# and continue to use as normal
#

# Need proxy settings
[[ -z "${http_proxy}" ]] && \
    echo "Need http_proxy to be set somewhere in order for this script be able to use socat!" && \
    exit 2

_proxy=${http_proxy%:*}
_proxyport=
if [[ "${http_proxy#*:}" != "${_proxy}" ]]
then
    _proxyport=${http_proxy#*:}
fi

case ${0##*/} in
    "svnproxy")
        targetserver="${1#*@}"
        targetport="3690"
        ;;
    "gitproxy")
        targetserver=$1
        targetport=$2
        ;;
    *)
        echo "Unknown usage! ${0##*/} is not a recognised command"
        exit 1
        ;;
esac

echo "socat STDIO PROXY:${_proxy}:${targetserver}:${targetport}${_proxyport:+,proxyport=${_proxyport}}" >&2
exec socat STDIO PROXY:${_proxy}:${targetserver}:${targetport}${_proxyport:+,proxyport=${_proxyport}}
