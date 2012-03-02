#!/bin/bash

DATA_DIR=~/targets/f16
VM_NAME='F16_nightly_run'
REPO='git://abrt.brq.redhat.com/abrt.git'
OS_VARIANT='fedora16'
KS_NAME_PREFIX='fedora_16'
LOC='http://download.fedoraproject.org/pub/fedora/linux/releases/16/Fedora/x86_64/os/'
DISK=$( echo /dev/mapper/*f16_vm )

