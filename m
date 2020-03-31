Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0A0C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 17:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F0C20848
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 17:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgCaRLR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:11:17 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:40143 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgCaRLR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 13:11:17 -0400
Received: by mail-io1-f72.google.com with SMTP id z207so19841259iof.7
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 10:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GeqKjfeAdJEJGZUK1GjRw+TiUXvLDp+2kKiRMtW1LCk=;
        b=tMW69W5VCNDOzt/WX1WXQyPnHCYUXULfoBaD6uX2uQF+MB9hdYP9qUMENKkyYFRbA+
         JyPv0+Gxe0wcXKvTR9vIcgYQosDCB0wtBRdeD5f0NDoD3MuTyJrvS9WJtmBc3+J15msh
         74hhTT3mpKtg48jFjTeFZFxzg2r2TboGaOC8yvAlOSMRpQxFar5nJivKBQl7AEi+cEVU
         w1jduwjyDjNLhfpk9LCzfzuPRVJbyVMuTkNPEoCcrE52s5COfTCFPqtSncbMp4Rsmxbw
         Yv4XYTTJKpjgDYYXqSqBY3rTDxpAQh84fRm/dqMZwZqMed6H9yF2LYIcPhY4PTir7mao
         TynA==
X-Gm-Message-State: ANhLgQ2bgzyWDS64h4iz+5/fRDURTyJ/NFBoZ037AlS33RJ2PRwaQZjK
        Kk/RmG4Oi2GbgiKuue6sEOmXlOMwS4nW9z27OOcOL1wHYmDM
X-Google-Smtp-Source: ADFU+vt+Tkk/vonhfkivzolcbjP+ktb+edSvNeC5MpAAEcl8QjOIsuGNwdwt5tE0tU8UThY0NBr6tIuoUZHzvQQy8JX8ZuxIgRsR
MIME-Version: 1.0
X-Received: by 2002:a02:c551:: with SMTP id g17mr7773176jaj.52.1585674675789;
 Tue, 31 Mar 2020 10:11:15 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:11:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7a80905a229a785@google.com>
