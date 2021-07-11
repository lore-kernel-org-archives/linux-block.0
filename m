Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252B7C07E96
	for <linux-block@archiver.kernel.org>; Sun, 11 Jul 2021 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC3761164
	for <linux-block@archiver.kernel.org>; Sun, 11 Jul 2021 15:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhGKP6J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Jul 2021 11:58:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:40726 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhGKP6J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Jul 2021 11:58:09 -0400
Received: by mail-il1-f197.google.com with SMTP id a18-20020a92c7120000b029020757e7bf9fso3806679ilp.7
        for <linux-block@vger.kernel.org>; Sun, 11 Jul 2021 08:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ovSoWS8nb0CSvEDvu13FQaSdyBmPdG9s6S/rf+oe9Rs=;
        b=RDpaxUEcn3c+l8CCvxDSBd/H9gkzxT/JNJ0MmAzJ3B13cpcZtL3ejSv+qG0ZlWV7M8
         vLqhGhTcnGXnFHr8aeInllk/Io3vwt92yA4Fk7/DA1FLjw9DeJgSalI7PK2I9TLccplp
         EwfkOL8ggqdH3Hk9LOiEY9J0k0a09Yeci7Wp+YbYOa4kBKqlbm+KwhTj7zVNWY0SM0Fp
         9qvEEi9b8sZQG29Fr/aX1EHbC/9IJRxKb4AXnyzxOkhevt+c54f/xfZr72rg74ohb6IJ
         Dcn3sN8ZtLtc8Px9qmVflHN9hzCQ9I/kAINfafFWorjHTGHGXHSxeNfJcoeNsOBlAhUM
         +tsA==
X-Gm-Message-State: AOAM533y8s2vHsYVDn2Mx9g8gP7ar3mPMyXLsre0eZQx+fYBalfwjIwO
        jvFqE3jgCFapvPN0NsVS4eJwRMdTEmUA0upFgUk1YT+jj+Qj
X-Google-Smtp-Source: ABdhPJwwDgJ2ngPGgq7aNwtmO8mUkob3D0juJDpdOOPGCNvH0S1yxbcg6VfeQ53MyFVhGchbgnSRKxPGChkKi0wNCtziCmwASfVE
MIME-Version: 1.0
X-Received: by 2002:a5d:85c1:: with SMTP id e1mr35364080ios.18.1626018922091;
 Sun, 11 Jul 2021 08:55:22 -0700 (PDT)
Date:   Sun, 11 Jul 2021 08:55:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fdaa905c6db08d0@google.com>
Subject: [syzbot] INFO: task hung in del_gendisk
From:   syzbot <syzbot+0fe7752e52337864d29b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hare@suse.de, hch@lst.de, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a845d8300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1700b0b2b41cd52c
dashboard link: https://syzkaller.appspot.com/bug?extid=0fe7752e52337864d29b
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156d30d2300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bc89c4300000

The issue was bisected to:

commit c76f48eb5c084b1e15c931ae8cc1826cd771d70d
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 6 06:22:56 2021 +0000

    block: take bd_mutex around delete_partitions in del_gendisk

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1630eac4300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1530eac4300000
console output: https://syzkaller.appspot.com/x/log.txt?x=1130eac4300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0fe7752e52337864d29b@syzkaller.appspotmail.com
Fixes: c76f48eb5c08 ("block: take bd_mutex around delete_partitions in del_gendisk")

INFO: task systemd-udevd:8423 blocked for more than 143 seconds.
      Tainted: G        W         5.13.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-udevd   state:D stack:25776 pid: 8423 ppid:  4859 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6078
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 del_gendisk+0x86/0x610 block/genhd.c:587
 nbd_dev_remove drivers/block/nbd.c:224 [inline]
 nbd_put+0x8d/0x170 drivers/block/nbd.c:246
 blkdev_put_whole fs/block_dev.c:1277 [inline]
 blkdev_put+0x470/0x810 fs/block_dev.c:1574
 blkdev_close+0x7a/0xa0 fs/block_dev.c:1584
 __fput+0x352/0x7b0 fs/file_table.c:280
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x201/0x220 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:302
 do_syscall_64+0x4c/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fbc7200f270
