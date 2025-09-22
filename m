Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E12F28F1
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572668; cv=none; b=QFrNbia4YkJ6mX8Y67jiqnvw81e0M0OqHDdckEpr4IS5yAXpLyQbt3j/QCq1UpT1NTnm3ZqlnC5OT4D1+axS7RlDhKd40cXEqDYWhXXvbAe+hPCzvY01/Ibir2R/nGtbDRYTBrpQeJlwcx7GUV9Sas25SXPHZYPZl6aFlzvpRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572668; c=relaxed/simple;
	bh=Oj7ln5Ljm5MkaOYXqtEJWRICBAgaj+7a15iMkZDSXvk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ljqy1ZiVOaFP7kxmPWw7DsVVri0GF5j+XVfzoV88PCs9F3RWAFmS8oRrKp1Gj2Q1r6EO0M+tdasKfrKOi0c4BEujLgz5pXRtGyAc0f6g6uPDDQ8vl+jyXK45YgKkVHy0nMsTiRGlP6LhdHiupXx8fdQgbZNREOmfup2tra4Cq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4248adc62e0so34091945ab.2
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 13:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758572666; x=1759177466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtSPXQPfZzam6Ek8Z1D3cpcTA781XX5zjw8YCXOn29Y=;
        b=aWvpjxUZMMCpYONGdrFXtC/4g7vClXmn8M250aCLY94gAnmN2u6QpByQ2i6JlbrFRE
         goZETrbTIBIkJW5NmXAIUDIfIUGKY2nU4ANdnu+mfhvu3LHcExP7mp2/AzQa8CBTYZ3h
         i5dGKN1UYMip6lS3lGoRVs5Gr7LT8z77RmA0OoWiTRQui/vl03R1oz/UChQOybT7qHSd
         iK0tuRa5TJ0VDLQsiX4FaVDo5hgwKrsNQs3dHFFJ5qCHG8x+x0Eki0L0hT3Hw5VVCQpx
         2LD5Jhpryt2wu+VgMguMF1EN7VWYINEm6oACbJdawcfb47t9e+rUAjTk2eu54qqVW99F
         Q+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWHP7kH1cRDUo7f/mcwk7vovsf5S2rvvr/jJV2ihtxXmekK5lZP0hcX/jE4AWJu3atnX3+Ishc1GBIWZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIa80+f9tWyI9eoMir3fSuDUOUx9ODqGk7eUvTa3SkKID7e9X
	pJURuKrouaWqKZ+GajMq5A8cLEbzQaGahbAAPXeSLVwNEsMZ9olPf7X2NkFczfxLZBVdbJ/ZKSr
	yayxxOwGXjacH9uHQ6x6NRqU5PTlZQXkD6dFy5aqTJTNuaQ5bM1w41BUtvv0=
X-Google-Smtp-Source: AGHT+IFYIHDlQpyP/i7r0yXGFFk5gQm76dpdixv1uabTuCUvuXcdoZkkvJ7DLoYl/7X4t2lsUeopup+fFo5oqSco6s0zoQAJpD9U
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:424:515:43f2 with SMTP id
 e9e14a558f8ab-42581ebceb3mr3205975ab.26.1758572665718; Mon, 22 Sep 2025
 13:24:25 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:24:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d1b079.a70a0220.1b52b.0000.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in blk_mq_free_tags_callback
From: syzbot <syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c238e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=5c5d41e80248d610221f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155e427c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bb8142580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c53d48022f8a/disk-846bd222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483534e784c8/vmlinux-846bd222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/721b36eec9b3/bzImage-846bd222.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 5962 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: rcu_gp srcu_invoke_callbacks
RIP: 0010:__list_del_entry_valid_or_report+0x25/0x190 lib/list_debug.c:49
Code: 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 55 41 54 53 48 89 fb 49 bd 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 05 e8 af 58 47 fd 4c 8b 7b 08 48 89 d8 48 c1 e8
RSP: 0018:ffffc90003d2f8e8 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88802f573c80
RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000008
RBP: dffffc0000000000 R08: ffffffff8fe4db77 R09: 1ffffffff1fc9b6e
R10: dffffc0000000000 R11: ffffffff84b089f0 R12: 1ffff11004cb1e1f
R13: dffffc0000000000 R14: ffff88802658f0a0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881257a2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055946acdc950 CR3: 000000007a708000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:132 [inline]
 __list_del_entry include/linux/list.h:223 [inline]
 list_del_init include/linux/list.h:295 [inline]
 blk_mq_free_tags_callback+0x5a/0x180 block/blk-mq-tag.c:593
 srcu_invoke_callbacks+0x208/0x450 kernel/rcu/srcutree.c:1807
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x25/0x190 lib/list_debug.c:49
Code: 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 55 41 54 53 48 89 fb 49 bd 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 05 e8 af 58 47 fd 4c 8b 7b 08 48 89 d8 48 c1 e8
RSP: 0018:ffffc90003d2f8e8 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88802f573c80
RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000008
RBP: dffffc0000000000 R08: ffffffff8fe4db77 R09: 1ffffffff1fc9b6e
R10: dffffc0000000000 R11: ffffffff84b089f0 R12: 1ffff11004cb1e1f
R13: dffffc0000000000 R14: ffff88802658f0a0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881257a2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055946acdc950 CR3: 000000007a708000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	f3 0f 1e fa          	endbr64
   9:	41 57                	push   %r15
   b:	41 56                	push   %r14
   d:	41 55                	push   %r13
   f:	41 54                	push   %r12
  11:	53                   	push   %rbx
  12:	48 89 fb             	mov    %rdi,%rbx
  15:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  1c:	fc ff df
  1f:	48 83 c7 08          	add    $0x8,%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 05                	je     0x36
  31:	e8 af 58 47 fd       	call   0xfd4758e5
  36:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
  3a:	48 89 d8             	mov    %rbx,%rax
  3d:	48                   	rex.W
  3e:	c1                   	.byte 0xc1
  3f:	e8                   	.byte 0xe8


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
