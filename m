Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB3CC432C1
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 06:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DDB21D7C
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 06:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfIYGTI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:19:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:44131 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfIYGTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 02:19:07 -0400
Received: by mail-io1-f69.google.com with SMTP id m3so7512959ion.11
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 23:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cW96M0F/kJO0oAtQ7bv2vEgNKpow1m3Kj4kGAYXb2JY=;
        b=PlifCr1kvAxr8zojPOdUJftoqDTVnZN5Is+5KOZArRVWIvOaYlwI93zKi/2kKrwq1J
         smb+FhBOSzpoTohxq32Aj/AW4EWMw54SGtM1xa3NMmY5RqJVkXCtTIwPF/+1TzxyS5sP
         P3RqwVm6Kv5BdR3wIy+iTgHcdt0/UgLHkrgackQNHcYv+Km2vDCK3Q6Hxd97hROGMXy8
         qP7SOAjfMTFTEvXKe2d+VgYYXcg99zRM8XcS0LiUSdRjkuGr9bNoyG7Tr5Y1t7CPAJTG
         Y2US7BlV7b2oBL/m78dih3E8BOpDecEIoK+PCEv1Cj1PMtefT04MxvQxwHFGs+90nozL
         Vonw==
X-Gm-Message-State: APjAAAXUgWW+G9tSnOlLHivXU3DN19qZYleiS6OtsuqStfaz2v5ibrd9
        +tPRYqNrDyHohZZnNFthmZdLGdcpB38jSwmLDADd2mMwQEKv
X-Google-Smtp-Source: APXvYqw2F2EwMD4TJ7b/ACk8a3u3T2sDbv/rmwsyD9F2I1+cIjvU0z46h7hDVmp2OYC3qQ/eRbiEqjbk8hfByu/8yNYfuRZimrQw
MIME-Version: 1.0
X-Received: by 2002:a5d:9f4e:: with SMTP id u14mr899668iot.106.1569392346773;
 Tue, 24 Sep 2019 23:19:06 -0700 (PDT)
Date:   Tue, 24 Sep 2019 23:19:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057e77805935aa13a@google.com>
Subject: possible deadlock in refcount_dec_and_mutex_lock
From:   syzbot <syzbot+22987eb604bffbcb717a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b5b3bd89 Add linux-next specific files for 20190920
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12bd8429600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eadcd01c1bd90b7f
dashboard link: https://syzkaller.appspot.com/bug?extid=22987eb604bffbcb717a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+22987eb604bffbcb717a@syzkaller.appspotmail.com

block nbd3: Receive control failed (result -22)
======================================================
WARNING: possible circular locking dependency detected
5.3.0-next-20190920 #0 Not tainted
------------------------------------------------------
kworker/u5:0/1524 is trying to acquire lock:
ffff8880a3030978 (&nbd->config_lock){+.+.}, at: refcount_dec_and_mutex_lock  
lib/refcount.c:319 [inline]
ffff8880a3030978 (&nbd->config_lock){+.+.}, at:  
refcount_dec_and_mutex_lock+0x56/0x90 lib/refcount.c:314

but task is already holding lock:
ffff8880a63ffdc0 ((work_completion)(&args->work)){+.+.}, at:  
process_one_work+0x8c1/0x1740 kernel/workqueue.c:2244

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((work_completion)(&args->work)){+.+.}:
        process_one_work+0x91c/0x1740 kernel/workqueue.c:2245
        worker_thread+0x98/0xe40 kernel/workqueue.c:2415
        kthread+0x361/0x430 kernel/kthread.c:255
        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

-> #1 ((wq_completion)knbd0-recv){+.+.}:
        flush_workqueue+0x126/0x14c0 kernel/workqueue.c:2774
        drain_workqueue+0x1b4/0x470 kernel/workqueue.c:2939
        destroy_workqueue+0x74/0x750 kernel/workqueue.c:4335
        nbd_config_put+0x3dd/0x870 drivers/block/nbd.c:1181
        nbd_release+0x103/0x150 drivers/block/nbd.c:1460
        __blkdev_put+0x4d1/0x810 fs/block_dev.c:1867
        blkdev_put+0x98/0x560 fs/block_dev.c:1929
        blkdev_close+0x8b/0xb0 fs/block_dev.c:1936
        __fput+0x2ff/0x890 fs/file_table.c:280
        ____fput+0x16/0x20 fs/file_table.c:313
        task_work_run+0x145/0x1c0 kernel/task_work.c:113
        exit_task_work include/linux/task_work.h:22 [inline]
        do_exit+0x904/0x2e60 kernel/exit.c:879
        do_group_exit+0x135/0x360 kernel/exit.c:983
        __do_sys_exit_group kernel/exit.c:994 [inline]
        __se_sys_exit_group kernel/exit.c:992 [inline]
        __x64_sys_exit_group+0x44/0x50 kernel/exit.c:992
        do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&nbd->config_lock){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain kernel/locking/lockdep.c:2971 [inline]
        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
        refcount_dec_and_mutex_lock lib/refcount.c:319 [inline]
        refcount_dec_and_mutex_lock+0x56/0x90 lib/refcount.c:314
        nbd_config_put+0x31/0x870 drivers/block/nbd.c:1159
        recv_work+0x19b/0x200 drivers/block/nbd.c:787
        process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
        worker_thread+0x98/0xe40 kernel/workqueue.c:2415
        kthread+0x361/0x430 kernel/kthread.c:255
        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

other info that might help us debug this:

Chain exists of:
   &nbd->config_lock --> (wq_completion)knbd0-recv -->  
(work_completion)(&args->work)

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&args->work));
                                lock((wq_completion)knbd0-recv);
                                lock((work_completion)(&args->work));
   lock(&nbd->config_lock);

  *** DEADLOCK ***

2 locks held by kworker/u5:0/1524:
  #0: ffff8880948d3d28 ((wq_completion)knbd3-recv){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8880948d3d28 ((wq_completion)knbd3-recv){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8880948d3d28 ((wq_completion)knbd3-recv){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8880948d3d28 ((wq_completion)knbd3-recv){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8880948d3d28 ((wq_completion)knbd3-recv){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8880948d3d28 ((wq_completion)knbd3-recv){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8880948d3d28 ((wq_completion)knbd3-recv){+.+.}, at:  
process_one_work+0x88b/0x1740 kernel/workqueue.c:2240
  #1: ffff8880a63ffdc0 ((work_completion)(&args->work)){+.+.}, at:  
process_one_work+0x8c1/0x1740 kernel/workqueue.c:2244

stack backtrace:
CPU: 1 PID: 1524 Comm: kworker/u5:0 Not tainted 5.3.0-next-20190920 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: knbd3-recv recv_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1685
  check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1809
  check_prev_add kernel/locking/lockdep.c:2476 [inline]
  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
  validate_chain kernel/locking/lockdep.c:2971 [inline]
  __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  __mutex_lock_common kernel/locking/mutex.c:956 [inline]
  __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
  refcount_dec_and_mutex_lock lib/refcount.c:319 [inline]
  refcount_dec_and_mutex_lock+0x56/0x90 lib/refcount.c:314
  nbd_config_put+0x31/0x870 drivers/block/nbd.c:1159
  recv_work+0x19b/0x200 drivers/block/nbd.c:787
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
block nbd3: shutting down sockets


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
