Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3400C433F5
	for <linux-block@archiver.kernel.org>; Mon, 22 Nov 2021 17:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbhKVRRl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:17:41 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:50820 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbhKVRRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Nov 2021 12:17:36 -0500
Received: by mail-il1-f199.google.com with SMTP id i3-20020a056e021b0300b0029eceae8532so2100616ilv.17
        for <linux-block@vger.kernel.org>; Mon, 22 Nov 2021 09:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nOFOOZq0Xnv803GImLRJ8nsqJkamYuAbU9VuETjOBEY=;
        b=3MxkqFDG8NylTKXcRB+e6WyDL5zTPI2kYMAIcFgH1c87T+IPy5mRlUul3vOPcQZhvi
         /2edIBC95Mc9AAi3+2/R/hU6cwAnq1CBHzSFNqLTtPZU3ANHrqsna0vO/Ujgn9vlnqt6
         8riW2DMAkfwVDtPESzSO3on6sE47vg+UwOlUCrv9sGDfGJDxN/dLxFyg7yLKZbdsXZ+T
         Sp6RQk8WllwjN1gNLxjIWUtZCM2JaJD64R1szyPyhSuRwHI4I6Q6wdWWMcwXL9nV5u7h
         fVIHngrBGGK3TDDSPZgQHfI2gSxN+bWYZN3C7bngxiDZyLK1z7JLIvTycHYremArG8/e
         n6tg==
X-Gm-Message-State: AOAM531jEMXfil0fq05IiFUd6uiT3zuJzYWDtq6afM5CB+eWX2BTeR9N
        qFlp3I8YvaWEw4DMXepROW9pC9TiKPRRjiI/HR4za4npX1sq
X-Google-Smtp-Source: ABdhPJxXbfcSm6msjREpNLPlwyvDMd5LCxQAhAKQEi77y+0cutCANYNNqrUVDKJtl99GvkvL8zGWBN6dWWlHcOrGWBUvCY+qfWig
MIME-Version: 1.0
X-Received: by 2002:a92:cd8b:: with SMTP id r11mr20313593ilb.320.1637601269294;
 Mon, 22 Nov 2021 09:14:29 -0800 (PST)
Date:   Mon, 22 Nov 2021 09:14:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0afc805d163c152@google.com>
Subject: [syzbot] INFO: task hung in lo_release (2)
From:   syzbot <syzbot+5e403cab907a802d6a9f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4c388a8e740d Merge tag 'zstd-for-linus-5.16-rc1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143d2c06b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7264d1cb8ba2795
dashboard link: https://syzkaller.appspot.com/bug?extid=5e403cab907a802d6a9f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e403cab907a802d6a9f@syzkaller.appspotmail.com

INFO: task syz-executor.3:14593 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:26472 pid:14593 ppid:  8449 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 lo_release+0x160/0x1f0 drivers/block/loop.c:1768
 blkdev_put_whole block/bdev.c:694 [inline]
 blkdev_put+0x2fb/0x9e0 block/bdev.c:956
 btrfs_close_bdev fs/btrfs/volumes.c:1114 [inline]
 btrfs_close_bdev fs/btrfs/volumes.c:1104 [inline]
 btrfs_close_one_device fs/btrfs/volumes.c:1135 [inline]
 close_fs_devices+0x24f/0xa60 fs/btrfs/volumes.c:1178
 btrfs_close_devices+0x8e/0x4b0 fs/btrfs/volumes.c:1193
 open_ctree+0x48af/0x4954 fs/btrfs/disk-io.c:3700
 btrfs_fill_super fs/btrfs/super.c:1359 [inline]
 btrfs_mount_root.cold+0x15/0x162 fs/btrfs/super.c:1726
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1500
 fc_mount fs/namespace.c:994 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1024
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:1011
 btrfs_mount+0x234/0xa60 fs/btrfs/super.c:1786
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1500
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3318
 do_mount fs/namespace.c:3331 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3516
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fea85df401a
RSP: 002b:00007fea83367fa8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000200009c0 RCX: 00007fea85df401a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fea83368000
RBP: 00007fea83368040 R08: 00007fea83368040 R09: 0000000020000000
R10: 0000000000010809 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fea83368000 R15: 00000000200005c0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8bb80fe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by in:imklog/6236:
 #0: ffff888020fea8f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:990
