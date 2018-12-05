Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC66C04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 19:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC11208E7
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 19:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC11208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeLETrF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:47:05 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:57755 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeLETrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 14:47:05 -0500
Received: by mail-it1-f197.google.com with SMTP id n124so17474661itb.7
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 11:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YVa/OlWOiplg4fXyE2Kfv28NP4lYPOJQNhiJnwTXdXA=;
        b=ZtEgZCXgSW0yrOTp3Rmn1fWBW2s4kqAgosYFhO+r8LgKse2V1G+3PCgrmJP3ZbttK5
         3L932mr25O5cwRi1XaajIg1vb6UYklkgQNeEOrGoFB9jEcPD2ScSKgH2GsGuzkbWSmQE
         scWufXQ9fsfNCRh+QEN1fiphs/2s8xSFOMiuNI43izcZQqgkeVf3J7XSyTXjKz43hvki
         o52Ggtqpp6Ey/4/70hqZTG0hPGFWMCsRbbe22iM4EF5df4WjL+FL2kwLwxgIKLsX7MRC
         IqfLVilp/DXTIX8qp9+rjtRAvEXldricBNqwvzus8H5x9EhwdoJUzFMTEBT6SQnZY/NJ
         0PUw==
X-Gm-Message-State: AA+aEWZ1pFccgUOXzWpKqmcu8gIppGjemncfKgYWThsZUAEpAb9kxOc3
        9k8IHNJudnTPWzG0+koP1v/Un+/AR2bG5rTlVZcbrLTf62Dp
X-Google-Smtp-Source: AFSGD/WDwZARPztAQzTSPNrYMD5KoACvC1QZ3cT/4R6bpQz1ThtDddK5ayJd/vHkOrZLoSn9/SjnYDf8jTE1OlSSuBob9gKRP+hp
MIME-Version: 1.0
X-Received: by 2002:a02:9143:: with SMTP id b3mr20032495jag.25.1544039223784;
 Wed, 05 Dec 2018 11:47:03 -0800 (PST)
Date:   Wed, 05 Dec 2018 11:47:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073fd73057c4ba52f@google.com>
Subject: WARNING: refcount bug in blk_mq_free_request
From:   syzbot <syzbot+5476726e7cb6a2d59bce@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    60b548237fed Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dab87d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
dashboard link: https://syzkaller.appspot.com/bug?extid=5476726e7cb6a2d59bce
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5476726e7cb6a2d59bce@syzkaller.appspotmail.com

Buffer I/O error on dev nbd0, logical block 2, async page read
block nbd0: Connection timed out, retrying (0/3 alive)
  nbd0: unable to read partition table
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 2551 at lib/refcount.c:187  
refcount_sub_and_test_checked+0x2c9/0x310 lib/refcount.c:187
Kernel panic - not syncing: panic_on_warn set ...
nbd0: partition table beyond EOD, truncated
CPU: 1 PID: 2551 Comm: kworker/1:2H Not tainted 4.20.0-rc4+ #134
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: kblockd blk_mq_run_work_fn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:refcount_sub_and_test_checked+0x2c9/0x310 lib/refcount.c:187
Code: 89 de e8 9a 13 ed fd 84 db 74 07 31 db e9 4d ff ff ff e8 ba 12 ed fd  
48 c7 c7 e0 b1 60 88 c6 05 93 46 80 06 01 e8 f7 72 b6 fd <0f> 0b 31 db e9  
2c ff ff ff 48 89 cf e8 46 66 30 fe e9 41 fe ff ff
RSP: 0018:ffff8881b1aeec00 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
RBP: ffff8881b1aeece8 R08: ffff8881c142c440 R09: ffffed103b5e3ef8
R10: ffffed103b5e3ef8 R11: ffff8881daf1f7c7 R12: ffff8881d175aed8
R13: 00000000ffffffff R14: ffff8881b1aeecc0 R15: 1ffff1103635ddb3
  refcount_dec_and_test_checked+0x1a/0x20 lib/refcount.c:212
  blk_mq_free_request+0x643/0x900 block/blk-mq.c:517
  __blk_mq_end_request block/blk-mq.c:542 [inline]
  blk_mq_end_request+0x2a4/0x490 block/blk-mq.c:551
  blk_mq_dispatch_rq_list+0x132d/0x2500 block/blk-mq.c:1210
  blk_mq_do_dispatch_sched+0x25b/0x580 block/blk-mq-sched.c:107
  blk_mq_sched_dispatch_requests+0x62d/0x9b0 block/blk-mq-sched.c:203
  __blk_mq_run_hw_queue+0x199/0x2e0 block/blk-mq.c:1314
  blk_mq_run_work_fn+0x51/0x70 block/blk-mq.c:1547
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
