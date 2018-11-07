Return-Path: <rong.a.chen@intel.com>
Date: Wed, 7 Nov 2018 11:16:43 +0800
From: kernel test robot <rong.a.chen@intel.com>
To: Omar Sandoval <osandov@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [LKP] a9f38e1dec [ 245.678853] INFO: task mount:580 blocked for more
 than 120 seconds.
Message-ID: <20181107031643.GD24195@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fTMItigZdw4hn5Z7"
List-ID: <linux-block@vger.kernel.org>


--fTMItigZdw4hn5Z7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit a9f38e1dec107af70d81338332494bf0a1e76597
Author:     Omar Sandoval <osandov@fb.com>
AuthorDate: Mon Oct 15 09:21:34 2018 -0600
Commit:     Jens Axboe <axboe@kernel.dk>
CommitDate: Tue Oct 16 09:50:14 2018 -0600

    floppy: convert to blk-mq
    
    This driver likes to fetch requests from all over the place, so make
    queue_rq put requests on a list so that the logic stays the same. Tested
    with QEMU.
    
    Signed-off-by: Omar Sandoval <osandov@fb.com>
    
    Converted to blk_mq_init_sq_queue() and fixed a few spots where the
    tag_set leaked on cleanup.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

6ec3938cff  ataflop: convert to blk-mq
a9f38e1dec  floppy: convert to blk-mq
8053e5b93e  Merge tag 'trace-v4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
337734cbca  Add linux-next specific files for 20181106
+---------------------------------------------------------+------------+------------+------------+---------------+
|                                                         | 6ec3938cff | a9f38e1dec | 8053e5b93e | next-20181106 |
+---------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                          | 251        | 68         | 69         | 74            |
| boot_failures                                           | 48         | 27         | 25         | 23            |
| Mem-Info                                                | 48         | 12         | 15         | 7             |
| invoked_oom-killer:gfp_mask=0x                          | 6          | 4          | 3          | 2             |
| EIP:iov_iter_fault_in_readable                          | 4          | 1          |            |               |
| Out_of_memory:Kill_process                              | 3          | 2          | 2          |               |
| Out_of_memory_and_no_killable_processes                 | 3          | 2          | 2          |               |
| Kernel_panic-not_syncing:System_is_deadlocked_on_memory | 3          | 2          | 2          |               |
| EIP:__put_user_4                                        | 1          |            |            |               |
| INFO:task_blocked_for_more_than#seconds                 | 0          | 15         | 10         | 16            |
| EIP:lock_is_held_type                                   | 0          | 1          | 0          | 1             |
| EIP:native_safe_halt                                    | 0          | 3          |            |               |
| Kernel_panic-not_syncing:hung_task:blocked_tasks        | 0          | 15         | 10         | 16            |
| EIP:strnlen_user                                        | 0          | 1          |            |               |
| EIP:_local_bh_enable                                    | 0          | 1          |            |               |
| EIP:__lock_acquire                                      | 0          | 1          | 1          | 1             |
| EIP:vprintk_emit                                        | 0          | 1          |            |               |
| EIP:do_softirq_own_stack                                | 0          | 0          | 1          |               |
| EIP:default_idle                                        | 0          | 0          | 2          | 1             |
| EIP:reschedule_interrupt                                | 0          | 0          | 1          |               |
| EIP:delay_tsc                                           | 0          | 0          | 0          | 1             |
| EIP:copy_page_from_iter                                 | 0          | 0          | 0          | 1             |
| EIP:_cond_resched                                       | 0          | 0          | 0          | 1             |
+---------------------------------------------------------+------------+------------+------------+---------------+

