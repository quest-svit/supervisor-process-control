#!/bin/bash

if [ $# -ne 1 ]; then 
    echo "Usage : "
    echo "source init_script.sh <OPTIONS>"
    echo "<OPTIONS> init, start , clean"
    echo "e.g. source init_script.sh init"
    exit -1
fi

if [ $1 == "init" ]; then
    if [ ! -d "pyvenv" ]; then

	    echo "Virtual Environment not found. Creating .."
	    #virtualenv pyvenv           # Python2.7
	    python3 -m venv pyvenv     # Python3.6
	    source pyvenv/bin/activate

        if [ -n $VIRTUAL_ENV ]; then
	        echo "Virtual Env Activated"
	        pip install -r requirements.txt
	    fi

    fi
fi

if [ $1 == "start" ]; then

    source pyvenv/bin/activate

    if [ -n $VIRTUAL_ENV ]; then
        echo "Virtual Env Activated"
        url=`grep 'port=' supervisord.conf | cut -f1 -d" " | cut -f2 -d"="`
        echo "Starting Supervisor D."
        echo "Open Browser and go to.." http://$url
        supervisord -n -c supervisord.conf
    fi
fi


if [ $1 == "clean" ]; then
    rm -rf pyvenv
fi

