Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2644BC43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F332720866
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 11:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeLULLF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:11:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:35079 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbeLULLF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 06:11:05 -0500
Received: by mail-it1-f198.google.com with SMTP id c128so4766191itc.0
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 03:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UBVrCdieYg9UK0EPEY0nGUoPuxOHIQH4409NbwCEasI=;
        b=DQ7yYDNCOgGxaFnluJUiyD+inEjmeCSISZ4QJjlC1dy1eLn0XXwTCd6Sw36H1KKVPD
         eESo8MOgsogghaUw2CJfDVQqxHZhZUz2SG0Fw5HbWa0jPlgYZKJoz5sEOBssTZF8E/vz
         CgSx19mvaIpGtVZeAD2iKBhpFoMogKOmA6PU3hBQ+eMJFFOKRDVg695I8i8J9RIHSZs1
         NpQ3bdPAmkEtwHorLLrYi5FMC3Yh3/XwimgDHYd5j9X513Wf24B0k4FSSWSCB53v9h4u
         CebZEXL7xbFOd8UIfk3Cr9rG3zGdgWs6dwt71c9BGCG0pTKqFfCsGQLzt5/ei0QZGM5Z
         kIog==
X-Gm-Message-State: AA+aEWbUC1wwVrZfJKi6Lfa5BBsRVZsJgFTSmD/f56eAibZrXp6tZgBI
        RDDY17N3p4Iq9uEHC8u3Uf/ZeMW+6HZTj2P+AHK7IPhtTbJp
X-Google-Smtp-Source: AFSGD/UUGDflqs4Aka6fSMF5nfeoOkp1KEiEBoXBwfx1gM/LEfzV4NRvXfS1qv1Yrm+gJmXjDlD9TfPSl7keyXfVox3Lju74Bk1Y
MIME-Version: 1.0
X-Received: by 2002:a24:4ac4:: with SMTP id k187mr1672823itb.8.1545390663620;
 Fri, 21 Dec 2018 03:11:03 -0800 (PST)
Date:   Fri, 21 Dec 2018 03:11:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b5eb5057d864dab@google.com>
Subject: linux-next test error: WARNING in __bio_associate_blkg
From:   syzbot <syzbot+a36a3ba92bea3b315c64@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    340ae71f9dd4 Add linux-next specific files for 20181221
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d95667400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c190b602a5d2d731
dashboard link: https://syzkaller.appspot.com/bug?extid=a36a3ba92bea3b315c64
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a36a3ba92bea3b315c64@syzkaller.appspotmail.com

sshd (6102) used greatest stack depth: 15720 bytes left
IPVS: ftp: loaded support on port[0] = 21
WARNING: CPU: 1 PID: 1520 at include/linux/blk-cgroup.h:518  
blkg_tryget_closest include/linux/blk-cgroup.h:518 [inline]
WARNING: CPU: 1 PID: 1520 at include/linux/blk-cgroup.h:518  
__bio_associate_blkg.isra.36+0x80b/0x8f0 block/bio.c:2010
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 1520 Comm: kworker/u4:3 Not tainted 4.20.0-rc7-next-20181221  
#182
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  panic+0x2ad/0x632 kernel/panic.c:214
  __warn.cold.8+0x20/0x4f kernel/panic.c:571
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:176 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:269
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:288
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:blkg_tryget_closest include/linux/blk-cgroup.h:518 [inline]
RIP: 0010:__bio_associate_blkg.isra.36+0x80b/0x8f0 block/bio.c:2010
Code: 7b 50 48 89 f8 48 c1 e8 03 42 80 3c 20 00 0f 85 f1 00 00 00 48 8b 43  
50 4c 89 ef e8 bf c6 88 04 e9 a4 f9 ff ff e8 c5 ad 07 fe <0f> 0b e9 5c fa  
ff ff e8 b9 ad 07 fe e8 ab e2 88 fd e9 fe f9 ff ff
RSP: 0018:ffff8881d462d738 EFLAGS: 00010293
RAX: ffff8881d461e380 RBX: 0000000000000000 RCX: ffffffff83779576
RDX: 0000000000000000 RSI: ffffffff83779b1b RDI: 0000000000000005
RBP: ffff8881d462d8b8 R08: ffff8881d461e380 R09: ffffed103b5e5b77
R10: ffffed103b5e5b77 R11: ffff8881daf2dbbb R12: ffff8881cee19340
R13: ffff8881b3354a40 R14: ffff8881bdf4a218 R15: ffff8881cee19340
  bio_clone_blkg_association block/bio.c:2101 [inline]
  __bio_clone_fast+0x412/0x5e0 block/bio.c:612
  bio_clone_fast+0x42/0x110 block/bio.c:633
  bio_split+0x86/0x260 block/bio.c:1819
  blk_bio_segment_split block/blk-merge.c:231 [inline]
  blk_queue_split+0xa1e/0x2080 block/blk-merge.c:262
  blk_mq_make_request+0x2e7/0x1e30 block/blk-mq.c:1917
  generic_make_request+0x9a5/0x1890 block/blk-core.c:1087
  submit_bio+0xba/0x460 block/blk-core.c:1195
  ext4_io_submit+0x197/0x230 fs/ext4/page-io.c:356
  ext4_writepages+0x1c4b/0x4190 fs/ext4/inode.c:2911
  do_writepages+0x9a/0x1a0 mm/page-writeback.c:2335
  __writeback_single_inode+0x20a/0x1660 fs/fs-writeback.c:1316
  writeback_sb_inodes+0x71f/0x1210 fs/fs-writeback.c:1580
  __writeback_inodes_wb+0x1b9/0x340 fs/fs-writeback.c:1649
  wb_writeback+0xa73/0xfc0 fs/fs-writeback.c:1758
  wb_check_old_data_flush fs/fs-writeback.c:1860 [inline]
  wb_do_writeback fs/fs-writeback.c:1913 [inline]
  wb_workfn+0x1008/0x1790 fs/fs-writeback.c:1942
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
