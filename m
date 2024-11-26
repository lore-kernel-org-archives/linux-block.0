Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D83D6D
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732596870; cv=none; b=dAIZ851tFGdJ2GjtRMlmU96LuliqsM90yEQJAnmRZB+un6ZtIz6qiqA3RbeHqQE7tfs/FpaDxEm7lnBaxTrUT7KyzHUN/z5lSdNy0O8PMprFf7eIMnagBFokOXtBuVzQsCzFlSi9IvVjQQVEJFFm9P9EqOIdrcPUIKgoAHIbHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732596870; c=relaxed/simple;
	bh=1O9fY8jhM8nBBCJU9jVRPUmnYrASxtLbAIuZKP20xQo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VthgbDgSWs6kvaFFd6OGgZgqr51pFjPGMaaugreKGDglQCte6a4UsGcJALYvQmo5+LB8nuQXxPt29xIXFDR/RuDTf9F3nEBO3le5rE9rGnwK+kAZObtD1ZrgpMvr6F8geoTQrWnKtlqT+TO1o72ENoU3dpp40x9nLLBa2fEgaoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so58758815ab.2
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 20:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732596868; x=1733201668;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysG09FAB291UDo3HdSz88MSyqqPDsH7EAVYh+xkseYs=;
        b=mUV1kxiiJ41olnKC+pUrRx8AgSwIyWaZp+S8Ue+RzGSRqAuhhPd9jgQN7iscdthc9S
         U2jq+Z6ab3tfYOIIlzj8nEMR2zC0lf4LJs/d8uFOEoSNoX5W/8JNtGoC4RFTF6EdNNpu
         Bfx+Lw5kc3TMm/MXNDEOrV3GSm5jwnBO582+dYBVovr0XhaJYdMWOREkV+zWwjlTHHYR
         AI+nRwE1Sq88w99GFTYbaM/3emGcuDtamrj8knt87wWu2hHZl47rUDwZWQJ8a1UPKFno
         x8nxCflinNjttqgRo5uqMsNwBvQ213yOa8MX6p4WIpB+zLdNw+Oh1Z5o9y3SZ4Huszbc
         Wo3g==
X-Forwarded-Encrypted: i=1; AJvYcCW5OuXR/8uOrj8FFNod9hEvqnBQ+wzD7vv6vE4BRPyshtJh4JODE7J14tvYwFQcR1nwSHg5HnuJt2AvRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaHHHnGF7j7jXdMi51Bd/SSej7AYg9SrBFg1zcubfJDgCc+6NC
	gPaoVu1f/6kMqT6UovbX9drAe8jzcjdQhuWUtg9NWsvBprv6+2Bokb/ur5Ut4450LvyMxW2KFP9
	vTPkYFKNjcrKtbx7fKwBHAdqV42Vh5K3qJMLBn+Mua/eeYHV10PBIRl4=
X-Google-Smtp-Source: AGHT+IHpIxQY1E1ryo9vjaXyTN8FeeeaPeUbjL4qHpD8Drljtun5oQQmclkSs0sAh4JWsEMrRTNG4xub62eyLD0YSrWJBGWsXFnR
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54c:0:b0:3a7:7ee3:108d with SMTP id
 e9e14a558f8ab-3a79afd5844mr194129115ab.23.1732596867996; Mon, 25 Nov 2024
 20:54:27 -0800 (PST)
Date: Mon, 25 Nov 2024 20:54:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67455483.050a0220.1286eb.000f.GAE@google.com>
Subject: [syzbot] [block?] BUG: unable to handle kernel paging request in
 try_to_wake_up (2)
