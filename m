Return-Path: <sploving1@gmail.com>
Return-Path: <sploving1@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Baozeng Ding <sploving1@gmail.com>
Subject: BUG: slab-out-of-bounds in bio_alloc_bioset
Message-ID: <19d79a69-cb2e-9742-dea1-4dceb9c328b9@gmail.com>
Date: Tue, 24 May 2016 23:28:05 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi all,
   I've got the following report (slab-out-of-bounds in bio_alloc_bioset) while running
syzkaller.The kernel version is 4.6.0-rc7+. (I can reproduce it with syzkaller).Thanks.

BUG: KASAN: slab-out-of-bounds in memcpy+0x1d/0x40 at addr ffff8800187a9030
Read of size 4096 by task syz-executor/27197
page:ffffea000061ea40 count:1 mapcount:0 mapping:          (null) index:0x0
flags: 0x1fffc0000000000()
page dumped because: kasan: bad access detected
CPU: 1 PID: 27197 Comm: syz-executor Not tainted 4.6.0-rc7+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
 0000000000000001 ffff8800323270b8 ffffffff82809d71 ffff880032327148
 ffff8800187a9030 ffff8800187a9030 ffff8800323275b0 ffff880032327138
 ffffffff815c504b ffff88001f004e00 ffff88001a5d7140 0000000000000286