[  244.196551] random: get_random_u32 called from arch_align_stack+0x2d/0x40 with crng_init=1
[  245.254485] _warn_unseeded_randomness: 54 callbacks suppressed
[  245.254491] random: get_random_u32 called from copy_process+0x1c8/0x17b0 with crng_init=1
[  245.257366] random: get_random_u32 called from arch_pick_mmap_layout+0x110/0x140 with crng_init=1
[  245.258675] random: get_random_u32 called from load_elf_binary+0x2b6/0xb48 with crng_init=1
[  245.678853] INFO: task mount:580 blocked for more than 120 seconds.
[  245.679906]       Tainted: G                T 4.19.0-rc6-00172-ga9f38e1 #1
[  245.680959] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  245.682181] mount           D 6372   580      1 0x00000004
[  245.683023] Call Trace:
[  245.683425]  __schedule+0x2df/0x570
[  245.683975]  schedule+0x2d/0x80
[  245.684476]  schedule_timeout+0x19d/0x330
[  245.685090]  ? wait_for_common+0xa5/0x170
[  245.685735]  wait_for_common+0xac/0x170
[  245.686339]  ? do_sched_yield+0x90/0x90
[  245.686935]  wait_for_completion+0x12/0x20
[  245.687571]  __floppy_read_block_0+0xfb/0x150
[  245.688244]  ? floppy_resume+0x40/0x40
[  245.688844]  floppy_revalidate+0x20f/0x240
[  245.689486]  check_disk_change+0x43/0x60
[  245.690087]  floppy_open+0x1ea/0x360
[  245.690653]  __blkdev_get+0xb4/0x4d0
[  245.691212]  ? blkdev_get+0x1db/0x370
[  245.691777]  blkdev_get+0x1f3/0x370
[  245.692351]  ? path_put+0x15/0x20
[  245.692871]  ? lookup_bdev+0x4b/0x90
[  245.693539]  blkdev_get_by_path+0x3d/0x80
[  245.694165]  mount_bdev+0x2a/0x190
[  245.694695]  squashfs_mount+0x10/0x20
[  245.695271]  ? squashfs_alloc_inode+0x30/0x30
[  245.695960]  mount_fs+0xf/0x90
[  245.696451]  vfs_kern_mount+0x43/0x130
[  245.697036]  do_mount+0x187/0xc40
[  245.697563]  ? memdup_user+0x28/0x50
[  245.698124]  ksys_mount+0x60/0xc0
[  245.698639]  sys_mount+0x19/0x20
[  245.699167]  do_int80_syscall_32+0x61/0x130
[  245.699813]  entry_INT80_32+0xc7/0xc7
[  245.700391] EIP: 0x47f46fee
[  245.700829] Code: 11 83 c8 ff eb e2 90 90 90 90 90 90 57 56 53 8b 7c 24 20 8b 74 24 1c 8b 54 24 18 8b 4c 24 14 8b 5c 24 10 b8 15 00 00 00 cd 80 <5b> 5e 5f 3d 01 f0 ff ff 73 01 c3 e8 e8 80 03 00 81 c1 f6 5f 09 00
[  245.703680] EAX: ffffffda EBX: affa4efa ECX: affa4f03 EDX: 080d3630
[  245.704642] ESI: 00008010 EDI: 00000000 EBP: 00000000 ESP: affa45c0
[  245.705637] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282
[  245.706679] 
[  245.706679] Showing all locks held in the system:
[  245.707636] 1 lock held by khungtaskd/22:
[  245.708258]  #0: (ptrval) (rcu_read_lock){....}, at: debug_show_all_locks+0x13/0x110
[  245.709474] 3 locks held by mount/580:
[  245.710056]  #0: (ptrval) (&bdev->bd_mutex){....}, at: __blkdev_get+0x136/0x4d0
[  245.711186]  #1: (ptrval) (floppy_mutex){....}, at: floppy_open+0x26/0x360
[  245.712265]  #2: (ptrval) (open_lock){....}, at: floppy_open+0x32/0x360
[  245.713289] 
[  245.713539] =============================================
[  245.713539] 
[  245.714587] NMI backtrace for cpu 0
[  245.715132] CPU: 0 PID: 22 Comm: khungtaskd Tainted: G                T 4.19.0-rc6-00172-ga9f38e1 #1
[  245.716507] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  245.717763] Call Trace:
[  245.718153]  dump_stack+0x79/0xa6
[  245.718663]  nmi_cpu_backtrace+0x8c/0x90
[  245.719269]  nmi_trigger_cpumask_backtrace+0xaa/0xe0
[  245.720019]  ? irq_force_complete_move+0x80/0x80
[  245.720731]  arch_trigger_cpumask_backtrace+0x13/0x20
[  245.721504]  watchdog+0x2d9/0x3f0
[  245.722010]  kthread+0xdb/0x110
[  245.722499]  ? hung_task_panic+0x20/0x20
[  245.723093]  ? __kthread_create_on_node+0x140/0x140
[  245.723842]  ret_from_fork+0x19/0x30
[  245.724419] Sending NMI from CPU 0 to CPUs 1:
[  245.725109] NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x5/0x10
[  245.726094] Kernel panic - not syncing: hung_task: blocked tasks
[  245.727154] CPU: 0 PID: 22 Comm: khungtaskd Tainted: G                T 4.19.0-rc6-00172-ga9f38e1 #1
[  245.728537] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  245.729790] Call Trace:
[  245.730185]  dump_stack+0x79/0xa6
[  245.730693]  panic+0x98/0x1d0
[  245.731166]  watchdog+0x2e3/0x3f0
[  245.731672]  kthread+0xdb/0x110
[  245.732158]  ? hung_task_panic+0x20/0x20
[  245.732755]  ? __kthread_create_on_node+0x140/0x140
[  245.733504]  ret_from_fork+0x19/0x30
[  245.734093] Kernel Offset: 0x5a00000 from 0xb1000000 (relocation range: 0xb0000000-0xc07d1fff)


                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 384a8a0d3699415091a01a3c7e7d40fe232bc32f 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d --
