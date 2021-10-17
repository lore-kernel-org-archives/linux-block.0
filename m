Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB45C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 21:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE960F35
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 21:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbhJQVmh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 17:42:37 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:41750 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhJQVmg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 17:42:36 -0400
Received: by mail-il1-f200.google.com with SMTP id c4-20020a92b744000000b002592dabe954so6720906ilm.8
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 14:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2TSfyptoUa4RCOgMKaGgOE0lwOtb+FL6rAkao5HJvrg=;
        b=csodL5CRnw2ufkpv4WQXex+Qekvl1T95I4wLakBWjhbn8tE8WCq7vl3EWlplv+HV3N
         cRV+QH2NJA3+NOEZ3dzh6ZzKQesO77HF3C/C8cwdGcOb22CLw3vbcEnMzu51KgCoGjvF
         Nqryqbr2ZgZsCF8PkhIPiJEFH/3SFS25IMDbaa1X6RvWQVIkg7Vn7R+b7FRBBaySNRoh
         xxrr+a3zFdqds/rqkfVnM75taflTfnuQAtFl/8dr0HQj8UeAoyTIkYB6Y0DlY6diHtCn
         p60kWAHjY6nLA1Q5hRwRdKr0y1tAXBr22KyyERRa4lTiTaHPH/xZRvnkXU9BNmvqb/X+
         GBAg==
X-Gm-Message-State: AOAM531K7JLO81SOaHu5aESrFaj/2KEjf/L3Gh7jtWeLRNDmH6btuyC9
        6QRRwR8vDQvkAzFC6B0XW0Atcwx2M4qRQH1Sq16vfcmHyDun
X-Google-Smtp-Source: ABdhPJxQ7zfs8QPLy0Q2dPSHc5QhrzOVET2+bUr8QGyD2SUWd4NjuQCQSmEKGkYIu1HubhGVR2pNULD6fQ4S9mR3oDrNw//c8dWd
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1507:: with SMTP id b7mr16441784jat.122.1634506826562;
 Sun, 17 Oct 2021 14:40:26 -0700 (PDT)
Date:   Sun, 17 Oct 2021 14:40:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7c18505ce93467e@google.com>
Subject: [syzbot] general protection fault in hctx_lock
From:   syzbot <syzbot+005b78d4c45263d656dd@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c832d2f9b95 Add linux-next specific files for 20211015
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e9df10b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6ac42766a768877
dashboard link: https://syzkaller.appspot.com/bug?extid=005b78d4c45263d656dd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1154f80cb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1750eeecb00000

The issue was bisected to:

commit f328476e373a7ce4b4d16c48fe85571044e025f5
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Oct 12 10:40:45 2021 +0000

    blk-mq: cleanup blk_mq_submit_bio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b6a078b00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13b6a078b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b6a078b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+005b78d4c45263d656dd@syzkaller.appspotmail.com
Fixes: f328476e373a ("blk-mq: cleanup blk_mq_submit_bio")

loop7: detected capacity change from 0 to 1036
general protection fault, probably for non-canonical address 0xdffffc0000000027: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000138-0x000000000000013f]
CPU: 0 PID: 7029 Comm: syz-executor121 Not tainted 5.15.0-rc5-next-20211015-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:hctx_lock+0x29/0x1d0 block/blk-mq.c:780
Code: 00 41 55 41 54 49 89 f4 55 53 48 89 fb e8 1f 16 b3 fd 48 8d bb 38 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 8a 01 00 00 48 8b ab 38 01 00 00 31 ff 83 e5 20
RSP: 0018:ffffc9000319f0c8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000027 RSI: ffffffff83c44e71 RDI: 0000000000000138
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc9000319f110
R13: 0000000000000001 R14: 0000000000000148 R15: ffffc9000319f570
FS:  00007fca2d18e700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fca2d232e88 CR3: 00000000705ed000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blk_mq_run_hw_queue+0x79/0x2f0 block/blk-mq.c:1697
 blk_mq_submit_bio+0x136b/0x1920 block/blk-mq.c:2316
 __submit_bio_noacct_mq block/blk-core.c:997 [inline]
 submit_bio_noacct block/blk-core.c:1026 [inline]
 submit_bio_noacct+0xa26/0xee0 block/blk-core.c:1012
 submit_bio block/blk-core.c:1087 [inline]
 submit_bio+0x1ea/0x470 block/blk-core.c:1045
 submit_bio_wait+0x106/0x230 block/bio.c:1266
 blkdev_issue_flush+0xd6/0x130 block/blk-flush.c:458
 blkdev_fsync+0x68/0xa0 block/fops.c:401
 vfs_fsync_range+0x13a/0x220 fs/sync.c:200
 generic_write_sync include/linux/fs.h:2951 [inline]
 blkdev_write_iter+0x3d8/0x540 block/fops.c:486
 call_write_iter include/linux/fs.h:2159 [inline]
 do_iter_readv_writev+0x472/0x750 fs/read_write.c:729
 do_iter_write+0x188/0x710 fs/read_write.c:855
 vfs_iter_write+0x70/0xa0 fs/read_write.c:896
 iter_file_splice_write+0x723/0xc70 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x110/0x180 fs/splice.c:936
 splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
 do_splice_direct+0x1b3/0x280 fs/splice.c:979
 do_sendfile+0xaf2/0x1250 fs/read_write.c:1249
 __do_sys_sendfile64 fs/read_write.c:1314 [inline]
 __se_sys_sendfile64 fs/read_write.c:1300 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fca2d1e96d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fca2d18e2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fca2d2664a0 RCX: 00007fca2d1e96d9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 00007fca2d2664ac R08: 0000000000000000 R09: 0000000000000000
R10: 0000000024002da8 R11: 0000000000000246 R12: 00007fca2d2332c4
R13: 6f6f6c2f7665642f R14: 0000002a1a885446 R15: 00007fca2d2664a8
 </TASK>
Modules linked in:
---[ end trace 20f37bd14883795d ]---
RIP: 0010:hctx_lock+0x29/0x1d0 block/blk-mq.c:780
Code: 00 41 55 41 54 49 89 f4 55 53 48 89 fb e8 1f 16 b3 fd 48 8d bb 38 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 8a 01 00 00 48 8b ab 38 01 00 00 31 ff 83 e5 20
RSP: 0018:ffffc9000319f0c8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000027 RSI: ffffffff83c44e71 RDI: 0000000000000138
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc9000319f110
R13: 0000000000000001 R14: 0000000000000148 R15: ffffc9000319f570
FS:  00007fca2d18e700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fca2d232e88 CR3: 00000000705ed000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 41 55             	add    %al,0x55(%rcx)
   3:	41 54                	push   %r12
   5:	49 89 f4             	mov    %rsi,%r12
   8:	55                   	push   %rbp
   9:	53                   	push   %rbx
   a:	48 89 fb             	mov    %rdi,%rbx
   d:	e8 1f 16 b3 fd       	callq  0xfdb31631
  12:	48 8d bb 38 01 00 00 	lea    0x138(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 8a 01 00 00    	jne    0x1be
  34:	48 8b ab 38 01 00 00 	mov    0x138(%rbx),%rbp
  3b:	31 ff                	xor    %edi,%edi
  3d:	83 e5 20             	and    $0x20,%ebp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
