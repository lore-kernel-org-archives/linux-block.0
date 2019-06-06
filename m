Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE11EC04AB5
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 18:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C6C20868
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 18:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFFSmI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:42:08 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:42534 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfFFSmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jun 2019 14:42:07 -0400
Received: by mail-it1-f198.google.com with SMTP id s18so672761itl.7
        for <linux-block@vger.kernel.org>; Thu, 06 Jun 2019 11:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Au0D6mWcBFLKUduxTVlVaH1XnraoVojjfsk4fIvDRzM=;
        b=qb0CSxaxSBjHYQgyeGkoxDBhzyuBBTNwO2pohTsGIlsLPZ1PvJwWHQE2hg1W0VF92I
         vJ3cct9HquzqtTEgmptcGBbKLJSFj106J5nsFOp/6ehuh/ytN1UUq9KLBfy1SrFgZcKA
         OYSBOmN/8STSIok2vwaxwaCU7dRJdsH6uJpYhXgzgO3Of8f9JMLEDU6DWhs/pwXS2emt
         mgXpqFpV8blXovxeuki8Cr52Y5PU/2qvE5xKQAnyshrDP+XvzD1wiFvtYcZSVLqkpVdB
         dmDr5mPmCvA+bDoj4aT4wJbUicnSiMAo6+ePpPPYoIqxL7EBdFbJogCzR5fp4/64FYQG
         oGFQ==
X-Gm-Message-State: APjAAAW8soN/DNY6CZ2lFL8hKHpPPomJzNEPC1S8FEYySkDVqVTQW2HT
        zk/RpVgKwpwS2Tn10rMdJwOTKjI2cgXNz7dEcRsCNrrmrvD8
X-Google-Smtp-Source: APXvYqxdfSZuYPUaJoBWPh9eTAKeQEExjBtyzx4VX+hcrua191r4RurLFA9Cr8P/Ib5Z621X804gHa8CaE+1prR9rVKfI87EMaJq
MIME-Version: 1.0
X-Received: by 2002:a24:f801:: with SMTP id a1mr1278395ith.113.1559846526704;
 Thu, 06 Jun 2019 11:42:06 -0700 (PDT)
Date:   Thu, 06 Jun 2019 11:42:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020e6b9058aac120b@google.com>
Subject: KASAN: use-after-free Read in blk_mq_free_rqs
From:   syzbot <syzbot+784281a934c3f71eb71a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9221dced Merge tag 'for-linus-20190601' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b3b772a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1fa7e451a5cac069
dashboard link: https://syzkaller.appspot.com/bug?extid=784281a934c3f71eb71a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149089aaa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b24edea00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+784281a934c3f71eb71a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in blk_mq_free_rqs+0x49f/0x4b0  
block/blk-mq.c:2049
Read of size 8 at addr ffff88809b5c0b10 by task kworker/1:1/22

CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.2.0-rc2+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events __blk_release_queue
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:188
  __kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  kasan_report+0x12/0x20 mm/kasan/common.c:614
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  blk_mq_free_rqs+0x49f/0x4b0 block/blk-mq.c:2049
  blk_mq_sched_free_tags block/blk-mq-sched.c:453 [inline]
  blk_mq_sched_tags_teardown+0x126/0x210 block/blk-mq-sched.c:485
  blk_mq_exit_sched+0x1fa/0x2d0 block/blk-mq-sched.c:557
  elevator_exit+0x70/0xa0 block/elevator.c:185
  blk_exit_queue block/blk-sysfs.c:853 [inline]
  __blk_release_queue+0x127/0x330 block/blk-sysfs.c:895
  process_one_work+0x989/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x354/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 8904:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:462
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:503
  kmem_cache_alloc_trace+0x151/0x750 mm/slab.c:3555
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  loop_add+0x51/0x8d0 drivers/block/loop.c:1973
  loop_control_ioctl drivers/block/loop.c:2157 [inline]
  loop_control_ioctl+0x165/0x360 drivers/block/loop.c:2139
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd5f/0x1380 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8905:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:451
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:459
  __cache_free mm/slab.c:3432 [inline]
  kfree+0xcf/0x220 mm/slab.c:3755
  loop_remove+0xa1/0xd0 drivers/block/loop.c:2078
  loop_control_ioctl drivers/block/loop.c:2173 [inline]
  loop_control_ioctl+0x320/0x360 drivers/block/loop.c:2139
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd5f/0x1380 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809b5c0900
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 528 bytes inside of
  1024-byte region [ffff88809b5c0900, ffff88809b5c0d00)
The buggy address belongs to the page:
page:ffffea00026d7000 refcount:1 mapcount:0 mapping:ffff8880aa400ac0  
index:0x0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002411188 ffffea000290c088 ffff8880aa400ac0
raw: 0000000000000000 ffff88809b5c0000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809b5c0a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809b5c0a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88809b5c0b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff88809b5c0b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809b5c0c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
