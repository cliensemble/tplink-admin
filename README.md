# Tplink Admin

[![Gem Version](https://badge.fury.io/rb/tplink-admin.svg)](https://badge.fury.io/rb/tplink-admin)

Ruby cli tool for tplink dsl router administration.
Based on [zealot128's tplink-cli](https://github.com/zealot128/tplink-cli) project, but more focused on simple management of TpLink routers.

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

Reboot your router

```
tplink-admin reboot
```

All commands use or modify ``~/.tplinkadmin``. change the url / password of your router.

## Other commands in progress
