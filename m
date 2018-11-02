Return-Path: <rong.a.chen@intel.com>
Date: Fri, 2 Nov 2018 08:19:57 +0800
From: kernel test robot <rong.a.chen@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [LKP] a518560778 [ 16.132179] BUG: KASAN: null-ptr-deref in brd_alloc
Message-ID: <20181102001957.GE24195@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2l43pqSnz0CmKuGJ"
List-ID: <linux-block@vger.kernel.org>


--2l43pqSnz0CmKuGJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-linus

commit a5185607787e030fcb0009194d3b12f8bcca59d6
Author:     Ming Lei <ming.lei@redhat.com>
AuthorDate: Wed Oct 31 16:40:50 2018 +0800
Commit:     Jens Axboe <axboe@kernel.dk>
CommitDate: Wed Oct 31 08:43:09 2018 -0600

    block: brd: associate with queue until adding disk
    
    brd_free() may be called in failure path on one brd instance without
    the disk being added yet, so release handler of gendisk may free the
    associated request_queue early and cause the following use-after-free[1].
    
    This patch fixes this issue by associating gendisk with request_queue
    just before adding disk.
    
    [1] KASAN: use-after-free Read in del_timer_syncNon-volatile memory driver v1.3
    Linux agpgart interface v0.103
    [drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
    usbcore: registered new interface driver udl
    ==================================================================
    BUG: KASAN: use-after-free in __lock_acquire+0x36d9/0x4c20
    kernel/locking/lockdep.c:3218
    Read of size 8 at addr ffff8801d1b6b540 by task swapper/0/1
    
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0+ #88
    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
    Google 01/01/2011
    Call Trace:
      __dump_stack lib/dump_stack.c:77 [inline]
      dump_stack+0x244/0x39d lib/dump_stack.c:113
      print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
      kasan_report_error mm/kasan/report.c:354 [inline]
      kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
      __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
      __lock_acquire+0x36d9/0x4c20 kernel/locking/lockdep.c:3218
      lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
      del_timer_sync+0xb7/0x270 kernel/time/timer.c:1283
      blk_cleanup_queue+0x413/0x710 block/blk-core.c:809
      brd_free+0x5d/0x71 drivers/block/brd.c:422
      brd_init+0x2eb/0x393 drivers/block/brd.c:518
      do_one_initcall+0x145/0x957 init/main.c:890
      do_initcall_level init/main.c:958 [inline]
      do_initcalls init/main.c:966 [inline]
      do_basic_setup init/main.c:984 [inline]
      kernel_init_freeable+0x5c6/0x6b9 init/main.c:1148
      kernel_init+0x11/0x1ae init/main.c:1068
      ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:350
    
    Reported-by: syzbot+3701447012fe951dabb2@syzkaller.appspotmail.com
    Signed-off-by: Ming Lei <ming.lei@redhat.com>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

c57cdf7a9e  block: call rq_qos_exit() after queue is frozen
a518560778  block: brd: associate with queue until adding disk
+------------------------------------------------+------------+------------+
|                                                | c57cdf7a9e | a518560778 |
+------------------------------------------------+------------+------------+
| boot_successes                                 | 0          | 0          |
| boot_failures                                  | 46         | 15         |
| BUG:kernel_hang_in_test_stage                  | 44         |            |
| IP-Config:Auto-configuration_of_network_failed | 2          |            |
| BUG:KASAN:null-ptr-deref_in_b                  | 0          | 15         |
| BUG:unable_to_handle_kernel                    | 0          | 15         |
| Oops:#[##]                                     | 0          | 15         |
| RIP:brd_alloc                                  | 0          | 15         |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 15         |
+------------------------------------------------+------------+------------+

[   16.119590] smapi::smapi_init, ERROR invalid usSmapiID
[   16.120907] mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is not available on this machine
[   16.123300] mwave: mwavedd::mwave_init: Error: Failed to initialize board data
[   16.125261] mwave: mwavedd::mwave_init: Error: Failed to initialize
[   16.130478] ==================================================================
[   16.132179] BUG: KASAN: null-ptr-deref in brd_alloc+0x20e/0x277
[   16.132179] Read of size 8 at addr 0000000000000230 by task swapper/1
[   16.132179] 
[   16.132179] CPU: 0 PID: 1 Comm: swapper Not tainted 4.19.0-05614-ga518560 #1
[   16.132179] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   16.132179] Call Trace:
[   16.132179]  kasan_report+0x231/0x279
[   16.132179]  brd_alloc+0x20e/0x277
[   16.132179]  brd_init+0x51/0x234
[   16.132179]  ? ramdisk_size+0x16/0x16
[   16.132179]  ? do_early_param+0xae/0xae
[   16.132179]  do_one_initcall+0xc0/0x1b3
[   16.132179]  ? rcu_read_lock+0x2c/0x2c
[   16.132179]  ? lock_downgrade+0x27d/0x27d
[   16.132179]  kernel_init_freeable+0x17c/0x227
[   16.132179]  ? rest_init+0xd5/0xd5
[   16.132179]  kernel_init+0x7/0xfe
[   16.132179]  ? rest_init+0xd5/0xd5
[   16.132179]  ret_from_fork+0x1f/0x30
[   16.132179] ==================================================================
[   16.132179] Disabling lock debugging due to kernel taint
[   16.173689] BUG: unable to handle kernel NULL pointer dereference at 0000000000000230
[   16.175701] PGD 0 P4D 0 
[   16.176497] Oops: 0000 [#1] PREEMPT KASAN PTI
[   16.176972] CPU: 0 PID: 1 Comm: swapper Tainted: G    B             4.19.0-05614-ga518560 #1
[   16.176972] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   16.176972] RIP: 0010:brd_alloc+0x20e/0x277
[   16.176972] Code: 50 4c 8d 24 00 e8 64 a8 b7 ff 4c 89 65 50 4c 89 ef e8 da a7 b7 ff 4c 8b a5 90 05 00 00 49 8d bc 24 30 02 00 00 e8 c6 a7 b7 ff <4d> 8b a4 24 30 02 00 00 49 8d 7c 24 3c e8 b1 a6 b7 ff 41 83 4c 24
[   16.176972] RSP: 0000:ffff88001909fdd8 EFLAGS: 00010282
[   16.176972] RAX: 0000000000000000 RBX: ffff880013473988 RCX: ffffffff810dffc0
[   16.176972] RDX: ffffffff811e48ae RSI: 0000000000000003 RDI: ffffffff8290b200
[   16.176972] RBP: ffff8800134c2ee8 R08: dffffc0000000000 R09: 0000000000000000
[   16.176972] R10: 0000000000000001 R11: 073d073d073d073d R12: 0000000000000000
[   16.176972] R13: ffff8800134c3478 R14: ffffffff83228050 R15: ffffffff82a8d960
[   16.176972] FS:  0000000000000000(0000) GS:ffffffff8285c000(0000) knlGS:0000000000000000
[   16.176972] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.176972] CR2: 0000000000000230 CR3: 0000000002824000 CR4: 00000000000006b0
[   16.176972] Call Trace:
[   16.176972]  brd_init+0x51/0x234
[   16.176972]  ? ramdisk_size+0x16/0x16
[   16.176972]  ? do_early_param+0xae/0xae
[   16.176972]  do_one_initcall+0xc0/0x1b3
[   16.176972]  ? rcu_read_lock+0x2c/0x2c
[   16.176972]  ? lock_downgrade+0x27d/0x27d
[   16.176972]  kernel_init_freeable+0x17c/0x227
[   16.176972]  ? rest_init+0xd5/0xd5
[   16.176972]  kernel_init+0x7/0xfe
[   16.176972]  ? rest_init+0xd5/0xd5
[   16.176972]  ret_from_fork+0x1f/0x30
[   16.176972] Modules linked in:
[   16.176972] CR2: 0000000000000230
[   16.176972] ---[ end trace 4c9c9e7a1ae58e68 ]---
[   16.176972] RIP: 0010:brd_alloc+0x20e/0x277

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 5da169cafb99be34009584e06bde227d33727524 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d --
git bisect  bad 94e203722538e1af1130debc1b4408b84d0a4ed4  # 17:26  B      0    11   26   0  Merge 'tip/x86/urgent' into devel-hourly-2018110113
git bisect good 2cd5e1c3bc1206e86c5e31651c4c77e179ddf4a8  # 19:03  G     11     0   11  12  Merge 'linux-review/Andreas-Puhm/fpga-altera_cvp-restrict-registration-to-CvP-enabled-devices/20181022-213417' into devel-hourly-2018110113
git bisect  bad 6d0d7e4e782cc962b8a4fa7b65c695a1092f61ac  # 19:19  B      0     1   16   0  Merge 'nf/master' into devel-hourly-2018110113
git bisect good bd5d37fd8f3f500f331161c816ce87c9427e9fc3  # 20:16  G     10     0   10  10  Merge 'linux-review/Florian-Fainelli/arm64-Get-rid-of-__early_init_dt_declare_initrd/20181030-075423' into devel-hourly-2018110113
git bisect  bad a0e620bebd1ad34866b6646af5027c6c92784314  # 20:39  B      0    11   26   0  Merge 'block/for-linus' into devel-hourly-2018110113
git bisect good 2561c52cec3f710041e34a3737a866b565437e20  # 21:39  G     11     0   11  11  Merge 'jlayton/locks-4.21' into devel-hourly-2018110113
git bisect good 1bb9b0d1289f12f22a4145804b66aba7e22581c3  # 22:23  G     11     0   11  11  Merge 'superna9999/amlogic/v4.20/drm-overlay' into devel-hourly-2018110113
git bisect good 6bceec3a8988eb11f6f75db9254fc42a4782d88d  # 23:16  G     10     0   10  10  Merge 'linux-review/Julia-Lawall/ASoC-AMD-constify-regulator_desc-structure/20181028-143635' into devel-hourly-2018110113
git bisect good d122007297044d28f8a285ea3a38f04a9065982d  # 00:03  G     10     0   10  10  Merge 'gpio/fixes' into devel-hourly-2018110113
git bisect good 698b53b3119c45a59eef10b516d780b3e9a5402d  # 00:56  G     11     0   11  13  mtip32xx: clean an indentation issue, remove extraneous tabs
git bisect  bad a5185607787e030fcb0009194d3b12f8bcca59d6  # 01:11  B      0     1   16   0  block: brd: associate with queue until adding disk
git bisect good c57cdf7a9e51d97a43e29b8f4a04157875104000  # 02:01  G     11     0   11  11  block: call rq_qos_exit() after queue is frozen
# first bad commit: [a5185607787e030fcb0009194d3b12f8bcca59d6] block: brd: associate with queue until adding disk
git bisect good c57cdf7a9e51d97a43e29b8f4a04157875104000  # 02:43  G     33     0   33  46  block: call rq_qos_exit() after queue is frozen
# extra tests with debug options
git bisect  bad a5185607787e030fcb0009194d3b12f8bcca59d6  # 02:56  B      0     5   20   0  block: brd: associate with queue until adding disk
# extra tests on HEAD of linux-devel/devel-hourly-2018110113
git bisect  bad 5da169cafb99be34009584e06bde227d33727524  # 03:01  B      0    13   31   0  0day head guard for 'devel-hourly-2018110113'
# extra tests on tree/branch block/for-linus
git bisect  bad a5185607787e030fcb0009194d3b12f8bcca59d6  # 03:06  B      0    15   30   0  block: brd: associate with queue until adding disk
# extra tests with first bad commit reverted
git bisect good 0d9bc20beb726cc13f58a44660e94ea0c4402314  # 04:54  G     10     0   10  10  Revert "block: brd: associate with queue until adding disk"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--2l43pqSnz0CmKuGJ
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vp-24:20181102011209:x86_64-randconfig-s3-11011429:4.19.0-05614-ga518560:1.gz"
Content-Transfer-Encoding: base64

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

