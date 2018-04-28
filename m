Return-Path: <30lnkWgkbBfMntufVggZmVkkdY.bjjbgZpnZmXjioZio.XjhVsWjZfZmiZg.Yf@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sat, 28 Apr 2018 04:24:02 -0700
Message-ID: <0000000000009b212b056ae6dbad@google.com>
Subject: INFO: task hung in blk_queue_enter
From: syzbot <syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
List-ID: <linux-block@vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
d8a332730e757129e70675679f2b2a03f1ecf65e (Fri Apr 27 17:39:38 2018 +0000)
Merge tag 'char-misc-4.17-rc3' of  
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=c4f9cebf9d651f6e54de

So far this crash happened 13 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4727023951937536
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6091190189424640
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5018098448990208
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=7043958930931867332
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

random: sshd: uninitialized urandom read (32 bytes read)
print_req_error: I/O error, dev loop0, sector 7680
print_req_error: I/O error, dev loop0, sector 10240
print_req_error: I/O error, dev loop0, sector 7680
print_req_error: I/O error, dev loop0, sector 12800
INFO: task kworker/u4:2:31 blocked for more than 120 seconds.
       Not tainted 4.17.0-rc2+ #20
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u4:2    D12840    31      2 0x80000000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  blk_queue_enter+0x8da/0xdf0 block/blk-core.c:953
  generic_make_request+0x144/0x1510 block/blk-core.c:2395
  submit_bio+0xba/0x460 block/blk-core.c:2568
  submit_bh_wbc+0x5e8/0x7c0 fs/buffer.c:3076
  __block_write_full_page+0x82e/0xef0 fs/buffer.c:1758
  block_write_full_page+0x1ff/0x250 fs/buffer.c:2944
  blkdev_writepage+0x24/0x30 fs/block_dev.c:566
  __writepage+0x69/0xe0 mm/page-writeback.c:2302
  write_cache_pages+0x920/0x1690 mm/page-writeback.c:2240
  generic_writepages+0xcc/0x120 mm/page-writeback.c:2326
  blkdev_writepages+0x1d/0x30 fs/block_dev.c:1951
  do_writepages+0x9a/0x1a0 mm/page-writeback.c:2341
  __writeback_single_inode+0x1e4/0x15c0 fs/fs-writeback.c:1323
  writeback_sb_inodes+0x6f0/0x11a0 fs/fs-writeback.c:1587
  __writeback_inodes_wb+0x1b0/0x320 fs/fs-writeback.c:1656
  wb_writeback+0x9e4/0xf50 fs/fs-writeback.c:1765
  wb_check_background_flush fs/fs-writeback.c:1833 [inline]
  wb_do_writeback fs/fs-writeback.c:1921 [inline]
  wb_workfn+0xd2f/0x1770 fs/fs-writeback.c:1949
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Showing all locks held in the system:
3 locks held by kworker/u4:2/31:
  #0:         (ptrval) ((wq_completion)"writeback"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0:         (ptrval) ((wq_completion)"writeback"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0:         (ptrval) ((wq_completion)"writeback"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0:         (ptrval) ((wq_completion)"writeback"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0:         (ptrval) ((wq_completion)"writeback"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0:         (ptrval) ((wq_completion)"writeback"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0:         (ptrval) ((wq_completion)"writeback"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1:         (ptrval) ((work_completion)(&(&wb->dwork)->work)){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
  #2:         (ptrval) (&type->s_umount_key#35){.+.+}, at:  
trylock_super+0x22/0x110 fs/super.c:399
2 locks held by khungtaskd/891:
  #0:         (ptrval) (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0:         (ptrval) (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1:         (ptrval) (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
2 locks held by getty/4512:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4513:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4514:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4515:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4516:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4517:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4518:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
1 lock held by syz-executor516/4581:
  #0:         (ptrval) (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 891 Comm: khungtaskd Not tainted 4.17.0-rc2+ #20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0xc10/0xf60 kernel/hung_task.c:249
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.17.0-rc2+ #20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ksoftirqd_running kernel/softirq.c:88 [inline]
RIP: 0010:invoke_softirq kernel/softirq.c:355 [inline]
RIP: 0010:irq_exit+0x125/0x200 kernel/softirq.c:405
RSP: 0018:ffff8801dae07cd8 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: ffff8801d9a9c200 RCX: 0000000000000000
RDX: 1ffff1003b353842 RSI: 0000000000000000 RDI: ffff8801d9a9c210
RBP: ffff8801dae07ce0 R08: ffffed003b5c46c3 R09: ffffed003b5c46c2
R10: ffffed003b5c46c2 R11: ffff8801dae23613 R12: ffff8801dae2c580
R13: ffffffff88c75dc0 R14: ffff8801dae07e68 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001b5553000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  scheduler_ipi+0x52b/0xa30 kernel/sched/core.c:1778
  smp_reschedule_interrupt+0xed/0x660 arch/x86/kernel/smp.c:277
  reschedule_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:887
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
RSP: 0018:ffffffff88c07bc0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff02
RAX: dffffc0000000000 RBX: 1ffffffff1180f7b RCX: 0000000000000000
RDX: 1ffffffff11a3160 RSI: 0000000000000001 RDI: ffffffff88d18b00
RBP: ffffffff88c07bc0 R08: ffffed003b5c46c3 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff88c07c78 R14: ffffffff897bf060 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xc2/0x440 arch/x86/kernel/process.c:354
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:345
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x395/0x560 kernel/sched/idle.c:262
  cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:368
  rest_init+0xe1/0xe4 init/main.c:441
  start_kernel+0x906/0x92d init/main.c:737
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:445
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:426
  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
Code: 00 01 5b 5d c3 65 48 8b 1d 89 a4 ba 7e 48 85 db 74 2c 48 b8 00 00 00  
00 00 fc ff df 48 8d 7b 10 48 89 fa 48 c1 ea 03 80 3c 02 00 <0f> 85 c2 00  
00 00 48 8b 43 10 48 85 c0 0f 84 31 ff ff ff 48 c7


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
