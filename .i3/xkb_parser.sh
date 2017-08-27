#!/bin/bash

pattern="$(xset -q | grep LED | awk '{ print $10 }')"
  
case "${pattern}" in
  "00000000") KBD="En" ;;
  "00001000") KBD="Ru" ;;
esac

echo "$KBD"