--2l43pqSnz0CmKuGJ
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vp-11:20181102023350:x86_64-randconfig-s3-11011429:4.19.0-05613-gc57cdf7:1.gz"
Content-Transfer-Encoding: base64

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
OPoXqKtfqp+kAAA=

--2l43pqSnz0CmKuGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-vp-24:20181102011209:x86_64-randconfig-s3-11011429:4.19.0-05614-ga518560:1"

#!/bin/bash

kernel=$1
initrd=quantal-core-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 512
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
)

"${kvm[@]}" -append "${append[*]}"

--2l43pqSnz0CmKuGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.19.0-05614-ga518560"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.19.0 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
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
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
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
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_PROFILING=y
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
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
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
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_CALGARY_IOMMU=y
# CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_X86_5LEVEL is not set
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_NFIT is not set
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
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_EP=y
CONFIG_PCI_FTPCI100=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
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
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
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
# CONFIG_GCC_PLUGINS is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=m
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
# CONFIG_ZONE_DEVICE is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
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
CONFIG_DNS_RESOLVER=m
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
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set

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
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SKD=y
CONFIG_BLK_DEV_SX8=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=m

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=y
# CONFIG_NVME_TARGET_FCLOOP is not set

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=m
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=m
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=m
CONFIG_MISC_RTSX=m
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=m
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

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
CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
# CONFIG_ECHO is not set
CONFIG_MISC_RTSX_PCI=m
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
CONFIG_CHR_DEV_OSST=y
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
CONFIG_SCSI_DH_HP_SW=y
# CONFIG_SCSI_DH_EMC is not set
# CONFIG_SCSI_DH_ALUA is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_CEVA is not set
CONFIG_AHCI_QORIQ=m
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=m
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
# CONFIG_FUSION_LOGGING is not set

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
# CONFIG_RIONET is not set
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
CONFIG_MDIO=m
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
# CONFIG_AQTION is not set
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
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
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
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
CONFIG_IGB_DCA=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCA=y
# CONFIG_I40E is not set
# CONFIG_IGC is not set
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
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
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
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
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
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
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
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
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
# CONFIG_THUNDERBOLT_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
CONFIG_NVM_PBLK=y
# CONFIG_NVM_PBLK_DEBUG is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

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
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
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
CONFIG_TOUCHSCREEN_88PM860X=y
CONFIG_TOUCHSCREEN_AD7879=m
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
# CONFIG_TOUCHSCREEN_ADC is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_ILI210X=m
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=y
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_STMPE=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=y
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=y
# CONFIG_CYCLADES is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=y
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=m
CONFIG_DEVMEM=y
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
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_ASPEED_VUART=m
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_MOXA=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SCCNXP=m
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=m
# CONFIG_R3964 is not set
CONFIG_APPLICOM=y
CONFIG_MWAVE=y
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_MUX_MLXCPLD=m
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD756_S4882 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_VIA is not set
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
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_CROS_EC_TUNNEL is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

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
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_EXAR=y
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_SYSCON is not set
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XILINX=m

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=m
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=m
# CONFIG_GPIO_MAX77620 is not set
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_STMPE is not set
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8994=m

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=y
# CONFIG_GPIO_SODAVILLE is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
CONFIG_POWER_RESET_LTC2952=y
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=m
CONFIG_SYSCON_REBOOT_MODE=m
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_MAX8925_POWER=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_LEGO_EV3=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GAUGE_LTC2941=m
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_DA9055=m
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_MLXREG_FAN=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=m
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_MAX77620_THERMAL=m
CONFIG_DA9062_THERMAL=y
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_AT91_USART is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_CHARDEV=y
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=m
CONFIG_HTC_PASIC3=m
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=m
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=m
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=m
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
# CONFIG_AB3100_OTP is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=y
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_VX855=m
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ANATOP=m
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_AB3100 is not set
CONFIG_REGULATOR_BD718XX=m
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9063=m
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
# CONFIG_REGULATOR_HI6421V530 is not set
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=y
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=m
CONFIG_REGULATOR_MAX8649=m
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_SY8106A=m
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65090 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8400=m
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_CEC_CORE=m
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
CONFIG_IR_HIX5HD2=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_GPIO_CIR is not set
CONFIG_IR_GPIO_TX=m
CONFIG_IR_PWM_TX=m
CONFIG_IR_SERIAL=m
# CONFIG_IR_SERIAL_TRANSMITTER is not set
# CONFIG_IR_SIR is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CEC_RC is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_PCI_SKELETON=y
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_IVTV is not set
CONFIG_VIDEO_HEXIUM_GEMINI=y
# CONFIG_VIDEO_HEXIUM_ORION is not set
CONFIG_VIDEO_MXB=m
CONFIG_VIDEO_DT3155=m

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
# CONFIG_VIDEO_CX88_BLACKBIRD is not set
# CONFIG_VIDEO_SAA7134 is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CAFE_CCIC=y
# CONFIG_VIDEO_VIA_CAMERA is not set
# CONFIG_VIDEO_CADENCE is not set
CONFIG_SOC_CAMERA=m
CONFIG_SOC_CAMERA_PLATFORM=m
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
# CONFIG_VIDEO_SH_VEU is not set
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_CEC_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CROS_EC_CEC is not set
# CONFIG_CEC_GPIO is not set
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_VIDEO_TVEEPROM=m
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_WM8775=m

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_BT819=y
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#

