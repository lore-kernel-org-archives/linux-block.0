Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4424C433EF
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 16:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbhKXQDy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 11:03:54 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:34594 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348314AbhKXQDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 11:03:38 -0500
Received: by mail-il1-f200.google.com with SMTP id e1-20020a056e020b2100b00299addac2a4so2154042ilu.1
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 08:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+ZNciu7HbiMJYkkN0h2daz6frE5XM098ZZFBi/fMcmc=;
        b=GojE67Ks/bM4gc70szSNTJRQEbuip6eMl3q746QVFeut3WWeksOOMpw1TNM42Sux2d
         Dl4JaCaLDLs3YgqdiOweKHUQgE/XPnW0ESpXUoGIPhk7eXfbmO76DLt5hjT5z/2VzwFW
         p+jzqJHYgMSS79fXtJHOfXsXMlYfT/b16MmHc2ThQCfaKZPiS1QKbeuFr8rmsvEp5Lb9
         8lk41O3JKSPhjRGoPpalJZRDMuLp7hbvcxTYcuv1p/O+q1p5v6ZQ4UgA40dprMwJFl3k
         xIdHqNBwgUOVuCC3b7+N6iiAhyu909/SS2ZNAFSXMyUALkifm9nyQmUJxA0GW0zgh44I
         qbMQ==
X-Gm-Message-State: AOAM530gZ4utlxasqsT2ic1gBsCvrpUtiEiISgma/Fe0itJhlULczvd6
        DtDQU445+t7oaqEebzp8ifhf7J40lMDEZoaZ7LoCMlcSNznG
X-Google-Smtp-Source: ABdhPJyCqv1ryqS3XGV1f904M1aAcA3M03JWwQUplZpcLnDRDV4wB3SUL5xt+jp5C03xEkO/00gDdb9oqusOzpMMcvoORHzTSRIs
MIME-Version: 1.0
X-Received: by 2002:a92:c54d:: with SMTP id a13mr13988683ilj.143.1637769628710;
 Wed, 24 Nov 2021 08:00:28 -0800 (PST)
Date:   Wed, 24 Nov 2021 08:00:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f17e3505d18af405@google.com>
Subject: [syzbot] possible deadlock in bd_register_pending_holders (2)
From:   syzbot <syzbot+4b74d06c264d2c1e5af3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a90af8f15bdc Merge tag 'libata-5.16-rc2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10575be6b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c3ab72998e7f1a4
dashboard link: https://syzkaller.appspot.com/bug?extid=4b74d06c264d2c1e5af3
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b74d06c264d2c1e5af3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.16.0-rc1-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.3/4793 is trying to acquire lock:
ffff88801fc2f118 (&disk->open_mutex){+.+.}-{3:3}, at: bd_register_pending_holders+0x32/0x370 block/holder.c:161

