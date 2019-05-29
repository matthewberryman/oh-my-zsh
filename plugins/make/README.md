# make plugin

This plugin sets the MAKEFLAGS variable to include the -j(num_threads) option for parallel
builds by default, setting numthreads = number of logical CPUs on macOS and Linux

To use it, add `make` to the plugins array in your zshrc file:

```zsh
plugins=(... make)
```