Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97D6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 19:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346743AbiEKTVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 May 2022 15:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346761AbiEKTVe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 May 2022 15:21:34 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2765D5DF
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 12:21:33 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ay38-20020a5d9da6000000b0065adc1f932bso1705981iob.11
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 12:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ot1OWyPBUaYmsL/rpRXMCMJU20uzrbWIkZX+H6+xufs=;
        b=bUSUYJ/LI9tyDPMmpk8ZpeivCyMCaPmC35e+WUH6At+PGQ1kUGvBAGyNOdhJsAf3EA
         tLIDCpiwUdsB3CPufcCK7AOxcfKI0W9QXJgJ1SOgFoS+qKesxK+1MtOg7lRs2uUx5j+1
         uQ9pac3gcekDxXp1aDr911Ea5HQa8rODP5n7Jxmxq6Wz7c63IRLdu17a6PR3kYOU5q6j
         FOiDbZk61OoUeihmCQiiOSCHjqZOjLs4qqn5EGhnZ7oi23Cm1wTkaMLe/7miRmIaIVPX
         AJ+ETzWPIam6kYMJKE5krOlQc0LJMiC1gfu9aIcN6O7Y+QMZfMDN0OVFd/cTbQ1/KbOC
         /peg==
X-Gm-Message-State: AOAM533Oyg/EgLulEjBbznJwwR50CJn9Yfi/hlXpRqlo9dV21VHFxnKk
        uF2SQPpkTt8Eh7yX7PdeCN4zr4wbK3KstXPkRW1E/U1x+Awi
X-Google-Smtp-Source: ABdhPJyvOsk/u2xVrvdbkaOMguoZ2YYFEphNw6wj66dFQA7gnt8Ylv8Ln1GUDoRgRJ+1nTHEacRmiGq5+0TafVTg7ibH/nyElN6P
MIME-Version: 1.0
X-Received: by 2002:a05:6638:cd3:b0:32a:eec5:bbca with SMTP id
 e19-20020a0566380cd300b0032aeec5bbcamr13461113jak.99.1652296892381; Wed, 11
 May 2022 12:21:32 -0700 (PDT)
Date:   Wed, 11 May 2022 12:21:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000557fe905dec159a6@google.com>
Subject: [syzbot] memory leak in blk_ioprio_init
From:   syzbot <syzbot+5d564137a4c4677abcf1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    feb9c5e19e91 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104f2666f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f33cdac6164584bd
dashboard link: https://syzkaller.appspot.com/bug?extid=5d564137a4c4677abcf1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12071811f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ffd166f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d564137a4c4677abcf1@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810a36cc80 (size 64):
  comm "syz-executor844", pid 3616, jiffies 4294958438 (age 12.560s)
  hex dump (first 32 bytes):
    80 99 ca 85 ff ff ff ff 40 16 93 04 81 88 ff ff  ........@.......
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82338d25>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff82338d25>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff82338d25>] blk_ioprio_init+0x25/0xf0 block/blk-ioprio.c:233
    [<ffffffff8233169d>] blkcg_init_queue+0xcd/0x1f0 block/blk-cgroup.c:1216
    [<ffffffff82317c6e>] __alloc_disk_node+0x11e/0x230 block/genhd.c:1381
    [<ffffffff82317db5>] __blk_alloc_disk+0x35/0x70 block/genhd.c:1421
    [<ffffffff832f7574>] md_alloc+0x5d4/0x830 drivers/md/md.c:5697
    [<ffffffff832f7839>] md_probe+0x69/0x70 drivers/md/md.c:5746
    [<ffffffff8231858a>] blk_request_module+0x8a/0x110 block/genhd.c:716
    [<ffffffff822e79f7>] blkdev_get_no_open+0x77/0xc0 block/bdev.c:737
    [<ffffffff822e7a63>] blkdev_get_by_dev.part.0+0x23/0x520 block/bdev.c:794
    [<ffffffff822e7fcb>] blkdev_get_by_dev+0x6b/0x80 block/bdev.c:850
    [<ffffffff822e9337>] blkdev_open+0xb7/0x130 block/fops.c:498
    [<ffffffff815b4be6>] do_dentry_open+0x1e6/0x650 fs/open.c:824
    [<ffffffff815db0a1>] do_open fs/namei.c:3476 [inline]
    [<ffffffff815db0a1>] path_openat+0x18a1/0x1e70 fs/namei.c:3609
    [<ffffffff815ddd71>] do_filp_open+0xc1/0x1b0 fs/namei.c:3636
    [<ffffffff815b83bd>] do_sys_openat2+0xed/0x260 fs/open.c:1213
    [<ffffffff815b8e0f>] do_sys_open fs/open.c:1229 [inline]
    [<ffffffff815b8e0f>] __do_sys_openat fs/open.c:1245 [inline]
    [<ffffffff815b8e0f>] __se_sys_openat fs/open.c:1240 [inline]
    [<ffffffff815b8e0f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1240

BUG: memory leak
unreferenced object 0xffff88810f6c7780 (size 96):
  comm "syz-executor844", pid 3616, jiffies 4294958438 (age 12.560s)
  hex dump (first 32 bytes):
    c0 9f ca 85 ff ff ff ff 40 16 93 04 81 88 ff ff  ........@.......
    01 00 00 00 00 00 00 00 80 cc 36 0a 81 88 ff ff  ..........6.....
  backtrace:
    [<ffffffff8233b228>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff8233b228>] kzalloc include/linux/slab.h:714 [inline]
    [<ffffffff8233b228>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:725
    [<ffffffff823316f5>] blkcg_init_queue+0x125/0x1f0 block/blk-cgroup.c:1224
    [<ffffffff82317c6e>] __alloc_disk_node+0x11e/0x230 block/genhd.c:1381
    [<ffffffff82317db5>] __blk_alloc_disk+0x35/0x70 block/genhd.c:1421
    [<ffffffff832f7574>] md_alloc+0x5d4/0x830 drivers/md/md.c:5697
    [<ffffffff832f7839>] md_probe+0x69/0x70 drivers/md/md.c:5746
    [<ffffffff8231858a>] blk_request_module+0x8a/0x110 block/genhd.c:716
    [<ffffffff822e79f7>] blkdev_get_no_open+0x77/0xc0 block/bdev.c:737
    [<ffffffff822e7a63>] blkdev_get_by_dev.part.0+0x23/0x520 block/bdev.c:794
    [<ffffffff822e7fcb>] blkdev_get_by_dev+0x6b/0x80 block/bdev.c:850
    [<ffffffff822e9337>] blkdev_open+0xb7/0x130 block/fops.c:498
    [<ffffffff815b4be6>] do_dentry_open+0x1e6/0x650 fs/open.c:824
    [<ffffffff815db0a1>] do_open fs/namei.c:3476 [inline]
    [<ffffffff815db0a1>] path_openat+0x18a1/0x1e70 fs/namei.c:3609
    [<ffffffff815ddd71>] do_filp_open+0xc1/0x1b0 fs/namei.c:3636
    [<ffffffff815b83bd>] do_sys_openat2+0xed/0x260 fs/open.c:1213
    [<ffffffff815b8e0f>] do_sys_open fs/open.c:1229 [inline]
    [<ffffffff815b8e0f>] __do_sys_openat fs/open.c:1245 [inline]
    [<ffffffff815b8e0f>] __se_sys_openat fs/open.c:1240 [inline]
    [<ffffffff815b8e0f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1240



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
