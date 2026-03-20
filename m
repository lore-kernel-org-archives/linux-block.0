Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4FA38D01A
	for <linux-block@vger.kernel.org>; Fri, 20 Mar 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046671; cv=none; b=eCWSabZVf603zBzaYJ7E9wSwcbLHG5lZ/gCRWCvzI1XIjit9EMBAyssY3dOWksiPkWF+dxEQHnm6h5dOVrid3mC+7BzOeFiHr6biu+RQNJ+5B963tIb4GiSlpbjqwXrWB+dwoxxpZEmfWYDpEYmZLHQsjeE6wm3EFA9RAFzIHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046671; c=relaxed/simple;
	bh=6qEZp8VS8dBegmlsP8ZbHVK/SCZzpWrnZg6aIG8yAT8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h+3N6XcOxE9jZLyfIQtiy5nx+eYbShWMxyNiL0r+my8x8az9wmgUlkuoCtQANb5yUu04U36IzT6D9MJVgD0yAFAnhLMlEb8LacrTd9vlzAohPtJYHu1OirxebZ4vFdJWekxmgzb09BXd+JQJOhYBeZZheVXWzWsVCd1k1ZMbvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-46705762d7eso3782830b6e.2
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2026 15:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774046669; x=1774651469;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1PiOvaG19DzrIcgf3//luJbSwJAeT0XnXRjUjrtTQQ=;
        b=A6qlX1iX091bDMV75zPaJ+1RlaLWrzzjr3toyvvJ6xrehh2BrsNsfkSYmCUeyRdaMW
         W/r8zHv29VczD7qfySo6eWcq1rU2kMS5lqlLy8/hEJxgjiGKd+iZ2Wvv/uzvBwFv8e7+
         tJdiq3EIDkm5Il9K0BLTrw8WEgAWUD7u4OEwMvuv9QaVzNbe+yKy+iB1qxWzrjKqw2mj
         2H2J2R4iPj2qakfPAg9I7mO/1ETlmv5lSKCmUlEBE4bKYfvUYue5AZHN0oHK9ilpUiCc
         AEfbZsRyojaOJAdK3qthdw5MZ9grY7P67hA4eI4qbey1kWUd2M+rBfRycGmABgJowgMc
         NsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvRobSUg9tlxQYTUS8A5xT6sEXj39R57TVNkbMH+iHB1pFEpt7M9rni0JHyUigbFIzEu2kAhJ0fV6WJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy71xsxi8dpZH3s0NkdvTQ/o+y+KLPLqUlzfRMw/rhILG7U3Am
	TJOTvwcqpe8dQ0EJMD+zy8z2+c42OjUPw22gZptStcZKvG8/NjICVlzxoeQTjjAQROtDs5XtEgL
	YPAoFqZQNxGzZQqAoKwcHVTAvgJJb29wl64col77rSe6wbw2Kb57ZoBlY5as=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:308e:b0:467:f636:23bd with SMTP id
 5614622812f47-467f6368f86mr1381577b6e.42.1774046669559; Fri, 20 Mar 2026
 15:44:29 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:44:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bdcdcd.050a0220.3bf4de.0030.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in bio_add_page
From: syzbot <syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8e42d2514a7e Add linux-next specific files for 20260318
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=139b34ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1da705b17f2649a3
dashboard link: https://syzkaller.appspot.com/bug?extid=ed8bc247f231c1a48e21
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108d7352580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64c940773401/disk-8e42d251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa7a94376665/vmlinux-8e42d251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a7ab603c859/bzImage-8e42d251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 35 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:bvec_set_page include/linux/bvec.h:44 [inline]
RIP: 0010:__bio_add_page block/bio.c:992 [inline]
RIP: 0010:bio_add_page+0x462/0x6e0 block/bio.c:1048
Code: fd 48 8b 1b 48 8b 44 24 30 42 0f b6 04 30 84 c0 0f 85 c3 01 00 00 48 8b 14 24 0f b7 02 c1 e0 04 48 01 c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 0c 48 89 df e8 5f da a3 fd 48 8b 14 24 48 8b 44
RSP: 0000:ffffc90000ab6b80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88801eac3d00
RDX: ffff88802cd6ea78 RSI: 00000000ffffefff RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffea0001b06147 R09: 1ffffd4000360c28
R10: dffffc0000000000 R11: fffff94000360c29 R12: 1ffff110059add4f
R13: 0000000000001000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124de1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9bc55ed6b8 CR3: 00000000769ea000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 bio_add_folio+0x64/0x90 block/bio.c:1084
 io_submit_add_bh fs/ext4/page-io.c:465 [inline]
 ext4_bio_write_folio+0x1446/0x1ea0 fs/ext4/page-io.c:603
 mpage_map_and_submit_buffers fs/ext4/inode.c:2326 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2516 [inline]
 ext4_do_writepages+0x207e/0x46e0 fs/ext4/inode.c:2928
 ext4_writepages+0x241/0x3b0 fs/ext4/inode.c:3022
 do_writepages+0x32e/0x550 mm/page-writeback.c:2554
 __writeback_single_inode+0x133/0x11a0 fs/fs-writeback.c:1750
 writeback_sb_inodes+0x992/0x1a20 fs/fs-writeback.c:2042
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2118
 wb_writeback+0x46a/0xb70 fs/fs-writeback.c:2229
 wb_check_start_all fs/fs-writeback.c:2355 [inline]
 wb_do_writeback fs/fs-writeback.c:2381 [inline]
 wb_workfn+0x95b/0xf50 fs/fs-writeback.c:2414
 process_one_work+0x9ab/0x1780 kernel/workqueue.c:3288
 process_scheduled_works kernel/workqueue.c:3379 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3465
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bvec_set_page include/linux/bvec.h:44 [inline]
RIP: 0010:__bio_add_page block/bio.c:992 [inline]
RIP: 0010:bio_add_page+0x462/0x6e0 block/bio.c:1048
Code: fd 48 8b 1b 48 8b 44 24 30 42 0f b6 04 30 84 c0 0f 85 c3 01 00 00 48 8b 14 24 0f b7 02 c1 e0 04 48 01 c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 0c 48 89 df e8 5f da a3 fd 48 8b 14 24 48 8b 44
RSP: 0000:ffffc90000ab6b80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88801eac3d00
RDX: ffff88802cd6ea78 RSI: 00000000ffffefff RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffea0001b06147 R09: 1ffffd4000360c28
R10: dffffc0000000000 R11: fffff94000360c29 R12: 1ffff110059add4f
R13: 0000000000001000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124ee1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005577be56a168 CR3: 000000002552e000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	fd                   	std
   1:	48 8b 1b             	mov    (%rbx),%rbx
   4:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
   9:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
   e:	84 c0                	test   %al,%al
  10:	0f 85 c3 01 00 00    	jne    0x1d9
  16:	48 8b 14 24          	mov    (%rsp),%rdx
  1a:	0f b7 02             	movzwl (%rdx),%eax
  1d:	c1 e0 04             	shl    $0x4,%eax
  20:	48 01 c3             	add    %rax,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 0c                	je     0x3d
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 5f da a3 fd       	call   0xfda3da98
  39:	48 8b 14 24          	mov    (%rsp),%rdx
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	44                   	rex.R


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