Subject: memory leak in nbd_add_socket
From:   syzbot <syzbot+934037347002901b8d2a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    673b41e0 staging/octeon: fix up merge error
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15badadbe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d97026d04c648459
dashboard link: https://syzkaller.appspot.com/bug?extid=934037347002901b8d2a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dbb747e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14421b9de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+934037347002901b8d2a@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810fd584a0 (size 32):
  comm "syz-executor586", pid 8424, jiffies 4294961663 (age 40.060s)
  hex dump (first 32 bytes):
    2f 64 65 76 2f 6e 62 64 30 00 00 00 00 00 00 00  /dev/nbd0.......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000090cb73c8>] __do_krealloc mm/slab_common.c:1671 [inline]
    [<0000000090cb73c8>] krealloc+0x7c/0xa0 mm/slab_common.c:1700
    [<00000000cf9e6ba7>] nbd_add_socket+0x7d/0x1e0 drivers/block/nbd.c:1040
    [<0000000040a0a881>] __nbd_ioctl drivers/block/nbd.c:1373 [inline]
    [<0000000040a0a881>] nbd_ioctl+0x175/0x430 drivers/block/nbd.c:1437
    [<000000004972a55a>] __blkdev_driver_ioctl block/ioctl.c:322 [inline]
    [<000000004972a55a>] blkdev_ioctl+0x147/0x300 block/ioctl.c:718
    [<000000008903d911>] block_ioctl+0x50/0x70 fs/block_dev.c:1995
    [<00000000c37950d9>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<00000000c37950d9>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:763
    [<00000000ffe4bbdc>] __do_sys_ioctl fs/ioctl.c:772 [inline]
    [<00000000ffe4bbdc>] __se_sys_ioctl fs/ioctl.c:770 [inline]
    [<00000000ffe4bbdc>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:770
    [<00000000ede38b98>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:294
    [<00000000553f73d5>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fd584a0 (size 32):
  comm "syz-executor586", pid 8424, jiffies 4294961663 (age 40.170s)
  hex dump (first 32 bytes):
    2f 64 65 76 2f 6e 62 64 30 00 00 00 00 00 00 00  /dev/nbd0.......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000090cb73c8>] __do_krealloc mm/slab_common.c:1671 [inline]
    [<0000000090cb73c8>] krealloc+0x7c/0xa0 mm/slab_common.c:1700
    [<00000000cf9e6ba7>] nbd_add_socket+0x7d/0x1e0 drivers/block/nbd.c:1040
    [<0000000040a0a881>] __nbd_ioctl drivers/block/nbd.c:1373 [inline]
    [<0000000040a0a881>] nbd_ioctl+0x175/0x430 drivers/block/nbd.c:1437
    [<000000004972a55a>] __blkdev_driver_ioctl block/ioctl.c:322 [inline]
    [<000000004972a55a>] blkdev_ioctl+0x147/0x300 block/ioctl.c:718
    [<000000008903d911>] block_ioctl+0x50/0x70 fs/block_dev.c:1995
    [<00000000c37950d9>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<00000000c37950d9>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:763
    [<00000000ffe4bbdc>] __do_sys_ioctl fs/ioctl.c:772 [inline]
    [<00000000ffe4bbdc>] __se_sys_ioctl fs/ioctl.c:770 [inline]
    [<00000000ffe4bbdc>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:770
    [<00000000ede38b98>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:294
    [<00000000553f73d5>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fd584a0 (size 32):
  comm "syz-executor586", pid 8424, jiffies 4294961663 (age 40.270s)
  hex dump (first 32 bytes):
    2f 64 65 76 2f 6e 62 64 30 00 00 00 00 00 00 00  /dev/nbd0.......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000090cb73c8>] __do_krealloc mm/slab_common.c:1671 [inline]
    [<0000000090cb73c8>] krealloc+0x7c/0xa0 mm/slab_common.c:1700
    [<00000000cf9e6ba7>] nbd_add_socket+0x7d/0x1e0 drivers/block/nbd.c:1040
    [<0000000040a0a881>] __nbd_ioctl drivers/block/nbd.c:1373 [inline]
    [<0000000040a0a881>] nbd_ioctl+0x175/0x430 drivers/block/nbd.c:1437
    [<000000004972a55a>] __blkdev_driver_ioctl block/ioctl.c:322 [inline]
    [<000000004972a55a>] blkdev_ioctl+0x147/0x300 block/ioctl.c:718
    [<000000008903d911>] block_ioctl+0x50/0x70 fs/block_dev.c:1995
    [<00000000c37950d9>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<00000000c37950d9>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:763
    [<00000000ffe4bbdc>] __do_sys_ioctl fs/ioctl.c:772 [inline]
    [<00000000ffe4bbdc>] __se_sys_ioctl fs/ioctl.c:770 [inline]
    [<00000000ffe4bbdc>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:770
    [<00000000ede38b98>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:294
    [<00000000553f73d5>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fd584a0 (size 32):
  comm "syz-executor586", pid 8424, jiffies 4294961663 (age 40.380s)
  hex dump (first 32 bytes):
    2f 64 65 76 2f 6e 62 64 30 00 00 00 00 00 00 00  /dev/nbd0.......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000090cb73c8>] __do_krealloc mm/slab_common.c:1671 [inline]
    [<0000000090cb73c8>] krealloc+0x7c/0xa0 mm/slab_common.c:1700
    [<00000000cf9e6ba7>] nbd_add_socket+0x7d/0x1e0 drivers/block/nbd.c:1040
    [<0000000040a0a881>] __nbd_ioctl drivers/block/nbd.c:1373 [inline]
    [<0000000040a0a881>] nbd_ioctl+0x175/0x430 drivers/block/nbd.c:1437
    [<000000004972a55a>] __blkdev_driver_ioctl block/ioctl.c:322 [inline]
    [<000000004972a55a>] blkdev_ioctl+0x147/0x300 block/ioctl.c:718
    [<000000008903d911>] block_ioctl+0x50/0x70 fs/block_dev.c:1995
    [<00000000c37950d9>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<00000000c37950d9>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:763
    [<00000000ffe4bbdc>] __do_sys_ioctl fs/ioctl.c:772 [inline]
    [<00000000ffe4bbdc>] __se_sys_ioctl fs/ioctl.c:770 [inline]
    [<00000000ffe4bbdc>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:770
    [<00000000ede38b98>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:294
    [<00000000553f73d5>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fd584a0 (size 32):
  comm "syz-executor586", pid 8424, jiffies 4294961663 (age 40.480s)
  hex dump (first 32 bytes):
    2f 64 65 76 2f 6e 62 64 30 00 00 00 00 00 00 00  /dev/nbd0.......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000090cb73c8>] __do_krealloc mm/slab_common.c:1671 [inline]
    [<0000000090cb73c8>] krealloc+0x7c/0xa0 mm/slab_common.c:1700
    [<00000000cf9e6ba7>] nbd_add_socket+0x7d/0x1e0 drivers/block/nbd.c:1040
    [<0000000040a0a881>] __nbd_ioctl drivers/block/nbd.c:1373 [inline]
    [<0000000040a0a881>] nbd_ioctl+0x175/0x430 drivers/block/nbd.c:1437
    [<000000004972a55a>] __blkdev_driver_ioctl block/ioctl.c:322 [inline]
    [<000000004972a55a>] blkdev_ioctl+0x147/0x300 block/ioctl.c:718
    [<000000008903d911>] block_ioctl+0x50/0x70 fs/block_dev.c:1995
    [<00000000c37950d9>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<00000000c37950d9>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:763
    [<00000000ffe4bbdc>] __do_sys_ioctl fs/ioctl.c:772 [inline]
    [<00000000ffe4bbdc>] __se_sys_ioctl fs/ioctl.c:770 [inline]
    [<00000000ffe4bbdc>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:770
    [<00000000ede38b98>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:294
    [<00000000553f73d5>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fd584a0 (size 32):
  comm "syz-executor586", pid 8424, jiffies 4294961663 (age 40.590s)
  hex dump (first 32 bytes):
    2f 64 65 76 2f 6e 62 64 30 00 00 00 00 00 00 00  /dev/nbd0.......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000090cb73c8>] __do_krealloc mm/slab_common.c:1671 [inline]
    [<0000000090cb73c8>] krealloc+0x7c/0xa0 mm/slab_common.c:1700
    [<00000000cf9e6ba7>] nbd_add_socket+0x7d/0x1e0 drivers/block/nbd.c:1040
    [<0000000040a0a881>] __nbd_ioctl drivers/block/nbd.c:1373 [inline]
    [<0000000040a0a881>] nbd_ioctl+0x175/0x430 drivers/block/nbd.c:1437
    [<000000004972a55a>] __blkdev_driver_ioctl block/ioctl.c:322 [inline]
    [<000000004972a55a>] blkdev_ioctl+0x147/0x300 block/ioctl.c:718
    [<000000008903d911>] block_ioctl+0x50/0x70 fs/block_dev.c:1995
    [<00000000c37950d9>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<00000000c37950d9>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:763
    [<00000000ffe4bbdc>] __do_sys_ioctl fs/ioctl.c:772 [inline]
    [<00000000ffe4bbdc>] __se_sys_ioctl fs/ioctl.c:770 [inline]
    [<00000000ffe4bbdc>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:770
    [<00000000ede38b98>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:294
    [<00000000553f73d5>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fd584a0 (size 32):
  comm "syz-executor586", pid 8424, jiffies 4294961663 (age 40.690s)
  hex dump (first 32 bytes):
    2f 64 65 76 2f 6e 62 64 30 00 00 00 00 00 00 00  /dev/nbd0.......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000090cb73c8>] __do_krealloc mm/slab_common.c:1671 [inline]
    [<0000000090cb73c8>] krealloc+0x7c/0xa0 mm/slab_common.c:1700
    [<00000000cf9e6ba7>] nbd_add_socket+0x7d/0x1e0 drivers/block/nbd.c:1040
    [<0000000040a0a881>] __nbd_ioctl drivers/block/nbd.c:1373 [inline]
    [<0000000040a0a881>] nbd_ioctl+0x175/0x430 drivers/block/nbd.c:1437
    [<000000004972a55a>] __blkdev_driver_ioctl block/ioctl.c:322 [inline]
    [<000000004972a55a>] blkdev_ioctl+0x147/0x300 block/ioctl.c:718
    [<000000008903d911>] block_ioctl+0x50/0x70 fs/block_dev.c:1995
    [<00000000c37950d9>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<00000000c37950d9>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:763
    [<00000000ffe4bbdc>] __do_sys_ioctl fs/ioctl.c:772 [inline]
    [<00000000ffe4bbdc>] __se_sys_ioctl fs/ioctl.c:770 [inline]
    [<00000000ffe4bbdc>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:770
    [<00000000ede38b98>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:294
    [<00000000553f73d5>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fd584a0 (size 32):
  comm "syz-executor586", pid 8424, jiffies 4294961663 (age 40.800s)
  hex dump (first 32 bytes):
    2f 64 65 76 2f 6e 62 64 30 00 00 00 00 00 00 00  /dev/nbd0.......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000090cb73c8>] __do_krealloc mm/slab_common.c:1671 [inline]
    [<0000000090cb73c8>] krealloc+0x7c/0xa0 mm/slab_common.c:1700
    [<00000000cf9e6ba7>] nbd_add_socket+0x7d/0x1e0 drivers/block/nbd.c:1040
    [<0000000040a0a881>] __nbd_ioctl drivers/block/nbd.c:1373 [inline]
    [<0000000040a0a881>] nbd_ioctl+0x175/0x430 drivers/block/nbd.c:1437
    [<000000004972a55a>] __blkdev_driver_ioctl block/ioctl.c:322 [inline]
    [<000000004972a55a>] blkdev_ioctl+0x147/0x300 block/ioctl.c:718
    [<000000008903d911>] block_ioctl+0x50/0x70 fs/block_dev.c:1995
    [<00000000c37950d9>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<00000000c37950d9>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:763
    [<00000000ffe4bbdc>] __do_sys_ioctl fs/ioctl.c:772 [inline]
    [<00000000ffe4bbdc>] __se_sys_ioctl fs/ioctl.c:770 [inline]
    [<00000000ffe4bbdc>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:770
    [<00000000ede38b98>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:294
    [<00000000553f73d5>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
