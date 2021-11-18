Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D9CC433FE
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 00:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC18A60041
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 00:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbhKRAgW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:36:22 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:54252 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhKRAgW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 19:36:22 -0500
Received: by mail-il1-f197.google.com with SMTP id g11-20020a056e021a2b00b0026ef3cb57beso2931799ile.20
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 16:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zltMbhNYCdJXbSE4O7r75SJdsj18hnh7KBMDQqduTmg=;
        b=E+2RMNqAIRjeTqIPk8WC4GmuQuey5GAsPut0TmqTcSE5JRzgd86i3FUtUniKOOEhes
         JVZmAGQLaO+yA7dzM2LvDSvNpga3EKau0aoLUaA7wHbg0+QgcWlKmWQIxSq3cp/pwyCF
         mRmunmVZ8z2j7ulZdGWtiM9HQ7jSDdty3S3viVjOanPWnh70fLoObpDdhRyaIjpsfRBb
         QuPldIiZ5oAfiR68Na2muFxYHdqY+TfQFNaV93rOmxpHGelvQLPLCI4bzfwf3qSaQfYe
         Zu3Hf3gusU3C+IMPvriotKeHQHLAYTiLznt7ClzixpxpTgAzEOzpKPxSPwGigT/uX3oK
         oI+A==
X-Gm-Message-State: AOAM533BZeZ/oygSBJtLJxZJFjGPbs7RlW77C1VjHItcCatLxvuZ97Gw
        OkvZYJoQOI7FSrtD/Bx+QeasT5OuR/+HDw/GcMQysTeDSHr5
X-Google-Smtp-Source: ABdhPJwgC6e22Cp0ykhm2INsebuJFztg2PDNXj0qUcA7q3gqFvMvUyfMXpia2HUhXV6wx+y46zGRc4pEyU+LV0j1rqP95xaIvk4W
MIME-Version: 1.0
X-Received: by 2002:a5d:9d9c:: with SMTP id ay28mr13948377iob.26.1637195603052;
 Wed, 17 Nov 2021 16:33:23 -0800 (PST)
Date:   Wed, 17 Nov 2021 16:33:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000590fa305d1054e24@google.com>
Subject: [syzbot] INFO: task hung in blkdev_get_by_dev (2)
From:   syzbot <syzbot+8325c16da4174fb30a26@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ee1703cda8dc Merge tag 'hyperv-fixes-signed-20211117' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106a11c9b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7264d1cb8ba2795
dashboard link: https://syzkaller.appspot.com/bug?extid=8325c16da4174fb30a26
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8325c16da4174fb30a26@syzkaller.appspotmail.com

INFO: task syz-executor.3:6555 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:23840 pid: 6555 ppid:     1 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 blkdev_get_by_dev.part.0+0x9b/0xb50 block/bdev.c:819
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:859
 blkdev_open+0x154/0x2e0 block/fops.c:501
 do_dentry_open+0x4c8/0x1250 fs/open.c:822
 do_open fs/namei.c:3426 [inline]
 path_openat+0x1cad/0x2750 fs/namei.c:3559
 do_filp_open+0x1aa/0x400 fs/namei.c:3586
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_sys_openat fs/open.c:1244 [inline]
 __se_sys_openat fs/open.c:1239 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1239
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3e2302ba04
RSP: 002b:00007fffeddde3e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fffeddde4e0 RCX: 00007f3e2302ba04
RDX: 0000000000000002 RSI: 00007fffeddde520 RDI: 00000000ffffff9c
RBP: 00007fffeddde520 R08: 0000000000000000 R09: 00007fffeddde2f0
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000009 R15: 00007fffeddde520
 </TASK>
INFO: task systemd-udevd:9608 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-udevd   state:D stack:26040 pid: 9608 ppid:  2974 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 __loop_clr_fd+0x1ae/0x1070 drivers/block/loop.c:1122
 lo_release+0x1ac/0x1f0 drivers/block/loop.c:1761
 blkdev_put_whole block/bdev.c:694 [inline]
 blkdev_put+0x2fb/0x9e0 block/bdev.c:956
 blkdev_close+0x6a/0x80 block/fops.c:515
 __fput+0x286/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8febedd270
RSP: 002b:00007fff5ede1b08 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007f8febedd270
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007f8fecd97710 R08: 000055f7f8a17e60 R09: 000055f7f8a17c00
R10: 00007f8fecd978c0 R11: 0000000000000246 R12: 0000000000000000
R13: 000055f7f8a17810 R14: 0000000000000003 R15: 000000000000000e
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8bb80f60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by in:imklog/6441:
 #0: ffff88806e510bb0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:990
