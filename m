Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8F2F744C
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824091; cv=none; b=Il+1poXGA+f2UUC0tBBnlpodmNYiDCtniT8xa5bygs4o5nEYW0jtUaNAd4Mo/iQSZ+M+/Q2mgyB/2NzMgey26GmgID8q6hX9LVEPS9Tak4TK4w6AJTn3phbkUK+4GaMhbMEUOx4iVnrbhPZ7q5IbSJh/+ER38sS5sBK/9i17vac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824091; c=relaxed/simple;
	bh=4mNRDK0udOU7z0Z89PU+wrdMa307/ikR3aK53nZH9Cg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GN7zaMZ1u3VgN9A5vRp3ZzSKTDotH93+IlfuZH5mC8VkXggM/5n0qCYYIW/EEIx+zc+8NMnfaQ1uhhPJYJ6s9Z/sHWhhlotu334QtkYRZ0+wLSH/1C6rF1P90YFRhurj5ELeGviIGQ6bzDNYvMl21WeTonarmc0daG2gVgVl0BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ee1d164774so72388825ab.1
        for <linux-block@vger.kernel.org>; Tue, 02 Sep 2025 07:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824089; x=1757428889;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/5JWzgvXCWK6jYp7RBORfP6Epn9/qkHRz9kION0DM4=;
        b=EV98ZeOCtRk3GS3hAlXjigKqTkZlRmuuzFmcVeXAPJdOVh8gF0W/1z/BL9ZkXxZ1dG
         RW7h/xsUe2GhXzKr+irIs+dS1bRLxiQMOplfZYUjODq/MKdEy9nAmIrUfcJdspqTtKD8
         d1fBDdbRLNbTw8vkgt22LK2Ipqns4cCLLhL1moeYD0sG/SJDApLZT9lQonrI66zr7p2u
         CrezH3o5kJtqkxstOc7lYF6UaE7sJS/n10m9GsvkMR1JAWsLXI5E5yxESchWdXGRKEVM
         IFz9k/cXl6GpFKjkRMQQrLNl9F9/Lx61s3ixbemnGuxYPlcZwxZ6EJrAeXmKahz8Kl82
         wCsA==
X-Forwarded-Encrypted: i=1; AJvYcCUTMk3JxX+FIeQ+Tdom6v5FT4EjX/1TyG0tkIrx+re5KddFXdtvTRHIsTRHp8D3ZfAK1PFCw5hhwufgkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2khFDrkaG7H28qROE092im/7zfhLUac40gyIlPebF/T06/Jgv
	gpN9mux70ZktyWTaJs5+4JM9uqLY51tKoZNUHjAHiTJV66QbSbXra9kuyx/bh57YpSESex1WJ8m
	tIGismkSjQf2/Y7sGzB6DZqQb9g3Ms0e5aXy0eqQxdJeqmc4S5EA7w+tCchk=
X-Google-Smtp-Source: AGHT+IGhPWpx2cUi9fYTwQKECTaLcmbeLI5iD67ghTJGxyd0JULrHR0UwRjnM1auyoIIVB5SL5zDhwlGh2nEJuf65sdqJiTIinUX
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ca:b0:3f6:5ea4:f0a3 with SMTP id
 e9e14a558f8ab-3f65ea4f0b3mr1493415ab.11.1756824088951; Tue, 02 Sep 2025
 07:41:28 -0700 (PDT)
Date: Tue, 02 Sep 2025 07:41:28 -0700
In-Reply-To: <6871117d.a00a0220.26a83e.004c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b70218.050a0220.3db4df.01d1.GAE@google.com>
Subject: Re: [syzbot] [block?] [mm?] INFO: rcu detected stall in wb_workfn (4)
From: syzbot <syzbot+5b4f4f81240931b16844@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b320789d6883 Linux 6.17-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1406ae62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=5b4f4f81240931b16844
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133b5e34580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1639ca42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/daf1f6c847dd/disk-b320789d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fbeb0bd5d987/vmlinux-b320789d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a85084f8e16b/bzImage-b320789d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b4f4f81240931b16844@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P1288/1:b.el P5851/1:b..l
rcu: 	(detected by 0, t=11117 jiffies, g=9285, q=859 ncpus=2)
task:udevd           state:R  running task     stack:27176 pid:5851  tgid:5851  ppid:5218   task_flags:0x400140 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:7145
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 wp_page_copy mm/memory.c:3653 [inline]
 do_wp_page+0x177b/0x4f00 mm/memory.c:4013
 handle_pte_fault mm/memory.c:6068 [inline]
 __handle_mm_fault+0x1b2d/0x2a50 mm/memory.c:6195
 handle_mm_fault+0x589/0xd10 mm/memory.c:6364
 do_user_addr_fault+0x60c/0x1370 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x5c/0xb0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f5c948b5db7
