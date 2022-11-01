#!/bin/bash
gateway="192.168.100.12"
interface="eth0"

ip route delete default
ip route add default via $gateway dev $interface