4 locks held by rs:main Q:Reg/6442:
 #0: ffff8880b9d39b18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:478
 #1: ffff8880b9d279c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3a6/0x490 kernel/sched/psi.c:880
 #2: ffff88806b33d670 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:783 [inline]
 #2: ffff88806b33d670 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at: ext4_buffered_write_iter+0xb6/0x3b0 fs/ext4/file.c:263
 #3: ffff88806b33d9d0 (&ei->i_raw_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #3: ffff88806b33d9d0 (&ei->i_raw_lock){+.+.}-{2:2}, at: ext4_do_update_inode fs/ext4/inode.c:5077 [inline]
 #3: ffff88806b33d9d0 (&ei->i_raw_lock){+.+.}-{2:2}, at: ext4_mark_iloc_dirty+0x207/0x1cf0 fs/ext4/inode.c:5694
1 lock held by syz-executor.3/6555:
 #0: ffff88801af71118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb50 block/bdev.c:819
2 locks held by systemd-udevd/9608:
 #0: ffff88801af71118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x97/0x9e0 block/bdev.c:914
 #1: ffff88801af39b60 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x7a/0x1070 drivers/block/loop.c:1106

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 26 Comm: khungtaskd Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2961 Comm: systemd-journal Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0x3bd/0x54a0 kernel/locking/lockdep.c:4975
Code: 00 00 fc ff df 45 89 7c 24 20 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 84 11 00 00 8b 84 24 38 01 00 00 <41> 89 44 24 24 48 8b 6c 24 10 be 08 00 00 00 81 e5 ff 1f 00 00 48
RSP: 0018:ffffc90001a678f8 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff8880b9d35620 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888014d80d04
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888014d80ce0
R13: ffff888014d80280 R14: 0000000000040000 R15: 00000000000c0021
FS:  00007f103cfef8c0(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f103a5ec000 CR3: 000000007795a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 rmqueue_pcplist mm/page_alloc.c:3644 [inline]
 rmqueue mm/page_alloc.c:3682 [inline]
 get_page_from_freelist+0x4aa/0x2f50 mm/page_alloc.c:4146
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5369
 __alloc_pages_node include/linux/gfp.h:570 [inline]
 kmem_getpages mm/slab.c:1377 [inline]
 cache_grow_begin+0x75/0x470 mm/slab.c:2593
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2965
 ____cache_alloc mm/slab.c:3048 [inline]
 ____cache_alloc mm/slab.c:3031 [inline]
 __do_cache_alloc mm/slab.c:3275 [inline]
 slab_alloc mm/slab.c:3316 [inline]
 kmem_cache_alloc+0x450/0x560 mm/slab.c:3507
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags include/linux/audit.h:323 [inline]
 getname fs/namei.c:217 [inline]
 __do_sys_mkdir fs/namei.c:3929 [inline]
 __se_sys_mkdir fs/namei.c:3927 [inline]
 __x64_sys_mkdir+0xda/0x140 fs/namei.c:3927
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f103c2aa687
Code: 00 b8 ff ff ff ff c3 0f 1f 40 00 48 8b 05 09 d8 2b 00 64 c7 00 5f 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 d7 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffdc5cac1b8 EFLAGS: 00000293 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007ffdc5caf220 RCX: 00007f103c2aa687
RDX: 0000000000000000 RSI: 00000000000001ed RDI: 00005593d09db8c0
RBP: 00007ffdc5cac1f0 R08: 00005593d00583e5 R09: 0000000000000018
R10: 0000000000000069 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00005593d09db8c0 R15: 00007ffdc5cac830
 </TASK>
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	df 45 89             	filds  -0x77(%rbp)
   3:	7c 24                	jl     0x29
   5:	20 0f                	and    %cl,(%rdi)
   7:	b6 14                	mov    $0x14,%dh
   9:	02 48 89             	add    -0x77(%rax),%cl
   c:	f8                   	clc
   d:	83 e0 07             	and    $0x7,%eax
  10:	83 c0 03             	add    $0x3,%eax
  13:	38 d0                	cmp    %dl,%al
  15:	7c 08                	jl     0x1f
  17:	84 d2                	test   %dl,%dl
  19:	0f 85 84 11 00 00    	jne    0x11a3
  1f:	8b 84 24 38 01 00 00 	mov    0x138(%rsp),%eax
* 26:	41 89 44 24 24       	mov    %eax,0x24(%r12) <-- trapping instruction
  2b:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
  30:	be 08 00 00 00       	mov    $0x8,%esi
  35:	81 e5 ff 1f 00 00    	and    $0x1fff,%ebp
  3b:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
