Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B05EC77B61
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 05:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjDQFgi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 01:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjDQFgh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 01:36:37 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9BA4486
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 22:35:55 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id 188-20020a6b15c5000000b007590817bcfbso11908637iov.12
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 22:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681709740; x=1684301740;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksk0yAdnPZ9h+aa8w70NQWMQ13RRkG9NRGp4NJmYeqw=;
        b=ii41GtV45NOuyGMGcXtwBYuet0iZ//ei06gOqHyx82gwv9NWsicA8fTJl6FnMWfesV
         iLmb2NsJo/A6E6b9vV+GD/w5InrlBc23wX21OP84qxMqRNjdxU9Q3wGO9ySb6MmeCM6+
         1eadKdfUE815wtmA8Ea3e62jclYYH3gAeMNCo2TOWs97NAEOAwadqRBmjAxP8pPa6czb
         9NpPWPbqzPP6/GcbURv4KBXepnzqfQ37b+iB6nGPe/xq1F1jkyTkwkpNf4cqh0eYGFPa
         HKjtKhtJK+HmoSXbxfIgNH53CrfquCF+lPXcLA6V1eFIorKYFZZw3DJhgiVFcTABnAs+
         ljLg==
X-Gm-Message-State: AAQBX9eyZxgI8KwiisOMqwXSsLfxN5oiTlhYbFziSoeOyX8A/JXIGD7S
        +SfVKlG0uljGBPxgBFieknmPoIiOsknajyle5qYiAFkKfJ7b
X-Google-Smtp-Source: AKy350aW5NfPbylJiWYB2EOuEHNguTLeuWv/IdMWFRoIGTZMfrjvgnnMWASkFNhxSmpzMrF5rrCsrd2Ed+7E3EhJ/bg2l4f46B7e
MIME-Version: 1.0
X-Received: by 2002:a02:b15c:0:b0:40f:9ab9:c43e with SMTP id
 s28-20020a02b15c000000b0040f9ab9c43emr1955764jah.3.1681709740392; Sun, 16 Apr
 2023 22:35:40 -0700 (PDT)
Date:   Sun, 16 Apr 2023 22:35:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1076405f9818f92@google.com>
Subject: [syzbot] [block?] WARNING in floppy_interrupt (2)
From:   syzbot <syzbot+aa45f3927a085bc1b242@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3e7bb4f24617 Merge tag '6.3-rc6-smb311-client-negcontext-f..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1304980bc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
dashboard link: https://syzkaller.appspot.com/bug?extid=aa45f3927a085bc1b242
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa45f3927a085bc1b242@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 21618 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 3 PID: 21618 at drivers/block/floppy.c:999 floppy_interrupt+0x3cc/0x440 drivers/block/floppy.c:1765
Modules linked in:
CPU: 3 PID: 21618 Comm: kworker/u16:7 Not tainted 6.3.0-rc6-syzkaller-00188-g3e7bb4f24617 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:floppy_interrupt+0x3cc/0x440 drivers/block/floppy.c:1765
Code: 03 cf 8a 89 c6 89 05 63 fa eb 0c e8 7e 27 ff ff 8b 1d 58 fa eb 0c e9 9c fd ff ff e8 8e 5f b7 fc e9 66 fd ff ff e8 24 4d 66 fc <0f> 0b e9 c9 fe ff ff 48 c7 c7 00 f2 40 8c e8 31 5f b7 fc e9 5a fc
RSP: 0018:ffffc900005d8e58 EFLAGS: 00010046
RAX: 0000000080010000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801d1b1d40 RSI: ffffffff851c9e3c RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff851c17e0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000006
FS:  0000000000000000(0000) GS:ffff88802c900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc8f5102dd0 CR3: 000000002655a000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 floppy_hardint+0x1b1/0x200 arch/x86/include/asm/floppy.h:66
 __handle_irq_event_percpu+0x22b/0x730 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
 handle_edge_irq+0x263/0xd00 kernel/irq/chip.c:819
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0xa1/0x220 arch/x86/kernel/irq.c:250
 common_interrupt+0xa8/0xd0 arch/x86/kernel/irq.c:240
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
RIP: 0010:outb_p arch/x86/include/asm/io.h:296 [inline]
RIP: 0010:fdc_outb drivers/block/floppy.c:602 [inline]
RIP: 0010:reset_fdc+0x185/0x400 drivers/block/floppy.c:1817
Code: ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 11 00 0f 85 8a 01 00 00 48 8d 14 9b 48 8b 14 d5 70 6f 08 92 83 c2 04 ee <e8> 56 ec ff ff 48 83 c4 08 5b 5d e9 ab 05 67 fc e8 a6 05 67 fc 48
RSP: 0018:ffffc9000f2c7c20 EFLAGS: 00000202
RAX: 00000000ffffff83 RBX: 0000000000000000 RCX: 1ffffffff2410dee
RDX: 00000000000003f4 RSI: ffffffff851be51c RDI: ffffffff92086f70
RBP: 0000000000000062 R08: 0000000000000001 R09: 0000000000000044
R10: 0000000000000062 R11: 0000000000000000 R12: ffffffff851ca2e0
R13: 0000000000000001 R14: ffff888049043c00 R15: ffff888012489000
 fd_wait_for_completion+0xd2/0x170 drivers/block/floppy.c:1051
 redo_fd_request+0x1f0/0x3010 drivers/block/floppy.c:2799
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
----------------
Code disassembly (best guess):
   0:	ba 00 00 00 00       	mov    $0x0,%edx
   5:	00 fc                	add    %bh,%ah
   7:	ff                   	(bad)
   8:	df 48 89             	fisttps -0x77(%rax)
   b:	f9                   	stc
   c:	48 c1 e9 03          	shr    $0x3,%rcx
  10:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
  14:	0f 85 8a 01 00 00    	jne    0x1a4
  1a:	48 8d 14 9b          	lea    (%rbx,%rbx,4),%rdx
  1e:	48 8b 14 d5 70 6f 08 	mov    -0x6df79090(,%rdx,8),%rdx
  25:	92
  26:	83 c2 04             	add    $0x4,%edx
  29:	ee                   	out    %al,(%dx)
* 2a:	e8 56 ec ff ff       	callq  0xffffec85 <-- trapping instruction
  2f:	48 83 c4 08          	add    $0x8,%rsp
  33:	5b                   	pop    %rbx
  34:	5d                   	pop    %rbp
  35:	e9 ab 05 67 fc       	jmpq   0xfc6705e5
  3a:	e8 a6 05 67 fc       	callq  0xfc6705e5
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
