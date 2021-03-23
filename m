Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B376C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 04:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C1361992
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 04:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCWEIq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 00:08:46 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50963 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCWEIP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 00:08:15 -0400
Received: by mail-io1-f69.google.com with SMTP id a1so975063iow.17
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 21:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0U88+G95cAsWJhc41ZWcXhG8yBOjOuy+fVe4cZKA5vY=;
        b=nvATgz1qWnVc2oKw2jGKIbOM7fgjnEhTOZeEqSuoSxj6BdftIQ8ecHl5tetzYSRtDq
         YQy4FZx73MAZnRjY4kyRp8wGcdvheJDMPWC1/LH2kbW6fIoy1KKLWN5pOhIA9FMP1Uqe
         9ALaDLdMjtxFcmQEwCBOeBZa+OHX5/Cb7EUhHNTv6d1u7WXEzduElrkfOBTZo0rk+Dfa
         bjspocxbcJxpki3WIp4knTmcsni1qgxHmkehSR2kDFlsETu1hvI5OH++UJZI6XDKpQTW
         B0XIzdiIbEciKvytJOS0fa+1bmfjpChV3IqjIbwUf9ZLGA2pkS/BN/eQvlzO40TFOBr1
         ZKeg==
X-Gm-Message-State: AOAM530EAbc3KVstOS0neZ3BvyyxRs5QWu5OXeN+5FG0A7yn+B09R5N5
        4qG9e6U9SDUjBN74KQIuWlxqpxQkQGLfVc/rCqnguVFQFASs
X-Google-Smtp-Source: ABdhPJx/yxzT7bELVO9/s5+VXfU7vy6tC3+QOG+xXxSCUI0KtZqmb1L4IGuKUXIO7Rvso9BQPo9Nwuz0brgVvZLraxwMmTViB65i
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2711:: with SMTP id m17mr2628467jav.115.1616472494883;
 Mon, 22 Mar 2021 21:08:14 -0700 (PDT)
Date:   Mon, 22 Mar 2021 21:08:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8c65105be2c5407@google.com>
Subject: [syzbot] possible deadlock in __loop_clr_fd
From:   syzbot <syzbot+707d51092ab7b87b23df@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ba5b053a Add linux-next specific files for 20210318
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10cfb406d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd6e556bdf0188e4
dashboard link: https://syzkaller.appspot.com/bug?extid=707d51092ab7b87b23df

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+707d51092ab7b87b23df@syzkaller.appspotmail.com

UDF-fs: warning (device loop4): udf_load_vrs: No VRS found
UDF-fs: Scanning with blocksize 4096 failed
======================================================
WARNING: possible circular locking dependency detected
5.12.0-rc3-next-20210318-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/13936 is trying to acquire lock:
ffff88805cb9b138 ((wq_completion)loop292057088){+.+.}-{0:0}, at: flush_workqueue+0xe1/0x13e0 kernel/workqueue.c:2783

