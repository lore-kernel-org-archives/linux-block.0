Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F825C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 23:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC0610A2
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 23:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbhIMX3m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 19:29:42 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:35574 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242170AbhIMX3l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 19:29:41 -0400
Received: by mail-il1-f199.google.com with SMTP id f4-20020a056e0204c400b0022dbd3f8b18so15982526ils.2
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 16:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zoiyz9yumUb2OwDpSUzdanvEqwi+zK0yBV9E9brBk3c=;
        b=NaWWIWbEHiZVZNULLeKmKNuJZsA0Jh2hZ//6IU4pkUDSrTs8p99Vg5wIDslYiWvUbW
         cIQ8OIRd5laSSKw6bx9186ipj33jNQMewQcd8uK63z/5lFMbp+ssx095duwCHFYIGMLM
         gqWc7jl7QA4ctuq0IquvXoj9KqiT5/imIJrRVVzV7V51Mzusd0Gus1xowwN0emMbD3Pv
         Gy+1zp3QWA/hnmNdLoau8+QPGsRXh6IWLUHHOCZyx1D5u4d4NmIR1dwdj4CoH0zQyWwB
         91Pr0y6/2CNRUpNEeIHgdhQi0Si3U3hyBkKlPt/5l82RXeRld1zgbD4z/1TDlyh73Iqw
         t5EA==
X-Gm-Message-State: AOAM533gYzSzuZ58MUqXylqxYahNKPjBgnR4gmMWrH9F0tK3kiWqOt7m
        HOHZlU+ZzAAFrZAQ8YDL2FGUE1/GOVAfSpaN527sf+aDTvyY
X-Google-Smtp-Source: ABdhPJxq8rbwHAG7zj/ETr+Yck5PBsq65xMiCa044uwkatUumATKS1ZpToFPv45jns8Qhr7aUYOjfD52RGCgkvDjpsqprS85LWog
MIME-Version: 1.0
X-Received: by 2002:a02:b0d1:: with SMTP id w17mr11996507jah.46.1631575704786;
 Mon, 13 Sep 2021 16:28:24 -0700 (PDT)
Date:   Mon, 13 Sep 2021 16:28:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ee28405cbe8d287@google.com>
Subject: [syzbot] memory leak in blk_iolatency_init
From:   syzbot <syzbot+01321b15cc98e6bf96d6@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a3fa7a101dcf Merge branches 'akpm' and 'akpm-hotfixes' (pa..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b4a5b3300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ee3a4c022ccbbca
dashboard link: https://syzkaller.appspot.com/bug?extid=01321b15cc98e6bf96d6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148c170b300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01321b15cc98e6bf96d6@syzkaller.appspotmail.com

2021/09/09 22:14:31 executed programs: 444
BUG: memory leak
unreferenced object 0xffff888129acdb80 (size 96):
  comm "syz-executor.1", pid 12661, jiffies 4294962682 (age 15.220s)
  hex dump (first 32 bytes):
    20 47 c9 85 ff ff ff ff 20 d4 8e 29 81 88 ff ff   G...... ..)....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82264ec8>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82264ec8>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82264ec8>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:724
    [<ffffffff8225b8c4>] blkcg_init_queue+0xb4/0x1c0 block/blk-cgroup.c:1185
    [<ffffffff822253da>] blk_alloc_queue+0x22a/0x2e0 block/blk-core.c:566
    [<ffffffff8223b175>] blk_mq_init_queue_data block/blk-mq.c:3100 [inline]
    [<ffffffff8223b175>] __blk_mq_alloc_disk+0x25/0xd0 block/blk-mq.c:3124
    [<ffffffff826a9303>] loop_add+0x1c3/0x360 drivers/block/loop.c:2344
    [<ffffffff826a966e>] loop_control_get_free drivers/block/loop.c:2501 [inline]
    [<ffffffff826a966e>] loop_control_ioctl+0x17e/0x2e0 drivers/block/loop.c:2516
    [<ffffffff81597eec>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81597eec>] __do_sys_ioctl fs/ioctl.c:874 [inline]
    [<ffffffff81597eec>] __se_sys_ioctl fs/ioctl.c:860 [inline]
    [<ffffffff81597eec>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:860
    [<ffffffff843fa745>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843fa745>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
