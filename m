Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91FDC4708F
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 04:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AEC861375
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 04:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhFAEtF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Jun 2021 00:49:05 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35809 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFAEtC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Jun 2021 00:49:02 -0400
Received: by mail-io1-f70.google.com with SMTP id w17-20020a6b4a110000b0290492680338ecso6192304iob.2
        for <linux-block@vger.kernel.org>; Mon, 31 May 2021 21:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cQ/WsXAPZ6FCnqmHJD4ME6qu+k7CkFxG85S8nmtGEvg=;
        b=J8wvSWTHCh8oNu40AuT7CDnNTUxLw9CfU8t/o8KIpIfoHApNUKMB5kWlLfvNHHJHiy
         x0Y7aDFnB+2Eo68MnDXvr+kJwzkucIo3eElbSZugxiTx6ONICk3HeyVM5gZOZyqu/+H3
         mntu0AoKzUguv4nOq19iiy62dEaW5T+P7fxohs2KPDeujQTkG1rCLcDMCDNxlAiGOdet
         cmWTUMp/VCR5Kg6ye+tcKBUWSejYNp7zsvkj8f8VtLjhuUararqODmnVq0RQg4BcdNFj
         9VxK4gGke2WRHx1Pzk133bi+xWLerJiGCdmcAR5xZqxM6eOTfkxIhOfYa08VSGSLpeqU
         u6kQ==
X-Gm-Message-State: AOAM531aDiBI7uo97LdEl4IS+1d1DdItWfS6ItEwSwly/RjBaRad3bni
        QwsVb67zNS2P2yJHiom0wQDT97bpcK1p88zAPu+KvbeAqzXG
X-Google-Smtp-Source: ABdhPJxwffnwptzUI5ttAL7HOq4FD5LtER+oQQJjKXiBAlzVzs0RqL49Z3pB9xvHk5jnhhb6LhwuGxu58m0jTh3s6/mNaYmetmhB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11b1:: with SMTP id 17mr9683133ilj.225.1622522840953;
 Mon, 31 May 2021 21:47:20 -0700 (PDT)
Date:   Mon, 31 May 2021 21:47:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093372a05c3ad0902@google.com>
Subject: [syzbot] WARNING: refcount bug in blk_mq_free_request (3)
From:   syzbot <syzbot+836f6f41af3c5867a8b9@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d7c5303f Merge tag 'net-5.13-rc4' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125b6e37d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aeeaaad9464418bb
dashboard link: https://syzkaller.appspot.com/bug?extid=836f6f41af3c5867a8b9

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+836f6f41af3c5867a8b9@syzkaller.appspotmail.com

refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 2924 at lib/refcount.c:28 refcount_warn_saturate+0x1d1/0x1e0 lib/refcount.c:28
Modules linked in:
CPU: 0 PID: 2924 Comm: kworker/0:1H Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: kblockd blk_mq_run_work_fn
RIP: 0010:refcount_warn_saturate+0x1d1/0x1e0 lib/refcount.c:28
Code: e9 db fe ff ff 48 89 df e8 4c 31 e9 fd e9 8a fe ff ff e8 62 a8 a4 fd 48 c7 c7 60 21 c2 89 c6 05 be 76 e5 09 01 e8 fc c0 05 05 <0f> 0b e9 af fe ff ff 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 55
RSP: 0018:ffffc90008cd78c0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801fb18000 RSI: ffffffff815c1805 RDI: fffff5200119af0a
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815bb63e R11: 0000000000000000 R12: ffff8880a9d70ae8
R13: ffffe8ffffc45300 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000185f848 CR3: 00000000543ac000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 blk_mq_free_request+0x4d0/0x640 block/blk-mq.c:533
 __blk_mq_end_request block/blk-mq.c:558 [inline]
 blk_mq_end_request+0x41a/0x510 block/blk-mq.c:567
 blk_mq_dispatch_rq_list+0xf4d/0x1fa0 block/blk-mq.c:1398
 __blk_mq_do_dispatch_sched+0x3bc/0x910 block/blk-mq-sched.c:191
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:204 [inline]
 __blk_mq_sched_dispatch_requests+0x361/0x490 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0xfb/0x180 block/blk-mq-sched.c:351
 __blk_mq_run_hw_queue+0xd8/0x150 block/blk-mq.c:1499
 blk_mq_run_work_fn+0x55/0x70 block/blk-mq.c:1831
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
