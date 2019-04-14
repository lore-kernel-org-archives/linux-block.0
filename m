Return-Path: <SRS0=vbI/=SQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DEFC10F13
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 16:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37062084E
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 16:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDNQsH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:48:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:39000 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfDNQsG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 12:48:06 -0400
Received: by mail-it1-f197.google.com with SMTP id z125so13753003itf.4
        for <linux-block@vger.kernel.org>; Sun, 14 Apr 2019 09:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mSSjFCuhcv8r/pTSYyS6CPzjHpZzHqNcR6G/1+sloD4=;
        b=JKSPRuAfi+UGT895ZPWRUG36XHNF11c0BWfnrOyOPSvSaxiA7VeyzcvoU0gEnFRipc
         lpwzH+dfm21ROdnyV1AHLTDo5Y7MjjL72CDkhamQpiNRLuU3r5soeKB4d8n2mXbBvLNH
         470tJbCe+6CadM5HPadyNbEENxcQa1FPU6cmVB2Gyd2xmgAGz+l5id9poOmeEAaBIU3U
         xq+oejQI7VIUOQd8mEwnlHC/shJzaXAFvWwBT6ocEDC+le6vehGtzL//3odf/6MpcHEa
         CTRK8AoT4zbrhGaifP0j9WCl3ShZ9O96SNgjlcMZo19JLfVlbDph6QQOeGMxX3Vo27zY
         CwmQ==
X-Gm-Message-State: APjAAAVIWDgjF6TA1Y9hWu1q6JhZu65h4i02dy/h/S2/0NrQ2kFzrQed
        nVZdpCEB5K29XY9QzgHmtv5NQZsbESxFvnbNDQX1UJT8qjDK
X-Google-Smtp-Source: APXvYqzLw3qWcBz98OKceFOokavxKmPolyxPUvNqvWnPrcw/soASAU3lDGzxyMatLYA8xrdp5ZWsXxH5VGHJ5IactQ6UQ2KiD/+u
MIME-Version: 1.0
X-Received: by 2002:a24:d603:: with SMTP id o3mr5706347itg.17.1555260486031;
 Sun, 14 Apr 2019 09:48:06 -0700 (PDT)
Date:   Sun, 14 Apr 2019 09:48:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cda1680586804c05@google.com>
Subject: KASAN: use-after-free Read in blkcg_print_stat
From:   syzbot <syzbot+18a2377b010d621c950e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4443f8e6 Merge tag 'for-linus-20190412' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1225b1fd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=18a2377b010d621c950e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+18a2377b010d621c950e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in dev_name include/linux/device.h:1087 [inline]
BUG: KASAN: use-after-free in blkg_dev_name block/blk-cgroup.c:477 [inline]
BUG: KASAN: use-after-free in blkcg_print_stat+0xa27/0xb30  
block/blk-cgroup.c:947
Read of size 8 at addr ffff8880928a3490 by task syz-executor.0/31903

CPU: 1 PID: 31903 Comm: syz-executor.0 Not tainted 5.1.0-rc4+ #69
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  dev_name include/linux/device.h:1087 [inline]
  blkg_dev_name block/blk-cgroup.c:477 [inline]
  blkcg_print_stat+0xa27/0xb30 block/blk-cgroup.c:947
  cgroup_seqfile_show+0x1aa/0x310 kernel/cgroup/cgroup.c:3612
  kernfs_seq_show+0x155/0x1b0 fs/kernfs/file.c:168
  seq_read+0x4db/0x1130 fs/seq_file.c:229
  kernfs_fop_read+0xed/0x560 fs/kernfs/file.c:252
  do_loop_readv_writev fs/read_write.c:701 [inline]
  do_loop_readv_writev fs/read_write.c:688 [inline]
  do_iter_read+0x4a9/0x660 fs/read_write.c:922
  vfs_readv+0xf0/0x160 fs/read_write.c:984
  do_readv+0x15e/0x370 fs/read_write.c:1017
  __do_sys_readv fs/read_write.c:1104 [inline]
  __se_sys_readv fs/read_write.c:1101 [inline]
  __x64_sys_readv+0x75/0xb0 fs/read_write.c:1101
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4b93306c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458c29
RDX: 000000000000017c RSI: 00000000200002c0 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4b933076d4
R13: 00000000004c5985 R14: 00000000004d9fe0 R15: 00000000ffffffff

Allocated by task 7596:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3623
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  device_create_groups_vargs+0x8e/0x270 drivers/base/core.c:2693
  device_create_vargs+0x45/0x60 drivers/base/core.c:2751
  bdi_register_va.part.0+0x38/0x740 mm/backing-dev.c:882
  bdi_register_va mm/backing-dev.c:910 [inline]
  bdi_register+0x12a/0x140 mm/backing-dev.c:907
  bdi_register_owner+0x61/0x110 mm/backing-dev.c:917
  __device_add_disk+0xd72/0x1170 block/genhd.c:717
  device_add_disk+0x2b/0x40 block/genhd.c:741
  add_disk include/linux/genhd.h:422 [inline]
  loop_add+0x635/0x8d0 drivers/block/loop.c:2013
  loop_probe+0x161/0x1a0 drivers/block/loop.c:2085
  kobj_lookup+0x265/0x460 drivers/base/map.c:124
  get_gendisk+0x4d/0x380 block/genhd.c:849
  bdev_get_gendisk fs/block_dev.c:1122 [inline]
  __blkdev_get+0x45a/0x1660 fs/block_dev.c:1508
  blkdev_get+0xc4/0x990 fs/block_dev.c:1667
  blkdev_open+0x205/0x290 fs/block_dev.c:1825
  do_dentry_open+0x4e2/0x1250 fs/open.c:777
  vfs_open+0xa0/0xd0 fs/open.c:886
  do_last fs/namei.c:3416 [inline]
  path_openat+0x10e9/0x46e0 fs/namei.c:3533
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3fe/0x5d0 fs/open.c:1069
  __do_sys_open fs/open.c:1087 [inline]
  __se_sys_open fs/open.c:1082 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1082
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 31901:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3500 [inline]
  kfree+0xcf/0x230 mm/slab.c:3823
  device_create_release+0x16/0x20 drivers/base/cpu.c:409
  device_release+0x7d/0x210 drivers/base/core.c:1064
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put.cold+0x28f/0x2ec lib/kobject.c:708
  put_device drivers/base/core.c:2205 [inline]
  device_unregister+0x28/0x30 drivers/base/core.c:2302
  bdi_unregister+0x41c/0x5e0 mm/backing-dev.c:949
  del_gendisk+0x8a5/0xa90 block/genhd.c:788
  loop_remove+0x3c/0xd0 drivers/block/loop.c:2031
  loop_control_ioctl drivers/block/loop.c:2130 [inline]
  loop_control_ioctl+0x320/0x360 drivers/block/loop.c:2096
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880928a3440
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 80 bytes inside of
  2048-byte region [ffff8880928a3440, ffff8880928a3c40)
The buggy address belongs to the page:
page:ffffea00024a2880 count:1 mapcount:0 mapping:ffff88812c3f0c40  
index:0xffff8880928a2bc0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002611f08 ffffea0002476788 ffff88812c3f0c40
raw: ffff8880928a2bc0 ffff8880928a2340 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880928a3380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8880928a3400: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8880928a3480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8880928a3500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880928a3580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
