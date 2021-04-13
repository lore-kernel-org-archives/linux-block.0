Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF76C433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 17:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BCC613B1
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 17:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbhDMRdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 13:33:39 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:54297 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbhDMRdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 13:33:39 -0400
Received: by mail-il1-f198.google.com with SMTP id f14so89504ilr.21
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 10:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uSWBhsPhltIy8Vu4b7IqRwVOVBqHHHNi3V0ikDinqQA=;
        b=p+Kgtc/amU0U7tgHXJkq1WAeuDrS0kDFmeKzUxLrd7lE71ift9Nazz9y3ZEIbfRgSr
         ek7iLi1uC+pYICjP+5S5RahQGtxuhaXwzxO86GaiWbIocG9vGFmB6/3e0wrK3xYgokja
         BVkvwQWy1zJN9n5CKoa690pth3i0b+8zTcmAIY2fuHM7pTaR7XTmYQxXziwNxyVP9WTJ
         di12dAMy6rh6Yqgxd8X6gKHUhjhZKeVIy2y4F98DYdlVHkh8PKB1/zfyGbiuLOMchjly
         BBM225i/WVyDrlgrzVkLy2HKWHoYmgTHTGM/M+W4xI88zXJOweRVWffvaJKJbKZnLNpw
         hsOA==
X-Gm-Message-State: AOAM532Sl+nswMd2VVNfEg203NiQlbhEHGuGBetVNlhuiQcQtRo/sSTh
        2UGZ9eVqtdynUk/3Ko4TkjtQTaBSR69mOBLSeGRPs1plULPR
X-Google-Smtp-Source: ABdhPJz2e5HG5xlxeuZfBVVk/37iB+7XHRq4HyKmoKN4yaSR4PiMTzrbLRuM1583YnqDGWjqmc1INV14srEKnq+Jg4VFQcfG2ZQA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5a2:: with SMTP id k2mr29085153ils.177.1618335199272;
 Tue, 13 Apr 2021 10:33:19 -0700 (PDT)
Date:   Tue, 13 Apr 2021 10:33:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae236f05bfde0678@google.com>
Subject: [syzbot] possible deadlock in del_gendisk
From:   syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, bp@alien8.de,
        hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        masahiroy@kernel.org, mingo@redhat.com, pbonzini@redhat.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        rostedt@goodmis.org, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, will@kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e99d8a84 Add linux-next specific files for 20210409
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b01681d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd69574979bfeb7
dashboard link: https://syzkaller.appspot.com/bug?extid=61e04e51b7ac86930589
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148265d9d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a981a1d00000

The issue was bisected to:

commit 997acaf6b4b59c6a9c259740312a69ea549cc684
Author: Mark Rutland <mark.rutland@arm.com>
Date:   Mon Jan 11 15:37:07 2021 +0000

    lockdep: report broken irq restoration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a7e77ed00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a7e77ed00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a7e77ed00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com
Fixes: 997acaf6b4b5 ("lockdep: report broken irq restoration")

======================================================
WARNING: possible circular locking dependency detected
5.12.0-rc6-next-20210409-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor104/8440 is trying to acquire lock:
ffff888016e9dca0 (&bdev->bd_mutex){+.+.}-{3:3}, at: del_gendisk+0x250/0x9e0 block/genhd.c:618

