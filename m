Return-Path: <fengguang.wu@intel.com>
Date: Wed, 22 Mar 2017 06:41:56 +0800
From: kernel test robot <fengguang.wu@intel.com>
To: Omar Sandoval <osandov@fb.com>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 wfg@linux.intel.com
Subject: [blk-stat] 34dbad5d26:  BUG: KASAN: null-ptr-deref on address
 0000000000000030
Message-ID: <58d1ac34.KV5wGsGJLqLm4XOd%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_58d1ac34.YiUk2W4GBPO6CI0Tg5ExbXdDfEWOzGZCntvH6UIU+7DOtKQf"
List-ID: <linux-block@vger.kernel.org>

This is a multi-part message in MIME format.

--=_58d1ac34.YiUk2W4GBPO6CI0Tg5ExbXdDfEWOzGZCntvH6UIU+7DOtKQf
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next

commit 34dbad5d26e2f4b88e60f0e9ad03f99480802812
Author:     Omar Sandoval <osandov@fb.com>
AuthorDate: Tue Mar 21 08:56:08 2017 -0700
Commit:     Jens Axboe <axboe@fb.com>
CommitDate: Tue Mar 21 10:03:11 2017 -0600

    blk-stat: convert to callback-based statistics reporting
    
    Currently, statistics are gathered in ~0.13s windows, and users grab the
    statistics whenever they need them. This is not ideal for both in-tree
    users:
    
    1. Writeback throttling wants its own dynamically sized window of
       statistics. Since the blk-stats statistics are reset after every
       window and the wbt windows don't line up with the blk-stats windows,
       wbt doesn't see every I/O.
    2. Polling currently grabs the statistics on every I/O. Again, depending
       on how the window lines up, we may miss some I/Os. It's also
       unnecessary overhead to get the statistics on every I/O; the hybrid
       polling heuristic would be just as happy with the statistics from the
       previous full window.
    
    This reworks the blk-stats infrastructure to be callback-based: users
    register a callback that they want called at a given time with all of
    the statistics from the window during which the callback was active.
    Users can dynamically bucketize the statistics. wbt and polling both
    currently use read vs. write, but polling can be extended to further
    subdivide based on request size.
    
    The callbacks are kept on an RCU list, and each callback has percpu
    stats buffers. There will only be a few users, so the overhead on the
    I/O completion side is low. The stats flushing is also simplified
    considerably: since the timer function is responsible for clearing the
    statistics, we don't have to worry about stale statistics.
    
    wbt is a trivial conversion. After the conversion, the windowing problem
    mentioned above is fixed.
    
    For polling, we register an extra callback that caches the previous
    window's statistics in the struct request_queue for the hybrid polling
    heuristic to use.
    
    Since we no longer have a single stats buffer for the request queue,
    this also removes the sysfs and debugfs stats entries. To replace those,
    we add a debugfs entry for the poll statistics.
    
    Signed-off-by: Omar Sandoval <osandov@fb.com>
    Signed-off-by: Jens Axboe <axboe@fb.com>

4875253fdd  blk-stat: move BLK_RQ_STAT_BATCH definition to blk-stat.c
34dbad5d26  blk-stat: convert to callback-based statistics reporting
34dbad5d26  blk-stat: convert to callback-based statistics reporting
+------------------------------------------+------------+------------+------------+
|                                          | 4875253fdd | 34dbad5d26 | 34dbad5d26 |
+------------------------------------------+------------+------------+------------+
| boot_successes                           | 33         | 0          | 0          |
| boot_failures                            | 0          | 48         | 48         |
| BUG:KASAN:null-ptr-deref_on_address      | 0          | 48         | 48         |
| BUG:unable_to_handle_kernel              | 0          | 48         | 48         |
| Oops:#[##]                               | 0          | 48         | 48         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 48         | 48         |
+------------------------------------------+------------+------------+------------+

