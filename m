Return-Path: <fengguang.wu@intel.com>
Date: Tue, 27 Jun 2017 11:53:01 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
	LKP <lkp@01.org>
Subject: [block] 044f1daaaa kernel BUG at block/blk-mq.c:415!
Message-ID: <20170627035301.j4slju6w4hah76tt@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lhc3ud5z6dp2jetq"
List-ID: <linux-block@vger.kernel.org>


--lhc3ud5z6dp2jetq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

Sorry the report is a bit late, this bug looks still active:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 044f1daaaaf7c86bc4fcf433848b7baae236946b
Merge: d557d1b58b354 daaadb3e9453a
Author:     Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate: Sat May 6 11:25:08 2017 -0700
Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Sat May 6 11:25:08 2017 -0700

     Merge branch 'for-linus' of git://git.kernel.dk/linux-block
     
     Pull block fixes and updates from Jens Axboe:
      "Some fixes and followup features/changes that should go in, in this
       merge window. This contains:
     
        - Two fixes for lightnvm from Javier, fixing problems in the new code
          merge previously in this merge window.
     
        - A fix from Jan for the backing device changes, fixing an issue in
          NFS that causes a failure to mount on certain setups.
     
        - A change from Christoph, cleaning up the blk-mq init and exit
          request paths.
     
        - Remove elevator_change(), which is now unused. From Bart.
     
        - A fix for queue operation invocation on a dead queue, from Bart.
     
        - A series fixing up mtip32xx for blk-mq scheduling, removing a
          bandaid we previously had in place for this. From me.
     
        - A regression fix for this series, fixing a case where we wait on
          workqueue flushing from an invalid (non-blocking) context. From me.
     
        - A fix/optimization from Ming, ensuring that we don't both quiesce
          and freeze a queue at the same time.
     
        - A fix from Peter on lock ordering for CPU hotplug. Not a real
          problem right now, but will be once the CPU hotplug rework goes in.
     
        - A series from Omar, cleaning up out blk-mq debugfs support, and
          adding support for exporting info from schedulers in debugfs as
          well. This is really useful in debugging stalls or livelocks. From
          Omar"
     
     * 'for-linus' of git://git.kernel.dk/linux-block: (28 commits)
       mq-deadline: add debugfs attributes
       kyber: add debugfs attributes
       blk-mq-debugfs: allow schedulers to register debugfs attributes
       blk-mq: untangle debugfs and sysfs
       blk-mq: move debugfs declarations to a separate header file
       blk-mq: Do not invoke queue operations on a dead queue
       blk-mq-debugfs: get rid of a bunch of boilerplate
       blk-mq-debugfs: rename hw queue directories from <n> to hctx<n>
       blk-mq-debugfs: don't open code strstrip()
       blk-mq-debugfs: error on long write to queue "state" file
       blk-mq-debugfs: clean up flag definitions
       blk-mq-debugfs: separate flags with |
       nfs: Fix bdi handling for cloned superblocks
       block/mq: Cure cpu hotplug lock inversion
       lightnvm: fix bad back free on error path
       lightnvm: create cmd before allocating request
       blk-mq: don't use sync workqueue flushing from drivers
       mtip32xx: convert internal commands to regular block infrastructure
       mtip32xx: cleanup internal tag assumptions
       block: don't call blk_mq_quiesce_queue() after queue is frozen
       ...

d557d1b58b  refcount: change EXPORT_SYMBOL markings
daaadb3e94  mq-deadline: add debugfs attributes
044f1daaaa  Merge branch 'for-linus' of git://git.kernel.dk/linux-block
8d829b9bb8  Merge branch 'for-linus' of git://git.kernel.dk/linux-block
09c1728473  Add linux-next specific files for 20170622
+------------------------------------------------+------------+------------+------------+------------+---------------+
|                                                | d557d1b58b | daaadb3e94 | 044f1daaaa | 8d829b9bb8 | next-20170622 |
+------------------------------------------------+------------+------------+------------+------------+---------------+
| boot_successes                                 | 914        | 0          | 306        | 314        | 123           |
| boot_failures                                  | 0          | 1224       | 8          | 4          | 6             |
| BUG:unable_to_handle_kernel                    | 0          | 1224       |            |            |               |
| Oops:#[##]                                     | 0          | 1224       |            |            |               |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 1224       | 8          | 4          | 1             |
| kernel_BUG_at_block/blk-mq.c                   | 0          | 0          | 7          | 4          | 1             |
| invalid_opcode:#[##]                           | 0          | 0          | 8          | 4          | 1             |
| kernel_BUG_at_block/elevator.c                 | 0          | 0          | 1          |            |               |
| is_trying_to_release_lock(rcu_preempt_state)at | 0          | 0          | 0          | 0          | 5             |
+------------------------------------------------+------------+------------+------------+------------+---------------+

