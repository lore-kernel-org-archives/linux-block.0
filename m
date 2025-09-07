Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A92315D40
	for <linux-block@vger.kernel.org>; Sun,  7 Sep 2025 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757229097; cv=none; b=fSH1D0ZKFpT+IdT1UClg1cMPYJLqMhfcJ55cr5YhHu2aclBIPxFuHMoznedNzjinL3+T7uEjyF3xDXlQJo0wSSQlfCDdomgMVmCBhyVtuarKGtbC6sdkS3DdQxqwbpLkB4uYI1hNxNN7exb23uZ43sR6SlSr6O8FhxcLbE9H0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757229097; c=relaxed/simple;
	bh=srrrLs+wEC07kyRpepO2/fSGE8nq9ahbv9VrAG4PnAY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TCeAsqO0Nu6nHzKAT+cpTjFZNfqJKzQunxjm63pzBUWRXSbFQG7WAOsn1C7bnh8rCICOsR/R2X39JfaICnIBYOQVVcGQhCSznoDENplaFc80r1FC02Afc4LjGUXrT6uZGBZAPRZfdz3kQpsfcYLhcYHX4NZI2aWeTxm4d8jKOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ee1d164774so64060935ab.1
        for <linux-block@vger.kernel.org>; Sun, 07 Sep 2025 00:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757229095; x=1757833895;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubewheY8ZTSPDA8vJSlVExU9cNAqFiFuY9Aubhjpw4s=;
        b=f7JFWMBMa3x1rXSiBj/ojwPydvtqJSPJccptIBmWW3Fur3A9WffRXeCWObKQcv7QHB
         3+X0IDjWjl2HS2uRLgvxiVlZPd8Na5KoR5dMMUnIcGXoG+MP/u96TH7fHMoQkZtRWoSy
         8/mgLdSzkw2Yk0wqeu8nvrqQYqlBfrC5lea6B/t2czLXAjdf/El0PuZR4vn72yW3MrpP
         ppPTBcwiTHg/yzqwgz+PJt/zzHJg70tR4YmHjQ8Ap1z7rvpzTrbcXXl3AJDeqfsWwSx1
         FYMjP/+yqI9/bE8L7eJxfRtSgNs4lOsPSIuCOxmbaQNJDy/yIBP0izNplE/iV5yoF8b4
         ziCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSHld0RH74mRNAbZLHApPFBTBMAQOpzTL733HBWEwYzmZQb+VWu5ZGGQwR0TxxlH2fLojxDnyK0HZvbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7zzIvuO6xtB1cZweT4qoeI2pz/KON7ThrnJNMoZeDp4gxNHoL
	L/4h3rDdsVcYEN9S9VFeGKS95N3TuBvkF1Hsi0kU/4BzCtUfCXt84IDJQ/mUdcNCKxG2molpiKW
	nBKRbzTdyu8Bf1owmSS6MfdV/+HGjk/J69gqicQNeXIDwPc08wla9xAkUwrw=
X-Google-Smtp-Source: AGHT+IFhxpWMbfP/8VjiaFb7Tjmk3W3CHtWSS2RDMm5Zf5J9mhCagz2YYGMLQrpTVpALgZ+jcAzo324oJgcV6ErhnCztNRrgBxos
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:3fb:d14c:3562 with SMTP id
 e9e14a558f8ab-3fbd14c368amr87816915ab.2.1757229095079; Sun, 07 Sep 2025
 00:11:35 -0700 (PDT)
Date: Sun, 07 Sep 2025 00:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bd3027.050a0220.192772.01cc.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in bio_iov_iter_get_pages
From: syzbot <syzbot+b253ade8e1751d90a7a9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, david@redhat.com, jgg@ziepe.ca, 
	jhubbard@nvidia.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    be5d4872e528 Add linux-next specific files for 20250905
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17896962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a726684450a7d788
dashboard link: https://syzkaller.appspot.com/bug?extid=b253ade8e1751d90a7a9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10496962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a98962580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f67121360b62/disk-be5d4872.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4f666ca2e57f/vmlinux-be5d4872.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e86b794b985e/bzImage-be5d4872.xz

