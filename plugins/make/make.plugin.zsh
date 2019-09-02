
# These next two count functions from https://stackoverflow.com/a/23378780

# Number of LOGICAL CPUs (includes those reported by hyper-threading cores)
  # Linux: Simply count the number of (non-comment) output lines from `lscpu -p`, 
  # which tells us the number of *logical* CPUs.
logicalCpuCount=$([ $(uname) = 'Darwin' ] && 
                       sysctl -n hw.logicalcpu_max || 
                       lscpu -p | egrep -v '^#' | wc -l)

# Number of PHYSICAL CPUs (cores).
  # Linux: The 2nd column contains the core ID, with each core ID having 1 or
  #        - in the case of hyperthreading - more logical CPUs.
  #        Counting the *unique* cores across lines tells us the
  #        number of *physical* CPUs (cores).
physicalCpuCount=$([ $(uname) = 'Darwin' ] && 
                       sysctl -n hw.physicalcpu_max ||
                       lscpu -p | egrep -v '^#' | sort -u -t, -k 2,4 | wc -l)

if [[ $MAKEFLAGS != "\-j\d" ]]
then
    export MAKEFLAGS=$MAKEFLAGS' -j'$physicalCpuCount 
fi
