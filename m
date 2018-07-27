Return-Path: <threeearcat@gmail.com>
Return-Path: <threeearcat@gmail.com>
Date: Fri, 27 Jul 2018 10:46:06 +0900
From: "Dae R. Jeong" <threeearcat@gmail.com>
To: jikos@kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	lifeasageek@gmail.com, kt0755@gmail.com
Subject: WARNING: possible recursive locking detected
Message-ID: <20180727014606.GA2786@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Reporting the crash: WARNING: possible recursive locking detected

This crash has been found in v4.18 using a modified version of
Syzkaller, which focus on exploring hard-to-reach coverages.

C repro code:
https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-8659a5.c
Kernel config:
https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/config-8659a5

Crash log:
============================================
WARNING: possible recursive locking detected
4.18.0-rc4 #1 Not tainted
--------------------------------------------
kworker/u4:3/1039 is trying to acquire lock:
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: start_flush_work kernel/workqueue.c:2888 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: flush_work+0x316/0x690 kernel/workqueue.c:2917

but task is already holding lock:
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: __write_once_size include/linux/compiler.h:215 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: set_work_data kernel/workqueue.c:617 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: process_one_work+0x857/0x1a30 kernel/workqueue.c:2124

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((wq_completion)"floppy");
  lock((wq_completion)"floppy");

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by kworker/u4:3/1039:
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: __write_once_size include/linux/compiler.h:215 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: process_one_work+0x857/0x1a30 kernel/workqueue.c:2124
 #1: 000000002682ab21 (floppy_work){+.+.}, at: process_one_work+0x88e/0x1a30 kernel/workqueue.c:2128

stack backtrace:
CPU: 0 PID: 1039 Comm: kworker/u4:3 Not tainted 4.18.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: floppy floppy_work_workfn
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x122/0x198 lib/dump_stack.c:113
 print_deadlock_bug kernel/locking/lockdep.c:1765 [inline]
 check_deadlock kernel/locking/lockdep.c:1809 [inline]
 validate_chain kernel/locking/lockdep.c:2405 [inline]
 __lock_acquire+0xfd2/0x39f0 kernel/locking/lockdep.c:3435
 lock_acquire+0x170/0x510 kernel/locking/lockdep.c:3924
 start_flush_work kernel/workqueue.c:2889 [inline]
 flush_work+0x33b/0x690 kernel/workqueue.c:2917
 __cancel_work_timer+0x298/0x3a0 kernel/workqueue.c:2989
 cancel_work_sync+0x1c/0x20 kernel/workqueue.c:3025
 cancel_activity drivers/block/floppy.c:1003 [inline]
 fd_watchdog+0xfe/0x160 drivers/block/floppy.c:1014
 setup_rw_floppy+0x76a/0xa80 drivers/block/floppy.c:1512
 seek_floppy drivers/block/floppy.c:1608 [inline]
 floppy_ready+0x4dd/0x18f0 drivers/block/floppy.c:1920
 floppy_start+0x250/0x2d0 drivers/block/floppy.c:1936
 floppy_work_workfn+0x1a/0x20 drivers/block/floppy.c:977
 process_one_work+0x98d/0x1a30 kernel/workqueue.c:2153
 worker_thread+0x8f/0xcf0 kernel/workqueue.c:2296
 kthread+0x3d5/0x4b0 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