The issue was bisected to:

commit db076b5db550aa34169dceee81d0974c7b2a2482
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Sep 1 15:03:40 2025 +0000

    mm/gup: remove record_subpages()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a0b312580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a0b312580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a0b312580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b253ade8e1751d90a7a9@syzkaller.appspotmail.com
Fixes: db076b5db550 ("mm/gup: remove record_subpages()")

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 UID: 0 PID: 6063 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
RIP: 0010:__bio_iov_iter_get_pages block/bio.c:1258 [inline]
RIP: 0010:bio_iov_iter_get_pages+0x5b2/0x11c0 block/bio.c:1336
Code: 9c 24 20 01 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 0c c9 7c fd 48 8b 1b 4c 8d 73 08 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 ef c8 7c fd 4d 8b 3e 4c 89 fe 48
RSP: 0018:ffffc90002f773e0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88807bfd0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002f77590 R08: 0000000000000000 R09: ffffffff84a7d3b5
R10: dffffc0000000000 R11: fffff94000329b51 R12: dffffc0000000000
R13: ffff888078cd0294 R14: 0000000000000008 R15: 00000000000000f0
FS:  0000555567d13500(0000) GS:ffff888125af9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9a3134c000 CR3: 0000000074d2a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __blkdev_direct_IO+0x60b/0xee0 block/fops.c:215
 blkdev_direct_IO+0x120f/0x1730 block/fops.c:434
 blkdev_direct_write+0x7c/0x140 block/fops.c:719
 blkdev_write_iter+0x547/0x710 block/fops.c:787
 aio_write+0x535/0x7a0 fs/aio.c:1634
 __io_submit_one fs/aio.c:-1 [inline]
 io_submit_one+0x78b/0x1310 fs/aio.c:2053
 __do_sys_io_submit fs/aio.c:2112 [inline]
 __se_sys_io_submit+0x185/0x2f0 fs/aio.c:2082
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9a3058ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf48caa48 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f9a307c5fa0 RCX: 00007f9a3058ebe9
RDX: 00002000000000c0 RSI: 00000000000000f3 RDI: 00007f9a3134c000
RBP: 00007f9a30611e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9a307c5fa0 R14: 00007f9a307c5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
RIP: 0010:__bio_iov_iter_get_pages block/bio.c:1258 [inline]
RIP: 0010:bio_iov_iter_get_pages+0x5b2/0x11c0 block/bio.c:1336
Code: 9c 24 20 01 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 0c c9 7c fd 48 8b 1b 4c 8d 73 08 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 ef c8 7c fd 4d 8b 3e 4c 89 fe 48
RSP: 0018:ffffc90002f773e0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88807bfd0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002f77590 R08: 0000000000000000 R09: ffffffff84a7d3b5
R10: dffffc0000000000 R11: fffff94000329b51 R12: dffffc0000000000
R13: ffff888078cd0294 R14: 0000000000000008 R15: 00000000000000f0
FS:  0000555567d13500(0000) GS:ffff8881259f9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe8453cfd8 CR3: 0000000074d2a000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	9c                   	pushf
   1:	24 20                	and    $0x20,%al
   3:	01 00                	add    %eax,(%rax)
   5:	00 48 89             	add    %cl,-0x77(%rax)
   8:	d8 48 c1             	fmuls  -0x3f(%rax)
   b:	e8 03 42 80 3c       	call   0x3c804213
  10:	20 00                	and    %al,(%rax)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 0c c9 7c fd       	call   0xfd7cc928
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	4c 8d 73 08          	lea    0x8(%rbx),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 ef c8 7c fd       	call   0xfd7cc928
  39:	4d 8b 3e             	mov    (%r14),%r15
  3c:	4c 89 fe             	mov    %r15,%rsi
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
