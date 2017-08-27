#!/bin/bash

fan_speed=$(sensors | awk '/fan1/ { print $2 }')
echo $fan_speed
