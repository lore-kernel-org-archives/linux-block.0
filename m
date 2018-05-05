Return-Path: <3ljLtWgkbBY09FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53rEs5v1v84v2.u1@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Fri, 04 May 2018 21:27:02 -0700
In-Reply-To: <001a113f64ee97b27105649a7cb2@google.com>
Message-ID: <0000000000002f0b35056b6dd903@google.com>
Subject: Re: INFO: task hung in blk_freeze_queue
From: syzbot <syzbot+2ab52b8d94df5e2eaa01@syzkaller.appspotmail.com>
To: axboe@kernel.dk, dvyukov@google.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	penguin-kernel@I-love.SAKURA.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
List-ID: <linux-block@vger.kernel.org>

syzbot has found a reproducer for the following crash on:

HEAD commit:    cdface520934 Merge tag 'for_linus_stable' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136c8ee7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61c12b53c2a25ec4
dashboard link: https://syzkaller.appspot.com/bug?extid=2ab52b8d94df5e2eaa01
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15afa247800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f07717800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2ab52b8d94df5e2eaa01@syzkaller.appspotmail.com

INFO: task syz-executor148:4500 blocked for more than 120 seconds.
       Not tainted 4.17.0-rc2+ #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor148 D16648  4500   4481 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  blk_mq_freeze_queue_wait+0x1ce/0x460 block/blk-mq.c:136
  blk_freeze_queue+0x4a/0x80 block/blk-mq.c:165
  blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:174
  loop_clr_fd+0x226/0xb80 drivers/block/loop.c:1047
  lo_ioctl+0x642/0x2130 drivers/block/loop.c:1404
  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
  blkdev_ioctl+0x9b6/0x2020 block/ioctl.c:601
  block_ioctl+0xee/0x130 fs/block_dev.c:1877
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x449789
RSP: 002b:00007f210fae5da8 EFLAGS: 00000297 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dac3c RCX: 0000000000449789
RDX: 0000000000449789 RSI: 0000000000004c01 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dac38
R13: 0030656c69662f2e R14: 6f6f6c2f7665642f R15: 0000000000000007

Showing all locks held in the system:
2 locks held by khungtaskd/893:
  #0: 0000000045f40930 (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0: 0000000045f40930 (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1: 0000000081898718 (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
1 lock held by rsyslogd/4362:
  #0: 000000002e322c73 (&f->f_pos_lock){+.+.}, at: __run_timers+0x16e/0xc50  
kernel/time/timer.c:1658
2 locks held by getty/4452:
  #0: 000000003abe4bd2 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000035e35fb8 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4453:
  #0: 000000004e78faf9 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000044d079f2 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4454:
  #0: 0000000037bf7fca (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000fc65c2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4455:
  #0: 00000000650b41ff (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000f8a69a89 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4456:
  #0: 0000000033547e18 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000000c85318d (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4457:
  #0: 00000000e5cb3908 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000009fc1aed4 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4458:
  #0: 0000000055360c24 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000002bcd4fa8 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
1 lock held by syz-executor148/4486:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/4500:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/4514:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/4515:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/4517:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/5006:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/5008:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/5009:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/5011:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/5012:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/5014:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391
1 lock held by syz-executor148/4483:
  #0: 0000000004c28cff (&rq->lock){-.-.}, at: rq_lock  
kernel/sched/sched.h:1799 [inline]
  #0: 0000000004c28cff (&rq->lock){-.-.}, at: __schedule+0x246/0x1e30  
kernel/sched/core.c:3428
1 lock held by blkid/5016:
  #0: 00000000bf14345a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 893 Comm: khungtaskd Not tainted 4.17.0-rc2+ #23
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
CPU: 0 PID: 4495 Comm: syz-executor148 Not tainted 4.17.0-rc2+ #23
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:debug_lockdep_rcu_enabled.part.1+0x3b/0x60 kernel/rcu/update.c:301
RSP: 0018:ffff8801d3ccefe0 EFLAGS: 00000046
RAX: 0000000000000007 RBX: ffff8801b142c200 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffff8801b142ca34
RBP: ffff8801d3ccefe8 R08: ffffed003b5c46c3 R09: ffffed003b5c46c2
R10: ffffed003b5c46c2 R11: ffff8801dae23613 R12: 1ffff1003a799e26
R13: ffff8801d3ccf170 R14: 0000000000000000 R15: ffff8801b142c200
FS:  00007f210fb07700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f16b38df9ce CR3: 00000001b19db000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  debug_lockdep_rcu_enabled+0x77/0x90 kernel/rcu/update.c:300
  trace_rcu_utilization include/trace/events/rcu.h:21 [inline]
  rcu_note_context_switch+0x554/0x710 kernel/rcu/tree.c:456
  __schedule+0x23e/0x1e30 kernel/sched/core.c:3418
  schedule+0xef/0x430 kernel/sched/core.c:3549
  freezable_schedule include/linux/freezer.h:172 [inline]
  futex_wait_queue_me+0x3e8/0x820 kernel/futex.c:2530
  futex_wait+0x450/0x9f0 kernel/futex.c:2645
  do_futex+0x336/0x27d0 kernel/futex.c:3527
  __do_sys_futex kernel/futex.c:3587 [inline]
  __se_sys_futex kernel/futex.c:3555 [inline]
  __x64_sys_futex+0x46a/0x680 kernel/futex.c:3555
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x449789
RSP: 002b:00007f210fb06da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 0000000000449789
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000006dac24
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac20
R13: 0030656c69662f2e R14: 6f6f6c2f7665642f R15: 0000000000000007
Code: 48 8b 1c 25 c0 ed 01 00 48 8d bb 34 08 00 00 48 89 fa 48 c1 ea 03 0f  
b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 10 <8b> 93 34 08  
00 00 31 c0 5b 5d 85 d2 0f 94 c0 c3 e8 70 ed 51 00
