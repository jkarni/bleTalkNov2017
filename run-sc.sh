#!/bin/bash

set -o errexit
set -o nounset

export SC_JACK_DEFAULT_INPUTS="system"
export SC_JACK_DEFAULT_OUTPUTS="system"
scsynth -u 57110
