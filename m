Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9DFC77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 17:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDMRY4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 13:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDMRYz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 13:24:55 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E356595
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 10:24:53 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id y198-20020a6bc8cf000000b00760b47349b4so1192712iof.17
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 10:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681406693; x=1683998693;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=het8HlJMdVytErwlzObZICB1SroiwS2yUvlml5Qdc98=;
        b=hoCsP+io8N5N8DDH0gUdOq2ks6pYrURwvH9VW9z8G+LmWtqV0Uw0e8LoGujN+6j3YC
         1OgZLxS1eQKohko49/RgXP/QfodilwaeexVdNipTUG7lQWNWFCTdimoZYAkveIv60zZl
         vqkJNHla/vAvK8o2qReUNuhIpDBgIzHsQ42zUIwi0ZXm6rWp1wwAVNcekQ5xLccZD6ux
         o43M5ygNNJf7kgzwae0SuEQOZu6eXm4j7GAeimTHnjMQolLwQHidC/IQ0UdwkebA6ktP
         i9FoZMsdyfQtsHbo81vaKkEN7PZ6ffvJeHiYPsdslZdnO8PnJ9p9nzy7BrqL82SDI/52
         +q3A==
X-Gm-Message-State: AAQBX9eqgjBrsNhkAEjvrKMqiVBCUF2vBsHVQQ0WSXvC6fdQEtzuPOKe
        g/Ue3hBPbkxtbQlO5jit/mY176KEfyk2qMlwpXevTV342nuX
X-Google-Smtp-Source: AKy350Y+zTXUXP8+Olm4yxgeHugP3Wwji8D+h9ozFpiwrKT4vPdDjy9AwaZXRAKMLcA3csFnDBkbG1ekHnOs/rdE+4fo+kSjNZOQ
MIME-Version: 1.0
X-Received: by 2002:a02:7a4a:0:b0:406:29c8:2d7c with SMTP id
 z10-20020a027a4a000000b0040629c82d7cmr974631jad.5.1681406693287; Thu, 13 Apr
 2023 10:24:53 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:24:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad319d05f93b0045@google.com>
Subject: [syzbot] [block?] WARNING in fd_locked_ioctl
From:   syzbot <syzbot+641182a53d64479c27e7@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cdc9718d5e59 Merge tag '6.3-rc5-smb3-cifs-client-fixes' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1276f863c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adfc55aec6afccdd
dashboard link: https://syzkaller.appspot.com/bug?extid=641182a53d64479c27e7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+641182a53d64479c27e7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 29187 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 0 PID: 29187 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 0 PID: 29187 at drivers/block/floppy.c:999 do_format drivers/block/floppy.c:2239 [inline]
WARNING: CPU: 0 PID: 29187 at drivers/block/floppy.c:999 fd_locked_ioctl+0x1607/0x1990 drivers/block/floppy.c:3501
Modules linked in:
CPU: 0 PID: 29187 Comm: syz-executor.0 Not tainted 6.3.0-rc5-syzkaller-00247-gcdc9718d5e59 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:do_format drivers/block/floppy.c:2239 [inline]
RIP: 0010:fd_locked_ioctl+0x1607/0x1990 drivers/block/floppy.c:3501
Code: 3d f8 ff ff 41 bf f0 ff ff ff e9 e3 ee ff ff e8 9f d8 65 fc 0f 0b e9 c9 f2 ff ff e8 93 d8 65 fc e9 68 ee ff ff e8 89 d8 65 fc <0f> 0b e9 93 ee ff ff 48 8b 34 24 48 c7 c7 80 47 44 8d e8 92 03 22
RSP: 0018:ffffc90025edfcd8 EFLAGS: 00010212
RAX: 00000000000023eb RBX: 0000000000000001 RCX: ffffc90008501000
RDX: 0000000000040000 RSI: ffffffff851c2227 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000004
R13: 000000000000000c R14: 0000000000000001 R15: 0000000000000007
FS:  00007f8e9362f700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f79a81ad988 CR3: 000000007486d000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fd_ioctl+0x39/0x60 drivers/block/floppy.c:3574
 blkdev_ioctl+0x372/0x800 block/ioctl.c:615
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8e9288c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8e9362f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8e929abf80 RCX: 00007f8e9288c169
RDX: 0000000020000000 RSI: 00000000400c0248 RDI: 0000000000000003
RBP: 00007f8e928e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff829ac3cf R14: 00007f8e9362f300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
