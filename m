Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F79C433F5
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391E9611BD
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 14:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhIJOnk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:43:40 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47696 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhIJOnj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 10:43:39 -0400
Received: by mail-io1-f70.google.com with SMTP id f1-20020a5edf01000000b005b85593f933so3220111ioq.14
        for <linux-block@vger.kernel.org>; Fri, 10 Sep 2021 07:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=D6ipSBinxwEjpTWl+5ibPA+j01Zg4SEDU51j224F9Y8=;
        b=iSB5HGsK7njj7NgF8akNgfTGRy9qO8T9kGN6i6cP15KoCXkF7ywX/z7KULSyYS9LmX
         7tJAOu4rGj0WLW3R9XKItAD1+qZoDmEztZ1Aiuh6SynGytN6SsRf/7k3n568IA3vFml9
         11BD6nITceXYePvd0kYMxSt/pNWhQTRMT2fpWnu6H9VTwUtHQyx6jTeskGN5EkCkaYA5
         r2jkZZ1tQiOmPt418f2eGG4goBzxz7cUbK6ei1FDM3aVbx9VAh65uuSNZAFAer4vHAEQ
         +Y2Fgb0vlcm6ewV1ax9eIQ1CkkfyQUUsB1vAaXorOJ4CZmXF9dcR1zE4YkeMpscz3e7u
         Zi2Q==
X-Gm-Message-State: AOAM530mkdw4+sgMPgFfejS1JcXiqNDFOjTV4O29D5EKvYmEWjytfpsh
        H4caBmnFwL+SmTYDl5LV+NiqhRlWW5tX0cbplctbgR1K24+u
X-Google-Smtp-Source: ABdhPJx9IosYfIK0a/6aKGcdv7Zq23qhPXBECBQHNvOqe2uBG63biwn5PbaXRSwgejWBWXgowEO5Dh6H5GaBCZp4VJcTy3w8vsKq
MIME-Version: 1.0
X-Received: by 2002:a5e:d80c:: with SMTP id l12mr7410193iok.120.1631284948527;
 Fri, 10 Sep 2021 07:42:28 -0700 (PDT)
Date:   Fri, 10 Sep 2021 07:42:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e272fb05cba51fe4@google.com>
Subject: [syzbot] possible deadlock in bd_register_pending_holders
From:   syzbot <syzbot+f5608de5d89cc0d998c7@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    27151f177827 Merge tag 'perf-tools-for-v5.15-2021-09-04' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104612b3300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac2f9cc43f6b17e4
dashboard link: https://syzkaller.appspot.com/bug?extid=f5608de5d89cc0d998c7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5608de5d89cc0d998c7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.14.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/10219 is trying to acquire lock:
ffff8880288d5918 (&disk->open_mutex){+.+.}-{3:3}, at: bd_register_pending_holders+0x2c/0x470 block/holder.c:160

