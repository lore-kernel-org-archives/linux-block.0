Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A378C433EF
	for <linux-block@archiver.kernel.org>; Sun, 27 Mar 2022 20:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiC0UKB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Mar 2022 16:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiC0UKA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Mar 2022 16:10:00 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D45FD6
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 13:08:19 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f11-20020a056602070b00b00645d08010fcso9210597iox.15
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 13:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CxecizhYVUoFFb2ENXPAj0S4kGMZ/wuMLwi+CMwdSbI=;
        b=nezhKa6hz3RZ9+C7RmFOKPIprZGvSKj7CMSebNGF+oFEpvyJfXA3KPEhx5LFi3oIAt
         yhPVMIgrDuz3RvitxNwk/pV106YS3FEkLuDYP2XsnYYNB99lfIeri5ZVCE3O2Dqls7nl
         nw3bXj33ROxkYPHRkI0Yjjc4/wkV1X2qBIlVdfvHIwnHmmqvVqmaljFEAK7lQ0qkThJS
         d8I9+Nag+VqIOeJET8+ceQyZ6DPswON3LQ3oRU83MKrVBQDtafzLEW7CmmhxRWHwHj97
         ZyeIPiXY9DEQxY+OF1qTTtD/3l/U7P31SxgmAVYF64o3JAt7oVDnrXwdvSlmo9skbYL5
         8m9g==
X-Gm-Message-State: AOAM530izc65sltzYzDKIyuUyOHs5iZFS1xwe+b+m109R1b9jz9aQyu+
        NOqoitYk9pZF1zhADu31HAk1Igtj6xJok61CO73bh29mtfUw
X-Google-Smtp-Source: ABdhPJwD+PBSPS3ktzpIWdE2S7u5EV8pDUealk+u+8fks+kyKgiSpSbPHMvHcaOUdX0zlvZHyHsVpkDM6GX2PiaEtG08HLZC2fng
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c6:b0:2c2:5f51:c81 with SMTP id
 r6-20020a056e0219c600b002c25f510c81mr4134847ill.57.1648411699002; Sun, 27 Mar
 2022 13:08:19 -0700 (PDT)
