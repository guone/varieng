#!/bin/sh

# Assumtion:
# ../dhh15 = input data from https://bitbucket.org/suomela/dhh15

mkdir -p plot || exit 1
in-time/in-time plot/scotl-engl.pdf '\<scotl' '\<engl' || exit 1