From: syzbot <syzbot+b7cf50a0c173770dcb14@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3022e9d00ebe Merge tag 'sched_ext-for-6.12-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151a4ce8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=b7cf50a0c173770dcb14
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee91c87bfb88/disk-3022e9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ec61801436b/vmlinux-3022e9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6feec591f6fa/bzImage-3022e9d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7cf50a0c173770dcb14@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffbfff46e2b8d
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffe4067 P4D 23ffe4067 PUD 23ffe3067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 40 Comm: kworker/0:1H Not tainted 6.12.0-rc7-syzkaller-00012-g3022e9d00ebe #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: kblockd blk_mq_requeue_work
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x82/0x290 mm/kasan/generic.c:189
Code: 01 00 00 00 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 4c 89 cd 48 f7 d5 48 01 dd <41> 80 3b 00 0f 85 c9 01 00 00 49 ff c3 48 ff c5 75 ee e9 1e 01 00
RSP: 0018:ffffc90000b07320 EFLAGS: 00010086
RAX: 0000000001e89001 RBX: 1ffffffff46e2b8d RCX: ffffffff81705a7b
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffa3715c68
RBP: ffffffffffffffff R08: ffffffffa3715c6f R09: 1ffffffff46e2b8d
R10: dffffc0000000000 R11: fffffbfff46e2b8d R12: ffff888020ef0000
R13: ffff888020ef0ad8 R14: dffffc0000000001 R15: fffffbfff46e2b8e
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff46e2b8d CR3: 000000004f6fe000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 __lock_acquire+0xc8b/0x2050 kernel/locking/lockdep.c:5172
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:606
 raw_spin_rq_lock kernel/sched/sched.h:1506 [inline]
 rq_lock kernel/sched/sched.h:1805 [inline]
 ttwu_queue kernel/sched/core.c:3951 [inline]
 try_to_wake_up+0x81e/0x14b0 kernel/sched/core.c:4281
 swake_up_locked kernel/sched/swait.c:29 [inline]
 swake_up_one+0x70/0x160 kernel/sched/swait.c:52
 rcu_report_unblock_qs_rnp kernel/rcu/tree.c:2376 [inline]
 rcu_preempt_deferred_qs_irqrestore+0x9f8/0xc70 kernel/rcu/tree_plugin.h:568
 rcu_read_unlock_special+0x497/0x570 kernel/rcu/tree_plugin.h:692
 __rcu_read_unlock+0xa1/0x110 kernel/rcu/tree_plugin.h:437
 blk_mq_run_hw_queues+0x2b6/0x360 block/blk-mq.c:2292
 blk_mq_requeue_work+0x8b1/0x900 block/blk-mq.c:1477
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: fffffbfff46e2b8d
---[ end trace 0000000000000000 ]---
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x82/0x290 mm/kasan/generic.c:189
Code: 01 00 00 00 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 4c 89 cd 48 f7 d5 48 01 dd <41> 80 3b 00 0f 85 c9 01 00 00 49 ff c3 48 ff c5 75 ee e9 1e 01 00
RSP: 0018:ffffc90000b07320 EFLAGS: 00010086
RAX: 0000000001e89001 RBX: 1ffffffff46e2b8d RCX: ffffffff81705a7b
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffa3715c68
RBP: ffffffffffffffff R08: ffffffffa3715c6f R09: 1ffffffff46e2b8d
R10: dffffc0000000000 R11: fffffbfff46e2b8d R12: ffff888020ef0000
R13: ffff888020ef0ad8 R14: dffffc0000000001 R15: fffffbfff46e2b8e
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff46e2b8d CR3: 000000004f6fe000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 7 bytes skipped:
   0:	df 4f 8d             	fisttps -0x73(%rdi)
   3:	3c 31                	cmp    $0x31,%al
   5:	4c 89 fd             	mov    %r15,%rbp
   8:	4c 29 dd             	sub    %r11,%rbp
   b:	48 83 fd 10          	cmp    $0x10,%rbp
   f:	7f 29                	jg     0x3a
  11:	48 85 ed             	test   %rbp,%rbp
  14:	0f 84 3e 01 00 00    	je     0x158
  1a:	4c 89 cd             	mov    %r9,%rbp
  1d:	48 f7 d5             	not    %rbp
  20:	48 01 dd             	add    %rbx,%rbp
* 23:	41 80 3b 00          	cmpb   $0x0,(%r11) <-- trapping instruction
  27:	0f 85 c9 01 00 00    	jne    0x1f6
  2d:	49 ff c3             	inc    %r11
  30:	48 ff c5             	inc    %rbp
  33:	75 ee                	jne    0x23
  35:	e9                   	.byte 0xe9
  36:	1e                   	(bad)
  37:	01 00                	add    %eax,(%rax)


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
