#!/bin/bash
Python=$(which python3)

if [ ! -x "${Python}" ];then
echo "需要python3环境"
else
python3 hello-weather.py
fi
