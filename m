Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <0000000000003b8d3a056bd3b073@google.com>
References: <0000000000003b8d3a056bd3b073@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 10 May 2018 08:30:32 +0200
Message-ID: <CACT4Y+a2mP6w4fw60_B8_2_KQps09bEQbi9jp_3ORkS6As7omA@mail.gmail.com>
Subject: Re: inconsistent lock state in fs_reclaim_acquire (2)
To: syzbot <syzbot+63833431f68be871fb95@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Laura Abbott <lauraa@codeaurora.org>,
	LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, May 10, 2018 at 7:57 AM, syzbot
<syzbot+63833431f68be871fb95@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    036db8bd9637 Merge branch 'for-4.17-fixes' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=146dab5b800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=31f4b3733894ef79
> dashboard link: https://syzkaller.appspot.com/bug?extid=63833431f68be871fb95
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+63833431f68be871fb95@syzkaller.appspotmail.com


Tetsuo thinks this is block layer problem.
+block maintainers


> ================================
> WARNING: inconsistent lock state
> 4.17.0-rc4+ #39 Not tainted
> --------------------------------
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> syz-executor3/10560 [HC0[0]:SC1[1]:HE1:SE0] takes:
> EXT4-fs (sda1): re-mounted. Opts: minixdf,
> 000000001180cb72 (fs_reclaim){+.?.}, at: fs_reclaim_acquire.part.82+0x0/0x30
> mm/page_alloc.c:463
> {SOFTIRQ-ON-W} state was registered at:
>   lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>   fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
>   fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
>   slab_pre_alloc_hook mm/slab.h:418 [inline]
>   slab_alloc_node mm/slab.c:3299 [inline]
>   kmem_cache_alloc_node_trace+0x39/0x770 mm/slab.c:3661
>   kmalloc_node include/linux/slab.h:550 [inline]
>   kzalloc_node include/linux/slab.h:712 [inline]
>   alloc_worker+0xbd/0x2e0 kernel/workqueue.c:1704
>   init_rescuer.part.25+0x1f/0x190 kernel/workqueue.c:4000
>   init_rescuer kernel/workqueue.c:3997 [inline]
>   workqueue_init+0x51f/0x7d0 kernel/workqueue.c:5732
>   kernel_init_freeable+0x2ad/0x58e init/main.c:1115
>   kernel_init+0x11/0x1b3 init/main.c:1053
>   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> irq event stamp: 8616
> hardirqs last  enabled at (8616): [<ffffffff876ef414>]
> __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
> hardirqs last  enabled at (8616): [<ffffffff876ef414>]
> _raw_spin_unlock_irqrestore+0x74/0xc0 kernel/locking/spinlock.c:184
> hardirqs last disabled at (8615): [<ffffffff876ef4d4>]
> __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
> hardirqs last disabled at (8615): [<ffffffff876ef4d4>]
> _raw_spin_lock_irqsave+0x74/0xc0 kernel/locking/spinlock.c:152
> softirqs last  enabled at (7446): [<ffffffff87a00778>]
> __do_softirq+0x778/0xaf5 kernel/softirq.c:311
> softirqs last disabled at (8601): [<ffffffff81476281>] invoke_softirq
> kernel/softirq.c:365 [inline]
> softirqs last disabled at (8601): [<ffffffff81476281>] irq_exit+0x1d1/0x200
> kernel/softirq.c:405
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(fs_reclaim);
>   <Interrupt>
>     lock(fs_reclaim);
>
>  *** DEADLOCK ***
>
> 2 locks held by syz-executor3/10560:
>  #0: 0000000099a775e3 (&(ptlock_ptr(page))->rlock#2){+.+.}, at: spin_lock
> include/linux/spinlock.h:310 [inline]
>  #0: 0000000099a775e3 (&(ptlock_ptr(page))->rlock#2){+.+.}, at:
> zap_pte_range mm/memory.c:1298 [inline]
>  #0: 0000000099a775e3 (&(ptlock_ptr(page))->rlock#2){+.+.}, at:
> zap_pmd_range mm/memory.c:1441 [inline]
>  #0: 0000000099a775e3 (&(ptlock_ptr(page))->rlock#2){+.+.}, at:
> zap_pud_range mm/memory.c:1470 [inline]
>  #0: 0000000099a775e3 (&(ptlock_ptr(page))->rlock#2){+.+.}, at:
> zap_p4d_range mm/memory.c:1491 [inline]
>  #0: 0000000099a775e3 (&(ptlock_ptr(page))->rlock#2){+.+.}, at:
> unmap_page_range+0x99b/0x2200 mm/memory.c:1512
>  #1: 00000000bbb25b9d (rcu_callback){....}, at: __rcu_reclaim
> kernel/rcu/rcu.h:168 [inline]
>  #1: 00000000bbb25b9d (rcu_callback){....}, at: rcu_do_batch
> kernel/rcu/tree.c:2675 [inline]
>  #1: 00000000bbb25b9d (rcu_callback){....}, at: invoke_rcu_callbacks
> kernel/rcu/tree.c:2930 [inline]
>  #1: 00000000bbb25b9d (rcu_callback){....}, at: __rcu_process_callbacks
> kernel/rcu/tree.c:2897 [inline]
>  #1: 00000000bbb25b9d (rcu_callback){....}, at:
> rcu_process_callbacks+0xa2c/0x15f0 kernel/rcu/tree.c:2914
>
> stack backtrace:
> CPU: 0 PID: 10560 Comm: syz-executor3 Not tainted 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_usage_bug.cold.59+0x320/0x41a kernel/locking/lockdep.c:2542
>  valid_state kernel/locking/lockdep.c:2555 [inline]
>  mark_lock_irq kernel/locking/lockdep.c:2749 [inline]
>  mark_lock+0x1034/0x19e0 kernel/locking/lockdep.c:3147
>  mark_irqflags kernel/locking/lockdep.c:3025 [inline]
>  __lock_acquire+0x1622/0x5140 kernel/locking/lockdep.c:3388
>  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>  fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
>  fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
>  slab_pre_alloc_hook mm/slab.h:418 [inline]
>  slab_alloc mm/slab.c:3378 [inline]
>  kmem_cache_alloc_trace+0x2d/0x780 mm/slab.c:3618
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  kobject_uevent_env+0x20f/0xea0 lib/kobject_uevent.c:446
>  kobject_uevent+0x1f/0x30 lib/kobject_uevent.c:568
>  kobject_cleanup lib/kobject.c:630 [inline]
>  kobject_release lib/kobject.c:672 [inline]
>  kref_put include/linux/kref.h:70 [inline]
>  kobject_put+0x1fb/0x280 lib/kobject.c:689
>  put_device+0x20/0x30 drivers/base/core.c:1940
>  delete_partition_rcu_cb+0x147/0x1b0 block/partition-generic.c:255
>  __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2675 [inline]
>  invoke_rcu_callbacks kernel/rcu/tree.c:2930 [inline]
>  __rcu_process_callbacks kernel/rcu/tree.c:2897 [inline]
>  rcu_process_callbacks+0x941/0x15f0 kernel/rcu/tree.c:2914
>  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
>  invoke_softirq kernel/softirq.c:365 [inline]
>  irq_exit+0x1d1/0x200 kernel/softirq.c:405
>  exiting_irq arch/x86/include/asm/apic.h:525 [inline]
>  smp_apic_timer_interrupt+0x17e/0x710 arch/x86/kernel/apic/apic.c:1052
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>  </IRQ>
> RIP: 0010:constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
> RIP: 0010:PageCompound include/linux/page-flags.h:156 [inline]
> RIP: 0010:page_mapcount include/linux/mm.h:599 [inline]
> RIP: 0010:zap_pte_range mm/memory.c:1338 [inline]
> RIP: 0010:zap_pmd_range mm/memory.c:1441 [inline]
> RIP: 0010:zap_pud_range mm/memory.c:1470 [inline]
> RIP: 0010:zap_p4d_range mm/memory.c:1491 [inline]
> RIP: 0010:unmap_page_range+0xf81/0x2200 mm/memory.c:1512
> RSP: 0018:ffff8801b1b37020 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 1ffffd4000c689b0 RBX: ffff8801c00f83b0 RCX: ffffffff81a70cc7
> RDX: 0000000000000000 RSI: ffffffff81a70cd5 RDI: 0000000000000007
> RBP: ffff8801b1b374b8 R08: ffff8801c7d8a0c0 R09: ffffed003b5c46c2
> R10: 0000000000000003 R11: 0000000000000001 R12: ffffea0006344d80
> R13: 00007fdf01277000 R14: dffffc0000000000 R15: 0000000000000000
>  unmap_single_vma+0x1a0/0x310 mm/memory.c:1557
>  unmap_vmas+0x120/0x1f0 mm/memory.c:1587
>  exit_mmap+0x265/0x570 mm/mmap.c:3047
>  __mmput kernel/fork.c:961 [inline]
>  mmput+0x251/0x610 kernel/fork.c:982
>  exit_mm kernel/exit.c:544 [inline]
>  do_exit+0xe98/0x2730 kernel/exit.c:852
>  do_group_exit+0x16f/0x430 kernel/exit.c:968
>  __do_sys_exit_group kernel/exit.c:979 [inline]
>  __se_sys_exit_group kernel/exit.c:977 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007ffd9fd2e388 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000079 RCX: 0000000000455979
> RDX: 0000000000000000 RSI: 0000000000730a80 RDI: 0000000000000000
> RBP: 0000000000000013 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000013
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000001380
> BUG: sleeping function called from invalid context at mm/slab.h:421
> in_atomic(): 1, irqs_disabled(): 0, pid: 10560, name: syz-executor3
> INFO: lockdep is turned off.
> CPU: 0 PID: 10560 Comm: syz-executor3 Not tainted 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 0
>  ___might_sleep.cold.87+0x11f/0x13a kernel/sched/core.c:6188
>  __might_sleep+0x95/0x190 kernel/sched/core.c:6141
>  slab_pre_alloc_hook mm/slab.h:421 [inline]
>  slab_alloc mm/slab.c:3378 [inline]
>  kmem_cache_alloc_trace+0x2bc/0x780 mm/slab.c:3618
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  kobject_uevent_env+0x20f/0xea0 lib/kobject_uevent.c:446
>  kobject_uevent+0x1f/0x30 lib/kobject_uevent.c:568
>  kobject_cleanup lib/kobject.c:630 [inline]
>  kobject_release lib/kobject.c:672 [inline]
>  kref_put include/linux/kref.h:70 [inline]
>  kobject_put+0x1fb/0x280 lib/kobject.c:689
>  put_device+0x20/0x30 drivers/base/core.c:1940
>  delete_partition_rcu_cb+0x147/0x1b0 block/partition-generic.c:255
>  __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2675 [inline]
>  invoke_rcu_callbacks kernel/rcu/tree.c:2930 [inline]
>  __rcu_process_callbacks kernel/rcu/tree.c:2897 [inline]
>  rcu_process_callbacks+0x941/0x15f0 kernel/rcu/tree.c:2914
>  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
>  invoke_softirq kernel/softirq.c:365 [inline]
>  irq_exit+0x1d1/0x200 kernel/softirq.c:405
>  exiting_irq arch/x86/include/asm/apic.h:525 [inline]
>  smp_apic_timer_interrupt+0x17e/0x710 arch/x86/kernel/apic/apic.c:1052
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>  </IRQ>
> RIP: 0010:constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
> RIP: 0010:PageCompound include/linux/page-flags.h:156 [inline]
> RIP: 0010:page_mapcount include/linux/mm.h:599 [inline]
> RIP: 0010:zap_pte_range mm/memory.c:1338 [inline]
> RIP: 0010:zap_pmd_range mm/memory.c:1441 [inline]
> RIP: 0010:zap_pud_range mm/memory.c:1470 [inline]
> RIP: 0010:zap_p4d_range mm/memory.c:1491 [inline]
> RIP: 0010:unmap_page_range+0xf81/0x2200 mm/memory.c:1512
> RSP: 0018:ffff8801b1b37020 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 1ffffd4000c689b0 RBX: ffff8801c00f83b0 RCX: ffffffff81a70cc7
> RDX: 0000000000000000 RSI: ffffffff81a70cd5 RDI: 0000000000000007
> RBP: ffff8801b1b374b8 R08: ffff8801c7d8a0c0 R09: ffffed003b5c46c2
> R10: 0000000000000003 R11: 0000000000000001 R12: ffffea0006344d80
> R13: 00007fdf01277000 R14: dffffc0000000000 R15: 0000000000000000
>  unmap_single_vma+0x1a0/0x310 mm/memory.c:1557
>  unmap_vmas+0x120/0x1f0 mm/memory.c:1587
>  exit_mmap+0x265/0x570 mm/mmap.c:3047
>  __mmput kernel/fork.c:961 [inline]
>  mmput+0x251/0x610 kernel/fork.c:982
>  exit_mm kernel/exit.c:544 [inline]
>  do_exit+0xe98/0x2730 kernel/exit.c:852
>  do_group_exit+0x16f/0x430 kernel/exit.c:968
>  __do_sys_exit_group kernel/exit.c:979 [inline]
>  __se_sys_exit_group kernel/exit.c:977 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007ffd9fd2e388 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000079 RCX: 0000000000455979
> RDX: 0000000000000000 RSI: 0000000000730a80 RDI: 0000000000000000
> RBP: 0000000000000013 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000013
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000001380
> CPU: 1 PID: 10615 Comm: syz-executor6 Not tainted 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:3082 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4322 [inline]
>  __alloc_pages_nodemask+0x34e/0xd70 mm/page_alloc.c:4358
>  __alloc_pages include/linux/gfp.h:456 [inline]
>  __alloc_pages_node include/linux/gfp.h:469 [inline]
>  kmem_getpages mm/slab.c:1411 [inline]
>  cache_grow_begin+0x72/0x6c0 mm/slab.c:2678
>  cache_alloc_refill mm/slab.c:3045 [inline]
>  ____cache_alloc mm/slab.c:3127 [inline]
>  __do_cache_alloc mm/slab.c:3349 [inline]
>  slab_alloc mm/slab.c:3384 [inline]
>  kmem_cache_alloc+0x689/0x760 mm/slab.c:3552
>  bdev_alloc_inode+0x1b/0x40 fs/block_dev.c:727
>  alloc_inode+0x63/0x190 fs/inode.c:209
>  iget5_locked+0x20e/0x570 fs/inode.c:1045
>  bdget+0xb1/0x5c0 fs/block_dev.c:868
>  blkpg_ioctl+0x31d/0xc40 block/ioctl.c:77
>  blkdev_ioctl+0x1753/0x2020 block/ioctl.c:573
>  block_ioctl+0xee/0x130 fs/block_dev.c:1877
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007f35a9be2c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f35a9be36d4 RCX: 0000000000455979
> RDX: 0000000020000180 RSI: 0000000000001269 RDI: 0000000000000013
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000014
> R13: 00000000000001a8 R14: 00000000006f6860 R15: 0000000000000001
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 0
> CPU: 1 PID: 10662 Comm: syz-executor6 Tainted: G        W
> 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:3082 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4322 [inline]
>  __alloc_pages_nodemask+0x34e/0xd70 mm/page_alloc.c:4358
>  __alloc_pages include/linux/gfp.h:456 [inline]
>  __alloc_pages_node include/linux/gfp.h:469 [inline]
>  kmem_getpages mm/slab.c:1411 [inline]
>  cache_grow_begin+0x72/0x6c0 mm/slab.c:2678
>  cache_alloc_refill mm/slab.c:3045 [inline]
>  ____cache_alloc mm/slab.c:3127 [inline]
>  __do_cache_alloc mm/slab.c:3349 [inline]
>  slab_alloc mm/slab.c:3384 [inline]
>  kmem_cache_alloc_trace+0x6a5/0x780 mm/slab.c:3618
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  kobject_uevent_env+0x20f/0xea0 lib/kobject_uevent.c:446
>  kobject_uevent+0x1f/0x30 lib/kobject_uevent.c:568
>  device_del+0x6c9/0xb70 drivers/base/core.c:2007
>  delete_partition+0x21d/0x2a0 block/partition-generic.c:284
>  blkpg_ioctl+0x3c5/0xc40 block/ioctl.c:93
>  blkdev_ioctl+0x1753/0x2020 block/ioctl.c:573
>  block_ioctl+0xee/0x130 fs/block_dev.c:1877
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007f35a9be2c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f35a9be36d4 RCX: 0000000000455979
> RDX: 0000000020000180 RSI: 0000000000001269 RDI: 0000000000000013
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000014
> R13: 00000000000001a8 R14: 00000000006f6860 R15: 0000000000000002
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 11012 Comm: syz-executor2 Tainted: G        W
> 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  __should_failslab+0x124/0x180 mm/failslab.c:32
>  should_failslab+0x9/0x14 mm/slab_common.c:1522
>  slab_pre_alloc_hook mm/slab.h:423 [inline]
>  slab_alloc mm/slab.c:3378 [inline]
>  kmem_cache_alloc_trace+0x2cb/0x780 mm/slab.c:3618
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  alloc_pipe_info+0x16d/0x580 fs/pipe.c:633
>  splice_direct_to_actor+0x6e7/0x8d0 fs/splice.c:920
>  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
>  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
>  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
>  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007fb8be39dc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fb8be39e6d4 RCX: 0000000000455979
> RDX: 0000000020000080 RSI: 0000000000000014 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 0000000000000514 R14: 00000000006fba80 R15: 0000000000000000
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 11055 Comm: syz-executor2 Tainted: G        W
> 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:3082 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4322 [inline]
>  __alloc_pages_nodemask+0x34e/0xd70 mm/page_alloc.c:4358
>  __alloc_pages include/linux/gfp.h:456 [inline]
>  __alloc_pages_node include/linux/gfp.h:469 [inline]
>  kmem_getpages mm/slab.c:1411 [inline]
>  cache_grow_begin+0x72/0x6c0 mm/slab.c:2678
>  cache_alloc_refill mm/slab.c:3045 [inline]
>  ____cache_alloc mm/slab.c:3127 [inline]
>  __do_cache_alloc mm/slab.c:3349 [inline]
>  slab_alloc mm/slab.c:3384 [inline]
>  kmem_cache_alloc_trace+0x6a5/0x780 mm/slab.c:3618
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  alloc_pipe_info+0x16d/0x580 fs/pipe.c:633
>  splice_direct_to_actor+0x6e7/0x8d0 fs/splice.c:920
>  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
>  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
>  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
>  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007fb8be39dc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fb8be39e6d4 RCX: 0000000000455979
> RDX: 0000000020000080 RSI: 0000000000000014 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 0000000000000514 R14: 00000000006fba80 R15: 0000000000000001
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 11101 Comm: syz-executor2 Tainted: G        W
> 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  __should_failslab+0x124/0x180 mm/failslab.c:32
>  should_failslab+0x9/0x14 mm/slab_common.c:1522
>  slab_pre_alloc_hook mm/slab.h:423 [inline]
>  slab_alloc_node mm/slab.c:3299 [inline]
>  kmem_cache_alloc_node_trace+0x26f/0x770 mm/slab.c:3661
>  __do_kmalloc_node mm/slab.c:3681 [inline]
>  __kmalloc_node+0x33/0x70 mm/slab.c:3689
>  kmalloc_node include/linux/slab.h:554 [inline]
>  kvmalloc_node+0x6b/0x100 mm/util.c:421
>  kvmalloc include/linux/mm.h:550 [inline]
>  kvmalloc_array include/linux/mm.h:566 [inline]
>  get_pages_array lib/iov_iter.c:1097 [inline]
>  pipe_get_pages_alloc lib/iov_iter.c:1123 [inline]
>  iov_iter_get_pages_alloc+0x7be/0x14e0 lib/iov_iter.c:1144
>  default_file_splice_read+0x1c7/0xad0 fs/splice.c:390
>  do_splice_to+0x12e/0x190 fs/splice.c:880
>  splice_direct_to_actor+0x268/0x8d0 fs/splice.c:952
>  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
>  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
>  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
>  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007fb8be39dc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fb8be39e6d4 RCX: 0000000000455979
> RDX: 0000000020000080 RSI: 0000000000000014 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 0000000000000514 R14: 00000000006fba80 R15: 0000000000000002
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 11156 Comm: syz-executor2 Tainted: G        W
> 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:3082 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4322 [inline]
>  __alloc_pages_nodemask+0x34e/0xd70 mm/page_alloc.c:4358
>  alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2093
>  alloc_pages include/linux/gfp.h:492 [inline]
>  push_pipe+0x400/0x7a0 lib/iov_iter.c:515
>  __pipe_get_pages lib/iov_iter.c:1022 [inline]
>  pipe_get_pages_alloc lib/iov_iter.c:1126 [inline]
>  iov_iter_get_pages_alloc+0x84a/0x14e0 lib/iov_iter.c:1144
>  default_file_splice_read+0x1c7/0xad0 fs/splice.c:390
>  do_splice_to+0x12e/0x190 fs/splice.c:880
>  splice_direct_to_actor+0x268/0x8d0 fs/splice.c:952
>  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
>  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
>  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
>  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007fb8be39dc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fb8be39e6d4 RCX: 0000000000455979
> RDX: 0000000020000080 RSI: 0000000000000014 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 0000000000000514 R14: 00000000006fba80 R15: 0000000000000003
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 11181 Comm: syz-executor2 Tainted: G        W
> 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:3082 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4322 [inline]
>  __alloc_pages_nodemask+0x34e/0xd70 mm/page_alloc.c:4358
>  alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2093
>  alloc_pages include/linux/gfp.h:492 [inline]
>  push_pipe+0x400/0x7a0 lib/iov_iter.c:515
>  __pipe_get_pages lib/iov_iter.c:1022 [inline]
>  pipe_get_pages_alloc lib/iov_iter.c:1126 [inline]
>  iov_iter_get_pages_alloc+0x84a/0x14e0 lib/iov_iter.c:1144
>  default_file_splice_read+0x1c7/0xad0 fs/splice.c:390
>  do_splice_to+0x12e/0x190 fs/splice.c:880
>  splice_direct_to_actor+0x268/0x8d0 fs/splice.c:952
>  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
>  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
>  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
>  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007fb8be39dc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fb8be39e6d4 RCX: 0000000000455979
> RDX: 0000000020000080 RSI: 0000000000000014 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 0000000000000514 R14: 00000000006fba80 R15: 0000000000000004
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 11208 Comm: syz-executor2 Tainted: G        W
> 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:3082 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4322 [inline]
>  __alloc_pages_nodemask+0x34e/0xd70 mm/page_alloc.c:4358
>  alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2093
>  alloc_pages include/linux/gfp.h:492 [inline]
>  push_pipe+0x400/0x7a0 lib/iov_iter.c:515
>  __pipe_get_pages lib/iov_iter.c:1022 [inline]
>  pipe_get_pages_alloc lib/iov_iter.c:1126 [inline]
>  iov_iter_get_pages_alloc+0x84a/0x14e0 lib/iov_iter.c:1144
>  default_file_splice_read+0x1c7/0xad0 fs/splice.c:390
>  do_splice_to+0x12e/0x190 fs/splice.c:880
>  splice_direct_to_actor+0x268/0x8d0 fs/splice.c:952
>  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
>  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
>  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
>  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007fb8be39dc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fb8be39e6d4 RCX: 0000000000455979
> RDX: 0000000020000080 RSI: 0000000000000014 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 0000000000000514 R14: 00000000006fba80 R15: 0000000000000005
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 11251 Comm: syz-executor2 Tainted: G        W
> 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:3082 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4322 [inline]
>  __alloc_pages_nodemask+0x34e/0xd70 mm/page_alloc.c:4358
>  alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2093
>  alloc_pages include/linux/gfp.h:492 [inline]
>  push_pipe+0x400/0x7a0 lib/iov_iter.c:515
>  __pipe_get_pages lib/iov_iter.c:1022 [inline]
>  pipe_get_pages_alloc lib/iov_iter.c:1126 [inline]
>  iov_iter_get_pages_alloc+0x84a/0x14e0 lib/iov_iter.c:1144
>  default_file_splice_read+0x1c7/0xad0 fs/splice.c:390
>  do_splice_to+0x12e/0x190 fs/splice.c:880
>  splice_direct_to_actor+0x268/0x8d0 fs/splice.c:952
>  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
>  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
>  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
>  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007fb8be39dc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fb8be39e6d4 RCX: 0000000000455979
> RDX: 0000000020000080 RSI: 0000000000000014 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 0000000000000514 R14: 00000000006fba80 R15: 0000000000000006
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 0
> CPU: 1 PID: 11321 Comm: syz-executor2 Tainted: G        W
> 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:3082 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4322 [inline]
>  __alloc_pages_nodemask+0x34e/0xd70 mm/page_alloc.c:4358
>  alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2093
>  alloc_pages include/linux/gfp.h:492 [inline]
>  push_pipe+0x400/0x7a0 lib/iov_iter.c:515
>  __pipe_get_pages lib/iov_iter.c:1022 [inline]
>  pipe_get_pages_alloc lib/iov_iter.c:1126 [inline]
>  iov_iter_get_pages_alloc+0x84a/0x14e0 lib/iov_iter.c:1144
>  default_file_splice_read+0x1c7/0xad0 fs/splice.c:390
>  do_splice_to+0x12e/0x190 fs/splice.c:880
>  splice_direct_to_actor+0x268/0x8d0 fs/splice.c:952
>  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
>  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
>  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
>  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007fb8be39dc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fb8be39e6d4 RCX: 0000000000455979
> RDX: 0000000020000080 RSI: 0000000000000014 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 0000000000000514 R14: 00000000006fba80 R15: 0000000000000007
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 0
> CPU: 1 PID: 11367 Comm: syz-executor2 Tainted: G        W
> 4.17.0-rc4+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
>  should_fail_alloc_page mm/page_alloc.c:3082 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4322 [inline]
>  __alloc_pages_nodemask+0x34e/0xd70 mm/page_alloc.c:4358
>  alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2093
>  alloc_pages include/linux/gfp.h:492 [inline]
>  push_pipe+0x400/0x7a0 lib/iov_iter.c:515
>  __pipe_get_pages lib/iov_iter.c:1022 [inline]
>  pipe_get_pages_alloc lib/iov_iter.c:1126 [inline]
>  iov_iter_get_pages_alloc+0x84a/0x14e0 lib/iov_iter.c:1144
>  default_file_splice_read+0x1c7/0xad0 fs/splice.c:390
>  do_splice_to+0x12e/0x190 fs/splice.c:880
>  splice_direct_to_actor+0x268/0x8d0 fs/splice.c:952
>  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
>  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
>  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
>  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455979
> RSP: 002b:00007fb8be39dc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007fb8be39e6d4 RCX: 0000000000455979
> RDX: 0000000020000080 RSI: 0000000000000014 RDI: 0000000000000014
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000015
> R13: 0000000000000514 R14: 00000000006fba80 R15: 0000000000000008
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000003b8d3a056bd3b073%40google.com.
> For more options, visit https://groups.google.com/d/optout.
