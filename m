Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6FDC4321A
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 04:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8FD20896
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 04:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFKEFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 00:05:16 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52496 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbfFKEFI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 00:05:08 -0400
Received: by mail-io1-f70.google.com with SMTP id p12so9039705iog.19
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2019 21:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wz9dGOd1R+1s59ciDwYkBRQA92joaEufJIfItrANXuU=;
        b=YZrDauWryRoAvMW3nKUBp4M8/v0cgA+bGJ7A0Vh42zyOdR3WDbyqvUCHBJ+0rZy5gA
         3dZ90WcGaL5gUoNbNAYVF8MpjymKMPeBhsi0bTQXx7hUs+w4LLe34FFU1HgobfCq/Gze
         KcXUlpOFCHGuziPSdpPKJ7VuTGgN9UaNn1gEtcJchye4LvcWG6XMVVN5cZgqwwf6qdQT
         q9bkUt/qlnFep/M/qrJPFUqXWK9QgsAHuh3mS/hbvsj5lorLL63IA7kmWeqF5qQFMm6B
         NSyIhj24AsXvJaRqF3X8enmRC+5SzGPHUFjJj4EnMkSSv7RJ92mBGKsSN1rUE2wiV7na
         G7Fg==
X-Gm-Message-State: APjAAAVpiAtTr2W39tiCBfu4QJ6XQvoHX7W26v8bNKqRFFnm9CRijdWh
        cBA7bg3uCvgmUXP2A7ztVhjZsRGb1651LQLE9RHr4sQDRFGl
X-Google-Smtp-Source: APXvYqwfnhvk1cHusdRiYNrHSd2S00tjyNN9b3K58HpaG3Rjp45MMI96ym3XdOKmtfLlcA4UDNnJPBg2PJ0G3v+dQFFGpnAPMDb6
MIME-Version: 1.0
X-Received: by 2002:a24:7f82:: with SMTP id r124mr13507017itc.135.1560225907490;
 Mon, 10 Jun 2019 21:05:07 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:05:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc4a7b058b04669e@google.com>
Subject: WARNING in blk_mq_sched_free_requests
From:   syzbot <syzbot+b9d0d56867048c7bcfde@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d1fdb6d8 Linux 5.2-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105ade6aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
dashboard link: https://syzkaller.appspot.com/bug?extid=b9d0d56867048c7bcfde
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c67dd2a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154be66aa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b9d0d56867048c7bcfde@syzkaller.appspotmail.com

Code: e8 bc b5 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f735bcf2d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 00000000004466e9
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00000000006dbc30 R08: 0000000000000002 R09: 0000000000003034
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00007f735bcf2d90 R14: 0000000000000004 R15: 20c49ba5e353f7cf
WARNING: CPU: 0 PID: 9739 at block/blk-mq-sched.c:558  
blk_mq_sched_free_requests+0x207/0x290 block/blk-mq-sched.c:558
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9739 Comm: syz-executor118 Not tainted 5.2.0-rc4 #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x744 kernel/panic.c:219
  __warn.cold+0x20/0x4d kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:blk_mq_sched_free_requests+0x207/0x290 block/blk-mq-sched.c:558
Code: ff e8 6d bf 30 fe 31 ff 89 c3 89 c6 e8 32 ac 4a fe 85 db 0f 85 68 fe  
ff ff e8 a5 aa 4a fe 0f 0b e9 5c fe ff ff e8 99 aa 4a fe <0f> 0b e9 7f fe  
ff ff 48 c7 c7 b4 e5 80 89 e8 b6 48 83 fe e9 28 fe
RSP: 0018:ffff88808ab9fa60 EFLAGS: 00010293
RAX: ffff88808c9f6340 RBX: 0000000000000001 RCX: ffffffff8326000e
RDX: 0000000000000000 RSI: ffffffff83260027 RDI: ffff88809f27b020
RBP: ffff88808ab9fab0 R08: ffff88808c9f6340 R09: ffffed1015d06be0
R10: ffffed1015d06bdf R11: ffff8880ae835efb R12: 00000000fffffff4
R13: ffff88809f27b008 R14: ffff88809ec4e658 R15: ffff88809f27b008
  blk_mq_init_sched+0x32c/0x770 block/blk-mq-sched.c:542
  elevator_init_mq+0xcd/0x160 block/elevator.c:622
  blk_mq_init_allocated_queue+0x10e2/0x15b0 block/blk-mq.c:2921
  blk_mq_init_queue+0x62/0xb0 block/blk-mq.c:2705
  loop_add+0x2dd/0x8d0 drivers/block/loop.c:2004
  loop_control_ioctl drivers/block/loop.c:2157 [inline]
  loop_control_ioctl+0x165/0x360 drivers/block/loop.c:2139
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd5f/0x1380 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4466e9
Code: e8 bc b5 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f735bcf2d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 00000000004466e9
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00000000006dbc30 R08: 0000000000000002 R09: 0000000000003034
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00007f735bcf2d90 R14: 0000000000000004 R15: 20c49ba5e353f7cf
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
