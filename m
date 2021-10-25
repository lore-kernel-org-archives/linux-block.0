Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 11:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F4E60EFF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 11:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJYLSm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:18:42 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:39894 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhJYLSm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 07:18:42 -0400
Received: by mail-io1-f70.google.com with SMTP id r15-20020a6b600f000000b005dde03edc0cso8620501iog.6
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 04:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e5NZpnxNaJyqowu2CwdQsqPF7xPZW737SvpJi76W8ug=;
        b=n9ideF7CgI2qivDtO2s+oalYKltE/Vt1Yo3lobGLHvWVr5bhFcBc0iPJDHbUvTKchD
         r/NzzO0r7nOedBJvOcYHRfoX2nWX7oQ9ypMFA7iil5RniKZP28jefoEmG6kLmeGZdmY7
         LjfqzwUtobZggJiqEhGejpF6IEd8eZApKyZKCH1DXUiOhtdAhZW5IRgVpodvu+Dfa/BA
         7Fjk/8Q1S3uts2LBINQnok1w189XsZSXIkhrE2erdbU7SQIw5r6qKNDdZkhrZoKGeFRL
         dRz95xZoeKOuJBzodzLj13L5KWJSDPG86FslJXWx147U8+GORYLZ5kBYu9eH2PhmC/B9
         iz7w==
X-Gm-Message-State: AOAM533wU1mXtKcoPb8dyiN6C/Y+fdzG7xdKsIY2GbRF0D0FTQkq1Sgd
        MfkD1+nj0+xXInLmpU7BZGq19HBiXivdcifZweyFpNpyg9W2
X-Google-Smtp-Source: ABdhPJzo+aUH+MCnAiTyEKu9F1hOnOjluvS1f1YeBNl20elMwblC8Pwoj2lnN2D+PF7gkxeop3KeAPEK/Bec1UkyTKVRAIuRQmsj
MIME-Version: 1.0
X-Received: by 2002:a02:ccfb:: with SMTP id l27mr4492245jaq.98.1635160580260;
 Mon, 25 Oct 2021 04:16:20 -0700 (PDT)
Date:   Mon, 25 Oct 2021 04:16:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089871905cf2b7d09@google.com>
Subject: [syzbot] KCSAN: data-race in sbitmap_queue_clear /
 sbitmap_queue_clear (3)
From:   syzbot <syzbot+4f8bfd804b4a1f95b8f6@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2f111a6fd5b5 Merge tag 'ceph-for-5.15-rc7' of git://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10dae330b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2868748300e5cf6
dashboard link: https://syzkaller.appspot.com/bug?extid=4f8bfd804b4a1f95b8f6
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f8bfd804b4a1f95b8f6@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in sbitmap_queue_clear / sbitmap_queue_clear

write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 1:
 sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
 blk_mq_put_tag+0x82/0x90
 __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
 blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
 __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
 blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
 lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
 blk_complete_reqs block/blk-mq.c:584 [inline]
 blk_done_softirq+0x69/0x90 block/blk-mq.c:589
 __do_softirq+0x12c/0x26e kernel/softirq.c:558
 run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
 smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
 kthread+0x262/0x280 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 0:
 sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
 blk_mq_put_tag+0x82/0x90
 __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
 blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
 __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
 blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
 lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
 blk_complete_reqs block/blk-mq.c:584 [inline]
 blk_done_softirq+0x69/0x90 block/blk-mq.c:589
 __do_softirq+0x12c/0x26e kernel/softirq.c:558
 run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
 smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
 kthread+0x262/0x280 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

value changed: 0x00000035 -> 0x00000044

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 10 Comm: ksoftirqd/0 Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
