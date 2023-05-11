Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07537C7EE22
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 07:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjEKHAO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 03:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjEKG7w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 02:59:52 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DDA6181
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 23:59:10 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-76c6048ca2cso182851439f.0
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 23:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788319; x=1686380319;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WN5PFATTZHA54ISSQ7zes2bFpUInfaZ2kfXXd5367QU=;
        b=QMUDs1/gA6kGYPRFMFTl8JFmJ3L1vuizLZp1t1gcugnHlgmQyp7KQd2ZJcXSV2B8aj
         M3e8dxDh1ppOnhTMLmTxWfr+Kjg/slxdbWXJxZeBI2o11Cplf+LAQtPzLNyqrb9GyHWa
         L3oYYx7uGhjilE7tmPiU2gXyCyQQKaWz3Dc3XJGt2xUP4hokUVootZISV+vENXWdKHQq
         6SWA+/HxyITAIfqfQfGAykAVsT09NIBaYy4FaLBc21AgbjLhOPVVJgB1A1gKTfT05Vnm
         V6SJXDGDIP3/Xd/o5WQRFit9ilAaiSMsY7dzm0Tl5NymlderlP4cM0ejXUI5sEDtrDyx
         jHdg==
X-Gm-Message-State: AC+VfDwnLabSMPkY85iVjXaF5skUTavf8npmUBgRAnNZxYIfi3pTz3ua
        IIMKVh0pH15G9KOLTcDjuHRk65Aa+xVQ6NudeC5eC0sCIzLM
X-Google-Smtp-Source: ACHHUZ6lzdostnls62kWkjlkXdEHUHVPKvj6frxV8VTQ60D23Kq79Oi5JtFBHXeZQtn/EodnGiFzM8l+WxHke0QP8a+8Mk+3MGS/
MIME-Version: 1.0
X-Received: by 2002:a02:94cd:0:b0:40f:80e3:6585 with SMTP id
 x71-20020a0294cd000000b0040f80e36585mr4250372jah.1.1683788319068; Wed, 10 May
 2023 23:58:39 -0700 (PDT)
Date:   Wed, 10 May 2023 23:58:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a294db05fb6584a4@google.com>
Subject: [syzbot] upstream boot error: KMSAN: uninit-value in unregister_blkdev
From:   syzbot <syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confusio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c0674c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7a1059074b7bdce
dashboard link: https://syzkaller.appspot.com/bug?extid=a66467b3864e82f8559f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4c6da24829a/disk-16a88291.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b2a0fc666c9/vmlinux-16a88291.xz
kernel image: https://storage.googleapis.com/syzbot-assets/710105c78106/bzImage-16a88291.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com

floppy0: no floppy controllers found
work still pending
=====================================================
BUG: KMSAN: uninit-value in strcmp+0xcf/0x120 lib/string.c:283
 strcmp+0xcf/0x120 lib/string.c:283
 unregister_blkdev+0x142/0x270 block/genhd.c:293
 do_floppy_init+0x4d3/0x15f0 drivers/block/floppy.c:4751
 floppy_async_init+0x17/0x20 drivers/block/floppy.c:4767
 async_run_entry_fn+0x97/0x420 kernel/async.c:127
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2405
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2552
 kthread+0x3e8/0x540 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Uninit was created at:
 slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:716
 slab_alloc_node mm/slub.c:3451 [inline]
 __kmem_cache_alloc_node+0x4ff/0x8b0 mm/slub.c:3490
 kmalloc_trace+0x51/0x200 mm/slab_common.c:1057
 kmalloc include/linux/slab.h:559 [inline]
 __register_blkdev+0x1a9/0x650 block/genhd.c:246
 do_floppy_init+0x420/0x15f0 drivers/block/floppy.c:4604
 floppy_async_init+0x17/0x20 drivers/block/floppy.c:4767
 async_run_entry_fn+0x97/0x420 kernel/async.c:127
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2405
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2552
 kthread+0x3e8/0x540 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

CPU: 1 PID: 39 Comm: kworker/u4:3 Not tainted 6.4.0-rc1-syzkaller-00012-g16a8829130ca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: events_unbound async_run_entry_fn

=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
