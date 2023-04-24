Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F2C7618E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 07:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjDXHVM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 03:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjDXHVH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 03:21:07 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581F335AF
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 00:20:47 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-32afe238257so29550085ab.3
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320846; x=1684912846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=641X8TIeBPrHbjUBnznHK1cRl0WGKLF1lPeAjBl/3gE=;
        b=Ec5xgKd/nHy59RDwUIWwIzNWtxrg6S2k7hvbAK2etYg1S08ZPcU6Jhuhox4ZbY9D9n
         PA/LIEvb1CqF66skDI0fCmVLXnX386s0PydtPxO6IfZxaLVM74XGoZK25/s+7MteQch+
         0phbEuis/nrrnm2KW83o2SByB25RcLYHxX5QxAgvmer6yfXlPi1nB8pFmafnXURdL1iw
         t+1yu8U/4HB9SCtuKKKY/vgCl0UW+8lWTGpyGYNzjHG68m9kGIHgWAx3wKVyp+12wtMI
         nUwR/bTx5mTQIj7LFYBeQpFEXfqL7fm9E/Bp4z0PFo8ZKai9GWDzUJAZAtP6UWledI7x
         /8nQ==
X-Gm-Message-State: AAQBX9ebK+ady2jV/O51tuAoQBQ2eu+/Y34pRz/sA0it38/jaFJyx7nh
        D+v7FHaGNoesg0N1P/Olhq3b3zVXDv/Q7W+XzHfoe0XMjWej
X-Google-Smtp-Source: AKy350ZEnx3Zx4Cj+mbDrjnj+JoW8mp9J0S7zQYAYKCC1TsC1EbxfeOlUwMXe29q77jAGUzC6IVnZ2n7ccHXt97HFizlWxzfX+rR
MIME-Version: 1.0
X-Received: by 2002:a02:95c2:0:b0:40f:8b6d:c549 with SMTP id
 b60-20020a0295c2000000b0040f8b6dc549mr4114436jai.2.1682320846514; Mon, 24 Apr
 2023 00:20:46 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:20:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007470fe05fa0fd8ba@google.com>
Subject: [syzbot] [block?] KCSAN: data-race in __filemap_add_folio /
 invalidate_bdev (3)
From:   syzbot <syzbot+8a416e3cb063d4787b0f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3e7bb4f24617 Merge tag '6.3-rc6-smb311-client-negcontext-f..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c2e6ebc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=710057cbb8def08c
dashboard link: https://syzkaller.appspot.com/bug?extid=8a416e3cb063d4787b0f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d1f21f86a5e7/disk-3e7bb4f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5769a034d50c/vmlinux-3e7bb4f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/82288ce4b761/bzImage-3e7bb4f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a416e3cb063d4787b0f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __filemap_add_folio / invalidate_bdev

read-write to 0xffff8881023fec48 of 8 bytes by task 5672 on cpu 1:
 __filemap_add_folio+0x38c/0x720 mm/filemap.c:904
 filemap_add_folio+0x6f/0x150 mm/filemap.c:939
 filemap_create_folio mm/filemap.c:2545 [inline]
 filemap_get_pages+0x5d2/0xea0 mm/filemap.c:2605
 filemap_read+0x223/0x680 mm/filemap.c:2693
 blkdev_read_iter+0x2ca/0x370 block/fops.c:606
 call_read_iter include/linux/fs.h:1845 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x39a/0x560 fs/read_write.c:470
 ksys_read+0xeb/0x1a0 fs/read_write.c:613
 __do_sys_read fs/read_write.c:623 [inline]
 __se_sys_read fs/read_write.c:621 [inline]
 __x64_sys_read+0x42/0x50 fs/read_write.c:621
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff8881023fec48 of 8 bytes by task 3141 on cpu 0:
 invalidate_bdev+0x35/0x80 block/bdev.c:84
 bdev_disk_changed+0x102/0xbb0 block/partitions/core.c:668
 __loop_clr_fd+0x2b9/0x3b0 drivers/block/loop.c:1189
 loop_clr_fd drivers/block/loop.c:1257 [inline]
 lo_ioctl+0xe9e/0x12f0 drivers/block/loop.c:1563
 blkdev_ioctl+0x3a0/0x490 block/ioctl.c:615
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xc9/0x140 fs/ioctl.c:856
 __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x0000000000000000 -> 0x0000000000000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 3141 Comm: syz-executor.2 Not tainted 6.3.0-rc6-syzkaller-00188-g3e7bb4f24617 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
