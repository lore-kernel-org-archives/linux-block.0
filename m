Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9172DC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7036D20989
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 18:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbfA3SxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:53:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:37460 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfA3SxF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 13:53:05 -0500
Received: by mail-io1-f70.google.com with SMTP id d63so409964iog.4
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 10:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fg+s8VemDqIS1Dm3ntxKLLmNxG7rXfSeD/eYWANBE04=;
        b=EBowt0W3Q3M2Z3jnYEl32+zGnYz3SQpBpZ693SILFRivzkZw9BHmjFdVj8Qfm9CH0Y
         N9PsewzUTPkc6X03CbCc7ak1nT9vgYWHSv4XfJDyPeKu9MD8fsMjeQpJpnhweJGjkf3L
         9/ZkOLA9J9e5IlEB07k+hLGctC6qTd5607xHEtuzYwdVkVC7nS6xAMPmjShDWkQE1ZKY
         33sWQzZ5uN/TigS9SK4tDOovTLzqn/6UI/29acAUV1oyh+Uk+yUF2LhXNHDBujFe4fPq
         a3sZnCJfFCm0NyqwrZNDdVNM/QKp5OPsQHfdsAWDWJ8iqAuyhimeOGoqt0qetxZ3Hs/p
         64+g==
X-Gm-Message-State: AHQUAuaAdKROD4KZlr2EkYWxgR4TAWgXJFaL8jyE6VdGLdObD+Y5lOHz
        79DzDLFbolfS+BeP/5g+85gJn+b91v/wTLOhOR34VeJ0pOQs
X-Google-Smtp-Source: AHgI3IaFmCwo0MU1pG/2QLdd3BLlHpj8O3UibzM+1ha9h58jtUuUA8TYjQHO7wC0WyTfylviYed+epjNesHzR3R2SCZZmb6UCCRU
MIME-Version: 1.0
X-Received: by 2002:a02:3b2b:: with SMTP id c43mr7160347jaa.15.1548874384164;
 Wed, 30 Jan 2019 10:53:04 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:53:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000784c000580b16bdd@google.com>
Subject: general protection fault in debugfs_create_files
From:   syzbot <syzbot+a9d09761be47db706560@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=172ed528c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
dashboard link: https://syzkaller.appspot.com/bug?extid=a9d09761be47db706560
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149209ef400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e00c2f400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a9d09761be47db706560@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8264 Comm: syz-executor060 Not tainted 5.0.0-rc4-next-20190130  
#22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:debugfs_create_files+0x2e/0x140 block/blk-mq-debugfs.c:842
Code: 41 56 49 89 fe 41 55 41 54 49 89 f4 53 48 89 d3 e8 87 d0 f3 fd 49 8d  
7e 58 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 e3 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff88809331f868 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffffffff8881d400 RCX: ffffffff82d9f665
RDX: 0000000000000008 RSI: ffffffff838e48c9 RDI: 0000000000000047
RBP: ffff88809331f888 R08: ffff8880a0c76400 R09: fffffbfff13024e6
R10: fffffbfff13024e5 R11: ffffffff8981272b R12: ffff888099398ed0
R13: ffff888099398ed0 R14: ffffffffffffffef R15: ffff888099398f98
FS:  0000000001edd880(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f835b5dc6f0 CR3: 00000000a0365000 CR4: 00000000001406e0
Call Trace:
  blk_mq_debugfs_register+0xec/0x4e0 block/blk-mq-debugfs.c:865
  blk_register_queue+0x1bc/0x370 block/blk-sysfs.c:944
  __device_add_disk+0xe9f/0x13c0 block/genhd.c:723
  device_add_disk+0x2b/0x40 block/genhd.c:739
  add_disk include/linux/genhd.h:422 [inline]
  loop_add+0x71d/0xa30 drivers/block/loop.c:1999
  loop_control_ioctl+0x18e/0x470 drivers/block/loop.c:2100
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4420d9
Code: e8 6c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffddb7abd48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004420d9
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 0000000000010555 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402f30
R13: 0000000000402fc0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 5909b82e24594aac ]---
RIP: 0010:debugfs_create_files+0x2e/0x140 block/blk-mq-debugfs.c:842
Code: 41 56 49 89 fe 41 55 41 54 49 89 f4 53 48 89 d3 e8 87 d0 f3 fd 49 8d  
7e 58 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 e3 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff88809331f868 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffffffff8881d400 RCX: ffffffff82d9f665
RDX: 0000000000000008 RSI: ffffffff838e48c9 RDI: 0000000000000047
RBP: ffff88809331f888 R08: ffff8880a0c76400 R09: fffffbfff13024e6
R10: fffffbfff13024e5 R11: ffffffff8981272b R12: ffff888099398ed0
R13: ffff888099398ed0 R14: ffffffffffffffef R15: ffff888099398f98
FS:  0000000001edd880(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f835b5dc6f0 CR3: 00000000a0365000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