[    4.462836] kworker/u2:1 (129) used greatest stack depth: 29112 bytes left
[    4.465516] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    4.465516] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    4.805175] ==================================================================
[    4.805175] ==================================================================
[    4.807817] BUG: KASAN: null-ptr-deref on address 0000000000000030
[    4.807817] BUG: KASAN: null-ptr-deref on address 0000000000000030
[    4.810134] Read of size 8 by task swapper/0/1
[    4.810134] Read of size 8 by task swapper/0/1
[    4.811257] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc3-00005-g34dbad5 #1
[    4.811257] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc3-00005-g34dbad5 #1
[    4.813351] Call Trace:
[    4.813351] Call Trace:
[    4.814224]  dump_stack+0x7e/0xa6
[    4.814224]  dump_stack+0x7e/0xa6
[    4.815203]  kasan_report+0x11c/0x46c
[    4.815203]  kasan_report+0x11c/0x46c
[    4.816331]  ? __lock_acquire+0xbc/0x7a8
[    4.816331]  ? __lock_acquire+0xbc/0x7a8
[    4.821898]  __asan_load8+0x64/0x66
[    4.821898]  __asan_load8+0x64/0x66
[    4.822909]  __lock_acquire+0xbc/0x7a8
[    4.822909]  __lock_acquire+0xbc/0x7a8
[    4.824413]  lock_acquire+0x89/0xb6
[    4.824413]  lock_acquire+0x89/0xb6
[    4.827583]  ? blk_stat_add_callback+0x184/0x1ec
[    4.827583]  ? blk_stat_add_callback+0x184/0x1ec
[    4.829018]  _raw_spin_lock+0x2a/0x39
[    4.829018]  _raw_spin_lock+0x2a/0x39
[    4.832807]  ? blk_stat_add_callback+0x184/0x1ec
[    4.832807]  ? blk_stat_add_callback+0x184/0x1ec
[    4.836900]  blk_stat_add_callback+0x184/0x1ec
[    4.836900]  blk_stat_add_callback+0x184/0x1ec
[    4.838239]  wbt_init+0x1a2/0x254
[    4.838239]  wbt_init+0x1a2/0x254
[    4.842123]  blk_register_queue+0x14d/0x1f1
[    4.842123]  blk_register_queue+0x14d/0x1f1
[    4.843407]  device_add_disk+0x5be/0x7ce
[    4.843407]  device_add_disk+0x5be/0x7ce
[    4.845634]  ? blk_alloc_devt+0x159/0x159
[    4.845634]  ? blk_alloc_devt+0x159/0x159
[    4.847030]  ? device_initialize+0x1d9/0x1e8
[    4.847030]  ? device_initialize+0x1d9/0x1e8
[    4.848480]  ? alloc_disk_node+0x1c0/0x1ce
[    4.848480]  ? alloc_disk_node+0x1c0/0x1ce
[    4.850202]  ? brd_alloc+0x2a0/0x2ae
[    4.850202]  ? brd_alloc+0x2a0/0x2ae
[    4.851404]  brd_init+0x106/0x22e
[    4.851404]  brd_init+0x106/0x22e
[    4.855372]  ? ramdisk_size+0x29/0x29
[    4.855372]  ? ramdisk_size+0x29/0x29
[    4.856702]  ? set_debug_rodata+0x20/0x20
[    4.856702]  ? set_debug_rodata+0x20/0x20
[    4.858217]  do_one_initcall+0x118/0x226
[    4.858217]  do_one_initcall+0x118/0x226
[    4.859269]  ? initcall_blacklisted+0x14f/0x14f
[    4.859269]  ? initcall_blacklisted+0x14f/0x14f
[    4.860409]  ? parse_args+0x476/0x489
[    4.860409]  ? parse_args+0x476/0x489
[    4.862709]  ? set_debug_rodata+0x20/0x20
[    4.862709]  ? set_debug_rodata+0x20/0x20
[    4.864021]  kernel_init_freeable+0x1fc/0x2ab
[    4.864021]  kernel_init_freeable+0x1fc/0x2ab
[    4.869014]  ? rest_init+0xdc/0xdc
[    4.869014]  ? rest_init+0xdc/0xdc
[    4.869907]  kernel_init+0x11/0x157
[    4.869907]  kernel_init+0x11/0x157
[    4.871086]  ? rest_init+0xdc/0xdc
[    4.871086]  ? rest_init+0xdc/0xdc
[    4.871957]  ret_from_fork+0x2c/0x40
[    4.871957]  ret_from_fork+0x2c/0x40
[    4.876237] ==================================================================
[    4.876237] ==================================================================
[    4.878151] Disabling lock debugging due to kernel taint
[    4.878151] Disabling lock debugging due to kernel taint
[    4.879881] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
[    4.879881] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
[    4.884106] IP: __lock_acquire+0xbc/0x7a8
[    4.884106] IP: __lock_acquire+0xbc/0x7a8
[    4.885698] PGD 0 
[    4.885698] PGD 0 
[    4.885700] 
[    4.885700] 
[    4.886695] Oops: 0000 [#1] PREEMPT SMP KASAN
[    4.886695] Oops: 0000 [#1] PREEMPT SMP KASAN
[    4.888175] Modules linked in:
[    4.888175] Modules linked in:
[    4.889286] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B           4.11.0-rc3-00005-g34dbad5 #1
[    4.889286] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B           4.11.0-rc3-00005-g34dbad5 #1
[    4.892230] task: ffff88001a5d5880 task.stack: ffff88001a5d8000
[    4.892230] task: ffff88001a5d5880 task.stack: ffff88001a5d8000
[    4.894176] RIP: 0010:__lock_acquire+0xbc/0x7a8
[    4.894176] RIP: 0010:__lock_acquire+0xbc/0x7a8
[    4.895890] RSP: 0000:ffff88001a5dfb18 EFLAGS: 00010046
[    4.895890] RSP: 0000:ffff88001a5dfb18 EFLAGS: 00010046
[    4.897769] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81115cff
[    4.897769] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81115cff
[    4.900242] RDX: 1ffffffff04e6438 RSI: dffffc0000000000 RDI: 0000000000000096
[    4.900242] RDX: 1ffffffff04e6438 RSI: dffffc0000000000 RDI: 0000000000000096
[    4.902700] RBP: ffff88001a5dfb68 R08: 0000000000000001 R09: 0000000000000000
[    4.902700] RBP: ffff88001a5dfb68 R08: 0000000000000001 R09: 0000000000000000
[    4.905111] R10: ffff88001a5dfa17 R11: fffffbfff06cbf67 R12: ffff88001a5d5880
[    4.905111] R10: ffff88001a5dfa17 R11: fffffbfff06cbf67 R12: ffff88001a5d5880
[    4.910851] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000028
[    4.910851] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000028
[    4.912952] FS:  0000000000000000(0000) GS:ffff88001a800000(0000) knlGS:0000000000000000
[    4.912952] FS:  0000000000000000(0000) GS:ffff88001a800000(0000) knlGS:0000000000000000
[    4.915677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.915677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.917673] CR2: 0000000000000030 CR3: 0000000002613000 CR4: 00000000001406f0
[    4.917673] CR2: 0000000000000030 CR3: 0000000002613000 CR4: 00000000001406f0
[    4.919920] Call Trace:
[    4.919920] Call Trace:
[    4.920500]  lock_acquire+0x89/0xb6
[    4.920500]  lock_acquire+0x89/0xb6
[    4.921430]  ? blk_stat_add_callback+0x184/0x1ec
[    4.921430]  ? blk_stat_add_callback+0x184/0x1ec
[    4.923076]  _raw_spin_lock+0x2a/0x39
[    4.923076]  _raw_spin_lock+0x2a/0x39
[    4.924359]  ? blk_stat_add_callback+0x184/0x1ec
[    4.924359]  ? blk_stat_add_callback+0x184/0x1ec
[    4.926018]  blk_stat_add_callback+0x184/0x1ec
[    4.926018]  blk_stat_add_callback+0x184/0x1ec
[    4.927511]  wbt_init+0x1a2/0x254
[    4.927511]  wbt_init+0x1a2/0x254
[    4.928694]  blk_register_queue+0x14d/0x1f1
[    4.928694]  blk_register_queue+0x14d/0x1f1
[    4.929754]  device_add_disk+0x5be/0x7ce
[    4.929754]  device_add_disk+0x5be/0x7ce
[    4.930735]  ? blk_alloc_devt+0x159/0x159
[    4.930735]  ? blk_alloc_devt+0x159/0x159
[    4.932061]  ? device_initialize+0x1d9/0x1e8
[    4.932061]  ? device_initialize+0x1d9/0x1e8
[    4.933573]  ? alloc_disk_node+0x1c0/0x1ce
[    4.933573]  ? alloc_disk_node+0x1c0/0x1ce
[    4.934985]  ? brd_alloc+0x2a0/0x2ae
[    4.934985]  ? brd_alloc+0x2a0/0x2ae
[    4.936199]  brd_init+0x106/0x22e
[    4.936199]  brd_init+0x106/0x22e
[    4.937395]  ? ramdisk_size+0x29/0x29
[    4.937395]  ? ramdisk_size+0x29/0x29
[    4.938668]  ? set_debug_rodata+0x20/0x20
[    4.938668]  ? set_debug_rodata+0x20/0x20
[    4.940044]  do_one_initcall+0x118/0x226
[    4.940044]  do_one_initcall+0x118/0x226
[    4.941437]  ? initcall_blacklisted+0x14f/0x14f
[    4.941437]  ? initcall_blacklisted+0x14f/0x14f
[    4.942938]  ? parse_args+0x476/0x489
[    4.942938]  ? parse_args+0x476/0x489
[    4.944002]  ? set_debug_rodata+0x20/0x20
[    4.944002]  ? set_debug_rodata+0x20/0x20
[    4.945100]  kernel_init_freeable+0x1fc/0x2ab
[    4.945100]  kernel_init_freeable+0x1fc/0x2ab
[    4.946381]  ? rest_init+0xdc/0xdc
[    4.946381]  ? rest_init+0xdc/0xdc
[    4.947505]  kernel_init+0x11/0x157
[    4.947505]  kernel_init+0x11/0x157
[    4.948757]  ? rest_init+0xdc/0xdc
[    4.948757]  ? rest_init+0xdc/0xdc
[    4.949938]  ret_from_fork+0x2c/0x40
[    4.949938]  ret_from_fork+0x2c/0x40
[    4.950977] Code: a0 4f e6 81 48 c7 c2 a0 4e e6 81 be 97 0c 00 00 e9 a8 00 00 00 83 fb 01 0f 87 b0 00 00 00 41 89 dd 4b 8d 7c ef 08 e8 85 c9 10 00 <4b> 8b 44 ef 08 48 85 c0 0f 84 95 00 00 00 3e ff 80 98 01 00 00 
[    4.950977] Code: a0 4f e6 81 48 c7 c2 a0 4e e6 81 be 97 0c 00 00 e9 a8 00 00 00 83 fb 01 0f 87 b0 00 00 00 41 89 dd 4b 8d 7c ef 08 e8 85 c9 10 00 <4b> 8b 44 ef 08 48 85 c0 0f 84 95 00 00 00 3e ff 80 98 01 00 00 
[    4.956939] RIP: __lock_acquire+0xbc/0x7a8 RSP: ffff88001a5dfb18
[    4.956939] RIP: __lock_acquire+0xbc/0x7a8 RSP: ffff88001a5dfb18
[    4.959176] CR2: 0000000000000030
[    4.959176] CR2: 0000000000000030
[    4.960169] ---[ end trace 4e180df5ee2e289b ]---
[    4.960169] ---[ end trace 4e180df5ee2e289b ]---

                                                         # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 9757e8c35963f662f0a21c80132ccaca74c64b49 c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201 --
git bisect  bad 0d3ea4d6c581f6f7e20ca63bdf30d54e3be8d733  # 02:10  B      0    11   22   0  Merge 'linux-review/Hans-de-Goede/gpio-acpi-Call-enable_irq_wake-for-_IAE-GpioInts-with-Wake-set/20170322-005456' into devel-catchup-201703220111
git bisect good 6843e7dacc3f7501dd5d0cc972e5ebe1720c4322  # 02:23  G     11     0   11  11  Merge 'linux-review/Luis-Oliveira/i2c-designware-add-I2C-SLAVE-support/20170321-225058' into devel-catchup-201703220111
git bisect good 49abb38c4e6dcc19ab8772ebb7dec896d99b6ddd  # 02:41  G     10     0    0   0  Merge 'arm-platforms/timers/errata-rework' into devel-catchup-201703220111
git bisect  bad d266f17d6ec278e015314b0b119c401311398d9f  # 02:53  B      0    11   22   0  Merge 'block/for-next' into devel-catchup-201703220111
git bisect good fa2e39cb9ee78f440d99a1bcfa47462c48a6fc11  # 05:38  G     11     0    0   0  blk-stat: use READ and WRITE instead of BLK_STAT_{READ,WRITE}
git bisect  bad 34dbad5d26e2f4b88e60f0e9ad03f99480802812  # 05:38  B      0    48  109   0  blk-stat: convert to callback-based statistics reporting
git bisect good 4875253fddd7b6d322f028ad023d44b6efb7f73b  # 05:59  G     11     0    0   0  blk-stat: move BLK_RQ_STAT_BATCH definition to blk-stat.c
# first bad commit: [34dbad5d26e2f4b88e60f0e9ad03f99480802812] blk-stat: convert to callback-based statistics reporting
git bisect good 4875253fddd7b6d322f028ad023d44b6efb7f73b  # 06:05  G     31     0    0   0  blk-stat: move BLK_RQ_STAT_BATCH definition to blk-stat.c
# extra tests on HEAD of linux-devel/devel-catchup-201703220111
git bisect  bad 9757e8c35963f662f0a21c80132ccaca74c64b49  # 06:05  B      0    21   35   0  0day head guard for 'devel-catchup-201703220111'
# extra tests on tree/branch block/for-next
git bisect  bad 34dbad5d26e2f4b88e60f0e9ad03f99480802812  # 06:08  B      0    48  109   0  blk-stat: convert to callback-based statistics reporting
# extra tests with first bad commit reverted
git bisect good 13c70c2e8cf9c46ed6442799a1ae3b9d073e53ce  # 06:41  G     11     0    0   0  Revert "blk-stat: convert to callback-based statistics reporting"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_58d1ac34.YiUk2W4GBPO6CI0Tg5ExbXdDfEWOzGZCntvH6UIU+7DOtKQf
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-ivb41-143:20170322032427:x86_64-randconfig-s0-03220031:4.11.0-rc3-00005-g34dbad5:1.gz"

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

--=_58d1ac34.YiUk2W4GBPO6CI0Tg5ExbXdDfEWOzGZCntvH6UIU+7DOtKQf
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-yocto-ivb41-143:20170322032427:x86_64-randconfig-s0-03220031:4.11.0-rc3-00005-g34dbad5:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/initrd/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	console=tty0
	vga=normal
	rw
	drbd.minor_count=8
)

"${kvm[@]}" -append "${append[*]}"

--=_58d1ac34.YiUk2W4GBPO6CI0Tg5ExbXdDfEWOzGZCntvH6UIU+7DOtKQf
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.11.0-rc3-00005-g34dbad5"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.11.0-rc3 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_FHANDLE=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_TREE_RCU_TRACE=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
# CONFIG_NUMA_BALANCING_DEFAULT_ENABLED is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
# CONFIG_MEMCG_SWAP is not set
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_INITRAMFS_COMPRESSION=".gz"
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
# CONFIG_POSIX_TIMERS is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_USERFAULTFD=y
CONFIG_PCI_QUIRKS=y
# CONFIG_MEMBARRIER is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_SANCOV=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
CONFIG_CC_STACKPROTECTOR_REGULAR=y
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=m
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_INTEL_RDT_A=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_GOLDFISH is not set
CONFIG_X86_INTEL_MID=y
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_APB_TIMER=y
# CONFIG_DMI is not set
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS=8192
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_VM86 is not set
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_MOVABLE_NODE is not set
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZPOOL=y
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=m
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_SCHED_HRTICK is not set
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
# CONFIG_KEXEC_VERIFY_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
# CONFIG_HT_IRQ is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT is not set

#
# PCI host controller drivers
#
CONFIG_VMD=y
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_KEYS_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_NET_KEY is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
# CONFIG_DST_CACHE is not set
# CONFIG_GRO_CELLS is not set
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
CONFIG_MTD_TESTS=m
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_AR7_PARTS=m

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
CONFIG_INFTL=y
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=m
CONFIG_MTD_SWAP=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=m
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
CONFIG_MTD_CK804XROM=y
CONFIG_MTD_SCB2_FLASH=m
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=m

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
CONFIG_MTD_PMC551_DEBUG=y
# CONFIG_MTD_DATAFLASH is not set
CONFIG_MTD_M25P80=y
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_ECC=m
CONFIG_MTD_NAND_ECC_SMC=y
# CONFIG_MTD_NAND is not set
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
# CONFIG_MTD_ONENAND_GENERIC is not set
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_MT81xx_NOR=m
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=m
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_BLK_DEV_FD=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_BLK_CPQ_CISS_DA=m
# CONFIG_CISS_SCSI_TAPE is not set
CONFIG_BLK_DEV_DAC960=m
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set

#
# DRBD disabled because PROC_FS or INET not selected
#
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SKD=m
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_RAM_DAX=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
CONFIG_BLK_DEV_HD=y
CONFIG_BLK_DEV_RSXX=m
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_BLK_DEV_NVME_SCSI=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=m
# CONFIG_PHANTOM is not set
CONFIG_INTEL_MID_PTI=m
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=y
CONFIG_TI_DAC7512=m
CONFIG_USB_SWITCH_FSA9480=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
CONFIG_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=y
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=y

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=m

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#
CONFIG_SCIF=m

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#
# CONFIG_MIC_COSM is not set

#
# VOP Driver
#
CONFIG_VOP=m
CONFIG_VHOST_RING=m
CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=m

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_IDE_GD is not set
CONFIG_BLK_DEV_IDECS=m
# CONFIG_BLK_DEV_DELKIN is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
CONFIG_BLK_DEV_PLATFORM=m
CONFIG_BLK_DEV_CMD640=m
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=m
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=m
CONFIG_BLK_DEV_AMD74XX=m
# CONFIG_BLK_DEV_ATIIXP is not set
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_JMICRON=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_IT8172=m
CONFIG_BLK_DEV_IT8213=m
# CONFIG_BLK_DEV_IT821X is not set
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_SVWKS=m
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
# CONFIG_BLK_DEV_TC86C001 is not set
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_MQ_DEFAULT=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=m
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=m
# CONFIG_SCSI_DH_ALUA is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=m
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NOSY=m
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
# CONFIG_NETDEVICES is not set
CONFIG_NVM=y
CONFIG_NVM_DEBUG=y
CONFIG_NVM_RRPC=m

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_88PM860X=m
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
# CONFIG_TOUCHSCREEN_AD7879_SPI is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_DA9034=m
# CONFIG_TOUCHSCREEN_DA9052 is not set
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_FUJITSU=m
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=m
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
# CONFIG_TOUCHSCREEN_UCB1400 is not set
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM831X=m
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_PCAP=m
CONFIG_TOUCHSCREEN_RM_TS=m
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
CONFIG_CYZ_INTR=y
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
# CONFIG_SYNCLINK is not set
CONFIG_SYNCLINKMP=m
# CONFIG_SYNCLINK_GT is not set
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
# CONFIG_N_GSM is not set
# CONFIG_TRACE_ROUTER is not set
CONFIG_TRACE_SINK=m
CONFIG_GOLDFISH_TTY=m
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_EXAR=m
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
# CONFIG_SERIAL_8250_LPSS is not set
CONFIG_SERIAL_8250_MID=m
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=m
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_DEV_BUS=m
CONFIG_TTY_PRINTK=y
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_TPM=m
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=y
# CONFIG_SCR24X is not set
CONFIG_MWAVE=m
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_PCIE is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=m
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=m
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=m
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_LM70_LLP=m
CONFIG_SPI_OC_TINY=m
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
CONFIG_SPI_ROCKCHIP=m
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=m
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
CONFIG_SPMI=y
# CONFIG_HSI is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VX855=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=m
CONFIG_GPIO_SCH=m
CONFIG_GPIO_SCH311X=m

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=m
CONFIG_GPIO_ARIZONA=m
# CONFIG_GPIO_CRYSTAL_COVE is not set
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_JANZ_TTL=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP873X=m
# CONFIG_GPIO_MSIC is not set
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TWL6040=m
CONFIG_GPIO_UCB1400=m
CONFIG_GPIO_WHISKEY_COVE=y
# CONFIG_GPIO_WM831X is not set
# CONFIG_GPIO_WM8994 is not set

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_INTEL_MID is not set
# CONFIG_GPIO_MERRIFIELD is not set
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCI_IDIO_16=m
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set

#
# SPI or I2C GPIO expanders
#
CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=m
# CONFIG_W1_SLAVE_DS2781 is not set
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_BQ27000 is not set
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_WM831X_BACKUP=m
CONFIG_WM831X_POWER=y
CONFIG_TEST_POWER=y
CONFIG_BATTERY_88PM860X=m
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
CONFIG_CHARGER_88PM860X=m
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_MAX8998 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=m
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_DA9052_ADC=m
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=m
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=m
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=m
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_BXT_PMIC_THERMAL=m
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_GENERIC_ADC_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_SILENT is not set
CONFIG_SSB_DEBUG=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=m
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_INTEL_SOC_PMIC=y
CONFIG_MFD_INTEL_LPSS=m
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=m
CONFIG_MFD_INTEL_MSIC=y
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77693=m
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
CONFIG_EZX_PCAP=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_UCB1400_CORE=m
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RTSX_PCI is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SMSC=y
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9063=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=m
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6397=m
# CONFIG_REGULATOR_PCAP is not set
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_RT5033=m
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=m
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65090=m
# CONFIG_REGULATOR_TPS65217 is not set
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8994=y
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_RC_SUPPORT is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CEC_DEBUG is not set
CONFIG_MEDIA_CEC_EDID=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_CORE=y
CONFIG_TTPCI_EEPROM=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_SAA7134=m
# CONFIG_VIDEO_SAA7134_ALSA is not set
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=y

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110=y
# CONFIG_DVB_AV7110_OSD is not set
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
# CONFIG_DVB_BUDGET_AV is not set
# CONFIG_DVB_BUDGET_PATCH is not set
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG=y
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_PT1=y
CONFIG_DVB_PT3=m
# CONFIG_DVB_NGENE is not set
CONFIG_DVB_DDBRIDGE=y
# CONFIG_DVB_NETUP_UNIDVB is not set
CONFIG_DVB_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=y

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_TVEEPROM=y
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y
CONFIG_SMS_SIANO_MDTV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=y
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=y
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_TLV320AIC23B=y
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_WM8775=y
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_SONY_BTF_MPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_BT819=y
CONFIG_VIDEO_BT856=y
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=m
CONFIG_VIDEO_ADV7393=y
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_THS8200=m

#
# Camera sensor devices
#
CONFIG_VIDEO_MT9M111=y

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=y

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT2266=m
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_TUA9001=y
# CONFIG_MEDIA_TUNER_SI2157 is not set
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=y

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
# CONFIG_DVB_STV6110x is not set
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
# CONFIG_DVB_SI2165 is not set
CONFIG_DVB_MN88472=m
# CONFIG_DVB_MN88473 is not set

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
# CONFIG_DVB_CX24123 is not set
CONFIG_DVB_MT312=y
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_TDA8083=m
# CONFIG_DVB_TDA10086 is not set
# CONFIG_DVB_TDA8261 is not set
# CONFIG_DVB_VES1X93 is not set
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=y
CONFIG_DVB_SI21XX=y
# CONFIG_DVB_TS2020 is not set
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=y
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
CONFIG_DVB_SP887X=y
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=y
CONFIG_DVB_S5H1432=y
# CONFIG_DVB_DRXD is not set
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_TDA1004X=m
# CONFIG_DVB_NXT6000 is not set
# CONFIG_DVB_MT352 is not set
CONFIG_DVB_ZL10353=y
# CONFIG_DVB_DIB3000MB is not set
# CONFIG_DVB_DIB3000MC is not set
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=m
# CONFIG_DVB_TDA10048 is not set
# CONFIG_DVB_AF9013 is not set
# CONFIG_DVB_EC100 is not set
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=m
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=m
# CONFIG_DVB_SI2168 is not set
# CONFIG_DVB_AS102_FE is not set
CONFIG_DVB_ZD1301_DEMOD=m
# CONFIG_DVB_GP8PSK_FE is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
CONFIG_DVB_OR51211=y
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=y
# CONFIG_DVB_LGDT330X is not set
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LG2160=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
# CONFIG_DVB_DIB8000 is not set
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_TC90522 is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=y
# CONFIG_DVB_SP2 is not set
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=y
CONFIG_DVB_IX2505V=m
# CONFIG_DVB_M88RS2000 is not set
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=y
CONFIG_DVB_HELENE=y

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_SIS=y
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=m
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_RADEON=m
# CONFIG_DRM_RADEON_USERPTR is not set
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
# CONFIG_DRM_AMDGPU_CIK is not set
# CONFIG_DRM_AMDGPU_USERPTR is not set
# CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_AMD_ACP is not set
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
CONFIG_DRM_I915=m
CONFIG_DRM_I915_ALPHA_SUPPORT=y
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
CONFIG_DRM_I915_DEBUG=y
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_HISI_HIBMC=m
CONFIG_DRM_TINYDRM=m
CONFIG_TINYDRM_MIPI_DBI=m
CONFIG_TINYDRM_MI0283QT=m
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=m
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
# CONFIG_FB_ARC is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=y
CONFIG_FB_LE80578=m
# CONFIG_FB_CARILLO_RANCH is not set
CONFIG_FB_INTEL=m
CONFIG_FB_INTEL_DEBUG=y
# CONFIG_FB_INTEL_I2C is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=m
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=m
# CONFIG_FB_PM3 is not set
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_SM501=m
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_BROADSHEET=y
CONFIG_FB_AUO_K190X=y
CONFIG_FB_AUO_K1900=m
# CONFIG_FB_AUO_K1901 is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=m
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=y
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_S6E63M0 is not set
CONFIG_LCD_LD9040=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_CARILLO_RANCH=m
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP5520 is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=m
CONFIG_VGASTATE=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_SEQUENCER_OSS is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_RAWMIDI_SEQ=m
CONFIG_SND_OPL3_LIB_SEQ=m
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=m
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_SB_COMMON=m
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
CONFIG_SND_ALS4000=m
# CONFIG_SND_ALI5451 is not set
CONFIG_SND_ASIHPI=m
# CONFIG_SND_ATIIXP is not set
CONFIG_SND_ATIIXP_MODEM=m
# CONFIG_SND_AU8810 is not set
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
CONFIG_SND_BT87X_OVERCLOCK=y
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=m
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
# CONFIG_SND_INDIGOIOX is not set
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
# CONFIG_SND_HDSPM is not set
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
# CONFIG_SND_MAESTRO3_INPUT is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
CONFIG_SND_SONICVIBES=m
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
# CONFIG_SND_HDA_HWDEP is not set
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
# CONFIG_SND_HDA_CODEC_CA0132 is not set
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=m
# CONFIG_SND_PDAUDIOCF is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=m
CONFIG_HDMI_LPE_AUDIO=m
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
# CONFIG_HID_LOGITECH_DJ is not set
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=m
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=m
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=m
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=y
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_BLOCK is not set
CONFIG_SDIO_UART=m
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
CONFIG_MMC_WBSD=y
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_GOLDFISH=y
CONFIG_MMC_SPI=y
CONFIG_MMC_SDRICOH_CS=y
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=y
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=m
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=m
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_ACCESSIBILITY=y
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_LP8788 is not set
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8998=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=y
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=m
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=m
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_TPS6586X is not set
CONFIG_RTC_DRV_TPS65910=y
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_S5M is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=y
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=y
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=m
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
# CONFIG_RTC_DRV_RS5C348 is not set
CONFIG_RTC_DRV_MAX6902=m
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_VRTC=m
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9052 is not set
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_PCF50633=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_PCAP=m
CONFIG_RTC_DRV_MC13XXX=y
# CONFIG_RTC_DRV_MT6397 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=m
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=m

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
# CONFIG_MSI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_SCU_IPC=y
# CONFIG_INTEL_SCU_IPC_UTIL is not set
CONFIG_INTEL_MID_POWER_BUTTON=m
# CONFIG_INTEL_MFLD_THERMAL is not set
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_PMC_CORE=y
CONFIG_IBM_RTL=y
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_MLX_PLATFORM=y
CONFIG_MLX_CPLD_PLATFORM=y
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
CONFIG_GOLDFISH_PIPE=m
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_CLK_TWL6040=m
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_DW_APB_TIMER=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IOVA=m
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#

#
# Broadcom SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
CONFIG_SOC_ZTE=y
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_QCOM_SPMI_MISC=m
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_KXSD9=m
CONFIG_KXSD9_SPI=m
CONFIG_KXSD9_I2C=m
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=m
CONFIG_STK8312=m
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD7266=y
CONFIG_AD7291=m
CONFIG_AD7298=m
CONFIG_AD7476=m
CONFIG_AD7766=y
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
CONFIG_AD7887=y
CONFIG_AD7923=y
# CONFIG_AD799X is not set
CONFIG_CC10001_ADC=m
# CONFIG_DA9150_GPADC is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_LP8788_ADC is not set
CONFIG_LTC2485=m
CONFIG_MAX1027=m
CONFIG_MAX11100=m
# CONFIG_MAX1363 is not set
CONFIG_MCP320X=m
# CONFIG_MCP3422 is not set
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=m
# CONFIG_QCOM_SPMI_IADC is not set
# CONFIG_QCOM_SPMI_VADC is not set
CONFIG_TI_ADC081C=m
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC12138 is not set
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS7950=m
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=y

#
# Amplifiers
#
CONFIG_AD8366=m

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_IAQCORE=m
CONFIG_VZ89X=m

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
CONFIG_AD5064=m
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
CONFIG_AD5446=m
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=m
# CONFIG_AD5592R is not set
CONFIG_AD5593R=m
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=y
# CONFIG_AD5686 is not set
CONFIG_AD5755=y
CONFIG_AD5761=m
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
CONFIG_AD7303=m
# CONFIG_AD8801 is not set
CONFIG_M62332=y
CONFIG_MAX517=m
CONFIG_MCP4725=y
# CONFIG_MCP4922 is not set

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=y
CONFIG_ADIS16136=y
CONFIG_ADIS16260=y
CONFIG_ADXRS450=m
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
CONFIG_AFE4404=y
CONFIG_MAX30100=m

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=m
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=m
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=m
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=m
CONFIG_KMX61=y
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=y
CONFIG_APDS9300=m
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM36651=m
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_ISL29125=m
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=y
CONFIG_LTR501=m
# CONFIG_MAX44000 is not set
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
CONFIG_SI1145=y
CONFIG_STK3310=m
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
# CONFIG_VEML6070 is not set

#
# Magnetometer sensors
#
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
CONFIG_MAG3110=y
CONFIG_MMC35240=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
# CONFIG_SENSORS_HMC5843_SPI is not set

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
# CONFIG_DS1803 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
CONFIG_MCP4131=y
CONFIG_MCP4531=y
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
CONFIG_MS5611_I2C=m
CONFIG_MS5611_SPI=y
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=y
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity and distance sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_SX9500 is not set
CONFIG_SRF08=m

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
CONFIG_MLX90614=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
CONFIG_TSYS01=m
# CONFIG_TSYS02D is not set
CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=m
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
# CONFIG_VME_TSI148 is not set
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
# CONFIG_PWM is not set
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STM32 is not set
# CONFIG_RESET_SUNXI is not set
CONFIG_TI_SYSCON_RESET=y
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
CONFIG_MCB=m
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_MCE_AMD_INJ=m
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
CONFIG_ND_BLK=m
# CONFIG_BTT is not set
CONFIG_DEV_DAX=y
CONFIG_NR_DEV_DAX=32768
CONFIG_NVMEM=y
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set

#
# FPGA Configuration Support
#
CONFIG_FPGA=m

#
# FSI support
#
CONFIG_FSI=m

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
# CONFIG_DCDBAS is not set
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y

#
# Google Firmware Drivers
#
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_NILFS2_FS=m
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=m
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=m
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_STACK_VALIDATION is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_KASAN=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_TEST_KASAN=m
CONFIG_ARCH_HAS_KCOV=y
CONFIG_KCOV=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_SPARSE_RCU_POINTER=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_INIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
CONFIG_INTERVAL_TREE_TEST=m
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
CONFIG_TEST_HEXDUMP=m
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
CONFIG_TEST_RHASHTABLE=m
# CONFIG_TEST_HASH is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_UDELAY=y
# CONFIG_MEMTEST is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_UBSAN_NULL is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HAVE_ARCH_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
# CONFIG_CRYPTO_MD5 is not set
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
# CONFIG_CRYPTO_SHA1_MB is not set
# CONFIG_CRYPTO_SHA256_MB is not set
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_X86_64=m
CONFIG_CRYPTO_AES_NI_INTEL=m
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=m
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_SALSA20_X86_64=y
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
# CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=m
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m

--=_58d1ac34.YiUk2W4GBPO6CI0Tg5ExbXdDfEWOzGZCntvH6UIU+7DOtKQf--
