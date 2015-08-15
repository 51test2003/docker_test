#!/bin/bash

$INIT=/webdata/ReChat/setup.sh

if [ -f "$INIT" ]; then
sh $INIT
fi