but task is already holding lock:
ffffffff8c7d9430 (bdev_lookup_sem){++++}-{3:3}, at: del_gendisk+0x222/0x9e0 block/genhd.c:616

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (bdev_lookup_sem){++++}-{3:3}:
       down_write+0x92/0x150 kernel/locking/rwsem.c:1406
       del_gendisk+0x222/0x9e0 block/genhd.c:616
       loop_remove drivers/block/loop.c:2191 [inline]
       loop_control_ioctl drivers/block/loop.c:2291 [inline]
       loop_control_ioctl+0x40d/0x4f0 drivers/block/loop.c:2251
       vfs_ioctl fs/ioctl.c:48 [inline]
       __do_sys_ioctl fs/ioctl.c:753 [inline]
       __se_sys_ioctl fs/ioctl.c:739 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (loop_ctl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:949 [inline]
       __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
       lo_open+0x1a/0x130 drivers/block/loop.c:1890
       __blkdev_get+0x135/0xa30 fs/block_dev.c:1305
       blkdev_get_by_dev fs/block_dev.c:1457 [inline]
       blkdev_get_by_dev+0x26c/0x600 fs/block_dev.c:1425
       blkdev_open+0x154/0x2b0 fs/block_dev.c:1554
       do_dentry_open+0x4b9/0x11b0 fs/open.c:826
       do_open fs/namei.c:3361 [inline]
       path_openat+0x1c09/0x27d0 fs/namei.c:3494
       do_filp_open+0x190/0x3d0 fs/namei.c:3521
       do_sys_openat2+0x16d/0x420 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_open fs/open.c:1211 [inline]
       __se_sys_open fs/open.c:1207 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1207
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&bdev->bd_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2938 [inline]
       check_prevs_add kernel/locking/lockdep.c:3061 [inline]
       validate_chain kernel/locking/lockdep.c:3676 [inline]
       __lock_acquire+0x2a17/0x5230 kernel/locking/lockdep.c:4902
       lock_acquire kernel/locking/lockdep.c:5512 [inline]
       lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
       __mutex_lock_common kernel/locking/mutex.c:949 [inline]
       __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
       del_gendisk+0x250/0x9e0 block/genhd.c:618
       loop_remove drivers/block/loop.c:2191 [inline]
       loop_control_ioctl drivers/block/loop.c:2291 [inline]
       loop_control_ioctl+0x40d/0x4f0 drivers/block/loop.c:2251
       vfs_ioctl fs/ioctl.c:48 [inline]
       __do_sys_ioctl fs/ioctl.c:753 [inline]
       __se_sys_ioctl fs/ioctl.c:739 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &bdev->bd_mutex --> loop_ctl_mutex --> bdev_lookup_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(bdev_lookup_sem);
                               lock(loop_ctl_mutex);
                               lock(bdev_lookup_sem);
  lock(&bdev->bd_mutex);

 *** DEADLOCK ***

2 locks held by syz-executor104/8440:
 #0: ffffffff8ca5f148 (loop_ctl_mutex){+.+.}-{3:3}, at: loop_control_ioctl+0x7b/0x4f0 drivers/block/loop.c:2257
 #1: ffffffff8c7d9430 (bdev_lookup_sem){++++}-{3:3}, at: del_gendisk+0x222/0x9e0 block/genhd.c:616

stack backtrace:
CPU: 1 PID: 8440 Comm: syz-executor104 Not tainted 5.12.0-rc6-next-20210409-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2129
 check_prev_add kernel/locking/lockdep.c:2938 [inline]
 check_prevs_add kernel/locking/lockdep.c:3061 [inline]
 validate_chain kernel/locking/lockdep.c:3676 [inline]
 __lock_acquire+0x2a17/0x5230 kernel/locking/lockdep.c:4902
 lock_acquire kernel/locking/lockdep.c:5512 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
 __mutex_lock_common kernel/locking/mutex.c:949 [inline]
 __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
 del_gendisk+0x250/0x9e0 block/genhd.c:618
 loop_remove drivers/block/loop.c:2191 [inline]
 loop_control_ioctl drivers/block/loop.c:2291 [inline]
 loop_control_ioctl+0x40d/0x4f0 drivers/block/loop.c:2251
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43ee49
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4d86c238 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043ee49
RDX: 0000000000000002 RSI: 0000000000004c81 RDI: 0000000000000003
RBP: 0000000000402e30 R08: 0000000000000000 R09: 0000000000400488
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402ec0
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
