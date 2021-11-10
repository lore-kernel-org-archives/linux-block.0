Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B939C433EF
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 17:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6278A61241
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 17:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhKJRDO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 12:03:14 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:44827 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhKJRDN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 12:03:13 -0500
Received: by mail-il1-f200.google.com with SMTP id j13-20020a056e02218d00b002677e6a569bso2251086ila.11
        for <linux-block@vger.kernel.org>; Wed, 10 Nov 2021 09:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n2JaGPPuTXM2KMU3jZNUcM1eL7paw782h+TnAafsbMU=;
        b=CHu38PmG9pbGFuMf3VMXsEtz8ptqoMr4kPPzlwnA44/RY+OE5f0fAIBAucPFbW2TL8
         jEUSvYnZHCsObQXD2VIBoDaz2wvXhP6Kl+/P2zYCei6ZaV67PAveRm7dv4pG6OXB2djY
         lsKtB2L+hOwlpHdU0vN/4eM5rIE5XEfcVjRUdPee8h28/p6U9sGgNLmFeXp8h7+ejF1W
         XxZ+n9bQUb7ghawn0xRWk4mS6JrKvpymD16HfuxPeROY3zM82yUlmj8Nh2Y5td2145LR
         2yCJg+VWjwhFVEz+QLynycYx8y8d7EYliX0THXFCVhlkarMaCh26a9SL5siYLrQMYnq/
         n+iA==
X-Gm-Message-State: AOAM532EBhtceueNcsXPecglP07k5mLfXhWAhJxwlulmQwmPZCET8BrW
        LwdYD4YfqW2Jg49dfM9ejiIBhSxzqQlmYEldPR8jGaFWf8Cc
X-Google-Smtp-Source: ABdhPJxTbfFVuPuDvGTMOO14y+ZuZsiwZudVCijaqnEtQKVAqz5a+jgZPVJE7KOXPs/CiVkRNjRVo2r+lRItC0E1igk4S9MsLsXM
MIME-Version: 1.0
X-Received: by 2002:a5e:9918:: with SMTP id t24mr364116ioj.161.1636563625262;
 Wed, 10 Nov 2021 09:00:25 -0800 (PST)
Date:   Wed, 10 Nov 2021 09:00:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089436205d07229eb@google.com>
Subject: [syzbot] possible deadlock in __loop_clr_fd (3)
From:   syzbot <syzbot+63614029dfb79abd4383@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb690f5238d7 Merge tag 'for-5.16/drivers-2021-11-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1611368ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
dashboard link: https://syzkaller.appspot.com/bug?extid=63614029dfb79abd4383
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63614029dfb79abd4383@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.15.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/23454 is trying to acquire lock:
ffff8880222c2938 ((wq_completion)loop1){+.+.}-{0:0}, at: flush_workqueue+0xe1/0x15b0 kernel/workqueue.c:2815