but task is already holding lock:
ffff88801a730468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x95/0x14a0 drivers/block/loop.c:1278

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&lo->lo_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:952 [inline]
       __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1099
       lo_open drivers/block/loop.c:1983 [inline]
       lo_open+0xa1/0x130 drivers/block/loop.c:1965
       __blkdev_get+0x135/0xa30 fs/block_dev.c:1302
       blkdev_get_by_dev fs/block_dev.c:1454 [inline]
       blkdev_get_by_dev+0x26c/0x600 fs/block_dev.c:1422
       blkdev_open+0x154/0x2b0 fs/block_dev.c:1551
       do_dentry_open+0x4b9/0x11b0 fs/open.c:826
       do_open fs/namei.c:3365 [inline]
       path_openat+0x1c0e/0x27e0 fs/namei.c:3498
       do_filp_open+0x17e/0x3c0 fs/namei.c:3525
       do_sys_openat2+0x16d/0x420 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_open fs/open.c:1211 [inline]
       __se_sys_open fs/open.c:1207 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1207
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (loop_ctl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:952 [inline]
       __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1099
       loop_probe+0xc7/0x150 drivers/block/loop.c:2407
       blk_request_module+0x111/0x1d0 block/genhd.c:769
       blkdev_get_no_open+0x225/0x2b0 fs/block_dev.c:1368
       blkdev_get_by_dev fs/block_dev.c:1440 [inline]
       blkdev_get_by_dev+0x1f9/0x600 fs/block_dev.c:1422
       blkdev_open+0x154/0x2b0 fs/block_dev.c:1551
       do_dentry_open+0x4b9/0x11b0 fs/open.c:826
       do_open fs/namei.c:3365 [inline]
       path_openat+0x1c0e/0x27e0 fs/namei.c:3498
       do_filp_open+0x17e/0x3c0 fs/namei.c:3525
       do_sys_openat2+0x16d/0x420 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_openat fs/open.c:1219 [inline]
       __se_sys_openat fs/open.c:1214 [inline]
       __x64_sys_openat+0x13f/0x1f0 fs/open.c:1214
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (major_names_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:952 [inline]
       __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1099
       blkdev_show+0x27/0x160 block/genhd.c:263
       devinfo_show+0xc1/0xf0 fs/proc/devices.c:22
       seq_read_iter+0xb66/0x1220 fs/seq_file.c:269
       proc_reg_read_iter+0x1fb/0x2d0 fs/proc/inode.c:310
       call_read_iter include/linux/fs.h:1969 [inline]
       new_sync_read+0x41e/0x6e0 fs/read_write.c:415
       vfs_read+0x35c/0x570 fs/read_write.c:496
       ksys_read+0x12d/0x250 fs/read_write.c:634
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:952 [inline]
       __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1099
       seq_read_iter+0xdf/0x1220 fs/seq_file.c:179
       call_read_iter include/linux/fs.h:1969 [inline]
       generic_file_splice_read+0x450/0x6c0 fs/splice.c:311
       do_splice_to+0x1bf/0x250 fs/splice.c:796
       splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
       do_splice_direct+0x1b3/0x280 fs/splice.c:979
       do_sendfile+0x9f0/0x1110 fs/read_write.c:1260
       __do_sys_sendfile64 fs/read_write.c:1325 [inline]
       __se_sys_sendfile64 fs/read_write.c:1311 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1311
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1638 [inline]
       sb_start_write include/linux/fs.h:1708 [inline]
       file_start_write include/linux/fs.h:2891 [inline]
       lo_write_bvec+0x3ed/0x6c0 drivers/block/loop.c:286
       lo_write_simple drivers/block/loop.c:309 [inline]
       do_req_filebacked drivers/block/loop.c:627 [inline]
       loop_handle_cmd drivers/block/loop.c:2143 [inline]
       loop_process_work+0xc60/0x25a0 drivers/block/loop.c:2183
       process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
       worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
       kthread+0x3b1/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

-> #1 ((work_completion)(&worker->work)){+.+.}-{0:0}:
       process_one_work+0x8fc/0x1600 kernel/workqueue.c:2251
       worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
       kthread+0x3b1/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

-> #0 ((wq_completion)loop292057088){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:2937 [inline]
       check_prevs_add kernel/locking/lockdep.c:3060 [inline]
       validate_chain kernel/locking/lockdep.c:3675 [inline]
       __lock_acquire+0x2a17/0x5230 kernel/locking/lockdep.c:4901
       lock_acquire kernel/locking/lockdep.c:5511 [inline]
       lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5476
       flush_workqueue+0x110/0x13e0 kernel/workqueue.c:2786
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2951
       destroy_workqueue+0x71/0x760 kernel/workqueue.c:4382
       __loop_clr_fd+0x1f8/0x14a0 drivers/block/loop.c:1296
       loop_clr_fd drivers/block/loop.c:1422 [inline]
       lo_ioctl+0x3b9/0x1620 drivers/block/loop.c:1780
       blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:583
       block_ioctl+0xf9/0x140 fs/block_dev.c:1667
       vfs_ioctl fs/ioctl.c:48 [inline]
       __do_sys_ioctl fs/ioctl.c:753 [inline]
       __se_sys_ioctl fs/ioctl.c:739 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  (wq_completion)loop292057088 --> loop_ctl_mutex --> &lo->lo_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&lo->lo_mutex);
                               lock(loop_ctl_mutex);
                               lock(&lo->lo_mutex);
  lock((wq_completion)loop292057088);

 *** DEADLOCK ***

1 lock held by syz-executor.4/13936:
 #0: ffff88801a730468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x95/0x14a0 drivers/block/loop.c:1278

stack backtrace:
CPU: 0 PID: 13936 Comm: syz-executor.4 Not tainted 5.12.0-rc3-next-20210318-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2128
 check_prev_add kernel/locking/lockdep.c:2937 [inline]
 check_prevs_add kernel/locking/lockdep.c:3060 [inline]
 validate_chain kernel/locking/lockdep.c:3675 [inline]
 __lock_acquire+0x2a17/0x5230 kernel/locking/lockdep.c:4901
 lock_acquire kernel/locking/lockdep.c:5511 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5476
 flush_workqueue+0x110/0x13e0 kernel/workqueue.c:2786
 drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2951
 destroy_workqueue+0x71/0x760 kernel/workqueue.c:4382
 __loop_clr_fd+0x1f8/0x14a0 drivers/block/loop.c:1296
 loop_clr_fd drivers/block/loop.c:1422 [inline]
 lo_ioctl+0x3b9/0x1620 drivers/block/loop.c:1780
 blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:583
 block_ioctl+0xf9/0x140 fs/block_dev.c:1667
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x466217
Code: 3c 1c 48 f7 d8 49 39 c4 72 b8 e8 a4 48 02 00 85 c0 78 bd 48 83 c4 08 4c 89 e0 5b 41 5c c3 0f 1f 44 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4df82a3fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000020001600 RCX: 0000000000466217
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000005
RBP: 00007f4df82a46bc R08: 00007f4df82a4040 R09: 0000000020001440
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000016 R14: 00007f4df82a4000 R15: 0000000020001640


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
