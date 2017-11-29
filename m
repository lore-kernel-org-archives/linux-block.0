Return-Path: <borntraeger@de.ibm.com>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <08e6f35a-4f49-973e-99f7-6087b44337c4@kernel.dk>
 <20171122072857.GA19338@lst.de>
 <a1d51b13-c034-e0c8-9428-e360b2c898c3@kernel.dk>
 <20171123143453.GA29715@lst.de>
 <cdca47a9-05cc-2676-57fe-904ce8ad5fbc@de.ibm.com>
 <20171123182542.GA2680@lst.de>
 <899f1638-cca4-28e6-3225-51505a053d45@de.ibm.com>
 <20171123183232.GA2845@lst.de>
 <92ef1aae-90b5-f14f-390e-bfab97899431@de.ibm.com>
 <419d8565-9cbe-16ac-3d5d-5945098694bc@de.ibm.com>
 <20171127155409.GA6937@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 29 Nov 2017 20:18:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171127155409.GA6937@lst.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <d0f39408-b697-8d1a-2cce-b833cb8fa118@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Works fine under KVM with virtio-blk, but still hangs during boot in an LPAR.
FWIW, the system not only has scsi disks via fcp but also DASDs as a boot disk.
Seems that this is the place where the system stops. (see the sysrq-t output
at the bottom).


Message
"[    0.247484] Linux version 4.15.0-rc1+ (cborntra@s38lp08) (gcc version 6.3.1 2
"
"0161221 (Red Hat 6.3.1-1.0.ibm) (GCC)) #229 SMP Wed Nov 29 20:05:35 CET 2017
"
"[    0.247489] setup: Linux is running natively in 64-bit mode
"
"[    0.247661] setup: The maximum memory size is 1048576MB
"
"[    0.247670] setup: Reserving 1024MB of memory at 1047552MB for crashkernel (S
"
"ystem RAM: 1047552MB)
"
"[    0.247688] numa: NUMA mode: plain
"
"[    0.247794] cpu: 64 configured CPUs, 0 standby CPUs
"
"[    0.247834] cpu: The CPU configuration topology of the machine is: 0 0 4 2 3 
"
"8 / 4
"
"[    0.248279] Write protected kernel read-only data: 12456k
"
"[    0.265131] Zone ranges:
"
"[    0.265134]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
"
"[    0.265136]   Normal   [mem 0x0000000080000000-0x000000ffffffffff]
"
"[    0.265137] Movable zone start for each node
"
"[    0.265138] Early memory node ranges
"
"[    0.265139]   node   0: [mem 0x0000000000000000-0x000000ffffffffff]
"
"[    0.265141] Initmem setup node 0 [mem 0x0000000000000000-0x000000ffffffffff]
"
"[    7.445561] random: fast init done
"
"[    7.449194] percpu: Embedded 23 pages/cpu @000000fbbe600000 s56064 r8192 d299
"
"52 u94208
"
"[    7.449380] Built 1 zonelists, mobility grouping on.  Total pages: 264241152
"
"[    7.449381] Policy zone: Normal
"
"[    7.449384] Kernel command line: elevator=deadline audit_enable=0 audit=0 aud
"
"it_debug=0 selinux=0 crashkernel=1024M printk.time=1 zfcp.dbfsize=100 dasd=241c,
"
"241d,241e,241f root=/dev/dasda1 kvm.nested=1  BOOT_IMAGE=0
"
"[    7.449420] audit: disabled (until reboot)
"
"[    7.450513] log_buf_len individual max cpu contribution: 4096 bytes
"
"[    7.450514] log_buf_len total cpu_extra contributions: 1044480 bytes
"
"[    7.450515] log_buf_len min size: 131072 bytes
"
"[    7.450788] log_buf_len: 2097152 bytes
"
"[    7.450789] early log buf free: 125076(95%)
"
"[   11.040620] Memory: 1055873868K/1073741824K available (8248K kernel code, 107
"
"8K rwdata, 4204K rodata, 812K init, 700K bss, 17867956K reserved, 0K cma-reserve
"
"d)
"
"[   11.040938] SLUB: HWalign=256, Order=0-3, MinObjects=0, CPUs=256, Nodes=1
"
"[   11.040969] ftrace: allocating 26506 entries in 104 pages
"
"[   11.051476] Hierarchical RCU implementation.
"
"[   11.051476]  RCU event tracing is enabled.
"
"[   11.051478]  RCU debug extended QS entry/exit.
"
"[   11.053263] NR_IRQS: 3, nr_irqs: 3, preallocated irqs: 3
"
"[   11.053444] clocksource: tod: mask: 0xffffffffffffffff max_cycles: 0x3b0a9be8
"
"03b0a9, max_idle_ns: 1805497147909793 ns
"
"[   11.160192] console [ttyS0] enabled
"
"[   11.308228] pid_max: default: 262144 minimum: 2048
"
"[   11.308298] Security Framework initialized
"
"[   11.308300] SELinux:  Disabled at boot.
"
"[   11.354028] Dentry cache hash table entries: 33554432 (order: 16, 268435456 b
"
"ytes)
"
"[   11.376945] Inode-cache hash table entries: 16777216 (order: 15, 134217728 by
"
"tes)
"
"[   11.377685] Mount-cache hash table entries: 524288 (order: 10, 4194304 bytes)
"

