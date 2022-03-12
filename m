Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1289C433EF
	for <linux-block@archiver.kernel.org>; Sat, 12 Mar 2022 21:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiCLVqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Mar 2022 16:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiCLVqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Mar 2022 16:46:34 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6601DC998
        for <linux-block@vger.kernel.org>; Sat, 12 Mar 2022 13:45:26 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id u25-20020a5d8199000000b006421bd641bbso9397425ion.11
        for <linux-block@vger.kernel.org>; Sat, 12 Mar 2022 13:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ct5lREH82s9udYR1fdl4zYR0ltj+8XZHSKD6BawGeNs=;
        b=kCO1BNq/AUSiOrRkj0G9ClT7ZEYtWxAZtR1eLXf3G2iYe5/btEEptBLl0Px9PydVHZ
         8sM7sI5MI9HlKU1lLrN2GRza8F0wWEdIluefUmmllFMkX1cNYAJJ5tCpzuLgAMOfMQ71
         VC1r/SNZkVU99Q+YowHx0XQbT5Buc8Tc2TMEMo1nGKgHCCkwgbAQpfqyzf6ULvQc7Uxk
         f1A9j4shBbq6xhtoQNyG0Qdm8ohKW4EeYjBjCW2g6nZdPhM8ihRfLr3b7pqUulsGYkDW
         yx0gM0N3lna6jb3treMljy/98WOBSJJBIVnytBy2duQEwU7t+s6wFSyzUUufhKt7rRfy
         ML7w==
X-Gm-Message-State: AOAM530UF4WUVV7NGATKLhI0rCcyY8w/d4XxrWrdP6l97rARvYuLpVPT
        Da72PLRXqwkcbaP1FkVUHbJP2RNubPrAXkZJriKrz69dqNTC
X-Google-Smtp-Source: ABdhPJxpp2Prvr0d6VA6nYUKzMcyVjycfSW9ihV8mjo900p/r9Rekh7C89SX9wkxl5SP7oh0D1QrybMsw19+VAdNnvEZ48wptzoM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dc5:b0:313:f8bd:35a7 with SMTP id
 m5-20020a0566380dc500b00313f8bd35a7mr14095224jaj.75.1647121525902; Sat, 12
 Mar 2022 13:45:25 -0800 (PST)
Date:   Sat, 12 Mar 2022 13:45:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007414e805da0c5de4@google.com>
Subject: [syzbot] memory leak in blk_iolatency_init (2)
From:   syzbot <syzbot+b42749a851a47a0f581b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    79b00034e9dc Merge tag 'drm-fixes-2022-03-11' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cf8329700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9e1a3a8e38b9582
dashboard link: https://syzkaller.appspot.com/bug?extid=b42749a851a47a0f581b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101cc4ee700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1270b5e9700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b42749a851a47a0f581b@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.480s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.480s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.560s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.560s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.630s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.630s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.700s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.700s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.770s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.770s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.850s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.850s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.920s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 503.920s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fa00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 504.000s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff 38 c8 26 04 81 88 ff ff  @]......8.&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888103f8fb00 (size 96):
  comm "kworker/u4:0", pid 8, jiffies 4294937736 (age 504.000s)
  hex dump (first 32 bytes):
    40 5d ca 85 ff ff ff ff c0 c2 26 04 81 88 ff ff  @]........&.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8228f408>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8228f408>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8228f408>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff82285ede>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1206
    [<ffffffff8224b1aa>] blk_alloc_queue+0x24a/0x4a0 block/blk-core.c:495
    [<ffffffff822647a5>] blk_mq_init_queue_data block/blk-mq.c:3883 [inline]
    [<ffffffff822647a5>] blk_mq_init_queue+0x35/0x90 block/blk-mq.c:3897
    [<ffffffff8277f2b1>] scsi_alloc_sdev+0x231/0x3b0 drivers/scsi/scsi_scan.c:330
    [<ffffffff82780425>] scsi_probe_and_add_lun+0xff5/0x17e0 drivers/scsi/scsi_scan.c:1167
    [<ffffffff827812df>] __scsi_scan_target+0x14f/0x9a0 drivers/scsi/scsi_scan.c:1649
    [<ffffffff82781da7>] scsi_scan_channel drivers/scsi/scsi_scan.c:1737 [inline]
    [<ffffffff82781da7>] scsi_scan_channel+0xb7/0x100 drivers/scsi/scsi_scan.c:1713
    [<ffffffff82781faf>] scsi_scan_host_selected+0x1bf/0x220 drivers/scsi/scsi_scan.c:1766
    [<ffffffff827820d0>] do_scsi_scan_host+0xc0/0xd0 drivers/scsi/scsi_scan.c:1905
    [<ffffffff82782359>] do_scan_async+0x19/0x200 drivers/scsi/scsi_scan.c:1915
    [<ffffffff8127cff4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b43f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd69>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
    [<ffffffff81275725>] kthread+0x125/0x160 kernel/kthread.c:377
    [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
