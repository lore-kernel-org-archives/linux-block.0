Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBEEC48BE6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 21:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC87613DF
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 21:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhFPVUY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 17:20:24 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41769 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbhFPVUY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 17:20:24 -0400
Received: by mail-io1-f70.google.com with SMTP id y26-20020a6be51a0000b02904b200a26422so367647ioc.8
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 14:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=duTj10WutJtiQxaoqsHiF2wpfRhcgG9nBHs+cYY/O0s=;
        b=JBwvBbSdg+QbsL+4fogQYzUjOFCXJYrpvygxfxSnQ/IcWCKYl1BIfkHOS/znfIzWSv
         Jmm1gmL+y00GgnmczvR2ib5o4WuKf1FgWcBA2jvkGrc+cJqjxNjXgMSRDKdbJ9jhoUQv
         0Fo3571NuvwGbSKSbytFfRkLIFZ7tqYiv97mi4J7tFJW/Mmf1dKph+DjGFtCOHU31/I2
         Ol/OJ7qE7zuxgVoBTOagCwgSI6m6VM3ckJNaaz4bXzZdm0klMLHy3eFEpVsIdwiC/PIQ
         SQZPQhGL+Kh0i1rjJhDK4meS2fg6WLk7lkSSzEsNGKjt7A603Z9u/ZELYzgcjPzm1gqz
         imEQ==
X-Gm-Message-State: AOAM530E5/URWOe7tjaDSlFWyHRHn0N5+tBfO0wvf6iWefunxQqIE186
        w+5oW8SswP654f2ZzOsVwSgb97R6Lbr0fTk3DHV0WXMeO4Zc
X-Google-Smtp-Source: ABdhPJwp/dBh+MkVc0KZmpZLXAAiEn5MS/4VUH2mxB5N0vOGhMX6oCBHieqfWMlrl2kv8YPDzd4TUAAo+cZTVJkfO7p6+IYUW4Og
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be4:: with SMTP id y4mr1078399ilv.135.1623878297558;
 Wed, 16 Jun 2021 14:18:17 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:18:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015a81105c4e8a1c3@google.com>
Subject: [syzbot] possible deadlock in loop_probe
From:   syzbot <syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com>
To:     axboe@fb.com, axboe@kernel.dk, gregkh@linuxfoundation.org,
        hch@lst.de, kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        rafael@kernel.org, sagi@grimberg.me,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8ecfa36c Merge tag 'riscv-for-linus-5.13-rc6' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17121304300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547a5e42ca601229
dashboard link: https://syzkaller.appspot.com/bug?extid=6a8a0d93c91e8fbf2e80
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17065d1fd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12de53afd00000

The issue was bisected to:

commit 5befc7c26e5a98cd49789fb1beb52c62bd472dba
Author: Keith Busch <kbusch@kernel.org>
Date:   Wed Mar 24 23:18:05 2021 +0000

    nvme: implement non-mdts command limits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e62857d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e62857d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e62857d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com
Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")

======================================================
WARNING: possible circular locking dependency detected
5.13.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
systemd-udevd/8445 is trying to acquire lock:
ffffffff8d671688 (loop_ctl_mutex){+.+.}-{3:3}, at: loop_probe+0xe1/0x220 drivers/block/loop.c:2234

but task is already holding lock:
ffffffff8d4db008 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x2f/0x1c0 block/genhd.c:680

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (major_names_lock){+.+.}-{3:3}:
       lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
       __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       __register_blkdev+0x2c/0x360 block/genhd.c:223
       register_mtd_blktrans+0x94/0x3d0 drivers/mtd/mtd_blkdevs.c:534
       do_one_initcall+0x1a7/0x400 init/main.c:1249
       do_initcall_level+0x14a/0x1f5 init/main.c:1322
       do_initcalls+0x4b/0x8c init/main.c:1338
       kernel_init_freeable+0x3fd/0x58a init/main.c:1560
       kernel_init+0xd/0x290 init/main.c:1447
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

