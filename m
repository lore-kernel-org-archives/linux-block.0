Return-Path: <SRS0=wE/y=4Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43972C10F00
	for <linux-block@archiver.kernel.org>; Sat,  7 Mar 2020 03:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E3A2073B
	for <linux-block@archiver.kernel.org>; Sat,  7 Mar 2020 03:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCGDzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 22:55:13 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:36879 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCGDzN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 22:55:13 -0500
Received: by mail-io1-f69.google.com with SMTP id p4so2858470ioo.4
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2020 19:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rdquNNGKuX/KSxwPrAJ3QB04nJPCe9ZSROBzyqMDPwc=;
        b=Kx9vrJVy1AJ1OIJQFnDKCUf5YXEZbsSVQq1aZq47J2dWo/iT/A1sqrUyKBmxeflDwy
         YZK9wsctVVJ6j7Q8ugcr32hynB/NwqbLvTu5/PitcluvPGEAorbRDIzpXdX5tai7u5DU
         v3ySrvyYeQ+KoIghy1kMBkRI2dk9sv6qc9pIBlkp9tzjUboMvubEKJBd5+drl6igJ6FJ
         8k8PMG5wLL2F1novLN6lylFhnrHY2g9sSajrOf9WjGL7RXsnq5SAkdRmHkJkx9X+R6TP
         QPByu20eRHrexjyaMwdKCNlReJ4k+sM5xndkFw94ZMAqxD1aqYT7Gu41GT/Ofvmqd9gA
         Bxww==
X-Gm-Message-State: ANhLgQ0+Nh3TuFYJcTWUmGtNgJiHYw37oWGMYUqClamjAsXazwi6Z6qo
        Om1Q44n/x7cIg80FYRr0w8X2sp/faGGm2ZWugj780Q6KdhxJ
X-Google-Smtp-Source: ADFU+vsW3AVSlPG3mP5XBZW+aR4i0MoXjs1O7Ptp3iLtdy+gFarE8PH5BOg0Vpcjq7j3Vl19sGkQgVOBbOZ3nUJ+aH27SRfxp12u
MIME-Version: 1.0
X-Received: by 2002:a02:7111:: with SMTP id n17mr5933928jac.129.1583553312294;
 Fri, 06 Mar 2020 19:55:12 -0800 (PST)
Date:   Fri, 06 Mar 2020 19:55:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a98a1705a03bbcbe@google.com>
Subject: general protection fault in __queue_work (2)
From:   syzbot <syzbot+889cc963ed79ee90f74f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    770fbb32 Add linux-next specific files for 20200228
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=104fdfa1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=576314276bce4ad5
dashboard link: https://syzkaller.appspot.com/bug?extid=889cc963ed79ee90f74f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176d7f29e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134c481de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+889cc963ed79ee90f74f@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000030: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000180-0x0000000000000187]
CPU: 0 PID: 9989 Comm: blkid Not tainted 5.6.0-rc3-next-20200228-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__queue_work+0xe8/0x1280 kernel/workqueue.c:1409
Code: c6 00 bf 97 89 4c 89 e7 e8 15 14 48 02 49 8d 86 80 01 00 00 48 89 c2 48 89 44 24 18 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 94 0e 00 00 41 8b 9e 80 01 00
RSP: 0018:ffffc90002457078 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000030 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000040 R08: ffff88809e21a180 R09: fffffbfff190c866
R10: fffffbfff190c865 R11: ffffffff8c86432b R12: ffff8880a677e518
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000040
FS:  00007fe98e0e6740(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000bd7058 CR3: 00000000a3381000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 queue_work_on+0x18b/0x200 kernel/workqueue.c:1515
 queue_work include/linux/workqueue.h:507 [inline]
 loop_queue_work drivers/block/loop.c:984 [inline]
 loop_queue_rq+0x5ac/0x1050 drivers/block/loop.c:2038
 blk_mq_dispatch_rq_list+0x997/0x17f0 block/blk-mq.c:1246
 blk_mq_do_dispatch_sched+0x188/0x3f0 block/blk-mq-sched.c:115
 blk_mq_sched_dispatch_requests+0x3cd/0x650 block/blk-mq-sched.c:211
 __blk_mq_run_hw_queue+0x1b8/0x2c0 block/blk-mq.c:1382
 __blk_mq_delay_run_hw_queue+0x522/0x5e0 block/blk-mq.c:1459
 blk_mq_run_hw_queue+0x16c/0x2f0 block/blk-mq.c:1512
 blk_mq_sched_insert_requests+0x2d4/0x5f0 block/blk-mq-sched.c:444
 blk_mq_flush_plug_list+0x452/0x880 block/blk-mq.c:1758
 blk_flush_plug_list+0x2ff/0x460 block/blk-core.c:1772
 blk_finish_plug block/blk-core.c:1789 [inline]
 blk_finish_plug+0x50/0x97 block/blk-core.c:1785
 read_pages+0x125/0x610 mm/readahead.c:142
 ? 0xffffffff81000000
 __do_page_cache_readahead+0x47c/0x570 mm/readahead.c:212
 force_page_cache_readahead+0x1dc/0x320 mm/readahead.c:243
 page_cache_sync_readahead mm/readahead.c:522 [inline]
 page_cache_sync_readahead+0x4b8/0x520 mm/readahead.c:509
 generic_file_buffered_read mm/filemap.c:2029 [inline]
 generic_file_read_iter+0x1650/0x2a40 mm/filemap.c:2302
 blkdev_read_iter+0x11b/0x180 fs/block_dev.c:2039
 call_read_iter include/linux/fs.h:1895 [inline]
 new_sync_read+0x4a2/0x790 fs/read_write.c:414
 __vfs_read+0xc9/0x100 fs/read_write.c:427
 vfs_read+0x1ea/0x430 fs/read_write.c:461
 ksys_read+0x127/0x250 fs/read_write.c:587
 do_syscall_64+0xf6/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fe98d9ee310
Code: 73 01 c3 48 8b 0d 28 4b 2b 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb ea 90 90 83 3d e5 a2 2b 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 6e 8a 01 00 48 89 04 24
RSP: 002b:00007ffd4d1e1df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe98d9ee310
RDX: 0000000000000400 RSI: 0000000000bd6c58 RDI: 0000000000000003
RBP: 0000000000bd6c30 R08: 0000000000000028 R09: 0000000001680000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000bd6030
R13: 0000000000000400 R14: 0000000000bd6080 R15: 0000000000bd6c48
Modules linked in:
---[ end trace 0e35dd0f272c5c88 ]---
RIP: 0010:__queue_work+0xe8/0x1280 kernel/workqueue.c:1409
Code: c6 00 bf 97 89 4c 89 e7 e8 15 14 48 02 49 8d 86 80 01 00 00 48 89 c2 48 89 44 24 18 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 94 0e 00 00 41 8b 9e 80 01 00
RSP: 0018:ffffc90002457078 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000030 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000040 R08: ffff88809e21a180 R09: fffffbfff190c866
R10: fffffbfff190c865 R11: ffffffff8c86432b R12: ffff8880a677e518
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000040
FS:  00007fe98e0e6740(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000bd7058 CR3: 00000000a3381000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
