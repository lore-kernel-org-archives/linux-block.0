Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12A3A254B
	for <linux-block@vger.kernel.org>; Sat,  8 Aug 2026 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219654; cv=none; b=D0v/wn+6RevWIyV4e0tTwpd1O6SJAQOsM/DT2v2+wu79dVlBMdZT14mMweYiQ0MwMpuAuFeNdsDW28zCrcT+VJxSD7+w75flCvGkZSqxbMrHN5Ewg4bJY0+3gZbmceA5FosvRmS4hBy/HL09oNoTVfoWCmXqsBnzW/TvBRVPOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219654; c=relaxed/simple;
	bh=WKn6Yw6vh8dlVHeVt4jd5UHaEPG4Mzys/fwc5o0UwoQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=erWeFJUPCO6Zr7YpFcRO9TZCOmJnR3esjYAMxjabWF4sI5rugOP/s80mSnX3vqWKETtDpWjKw5JrQQMtjE4tSWNwf1CQ2mkVhplZARhaq+aPf/0BKoomAb90x/YPkJpqTUNymwtiDh8SGfHZoijZBkJrv/KuK5g8cgj7Z7tY7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-4566537e644so780385fac.0
        for <linux-block@vger.kernel.org>; Sat, 08 Aug 2026 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786219651; x=1786824451;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6qP1E133lF00wZnHYXsHErjGqEeVbeqqdM/0uVEdVw8=;
        b=WSjsSCLJbIt62IXwjClDluFK8I6HT7S/qe3q+FNIXqhI7lUJo83y5941ZhT91U5KGz
         cs+NY0KuJt4m4BbeUoprJnUdeApxK7/ILQhB8IhmrPUHSrNUVX5pt36xb+fJ9UlBqAb7
         p33rqXjXwf3RVxHYOWXdopiqBY9uHZ7QRe7LmWDTc2TA0F6rEdTUxJGua16+vSN8HIz5
         rBq5aShEEkW1ZJOHK9hMjQlZ2MELa8P+J2ukKjcX0kKI31zMvRxhswGO6JadrmZfkBss
         fzIJJWcg6tpBtcU3ld9/ME070boRMMjga7xHOBweezSG6e4z6V+pVu+fqjLgBNACigt4
         CePg==
X-Forwarded-Encrypted: i=1; AHgh+RoNYbHsx2UC7lFUq0dksI10nVCjJ+hW/LNux8i3CdgOpwIXzG6gnFIkTi74EjT0P5eA9eIUYMAs8dZZHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9ia+g645hQdePDvKYHpghfWhQtYbnD7SfkV2uhteA3MLOFIP
	HxIzTad1+Ryg/PwrKcdBCtzmhOzTArGK0zq4arGIuMoED65kp2k8v2E0HN5C/kbNXcOgc0tdDxd
	X8XO5uAm6dlBIcCL0RFoco0azJVme1DW6vFptPRdQxAAXhDovvlIVEPrQh7w=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:15a6:b0:49b:c387:36c5 with SMTP id
 5614622812f47-4afae16d6cfmr17427989b6e.17.1786219651097; Sat, 08 Aug 2026
 13:07:31 -0700 (PDT)
Date: Sat, 08 Aug 2026 13:07:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a778c83.01d0871a.3a0d52.006b.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in __rq_qos_throttle (2)
From: syzbot <syzbot+53706c567afab5131044@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1440fcc6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e8a402093abe6b2
dashboard link: https://syzkaller.appspot.com/bug?extid=53706c567afab5131044
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146d57b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d54fb9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f43b22650b3/disk-0d839570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a5a74ede35c/vmlinux-0d839570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f66d75fb8a35/bzImage-0d839570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53706c567afab5131044@syzkaller.appspotmail.com

