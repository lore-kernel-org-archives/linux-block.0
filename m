Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE78C636CE
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AAC613AE
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 16:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348497AbhGSPaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 11:30:24 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33676 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346609AbhGSPRl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 11:17:41 -0400
Received: by mail-io1-f71.google.com with SMTP id i9-20020a0566021349b02904df6556dad4so12982883iov.0
        for <linux-block@vger.kernel.org>; Mon, 19 Jul 2021 08:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nwF/dXeoCRoI2C/ceSgiuSYAcwbfabDAX5CG9siKVg4=;
        b=o4lBz4Obvnx1F+myHwaUpcn8koRST+mL+wwM97J2vzUJnS6NrTNSNwGhc8AtsGYDjV
         bn+eWxjpXxyxsFzLPD6OGF18gwOgrNQJWXz5h/aoMtIKKq5oHEiRmWTR/CpzKhuUd3d2
         +vW0gFga7Iwg5fLULIIPpLl1yfR4SNkyy9QiRjw34uR0AKUGbe7h9ElUv8f3HgHs/69M
         p9CnRkUinW9SL5R10hLHGS1AWfS90tOJ+l7aIUx3q0VYuwKEJxbaVZAV+8W+WwYQsNlF
         1Lk30FPBj1CIB9M4qLJxPc48UdrsVyzI4eFez5Uf39JqlPCeyp05jZvTgsyi7OoAHgRp
         Sdew==
X-Gm-Message-State: AOAM533PGU5WxA6AoQXzO8LWWXi01XQbNI95lpmxiGodU6FSXjn4+GlO
        +Yj18uWK/Ery1fkBB2g22v+VK98DIl5FTsNlITbb0zZPk/8J
X-Google-Smtp-Source: ABdhPJyvXXC06oThxXg2v+XvQipalVyf/v8o5JV4y1xvR/ChnsB2CiGmQxn9aKTmYayeuSozPFCzP+/rRRby5ATu+0cuS8BTYtu1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13ca:: with SMTP id i10mr18714334jaj.90.1626710300207;
 Mon, 19 Jul 2021 08:58:20 -0700 (PDT)
Date:   Mon, 19 Jul 2021 08:58:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098af8e05c77c0161@google.com>
Subject: [syzbot] WARNING in md_alloc
From:   syzbot <syzbot+2390fceae217ab729cf7@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8096acd7442e Merge tag 'net-5.14-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168f0a14300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da140227e4f25b17
dashboard link: https://syzkaller.appspot.com/bug?extid=2390fceae217ab729cf7

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2390fceae217ab729cf7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2468 at block/genhd.c:523 __device_add_disk+0xb76/0xd10 block/genhd.c:523
Modules linked in:
CPU: 0 PID: 2468 Comm: syz-executor.5 Tainted: G        W         5.14.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__device_add_disk+0xb76/0xd10 block/genhd.c:523
Code: fb ff ff 4c 89 ef 89 44 24 28 e8 75 c8 f6 fd 8b 44 24 28 e9 7a fb ff ff 4c 89 ef e8 f4 c7 f6 fd e9 e0 fb ff ff e8 4a a8 b0 fd <0f> 0b e9 97 fb ff ff 4c 89 ff e8 0b c8 f6 fd e9 b1 f6 ff ff 48 8b
RSP: 0018:ffffc90018587a30 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff8880863cac00 RCX: ffffc90014873000
RDX: 0000000000040000 RSI: ffffffff83c4df76 RDI: 0000000000000003
RBP: ffff888027440400 R08: 0000000000000000 R09: ffffffff8bac1273
R10: ffffffff83c4db08 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8880863cb09c R14: ffff8880274404a0 R15: 0000000000000000
FS:  00007f66b7003700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000544038 CR3: 000000003f471000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 add_disk include/linux/genhd.h:217 [inline]
 md_alloc+0xa32/0x1190 drivers/md/md.c:5707
 md_probe+0x69/0x70 drivers/md/md.c:5738
 blk_request_module+0x111/0x1d0 block/genhd.c:660
 blkdev_get_no_open+0x1d5/0x250 fs/block_dev.c:1332
 blkdev_get_by_dev.part.0+0x25/0xdd0 fs/block_dev.c:1395
 blkdev_get_by_dev+0x6b/0x80 fs/block_dev.c:1448
 swsusp_check+0x4d/0x270 kernel/power/swap.c:1525
 software_resume.part.0+0x102/0x1f0 kernel/power/hibernate.c:977
 software_resume kernel/power/hibernate.c:86 [inline]
 resume_store+0x161/0x190 kernel/power/hibernate.c:1179
 kobj_attr_store+0x50/0x80 lib/kobject.c:856
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x75a/0xa40 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f66b7003188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000012 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00007f66b70031d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000a9fb1f R14: 00007f66b7003300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
