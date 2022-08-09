Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF75C19F2D
	for <linux-block@archiver.kernel.org>; Tue,  9 Aug 2022 10:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbiHIKld (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Aug 2022 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbiHIKlc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2022 06:41:32 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9B24097
        for <linux-block@vger.kernel.org>; Tue,  9 Aug 2022 03:41:31 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h25-20020a056e021d9900b002e069b96119so5911720ila.14
        for <linux-block@vger.kernel.org>; Tue, 09 Aug 2022 03:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=tUq98I7aR5JXGl5sCzEIGpj+bZOjTZ1Xlr+6Uy5x0Ls=;
        b=zSopQt8D8TVOkUuu53GEN2fXZX0d08bU5KRswV1yU9wyWUsXXb94LODvI8xcJiuYwF
         B9+0ZX0D6o/oyTJE4ABhfzEV1yPfdhsC/zt+pkJiBIgJt2HgJGdHnOw7CXVOXxi98k+L
         gOa72NPwfKUEWk44n6PzMM4ftmXb8IykZklQRqgYmoUWhoGuwRcNDsM1wlpyn049pg+c
         MSMqTMOIS/1frVMyHEtPlFaGqrsBptMJ8hDuVnW30wZSDxMjwPt4zVv4ZXIPBZWz0w+F
         6tPQu0F/oyxdRp5AzbqU5JBFFLlZrZwTKjM1b67hPWGD1pj6VJ7V/4ceEGvFcw/7AK8I
         5C1A==
X-Gm-Message-State: ACgBeo31tqXDZiL8qBwcXiL0+CgZseDnkDM87y0+2RGWidTRvNl/09LL
        0qh9vLU/dElOYoarE6lqwFpnBCsouRL7Uq1/qAAiAQspw3uP
X-Google-Smtp-Source: AA6agR43YaEMsUVc0nln447abeqEOnooti4uMdExknLZbeue8Dw4a9H4ecC1NOhlEGgjwc23KyBdSLEYB1ui7NliMkUNc7CZRNSg
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3015:b0:341:de68:602c with SMTP id
 r21-20020a056638301500b00341de68602cmr10181049jak.10.1660041690986; Tue, 09
 Aug 2022 03:41:30 -0700 (PDT)
Date:   Tue, 09 Aug 2022 03:41:30 -0700
In-Reply-To: <000000000000ab752605e5c85e9a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004dbc5305e5cc93a6@google.com>
Subject: Re: [syzbot] WARNING in blk_mq_release
From:   syzbot <syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1446b746080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=31c9594f6e43b9289b25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106b302a080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b1dae1080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 23016 at block/blk-mq.c:3881 blk_mq_release+0xf8/0x3e0 block/blk-mq.c:3881
Modules linked in:
CPU: 1 PID: 23016 Comm: syz-executor588 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:blk_mq_release+0xf8/0x3e0 block/blk-mq.c:3881
Code: fd 4c 8d a3 a8 02 00 00 4c 89 e0 48 c1 e8 03 80 3c 28 00 0f 85 14 02 00 00 48 8b 83 a8 02 00 00 49 39 c4 75 b1 e8 48 e4 96 fd <0f> 0b eb a8 e8 3f e4 96 fd 48 8b 44 24 10 48 05 18 05 00 00 48 89
RSP: 0018:ffffc900032bfc60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807a8e8800 RCX: 0000000000000000
RDX: ffff88807cd89d80 RSI: ffffffff83e3f578 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88807a8e8aa8
R13: ffff88807ab0db40 R14: ffff88807ab0db88 R15: 0000000000000000
FS:  0000555555af3300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbf573219f0 CR3: 000000007deea000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 blk_release_queue+0x153/0x270 block/blk-sysfs.c:780
 kobject_cleanup lib/kobject.c:673 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:721
 __alloc_disk_node+0x4f7/0x610 block/genhd.c:1388
 __blk_mq_alloc_disk+0x13b/0x1f0 block/blk-mq.c:3961
 loop_add+0x3e2/0xaf0 drivers/block/loop.c:1978
 loop_control_ioctl+0x133/0x620 drivers/block/loop.c:2150
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbf572f20b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca9b31288 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fbf572f20b9
RDX: 000000000000000c RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007ffca9b312a0 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