#
# Video encoders
#
CONFIG_VIDEO_ADV7170=m

#
# Camera sensor devices
#
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_MT9M111=m

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
CONFIG_SOC_CAMERA_MT9M001=m
CONFIG_SOC_CAMERA_MT9M111=m
# CONFIG_SOC_CAMERA_MT9T112 is not set
CONFIG_SOC_CAMERA_MT9V022=m
CONFIG_SOC_CAMERA_OV5642=m
# CONFIG_SOC_CAMERA_OV772X is not set
CONFIG_SOC_CAMERA_OV9640=m
CONFIG_SOC_CAMERA_OV9740=m
# CONFIG_SOC_CAMERA_RJ54N1 is not set
# CONFIG_SOC_CAMERA_TW9910 is not set
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
CONFIG_AGP=m
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=m
# CONFIG_AGP_SIS is not set
CONFIG_AGP_VIA=m
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_I2C_NXP_TDA9950=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=m
# CONFIG_DRM_AMDGPU_SI is not set
CONFIG_DRM_AMDGPU_CIK=y
# CONFIG_DRM_AMDGPU_USERPTR is not set
# CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_AMD_ACP is not set

#
# Display Engine Configuration
#
# CONFIG_DRM_AMD_DC is not set

#
# AMD Library routines
#
CONFIG_CHASH=m
# CONFIG_CHASH_STATS is not set
# CONFIG_CHASH_SELFTEST is not set
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
CONFIG_NOUVEAU_DEBUG_MMU=y
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_ALPHA_SUPPORT=y
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set
CONFIG_DRM_I915_GVT=y
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
# CONFIG_DRM_GMA3600 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_SIMPLE=m
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_DUMB_VGA_DAC=m
CONFIG_DRM_LVDS_ENCODER=m
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
# CONFIG_DRM_NXP_PTN3460 is not set
CONFIG_DRM_PARADE_PS8622=m
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
CONFIG_DRM_THINE_THC63LVD1024=m
CONFIG_DRM_TOSHIBA_TC358767=m
CONFIG_DRM_TI_TFP410=m
CONFIG_DRM_I2C_ADV7511=m
# CONFIG_DRM_I2C_ADV7533 is not set
# CONFIG_DRM_I2C_ADV7511_CEC is not set
CONFIG_HSA_AMD=m
CONFIG_DRM_ARCPGU=m
CONFIG_DRM_HISI_HIBMC=m
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_TINYDRM=m
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=m
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=m
# CONFIG_FB_CYBER2000_DDC is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
# CONFIG_FB_I740 is not set
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G=y
# CONFIG_FB_MATROX_I2C is not set
CONFIG_FB_RADEON=m
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=m
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=m
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=m
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_SM501 is not set
CONFIG_FB_IBM_GXT4500=m
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
CONFIG_FB_SSD1307=m
CONFIG_FB_SM712=m
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_CARILLO_RANCH=m
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_MAX8925=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_AAT2870=y
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
CONFIG_HID_COUGAR=m
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=m
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=y