but task is already holding lock:
ffff8880996a0230 (&mddev->open_mutex){+.+.}-{3:3}, at: md_alloc+0x911/0x1150 drivers/md/md.c:5706

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (&mddev->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
       md_alloc+0x911/0x1150 drivers/md/md.c:5706
       md_probe+0x69/0x70 drivers/md/md.c:5738
       blk_request_module+0x111/0x1d0 block/genhd.c:632
       blkdev_get_no_open+0x178/0x1e0 fs/block_dev.c:1150
       blkdev_get_by_dev.part.0+0x22/0xb60 fs/block_dev.c:1214
       blkdev_get_by_dev fs/block_dev.c:1323 [inline]
       blkdev_open+0x295/0x300 fs/block_dev.c:1329
       do_dentry_open+0x4c8/0x11d0 fs/open.c:822
       do_open fs/namei.c:3426 [inline]
       path_openat+0x1c9a/0x2740 fs/namei.c:3559
       do_filp_open+0x1aa/0x400 fs/namei.c:3586
       do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
       do_sys_open fs/open.c:1216 [inline]
       __do_sys_openat fs/open.c:1232 [inline]
       __se_sys_openat fs/open.c:1227 [inline]
       __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #7 (disks_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
       md_alloc+0x37/0x1150 drivers/md/md.c:5644
       md_probe+0x69/0x70 drivers/md/md.c:5738
       blk_request_module+0x111/0x1d0 block/genhd.c:632
       blkdev_get_no_open+0x178/0x1e0 fs/block_dev.c:1150
       blkdev_get_by_dev.part.0+0x22/0xb60 fs/block_dev.c:1214
       blkdev_get_by_dev fs/block_dev.c:1323 [inline]
       blkdev_open+0x295/0x300 fs/block_dev.c:1329
       do_dentry_open+0x4c8/0x11d0 fs/open.c:822
       do_open fs/namei.c:3426 [inline]
       path_openat+0x1c9a/0x2740 fs/namei.c:3559
       do_filp_open+0x1aa/0x400 fs/namei.c:3586
       do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
       do_sys_open fs/open.c:1216 [inline]
       __do_sys_openat fs/open.c:1232 [inline]
       __se_sys_openat fs/open.c:1227 [inline]
       __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #6 (major_names_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
       blkdev_show+0x27/0x160 block/genhd.c:198
       devinfo_show+0xc1/0xf0 fs/proc/devices.c:22
       seq_read_iter+0xbb0/0x1240 fs/seq_file.c:272
       proc_reg_read_iter+0x1fb/0x2d0 fs/proc/inode.c:300
       call_read_iter include/linux/fs.h:2157 [inline]
       new_sync_read+0x421/0x6e0 fs/read_write.c:404
       vfs_read+0x35c/0x600 fs/read_write.c:485
       ksys_read+0x12d/0x250 fs/read_write.c:623
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
       seq_read_iter+0xdf/0x1240 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2157 [inline]
       generic_file_splice_read+0x453/0x6d0 fs/splice.c:311
       do_splice_to+0x1bf/0x250 fs/splice.c:796
       splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
       do_splice_direct+0x1b3/0x280 fs/splice.c:979
       do_sendfile+0xae9/0x1240 fs/read_write.c:1249
       __do_sys_sendfile64 fs/read_write.c:1314 [inline]
       __se_sys_sendfile64 fs/read_write.c:1300 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1812 [inline]
       sb_start_write include/linux/fs.h:1882 [inline]
       file_start_write include/linux/fs.h:3008 [inline]
       lo_write_bvec+0x3b6/0x6d0 drivers/block/loop.c:327
       lo_write_simple drivers/block/loop.c:350 [inline]
       do_req_filebacked drivers/block/loop.c:668 [inline]
       loop_handle_cmd drivers/block/loop.c:2202 [inline]
       loop_process_work+0xc60/0x24e0 drivers/block/loop.c:2242
       process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
       kthread+0x3e5/0x4d0 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #3 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x92e/0x16b0 kernel/workqueue.c:2273
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
       kthread+0x3e5/0x4d0 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #2 ((wq_completion)loop5){+.+.}-{0:0}:
       flush_workqueue+0x110/0x15b0 kernel/workqueue.c:2817
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2982
       destroy_workqueue+0x71/0x800 kernel/workqueue.c:4419
       __loop_clr_fd+0x212/0x15e0 drivers/block/loop.c:1368
       lo_release+0x1ac/0x1f0 drivers/block/loop.c:2068
       blkdev_put_whole fs/block_dev.c:1102 [inline]
       blkdev_put+0x2fb/0x9e0 fs/block_dev.c:1393
       btrfs_close_bdev fs/btrfs/volumes.c:1108 [inline]
       btrfs_close_bdev fs/btrfs/volumes.c:1098 [inline]
       btrfs_close_one_device fs/btrfs/volumes.c:1127 [inline]
       close_fs_devices+0x26a/0xa20 fs/btrfs/volumes.c:1157
       btrfs_close_devices+0x8e/0x4b0 fs/btrfs/volumes.c:1172
       close_ctree+0x752/0x795 fs/btrfs/disk-io.c:4438
       generic_shutdown_super+0x14c/0x370 fs/super.c:465
       kill_anon_super+0x36/0x60 fs/super.c:1057
       btrfs_kill_super+0x38/0x50 fs/btrfs/super.c:2348
       deactivate_locked_super+0x94/0x160 fs/super.c:335
       deactivate_super+0xad/0xd0 fs/super.c:366
       cleanup_mnt+0x3a2/0x540 fs/namespace.c:1137
       task_work_run+0xdd/0x1a0 kernel/task_work.c:164
       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
       exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
       __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
       do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&lo->lo_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
       lo_open+0x75/0x120 drivers/block/loop.c:2040
       blkdev_get_whole+0x99/0x2a0 fs/block_dev.c:1079
       blkdev_get_by_dev.part.0+0x354/0xb60 fs/block_dev.c:1234
       blkdev_get_by_dev fs/block_dev.c:1323 [inline]
       blkdev_open+0x295/0x300 fs/block_dev.c:1329
       do_dentry_open+0x4c8/0x11d0 fs/open.c:822
       do_open fs/namei.c:3426 [inline]
       path_openat+0x1c9a/0x2740 fs/namei.c:3559
       do_filp_open+0x1aa/0x400 fs/namei.c:3586
       do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
       do_sys_open fs/open.c:1216 [inline]
       __do_sys_open fs/open.c:1224 [inline]
       __se_sys_open fs/open.c:1220 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1220
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&disk->open_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
       bd_register_pending_holders+0x2c/0x470 block/holder.c:160
       device_add_disk+0x74c/0xfc0 block/genhd.c:470
       add_disk include/linux/genhd.h:221 [inline]
       md_alloc+0x91d/0x1150 drivers/md/md.c:5707
       md_probe+0x69/0x70 drivers/md/md.c:5738
       blk_request_module+0x111/0x1d0 block/genhd.c:632
       blkdev_get_no_open+0x178/0x1e0 fs/block_dev.c:1150
       blkdev_get_by_dev.part.0+0x22/0xb60 fs/block_dev.c:1214
       blkdev_get_by_dev fs/block_dev.c:1323 [inline]
       blkdev_open+0x295/0x300 fs/block_dev.c:1329
       do_dentry_open+0x4c8/0x11d0 fs/open.c:822
       do_open fs/namei.c:3426 [inline]
       path_openat+0x1c9a/0x2740 fs/namei.c:3559
       do_filp_open+0x1aa/0x400 fs/namei.c:3586
       do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
       do_sys_open fs/open.c:1216 [inline]
       __do_sys_openat fs/open.c:1232 [inline]
       __se_sys_openat fs/open.c:1227 [inline]
       __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &disk->open_mutex --> disks_mutex --> &mddev->open_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mddev->open_mutex);
                               lock(disks_mutex);
                               lock(&mddev->open_mutex);
  lock(&disk->open_mutex);

 *** DEADLOCK ***

