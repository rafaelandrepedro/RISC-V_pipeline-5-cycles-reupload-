#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue May 31 11:36:04 WEST 2022
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 73a7a3c9cbda44de9ae17cc0547b9bdc --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L secureip --snapshot testbench_func_impl xil_defaultlib.testbench xil_defaultlib.glbl -log elaborate.log"
xelab -wto 73a7a3c9cbda44de9ae17cc0547b9bdc --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L secureip --snapshot testbench_func_impl xil_defaultlib.testbench xil_defaultlib.glbl -log elaborate.log

