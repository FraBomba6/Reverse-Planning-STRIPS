#!/bin/sh

# File to execute DLV from RevDomain.java
$1 -silent -FP$3 -planlength=$2 $4 $5 > $6
# $1 -FP$3 -planlength=$2 $4 $5 > $6