"[   11.378401] Mountpoint-cache hash table entries: 524288 (order: 10, 4194304 b
"
"ytes)
"
"[   11.378984] Hierarchical SRCU implementation.
"
"[   11.380032] smp: Bringing up secondary CPUs ...
"
"[   11.393634] smp: Brought up 1 node, 64 CPUs
"
"[   11.585458] devtmpfs: initialized
"
"[   11.588589] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, ma
"
"x_idle_ns: 19112604462750000 ns
"
"[   11.588998] futex hash table entries: 65536 (order: 12, 16777216 bytes)
"
"[   11.591926] NET: Registered protocol family 16
"
"[   11.596413] HugeTLB registered 1.00 MiB page size, pre-allocated 0 pages
"
"[   11.597604] SCSI subsystem initialized
"
"[   11.597611] pps_core: LinuxPPS API ver. 1 registered
"
"[   11.597612] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giome
"
"tti <giometti@linux.it>
"
"[   11.597614] PTP clock support registered
"
"[   11.599088] NetLabel: Initializing
"
"[   11.599089] NetLabel:  domain hash size = 128
"
"[   11.599090] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
"
"[   11.599101] NetLabel:  unlabeled traffic allowed by default
"
"[   11.612542] PCI host bridge to bus 0000:00
"
"[   11.612546] pci_bus 0000:00: root bus resource [mem 0x8000000000000000-0x8000
"
"0000007fffff 64bit pref]
"
"[   11.612548] pci_bus 0000:00: No busn resource found for root bus, will use [b
"
"us 00-ff]
"
"[   11.616458] iommu: Adding device 0000:00:00.0 to group 0
"
"[   12.291894] VFS: Disk quotas dquot_6.6.0
"
"[   12.291942] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
"
"[   12.292226] NET: Registered protocol family 2
"
"[   12.292662] TCP established hash table entries: 524288 (order: 10, 4194304 by
"
"tes)
"
"[   12.294559] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
"
"[   12.295008] TCP: Hash tables configured (established 524288 bind 65536)
"
"[   12.295229] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
"
"[   12.296173] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
"
"[   12.297343] NET: Registered protocol family 1
"
"[   12.301053] workingset: timestamp_bits=42 max_order=28 bucket_order=0
"
"[   12.304670] NET: Registered protocol family 38
"
"[   12.304694] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 2
"
"50)
"
"[   12.304939] io scheduler noop registered
"
"[   12.304940] io scheduler deadline registered (default)
"
"[   12.304975] io scheduler cfq registered
"
"[   12.304977] io scheduler mq-deadline registered (default)
"
"[   12.304977] io scheduler kyber registered
"
"[   12.305949] atomic64_test: passed
"
"[   12.305985] hvc_iucv: The z/VM IUCV HVC device driver cannot be used without 
"
"z/VM
"
"[   12.317868] loop: module loaded
"
"[   12.318153] tun: Universal TUN/TAP device driver, 1.6
"
"[   12.318240] mlx4_core: Mellanox ConnectX core driver v4.0-0
"
"[   12.318251] mlx4_core: Initializing 0000:00:00.0
"
"[   12.318324] mlx4_core 0000:00:00.0: enabling device (0000 -> 0002)
"
"[   12.319389] mlx4_core 0000:00:00.0: Detected virtual function - running in sl
"
"ave mode
"
"[   12.319448] mlx4_core 0000:00:00.0: Sending reset
"
"[   12.320791] mlx4_core 0000:00:00.0: Sending vhcr0
"
"[   12.326014] mlx4_core 0000:00:00.0: Requested number of MACs is too much for 
"
"port 1, reducing to 64
"
"[   12.326016] mlx4_core 0000:00:00.0: Requested number of VLANs is too much for
"
" port 1, reducing to 1
"
"[   12.326240] mlx4_core 0000:00:00.0: HCA minimum page size:512
"
"[   12.327666] mlx4_core 0000:00:00.0: Timestamping is not supported in slave mo
"
"de
"
"[   12.537132] mlx4_en: Mellanox ConnectX HCA Ethernet driver v4.0-0
"
"[   12.537646] mlx4_en 0000:00:00.0: Activating port:1
"
"[   12.578197] mlx4_en: 0000:00:00.0: Port 1: Using 32 TX rings
"
"[   12.578201] mlx4_en: 0000:00:00.0: Port 1: Using 8 RX rings
"
"[   12.578676] mlx4_en: 0000:00:00.0: Port 1: Initializing port
"
"[   12.579202] mlx4_en 0000:00:00.0: Activating port:2
"
"[   12.613180] mlx4_en: 0000:00:00.0: Port 2: Using 32 TX rings
"
"[   12.613182] mlx4_en: 0000:00:00.0: Port 2: Using 8 RX rings
"
"[   12.613592] mlx4_en: 0000:00:00.0: Port 2: Initializing port
"
"[   12.614141] VFIO - User Level meta-driver version: 0.3
"
"[   12.614231] mousedev: PS/2 mouse device common for all mice
"
"[   12.614247] IR NEC protocol handler initialized
"
"[   12.614248] IR RC5(x/sz) protocol handler initialized
"
"[   12.614249] IR RC6 protocol handler initialized
"
"[   12.614250] IR JVC protocol handler initialized
"
"[   12.614251] IR Sony protocol handler initialized
"
"[   12.614252] IR SANYO protocol handler initialized
"
"[   12.614253] IR Sharp protocol handler initialized
"
"[   12.614254] IR MCE Keyboard/mouse protocol handler initialized
"
"[   12.614255] IR XMP protocol handler initialized
"
"[   12.614318] device-mapper: uevent: version 1.0.3
"
"[   12.614376] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-d
"
"evel@redhat.com
"
"[   12.614856] cio: Channel measurement facility initialized using format extend
"
"ed (mode autodetected)
"
"[   12.615194] Discipline DIAG cannot be used without z/VM
"
"[   12.619692] dasd-eckd 0.0.241c: A channel path to the device has become opera
"
"tional
"
"[   12.619847] dasd-eckd 0.0.241e: A channel path to the device has become opera
"
"tional
"
"[   12.619992] dasd-eckd 0.0.241d: A channel path to the device has become opera
"
"tional
"
"[   12.620344] dasd-eckd 0.0.241f: A channel path to the device has become opera
"
"tional
"
"[   12.621880] dasd-eckd 0.0.241e: New DASD 3390/0C (CU 3990/01) with 30051 cyli
"
"nders, 15 heads, 224 sectors
"
"[   12.622097] dasd-eckd 0.0.241d: New DASD 3390/0C (CU 3990/01) with 30051 cyli
"
"nders, 15 heads, 224 sectors
"
"[   12.622286] dasd-eckd 0.0.241f: New DASD 3390/0C (CU 3990/01) with 30051 cyli
"
"nders, 15 heads, 224 sectors
"
"[   12.622519] dasd-eckd 0.0.241c: New DASD 3390/0C (CU 3990/01) with 30051 cyli
"
"nders, 15 heads, 224 sectors
"
"[   12.637350] dasd-eckd 0.0.241c: DASD with 4 KB/block, 21636720 KB total size,
"
" 48 KB/track, compatible disk layout
"
"[   12.642780] dasd-eckd 0.0.241d: DASD with 4 KB/block, 21636720 KB total size,
"
" 48 KB/track, compatible disk layout
"
"[   12.644616]  dasdb:VOL1/  0X241D: dasdb1
"
"[   12.644943] dasd-eckd 0.0.241e: DASD with 4 KB/block, 21636720 KB total size,
"
" 48 KB/track, compatible disk layout
"
"[   12.645439] dasd-eckd 0.0.241f: DASD with 4 KB/block, 21636720 KB total size,
"
" 48 KB/track, compatible disk layout
"
"[   12.647222]  dasda:VOL1/  0X241C: dasda1
"
"[   12.651236]  dasdc:VOL1/  0X241E: dasdc1
"
"[   12.651704]  dasdd:VOL1/  0X241F: dasdd1
"
"[   13.171832] drop_monitor: Initializing network drop monitor service
"
"[   13.172016] Initializing XFRM netlink socket
"
"[   13.172105] NET: Registered protocol family 10
"
"[   13.172902] Segment Routing with IPv6
"
"[   13.172915] mip6: Mobile IPv6
"
"[   13.172916] NET: Registered protocol family 17
"
"[   13.172923] Key type dns_resolver registered
"
"[   13.173033] registered taskstats version 1
"
"[   13.173394] Key type encrypted registered
"
"[   13.173665] md: Waiting for all devices to be available before autodetect
"
"[   13.173667] md: If you don't use raid, use raid=noautodetect
"
"[   13.173894] md: Autodetecting RAID arrays.
"
"[   13.173896] md: autorun ...
"
"[   13.173896] md: ... autorun DONE.
"
"[   13.174405] EXT4-fs (dasda1): couldn't mount as ext3 due to feature incompati
"
"bilities
"
"[   13.174647] EXT4-fs (dasda1): couldn't mount as ext2 due to feature incompati
"
"bilities
"
"[   13.199229] EXT4-fs (dasda1): mounted filesystem with ordered data mode. Opts
"
": (null)
"
"[   13.199233] VFS: Mounted root (ext4 filesystem) readonly on device 94:1.
"
"[   16.773545] random: crng init done
"
"[  112.413804] sysrq: SysRq : Show State
"
"[  112.413809]   task                        PC stack   pid father
"
"[  112.413811] swapper/0       D    0     1      0 0x00000000
"
"[  112.413814] Call Trace:
"
"[  112.413820] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.413821]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.413824]  [<000000000019e8c4>] io_schedule+0x34/0x58 
"
"[  112.413826]  [<00000000009064f6>] bit_wait_io+0x2e/0x90 
"
"[  112.413827]  [<0000000000905fe8>] __wait_on_bit+0xb8/0x110 
"
"[  112.413828]  [<00000000009060de>] out_of_line_wait_on_bit+0x9e/0xb0 
"
"[  112.413833]  [<000000000041e5ba>] __ext4_get_inode_loc+0x52a/0x570 
"
"[  112.413836]  [<0000000000422664>] ext4_iget+0x7c/0xc28 
"
"[  112.413839]  [<000000000043cf5a>] ext4_lookup+0x12a/0x238 
"
"[  112.413843]  [<00000000003620b6>] lookup_slow+0xae/0x198 
"
"[  112.413844]  [<00000000003657a0>] walk_component+0x210/0x358 
"
"[  112.413845]  [<000000000036629a>] path_lookupat+0xe2/0x278 
"
"[  112.413847]  [<0000000000368174>] filename_lookup+0x9c/0x160 
"
"[  112.413848]  [<000000000036835c>] user_path_at_empty+0x5c/0x70 
"
"[  112.413851]  [<0000000000380b94>] do_mount+0x74/0xd10 
"
"[  112.413853]  [<0000000000381c1c>] SyS_mount+0xa4/0x108 
"
"[  112.413857]  [<00000000005c02f8>] devtmpfs_mount+0x60/0xc0 
"
"[  112.413860]  [<0000000000e395c6>] prepare_namespace+0x18e/0x1c0 
"
"[  112.413861]  [<0000000000e38e46>] kernel_init_freeable+0x26e/0x288 
"
"[  112.413865]  [<0000000000900572>] kernel_init+0x2a/0x150 
"
"[  112.413868]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.413869]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.413870] kthreadd        S    0     2      0 0x00000000
"
"[  112.418205]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418206]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418207]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418208] kworker/51:1    I    0   441      2 0x00000000
"
"[  112.418210] Call Trace:
"
"[  112.418211] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418213]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418214]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418215]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418217]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418218]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418219] kworker/53:1    I    0   442      2 0x00000000
"
"[  112.418221] Call Trace:
"
"[  112.418222] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418223]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418225]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418226]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418227]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418229]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418230] kworker/52:1    I    0   443      2 0x00000000
"
"[  112.418231] Call Trace:
"
"[  112.418233] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418234]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418235]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418237]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418238]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418239]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418240] kworker/54:1    I    0   444      2 0x00000000
"
"[  112.418242] Call Trace:
"
"[  112.418243] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418244]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418246]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418247]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418249]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418250]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418251] kworker/55:1    I    0   445      2 0x00000000
"
"[  112.418253] Call Trace:
"
"[  112.418254] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418255]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418256]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418258]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418259]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418260]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418262] kworker/57:1    I    0   446      2 0x00000000
"
"[  112.418263] Call Trace:
"
"[  112.418265] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418266]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418267]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418268]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418270]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418271]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418272] kworker/56:1    I    0   447      2 0x00000000
"
"[  112.418274] Call Trace:
"
"[  112.418275] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418276]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418278]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418279]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418280]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418282]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418283] kworker/59:1    I    0   448      2 0x00000000
"
"[  112.418284] Call Trace:
"
"[  112.418286] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418287]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418288]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418290]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418291]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418292]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418293] kworker/58:1    I    0   449      2 0x00000000
"
"[  112.418295] Call Trace:
"
"[  112.418296] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418297]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418299]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418300]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418301]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418303]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418304] kworker/61:1    I    0   450      2 0x00000000
"
"[  112.418305] Call Trace:
"
"[  112.418306] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418308]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418309]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418311]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418312]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418313]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418315] kworker/63:1    I    0   451      2 0x00000000
"
"[  112.418316] Call Trace:
"
"[  112.418318] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418319]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418320]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418322]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418323]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418324]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418325] kworker/0:1H    I    0   452      2 0x00000000
"
"[  112.418327] Call Trace:
"
"[  112.418328] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418329]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418330]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418332]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418333]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418335]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418336] jbd2/dasda1-8   S    0   453      2 0x00000000
"
"[  112.418337] Call Trace:
"
"[  112.418338] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418339]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418343]  [<00000000004725be>] kjournald2+0x386/0x3c8 
"
"[  112.418345]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418346]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418348]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418349] ext4-rsv-conver I    0   454      2 0x00000000
"
"[  112.418350] Call Trace:
"
"[  112.418352] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418353]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418354]  [<0000000000189008>] rescuer_thread+0x3f8/0x460 
"
"[  112.418356]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418357]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418358]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418360] kworker/62:1H   I    0   455      2 0x00000000
"
"[  112.418361] Call Trace:
"
"[  112.418362] ([<0000000000905458>] __schedule+0x398/0x850)
"
"[  112.418364]  [<000000000090595a>] schedule+0x4a/0xb8 
"
"[  112.418365]  [<00000000001882ec>] worker_thread+0xe4/0x4f8 
"
"[  112.418366]  [<000000000018ee66>] kthread+0x13e/0x160 
"
"[  112.418368]  [<000000000090a9c2>] kernel_thread_starter+0x6/0xc 
"
"[  112.418369]  [<000000000090a9bc>] kernel_thread_starter+0x0/0xc 
"
"[  112.418370] Showing busy workqueues and worker pools:
"
"[  112.418407] workqueue events: flags=0x0
"
"[  112.418426]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
"
"[  112.418429]     in-flight: 343:ctrlchar_handle_sysrq
"
"[  112.418837] workqueue kblockd: flags=0x18
"
"[  112.418855]   pwq 131: cpus=65 node=0 flags=0x4 nice=-20 active=1/256
"
"[  112.418858]     pending: blk_mq_run_work_fn
"
"[  112.419188] pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=0s workers=2 idle: 20
"


On 11/27/2017 04:54 PM, Christoph Hellwig wrote:
> Can you try this git branch:
> 
>     git://git.infradead.org/users/hch/block.git blk-mq-hotplug-fix
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug-fix
> 
