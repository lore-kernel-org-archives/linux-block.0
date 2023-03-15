Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AFBC61DA4
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 03:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCODQv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 23:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCODQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 23:16:50 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D43457D0
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 20:16:48 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id d6-20020a92d786000000b00316f1737173so9401523iln.16
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 20:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678850207;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGBVKQOu//U9MZYEieyhjs1JmosA1wF9zZa3sb+J/0w=;
        b=ijeDBaA2YOMmqCZi6nT9qIjB4HtQsuM23gHsk5IGnpGcX3SMQkAj+Isl+xWz3KkeTu
         h0IlAzhdSZynP8lvFadPSs4G7I7fPMiL9M+HH76Us76+JHhAIISDgHK9yDGa8te3+/ZA
         CwXG2srX3qnXGammXe0xjWwAs5AXS2nZ3MC/b89Kt3WK6pRnhj0fhljrZAVSraNxdpiN
         yIlB89C6Ah+ScnNMBGHuZSEs+dwqXB8ZeyLMNw2OVW9p3/75DCsgc1cPZpCW7g2gRzgU
         WiCdNGV74/Us7psw/YgNlQi3BPVZhubcfMO1L5Ed6r2f6ziZ0Wid3+I1RDiDDanxW15O
         IXHg==
X-Gm-Message-State: AO0yUKWRyrkEl+W1k+LxhIaTQ4bc4uHUwfOkitBye7h8Jr8jK7L4Mh6F
        6qwlcmcqWSoZ2Ev1d09UsICOLPC5TpG47dDBMzL20/iDPKGj
X-Google-Smtp-Source: AK7set/GAqdOFmxcV2MmuG0PXBuF4cINuIPZG+o9uUcOG/MPMfL6gi+8XaWlhl77JLjbUkmLCXIZouRhhiQFP3qYrJBgz9fMtBCf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d0c:b0:313:c399:73c8 with SMTP id
 g12-20020a056e020d0c00b00313c39973c8mr2516315ilj.4.1678850207484; Tue, 14 Mar
 2023 20:16:47 -0700 (PDT)
Date:   Tue, 14 Mar 2023 20:16:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003faaa105f6e7c658@google.com>
Subject: [syzbot] [block?] WARNING in copy_page_from_iter
From:   syzbot <syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fc89d7fb499b Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ec6e84c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=253e7e1012aef938
dashboard link: https://syzkaller.appspot.com/bug?extid=63dec323ac56c28e644f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103eae42c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a81156c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a6a7b232754b/disk-fc89d7fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdf765cb166a/vmlinux-fc89d7fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ba2677f81efa/bzImage-fc89d7fb.xz

The issue was bisected to:

commit a41dad905e5a388f88435a517de102e9b2c8e43d
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Sep 16 00:11:15 2022 +0000

    iov_iter: saner checks for attempt to copy to/from iterator

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14bda788c80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16bda788c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12bda788c80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com
Fixes: a41dad905e5a ("iov_iter: saner checks for attempt to copy to/from iterator")

WARNING: CPU: 1 PID: 5070 at lib/iov_iter.c:623 _copy_from_iter+0x2ad/0x1060 lib/iov_iter.c:623
Modules linked in:
CPU: 1 PID: 5070 Comm: syz-executor363 Not tainted 6.3.0-rc2-syzkaller-00006-gfc89d7fb499b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:_copy_from_iter+0x2ad/0x1060 lib/iov_iter.c:623
Code: 5d 41 5c 41 5d 41 5e 41 5f c3 e8 4e 1a 6e fd be 73 02 00 00 48 c7 c7 40 ab a6 8a e8 1d ec a9 fd e9 56 fe ff ff e8 33 1a 6e fd <0f> 0b 45 31 ff eb 8b e8 27 1a 6e fd 31 ff 89 ee e8 2e 16 6e fd 40
RSP: 0018:ffffc9000348f688 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802ab34100 RSI: ffffffff8414dc0d RDI: 0000000000000001
RBP: 0000000000000021 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffea0001c9fc00 R14: ffffc9000348f8c0 R15: 0000000000000021
FS:  000055555576d300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004561a0 CR3: 000000007980a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 copy_page_from_iter lib/iov_iter.c:748 [inline]
 copy_page_from_iter+0x233/0x3f0 lib/iov_iter.c:737
 bio_copy_from_iter block/blk-map.c:55 [inline]
 bio_copy_user_iov block/blk-map.c:210 [inline]
 blk_rq_map_user_iov+0xb5d/0x16e0 block/blk-map.c:661
 blk_rq_map_user block/blk-map.c:690 [inline]
 blk_rq_map_user_io+0x1cd/0x200 block/blk-map.c:723
 sg_start_req drivers/scsi/sg.c:1807 [inline]
 sg_common_write.constprop.0+0xdcd/0x1e00 drivers/scsi/sg.c:803
 sg_new_write.isra.0+0x522/0xa90 drivers/scsi/sg.c:770
 sg_ioctl_common drivers/scsi/sg.c:935 [inline]
 sg_ioctl+0x9a8/0x2700 drivers/scsi/sg.c:1159
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f47aad046c9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcbf523d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f47aad046c9
RDX: 0000000020000180 RSI: 0000000000002285 RDI: 0000000000000003
RBP: 00007f47aacc41d0 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000ffff R11: 0000000000000246 R12: 00007f47aacc4260
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
