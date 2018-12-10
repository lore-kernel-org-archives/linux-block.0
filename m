Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83925C04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 07:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487232081F
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 07:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487232081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeLJHtF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:49:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:56541 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLJHtE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 02:49:04 -0500
Received: by mail-it1-f200.google.com with SMTP id x3so12886856itb.6
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 23:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fskeLgDIlTWoRRDITccqr/L2+yuEhPN362olBBjX+KM=;
        b=EpUJkzmht3rxeAfcTBWejksBUiZFuE4Sd8r2HRx9h2AlR+ZygkK1Xc5R2cOGci7dQY
         AZ8Du2SPdvV9B8CLDIjrcGmaUmyRb9ay5FOg1LHsld+V5QDTHPK1phaaHvIfP+y5CAs8
         IhHGvPMrE4QznzjknBnClQq+mt5B3cdafQT+uq6Ws1A7lXnhqQ6/Q2Nr3LV3gfUgAkoi
         ukfo8ZOIvMbMA7HtKCaDQCHhlbJhUXJIUFaXKT208lo9Prqj/CxKod8LvwA4W3UkKMjM
         X0XwH8+y1ItRatJExe1vGgxOUZcK3cIwevYCceC6h5gMC0k/2ONALdTnffHuPfDSbTRP
         aKeA==
X-Gm-Message-State: AA+aEWaLu/Vs8PYdfTsi5SWupKdnB6G7IJi/tdT8ikMTngFr2M5txBYz
        S0yKQw+CBYKeAyRWFNptsclfCzLXMDvChOr5HgETENEPCtIA
X-Google-Smtp-Source: AFSGD/WxQ9vIH4JqYOTS2Ugv1CsNBjK4E5rI6kKzdZQwP5lS+AAeKdWCyeozSbmijpgpoexr2DEbkzz4ioBnyxO57aM5Yh5X4W4i
MIME-Version: 1.0
X-Received: by 2002:a02:4596:: with SMTP id o22mr9575456jad.12.1544428143007;
 Sun, 09 Dec 2018 23:49:03 -0800 (PST)
Date:   Sun, 09 Dec 2018 23:49:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d86774057ca63295@google.com>
Subject: KASAN: use-after-free Read in get_disk_and_module
From:   syzbot <syzbot+b00e02299cdecb22b288@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    74c4a24df7ca Add linux-next specific files for 20181207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=171e9125400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e9413388bf37bed
dashboard link: https://syzkaller.appspot.com/bug?extid=b00e02299cdecb22b288
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b00e02299cdecb22b288@syzkaller.appspotmail.com

QAT: Invalid ioctl
QAT: Invalid ioctl
QAT: Invalid ioctl
__loop_clr_fd: partition scan of loop3 failed (rc=-22)
==================================================================
BUG: KASAN: use-after-free in get_disk_and_module+0xd5/0xf0  
block/genhd.c:1493
Read of size 8 at addr ffff8881b4f24f58 by task blkid/21934

CPU: 0 PID: 21934 Comm: blkid Not tainted 4.20.0-rc5-next-20181207+ #163
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.4+0x9/0x1ff mm/kasan/report.c:187
  kasan_report.cold.5+0x1b/0x39 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  get_disk_and_module+0xd5/0xf0 block/genhd.c:1493
  get_gendisk+0x17a/0x380 block/genhd.c:855
  bdev_get_gendisk fs/block_dev.c:1092 [inline]
  __blkdev_get+0x467/0x13b0 fs/block_dev.c:1487
  blkdev_get+0xc1/0xb50 fs/block_dev.c:1643
  blkdev_open+0x1fb/0x280 fs/block_dev.c:1801
  do_dentry_open+0x499/0x1250 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3418 [inline]
  path_openat+0x12bc/0x5150 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x780 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fe787296120
Code: 48 8b 15 1b 4d 2b 00 f7 d8 64 89 02 83 c8 ff c3 90 90 90 90 90 90 90  
90 90 90 83 3d d5 a4 2b 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 5e 8c 01 00 48 89 04 24
RSP: 002b:00007fffed985768 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe787296120
RDX: 00007fffed987f1f RSI: 0000000000000000 RDI: 00007fffed987f1f
RBP: 0000000000000000 R08: 0000000000000078 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000939030
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000005

Allocated by task 21892:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc+0xcb/0xd0 mm/kasan/common.c:482
  kmem_cache_alloc_node_trace+0x14f/0x740 mm/slab.c:3650
  kmalloc_node include/linux/slab.h:583 [inline]
  kzalloc_node include/linux/slab.h:751 [inline]
  __alloc_disk_node+0xc9/0x510 block/genhd.c:1446
  loop_add+0x453/0xa20 drivers/block/loop.c:1935
  loop_probe+0x18d/0x1d0 drivers/block/loop.c:2041
  kobj_lookup+0x264/0x460 drivers/base/map.c:124
  get_gendisk+0x4c/0x380 block/genhd.c:847
  bdev_get_gendisk fs/block_dev.c:1092 [inline]
  __blkdev_get+0x467/0x13b0 fs/block_dev.c:1487
  blkdev_get+0xc1/0xb50 fs/block_dev.c:1643
  blkdev_open+0x1fb/0x280 fs/block_dev.c:1801
  do_dentry_open+0x499/0x1250 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3418 [inline]
  path_openat+0x12bc/0x5150 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x780 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 21924:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  disk_release+0x1f2/0x250 block/genhd.c:1304
  device_release+0x7e/0x210 drivers/base/core.c:919
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:70 [inline]
  kobject_put.cold.9+0x287/0x2e4 lib/kobject.c:708
  put_disk+0x23/0x30 block/genhd.c:1511
  loop_remove+0x92/0xc0 drivers/block/loop.c:1990
  loop_control_ioctl+0x3f2/0x480 drivers/block/loop.c:2086
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881b4f249c0
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1432 bytes inside of
  2048-byte region [ffff8881b4f249c0, ffff8881b4f251c0)
The buggy address belongs to the page:
page:ffffea0006d3c900 count:1 mapcount:0 mapping:ffff8881da800c40  
index:0xffff8881b4f25240 compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea000707b388 ffffea00075d4688 ffff8881da800c40
raw: ffff8881b4f25240 ffff8881b4f24140 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881b4f24e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b4f24e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881b4f24f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                     ^
  ffff8881b4f24f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b4f25000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
