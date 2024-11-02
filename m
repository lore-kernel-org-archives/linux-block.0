Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F424A3E
	for <linux-block@vger.kernel.org>; Sat,  2 Nov 2024 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506533; cv=none; b=E3ZrQeqq8N1Ujl3CaNlh6zTac+/atuHuYm+wF55YtcsiNJQDO7DqgDMQo0XBhIfXsiJKh2NBxG5UkGmiSudOjFDSwBffO06MbnBG0D2YTpqt4zAYMMsZZpVMCw4g6E5UcprmgBY3syp0F7zjus5+w3DO1CZ8L+OMFcerv+nBNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506533; c=relaxed/simple;
	bh=tu90EwF9Fuc+Ly4RB/JHAkt1ImdYEDy2DN4z8tXkJGY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CDZwFR8NSIrOVydjzdSOXFtP46laFR28kX5o4RlZXAN29b4yZD/KwNCQucJQH+c44P5k8dTwwmcJI0ffpgIP4WcEWHZ/VaNHftcyZX9aLir+rq3kaCobeD2iW0jdmwOCp4kuV0h6W5lCYZcDOttrqHQ5FO6HqniLgo0vOE3zhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so7058265ab.2
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2024 17:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506531; x=1731111331;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svwq+zTEWxdtOvQVSc1wiBds0BD2CCLeRevra06h50k=;
        b=XjG7ix8zi4AzY2/PkfjOEUcqf5N1ZL4KTf4/IfOl7oT8357ov+SX+CPqJRjn6vv43s
         kMI08Jnmp+JxocvdTwJmRVsaCH+GLH8m1UnIijrG/OELQY31z7gJ5ggTG+2znUMpLcp5
         2C07q6IJ9HhWXJoblXyWkFFs+NlPf/jbWVWIh5oeYCMwRVSBbAzwOBSt0SUgcNkYeWYH
         TuLKweMCyUca1QY8gFqsgpNHkfgU5huJ8i7fYKP2zWyVkvOweWNCgvUnqziOBZAwM2Sd
         qkJ5ExiEmqweUH5F+81fQjOTMNSfnC71F9rAN0bnb5hLzt6QUGpd5V5CYPOWyQPuPz/8
         mN7w==
X-Forwarded-Encrypted: i=1; AJvYcCUFpfb77WkJAMLLYSAKopQcDx0bJYFqXz1CP1D6LFUSrxs+YkXgLlzmJtYVimnOlkFqIwuCQBbyZPELbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xKVjs1JaIdZen5nmjPIvytPatEvlNMJ8WW+XlCFfl/rgu2Wd
	gVHL2D3H31N7kGt1PTsNb+IQ62hfuzxhZJM100PlZjdm4qVZH2H6yBb8XBGhRHdJjxTMu+6VajX
	Qg7jTuIbpbv6CunR1vcOPzgHpjUad6e+wCnhmGzOofQIn0yw9TJPB7u8=
X-Google-Smtp-Source: AGHT+IEXewltQnTxa9W9quoHZ2SUC1309Btru3DCiuz5w9YgSkxUpftUsJSbZHWFJPNT5uwrhPOGmxfTbDXmUc2Rifmkl4wAFayt
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1688:b0:3a6:be66:ce53 with SMTP id
 e9e14a558f8ab-3a6be66d4b1mr8457905ab.18.1730506531084; Fri, 01 Nov 2024
 17:15:31 -0700 (PDT)
Date: Fri, 01 Nov 2024 17:15:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67256f23.050a0220.35b515.017e.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in blk_update_request
From: syzbot <syzbot+1d38eedcb25a3b5686a7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    819837584309 Linux 6.12-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ec6ca7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=1d38eedcb25a3b5686a7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7eaadcc9db59/disk-81983758.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ffd56091c79/vmlinux-81983758.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c49f66756e3e/bzImage-81983758.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d38eedcb25a3b5686a7@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xe01ffbf110170c7f: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x00ffff8880b863f8-0x00ffff8880b863ff]
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__lock_acquire+0x69/0x2050 kernel/locking/lockdep.c:5065
Code: b6 04 30 84 c0 0f 85 9b 16 00 00 45 31 f6 83 3d c8 e8 ac 0e 00 0f 84 b6 13 00 00 89 54 24 54 89 5c 24 68 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 79 48 8e 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90000157610 EFLAGS: 00010013
RAX: 001ffff110170c7f RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 00ffff8880b863fe
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff203a066 R12: ffff88801d2bda00
R13: 0000000000000001 R14: 0000000000000000 R15: 00ffff8880b863fe
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3091aff8 CR3: 000000000e734000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x759/0xf50
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 blk_update_request+0x5e5/0x1160 block/blk-mq.c:923
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1051
 blk_flush_complete_seq+0x6b7/0xce0 block/blk-flush.c:191
 flush_end_io+0xab1/0xdc0 block/blk-flush.c:250
 __blk_mq_end_request+0x4a5/0x620 block/blk-mq.c:1041
 blk_complete_reqs block/blk-mq.c:1126 [inline]
 blk_done_softirq+0x102/0x150 block/blk-mq.c:1131
 handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x546/0xa30 kernel/smpboot.c:164
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x69/0x2050 kernel/locking/lockdep.c:5065
Code: b6 04 30 84 c0 0f 85 9b 16 00 00 45 31 f6 83 3d c8 e8 ac 0e 00 0f 84 b6 13 00 00 89 54 24 54 89 5c 24 68 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 79 48 8e 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90000157610 EFLAGS: 00010013
RAX: 001ffff110170c7f RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 00ffff8880b863fe
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff203a066 R12: ffff88801d2bda00
R13: 0000000000000001 R14: 0000000000000000 R15: 00ffff8880b863fe
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3091aff8 CR3: 000000000e734000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	b6 04                	mov    $0x4,%dh
   2:	30 84 c0 0f 85 9b 16 	xor    %al,0x169b850f(%rax,%rax,8)
   9:	00 00                	add    %al,(%rax)
   b:	45 31 f6             	xor    %r14d,%r14d
   e:	83 3d c8 e8 ac 0e 00 	cmpl   $0x0,0xeace8c8(%rip)        # 0xeace8dd
  15:	0f 84 b6 13 00 00    	je     0x13d1
  1b:	89 54 24 54          	mov    %edx,0x54(%rsp)
  1f:	89 5c 24 68          	mov    %ebx,0x68(%rsp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 79 48 8e 00       	call   0x8e48b1
  38:	48                   	rex.W
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