3 locks held by syz-executor.1/10219:
 #0: ffffffff8c204908 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x25/0x1d0 block/genhd.c:629
 #1: ffffffff8cd2fc48 (disks_mutex){+.+.}-{3:3}, at: md_alloc+0x37/0x1150 drivers/md/md.c:5644
 #2: ffff8880996a0230 (&mddev->open_mutex){+.+.}-{3:3}, at: md_alloc+0x911/0x1150 drivers/md/md.c:5706

stack backtrace:
CPU: 1 PID: 10219 Comm: syz-executor.1 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __mutex_lock_common kernel/locking/mutex.c:596 [inline]
 __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
 bd_register_pending_holders+0x2c/0x470 block/holder.c:160
 device_add_disk+0x74c/0xfc0 block/genhd.c:470
 add_disk include/linux/genhd.h:221 [inline]
 md_alloc+0x91d/0x1150 drivers/md/md.c:5707
 md_probe+0x69/0x70 drivers/md/md.c:5738
 blk_request_module+0x111/0x1d0 block/genhd.c:632
 blkdev_get_no_open+0x178/0x1e0 fs/block_dev.c:1150
 blkdev_get_by_dev.part.0+0x22/0xb60 fs/block_dev.c:1214
 blkdev_get_by_dev fs/block_dev.c:1323 [inline]
 blkdev_open+0x295/0x300 fs/block_dev.c:1329
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3426 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3559
 do_filp_open+0x1aa/0x400 fs/namei.c:3586
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f99121a3188 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000000056c038 RCX: 00000000004665f9
RDX: 0000000000000000 RSI: 00000000200020c0 RDI: ffffffffffffff9c
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c038
R13: 00007ffea339c34f R14: 00007f99121a3300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