RSP: 002b:00007ffd6b822260 EFLAGS: 00010202
RAX: 0000000000006010 RBX: 00000000000001f0 RCX: 000055b18d0b4fe0
RDX: 0000000000006010 RSI: 000055b18d0aefd0 RDI: 00007f5c949f1ac0
RBP: 00007f5c949f1ac0 R08: 00000000000001f0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000055b18d0aefd0
R13: 00007f5c949f1ac0 R14: 00000000000001f0 R15: 00007f5c949f1ac0
 </TASK>
task:kworker/u8:5    state:R  running task     stack:22344 pid:1288  tgid:1288  ppid:2      task_flags:0x24248060 flags:0x00004000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__sanitizer_cov_trace_switch+0x7f/0x90 kernel/kcov.c:336
Code: 39 de 75 e2 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 41 bd 07 00 00 00 48 83 f8 40 74 be 5b 5d 41 5c 41 5d 41 5e e9 91 66 db 09 <41> bd 01 00 00 00 eb a9 41 bd 05 00 00 00 eb a1 90 90 90 90 90 90
RSP: 0018:ffffc90004d1e918 EFLAGS: 00000246
RAX: 0000000000000008 RBX: ffff888029fc9a50 RCX: ffffffff863bcae4
RDX: ffff888028ca2440 RSI: ffffffff8c136f20 RDI: 0000000000000000
RBP: ffffffff8c136f20 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888029fc9a48 R14: ffff888027e99000 R15: ffffc90004d1eb60
 blk_mq_dispatch_rq_list+0x428/0x1e20 block/blk-mq.c:2121
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
 __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
 blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
 blk_mq_run_hw_queue+0x349/0x670 block/blk-mq.c:2358
 blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2919
 blk_mq_flush_plug_list block/blk-mq.c:2967 [inline]
 blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2939
 blk_add_rq_to_plug+0x1ca/0x540 block/blk-mq.c:1390
 blk_mq_submit_bio+0x1a6b/0x2a10 block/blk-mq.c:3212
 __submit_bio+0x3cf/0x690 block/blk-core.c:635
 __submit_bio_noacct_mq block/blk-core.c:722 [inline]
 submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:751
 submit_bio_noacct+0xc20/0x1ed0 block/blk-core.c:874
 ext4_io_submit+0xa6/0x140 fs/ext4/page-io.c:404
 ext4_do_writepages+0xe42/0x3cf0 fs/ext4/inode.c:2951
 ext4_writepages+0x37a/0x7d0 fs/ext4/inode.c:3025
 do_writepages+0x27a/0x600 mm/page-writeback.c:2634
 __writeback_single_inode+0x160/0xfb0 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x60d/0xfa0 fs/fs-writeback.c:1976
 __writeback_inodes_wb+0xf8/0x2d0 fs/fs-writeback.c:2047
 wb_writeback+0x7f3/0xb70 fs/fs-writeback.c:2158
 wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
 wb_do_writeback fs/fs-writeback.c:2315 [inline]
 wb_workfn+0x8ca/0xbe0 fs/fs-writeback.c:2343
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: rcu_preempt kthread starved for 11117 jiffies! g9285 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27928 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 schedule_timeout+0x123/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1ea/0xb00 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x270/0x380 kernel/rcu/tree.c:2285
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 5513 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x8/0x20 kernel/kcov.c:314
Code: bf 03 00 00 00 e9 58 fe ff ff 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 0c 24 <89> f2 89 fe bf 05 00 00 00 e9 2a fe ff ff 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc90003277730 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffff8880b853fe80 RCX: ffffffff81af8ea1
RDX: ffff8880213e4880 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffed10170a7fd1 R14: 0000000000000001 R15: 0000000000000001
FS:  00007fd829003740(0000) GS:ffff8881246b8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9856c3ffdc CR3: 00000000782b2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 csd_lock_wait kernel/smp.c:342 [inline]
 smp_call_function_many_cond+0xe21/0x1600 kernel/smp.c:877
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1044
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x4a0/0x17a0 arch/x86/mm/tlb.c:1451
 dup_mmap+0xfa2/0x21d0 mm/mmap.c:1873
 dup_mm kernel/fork.c:1485 [inline]
 copy_mm kernel/fork.c:1537 [inline]
 copy_process+0x4081/0x7690 kernel/fork.c:2175
 kernel_clone+0xfc/0x930 kernel/fork.c:2605
 __do_sys_clone+0xce/0x120 kernel/fork.c:2748
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd8290d7636
Code: 89 df e8 6d e8 f6 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 52 89 c5 85 c0 75 31 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffc8dce2200 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffc8dce2208 RCX: 00007fd8290d7636
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffc8dd02750 R08: 0000000000000000 R09: 0000000000000001
R10: 00007fd829003a10 R11: 0000000000000246 R12: 00007ffc8dce2340
R13: 0000000000000000 R14: 0000000000000000 R15: 0000560acbd41ac0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