#
# I2C HID support
#
CONFIG_I2C_HID=y

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
CONFIG_MMC_SDHCI_OF_ARASAN=m
CONFIG_MMC_SDHCI_OF_AT91=m
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
# CONFIG_MMC_SDHCI_CADENCE is not set
CONFIG_MMC_SDHCI_F_SDH30=m
CONFIG_MMC_WBSD=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MMC_SDHCI_OMAP is not set
CONFIG_MEMSTICK=m
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=m
# CONFIG_MEMSTICK_REALTEK_PCI is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=y
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8860=m
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=m
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_DW_AXI_DMAC=y
# CONFIG_FSL_EDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
CONFIG_COMEDI_TEST=m
# CONFIG_COMEDI_PARPORT is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=m
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=m
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
# CONFIG_COMEDI_ADDI_APCI_1516 is not set
# CONFIG_COMEDI_ADDI_APCI_1564 is not set
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
CONFIG_COMEDI_ADDI_APCI_3120=m
CONFIG_COMEDI_ADDI_APCI_3501=m
CONFIG_COMEDI_ADDI_APCI_3XXX=m
CONFIG_COMEDI_ADL_PCI6208=m
CONFIG_COMEDI_ADL_PCI7X3X=m
# CONFIG_COMEDI_ADL_PCI8164 is not set
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
# CONFIG_COMEDI_ADV_PCI1710 is not set
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
# CONFIG_COMEDI_ADV_PCI1724 is not set
CONFIG_COMEDI_ADV_PCI1760=m
CONFIG_COMEDI_ADV_PCI_DIO=m
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
# CONFIG_COMEDI_AMPLC_PC236_PCI is not set
CONFIG_COMEDI_AMPLC_PC263_PCI=m
# CONFIG_COMEDI_AMPLC_PCI224 is not set
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=m
# CONFIG_COMEDI_DAS08_PCI is not set
CONFIG_COMEDI_DT3000=m
# CONFIG_COMEDI_DYNA_PCI10XX is not set
CONFIG_COMEDI_GSC_HPDI=m
CONFIG_COMEDI_MF6X4=m
# CONFIG_COMEDI_ICP_MULTI is not set
CONFIG_COMEDI_DAQBOARD2000=m
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
CONFIG_COMEDI_CB_PCIDAS=m
# CONFIG_COMEDI_CB_PCIDDA is not set
CONFIG_COMEDI_CB_PCIMDAS=m
CONFIG_COMEDI_CB_PCIMDDA=m
# CONFIG_COMEDI_ME4000 is not set
CONFIG_COMEDI_ME_DAQ=m
# CONFIG_COMEDI_NI_6527 is not set
CONFIG_COMEDI_NI_65XX=m
CONFIG_COMEDI_NI_660X=m
CONFIG_COMEDI_NI_670X=m
CONFIG_COMEDI_NI_LABPC_PCI=m
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=m
CONFIG_COMEDI_RTD520=m
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_TIO=m
# CONFIG_RTLLIB is not set
CONFIG_RTS5208=y