INFO: task kworker/u8:6:763 blocked in I/O wait for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:6    state:D stack:20032 pid:763   tgid:763   ppid:2      task_flags:0x4248060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 io_schedule+0x7f/0xd0 kernel/sched/core.c:8154
 rq_qos_wait+0x266/0x360 block/blk-rq-qos.c:307
 __wbt_wait block/blk-wbt.c:598 [inline]
 wbt_wait+0x326/0x550 block/blk-wbt.c:658
 __rq_qos_throttle+0x6b/0xb0 block/blk-rq-qos.c:66
 rq_qos_throttle block/blk-rq-qos.h:164 [inline]
 blk_mq_get_new_requests block/blk-mq.c:3032 [inline]
 blk_mq_submit_bio+0x1522/0x2a40 block/blk-mq.c:3170
 __submit_bio_noacct_mq block/blk-core.c:756 [inline]
 submit_bio_noacct_nocheck+0x34e/0xa40 block/blk-core.c:790
 blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
 ext4_io_submit+0x11b/0x190 fs/ext4/page-io.c:404
 ext4_do_writepages+0x1293/0x47a0 fs/ext4/inode.c:2969
 ext4_writepages+0x241/0x3b0 fs/ext4/inode.c:3043
 do_writepages+0x338/0x560 mm/page-writeback.c:2571
 __writeback_single_inode+0x12e/0xf90 fs/fs-writeback.c:1787
 writeback_sb_inodes+0x9de/0x1b00 fs/fs-writeback.c:2079
 __writeback_inodes_wb+0x114/0x240 fs/fs-writeback.c:2155
 wb_writeback+0x42f/0xad0 fs/fs-writeback.c:2266
 wb_check_old_data_flush fs/fs-writeback.c:2370 [inline]
 wb_do_writeback fs/fs-writeback.c:2449 [inline]
 wb_workfn+0xc92/0x10f0 fs/fs-writeback.c:2477
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task jbd2/sda1-8:4934 blocked in I/O wait for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/sda1-8     state:D stack:25288 pid:4934  tgid:4934  ppid:2      task_flags:0x240040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 io_schedule+0x7f/0xd0 kernel/sched/core.c:8154
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:250
 __wait_on_bit+0xac/0x300 kernel/sched/wait_bit.c:52
 out_of_line_wait_on_bit+0x13b/0x190 kernel/sched/wait_bit.c:67
 wait_on_buffer include/linux/buffer_head.h:422 [inline]
 jbd2_journal_commit_transaction+0x2f1d/0x5b70 fs/jbd2/commit.c:834
 kjournald2+0x3bc/0x750 fs/jbd2/journal.c:199
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.0.252:6057 blocked in I/O wait for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.252       state:D stack:28200 pid:6057  tgid:6057  ppid:5759   task_flags:0x440040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 io_schedule+0x7f/0xd0 kernel/sched/core.c:8154
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:250
 __wait_on_bit+0xac/0x300 kernel/sched/wait_bit.c:52
 out_of_line_wait_on_bit+0x13b/0x190 kernel/sched/wait_bit.c:67
 wait_on_bit_io include/linux/wait_bit.h:105 [inline]
 do_get_write_access+0x661/0x1080 fs/jbd2/transaction.c:1113
 jbd2_journal_get_write_access+0x1d6/0x230 fs/jbd2/transaction.c:1263
 __ext4_journal_get_write_access+0x1c3/0x590 fs/ext4/ext4_jbd2.c:241
 ext4_reserve_inode_write+0x294/0x360 fs/ext4/inode.c:6427
 __ext4_mark_inode_dirty+0x13e/0x700 fs/ext4/inode.c:6602
 ext4_dirty_inode+0xd0/0x110 fs/ext4/inode.c:6639
 __mark_inode_dirty+0x3a8/0x13b0 fs/fs-writeback.c:2709
 generic_update_time fs/inode.c:2257 [inline]
 file_update_time_flags+0x3ee/0x4a0 fs/inode.c:2487
 ext4_page_mkwrite+0x224/0x1140 fs/ext4/inode.c:6805
 do_page_mkwrite+0x147/0x310 mm/memory.c:3684
 do_shared_fault mm/memory.c:5936 [inline]
 do_fault mm/memory.c:5998 [inline]
 do_pte_missing+0x757/0x34b0 mm/memory.c:4566
 handle_pte_fault mm/memory.c:6379 [inline]
 __handle_mm_fault mm/memory.c:6517 [inline]
 handle_mm_fault+0x1b36/0x3080 mm/memory.c:6686
 do_user_addr_fault+0xa4d/0x1340 arch/x86/mm/fault.c:1343
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1536
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
RIP: 0033:0x7f83ac26ba23
RSP: 002b:00007fff430be250 EFLAGS: 00010246
RAX: 000000000003fde8 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000001b34a24000 RSI: 0000000000040000 RDI: 00007f83ac5e0708
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 00007fff430be4e0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/32:
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
4 locks held by kworker/u8:6/763:
 #0: ffff88801c2ab940 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88801c2ab940 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc9000451fc40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc9000451fc40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffff88803604a0d8 (&type->s_umount_key#32){++++}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:566
 #3: ffff888036048c18 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 #3: ffff888036048c18 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1876 [inline]
 #3: ffff888036048c18 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x205/0x3b0 fs/ext4/inode.c:3042
2 locks held by getty/5359:
 #0: ffff8880361ec0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
3 locks held by syz.0.252/6057:
 #0: ffff888033cfd588 (vm_lock){++++}-{0:0}, at: lock_vma_under_rcu+0x1d1/0x500 mm/mmap_lock.c:310
 #1: ffff88803604a548 (sb_pagefaults){.+.+}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 #1: ffff88803604a548 (sb_pagefaults){.+.+}-{0:0}, at: __sb_start_write include/linux/fs/super.h:19 [inline]
 #1: ffff88803604a548 (sb_pagefaults){.+.+}-{0:0}, at: sb_start_pagefault include/linux/fs/super.h:159 [inline]
 #1: ffff88803604a548 (sb_pagefaults){.+.+}-{0:0}, at: ext4_page_mkwrite+0x202/0x1140 fs/ext4/inode.c:6804
 #2: ffff888033db6938 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1fc3/0x2210 fs/jbd2/transaction.c:444
3 locks held by syz-executor/6064:
 #0: ffff88803604a450 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:494
 #1: ffff8880764c1640 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #1: ffff8880764c1640 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2918 [inline]
 #1: ffff8880764c1640 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2942 [inline]
 #1: ffff8880764c1640 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_create+0x200/0x370 fs/namei.c:4955
 #2: ffff888033db6938 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1fc3/0x2210 fs/jbd2/transaction.c:444

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 32 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x17a/0x380 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: 6c 80 02 e9 fe 5f 41 f5 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 8e 1a 00 fb f4 <e9> d7 5f 41 f5 cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffc90000197e40 EFLAGS: 00000242
RAX: 00000000000e1b9b RBX: ffffffff819b4450 RCX: 0000000080000001
RDX: 0000000000000001 RSI: ffffffff8e226a0e RDI: ffffffff8c4bb880
RBP: ffffc90000197f10 R08: ffff8880b87338db R09: 1ffff110170e671b
R10: dffffc0000000000 R11: ffffed10170e671c R12: 0000000000000000
R13: 1ffff11003bd5000 R14: 1ffff92000032fd0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88812505e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561c741e9660 CR3: 000000000e946000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/kernel/process.c:767 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:768
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x2e0/0x540 kernel/sched/idle.c:355
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:454
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x157
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
