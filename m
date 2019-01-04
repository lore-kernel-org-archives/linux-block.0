Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E0BC43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF04D21874
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 16:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfADQhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:37:19 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:39939 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfADQhF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 11:37:05 -0500
Received: by mail-it1-f198.google.com with SMTP id 135so1508489itk.5
        for <linux-block@vger.kernel.org>; Fri, 04 Jan 2019 08:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6CPda2rd/Ei4ocRTxtuDKDu4e5pMW8qjwG6/bGMCGnk=;
        b=rfCSTQ4BcCLuXYb0KJH7YCYYqVj3im5ykcfalYVZOBcL9uj9O5oKW1IQ2RQpSZSADg
         rssqE3fCeoJ9p6k03rYoa54ZloJ/PFTO6/5cxN6ZFsw5djSkn0lP/hRn3yW5X0dd2FIv
         YjOCuYG4j21GYvTY+e2ynG+q0uYdNIPtJywvd6QqSqtaxgH3xwVUi3hwYf1grTRObaNu
         rfDXjNJ+TQ44DwqS1u4GGnkVxBcSxwK6YVkEAxkjolOpKBZR89aSmn/PWgsqgSdX2D41
         dYT5lbzfIbHP9MoXVNgzWcuhvkTqWaxSyXsr37sxwauqnFtQ3wnc0/HTyDzPq8SFatfx
         8ZGQ==
X-Gm-Message-State: AA+aEWbKFcG8XIuWjacr6dqowVfWHag6O4Nw0sT1pkXM/GD6eH0xAPUT
        s2SfFESKZolY74JzBkxBCMJ9rk3mF0sU9K5IJ09dUOYJkdnU
X-Google-Smtp-Source: AFSGD/W172ZC12HkzPJI8Avl0pLhTftGmCSRqKui8bUdfLr7TLXywscu15Dq1TYdY8UQZPnRcJP96Mg4kleH5TxYpwG9TLFQ/U4K
MIME-Version: 1.0
X-Received: by 2002:a02:c90a:: with SMTP id t10mr40863479jao.19.1546619824110;
 Fri, 04 Jan 2019 08:37:04 -0800 (PST)
Date:   Fri, 04 Jan 2019 08:37:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003804ff057ea47d37@google.com>
Subject: KASAN: use-after-free Read in disk_map_sector_rcu
From:   syzbot <syzbot+e01322aeded15e015bbd@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    645ff1e8e704 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bb39ab400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
dashboard link: https://syzkaller.appspot.com/bug?extid=e01322aeded15e015bbd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e01322aeded15e015bbd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in sector_in_part block/genhd.c:260 [inline]
BUG: KASAN: use-after-free in disk_map_sector_rcu+0x6a6/0x6d0  
block/genhd.c:288
Read of size 8 at addr ffff88808b32d640 by task blkid/2241

CPU: 0 PID: 2241 Comm: blkid Not tainted 4.20.0+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  sector_in_part block/genhd.c:260 [inline]
  disk_map_sector_rcu+0x6a6/0x6d0 block/genhd.c:288
  blk_account_io_start+0x54a/0x1000 block/blk-core.c:1360
  blk_mq_bio_to_request block/blk-mq.c:1749 [inline]
  blk_mq_make_request+0x7ac/0x1e10 block/blk-mq.c:1962
  generic_make_request+0x902/0x17f0 block/blk-core.c:1087
  submit_bio+0xba/0x480 block/blk-core.c:1195
  mpage_bio_submit fs/mpage.c:66 [inline]
  mpage_readpages+0x694/0x920 fs/mpage.c:410
  blkdev_readpages+0x2d/0x40 fs/block_dev.c:601
  read_pages+0x119/0x650 mm/readahead.c:123
  __do_page_cache_readahead+0x5ce/0x800 mm/readahead.c:209
  force_page_cache_readahead+0x1e9/0x360 mm/readahead.c:240
  page_cache_sync_readahead mm/readahead.c:519 [inline]
  page_cache_sync_readahead+0x62a/0x6b0 mm/readahead.c:506
  generic_file_buffered_read mm/filemap.c:2080 [inline]
  generic_file_read_iter+0x1a81/0x2d40 mm/filemap.c:2350
  blkdev_read_iter+0x120/0x190 fs/block_dev.c:1959
  call_read_iter include/linux/fs.h:1856 [inline]
  new_sync_read fs/read_write.c:406 [inline]
  __vfs_read+0x761/0xb20 fs/read_write.c:418
  vfs_read+0x194/0x3e0 fs/read_write.c:452
  ksys_read+0x105/0x260 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fd3fcbe0310
Code: 73 01 c3 48 8b 0d 28 4b 2b 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb  
ea 90 90 83 3d e5 a2 2b 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 6e 8a 01 00 48 89 04 24
RSP: 002b:00007ffcead735c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd3fcbe0310
RDX: 0000000000000400 RSI: 0000000001aedc58 RDI: 0000000000000003
RBP: 0000000001aedc30 R08: 0000000000000028 R09: 0000000001680000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001aed030
R13: 0000000000000400 R14: 0000000001aed080 R15: 0000000001aedc48

Allocated by task 2136:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc mm/kasan/common.c:482 [inline]
  kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3607
  kmalloc include/linux/slab.h:545 [inline]
  kzalloc include/linux/slab.h:740 [inline]
  add_partition+0x1e9/0xf50 block/partition-generic.c:322
  rescan_partitions+0x5c5/0x970 block/partition-generic.c:618
  __blkdev_reread_part+0x1a2/0x230 block/ioctl.c:173
  blkdev_reread_part+0x27/0x40 block/ioctl.c:193
  loop_reread_partitions+0x1c/0x40 drivers/block/loop.c:633
  loop_set_status+0xcf7/0x1100 drivers/block/loop.c:1268
  loop_set_status64+0xc2/0x120 drivers/block/loop.c:1388
  lo_ioctl+0x518/0x2190 drivers/block/loop.c:1514
  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
  blkdev_ioctl+0x10e0/0x2120 block/ioctl.c:605
  block_ioctl+0xee/0x130 fs/block_dev.c:1906
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8281:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  part_release+0xaa/0xd0 block/partition-generic.c:228
  device_release+0x7d/0x210 drivers/base/core.c:919
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put.cold+0x28f/0x2ec lib/kobject.c:708
  put_device+0x20/0x30 drivers/base/core.c:2060
  delete_partition_work_fn+0x14a/0x1b0 block/partition-generic.c:256
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88808b32d640
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 0 bytes inside of
  2048-byte region [ffff88808b32d640, ffff88808b32de40)
The buggy address belongs to the page:
page:ffffea00022ccb00 count:1 mapcount:0 mapping:ffff88812c3f0c40 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002153f88 ffffea00011d8588 ffff88812c3f0c40
raw: 0000000000000000 ffff88808b32c540 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808b32d500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808b32d580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff88808b32d600: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                            ^
  ffff88808b32d680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808b32d700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
