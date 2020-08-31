Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8DAC433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 10:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716D52072D
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 10:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgHaK21 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:28:27 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:39237 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaK2X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 06:28:23 -0400
Received: by mail-il1-f200.google.com with SMTP id o1so4726777ilk.6
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 03:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DWxdBslkom8iu1CMhBZx9cnBrix7vgJ186+tz9LmQSs=;
        b=kiOp/SUpq7K8I+zd4ruRezwnAnfOCvudaqNNd+lgYXXtRqbh13SmQYce7+1eCE+Jo7
         WiOPLKekIWnRNaJqlNWx5sw/gRQJtLhRHVI7D/c7cnqu349U2XOFDWSUojXS2HQ8Lmla
         VtKNpfnRlLJQOvWGCCsYdN7j41OEExyby79ZF9cQkZf7SwKncXKcoLZP6pJ3fYG/JFvq
         HgeIlsCOm4cHozIio5q3J5MTmBGiBYfR5Jkn0GqKyd4+pQNQ7w5QCznsfajVzBo9QEQ2
         jL3QWJHM4A2/8XrTTWN4d0kJV2tT++n5OR9J3tamsiYltNa6UpAB9vYIMkT9ANgYXrZB
         R7/g==
X-Gm-Message-State: AOAM532sRGdWKvqc1a/Cl36JOmY/RhYYQlMIoD/kbzkHAXnp8HgZrwj3
        FOa3e6yzz9+gaXhSB8aRnFYYt7buYs4CIQUs9pQ2+ZC8wAhh
X-Google-Smtp-Source: ABdhPJyl+/bjrhBTqzilrgleXpP82H0h5USvj/TK22Dj4vuigPaCgy/1J64q0xPq0uRY9g/tCW7+xz8bJ3O6btIQ0pegaT5dUSyI
MIME-Version: 1.0
X-Received: by 2002:a92:d4ca:: with SMTP id o10mr705468ilm.129.1598869702068;
 Mon, 31 Aug 2020 03:28:22 -0700 (PDT)
Date:   Mon, 31 Aug 2020 03:28:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a24fa705ae29dc6c@google.com>
Subject: KMSAN: kernel-infoleak in scsi_cmd_ioctl
From:   syzbot <syzbot+85433a479a646a064ab3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, glider@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3b3ea602 x86: add failure injection to get/put/clear_user
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14d89966900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
dashboard link: https://syzkaller.appspot.com/bug?extid=85433a479a646a064ab3
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85433a479a646a064ab3@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
CPU: 1 PID: 12272 Comm: syz-executor.3 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 kmsan_internal_check_memory+0x238/0x3d0 mm/kmsan/kmsan.c:423
 kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
 instrument_copy_to_user include/linux/instrumented.h:91 [inline]
 _copy_to_user+0x18e/0x260 lib/usercopy.c:33
 scsi_put_cdrom_generic_arg include/linux/uaccess.h:170 [inline]
 scsi_cdrom_send_packet block/scsi_ioctl.c:770 [inline]
 scsi_cmd_ioctl+0x2422/0x25a0 block/scsi_ioctl.c:827
 scsi_cmd_blk_ioctl+0x1f6/0x240 block/scsi_ioctl.c:876
 sd_ioctl_common+0x50a/0x5c0 drivers/scsi/sd.c:1531
 sd_compat_ioctl+0xc5/0x220 drivers/scsi/sd.c:1733
 compat_blkdev_ioctl+0x74b/0x1200 block/ioctl.c:691
 __do_compat_sys_ioctl fs/ioctl.c:847 [inline]
 __se_compat_sys_ioctl+0x55f/0x1100 fs/ioctl.c:798
 __ia32_compat_sys_ioctl+0x4a/0x70 fs/ioctl.c:798
 do_syscall_32_irqs_on arch/x86/entry/common.c:430 [inline]
 __do_fast_syscall_32+0x2af/0x480 arch/x86/entry/common.c:477
 do_fast_syscall_32+0x6b/0xd0 arch/x86/entry/common.c:505
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:554
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fae549
Code: Bad RIP value.
RSP: 002b:00000000f55a80cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000005393
RDX: 0000000020002000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Local variable ----cgc32.i42.i@scsi_cmd_ioctl created at:
 scsi_put_cdrom_generic_arg block/scsi_ioctl.c:695 [inline]
 scsi_cdrom_send_packet block/scsi_ioctl.c:770 [inline]
 scsi_cmd_ioctl+0x2257/0x25a0 block/scsi_ioctl.c:827
 scsi_put_cdrom_generic_arg block/scsi_ioctl.c:695 [inline]
 scsi_cdrom_send_packet block/scsi_ioctl.c:770 [inline]
 scsi_cmd_ioctl+0x2257/0x25a0 block/scsi_ioctl.c:827

Bytes 29-31 of 44 are uninitialized
Memory access of size 44 starts at ffff8881c5bfbaa0
Data copied to user address 0000000020002000
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
