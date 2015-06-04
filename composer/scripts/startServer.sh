#!/bin/sh
gfsh start server --name=$HOSTNAME --locators=locator[10334]

while true; do
    sleep 10
  done
done