#
# IIO staging drivers
#

#
# Accelerometers
#

#
# Analog to digital converters
#
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7152 is not set
# CONFIG_AD7746 is not set

#
# Direct Digital Synthesis
#

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set

#
# Resolver to digital converters
#
CONFIG_FB_SM750=m
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_SPEAKUP=y
CONFIG_SPEAKUP_SYNTH_ACNTSA=m
CONFIG_SPEAKUP_SYNTH_APOLLO=m
CONFIG_SPEAKUP_SYNTH_AUDPTR=y
CONFIG_SPEAKUP_SYNTH_BNS=m
# CONFIG_SPEAKUP_SYNTH_DECTLK is not set
CONFIG_SPEAKUP_SYNTH_DECEXT=m
# CONFIG_SPEAKUP_SYNTH_LTLK is not set
CONFIG_SPEAKUP_SYNTH_SOFT=m
CONFIG_SPEAKUP_SYNTH_SPKOUT=y
CONFIG_SPEAKUP_SYNTH_TXPRT=y
CONFIG_SPEAKUP_SYNTH_DUMMY=m
CONFIG_STAGING_MEDIA=y
CONFIG_SOC_CAMERA_IMX074=m
# CONFIG_SOC_CAMERA_MT9T031 is not set
CONFIG_VIDEO_ZORAN=y
# CONFIG_VIDEO_ZORAN_DC30 is not set
CONFIG_VIDEO_ZORAN_ZR36060=y
# CONFIG_VIDEO_ZORAN_BUZ is not set
# CONFIG_VIDEO_ZORAN_DC10 is not set
CONFIG_VIDEO_ZORAN_LML33=y
CONFIG_VIDEO_ZORAN_LML33R10=m
# CONFIG_VIDEO_ZORAN_AVS6EYES is not set