git bisect  bad 08b6b9a0ecf1807ed20f24a3dd1284d707563ad1  # 22:15  B     29     2   20  20  Merge 'linux-review/robbieko/Btrfs-fix-cur_offset-in-the-error-case-for-nocow/20181030-181552' into devel-catchup-201810311741
git bisect  bad bb451bbc477cc8aa24b61bcc50db56b126838e4b  # 22:41  B     17     2    9   9  Merge 'tip/master' into devel-catchup-201810311741
git bisect  bad f4e4b76f16e81d604c111e0fe740434fda6cfd08  # 22:57  B     21     1    8   8  Merge 'linux-review/Yuantian-Tang/clk-qoriq-add-more-chips-support/20181031-170545' into devel-catchup-201810311741
git bisect  bad e7248e5b707330ae6d6e4c45061a74faf428faa7  # 23:19  B     22     1   15  16  Merge 'jpirko-mlxsw/net_queue' into devel-catchup-201810311741
git bisect good 1e68fdfc37c7dc0e53a5ff23888c6f7284d53511  # 23:57  G    157     0   97  97  0day base guard for 'devel-catchup-201810311741'
git bisect  bad 62606c224d72a98c35d21a849f95cccf95b0a252  # 00:17  B     18     1   12  13  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect good 3f80e08f40cdb308589a49077c87632fa4508b21  # 00:58  G    161     0   96  96  tcp: add tcp_reset_xmit_timer() helper
git bisect  bad 382d72a9aa525b56ab8453ce61751fa712414d3d  # 01:12  B     33     2   18  19  Merge branch 'x86-hyperv-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad b0b6a28bc4b265aa56cbf4fa8fd27c0a4fa3a49c  # 01:29  B     13     1    7   7  Merge tag 'pinctrl-v4.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect  bad a36cf6865120d7534fcb132d311f03e5159f2da7  # 01:45  B      5     1    4   4  Merge tag 'mtd/for-4.20' of git://git.infradead.org/linux-mtd
git bisect  bad 52990a5fb0c991ecafebdab43138b5ed41376852  # 02:00  B     12     1    6   6  block: setup bounce bio_sets properly
git bisect good ae14cc044b5988148d819c377fd0cc1c7504bc3c  # 03:29  G    155     0   90  90  lightnvm: pblk: refactor put line fn on read completion
git bisect good 9316a9ed6895c4ad2f0cde171d486f80c55d8283  # 04:11  G    157     0   86  86  blk-mq: provide helper for setting up an SQ queue and tag set
git bisect  bad bb2a1d4e804aa41eef0003a192a674f844dbca23  # 04:26  B     31     1   19  19  nvme-core: rework a NQN copying operation
git bisect good 21b07f35544af5e2c11f079057e8fb4263d35dd3  # 05:20  G    159     0   92  92  amiflop: convert to blk-mq
git bisect  bad 8535fd6f702a4b3e225258a86dcbf5dd93b73d51  # 05:41  B     38     1   19  19  z2ram: convert to blk-mq
git bisect good 6ec3938cff95fe792a05fdf4ba14f92977e5e31d  # 06:40  G    174     0  106 106  ataflop: convert to blk-mq
git bisect  bad ad5fc6bb72214615f300af1f4ed57f71bc3be510  # 07:02  B     25     2   16  17  gdrom: convert to blk-mq
git bisect  bad a9f38e1dec107af70d81338332494bf0a1e76597  # 07:27  B     31     1   21  21  floppy: convert to blk-mq
# first bad commit: [a9f38e1dec107af70d81338332494bf0a1e76597] floppy: convert to blk-mq
git bisect good 6ec3938cff95fe792a05fdf4ba14f92977e5e31d  # 08:44  G    498     0  250 357  ataflop: convert to blk-mq
# extra tests with debug options
git bisect  bad a9f38e1dec107af70d81338332494bf0a1e76597  # 09:00  B     30     2   14  15  floppy: convert to blk-mq
# extra tests on HEAD of linux-devel/devel-catchup-201810311741
git bisect  bad 384a8a0d3699415091a01a3c7e7d40fe232bc32f  # 09:01  B    136    24    0 194  0day head guard for 'devel-catchup-201810311741'
# extra tests on tree/branch linus/master
git bisect  bad 8053e5b93eca9b011f7b79bb019bf1eeaaf96c4b  # 09:28  B     37     1   19  19  Merge tag 'trace-v4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
# extra tests with first bad commit reverted
git bisect good e63db4a6aaac124f2fd7700827d4f2566d80d01e  # 10:17  G    202     0  119 119  Revert "floppy: convert to blk-mq"
# extra tests on tree/branch linux-next/master
git bisect  bad 337734cbca7453b1d57049bda1b9879adde2a5f8  # 10:41  B     17     1   11  12  Add linux-next specific files for 20181106

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--fTMItigZdw4hn5Z7
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-ivb41-5:20181107080728:i386-randconfig-h1-10311702:4.19.0-rc6-00172-ga9f38e1:1.gz"
Content-Transfer-Encoding: base64

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