-> #2 (mtd_table_mutex){+.+.}-{3:3}:
       lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
       __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       blktrans_open+0x61/0x430 drivers/mtd/mtd_blkdevs.c:212
       __blkdev_get+0x293/0xa50 fs/block_dev.c:1311
       blkdev_get_by_dev+0xf9/0x640 fs/block_dev.c:1451
       blkdev_open+0x132/0x2c0 fs/block_dev.c:1546
       do_dentry_open+0x7cb/0x1010 fs/open.c:826
       do_open fs/namei.c:3361 [inline]
       path_openat+0x28e6/0x39b0 fs/namei.c:3494
       do_filp_open+0x221/0x460 fs/namei.c:3521
       do_sys_openat2+0x124/0x460 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_open fs/open.c:1211 [inline]
       __se_sys_open fs/open.c:1207 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1207
       do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&bdev->bd_mutex){+.+.}-{3:3}:
       lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
       __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       del_gendisk+0x2ab/0x860 block/genhd.c:610
       loop_remove drivers/block/loop.c:2180 [inline]
       loop_control_ioctl+0x62c/0x770 drivers/block/loop.c:2280
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:1069 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
       do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (loop_ctl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2938 [inline]
       check_prevs_add+0x4f9/0x5b60 kernel/locking/lockdep.c:3061
       validate_chain kernel/locking/lockdep.c:3676 [inline]
       __lock_acquire+0x4307/0x6040 kernel/locking/lockdep.c:4902
       lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
       __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       loop_probe+0xe1/0x220 drivers/block/loop.c:2234
       blk_request_module+0x19d/0x1c0 block/genhd.c:683
       blkdev_get_no_open+0x44/0x1f0 fs/block_dev.c:1374
       blkdev_get_by_dev+0x82/0x640 fs/block_dev.c:1437
       blkdev_open+0x132/0x2c0 fs/block_dev.c:1546
       do_dentry_open+0x7cb/0x1010 fs/open.c:826
       do_open fs/namei.c:3361 [inline]
       path_openat+0x28e6/0x39b0 fs/namei.c:3494
       do_filp_open+0x221/0x460 fs/namei.c:3521
       do_sys_openat2+0x124/0x460 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_open fs/open.c:1211 [inline]
       __se_sys_open fs/open.c:1207 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1207
       do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  loop_ctl_mutex --> mtd_table_mutex --> major_names_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(major_names_lock);
                               lock(mtd_table_mutex);
                               lock(major_names_lock);
  lock(loop_ctl_mutex);

 *** DEADLOCK ***

1 lock held by systemd-udevd/8445:
 #0: ffffffff8d4db008 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x2f/0x1c0 block/genhd.c:680

stack backtrace:
CPU: 1 PID: 8445 Comm: systemd-udevd Not tainted 5.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x202/0x31e lib/dump_stack.c:120
 print_circular_bug+0xb17/0xdc0 kernel/locking/lockdep.c:2007
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2129
 check_prev_add kernel/locking/lockdep.c:2938 [inline]
 check_prevs_add+0x4f9/0x5b60 kernel/locking/lockdep.c:3061
 validate_chain kernel/locking/lockdep.c:3676 [inline]
 __lock_acquire+0x4307/0x6040 kernel/locking/lockdep.c:4902
 lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
 __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 loop_probe+0xe1/0x220 drivers/block/loop.c:2234
 blk_request_module+0x19d/0x1c0 block/genhd.c:683
 blkdev_get_no_open+0x44/0x1f0 fs/block_dev.c:1374
 blkdev_get_by_dev+0x82/0x640 fs/block_dev.c:1437
 blkdev_open+0x132/0x2c0 fs/block_dev.c:1546
 do_dentry_open+0x7cb/0x1010 fs/open.c:826
 do_open fs/namei.c:3361 [inline]
 path_openat+0x28e6/0x39b0 fs/namei.c:3494
 do_filp_open+0x221/0x460 fs/namei.c:3521
 do_sys_openat2+0x124/0x460 fs/open.c:1187
 do_sys_open fs/open.c:1203 [inline]
 __do_sys_open fs/open.c:1211 [inline]
 __se_sys_open fs/open.c:1207 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1207
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f666c06a840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffc880be598 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000055dd2c8278f0 RCX: 00007f666c06a840
RDX: 000055dd2c52efe3 RSI: 00000000000a0800 RDI: 000055dd2c827830
RBP: 00007ffc880be710 R08: 000055dd2c52e670 R09: 0000000000000010
R10: 000055dd2c52ed0c R11: 0000000000000246 R12: 00007ffc880be660
R13: 000055dd2c829010 R14: 0000000000000003 R15: 000000000000000e


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
