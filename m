Return-Path: <SRS0=lQ3E=AX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7AC433E1
	for <linux-block@archiver.kernel.org>; Sun, 12 Jul 2020 22:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B5E206F0
	for <linux-block@archiver.kernel.org>; Sun, 12 Jul 2020 22:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgGLWYS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Jul 2020 18:24:18 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:49810 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgGLWYS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Jul 2020 18:24:18 -0400
Received: by mail-il1-f200.google.com with SMTP id w10so8303603ilm.16
        for <linux-block@vger.kernel.org>; Sun, 12 Jul 2020 15:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lfEUoN6eZ2Vpakurx2iFM6Dd7YCNc28MRRpsVU4KH6I=;
        b=Y/bJdWwMWcgyVV8ORlkH3xtzrrl0z0CNMXrDto3+ZECXzuerVqpSpFG7sHhzPNhwZH
         RU4AoizSh5gGzenQnV+pT/ArQ6km0jeoSPJW3KkG9plu4MIEa6NCn+auqDA5B/oKpsRX
         WZTveL8eigKP54VSgJ4BAreIPnHS0R0VKFljQHoC28mFlUoD1sNP2Mt4tP/VA/yMjxs1
         ZybZKQ1XTNi+HgI5Rdu7AuAl+WpMQdESLAm586+JHhCjDWn+Se07Sr/vF28q3xt0novD
         UIF+hdlwhIhPVug0PVK7OsAAiOaohey+okpXx3OQXAkZm9j4yrBNHbI2nMAwCt7AFjRI
         xYjw==
X-Gm-Message-State: AOAM530OLIt+eiF8dNgN6sL0KGnlLATHSF7QWCmbI88HbTMSum75Ebp1
        5LRb/+9arQ0Ep79PrcAAu9eeyF7awMgKTDMqS1sgI2QAMH5x
X-Google-Smtp-Source: ABdhPJxd5+giVy0IWcrPsNaP7TvkuUBp/M1jeFVfGUOvBqt+HdmQhJZrQ2byAjo/3BPpBrTfibhqYlS4NJq5ZuOr2WbxiJA40OY8
MIME-Version: 1.0
X-Received: by 2002:a02:108a:: with SMTP id 132mr69030102jay.131.1594592657308;
 Sun, 12 Jul 2020 15:24:17 -0700 (PDT)
Date:   Sun, 12 Jul 2020 15:24:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6807f05aa4608b7@google.com>
Subject: WARNING in kthread_queue_work
From:   syzbot <syzbot+fa64e680a1ff32087778@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    89032636 Add linux-next specific files for 20200708
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11638f9d100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64a250ebabc6c320
dashboard link: https://syzkaller.appspot.com/bug?extid=fa64e680a1ff32087778
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bf9f2f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118380ed100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fa64e680a1ff32087778@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6844 at kernel/kthread.c:819 queuing_blocked kernel/kthread.c:819 [inline]
WARNING: CPU: 1 PID: 6844 at kernel/kthread.c:819 kthread_queue_work+0x16d/0x1b0 kernel/kthread.c:866
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6844 Comm: systemd-udevd Not tainted 5.8.0-rc4-next-20200708-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:542
RIP: 0010:queuing_blocked kernel/kthread.c:819 [inline]
RIP: 0010:kthread_queue_work+0x16d/0x1b0 kernel/kthread.c:866
Code: 0f 85 72 ff ff ff e8 62 49 26 00 48 8d 55 48 4c 89 e6 48 89 ef e8 63 ec ff ff 41 bc 01 00 00 00 e9 56 ff ff ff e8 43 49 26 00 <0f> 0b 45 31 e4 e9 47 ff ff ff 48 c7 c7 f4 61 af 8a e8 dd fd 65 00
RSP: 0018:ffffc900016e72b8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff814db478
RDX: ffff888095b08440 RSI: ffffffff814db4ed RDI: ffff8880a1d731c0
RBP: ffff8880a1d73158 R08: 0000000000000001 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a14d6328
R13: 0000000000000286 R14: ffff8880a1d73160 R15: dffffc0000000000
 loop_queue_rq+0x428/0x590 drivers/block/loop.c:2027
 blk_mq_dispatch_rq_list+0x2e0/0x1e40 block/blk-mq.c:1389
 __blk_mq_do_dispatch_sched+0x3bc/0x870 block/blk-mq-sched.c:194
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:207 [inline]
 __blk_mq_sched_dispatch_requests+0x394/0x490 block/blk-mq-sched.c:323
 blk_mq_sched_dispatch_requests+0xfb/0x180 block/blk-mq-sched.c:349
 __blk_mq_run_hw_queue+0x13a/0x2d0 block/blk-mq.c:1529
 __blk_mq_delay_run_hw_queue+0x522/0x5f0 block/blk-mq.c:1606
 blk_mq_run_hw_queue+0x16c/0x2f0 block/blk-mq.c:1659
 blk_mq_sched_insert_requests+0x286/0x620 block/blk-mq-sched.c:603
 blk_mq_flush_plug_list+0x3d8/0x560 block/blk-mq.c:1928
 blk_flush_plug_list block/blk-core.c:1867 [inline]
 blk_finish_plug block/blk-core.c:1884 [inline]
 blk_finish_plug+0x83/0xe0 block/blk-core.c:1880
 read_pages+0x4a5/0x8d0 mm/readahead.c:150
 page_cache_readahead_unbounded+0x572/0x850 mm/readahead.c:244
 __do_page_cache_readahead mm/readahead.c:273 [inline]
 force_page_cache_readahead+0x2e9/0x460 mm/readahead.c:303
 page_cache_sync_readahead mm/readahead.c:580 [inline]
 page_cache_sync_readahead+0x113/0x130 mm/readahead.c:567
 generic_file_buffered_read+0x159d/0x3150 mm/filemap.c:2058
 generic_file_read_iter+0x396/0x4e0 mm/filemap.c:2362
 blkdev_read_iter+0x11b/0x180 fs/block_dev.c:2021
 call_read_iter include/linux/fs.h:1873 [inline]
 new_sync_read+0x41a/0x6e0 fs/read_write.c:414
 vfs_read+0x45c/0x520 fs/read_write.c:493
 ksys_read+0x12d/0x250 fs/read_write.c:624
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7ff65bf6a210
Code: Bad RIP value.
RSP: 002b:00007ffde963e968 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000557d6f90c200 RCX: 00007ff65bf6a210
RDX: 0000000000000400 RSI: 0000557d6f90c228 RDI: 000000000000000f
RBP: 0000557d6f90ed90 R08: 00007ff65bf54fe8 R09: 0000000000000430
R10: 0000557d6f90c218 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000400 R14: 0000557d6f90ede0 R15: 0000000000000400
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
