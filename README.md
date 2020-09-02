## fpinit: Fast parallel init

`fpinit` is a modified version of [sinit](https://core.suckless.org/sinit) which makes use of [script](https://github.com/Cubified/script) to execute init scripts in parallel.

In its current state, `fpinit` is usable as a system's full-time init, but it (somewhat by design) lacks process supervision, meaning it does nothing other than boot and halt the system.

### Compiling and Running

`fpinit` contains `script` as a module, meaning:

     $ git submodule update --recursive --remote

Will clone the latest version of `script`.  `fpinit` can be compiled with:

     $ make

And installed with (this will **not** overwrite any important init scripts or files -- everything is entirely self-contained within `/usr/local`):

     # make install

To use `fpinit` as the system init, the kernel parameter:

     init=/usr/local/bin/fpinit

Must be added to the kernel's configuration, likely through bootloader (i.e. GRUB/LILO/Syslinux) or EFI boot entry configuration.

### Adding New Scripts

Because `script` is configuration-free by design, any executable file can be placed into `/usr/local/share/fpinit.d/` or `/usr/local/share/fphalt.d/`.  As `fpinit` lacks process supervision, there is currently no built-in to create services or recurrent tasks, however POSIX `setsid` and bash's `disown`can achieve similar behavior (see [4-tty.sh](https://github.com/Cubified/script/blob/master/init.d/4-tty.sh)) 
