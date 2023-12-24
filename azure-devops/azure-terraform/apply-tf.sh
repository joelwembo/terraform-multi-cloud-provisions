#!/bin/bash
set -xe

. ./common-tf.sh

terraform apply -auto-approve tfplan.tmp
