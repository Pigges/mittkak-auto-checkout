# MittKäk! auto checkout

A simple script to automatically checkout food in the MittKäk! app.

This script is made to run on Linux, it might work on ohter platforms, but not tested.

## Prerequisites
* Node.js

## Run direclty
```sh
sh checkout-food.sh
```

## Auto checkout
An easy way to do this would be to add it to crontab.
An example line could be:
```
0 7 * * 1-5 /usr/bin/sh /opt/checkout-food/checkout-food.sh
```
This would run on Monday through Friday at 7am.