[   36.037364]   sector 2, nr/cnr 0/2
[   36.037367]   bio ffff88001af84e80, biotail ffff88001af84e80, len 0
[   36.037367]   bio ffff88001af84e80, biotail ffff88001af84e80, len 0
[   36.037424] ------------[ cut here ]------------
[   36.037424] ------------[ cut here ]------------
[   36.037428] kernel BUG at block/blk-mq.c:415!
[   36.037428] kernel BUG at block/blk-mq.c:415!
[   36.037433] invalid opcode: 0000 [#1] PREEMPT SMP
[   36.037433] invalid opcode: 0000 [#1] PREEMPT SMP
[   36.037434] Modules linked in:
[   36.037434] Modules linked in:
[   36.037441] CPU: 0 PID: 178 Comm: kworker/0:1H Not tainted 4.11.0-10534-g044f1da #1
[   36.037441] CPU: 0 PID: 178 Comm: kworker/0:1H Not tainted 4.11.0-10534-g044f1da #1
[   36.037448] Workqueue: kblockd blk_mq_run_work_fn
[   36.037448] Workqueue: kblockd blk_mq_run_work_fn
[   36.037452] task: ffff88001abb8000 task.stack: ffffc90000388000
[   36.037452] task: ffff88001abb8000 task.stack: ffffc90000388000
[   36.037457] RIP: 0010:blk_mq_end_request+0x97/0xb0
[   36.037457] RIP: 0010:blk_mq_end_request+0x97/0xb0
[   36.037460] RSP: 0018:ffffc9000038bce8 EFLAGS: 00010297
[   36.037460] RSP: 0018:ffffc9000038bce8 EFLAGS: 00010297
[   36.037464] RAX: ffff88001abb8000 RBX: ffff88001df0b980 RCX: 0000000000000400
[   36.037464] RAX: ffff88001abb8000 RBX: ffff88001df0b980 RCX: 0000000000000400
[   36.037467] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000400
[   36.037467] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000400
[   36.037470] RBP: ffffc9000038bcf8 R08: 0000000000000000 R09: 0000000000000000
[   36.037470] RBP: ffffc9000038bcf8 R08: 0000000000000000 R09: 0000000000000000
[   36.037473] R10: 0000000000000001 R11: 0000000072f531ca R12: 00000000fffffffb
[   36.037473] R10: 0000000000000001 R11: 0000000072f531ca R12: 00000000fffffffb
[   36.037476] R13: ffffc9000038bd80 R14: ffff88001a847008 R15: ffff88001a8482d8
[   36.037476] R13: ffffc9000038bd80 R14: ffff88001a847008 R15: ffff88001a8482d8
[   36.037481] FS:  0000000000000000(0000) GS:ffff88001fa00000(0000) knlGS:0000000000000000
[   36.037481] FS:  0000000000000000(0000) GS:ffff88001fa00000(0000) knlGS:0000000000000000
[   36.037484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.037484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.037487] CR2: 00007f414771adb0 CR3: 000000001ae45000 CR4: 00000000000006b0
[   36.037487] CR2: 00007f414771adb0 CR3: 000000001ae45000 CR4: 00000000000006b0
[   36.037491] Call Trace:
[   36.037491] Call Trace:
[   36.037497]  blk_mq_dispatch_rq_list+0x427/0x520
[   36.037497]  blk_mq_dispatch_rq_list+0x427/0x520
[   36.037505]  blk_mq_sched_dispatch_requests+0x160/0x1e0
[   36.037505]  blk_mq_sched_dispatch_requests+0x160/0x1e0
[   36.037510]  __blk_mq_run_hw_queue+0x1a0/0x2a0
[   36.037510]  __blk_mq_run_hw_queue+0x1a0/0x2a0
[   36.037515]  ? __blk_mq_run_hw_queue+0x168/0x2a0
[   36.037515]  ? __blk_mq_run_hw_queue+0x168/0x2a0
[   36.037519]  blk_mq_run_work_fn+0x3f/0x50
[   36.037519]  blk_mq_run_work_fn+0x3f/0x50
[   36.037525]  process_one_work+0x20f/0x4b0
[   36.037525]  process_one_work+0x20f/0x4b0
[   36.037529]  ? process_one_work+0x19c/0x4b0
[   36.037529]  ? process_one_work+0x19c/0x4b0
[   36.037535]  worker_thread+0x53/0x4d0
[   36.037535]  worker_thread+0x53/0x4d0
[   36.037541]  kthread+0x12b/0x170
[   36.037541]  kthread+0x12b/0x170
[   36.037545]  ? process_one_work+0x4b0/0x4b0
[   36.037545]  ? process_one_work+0x4b0/0x4b0
[   36.037550]  ? kthread_create_on_node+0x70/0x70
[   36.037550]  ? kthread_create_on_node+0x70/0x70
[   36.037557]  ret_from_fork+0x31/0x40
[   36.037557]  ret_from_fork+0x31/0x40
[   36.037560] Code: 38 ca ff 4c 8b a3 40 01 00 00 4d 85 e4 75 1e e8 c0 38 ca ff 48 89 df e8 e8 6d 00 00 e8 b3 38 ca ff 5b 41 5c 5d c3 e8 a9 38 ca ff <0f> 0b e8 a2 38 ca ff 4c 89 e7 e8 ca 6d 00 00 eb d3 0f 1f 84 00 
[   36.037560] Code: 38 ca ff 4c 8b a3 40 01 00 00 4d 85 e4 75 1e e8 c0 38 ca ff 48 89 df e8 e8 6d 00 00 e8 b3 38 ca ff 5b 41 5c 5d c3 e8 a9 38 ca ff <0f> 0b e8 a2 38 ca ff 4c 89 e7 e8 ca 6d 00 00 eb d3 0f 1f 84 00 
[   36.037643] RIP: blk_mq_end_request+0x97/0xb0 RSP: ffffc9000038bce8
[   36.037643] RIP: blk_mq_end_request+0x97/0xb0 RSP: ffffc9000038bce8
[   36.037646] ---[ end trace 411e8acef3348c6b ]---
[   36.037646] ---[ end trace 411e8acef3348c6b ]---

                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 41f1830f5a7af77cf5c86359aba3cbd706687e52 v4.11 --
git bisect  bad 1be627dfa74d9eee1eca1bc48653e461366a2bb9  # 11:48  B     62     2    0   0  Merge tag 'staging-4.12-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect  bad ec059019b7e6ae3926a8e1dec02a62d64dd8c060  # 12:09  B     20     1    0   0  Merge branch 'for-linus-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml
git bisect  bad 6b402bdfdbafce241cb6789ae38d94f45641078c  # 12:37  B     51     1    0   0  Merge tag 'for-v4.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
git bisect good ab182e67ec99ea0c8d7435a32a4a1ed9bb02559a  # 13:28  G    208     0    0   0  Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect  bad 28b47809b2171a6cfbab839936b24280639c9f85  # 13:39  B      0     1   13   0  Merge tag 'iommu-updates-v4.12' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
git bisect  bad 70ef8f0d37573079e093305214d0cc9eb71100f7  # 14:05  B     53     1    0   0  Merge tag 'for-f2fs-4.12' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
git bisect  bad 677375cef8cb7763ef620e007873117b9bad72a0  # 14:47  B     98     1    0   0  Merge tag 'fscrypt_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/fscrypt
git bisect  bad 13e0988140374123bead1dd27c287354cb95108e  # 15:34  B    165     1    0   0  docs: complete bumping minimal GNU Make version to 3.81
git bisect  bad fe7a719b30dfdb4d55680461954b99b257ebe671  # 16:03  B     49     1    0   0  Merge branch 'for-next' of git://git.samba.org/sfrench/cifs-2.6
git bisect  bad d484467c860dab3e17893d23b2238e1f581460fa  # 16:25  B      8     1    0   0  Merge tag 'xfs-4.12-merge-7' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect good d557d1b58b3546bab2c5bc2d624c5709840e6b10  # 17:43  G    310     0    0   0  refcount: change EXPORT_SYMBOL markings
git bisect  bad 044f1daaaaf7c86bc4fcf433848b7baae236946b  # 17:53  B      0     1   13   0  Merge branch 'for-linus' of git://git.kernel.dk/linux-block
git bisect good 507f7d68fe5c24973dcd6e48f011bdfbd2197f01  # 19:00  G    310     0  310 314  lightnvm: fix bad back free on error path
git bisect good 88aabbd7e7ace77fb3fbf06d22dd3cc0bfc0ca79  # 19:46  G    310     0  310 314  blk-mq-debugfs: rename hw queue directories from <n> to hctx<n>
git bisect good 9c1051aacde828073dbbab5e8e59c0fc802efa9a  # 20:29  G    308     0  308 312  blk-mq: untangle debugfs and sysfs
git bisect good 16b738f651c83a01db057e5db02ec4b830af9130  # 21:30  G    310     0  310 314  kyber: add debugfs attributes
git bisect good daaadb3e9453ab89c2e113a2d1df8e19e30944cc  # 22:22  G    302     0  302 306  mq-deadline: add debugfs attributes
# first bad commit: [044f1daaaaf7c86bc4fcf433848b7baae236946b] Merge branch 'for-linus' of git://git.kernel.dk/linux-block
git bisect good d557d1b58b3546bab2c5bc2d624c5709840e6b10  # 23:18  G    910     0    0   0  refcount: change EXPORT_SYMBOL markings
git bisect good daaadb3e9453ab89c2e113a2d1df8e19e30944cc  # 01:30  G    907     0  907 1221  mq-deadline: add debugfs attributes
# extra tests with CONFIG_DEBUG_INFO_REDUCED
git bisect  bad 044f1daaaaf7c86bc4fcf433848b7baae236946b  # 01:47  B     16     1    0   0  Merge branch 'for-linus' of git://git.kernel.dk/linux-block
# extra tests on HEAD of linux-devel/devel-spot-201706220724
git bisect  bad 7d64799d1536df3eef4ba6cc7cb2258a1943f637  # 01:47  B     43     2    0   2  0day head guard for 'devel-spot-201706220724'
# extra tests on tree/branch linus/master
git bisect  bad 8d829b9bb878904f3419af8003176a12910b94e8  # 02:24  B     85     1    0   0  Merge branch 'for-linus' of git://git.kernel.dk/linux-block
# extra tests on tree/branch linux-next/master
git bisect  bad 09c17284731e42dbe4c6d334603e9c05ba1219ae  # 02:51  B     57     1    0   1  Add linux-next specific files for 20170622

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--lhc3ud5z6dp2jetq
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-intel12-10:20170622183735:x86_64-randconfig-n0-06220832:4.11.0-10534-g044f1da:1.gz"
Content-Transfer-Encoding: base64

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
u5rqgddR0xOw2Qc5RPqp6BwCAA==

--lhc3ud5z6dp2jetq
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-vm-lkp-nhm-dp2-yocto-ia32-3:20170622214347:x86_64-randconfig-n0-06220832:4.11.0-00403-gdaaadb3:1.gz"
Content-Transfer-Encoding: base64

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
tOXo3aymFxDscvrT9U/0uPq/QtI+QTJkAQA=

--lhc3ud5z6dp2jetq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-intel12-10:20170622183735:x86_64-randconfig-n0-06220832:4.11.0-10534-g044f1da:1"

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

--lhc3ud5z6dp2jetq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.11.0-10534-g044f1da"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.11.0 Kernel Configuration
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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
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
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_DEBUG=y
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
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
# CONFIG_NO_HZ_FULL_ALL is not set
CONFIG_NO_HZ_FULL_SYSIDLE=y
CONFIG_NO_HZ_FULL_SYSIDLE_SMALL=8
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FAST_NO_HZ is not set
CONFIG_TREE_RCU_TRACE=y
CONFIG_RCU_BOOST=y
CONFIG_RCU_KTHREAD_PRIO=1
CONFIG_RCU_BOOST_DELAY=500
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_NONE is not set
# CONFIG_RCU_NOCB_CPU_ZERO is not set
CONFIG_RCU_NOCB_CPU_ALL=y
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
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_BLK_CGROUP=y
CONFIG_DEBUG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
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
CONFIG_INITRAMFS_COMPRESSION=".gz"
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_POSIX_TIMERS=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_BPF_SYSCALL=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_USERFAULTFD is not set
CONFIG_PCI_QUIRKS=y
CONFIG_MEMBARRIER=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
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
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_SANCOV=y
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
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
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
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
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_SQ=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
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
CONFIG_IOSCHED_CFQ=m
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
CONFIG_PADATA=y
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
# CONFIG_X86_FAST_FEATURE_TESTS is not set
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
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
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_GART_IOMMU=y
CONFIG_CALGARY_IOMMU=y
# CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS=64
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_VM86 is not set
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
# CONFIG_ACPI_HED is not set
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=m
CONFIG_ACPI_WATCHDOG=y
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set

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
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_HT_IRQ=y
CONFIG_PCI_ATS=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y

#
# PCI host controller drivers
#
# CONFIG_VMD is not set
CONFIG_ISA_BUS=y
# CONFIG_ISA_DMA_API is not set
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
CONFIG_RAPIDIO_CPS_XX=m
# CONFIG_RAPIDIO_TSI568 is not set
CONFIG_RAPIDIO_CPS_GEN2=m
CONFIG_RAPIDIO_RXS_GEN3=y
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=m
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_KEYS_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_NET_KEY is not set
# CONFIG_INET is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_ATM is not set
CONFIG_MRP=m
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=m
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=m
CONFIG_LAPB=y
CONFIG_PHONET=m
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
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
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
# CONFIG_AX25 is not set
# CONFIG_CAN is not set
CONFIG_IRDA=m

#
# IrDA protocols
#
# CONFIG_IRLAN is not set
# CONFIG_IRCOMM is not set
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
# CONFIG_IRDA_CACHE_LAST_LSAP is not set
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
# CONFIG_IRTTY_SIR is not set

#
# Dongle support
#
# CONFIG_KINGSUN_DONGLE is not set
CONFIG_KSDAZZLE_DONGLE=m
# CONFIG_KS959_DONGLE is not set

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
CONFIG_SIGMATEL_FIR=m
# CONFIG_VLSI_FIR is not set
# CONFIG_MCS_FIR is not set
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
# CONFIG_BT_LEDS is not set
CONFIG_BT_SELFTEST=y
# CONFIG_BT_SELFTEST_ECDH is not set
CONFIG_BT_SELFTEST_SMP=y
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=y
# CONFIG_BT_MRVL is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=m
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
# CONFIG_CAIF_NETDEV is not set
CONFIG_CAIF_USB=y
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
CONFIG_NFC_NCI=y
# CONFIG_NFC_NCI_UART is not set
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_MEI_PHY is not set
CONFIG_NFC_SIM=m
# CONFIG_NFC_PORT100 is not set
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN544_I2C is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MICROREAD_I2C is not set
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
CONFIG_NFC_MRVL_I2C=m
CONFIG_NFC_ST21NFCA=y
CONFIG_NFC_ST21NFCA_I2C=y
# CONFIG_NFC_ST_NCI_I2C is not set
CONFIG_NFC_NXP_NCI=y
# CONFIG_NFC_NXP_NCI_I2C is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
# CONFIG_DST_CACHE is not set
# CONFIG_GRO_CELLS is not set
CONFIG_NET_DEVLINK=y
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
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
CONFIG_BLK_CPQ_CISS_DA=y
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_UMEM=m
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set

#
# DRBD disabled because PROC_FS or INET not selected
#
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_SKD=y
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_RAM_DAX=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RSXX is not set
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
# CONFIG_BLK_DEV_NVME_SCSI is not set
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_FC=y

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_VMWARE_BALLOON is not set
CONFIG_USB_SWITCH_FSA9480=m
# CONFIG_SRAM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m

#
# Altera FPGA firmware download module
#
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=y

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=m

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
CONFIG_ECHO=m
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
CONFIG_IDE_GD=y
# CONFIG_IDE_GD_ATA is not set
CONFIG_IDE_GD_ATAPI=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_DELKIN=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
CONFIG_BLK_DEV_IDETAPE=m
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPNP=m
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=m
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_JMICRON=m
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IT8172=m
CONFIG_BLK_DEV_IT8213=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=m
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_TC86C001=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_MQ_DEFAULT=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_BNX2_ISCSI is not set
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
# CONFIG_SCSI_3W_9XXX is not set
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
CONFIG_SCSI_DPT_I2O=m
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
CONFIG_SCSI_ESAS2R=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
CONFIG_SCSI_UFS_DWC_TC_PCI=m
CONFIG_SCSI_UFSHCD_PLATFORM=m
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_SCSI_HPTIOP=m
CONFIG_VMWARE_PVSCSI=m
CONFIG_SCSI_SNIC=m
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_FUTURE_DOMAIN=m
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_ISCSI=m
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_WD719X=m
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=m
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
# CONFIG_PCMCIA_AHA152X is not set
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_QLOGIC=m
# CONFIG_PCMCIA_SYM53C500 is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=m
# CONFIG_SCSI_OSD_ULD is not set
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=m
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_SBP2 is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
# CONFIG_NETDEVICES is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
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
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=m
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_DB9=m
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=m
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_WALKERA0701 is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=m
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_BMA150=m
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=y
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_TILT_POLLED=m
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=m
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=m
CONFIG_INPUT_KXTJ9_POLLED_MODE=y
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
# CONFIG_INPUT_RETU_PWRBUTTON is not set
CONFIG_INPUT_TPS65218_PWRBUTTON=m
# CONFIG_INPUT_AXP20X_PEK is not set
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=y
CONFIG_INPUT_TWL6040_VIBRA=y
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF50633_PMU=m
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA9055_ONKEY=m
# CONFIG_INPUT_DA9063_ONKEY is not set
# CONFIG_INPUT_WM831X_ON is not set
CONFIG_INPUT_ADXL34X=y
# CONFIG_INPUT_ADXL34X_I2C is not set
CONFIG_INPUT_IMS_PCU=m
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=m
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_FM801=y

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
# CONFIG_TRACE_SINK is not set
# CONFIG_GOLDFISH_TTY is not set
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
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
CONFIG_APPLICOM=m

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=m
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=m
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=m
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TELCLOCK=m
# CONFIG_DEVPORT is not set
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=m
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
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=y
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=m
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
# CONFIG_I2C_DLN2 is not set
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=m
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=m
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m

#
# PPS support
#
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PINCTRL=y

#
# Pin controllers
#
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_AXP209=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_VX855=m

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
# CONFIG_GPIO_104_IDIO_16 is not set
# CONFIG_GPIO_104_IDI_48 is not set
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=m
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_MAX7300=m
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_SX150X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_CRYSTAL_COVE=m
CONFIG_GPIO_DA9055=m
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=m
# CONFIG_GPIO_TWL6040 is not set
# CONFIG_GPIO_WHISKEY_COVE is not set
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8350=m

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
CONFIG_GPIO_BT8XX=m
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_RDC321X=m

#
# SPI or I2C GPIO expanders
#

#
# USB GPIO expanders
#
# CONFIG_W1 is not set
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=m
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
CONFIG_TEST_POWER=y
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_DA9030=y
CONFIG_AXP288_FUEL_GAUGE=m
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=m
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=m
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=m
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
# CONFIG_AXP20X_POWER is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=m
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX20751=y
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_TPS40422=m
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=m
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_WM8350=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
CONFIG_INTEL_BXT_PMIC_THERMAL=m
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_WDAT_WDT=m
CONFIG_WM831X_WATCHDOG=m
CONFIG_WM8350_WATCHDOG=m
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=m
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
CONFIG_TWL4030_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_RETU_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=m
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=y
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=m
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=m
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
CONFIG_VIA_WDT=y
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_INTEL_MEI_WDT=m
CONFIG_NI903X_WDT=y
CONFIG_NIC7018_WDT=m
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=y
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_BXTWC=m
CONFIG_MFD_INTEL_LPSS=m
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=m
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RTSX_PCI is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AAT2870 is not set
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8997 is not set
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_QCOM_SPMI=m
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65217=m
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TWL4030=m
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8350=m
# CONFIG_REGULATOR_WM8400 is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=m
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_MM_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_ALPHA_SUPPORT=y
CONFIG_DRM_I915_CAPTURE_ERROR=y
# CONFIG_DRM_I915_COMPRESS_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set
CONFIG_DRM_I915_GVT=y

#
# drm/i915 Debugging
#
CONFIG_DRM_I915_WERROR=y
CONFIG_DRM_I915_DEBUG=y
CONFIG_DRM_I915_DEBUG_GEM=y
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
CONFIG_DRM_I915_SELFTEST=y
CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
CONFIG_DRM_VGEM=m
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
# CONFIG_DRM_HISI_HIBMC is not set
CONFIG_DRM_TINYDRM=y
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=m
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
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=m
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=y
CONFIG_FB_VESA=y
# CONFIG_FB_EFI is not set
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=m
CONFIG_FB_LE80578=y
# CONFIG_FB_CARILLO_RANCH is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=m
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SMSCUFX=m
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_BROADSHEET=y
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_CARILLO_RANCH=m
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=m
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_TPS65217=m
CONFIG_BACKLIGHT_GPIO=m
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_VGASTATE=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=m
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_ELO=m
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=y
# CONFIG_HID_HOLTEK is not set
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=m
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=m
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
CONFIG_HID_ROCCAT=m
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
# CONFIG_USB_MOUSE is not set

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
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_WHITELIST=y
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=m
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=m
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_HCD_PCI is not set
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_U132_HCD is not set
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_SL811_CS=m
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

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
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_ULPI is not set
# CONFIG_USB_DWC3_HOST is not set
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_DUAL_ROLE=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC2=m
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
CONFIG_USB_DWC2_PCI=m
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=m
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m
# CONFIG_UCSI is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
CONFIG_USB_ISP1301=y
CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=m
CONFIG_USB_GR_UDC=m
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_M66592=m
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=m
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
CONFIG_USB_GOKU=m
# CONFIG_USB_EG20T is not set
CONFIG_USB_DUMMY_HCD=m
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_U_ETHER=m
CONFIG_USB_F_NCM=m
CONFIG_USB_F_ECM=m
CONFIG_USB_F_PHONET=m
CONFIG_USB_F_RNDIS=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
CONFIG_USB_CONFIGFS_NCM=y
CONFIG_USB_CONFIGFS_ECM=y
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
CONFIG_USB_CONFIGFS_RNDIS=y
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_PHONET=y
# CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
# CONFIG_USB_CONFIGFS_F_FS is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
CONFIG_USB_CONFIGFS_F_PRINTER=y

#
# USB Power Delivery and Type-C drivers
#
CONFIG_TYPEC=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_UWB is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=m
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_ACCESSIBILITY=y
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=y
# CONFIG_EDAC_I3000 is not set
CONFIG_EDAC_I3200=y
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I5000 is not set
CONFIG_EDAC_I5100=y
CONFIG_EDAC_I7300=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_HWMON=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8997 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_PALMAS is not set
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_TPS65910=m
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_S5M=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DS1685_PROC_REGS=y
CONFIG_RTC_DS1685_SYSFS_REGS=y
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9055=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=m
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_WM831X is not set
# CONFIG_RTC_DRV_WM8350 is not set
# CONFIG_RTC_DRV_PCF50633 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_MC13XXX is not set
CONFIG_RTC_DRV_MT6397=m

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_HID_SENSOR_TIME=m
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=m

#
# Virtio drivers
#
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
CONFIG_RTS5208=m

#
# IIO staging drivers
#

#
# Accelerometers
#

#
# Analog to digital converters
#
# CONFIG_AD7606 is not set

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
# CONFIG_AD7152 is not set
CONFIG_AD7746=m

#
# Direct Digital Synthesis
#

#
# Digital gyroscope sensors
#

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Light sensors
#
CONFIG_SENSORS_ISL29028=m
CONFIG_TSL2x7x=m

#
# Active energy metering IC
#
CONFIG_ADE7854=m
# CONFIG_ADE7854_I2C is not set

#
# Resolver to digital converters
#

#
# Triggers - standalone
#
CONFIG_FB_SM750=m
CONFIG_FB_XGI=m

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y

#
# Android
#
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_GOLDFISH_AUDIO=m
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=y
CONFIG_CRYPTO_SKEIN=y
CONFIG_UNISYSSPAR=y
CONFIG_UNISYS_VISORBUS=y
# CONFIG_UNISYS_VISORNIC is not set
CONFIG_UNISYS_VISORINPUT=m
CONFIG_UNISYS_VISORHBA=m
CONFIG_MOST=y
CONFIG_MOSTCORE=y
CONFIG_AIM_CDEV=m
CONFIG_AIM_NETWORK=y
CONFIG_HDM_DIM2=y
CONFIG_HDM_I2C=y
CONFIG_HDM_USB=m
# CONFIG_GREYBUS is not set

#
# USB Power Delivery and Type-C drivers
#
CONFIG_TYPEC_TCPM=y
# CONFIG_TYPEC_TCPCI is not set
CONFIG_TYPEC_FUSB302=y
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WMI is not set
CONFIG_ACERHDF=y
CONFIG_ALIENWARE_WMI=m
CONFIG_ASUS_LAPTOP=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_LAPTOP_DEBUG=y
CONFIG_FUJITSU_TABLET=y
# CONFIG_AMILO_RFKILL is not set
# CONFIG_HP_ACCEL is not set
CONFIG_HP_WIRELESS=y
CONFIG_HP_WMI=m
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_IDEAPAD_LAPTOP is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
# CONFIG_THINKPAD_ACPI_DEBUG is not set
CONFIG_THINKPAD_ACPI_UNSAFE_LEDS=y
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_ASUS_WIRELESS=m
CONFIG_ACPI_WMI=m
CONFIG_MSI_WMI=m
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=y
CONFIG_TOSHIBA_WMI=m
CONFIG_ACPI_CMPC=y
CONFIG_INTEL_CHT_INT33FE=y
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_PMC_CORE=y
CONFIG_IBM_RTL=y
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=m
# CONFIG_PVPANIC is not set
CONFIG_INTEL_PMC_IPC=y
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
CONFIG_SURFACE_PRO3_BUTTON=m
CONFIG_INTEL_PUNIT_IPC=m
# CONFIG_INTEL_TELEMETRY is not set
CONFIG_MLX_PLATFORM=y
CONFIG_MLX_CPLD_PLATFORM=m
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_BUS=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_EC_CHARDEV is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CS2000_CP=m
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

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
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
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
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX8997=m
# CONFIG_EXTCON_PALMAS is not set
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=m
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
# CONFIG_BMA180 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=m
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=m
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=m

#
# Analog to digital converters
#
CONFIG_AD7291=m
# CONFIG_AD799X is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_LTC2485=m
CONFIG_LTC2497=m
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=m
CONFIG_MCP3422=m
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
CONFIG_QCOM_SPMI_IADC=m
# CONFIG_QCOM_SPMI_VADC is not set
CONFIG_STX104=m
CONFIG_TI_ADC081C=m
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_AM335X_ADC is not set
# CONFIG_TWL4030_MADC is not set
# CONFIG_TWL6030_GPADC is not set

#
# Amplifiers
#

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_IAQCORE=m
CONFIG_VZ89X=m
CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#
CONFIG_104_QUAD_8=m

#
# Digital to analog converters
#
CONFIG_AD5064=m
# CONFIG_AD5380 is not set
CONFIG_AD5446=m
# CONFIG_AD5593R is not set
# CONFIG_CIO_DAC is not set
CONFIG_M62332=m
CONFIG_MAX517=m
# CONFIG_MCP4725 is not set

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

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=m

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
# CONFIG_HTU21 is not set
CONFIG_SI7005=m
CONFIG_SI7020=m

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_KMX61=m
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
# CONFIG_CM3323 is not set
CONFIG_CM36651=m
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=m
CONFIG_ISL29125=m
# CONFIG_HID_SENSOR_ALS is not set
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_LTR501=m
CONFIG_MAX44000=m
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
CONFIG_SI1145=m
CONFIG_STK3310=m
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VEML6070=m
CONFIG_VL6180=m

#
# Magnetometer sensors
#
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_MAG3110=m
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
CONFIG_DS1803=m
CONFIG_MCP4531=m
CONFIG_TPL0102=m

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
# CONFIG_IIO_CROS_EC_BARO is not set
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
# CONFIG_MPL115_I2C is not set
CONFIG_MPL3115=m
CONFIG_MS5611=m
# CONFIG_MS5611_I2C is not set
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_T5403=m
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_SRF04=m
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=m
# CONFIG_MLX90614 is not set
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=m
CONFIG_NTB=m
CONFIG_NTB_AMD=m
CONFIG_NTB_INTEL=m
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STM32 is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_TI_SYSCON_RESET is not set
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
CONFIG_PHY_SAMSUNG_USB2=m
# CONFIG_PHY_EXYNOS4210_USB2 is not set
# CONFIG_PHY_EXYNOS4X12_USB2 is not set
# CONFIG_PHY_EXYNOS5250_USB2 is not set
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_TUSB1210=m
# CONFIG_POWERCAP is not set
CONFIG_MCB=m
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_THUNDERBOLT=y

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=m
# CONFIG_ND_BLK is not set
# CONFIG_BTT is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NR_DEV_DAX=32768
CONFIG_NVMEM=y
CONFIG_STM=y
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y

#
# FPGA Configuration Support
#
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=m

#
# FSI support
#
# CONFIG_FSI is not set

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=m
CONFIG_GOOGLE_COREBOOT_TABLE_ACPI=m
CONFIG_GOOGLE_MEMCONSOLE=m
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
CONFIG_GOOGLE_VPD=m

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=m
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=m
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=m
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_TEST=y
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
CONFIG_NILFS2_FS=y
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
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=y
CONFIG_HFSPLUS_FS_POSIX_ACL=y
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
CONFIG_SQUASHFS_DECOMP_MULTI=y
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
# CONFIG_SQUASHFS_LZO is not set
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=m
CONFIG_QNX6FS_FS=m
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_ZLIB_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=m
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=m
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y

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
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_MEMORY_NOTIFIER_ERROR_INJECT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
CONFIG_HAVE_ARCH_KASAN=y
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
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_REPEATEDLY=y
CONFIG_SPARSE_RCU_POINTER=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT=y
CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT_DELAY=3
# CONFIG_RCU_TORTURE_TEST_SLOW_INIT is not set
# CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
CONFIG_FAULT_INJECTION=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_LATENCYTOP=y
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

#
# Runtime Testing
#
CONFIG_LKDTM=y
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_SORT=y
CONFIG_KPROBES_SANITY_TEST=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
CONFIG_TEST_STRING_HELPERS=m
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
CONFIG_TEST_UUID=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_HASH=m
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_TEST_LKM is not set
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_UDELAY is not set
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
CONFIG_UBSAN_NULL=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_EFI=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
CONFIG_EFI_PGT_DUMP=y
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
# CONFIG_IOMMU_DEBUG is not set
CONFIG_IOMMU_STRESS=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=m
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
CONFIG_CRYPTO_AKCIPHER=m
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA1_MB=y
CONFIG_CRYPTO_SHA256_MB=y
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_X86_64 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_X86_64=y
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=m
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=m
# CONFIG_X509_CERTIFICATE_PARSER is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=m
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
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
# CONFIG_CPUMASK_OFFSTACK is not set
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
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m

--lhc3ud5z6dp2jetq--
