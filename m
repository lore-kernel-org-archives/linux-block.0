Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C114C433ED
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 11:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C9661166
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 11:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhEQL2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 07:28:37 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45859 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbhEQL2g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 07:28:36 -0400
Received: by mail-io1-f70.google.com with SMTP id w5-20020a6bf0050000b029043afd24a1b2so1434107ioc.12
        for <linux-block@vger.kernel.org>; Mon, 17 May 2021 04:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VRtyE+K4bDvEeVJIGzRGJz8MzoagJik85ppor/eakrk=;
        b=tsk9UP8X4SjWFZeBfPwBc5+gL7vpV6Qr06YxJOkzUl5r4ScMPPjBHkX/DlkSgWUIA2
         qRowX/mcYsSSOf3UjxC+vXErc7/mVEVP+wWnmhAJCRnAmF/TCktM8j8fjAQpl/vcA9Nl
         EOKT6WcbkJ59dVSP/gEBcWGrYFvRxiQIPzmJ6dqwrbRmAYMw5FeS6MlelmG0aOfgAWfZ
         e7LiAdcuSC1px4gOtalP4prxM9ZuQd6V4A41fpAn/x/DMVaJD54E9sem3f7Zhj1Ypizi
         vh50gftyNmgpYNe71+8wv0rHiZ6bickFAwq8Gs6R851JKOit2DnNEHwkCUiUKT4tO0xB
         oCtw==
X-Gm-Message-State: AOAM532OrXjtQ85S9WflIQ4C4DnoGoOKzoJ0/op4nfuw8JdnCEkGsNoC
        c0VwZoiegBgWHPhNu008Bah1fPKWMv+nww30CwoRxBTL7swI
X-Google-Smtp-Source: ABdhPJwv4SXSZUY53hUX3Oi3hmYhGejpxNC0AbLMphCbwAiOTmorx+lrw+lwUrWBaCZ6ZiKvjwCCxceIHbgB09vzJEL0a8aKq5pu
MIME-Version: 1.0
X-Received: by 2002:a02:1c81:: with SMTP id c123mr58166571jac.42.1621250840268;
 Mon, 17 May 2021 04:27:20 -0700 (PDT)
Date:   Mon, 17 May 2021 04:27:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d129905c284e02d@google.com>
Subject: [syzbot] WARNING in blk_rq_append_bio
From:   syzbot <syzbot+1c24e3484e48799b2333@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hare@suse.de, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5103a5be Add linux-next specific files for 20210407
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17b28e36d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c278e8a8a7f47f4c
dashboard link: https://syzkaller.appspot.com/bug?extid=1c24e3484e48799b2333
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1232b5c9d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17971a36d00000

The issue was bisected to:

commit 393bb12e00580aaa23356504eed38d8f5571153a
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Mar 31 07:30:01 2021 +0000

    block: stop calling blk_queue_bounce for passthrough requests

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134e9381d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ce9381d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=174e9381d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c24e3484e48799b2333@syzkaller.appspotmail.com
Fixes: 393bb12e0058 ("block: stop calling blk_queue_bounce for passthrough requests")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 25 at block/blk-map.c:488 blk_rq_append_bio+0x565/0x680 block/blk-map.c:488
Modules linked in:
CPU: 0 PID: 25 Comm: kworker/u4:1 Not tainted 5.12.0-rc6-next-20210407-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:blk_rq_append_bio+0x565/0x680 block/blk-map.c:488
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 de 00 00 00 48 8b 44 24 10 48 89 98 a0 00 00 00 45 31 e4 e9 3f fe ff ff e8 6b 3e bc fd <0f> 0b 41 bc ea ff ff ff e9 2d fe ff ff c7 44 24 08 00 00 00 00 e9
RSP: 0018:ffffc90000dff6d0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888011cbb900 RSI: ffffffff83b7ea55 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff83b7e568 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000008 R14: ffff88801c86e400 R15: ffff88801c86e400
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb8501cc930 CR3: 0000000023c21000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 blk_rq_map_kern+0x5db/0x750 block/blk-map.c:653
 __scsi_execute+0x4c1/0x600 drivers/scsi/scsi_lib.c:224
 scsi_execute_req include/scsi/scsi_device.h:462 [inline]
 read_capacity_10+0x112/0x690 drivers/scsi/sd.c:2442
 sd_read_capacity drivers/scsi/sd.c:2519 [inline]
 sd_revalidate_disk.isra.0+0x206c/0x7c00 drivers/scsi/sd.c:3203
 sd_probe+0x9e5/0x1140 drivers/scsi/sd.c:3459
 really_probe+0x291/0xf60 drivers/base/dd.c:576
 driver_probe_device+0x298/0x410 drivers/base/dd.c:763
 __device_attach_driver+0x203/0x2c0 drivers/base/dd.c:870
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach_async_helper+0x1c9/0x290 drivers/base/dd.c:896
 async_run_entry_fn+0x9d/0x550 kernel/async.c:127
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