but task is already holding lock:
ffffffff8d8dbf88 (disks_mutex){+.+.}-{3:3}, at: md_alloc+0x32/0xbc0 drivers/md/md.c:5658

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #9 (disks_mutex){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:607
       __mutex_lock kernel/locking/mutex.c:740 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:792
       md_alloc+0x32/0xbc0 drivers/md/md.c:5658
       blk_request_module+0x19d/0x1c0 block/genhd.c:690
       blkdev_get_no_open+0x37/0x180 block/bdev.c:742
       blkdev_get_by_dev+0x84/0xb80 block/bdev.c:806
       swsusp_check+0xb0/0x2b0 kernel/power/swap.c:1520
       software_resume+0xc8/0x3d0 kernel/power/hibernate.c:979
       resume_store+0xdc/0x120 kernel/power/hibernate.c:1181
       kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2162 [inline]
       new_sync_write fs/read_write.c:503 [inline]
       vfs_write+0xb11/0xe90 fs/read_write.c:590
       ksys_write+0x18f/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #8 (major_names_lock){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:607
       __mutex_lock kernel/locking/mutex.c:740 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:792
       blk_request_module+0x2f/0x1c0 block/genhd.c:687
       blkdev_get_no_open+0x37/0x180 block/bdev.c:742
       blkdev_get_by_dev+0x84/0xb80 block/bdev.c:806
       swsusp_check+0xb0/0x2b0 kernel/power/swap.c:1520
       software_resume+0xc8/0x3d0 kernel/power/hibernate.c:979
       resume_store+0xdc/0x120 kernel/power/hibernate.c:1181
       kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2162 [inline]
       new_sync_write fs/read_write.c:503 [inline]
       vfs_write+0xb11/0xe90 fs/read_write.c:590
       ksys_write+0x18f/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #7 (system_transition_mutex/1){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:607
       __mutex_lock kernel/locking/mutex.c:740 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:792
       software_resume+0x7a/0x3d0 kernel/power/hibernate.c:934
       resume_store+0xdc/0x120 kernel/power/hibernate.c:1181
       kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2162 [inline]
       new_sync_write fs/read_write.c:503 [inline]
       vfs_write+0xb11/0xe90 fs/read_write.c:590
       ksys_write+0x18f/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #6 (&of->mutex){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:607
       __mutex_lock kernel/locking/mutex.c:740 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:792
       kernfs_seq_start+0x50/0x3b0 fs/kernfs/file.c:112
       seq_read_iter+0x401/0xdc0 fs/seq_file.c:225
       call_read_iter include/linux/fs.h:2156 [inline]
       new_sync_read fs/read_write.c:400 [inline]
       vfs_read+0xaf9/0xe60 fs/read_write.c:481
       ksys_read+0x18f/0x2c0 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (&p->lock){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:607
       __mutex_lock kernel/locking/mutex.c:740 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:792
       seq_read_iter+0xb6/0xdc0 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2156 [inline]
       generic_file_splice_read+0x482/0x760 fs/splice.c:311
       do_splice_to fs/splice.c:796 [inline]
       splice_direct_to_actor+0x45f/0xd00 fs/splice.c:870
       do_splice_direct+0x291/0x3e0 fs/splice.c:979
       do_sendfile+0x6fe/0x1040 fs/read_write.c:1245
       __do_sys_sendfile64 fs/read_write.c:1310 [inline]
       __se_sys_sendfile64+0x171/0x1d0 fs/read_write.c:1296
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (sb_writers#3){.+.+}-{0:0}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1810 [inline]
       sb_start_write include/linux/fs.h:1880 [inline]
       file_start_write include/linux/fs.h:3009 [inline]
       lo_write_bvec drivers/block/loop.c:242 [inline]
       lo_write_simple drivers/block/loop.c:265 [inline]
       do_req_filebacked drivers/block/loop.c:494 [inline]
       loop_handle_cmd drivers/block/loop.c:1857 [inline]
       loop_process_work+0x1682/0x22d0 drivers/block/loop.c:1897
       process_one_work+0x853/0x1140 kernel/workqueue.c:2298
       worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
       kthread+0x468/0x490 kernel/kthread.c:327
       ret_from_fork+0x1f/0x30

-> #3 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       process_one_work+0x827/0x1140 kernel/workqueue.c:2274
       worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
       kthread+0x468/0x490 kernel/kthread.c:327
       ret_from_fork+0x1f/0x30

-> #2 ((wq_completion)loop5){+.+.}-{0:0}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       flush_workqueue+0x18e/0x16b0 kernel/workqueue.c:2818
       drain_workqueue+0xc3/0x3a0 kernel/workqueue.c:2983
       destroy_workqueue+0x7d/0xed0 kernel/workqueue.c:4420
       __loop_clr_fd+0x1ec/0x9b0 drivers/block/loop.c:1124
       blkdev_put_whole block/bdev.c:694 [inline]
       blkdev_put+0x477/0x7b0 block/bdev.c:956
       deactivate_locked_super+0xa7/0xf0 fs/super.c:335
       cleanup_mnt+0x462/0x510 fs/namespace.c:1137
       task_work_run+0x146/0x1c0 kernel/task_work.c:164
       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
       exit_to_user_mode_prepare+0x209/0x220 kernel/entry/common.c:207
       __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
       syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
       do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&lo->lo_mutex){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:607
       __mutex_lock kernel/locking/mutex.c:740 [inline]
       mutex_lock_killable_nested+0x1a/0x20 kernel/locking/mutex.c:807
       lo_open+0x68/0x100 drivers/block/loop.c:1733
       blkdev_get_whole+0x8c/0x3d0 block/bdev.c:671
       blkdev_get_by_dev+0x298/0xb80 block/bdev.c:826
       blkdev_open+0x137/0x2f0 block/fops.c:501
       do_dentry_open+0x78b/0x1020 fs/open.c:822
       do_open fs/namei.c:3426 [inline]
       path_openat+0x2896/0x3660 fs/namei.c:3559
       do_filp_open+0x277/0x4f0 fs/namei.c:3586
       do_sys_openat2+0x13b/0x500 fs/open.c:1212
       do_sys_open fs/open.c:1228 [inline]
       __do_sys_open fs/open.c:1236 [inline]
       __se_sys_open fs/open.c:1232 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1232
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&disk->open_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3801
       __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:607
       __mutex_lock kernel/locking/mutex.c:740 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:792
       bd_register_pending_holders+0x32/0x370 block/holder.c:161
       device_add_disk+0x4d4/0xe00 block/genhd.c:485
       add_disk include/linux/genhd.h:212 [inline]
       md_alloc+0x819/0xbc0 drivers/md/md.c:5717
       blk_request_module+0x19d/0x1c0 block/genhd.c:690
       blkdev_get_no_open+0x37/0x180 block/bdev.c:742
       blkdev_get_by_dev+0x84/0xb80 block/bdev.c:806
       swsusp_check+0xb0/0x2b0 kernel/power/swap.c:1520
       software_resume+0xc8/0x3d0 kernel/power/hibernate.c:979
       resume_store+0xdc/0x120 kernel/power/hibernate.c:1181
       kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2162 [inline]
       new_sync_write fs/read_write.c:503 [inline]
       vfs_write+0xb11/0xe90 fs/read_write.c:590
       ksys_write+0x18f/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &disk->open_mutex --> major_names_lock --> disks_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(disks_mutex);
                               lock(major_names_lock);
                               lock(disks_mutex);
  lock(&disk->open_mutex);

 *** DEADLOCK ***

7 locks held by syz-executor.3/4793:
 #0: ffff88807d658af0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x2f0 fs/file.c:990
 #1: ffff88807eb10460 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x2b5/0xe90 fs/read_write.c:586
 #2: ffff88803209ec88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1f3/0x510 fs/kernfs/file.c:287
 #3: ffff888015d9c830 (kn->active#624){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x217/0x510 fs/kernfs/file.c:288
 #4: ffffffff8c9d5ce8 (system_transition_mutex/1){+.+.}-{3:3}, at: software_resume+0x7a/0x3d0 kernel/power/hibernate.c:934
 #5: ffffffff8d1116a8 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x2f/0x1c0 block/genhd.c:687
 #6: ffffffff8d8dbf88 (disks_mutex){+.+.}-{3:3}, at: md_alloc+0x32/0xbc0 drivers/md/md.c:5658

stack backtrace:
CPU: 1 PID: 4793 Comm: syz-executor.3 Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 check_noncircular+0x2f9/0x3b0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3801
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
 __mutex_lock_common+0x1d5/0x2590 kernel/locking/mutex.c:607
 __mutex_lock kernel/locking/mutex.c:740 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:792
 bd_register_pending_holders+0x32/0x370 block/holder.c:161
 device_add_disk+0x4d4/0xe00 block/genhd.c:485
 add_disk include/linux/genhd.h:212 [inline]
 md_alloc+0x819/0xbc0 drivers/md/md.c:5717
 blk_request_module+0x19d/0x1c0 block/genhd.c:690
 blkdev_get_no_open+0x37/0x180 block/bdev.c:742
 blkdev_get_by_dev+0x84/0xb80 block/bdev.c:806
 swsusp_check+0xb0/0x2b0 kernel/power/swap.c:1520
 software_resume+0xc8/0x3d0 kernel/power/hibernate.c:979
 resume_store+0xdc/0x120 kernel/power/hibernate.c:1181
 kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write fs/read_write.c:503 [inline]
 vfs_write+0xb11/0xe90 fs/read_write.c:590
 ksys_write+0x18f/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7faf24dbbae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faf22331188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007faf24ecef60 RCX: 00007faf24dbbae9
RDX: 000000004000fdef RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007faf24e15f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffedf87dfff R14: 00007faf22331300 R15: 0000000000022000
 </TASK>
PM: Image not found (code -5)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