2 locks held by kworker/u4:12/12192:
 #0: ffff8880b9d39b18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:478
 #1: ffffc90004a7fdb0 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
4 locks held by syz-executor.3/14593:
 #0: ffff88803a2da0e0 (&type->s_umount_key#73/1){+.+.}-{3:3}, at: alloc_super+0x1dd/0xac0 fs/super.c:229
 #1: ffffffff8c25fc48 (uuid_mutex){+.+.}-{3:3}, at: btrfs_close_devices+0x86/0x4b0 fs/btrfs/volumes.c:1192
 #2: ffff88801ad79118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x97/0x9e0 block/bdev.c:914
 #3: ffff88801adcab60 (&lo->lo_mutex){+.+.}-{3:3}, at: lo_release+0x4d/0x1f0 drivers/block/loop.c:1748

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 26 Comm: khungtaskd Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
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
RIP: 0010:PageTail include/linux/page-flags.h:237 [inline]
RIP: 0010:free_tail_pages_check+0x94/0x2d0 mm/page_alloc.c:1246
Code: b8 01 00 00 00 eb 4a 4c 8d 6e 08 4c 8d 66 18 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 fb 01 00 00 <48> 8b 45 08 f7 d0 83 e0 01 0f 85 56 01 00 00 48 8b 4d 08 48 8d 51
RSP: 0018:ffffc90002057c58 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: ffffea00023df100 RCX: ffffffff81b2a420
RDX: 1ffffd400047be29 RSI: 0000000000000004 RDI: ffffea00023df154
RBP: ffffea00023df140 R08: 0000000000000000 R09: ffffea00023df157
R10: fffff9400047be2a R11: 000000000000001f R12: ffffea00023df158
R13: ffffea00023df148 R14: ffffea00023df154 R15: ffffea00023df100
FS:  00007f24420758c0(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f243f5be000 CR3: 00000000776d0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 free_pages_prepare mm/page_alloc.c:1319 [inline]
 free_pcp_prepare+0x560/0x870 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3388
 slab_destroy mm/slab.c:1627 [inline]
 slabs_destroy+0x89/0xc0 mm/slab.c:1647
 cache_flusharray mm/slab.c:3418 [inline]
 ___cache_free+0x4cc/0x610 mm/slab.c:3480
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x4e/0x110 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x97/0xb0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc mm/slab.c:3323 [inline]
 kmem_cache_alloc+0x265/0x560 mm/slab.c:3507
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags include/linux/audit.h:323 [inline]
 getname fs/namei.c:217 [inline]
 __do_sys_mkdir fs/namei.c:3929 [inline]
 __se_sys_mkdir fs/namei.c:3927 [inline]
 __x64_sys_mkdir+0xda/0x140 fs/namei.c:3927
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2441330687
Code: 00 b8 ff ff ff ff c3 0f 1f 40 00 48 8b 05 09 d8 2b 00 64 c7 00 5f 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 d7 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffecd753e08 EFLAGS: 00000293 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007ffecd756e70 RCX: 00007f2441330687
RDX: 0000000000000000 RSI: 00000000000001ed RDI: 0000560cc21068c0
RBP: 00007ffecd753e40 R08: 0000560cc07433e5 R09: 0000000000000018
R10: 0000000000000069 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000560cc21068c0 R15: 00007ffecd754480
 </TASK>
----------------
Code disassembly (best guess):
   0:	b8 01 00 00 00       	mov    $0x1,%eax
   5:	eb 4a                	jmp    0x51
   7:	4c 8d 6e 08          	lea    0x8(%rsi),%r13
   b:	4c 8d 66 18          	lea    0x18(%rsi),%r12
   f:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  16:	fc ff df
  19:	4c 89 ea             	mov    %r13,%rdx
  1c:	48 c1 ea 03          	shr    $0x3,%rdx
  20:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  24:	0f 85 fb 01 00 00    	jne    0x225
* 2a:	48 8b 45 08          	mov    0x8(%rbp),%rax <-- trapping instruction
  2e:	f7 d0                	not    %eax
  30:	83 e0 01             	and    $0x1,%eax
  33:	0f 85 56 01 00 00    	jne    0x18f
  39:	48 8b 4d 08          	mov    0x8(%rbp),%rcx
  3d:	48                   	rex.W
  3e:	8d                   	.byte 0x8d
  3f:	51                   	push   %rcx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