--fTMItigZdw4hn5Z7
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-ivb41-10:20181107061345:i386-randconfig-h1-10311702:4.19.0-rc6-00171-g6ec3938c:1.gz"
Content-Transfer-Encoding: base64

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
RiqP5ccC10FqA8XEgrHEd9DMsVDlymUXxBAyQ0YXiFskMTMyRUaPPFYzMrpgRpV9QTDH4PS+
M9jlyRfAJ/Q9Ui2zfeegJ8MaOrzUm/XVbXN1++HuPbCFLXn2HnsAW/Ly4n51s358/4b8pBgh
m/Xnv/3mj6vfffvb3/34w9s/rb77/r//+je/f+t25nbnGn5++3x9DV/cPWx3D2/IV26Hu6Gv
1tv//eYMTgbiuyGc+NHrxub++XH39OYVzujjan19ffdxt30TPCNdao6v//jja1BE/vjtP7/G
CbLN13c3N6/7pP4M/3rabV83v22if/7ciJfUviRnDxt1RgjV9OxS7TbccrNp/hP1zJTGA/53
64ftxzW8vdv1ze5189/efvdj88PT+nYL3zd//Lr5/EoI8s2/Nr+C/nz7r1811FoUzn/z7fc/
NPQlJS/ZGW2IeEXoK0ao8OS1Qbjraxhl8+eH9Wb32v9knLWh2T7f3K8en9ab978iP2n7ivy0
VkEjjUuwbfRut4Yph1aSQysmjG9mOQKhzT81d89Pq7uLVbtY0bOCb6Ett8H0WoPn2aAlp7uo
JRwX6EnWrNxL2qzu15e7x9VhIcAj55sNPLIxwSOUYOEE6MjT9Tmc+zd3H3buOewK+qewsK3C
epHNx3vXYoU+Jzi4NTQTF0E7Rt1ETaLJ3OtstnerPVn0XiHoXSJp0Iw7EQVIrh7WH1eP91e3
Kxghjok59mFTl09wGnfhghKbd7Bwrnerm5vVxfr5Gp1zxMZAUxN2QVhUBmFyoa9u/Ie21OCs
irAPUmjq+vD+g7tNtyvgAB9gH63uL/Cbx7tbfIfYIR48qChWYmhiFkzE7ZwrO7ZbP3663UQd
wtbroDWWmoHWG9iQd7er3U+b3f3TlevAFtfQbhc0de50b7/9I+zlnwwxF5vwzRqGOurXsKJe
N0Y2FxcNucAPO9YQsv//mjaaNOfbZq0bYuC5xpw3ZIufuzbwyIY0WjSEN3CU4pcCSXGK7de8
oZuGHGgiBdtQ2TDiv/yHNf9HJHm+2/M5D8h3HNrnyMY3Q54b5LnbdMOSxKAR/u2v/xVOLs7l
hd2a5u1v4C+CZQgJpc3br/Evs9YbA+rK23/Gv9w/bO3JUBf++faHbw8/Emza++s3MK/rCys3
dgMsfuj+Ct6WZM7U8c8/4HP6HFrtP3zzQ0up+a37wHnzQ9fmm9//uv2WUMKEP48kl4isfgc3
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
A0P3RzZ4AwA=

