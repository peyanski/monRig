#!/bin/sh
if ! ping -q -c 1 -W 10 google.com > /dev/null; then
    (ifup wan) &
fi
