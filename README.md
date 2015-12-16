# Tplink Admin

[![Gem Version](https://badge.fury.io/rb/tplink-admin.svg)](https://badge.fury.io/rb/tplink-admin)

Ruby cli tool for tplink dsl modem administration.
Based on [zealot128's tplink-cli](https://github.com/zealot128/tplink-cli) project, but more focused on simple management of TpLink modems.

This project is in alpha stage - tested on: TL-WR741N

## How to install

```
git clone https://github.com/muniz95/tplink-admin
cd tplink-admin && bundle install
gem build tplink-admin.gemspec && gem install tplink-admin-X.X.X.gem
```

This gem will be avaliable at rubygems soon.

## Commands

Create config file and open in $EDITOR

```
tplink-admin config
```

All commands use & modify ``~/.tplinkadmin``. change the url / password of your router.
You can also add ``:name: "..."`` attributes to hosts, if you want to overwrite the ``host_name`` in traffic view

## Other commands in progress