--fTMItigZdw4hn5Z7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-ivb41-5:20181107080728:i386-randconfig-h1-10311702:4.19.0-rc6-00172-ga9f38e1:1"

#!/bin/bash

kernel=$1
initrd=yocto-minimal-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 256
	-smp 2
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
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
	--no-log
)

"${kvm[@]}" -append "${append[*]}"

--fTMItigZdw4hn5Z7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.19.0-rc6-00172-ga9f38e1"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.19.0-rc6 Kernel Configuration
#

#
# Compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=40904
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
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
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FAST_NO_HZ is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
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
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_PROFILING is not set
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_BIGSMP=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_RDC321X=y
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_QUEUED_LOCK_STAT=y
CONFIG_KVM_GUEST=y
CONFIG_KVM_DEBUG_FS=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
CONFIG_M586=y
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_F00F_BUG=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
# CONFIG_CPU_SUP_UMC_32 is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_16BIT is not set
CONFIG_TOSHIBA=y
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_VMSPLIT_3G is not set
CONFIG_VMSPLIT_3G_OPT=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xB0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
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

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# CONFIG_PCIE_CADENCE_EP is not set
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
CONFIG_PCI_EPF_TEST=y

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE_OF is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_SCSI=y
CONFIG_VHOST=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_LBDAF is not set
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
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
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
# CONFIG_FAILOVER is not set
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
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_MTD=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_FTL=y
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_SWAP=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
CONFIG_MTD_MAP_BANK_WIDTH_32=y
# CONFIG_MTD_CFI_I1 is not set
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
CONFIG_MTD_CFI_I8=y
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_SBC_GXX=y
# CONFIG_MTD_SCx200_DOCFLASH is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_GPIO_ADDR is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
CONFIG_MTD_LATCH_ADDR=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_M25P80 is not set
CONFIG_MTD_MCHP23K256=y
# CONFIG_MTD_SST25L is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SMC is not set
CONFIG_MTD_NAND=y
CONFIG_MTD_NAND_BCH=y
CONFIG_MTD_NAND_ECC_BCH=y
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
CONFIG_MTD_NAND_DOCG4=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=y
CONFIG_MTD_NAND_NANDSIM=y
CONFIG_MTD_NAND_PLATFORM=y
CONFIG_MTD_SPI_NAND=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_MT81xx_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=y
# CONFIG_MTD_UBI is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=y
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_BLK_SCSI=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_ECHO is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
CONFIG_IDE_GD_ATAPI=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_CS5536 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_MQ_DEFAULT=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_CEVA=y
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_I40E is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

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
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
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
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_PS2_OLPC is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_ASPEED_VUART=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_IFX6X60=y
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=y
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=y
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=y
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
CONFIG_RANDOM_TRUST_CPU=y

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
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=y
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=y
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AS3722=y
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_PALMAS=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_STMPE=y
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_MAX8925_POWER is not set
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_OLPC=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9052=y
# CONFIG_BATTERY_DA9150 is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
# CONFIG_BATTERY_TWL4030_MADC is not set
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_BATTERY_RX51=y
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS1015 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_DA9062_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_QCOM_SPMI_TEMP_ALARM=y
# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_CHARDEV=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_MADERA_SPI is not set
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# CONFIG_STMPE_SPI is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_RAVE_SP_CORE is not set
# CONFIG_REGULATOR is not set
CONFIG_CEC_CORE=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CAFE_CCIC is not set
CONFIG_VIDEO_CADENCE=y
CONFIG_VIDEO_CADENCE_CSI2RX=y
# CONFIG_VIDEO_CADENCE_CSI2TX is not set
# CONFIG_VIDEO_MUX is not set
CONFIG_SOC_CAMERA=y
# CONFIG_SOC_CAMERA_PLATFORM is not set
CONFIG_VIDEO_XILINX=y
CONFIG_VIDEO_XILINX_TPG=y
CONFIG_VIDEO_XILINX_VTC=y
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set
# CONFIG_VIDEO_SH_VEU is not set
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIMC=y
CONFIG_VIDEO_VIVID=y
CONFIG_VIDEO_VIVID_CEC=y
CONFIG_VIDEO_VIVID_MAX_DEVS=64
CONFIG_VIDEO_VIM2M=y
CONFIG_VIDEO_VICODEC=y
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
# CONFIG_CYPRESS_FIRMWARE is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEO_V4L2_TPG=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

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

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#