#
# Android
#
CONFIG_ASHMEM=y
# CONFIG_ION is not set
CONFIG_STAGING_BOARD=y
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=y
# CONFIG_UNISYSSPAR is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
CONFIG_GREYBUS=m
CONFIG_GREYBUS_BOOTROM=m
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=m
# CONFIG_GREYBUS_LOOPBACK is not set
CONFIG_GREYBUS_POWER=m
# CONFIG_GREYBUS_RAW is not set
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
# CONFIG_GREYBUS_PWM is not set
CONFIG_GREYBUS_SDIO=m
# CONFIG_GREYBUS_UART is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_MTK_MMC=m
# CONFIG_MTK_AEE_KDUMP is not set
# CONFIG_MTK_MMC_CD_POLL is not set

#
# Gasket devices
#
CONFIG_STAGING_GASKET_FRAMEWORK=y
CONFIG_STAGING_APEX_DRIVER=m
CONFIG_XIL_AXIS_FIFO=y
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
# CONFIG_EROFS_FS_XATTR is not set
# CONFIG_EROFS_FS_USE_VM_MAP_RAM is not set
CONFIG_EROFS_FAULT_INJECTION=y
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
# CONFIG_EROFS_FS_ZIP_NO_CACHE is not set
# CONFIG_EROFS_FS_ZIP_CACHE_UNIPOLAR is not set
CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR=y
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WMI is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_MXM_WMI=m
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_TOUCHSCREEN_DMI is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC_CTL=y
CONFIG_CROS_EC_I2C=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=m
CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_RK808=m
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CDCE925=m
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_PALMAS=m
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_MAILBOX_TEST=m
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_DEBUGFS=y
# CONFIG_AMD_IOMMU is not set

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
CONFIG_RPMSG_VIRTIO=m
# CONFIG_SOUNDWIRE is not set

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
CONFIG_XILINX_VCU=m
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=m
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
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
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
# CONFIG_BMA180 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
# CONFIG_DA311 is not set
CONFIG_DMARD06=m
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_KXSD9=y
# CONFIG_KXSD9_I2C is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
CONFIG_MXC4005=m
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=m