Call Trace:
 [<     inline     >] __dump_stack /lib/dump_stack.c:15
 [<ffffffff82809d71>] dump_stack+0xb3/0x112 /lib/dump_stack.c:51
 [<     inline     >] print_address_description /mm/kasan/report.c:190
 [<ffffffff815c504b>] kasan_report_error+0x4fb/0x530 /mm/kasan/report.c:275
 [<ffffffff815beab7>] ? ___slab_alloc+0x167/0x500 /mm/slub.c:2449
 [<     inline     >] ? spin_unlock /include/linux/spinlock.h:347
 [<ffffffff815bde58>] ? deactivate_slab+0x408/0x710 /mm/slub.c:2001
 [<ffffffff815c53b4>] kasan_report+0x34/0x40 /mm/kasan/report.c:297
 [<ffffffff815c45bd>] ? memcpy+0x1d/0x40 /mm/kasan/kasan.c:318
 [<     inline     >] check_memory_region /mm/kasan/kasan.c:285
 [<ffffffff815c3ff4>] __asan_loadN+0x124/0x1a0 /mm/kasan/kasan.c:678
 [<ffffffff815c45bd>] memcpy+0x1d/0x40 /mm/kasan/kasan.c:318
 [<ffffffff8284a951>] copy_from_iter+0x581/0x960 /lib/iov_iter.c:416
 [<     inline     >] ? kasan_poison_shadow /mm/kasan/kasan.c:52
 [<ffffffff815c43c6>] ? kasan_unpoison_shadow+0x36/0x50 /mm/kasan/kasan.c:57
 [<ffffffff8284dd60>] copy_page_from_iter+0x510/0xa50 /lib/iov_iter.c:467
 [<ffffffff8275f6fa>] ? bio_alloc_bioset+0x3ca/0x7a0 /block/bio.c:512
 [<ffffffff8284d850>] ? iov_iter_fault_in_readable+0x220/0x220 /lib/iov_iter.c:313
 [<ffffffff8275bd9c>] ? bio_add_pc_page+0x3fc/0x900 /block/bio.c:798
 [<     inline     >] bio_copy_from_iter /block/bio.c:1029
 [<ffffffff82762568>] bio_copy_user_iov+0xac8/0xe10 /block/bio.c:1230
 [<ffffffff82761aa0>] ? bio_uncopy_user+0x650/0x650 /block/bio.c:1057
 [<ffffffff82847534>] ? iov_iter_advance+0x154/0x540 /lib/iov_iter.c:511
 [<     inline     >] bio_set_flag /include/linux/bio.h:305
 [<     inline     >] __blk_rq_map_user_iov /block/blk-map.c:59
 [<ffffffff82793ccb>] blk_rq_map_user_iov+0x23b/0xa80 /block/blk-map.c:125
 [<ffffffff82793a90>] ? blk_rq_append_bio+0x170/0x170 /block/blk-map.c:15
 [<ffffffff815beab7>] ? ___slab_alloc+0x167/0x500 /mm/slub.c:2449
 [<ffffffff812b45f0>] ? debug_check_no_locks_freed+0x290/0x290 /kernel/locking/lockdep.c:4212
 [<     inline     >] ? kmalloc /include/linux/slab.h:483
 [<     inline     >] ? kzalloc /include/linux/slab.h:622
 [<     inline     >] ? sg_build_sgat /drivers/scsi/sg.c:1817
 [<ffffffff8354481b>] ? sg_build_indirect.isra.18+0x8b/0x530 /drivers/scsi/sg.c:1843
 [<ffffffff82848534>] ? import_single_range+0x1d4/0x2b0 /lib/iov_iter.c:869
 [<ffffffff82794610>] blk_rq_map_user+0x100/0x170 /block/blk-map.c:154
 [<ffffffff82794510>] ? blk_rq_map_user_iov+0xa80/0xa80 /block/blk-map.c:227
 [<ffffffff815af514>] ? alloc_pages_current+0x104/0x340 /mm/mempolicy.c:2095
 [<     inline     >] sg_start_req /drivers/scsi/sg.c:1767
 [<ffffffff83547152>] sg_common_write.isra.19+0x1042/0x16d0 /drivers/scsi/sg.c:783
 [<ffffffff83546110>] ? sg_open+0x13a0/0x13a0 /drivers/scsi/sg.c:2145
 [<ffffffff8353f030>] ? sg_add_request+0x30/0x2d0 /drivers/scsi/sg.c:2058
 [<ffffffff812b407d>] ? trace_hardirqs_on+0xd/0x10 /kernel/locking/lockdep.c:2734
 [<ffffffff8353f0fb>] ? sg_add_request+0xfb/0x2d0 /drivers/scsi/sg.c:2088
 [<     inline     >] ? finish_lock_switch /kernel/sched/sched.h:1122
 [<ffffffff8123200e>] ? finish_task_switch+0x14e/0x5f0 /kernel/sched/core.c:2626
 [<ffffffff8354aeb6>] sg_write+0x606/0xa30 /drivers/scsi/sg.c:686
 [<ffffffff8354a8b0>] ? sg_ioctl+0x2990/0x2990 /drivers/scsi/sg.c:1090
 [<     inline     >] ? rcu_read_unlock /include/linux/rcupdate.h:922
 [<ffffffff812a86cd>] ? cpuacct_charge+0x1bd/0x340 /kernel/sched/cpuacct.c:245
 [<ffffffff812b45f0>] ? debug_check_no_locks_freed+0x290/0x290 /kernel/locking/lockdep.c:4212
 [<     inline     >] ? idle_balance /kernel/sched/fair.c:7505
 [<ffffffff8127c750>] ? pick_next_task_fair+0x310/0x2390 /kernel/sched/fair.c:5556
 [<     inline     >] ? rcu_read_unlock /include/linux/rcupdate.h:922
 [<     inline     >] ? idle_balance /kernel/sched/fair.c:7511
 [<ffffffff8127c86e>] ? pick_next_task_fair+0x42e/0x2390 /kernel/sched/fair.c:5556
 [<ffffffff812b45f0>] ? debug_check_no_locks_freed+0x290/0x290 /kernel/locking/lockdep.c:4212
 [<ffffffff8160eac3>] __vfs_write+0x113/0x4b0 /fs/read_write.c:529
 [<ffffffff8354a8b0>] ? sg_ioctl+0x2990/0x2990 /drivers/scsi/sg.c:1090
 [<ffffffff8160e9b0>] ? do_iter_readv_writev+0x2b0/0x2b0 /fs/read_write.c:707
 [<ffffffff812b407d>] ? trace_hardirqs_on+0xd/0x10 /kernel/locking/lockdep.c:2734
 [<     inline     >] ? pipe_lock_nested /fs/pipe.c:65
 [<     inline     >] ? pipe_lock /fs/pipe.c:73
 [<ffffffff816295a8>] ? pipe_wait+0x148/0x1a0 /fs/pipe.c:121
 [<ffffffff85b443b0>] ? mutex_lock_interruptible_nested+0x980/0x980 ??:?
 [<     inline     >] ? arch_local_irq_restore /./arch/x86/include/asm/paravirt.h:791
 [<     inline     >] ? __raw_spin_unlock_irqrestore /include/linux/spinlock_api_smp.h:162
 [<ffffffff85b4ac76>] ? _raw_spin_unlock_irqrestore+0x36/0x60 /kernel/locking/spinlock.c:191
 [<     inline     >] ? spin_unlock_irqrestore /include/linux/spinlock.h:362
 [<ffffffff812975cd>] ? finish_wait+0xfd/0x180 /kernel/sched/wait.c:253
 [<ffffffff8160ef47>] __kernel_write+0xe7/0x320 /fs/read_write.c:551
 [<ffffffff81227630>] ? __might_sleep+0x90/0x1a0 /kernel/sched/core.c:7426
 [<ffffffff816ae2b9>] write_pipe_buf+0x159/0x1e0 /fs/splice.c:1071
 [<ffffffff816ae160>] ? do_splice_direct+0x250/0x250 /fs/splice.c:1339
 [<ffffffff816aedf0>] ? splice_from_pipe_next+0x2f0/0x3c0 /fs/splice.c:818
 [<     inline     >] splice_from_pipe_feed /fs/splice.c:773
 [<ffffffff816af114>] __splice_from_pipe+0x254/0x710 /fs/splice.c:898
 [<ffffffff816ae160>] ? do_splice_direct+0x250/0x250 /fs/splice.c:1339
 [<ffffffff816b29e7>] splice_from_pipe+0xf7/0x140 /fs/splice.c:933
 [<ffffffff816ae160>] ? do_splice_direct+0x250/0x250 /fs/splice.c:1339
 [<ffffffff816b28f0>] ? splice_shrink_spd+0x60/0x60 /fs/splice.c:299
 [<ffffffff82548b29>] ? security_file_permission+0x89/0x1e0 /security/security.c:733
 [<ffffffff816b2ac0>] default_file_splice_write+0x40/0x90 /fs/splice.c:1083
 [<     inline     >] do_splice_from /fs/splice.c:1125
 [<     inline     >] do_splice /fs/splice.c:1404
 [<     inline     >] SYSC_splice /fs/splice.c:1707
 [<ffffffff816b36aa>] SyS_splice+0x7fa/0x1670 /fs/splice.c:1690
 [<     inline     >] ? SYSC_futex /kernel/futex.c:3237
 [<ffffffff8135988f>] ? SyS_futex+0x13f/0x2b0 /kernel/futex.c:3205
 [<ffffffff816b2a80>] ? generic_splice_sendpage+0x50/0x50 /fs/splice.c:1107
 [<ffffffff816b2eb0>] ? compat_SyS_vmsplice+0x250/0x250 /fs/splice.c:1658
 [<ffffffff8100301b>] ? trace_hardirqs_on_thunk+0x1b/0x1d /arch/x86/entry/thunk_64.S:42
 [<ffffffff85b4b340>] entry_SYSCALL_64_fastpath+0x23/0xc1 /arch/x86/entry/entry_64.S:207
Memory state around the buggy address:
 ffff8800187a9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8800187a9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8800187aa000: fc 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
                   ^
 ffff8800187aa080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8800187aa100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================

Best Regards,
Baozeng Ding
