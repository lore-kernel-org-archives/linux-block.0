Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5916AECAAD3
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 20:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiIAUWd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 16:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiIAUWb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 16:22:31 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A76F24D
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 13:22:30 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id bf4-20020a056602368400b0068baaa4f99bso11720iob.3
        for <linux-block@vger.kernel.org>; Thu, 01 Sep 2022 13:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=BTFxe77WWd3NzcfLpg8ofoPcbrQKuZjmz/hqFy6+W8I=;
        b=YIHj7EV7JSF3F6/r766mgaOaa/5RLpYIKUU4TDreFI0HtTLIRMf+8oJSZue8CzjEha
         XYGo/Ed47LbARzmxTvfdhSpeMBeSyzpvAwo5cRQXVcfdwT73nMGrX2/LXWsHruL31aJg
         ck7FeArAR21Kuui6PdqSuvWQT6qs59hhc7y/IwfE9mTubwqEqPoz1U5VlLGzGiWBWE/0
         dT+ing+NuKD13Rc1YkAUODFdPNyQdE2dcymFEmKCeV7VxE1E8rhPuGNrkvJiYagGEA1+
         t0grFvwYTcUaEnGy/K8lv1hwYfH+VX976X5oNAev8cfJJYoOWxRcZVH0xkuvVlq3i+1f
         10Gw==
X-Gm-Message-State: ACgBeo3vzC4raFF55biANmFuv7DmDSGFyeXI6K9w2M4V/hJEdjmK1g3N
        BeurOQeAZYB0JA3QLFa7cx6seuji6psDwVzS7oRmOPQ8I7/F
X-Google-Smtp-Source: AA6agR7gvwViqI19wdSQETxaBt6FWFc8WlMRc9kl3GMEX6z/rfV2CenGPBsZ6HJFWVIX7hNNdqcRX++Q3esAzk6DjzOONMs69j8O
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c95:b0:689:e4e2:2c02 with SMTP id
 i21-20020a0566022c9500b00689e4e22c02mr15267879iow.94.1662063749454; Thu, 01
 Sep 2022 13:22:29 -0700 (PDT)
Date:   Thu, 01 Sep 2022 13:22:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000615f3905e7a35f9d@google.com>
Subject: [syzbot] general protection fault in start_motor (2)
From:   syzbot <syzbot+30e9df1b3f1d5117d77f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    10d4879f9ef0 Merge tag 'thermal-6.0-rc3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116400e5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=312be25752c7fe30
dashboard link: https://syzkaller.appspot.com/bug?extid=30e9df1b3f1d5117d77f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126b8675080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30e9df1b3f1d5117d77f@syzkaller.appspotmail.com

floppy1: FDC access conflict!
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 12 Comm: kworker/u16:1 Not tainted 6.0.0-rc2-syzkaller-00283-g10d4879f9ef0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:start_motor+0x3a/0x3f0 drivers/block/floppy.c:1905
Code: 08 e8 7a 39 e0 fc 48 8b 1d 63 54 ae 0c 48 b8 00 00 00 00 00 fc ff df 0f b6 2d b2 3e ae 0c 48 89 da 48 c1 ea 03 89 e9 41 89 ed <0f> b6 04 02 83 e1 03 41 83 e5 03 84 c0 74 08 3c 03 0f 8e be 02 00
RSP: 0018:ffffc900005ffc98 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff849b0096 RDI: ffffffff849b2f00
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff849b2f00
R13: 0000000000000001 R14: ffff888012459400 R15: ffff888011875800
FS:  0000000000000000(0000) GS:ffff88802c900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0afb5ff718 CR3: 000000001b6a0000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_ready+0x83/0x1940 drivers/block/floppy.c:1932
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:start_motor+0x3a/0x3f0 drivers/block/floppy.c:1905
Code: 08 e8 7a 39 e0 fc 48 8b 1d 63 54 ae 0c 48 b8 00 00 00 00 00 fc ff df 0f b6 2d b2 3e ae 0c 48 89 da 48 c1 ea 03 89 e9 41 89 ed <0f> b6 04 02 83 e1 03 41 83 e5 03 84 c0 74 08 3c 03 0f 8e be 02 00
RSP: 0018:ffffc900005ffc98 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff849b0096 RDI: ffffffff849b2f00
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff849b2f00
R13: 0000000000000001 R14: ffff888012459400 R15: ffff888011875800
FS:  0000000000000000(0000) GS:ffff88802c900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0afb5ff718 CR3: 00000000284ad000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 e8                	or     %ch,%al
   2:	7a 39                	jp     0x3d
   4:	e0 fc                	loopne 0x2
   6:	48 8b 1d 63 54 ae 0c 	mov    0xcae5463(%rip),%rbx        # 0xcae5470
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	0f b6 2d b2 3e ae 0c 	movzbl 0xcae3eb2(%rip),%ebp        # 0xcae3ed0
  1e:	48 89 da             	mov    %rbx,%rdx
  21:	48 c1 ea 03          	shr    $0x3,%rdx
  25:	89 e9                	mov    %ebp,%ecx
  27:	41 89 ed             	mov    %ebp,%r13d
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	83 e1 03             	and    $0x3,%ecx
  31:	41 83 e5 03          	and    $0x3,%r13d
  35:	84 c0                	test   %al,%al
  37:	74 08                	je     0x41
  39:	3c 03                	cmp    $0x3,%al
  3b:	0f                   	.byte 0xf
  3c:	8e                   	.byte 0x8e
  3d:	be                   	.byte 0xbe
  3e:	02 00                	add    (%rax),%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