#
# Analog to digital converters
#
CONFIG_AD7291=y
CONFIG_AD799X=m
CONFIG_CC10001_ADC=m
# CONFIG_DA9150_GPADC is not set
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_HX711 is not set
CONFIG_INA2XX_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=y
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
CONFIG_SD_ADC_MODULATOR=m
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_AM335X_ADC=m
# CONFIG_VF610_ADC is not set

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_BME680=m
CONFIG_BME680_I2C=m
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
CONFIG_VZ89X=m
# CONFIG_IIO_CROS_EC_SENSORS_CORE is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5446=m
# CONFIG_AD5593R is not set
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_M62332=y
CONFIG_MAX517=m
CONFIG_MAX5821=m
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=y
CONFIG_VF610_DAC=y

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=m
CONFIG_CM3232=m
# CONFIG_CM3323 is not set
CONFIG_CM3605=m
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
# CONFIG_HID_SENSOR_PROX is not set
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=y
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=m
CONFIG_MAX44000=y
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
CONFIG_SI1133=m
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=y
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=m
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
# CONFIG_VCNL4000 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
CONFIG_AK09911=m
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set

#
# Multiplexers
#
CONFIG_IIO_MUX=m

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
CONFIG_MCP4018=m
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=m

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
CONFIG_MS5611_I2C=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=m
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX9500=y
CONFIG_SRF08=m