RSP: 002b:00007ffca87ce908 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007fbc7200f270
RDX: 000000000aba9500 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007fbc72ec9710 R08: 000000000000004a R09: 0000000000000008
R10: 00005640bf30ff58 R11: 0000000000000246 R12: 0000000000000000
R13: 00005640bf324680 R14: 0000000000000003 R15: 000000000000000e
INFO: task syz-executor861:8425 blocked for more than 143 seconds.
      Tainted: G        W         5.13.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor861 state:D stack:27216 pid: 8425 ppid:  8420 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6078
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 nbd_genl_connect+0x24f/0x1aa0 drivers/block/nbd.c:1801
 genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0xfb4/0x13c0 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x1f0/0x460 net/netlink/af_netlink.c:2504
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x7de/0x9b0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0xaa6/0xe90 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:702 [inline]
 sock_sendmsg net/socket.c:722 [inline]
 ____sys_sendmsg+0x5a2/0x900 net/socket.c:2385
 ___sys_sendmsg net/socket.c:2439 [inline]
 __sys_sendmsg+0x319/0x400 net/socket.c:2468
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4414f9
RSP: 002b:00007fff264c11e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000000882dd RCX: 00000000004414f9
RDX: 0000000000000800 RSI: 0000000020000340 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007fff264c11f0 R11: 0000000000000246 R12: 00007fff264c121c
R13: 431bde82d7b634db R14: 00007fff264c1230 R15: 00000000004004a0
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 1641 Comm: khungtaskd Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0x1d3/0x29f lib/dump_stack.c:96
 nmi_cpu_backtrace+0x16c/0x190 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x191/0x2f0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd06/0xd50 kernel/hung_task.c:294
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 8402 Comm: kworker/0:3 Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_power_efficient toggle_allocation_gate
RIP: 0010:kasan_mem_to_shadow include/linux/kasan.h:54 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x4d/0x2f0 mm/kasan/generic.c:189
Code: 48 c1 eb 2f 81 fb fe ff 01 00 0f 86 7a 02 00 00 49 89 fc 49 c1 ec 03 49 b8 00 00 00 00 00 fc ff df 4f 8d 0c 04 4c 8d 54 37 ff <49> c1 ea 03 49 bd 01 00 00 00 00 fc ff df 4d 01 ea 4d 89 d6 4d 29
RSP: 0018:ffffc90001c9f788 EFLAGS: 00000806
RAX: ffff8880300f0001 RBX: 000000000001ffff RCX: ffffffff812de007
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff8fa3b199
RBP: ffffc90001c9f990 R08: dffffc0000000000 R09: fffffbfff1f47633
R10: ffffffff8fa3b199 R11: 0000000000000000 R12: 1ffffffff1f47633
R13: dffffc0000000000 R14: ffffffff8fa3b199 R15: 00002aaaaaaabd81
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f42e3bca000 CR3: 00000001400d4000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 memcpy+0x25/0x60 mm/kasan/shadow.c:65
 __text_poke+0x557/0x8c0 arch/x86/kernel/alternative.c:841
 text_poke arch/x86/kernel/alternative.c:900 [inline]
 text_poke_bp_batch+0x6b0/0x940 arch/x86/kernel/alternative.c:1178
 text_poke_flush arch/x86/kernel/alternative.c:1268 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1275
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:145
 static_key_enable_cpuslocked+0x12d/0x250 kernel/jump_label.c:177
 static_key_enable+0x16/0x20 kernel/jump_label.c:190
 toggle_allocation_gate+0xbf/0x440 mm/kfence/core.c:623
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