#
# soc_camera sensor drivers
#
CONFIG_SOC_CAMERA_MT9M001=y
CONFIG_SOC_CAMERA_MT9M111=y
CONFIG_SOC_CAMERA_MT9T112=y
CONFIG_SOC_CAMERA_MT9V022=y
CONFIG_SOC_CAMERA_OV5642=y
# CONFIG_SOC_CAMERA_OV772X is not set
CONFIG_SOC_CAMERA_OV9640=y
CONFIG_SOC_CAMERA_OV9740=y
# CONFIG_SOC_CAMERA_RJ54N1 is not set
CONFIG_SOC_CAMERA_TW9910=y

#
# Media SPI Adapters
#
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
# CONFIG_DRM_DP_CEC is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=y
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_S6E63M0=y
CONFIG_LCD_LD9040=y
CONFIG_LCD_AMS369FG06=y
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_TPS65217=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GOOGLE_HAMMER is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_OTG_FSM=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_MON=y
CONFIG_USB_WUSB=y
CONFIG_USB_WUSB_CBAF=y
CONFIG_USB_WUSB_CBAF_DEBUG=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=y
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
CONFIG_USB_DWC3_OF_SIMPLE=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=y
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_SIMPLE=y
CONFIG_USB_SERIAL_AIRCABLE=y
# CONFIG_USB_SERIAL_ARK3116 is not set
CONFIG_USB_SERIAL_BELKIN=y
CONFIG_USB_SERIAL_CH341=y
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
# CONFIG_USB_SERIAL_CP210X is not set
CONFIG_USB_SERIAL_CYPRESS_M8=y
# CONFIG_USB_SERIAL_EMPEG is not set
CONFIG_USB_SERIAL_FTDI_SIO=y
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
CONFIG_USB_SERIAL_IR=y
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_F8153X=y
# CONFIG_USB_SERIAL_GARMIN is not set
CONFIG_USB_SERIAL_IPW=y
CONFIG_USB_SERIAL_IUU=y
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=y
CONFIG_USB_SERIAL_METRO=y
# CONFIG_USB_SERIAL_MOS7720 is not set
CONFIG_USB_SERIAL_MOS7840=y
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=y
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_OTI6858=y
CONFIG_USB_SERIAL_QCAUX=y
CONFIG_USB_SERIAL_QUALCOMM=y
CONFIG_USB_SERIAL_SPCP8X5=y
# CONFIG_USB_SERIAL_SAFE is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_XIRCOM=y
CONFIG_USB_SERIAL_WWAN=y
CONFIG_USB_SERIAL_OPTION=y
CONFIG_USB_SERIAL_OMNINET=y
CONFIG_USB_SERIAL_OPTICON=y
# CONFIG_USB_SERIAL_XSENS_MT is not set
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
CONFIG_USB_SERIAL_QT2=y
CONFIG_USB_SERIAL_UPD78F0730=y
CONFIG_USB_SERIAL_DEBUG=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=y
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_ACPI is not set
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_UWB=y
CONFIG_UWB_HWA=y
# CONFIG_UWB_WHCI is not set
# CONFIG_UWB_I1480U is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CR0014114 is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_NET48XX=y
# CONFIG_LEDS_WRAP is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
CONFIG_RTC_DRV_88PM80X=y
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_AS3722=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX8998=y
# CONFIG_RTC_DRV_MAX77686 is not set
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
# CONFIG_RTC_DRV_PCF85063 is not set
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TWL4030=y
# CONFIG_RTC_DRV_PALMAS is not set
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_S5M is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
CONFIG_RTC_DRV_M41T94=y
# CONFIG_RTC_DRV_DS1302 is not set
CONFIG_RTC_DRV_DS1305=y
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=y
CONFIG_RTC_DRV_RX4581=y
# CONFIG_RTC_DRV_RX6110 is not set
CONFIG_RTC_DRV_RS5C348=y
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_WM831X is not set
# CONFIG_RTC_DRV_WM8350 is not set
CONFIG_RTC_DRV_PCF50633=y
# CONFIG_RTC_DRV_ZYNQMP is not set
CONFIG_RTC_DRV_CROS_EC=y

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_PCAP is not set
CONFIG_RTC_DRV_MC13XXX=y
CONFIG_RTC_DRV_SNVS=y
CONFIG_RTC_DRV_MT6397=y
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
# CONFIG_KS0108 is not set
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
CONFIG_FB_OLPC_DCON=y
CONFIG_FB_OLPC_DCON_1_5=y
# CONFIG_R8712U is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
CONFIG_ADIS16240=y