Date:   Sun, 27 Mar 2022 13:08:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c341cc05db38c1b0@google.com>
Subject: [syzbot] memory leak in blk_mq_init_tags
From:   syzbot <syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6b1f86f8e9c7 Merge tag 'folio-5.18b' of git://git.infradea..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b41dcb700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6e80763d853259b
dashboard link: https://syzkaller.appspot.com/bug?extid=f08c77040fa163a75a46
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1564ecb3700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888118503c00 (size 192):
  comm "kworker/u4:2", pid 52, jiffies 4294961137 (age 11.420s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    02 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff822c042b>] kmalloc_node include/linux/slab.h:602 [inline]
    [<ffffffff822c042b>] kzalloc_node include/linux/slab.h:728 [inline]
    [<ffffffff822c042b>] blk_mq_init_tags+0x4b/0xc0 block/blk-mq-tag.c:578
    [<ffffffff822b6caa>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3169
    [<ffffffff822bbb86>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3620
    [<ffffffff822c3437>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c3437>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff8229e6f9>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822c7085>] device_add_disk+0x25/0x510 block/genhd.c:421
    [<ffffffff82846437>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3551
    [<ffffffff8270c477>] call_driver_probe drivers/base/dd.c:517 [inline]
    [<ffffffff8270c477>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
    [<ffffffff8270c81c>] really_probe drivers/base/dd.c:558 [inline]
    [<ffffffff8270c81c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:755
    [<ffffffff8270c91a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:785
    [<ffffffff8270d186>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:902
    [<ffffffff827093e7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff8270b9ef>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:931
    [<ffffffff8127cf94>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff8126b3ef>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
    [<ffffffff8126bd19>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454

BUG: memory leak
unreferenced object 0xffff888117fee680 (size 128):
  comm "kworker/u4:2", pid 52, jiffies 4294961137 (age 11.420s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8240b6be>] kmalloc_array_node include/linux/slab.h:679 [inline]
    [<ffffffff8240b6be>] kcalloc_node include/linux/slab.h:684 [inline]
    [<ffffffff8240b6be>] sbitmap_init_node+0xde/0x2d0 lib/sbitmap.c:113
    [<ffffffff8240b8ec>] sbitmap_queue_init_node+0x3c/0x1f0 lib/sbitmap.c:428
    [<ffffffff822c0347>] bt_alloc block/blk-mq-tag.c:543 [inline]
    [<ffffffff822c0347>] blk_mq_init_bitmaps+0x57/0xf0 block/blk-mq-tag.c:555
    [<ffffffff822c0468>] blk_mq_init_tags+0x88/0xc0 block/blk-mq-tag.c:586
    [<ffffffff822b6caa>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3169
    [<ffffffff822bbb86>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3620
    [<ffffffff822c3437>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c3437>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff8229e6f9>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822c7085>] device_add_disk+0x25/0x510 block/genhd.c:421
    [<ffffffff82846437>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3551
    [<ffffffff8270c477>] call_driver_probe drivers/base/dd.c:517 [inline]
    [<ffffffff8270c477>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
    [<ffffffff8270c81c>] really_probe drivers/base/dd.c:558 [inline]
    [<ffffffff8270c81c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:755
    [<ffffffff8270c91a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:785
    [<ffffffff8270d186>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:902
    [<ffffffff827093e7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff8270b9ef>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:931

BUG: memory leak
unreferenced object 0xffff888116df4c00 (size 512):
  comm "kworker/u4:2", pid 52, jiffies 4294961137 (age 11.420s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    10 4c df 16 81 88 ff ff 10 4c df 16 81 88 ff ff  .L.......L......
  backtrace:
    [<ffffffff8240b9b8>] kmalloc_node include/linux/slab.h:602 [inline]
    [<ffffffff8240b9b8>] kzalloc_node include/linux/slab.h:728 [inline]
    [<ffffffff8240b9b8>] sbitmap_queue_init_node+0x108/0x1f0 lib/sbitmap.c:438
    [<ffffffff822c0377>] bt_alloc block/blk-mq-tag.c:543 [inline]
    [<ffffffff822c0377>] blk_mq_init_bitmaps+0x87/0xf0 block/blk-mq-tag.c:557
    [<ffffffff822c0468>] blk_mq_init_tags+0x88/0xc0 block/blk-mq-tag.c:586
    [<ffffffff822b6caa>] blk_mq_alloc_rq_map+0xea/0x1a0 block/blk-mq.c:3169
    [<ffffffff822bbb86>] blk_mq_alloc_map_and_rqs+0x26/0xb0 block/blk-mq.c:3620
    [<ffffffff822c3437>] blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:507 [inline]
    [<ffffffff822c3437>] blk_mq_init_sched+0x127/0x2e0 block/blk-mq-sched.c:587
    [<ffffffff8229e6f9>] elevator_init_mq+0x1f9/0x240 block/elevator.c:709
    [<ffffffff822c7085>] device_add_disk+0x25/0x510 block/genhd.c:421
    [<ffffffff82846437>] sd_probe+0x457/0x670 drivers/scsi/sd.c:3551
    [<ffffffff8270c477>] call_driver_probe drivers/base/dd.c:517 [inline]
    [<ffffffff8270c477>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
    [<ffffffff8270c81c>] really_probe drivers/base/dd.c:558 [inline]
    [<ffffffff8270c81c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:755
    [<ffffffff8270c91a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:785
    [<ffffffff8270d186>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:902
    [<ffffffff827093e7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff8270b9ef>] __device_attach_async_helper+0xcf/0x110 drivers/base/dd.c:931
    [<ffffffff8127cf94>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