#
# Resolver to digital converters
#

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=y
CONFIG_MLX90632=m
CONFIG_TMP006=m
CONFIG_TMP007=m
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_NTB is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=m
CONFIG_VME_TSI148=y
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
CONFIG_VME_USER=y
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_FSL_FTM=m
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_STMPE is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=m
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=m
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
# CONFIG_ND_BLK is not set
CONFIG_ND_CLAIM=y
CONFIG_BTT=y
# CONFIG_OF_PMEM is not set
CONFIG_DAX=m
CONFIG_NVMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_OF_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
CONFIG_FPGA_DFL_FME_MGR=m
CONFIG_FPGA_DFL_FME_BRIDGE=m
CONFIG_FPGA_DFL_FME_REGION=m
CONFIG_FPGA_DFL_AFU=m
CONFIG_FPGA_DFL_PCI=m
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=m
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=m
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QFMT_V1=m
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_XINO_AUTO=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_FSCACHE_OBJECT_LIST=y
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
CONFIG_CACHEFILES_HISTOGRAM=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
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
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
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
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=m
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
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
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_AEGIS128=m
# CONFIG_CRYPTO_AEGIS128L is not set
CONFIG_CRYPTO_AEGIS256=m
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=m
CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2=y
CONFIG_CRYPTO_AEGIS256_AESNI_SSE2=y
CONFIG_CRYPTO_MORUS640=y
CONFIG_CRYPTO_MORUS640_GLUE=y
CONFIG_CRYPTO_MORUS640_SSE2=y
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_MORUS1280_GLUE=y
CONFIG_CRYPTO_MORUS1280_SSE2=m
CONFIG_CRYPTO_MORUS1280_AVX2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=m
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA1_MB=m
CONFIG_CRYPTO_SHA256_MB=y
CONFIG_CRYPTO_SHA512_MB=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SPECK is not set
CONFIG_CRYPTO_TEA=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=m
CONFIG_FONT_SUPPORT=m
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m
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
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_MEMORY_NOTIFIER_ERROR_INJECT is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_KASAN=y
# CONFIG_KASAN_EXTRA is not set
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_TEST_KASAN=m
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

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
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
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
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_TEST_LIST_SORT=m
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=m
CONFIG_TEST_HEXDUMP=y
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_OVERFLOW is not set
CONFIG_TEST_RHASHTABLE=m
# CONFIG_TEST_HASH is not set
CONFIG_TEST_IDA=y
CONFIG_TEST_LKM=m
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
CONFIG_FIND_BIT_BENCHMARK=y
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
CONFIG_TEST_UDELAY=y
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_TEST_UBSAN=m
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
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
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set

--2l43pqSnz0CmKuGJ--
