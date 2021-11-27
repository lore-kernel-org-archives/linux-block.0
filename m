Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA92CC433EF
	for <linux-block@archiver.kernel.org>; Sat, 27 Nov 2021 18:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356036AbhK0TCj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Nov 2021 14:02:39 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:53031 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbhK0TAi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Nov 2021 14:00:38 -0500
Received: by mail-io1-f69.google.com with SMTP id k12-20020a0566022a4c00b005ebe737d989so16941989iov.19
        for <linux-block@vger.kernel.org>; Sat, 27 Nov 2021 10:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3lkU9HP9e3xxiLpCA+BlAceZUjMs7h7UuNJjabJrOM0=;
        b=Lo+K4omDdW9FLfRBYHuiHCN3ClDsfhr0i8dmY4E5aqGectPTVw++pcySlCRkyZC2No
         JaXmbgy8yQcjANtGfpyoCG/HNqx2oe7QFsPBgk4+1OX8mU2sOFg2Evl1FHS1iLaxqZYU
         rRXuAXhIxUTi/R/uwUuscvH0nHZBDfM43WgqSEipgRHgGitz8jFa3as9ZyrBq37SVFsQ
         1suQmulPBtcPdSAwNRr3qYb2gmlQD2CwYTwfiMXhY2ZdvM5GhLdLoicuow0jvpYX2pFE
         GBltK+XjzNlUAYSPHCMlKzgGNX2GPthqGAbyRvpgAOVY2hljBzS44h7S6fbfW4Gt5/m0
         PYTA==
X-Gm-Message-State: AOAM532YCE3jgqq4vz6K92a8yOmCpabaJy+ktXByNMM0OCEDuf42AxPg
        KAgiJcH/pEtSzR+RJW2iwnlwcWvrqOLRCqAs0oTbrdrHrfVu
X-Google-Smtp-Source: ABdhPJxvv/efQnvUAEQ9kc0mvTJ9zT/D6GPQYgSH7MhCO4QsxlFrmei6lmBz9KTTxX6hgfj7aHYExMDMKK9FzqSZCN/+64JgIE25
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3048:: with SMTP id u8mr38901358jak.148.1638039443876;
 Sat, 27 Nov 2021 10:57:23 -0800 (PST)
Date:   Sat, 27 Nov 2021 10:57:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e2fc005d1c9c798@google.com>
Subject: [syzbot] general protection fault in reset_interrupt
From:   syzbot <syzbot+b1f15b24307fd6df6021@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c5c17547b778 Merge tag 'net-5.16-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d12e9ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf85c53718a1e697
dashboard link: https://syzkaller.appspot.com/bug?extid=b1f15b24307fd6df6021
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1f15b24307fd6df6021@syzkaller.appspotmail.com

floppy1: disk absent or changed during operation
floppy1: disk absent or changed during operation
floppy1: disk absent or changed during operation
floppy1: disk absent or changed during operation
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 9 Comm: kworker/u16:0 Not tainted 5.16.0-rc2-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:reset_interrupt+0xef/0x140 drivers/block/floppy.c:1793
Code: fc 84 db 0f 85 ab 5e 9b 04 e8 5d 4f fc fc 48 8b 1d 76 4b 00 0c 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 40 48 8b 43 08 5b ff e0 e8 6f 85 42 fd eb a8 e8 68
RSP: 0018:ffffc900005cfd10 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff847a8383 RDI: 0000000000000008
RBP: ffffffff8c6a4240 R08: 0000000000000080 R09: 0000000000000000
R10: ffffffff847a8376 R11: 0000000000000000 R12: ffffc900005cfdb0
R13: ffffffff8c6a4250 R14: ffff888011850600 R15: ffff888010c75800
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa679dac058 CR3: 00000000194aa000 CR4: 0000000000150ef0
DR0: 0000000000002000 DR1: 0000000000000000 DR2: 0000000000000001
DR3: 0000000000006000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace f0abc9321f84d854 ]---
RIP: 0010:reset_interrupt+0xef/0x140 drivers/block/floppy.c:1793
Code: fc 84 db 0f 85 ab 5e 9b 04 e8 5d 4f fc fc 48 8b 1d 76 4b 00 0c 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 40 48 8b 43 08 5b ff e0 e8 6f 85 42 fd eb a8 e8 68
RSP: 0018:ffffc900005cfd10 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff847a8383 RDI: 0000000000000008
RBP: ffffffff8c6a4240 R08: 0000000000000080 R09: 0000000000000000
R10: ffffffff847a8376 R11: 0000000000000000 R12: ffffc900005cfdb0
R13: ffffffff8c6a4250 R14: ffff888011850600 R15: ffff888010c75800
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2645abc6b8 CR3: 00000000194aa000 CR4: 0000000000150ee0
DR0: 0000000000002000 DR1: 0000000000000000 DR2: 0000000000000001
DR3: 0000000000006000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	fc                   	cld
   1:	84 db                	test   %bl,%bl
   3:	0f 85 ab 5e 9b 04    	jne    0x49b5eb4
   9:	e8 5d 4f fc fc       	callq  0xfcfc4f6b
   e:	48 8b 1d 76 4b 00 0c 	mov    0xc004b76(%rip),%rbx        # 0xc004b8b
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 40                	jne    0x70
  30:	48 8b 43 08          	mov    0x8(%rbx),%rax
  34:	5b                   	pop    %rbx
  35:	ff e0                	jmpq   *%rax
  37:	e8 6f 85 42 fd       	callq  0xfd4285ab
  3c:	eb a8                	jmp    0xffffffe6
  3e:	e8                   	.byte 0xe8
  3f:	68                   	.byte 0x68


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