#
# Analog to digital converters
#
CONFIG_AD7606=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD7606_IFACE_SPI=y
CONFIG_AD7780=y
CONFIG_AD7816=y
CONFIG_AD7192=y
CONFIG_AD7280=y

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_SPI=y
# CONFIG_ADT7316_I2C is not set

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
CONFIG_AD7152=y
# CONFIG_AD7746 is not set

#
# Direct Digital Synthesis
#
CONFIG_AD9832=y
# CONFIG_AD9834 is not set

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1210=y
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y
CONFIG_SOC_CAMERA_IMX074=y
CONFIG_SOC_CAMERA_MT9T031=y
# CONFIG_VIDEO_ZORAN is not set

#
# Android
#
CONFIG_ASHMEM=y
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
CONFIG_ION_CARVEOUT_HEAP=y
CONFIG_ION_CHUNK_HEAP=y
# CONFIG_STAGING_BOARD is not set
CONFIG_GOLDFISH_AUDIO=y
# CONFIG_MTD_SPINAND_MT29F is not set
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=y
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_FB_TFT is not set
# CONFIG_MOST is not set
CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=y
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=y
# CONFIG_GREYBUS_LOOPBACK is not set
CONFIG_GREYBUS_POWER=y
CONFIG_GREYBUS_RAW=y
# CONFIG_GREYBUS_VIBRATOR is not set
# CONFIG_GREYBUS_BRIDGED_PHY is not set
CONFIG_PI433=y

