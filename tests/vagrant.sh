#!/bin/bash

BASE=/vagrant/tests

puppet apply ${BASE}/init.pp --modulepath=${BASE}/modules
