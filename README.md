# Tplink Cli

[![Gem Version](https://badge.fury.io/rb/tplink-admin.svg)](https://badge.fury.io/rb/tplink-admin)

Ruby cli tool for tplink dsl modem.

Total alpha + WIP - tested on: 0.6.0 2.10 TD-W8970B

Most useful for traffic statistics for individual hosts.

```
gem install tplink-admin
```


## Commands

Create config file and open in $EDITOR

```
tplink-admin config
```

Show DSL connection infos

```
tplink-admin status
```


Show traffic consumption of all connected hosts (traffic control need to be activated in Router menu (statistics))

```
tplink-admin traffic
```

Resolve hostnames of connected mac-addresses (saves to config file, so traffic command will display that hostnames for the next commands)

```
tplink-admin hosts
```

All commands use & modify ``~/.tplinkcli``. change the url / password of your router.
You can also add ``:name: "..."`` attributes to hosts, if you want to overwrite the ``host_name`` in traffic view