#
# Gasket devices
#
CONFIG_XIL_AXIS_FIFO=y
CONFIG_EROFS_FS=y
CONFIG_EROFS_FS_DEBUG=y
CONFIG_EROFS_FS_XATTR=y
# CONFIG_EROFS_FS_POSIX_ACL is not set
# CONFIG_EROFS_FS_SECURITY is not set
# CONFIG_EROFS_FS_USE_VM_MAP_RAM is not set
CONFIG_EROFS_FAULT_INJECTION=y
# CONFIG_EROFS_FS_ZIP is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_XO15_EBOOK is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_MLX_PLATFORM=y
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC_CTL=y
CONFIG_CROS_EC_I2C=y
CONFIG_CROS_EC_SPI=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
# CONFIG_MLXREG_IO is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_VIRTIO=y
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_PALMAS=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
CONFIG_ADIS16209=y
CONFIG_ADXL345=y
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL345_SPI=y
# CONFIG_BMA180 is not set
CONFIG_BMA220=y
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7266=y
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
# CONFIG_AD7766 is not set
CONFIG_AD7791=y
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
CONFIG_AD7923=y
CONFIG_AD799X=y
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HI8435=y
# CONFIG_HX711 is not set
CONFIG_LTC2471=y
CONFIG_LTC2485=y
CONFIG_LTC2497=y
CONFIG_MAX1027=y
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=y
# CONFIG_MCP320X is not set
CONFIG_MCP3422=y
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_QCOM_VADC_COMMON=y
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=y
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_TI_ADC081C=y
CONFIG_TI_ADC0832=y
CONFIG_TI_ADC084S021=y
# CONFIG_TI_ADC12138 is not set
CONFIG_TI_ADC108S102=y
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=y
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_ADS8688=y
CONFIG_TI_AM335X_ADC=y
CONFIG_TI_TLC4541=y
CONFIG_TWL4030_MADC=y
CONFIG_TWL6030_GPADC=y
CONFIG_VF610_ADC=y
CONFIG_VIPERBOARD_ADC=y

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set

#
# Amplifiers
#
CONFIG_AD8366=y

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_VZ89X is not set
# CONFIG_IIO_CROS_EC_SENSORS_CORE is not set

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORS_COMMONS is not set
CONFIG_IIO_SSP_SENSORHUB=y
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5360=y
CONFIG_AD5380=y
CONFIG_AD5421=y
# CONFIG_AD5446 is not set
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
# CONFIG_AD5592R is not set
CONFIG_AD5593R=y
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
CONFIG_LTC2632=y
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
CONFIG_AD5696_I2C=y
# CONFIG_AD5755 is not set
CONFIG_AD5758=y
# CONFIG_AD5761 is not set
CONFIG_AD5764=y
CONFIG_AD5791=y
# CONFIG_AD7303 is not set
CONFIG_AD8801=y
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
CONFIG_MCP4922=y
# CONFIG_TI_DAC082S085 is not set
CONFIG_TI_DAC5571=y
# CONFIG_VF610_DAC is not set

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=y
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
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
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=y
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=y

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16480=y
CONFIG_BMI160=y
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=y
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_INV_MPU6050_SPI=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
# CONFIG_APDS9960 is not set
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
CONFIG_GP2AP020A00F=y
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=y
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=y
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=y
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=y
CONFIG_MCP4131=y
CONFIG_MCP4531=y
CONFIG_TPL0102=y

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
# CONFIG_SX9500 is not set
CONFIG_SRF08=y

#
# Resolver to digital converters
#
# CONFIG_AD2S1200 is not set

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LP3943=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
CONFIG_PWM_STMPE=y
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_TUSB1210 is not set
CONFIG_POWERCAP=y
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_STH=y
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_ICE40_SPI=y
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
# CONFIG_FPGA_DFL_FME_MGR is not set
CONFIG_FPGA_DFL_FME_BRIDGE=y
CONFIG_FPGA_DFL_FME_REGION=y
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_SCOM=y
CONFIG_FSI_SBEFIFO=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_ADGS1408 is not set
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_ENCRYPTION is not set
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_FS_WBUF_VERIFY=y
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
# CONFIG_JFFS2_FS_SECURITY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_ZSTD is not set
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=y
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_RAM is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
# CONFIG_CRYPTO_AUTHENC is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128L=y
CONFIG_CRYPTO_AEGIS256=y
CONFIG_CRYPTO_MORUS640=y
CONFIG_CRYPTO_MORUS1280=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
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
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SPECK=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PI_LIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=2
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

--fTMItigZdw4hn5Z7--