but task is already holding lock:
ffff88801a7e9360 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x7a/0x1070 drivers/block/loop.c:1106

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&lo->lo_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       lo_open+0x75/0x120 drivers/block/loop.c:1733
       blkdev_get_whole+0x99/0x2d0 block/bdev.c:671
       blkdev_get_by_dev.part.0+0x354/0xb50 block/bdev.c:826
       blkdev_get_by_dev+0x6b/0x80 block/bdev.c:859
       blkdev_open+0x154/0x2e0 block/fops.c:501
       do_dentry_open+0x4c8/0x1250 fs/open.c:822
       do_open fs/namei.c:3426 [inline]
       path_openat+0x1cad/0x2750 fs/namei.c:3559
       do_filp_open+0x1aa/0x400 fs/namei.c:3586
       do_sys_openat2+0x16d/0x4d0 fs/open.c:1212
       do_sys_open fs/open.c:1228 [inline]
       __do_sys_open fs/open.c:1236 [inline]
       __se_sys_open fs/open.c:1232 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1232
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #6 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       blkdev_get_by_dev.part.0+0x24e/0xb50 block/bdev.c:819
       blkdev_get_by_dev+0x6b/0x80 block/bdev.c:859
       swsusp_check+0x97/0x2f0 kernel/power/swap.c:1520
       software_resume.part.0+0x102/0x1f0 kernel/power/hibernate.c:979
       software_resume kernel/power/hibernate.c:86 [inline]
       resume_store+0x161/0x190 kernel/power/hibernate.c:1181
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2162 [inline]
       new_sync_write+0x429/0x660 fs/read_write.c:503
       vfs_write+0x7cd/0xae0 fs/read_write.c:590
       ksys_write+0x12d/0x250 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (system_transition_mutex/1){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       software_resume.part.0+0x19/0x1f0 kernel/power/hibernate.c:934
       software_resume kernel/power/hibernate.c:86 [inline]
       resume_store+0x161/0x190 kernel/power/hibernate.c:1181
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2162 [inline]
       new_sync_write+0x429/0x660 fs/read_write.c:503
       vfs_write+0x7cd/0xae0 fs/read_write.c:590
       ksys_write+0x12d/0x250 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (&of->mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       kernfs_fop_write_iter+0x287/0x500 fs/kernfs/file.c:287
       call_write_iter include/linux/fs.h:2162 [inline]
       do_iter_readv_writev+0x472/0x750 fs/read_write.c:725
       do_iter_write+0x188/0x710 fs/read_write.c:851
       vfs_iter_write+0x70/0xa0 fs/read_write.c:892
       iter_file_splice_write+0x723/0xc70 fs/splice.c:689
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xb7e/0x1960 fs/splice.c:1079
       __do_splice+0x134/0x250 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice fs/splice.c:1332 [inline]
       __x64_sys_splice+0x198/0x250 fs/splice.c:1332
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (&pipe->mutex/1){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       pipe_lock_nested fs/pipe.c:81 [inline]
       pipe_lock+0x5a/0x70 fs/pipe.c:89
       iter_file_splice_write+0x183/0xc70 fs/splice.c:635
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xb7e/0x1960 fs/splice.c:1079
       __do_splice+0x134/0x250 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice fs/splice.c:1332 [inline]
       __x64_sys_splice+0x198/0x250 fs/splice.c:1332
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1810 [inline]
       sb_start_write include/linux/fs.h:1880 [inline]
       file_start_write include/linux/fs.h:3009 [inline]
       lo_write_bvec drivers/block/loop.c:242 [inline]
       lo_write_simple drivers/block/loop.c:265 [inline]
       do_req_filebacked drivers/block/loop.c:494 [inline]
       loop_handle_cmd drivers/block/loop.c:1857 [inline]
       loop_process_work+0x1499/0x1db0 drivers/block/loop.c:1897
       process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
       kthread+0x405/0x4f0 kernel/kthread.c:327
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x921/0x1690 kernel/workqueue.c:2274
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
       kthread+0x405/0x4f0 kernel/kthread.c:327
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 ((wq_completion)loop1){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5637 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
       flush_workqueue+0x110/0x15b0 kernel/workqueue.c:2818
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2983
       destroy_workqueue+0x71/0x800 kernel/workqueue.c:4420
       __loop_clr_fd+0x1de/0x1070 drivers/block/loop.c:1124
       loop_clr_fd drivers/block/loop.c:1237 [inline]
       lo_ioctl+0x398/0x17c0 drivers/block/loop.c:1562
       blkdev_ioctl+0x37a/0x800 block/ioctl.c:597
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:874 [inline]
       __se_sys_ioctl fs/ioctl.c:860 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  (wq_completion)loop1 --> &disk->open_mutex --> &lo->lo_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&lo->lo_mutex);
                               lock(&disk->open_mutex);
                               lock(&lo->lo_mutex);
  lock((wq_completion)loop1);

 *** DEADLOCK ***

1 lock held by syz-executor.1/23454:
 #0: ffff88801a7e9360 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x7a/0x1070 drivers/block/loop.c:1106

stack backtrace:
CPU: 1 PID: 23454 Comm: syz-executor.1 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 flush_workqueue+0x110/0x15b0 kernel/workqueue.c:2818
 drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2983
 destroy_workqueue+0x71/0x800 kernel/workqueue.c:4420
 __loop_clr_fd+0x1de/0x1070 drivers/block/loop.c:1124
 loop_clr_fd drivers/block/loop.c:1237 [inline]
 lo_ioctl+0x398/0x17c0 drivers/block/loop.c:1562
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:597
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f77a49078a7
Code: 3c 1c 48 f7 d8 49 39 c4 72 b8 e8 04 54 02 00 85 c0 78 bd 48 83 c4 08 4c 89 e0 5b 41 5c c3 0f 1f 44 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f77a4f4ed78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f77a4f4ee00 RCX: 00007f77a49078a7
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 00007f77a4f4ec10
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000000000 R14: 0000000000000014 R15: 00007f77a4f4ee40
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
