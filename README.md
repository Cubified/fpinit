## fpinit: Fast parallel init

`fpinit` is a modified version of [sinit](https://core.suckless.org/sinit) which makes use of [script](https://github.com/Cubified/script) to execute init scripts in parallel.

In its current state, `fpinit` is usable as a system's full-time init, but it (somewhat by design) lacks process supervision, meaning it does nothing other than boot and halt the system.

### Demo

`fpinit` booting Alpine Linux in a QEMU VM:

![demo.gif](https://github.com/Cubified/fpinit/blob/master/demo.gif)

### Compiling and Running

`fpinit` contains `script` as a module, meaning:

     $ git submodule update --init --recursive --remote

Will clone the latest version of `script` (`--init` is only necessary for first clone).  `fpinit` can be compiled with:

     $ make

And installed with (this will **not** overwrite any important init scripts or files -- everything is entirely self-contained within `/usr/local`):

     # make install

To use `fpinit` as the system init, the kernel parameter:

     init=/usr/local/bin/fpinit

Must be added to the kernel's configuration, likely through bootloader (i.e. GRUB/LILO/Syslinux) or EFI boot entry configuration.

### Included Scripts

The scripts available in `fpinit.d/` and `fphalt.d/` are a stripped-down and modified subset of [Void's runit scripts](https://github.com/void-linux/void-runit), [stali's sinit scripts](http://r-36.net/scm/stali-init/files.html), and [Alpine's openrc scripts](https://git.alpinelinux.org/aports/tree/main/busybox-initscripts), doing slightly more than the absolute minimum necessary for a usable system.  Right now, they are intended to work on Alpine, however all Alpine/busybox-specific behavior is configurable and removable, some of which automatically (such as `getty` vs. `agetty` -- `mdev` vs. `(e)udev` is not, as there exist tangible differences between the two).

### Adding New Scripts

Because `script` is configuration-free by design, any executable file can be placed into `/usr/local/share/fpinit.d/` or `/usr/local/share/fphalt.d/`.  As `fpinit` lacks process supervision, there is currently no built-in way to create services or recurrent tasks, however POSIX `setsid` and bash's `disown` can achieve similar behavior (see [4-tty.sh](https://github.com/Cubified/fpinit/blob/master/fpinit.d/4-tty.sh)) 

### To-Do

- Fix system occasionally hanging on final script in each runlevel on single core systems (e.g. qemu by default -- threading issue, may not be easily resolved without adding more cores to VM)
- Fix `fphalt.d/0-processes.sh` hanging the system on shutdown
