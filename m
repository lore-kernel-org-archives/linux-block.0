Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447472FE595
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761347490; cv=none; b=GVQ7jflz0sL0uSQtyAj7F6YpUwKLCmX55ka34CUDwLWo47A87z49ywwUz03Fuz+VW6TwkNJyKMUW/w1pcDsfJeqtm/YKlSGXoor+sfam/zFE0OdL5MD5+1g9+9fpYjRh8mhMRMZuDyvkrHDvtryXiR6MNfkCHexGvxExFT0EnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761347490; c=relaxed/simple;
	bh=TqWuiMNO1hihfjy9mgKoaYzys0fXiMRYv7UN+tg68rk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h7KRt+dNL/Sy/kaZirhfSooP1lskfF4eOODCk606TrkMejwf0GOuLdlmor7Gqrb3BZxAu1yOGBOdg3JVUR1dabSqqTy3OlZ57HVSSqD15SBgWnWgQmshRCiZ9MECw8Fh6jGd5Yp5p/7EqnPf7HmPNeCZiMisTwhIw0w77/t5OVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-93e8839f138so261066639f.2
        for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 16:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761347488; x=1761952288;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjmRepIJwH/cpcB3aftqxCwBsx92PWT+vYtmyrKvt24=;
        b=cED1UjCXnR97Y9YIa5IvQXWalP2hL2pZAp4zcJanAhcdM6HyXmo0w7WdWHS5sf0tOZ
         UXtlG9/ph3N0SEuoE8WtzMEREO8NNPe4GEVGqntS5tOMbAK7HoIEt9R4SItKqj79m4UC
         fpMDknEqa8tioiHiHfy/UlHCqXeQNzx3oTDs2OsGZoiD2yo/T/GPZfBZoJR7ArYMgkCH
         ThMpKHxpstyfdv9YcNCN/5bYXOVdx5zxZoy+EGNNIqVztH22utLHUQRMfuNKidaBrEw+
         2ucTMJSmzL1/r1+JuefUsuBmLSY4P7rXkryFvqA9c4O/W+iHlQax4xWyIlZ8LssjTwiR
         R6kg==
X-Forwarded-Encrypted: i=1; AJvYcCXTp2efw2e38rOl0HvDZNzWtpdC5X9MurourX76r6wzf5k9CQYRCUyaM84m+ZSiJvbM8w9bC3p93rVYyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8ng4wZuv8BemOBYjo7DERGVaZPirBgwwFoKIrR0NleZrYgwu
	VPOB5rpiLcT2HM8l91jCnafF6xXlEWJCZcy+yEoCwU+oQP1x7QeOiTdJE+/OaTwKig1P6ZNEliW
	DL47KS6GbMhnLlVZzeDLAyyBH4jlcwjdogmocJ3Mc6K0wfShBbosZ7rktQdQ=
X-Google-Smtp-Source: AGHT+IEhwT19yRBFdU5xSahNxl1hbmQgfpoTuyYyUWb1tuix3klrR1XXKvb7K1Wso2+1MmfeyfhqdhNMIcwuz1zjrPwKY59zxnEx
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3005:b0:42f:9847:15bd with SMTP id
 e9e14a558f8ab-431ebed6309mr48161935ab.26.1761347488417; Fri, 24 Oct 2025
 16:11:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:11:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc07a0.a70a0220.3bf6c6.01aa.GAE@google.com>
Subject: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
From: syzbot <syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    72fb0170ef1f Add linux-next specific files for 20251024
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1640f734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f02d98016cc9c137
dashboard link: https://syzkaller.appspot.com/bug?extid=153e64c0aa875d7e4c37
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105853e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12722614580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f63074a739fa/disk-72fb0170.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b15d7b8b9621/vmlinux-72fb0170.xz
kernel image: https://storage.googleapis.com/syzbot-assets/449963b71f60/bzImage-72fb0170.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: kernel/trace/blktrace.c:368 at __blk_add_trace+0x79c/0x8d0 kernel/trace/blktrace.c:367, CPU#0: jbd2/sda1-8/5163
Modules linked in:
CPU: 0 UID: 0 PID: 5163 Comm: jbd2/sda1-8 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__blk_add_trace+0x79c/0x8d0 kernel/trace/blktrace.c:367
Code: ff 4d 85 e4 75 4f e8 83 0e f8 ff e9 fb fd ff ff e8 79 0e f8 ff e9 ec fd ff ff e8 6f 0e f8 ff e9 d8 fd ff ff e8 65 0e f8 ff 90 <0f> 0b 90 e9 ca fd ff ff e8 57 0e f8 ff 48 8b 7c 24 30 e8 cd 51 00
RSP: 0018:ffffc9000e54f460 EFLAGS: 00010293
RAX: ffffffff81c81b4b RBX: 0000000000000001 RCX: ffff8880341abc80
RDX: 0000000000000000 RSI: 00000000901e000f RDI: 000000008000ffff
RBP: ffffc9000e54f578 R08: ffff8880341abc80 R09: 0000000000000009
R10: 0000000000000011 R11: 0000000000000000 R12: 000000008000ffff
R13: ffff888075c86080 R14: 00000000901e000f R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125f22000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555577629808 CR3: 000000000dd38000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 blk_add_trace_bio_remap+0x4b8/0x560 kernel/trace/blktrace.c:1200
 __do_trace_block_bio_remap include/trace/events/block.h:526 [inline]
 trace_block_bio_remap include/trace/events/block.h:526 [inline]
 blk_partition_remap block/blk-core.c:585 [inline]
 submit_bio_noacct+0x187b/0x1b80 block/blk-core.c:804
 journal_submit_commit_record+0x665/0x8b0 fs/jbd2/commit.c:156
 jbd2_journal_commit_transaction+0x3455/0x5a00 fs/jbd2/commit.c:875
 kjournald2+0x3cf/0x750 fs/jbd2/journal.c:201
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
