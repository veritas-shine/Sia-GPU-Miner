cmake_minimum_required(VERSION 3.8)
project(PQC-Miner)

set(CMAKE_CXX_STANDARD 11)
include(CMakeHelper.cmake)

CheckLibrary()
add_executable(PQC-Miner network.c network.h sia-gpu-miner.c)
LinTargetLibrary(PQC-Miner)