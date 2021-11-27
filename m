Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2152C433F5
	for <linux-block@archiver.kernel.org>; Sat, 27 Nov 2021 07:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhK0HPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Nov 2021 02:15:34 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:55281 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243204AbhK0HNd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Nov 2021 02:13:33 -0500
Received: by mail-io1-f72.google.com with SMTP id s8-20020a056602168800b005e96bba1363so14983277iow.21
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 23:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5orzsRlipPdtzPYU8d+6vefG9X/utpsUgcNp+GtGtGA=;
        b=wr28WqqEF9cfaPuHckH4FNosTHtiPSwiCh6I6Qan/V+HABwfQIAzhjafgqW9z1gujC
         +QEM3wmoa3SnV+gdg/EJJ2drjALvMxa/4cydPQtHjdTD9UQ6jUICsWR/1/bH9pamIWkL
         4stoRfIjmJHxUsddYjf6an9zwKXDqlTBKbZOXq6VcSyw4bCH+OfMsVwmBR4/nfzgkKmk
         hhF2HYazYhqZs+YDRnlZ8ja/0Ahdv+tbu4XDLbHKwQT34UfWokG/clvZ6N0VjDchA9fq
         rtAvC0Kq+SMlfD9tUNuAygKRJdlGLhRrAWfACDWEKn+wZGzbk/XGf8+EDnl10F1N2WTX
         lq8Q==
X-Gm-Message-State: AOAM531vq0T14uALcQKhLatL+7fa0KfRFH3J/47kDlT2TpyA5s/aB7lh
        wPIRGF2I4N4iE/JJr1zjR+iVGDz5Tbxm7X2q5cQRGqnPWQ2n
X-Google-Smtp-Source: ABdhPJztyXzx9FOPdezN/h/lsmbUFBHOBWh5Xp0APKV/CGeV7w9z+DWiNu2XnvRW+5XXgns74flkJ/Cg3rJQffAUO8gi1YM0ZuNy
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2acc:: with SMTP id m12mr42299523iov.107.1637997019605;
 Fri, 26 Nov 2021 23:10:19 -0800 (PST)
Date:   Fri, 26 Nov 2021 23:10:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f2f5405d1bfe618@google.com>
Subject: [syzbot] possible deadlock in blkdev_put (2)
From:   syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f81e94e91878 Add linux-next specific files for 20211125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16366216b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be9183de0824e4d7
dashboard link: https://syzkaller.appspot.com/bug?extid=643e4ce4b6ad1347d372
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.16.0-rc2-next-20211125-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.3/8204 is trying to acquire lock:
ffff88807df21138 ((wq_completion)loop3){+.+.}-{0:0}, at: flush_workqueue+0xe1/0x15b0 kernel/workqueue.c:2816

but task is already holding lock:
ffff88801a822918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x97/0x9e0 block/bdev.c:913

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       blkdev_get_by_dev.part.0+0x24e/0xb50 block/bdev.c:818
       blkdev_get_by_dev+0x6b/0x80 block/bdev.c:858
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
       kernfs_seq_start+0x4b/0x260 fs/kernfs/file.c:112
       seq_read_iter+0x2c7/0x1240 fs/seq_file.c:225
       kernfs_fop_read_iter+0x44f/0x5f0 fs/kernfs/file.c:241
       call_read_iter include/linux/fs.h:2156 [inline]
       new_sync_read+0x421/0x6e0 fs/read_write.c:400
       vfs_read+0x35c/0x600 fs/read_write.c:481
       ksys_read+0x12d/0x250 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       seq_read_iter+0xdf/0x1240 fs/seq_file.c:182
       kernfs_fop_read_iter+0x44f/0x5f0 fs/kernfs/file.c:241
       call_read_iter include/linux/fs.h:2156 [inline]
       generic_file_splice_read+0x453/0x6d0 fs/splice.c:311
       do_splice_to+0x1bf/0x250 fs/splice.c:796
       splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
       do_splice_direct+0x1b3/0x280 fs/splice.c:979
       do_sendfile+0xaf2/0x1250 fs/read_write.c:1245
       __do_sys_sendfile64 fs/read_write.c:1310 [inline]
       __se_sys_sendfile64 fs/read_write.c:1296 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1296
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1810 [inline]
       sb_start_write include/linux/fs.h:1880 [inline]
       file_start_write include/linux/fs.h:3008 [inline]
       lo_write_bvec drivers/block/loop.c:242 [inline]
       lo_write_simple drivers/block/loop.c:265 [inline]
       do_req_filebacked drivers/block/loop.c:494 [inline]
       loop_handle_cmd drivers/block/loop.c:1846 [inline]
       loop_process_work+0x1499/0x1db0 drivers/block/loop.c:1886
       process_one_work+0x9b2/0x1690 kernel/workqueue.c:2299
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2446
       kthread+0x405/0x4f0 kernel/kthread.c:345
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x921/0x1690 kernel/workqueue.c:2275
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2446
       kthread+0x405/0x4f0 kernel/kthread.c:345
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 ((wq_completion)loop3){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5637 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
       flush_workqueue+0x110/0x15b0 kernel/workqueue.c:2819
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2984
       destroy_workqueue+0x71/0x800 kernel/workqueue.c:4421
       __loop_clr_fd+0x1ab/0xe20 drivers/block/loop.c:1118
       lo_release+0x1ac/0x1f0 drivers/block/loop.c:1750
       blkdev_put_whole block/bdev.c:694 [inline]
       blkdev_put+0x2fb/0x9e0 block/bdev.c:955
       deactivate_locked_super+0x94/0x160 fs/super.c:335
       deactivate_super+0xad/0xd0 fs/super.c:366
       cleanup_mnt+0x3a2/0x540 fs/namespace.c:1137
       task_work_run+0xdd/0x1a0 kernel/task_work.c:164
       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
       exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
       __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
       do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  (wq_completion)loop3 --> system_transition_mutex/1 --> &disk->open_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&disk->open_mutex);
                               lock(system_transition_mutex/1);
                               lock(&disk->open_mutex);
  lock((wq_completion)loop3);

 *** DEADLOCK ***

1 lock held by syz-executor.3/8204:
 #0: ffff88801a822918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x97/0x9e0 block/bdev.c:913

stack backtrace:
CPU: 0 PID: 8204 Comm: syz-executor.3 Not tainted 5.16.0-rc2-next-20211125-syzkaller #0
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
 flush_workqueue+0x110/0x15b0 kernel/workqueue.c:2819
 drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2984
 destroy_workqueue+0x71/0x800 kernel/workqueue.c:4421
 __loop_clr_fd+0x1ab/0xe20 drivers/block/loop.c:1118
 lo_release+0x1ac/0x1f0 drivers/block/loop.c:1750
 blkdev_put_whole block/bdev.c:694 [inline]
 blkdev_put+0x2fb/0x9e0 block/bdev.c:955
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a2/0x540 fs/namespace.c:1137
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fcdf7077f57
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc24b336f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fcdf7077f57
RDX: 00007ffc24b337ca RSI: 000000000000000a RDI: 00007ffc24b337c0
RBP: 00007ffc24b337c0 R08: 00000000ffffffff R09: 00007ffc24b33590
R10: 0000555555c00903 R11: 0000000000000246 R12: 00007fcdf70d0105
R13: 00007ffc24b34880 R14: 0000555555c00810 R15: 00007ffc24b348c0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
