Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2363A257AC7
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708986; cv=none; b=TeIbkplKNHXIvwxkEKWubeqCzAhIZWMfnqyRpl4OE1ILTRoe6AXAOhWaFKEsumyyFm9X+1FwxmYCJgqFjog0+nYu++Zb0hTWEJqSbJIZDpNF8xE5dbqrZTDtQREfZBXvhZJNTWlOeD8gIjIaatX2KXaKDLICuJIQgOJJg67kCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708986; c=relaxed/simple;
	bh=IzGHnbSKy9QS28KDdwSYE4m4fHdzMc0buR92jwueS2g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZkUwqs6mAeTg1nDzbaUSEUmhayV5QUXOzeInbwu1615okwX+ttAZ1qvf9rkITKc+0X4ap5FsT0QIY/dpnYjTDegNebMPqD31phjSd0lPSKVNSgVQDkx6UVJ46R5BT0YdRgMRutBnfaNdkLJGyHQN1L39b1SysElGL7N060272Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d43d1df18bso15742915ab.0
        for <linux-block@vger.kernel.org>; Thu, 03 Apr 2025 12:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743708984; x=1744313784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ3vF3m261vLwIGTgD2U8hST9APCzsBh/6KFnvzeTHw=;
        b=EHgezb3I1ARWIbdQjLnjCuZ7hyUS2zyhWMpXgLWdVQHYP3n3wEDckb6WdN/sgGlRWV
         pFNWq9Ggx4YKpdMbt/K+5wdqzUy7iugCBRGTDMe64Hkl5HeUiqRN+WEcSxR2+7VMlXZs
         Ww+uEZj1Iweva9sCKsg8fQSlNCPrXicoMnFHC6cLPi39YaxIsVVPpFQOQd7TeeXfqlfL
         SV+vCAMsmUZqcfstvHyPyWnTZrF9i1eq9kxMb1uvyw23DutciNXHpli10kW6iWlu2e2E
         oYilUo4sDyWkQ0rrr4ratnMaGEbbdgMF4wYSP40JNzGmGFO4maaKlFN9UmtQxfcTilsB
         O2mw==
X-Forwarded-Encrypted: i=1; AJvYcCVAiUYwLuxCQ/7YyPg7HY13C83V8NWRdlDGe5w9K18iGZMJja8DVfw4Qi446TdSRldLW9bpO+ctg/b5yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqaI8pj4zTzOQD4vsgOkD4dG9Wg3W/D9H4IwcaY1WDZ65+U1rh
	Nl0dzBnu4SDr8vc6fLXTflenSWJzuO86jeFAKCGjgKXFi0x7VS96B7P+18Hao8kJKC1fbbjuGuR
	A9XJgKnbgfn+X5i5GFwuee1il+CmyLgl4EKJJpPMDASAGkLYNJqSF4Ww=
X-Google-Smtp-Source: AGHT+IFJUL7typZLI0KSHwcfJtAx+NqjslqbL9muBeS23N3HxZtVZBSO7PXl5314so18bhdFEyEoj1ZjmPUyYsSVSFFBQfASanfo
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:300a:b0:3d2:aa73:7b7a with SMTP id
 e9e14a558f8ab-3d6e535c466mr561315ab.12.1743708984060; Thu, 03 Apr 2025
 12:36:24 -0700 (PDT)
Date: Thu, 03 Apr 2025 12:36:24 -0700
In-Reply-To: <6743b30d.050a0220.1cc393.004e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67eee338.050a0220.9040b.023b.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_update_nr_hw_queues
From: syzbot <syzbot+6279b273d888c2017726@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a2cc6ff5ec8f Merge tag 'firewire-updates-6.15' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1007f7b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adffebefc9feb9d6
dashboard link: https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12202fb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1417e94c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-a2cc6ff5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebd4f463c5cb/vmlinux-a2cc6ff5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/91fd93bd91b3/bzImage-a2cc6ff5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6279b273d888c2017726@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-syzkaller-12966-ga2cc6ff5ec8f #0 Not tainted
------------------------------------------------------
syz-executor876/5939 is trying to acquire lock:
ffff8880261b2318 (&q->elevator_lock){+.+.}-{4:4}, at: blk_mq_elv_switch_none block/blk-mq.c:4942 [inline]
ffff8880261b2318 (&q->elevator_lock){+.+.}-{4:4}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:5022 [inline]
ffff8880261b2318 (&q->elevator_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x4a9/0x1360 block/blk-mq.c:5074

but task is already holding lock:
ffff8880261b1de8 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave block/blk-mq.c:215 [inline]
ffff8880261b1de8 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:5014 [inline]
ffff8880261b1de8 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: blk_mq_update_nr_hw_queues+0x263/0x1360 block/blk-mq.c:5074

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x179/0x290 block/blk-mq.c:4349
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4396
       nbd_dev_add+0x49d/0xbb0 drivers/block/nbd.c:1933
       nbd_init+0x181/0x320 drivers/block/nbd.c:2670
       do_one_initcall+0x120/0x6e0 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1567
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4028 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4042
       might_alloc include/linux/sched/mm.h:318 [inline]
       xa_insert include/linux/xarray.h:783 [inline]
       blk_mq_init_hctx block/blk-mq.c:3924 [inline]
       blk_mq_alloc_and_init_hctx+0x503/0x11c0 block/blk-mq.c:4457
       blk_mq_realloc_hw_ctxs+0x8f6/0xc00 block/blk-mq.c:4486
       blk_mq_init_allocated_queue+0x3af/0x1230 block/blk-mq.c:4540
       blk_mq_alloc_queue+0x1c2/0x290 block/blk-mq.c:4353
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4396
       loop_add+0x496/0xb70 drivers/block/loop.c:2067
       loop_init+0x164/0x270 drivers/block/loop.c:2302
       do_one_initcall+0x120/0x6e0 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1567
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&q->elevator_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain kernel/locking/lockdep.c:3909 [inline]
       __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
       lock_acquire kernel/locking/lockdep.c:5866 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       blk_mq_elv_switch_none block/blk-mq.c:4942 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5022 [inline]
       blk_mq_update_nr_hw_queues+0x4a9/0x1360 block/blk-mq.c:5074
       nbd_start_device+0x172/0xcd0 drivers/block/nbd.c:1476
       nbd_start_device_ioctl drivers/block/nbd.c:1527 [inline]
       __nbd_ioctl drivers/block/nbd.c:1602 [inline]
       nbd_ioctl+0x219/0xda0 drivers/block/nbd.c:1642
       blkdev_ioctl+0x274/0x6d0 block/ioctl.c:698
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#49

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#49);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#49);
  lock(&q->elevator_lock);

 *** DEADLOCK ***

4 locks held by syz-executor876/5939:
 #0: ffff8880261c3998 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_ioctl+0x150/0xda0 drivers/block/nbd.c:1635
 #1: ffff8880261c38d8 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x8e/0x1360 block/blk-mq.c:5073
 #2: ffff8880261b1de8 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave block/blk-mq.c:215 [inline]
 #2: ffff8880261b1de8 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:5014 [inline]
 #2: ffff8880261b1de8 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: blk_mq_update_nr_hw_queues+0x263/0x1360 block/blk-mq.c:5074
 #3: ffff8880261b1e20 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave block/blk-mq.c:215 [inline]
 #3: ffff8880261b1e20 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:5014 [inline]
 #3: ffff8880261b1e20 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_update_nr_hw_queues+0x263/0x1360 block/blk-mq.c:5074

stack backtrace:
CPU: 3 UID: 0 PID: 5939 Comm: syz-executor876 Not tainted 6.14.0-syzkaller-12966-ga2cc6ff5ec8f #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2079
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain kernel/locking/lockdep.c:3909 [inline]
 __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
 blk_mq_elv_switch_none block/blk-mq.c:4942 [inline]
 __blk_mq_update_nr_hw_queues block/blk-mq.c:5022 [inline]
 blk_mq_update_nr_hw_queues+0x4a9/0x1360 block/blk-mq.c:5074
 nbd_start_device+0x172/0xcd0 drivers/block/nbd.c:1476
 nbd_start_device_ioctl drivers/block/nbd.c:1527 [inline]
 __nbd_ioctl drivers/block/nbd.c:1602 [inline]
 nbd_ioctl+0x219/0xda0 drivers/block/nbd.c:1642
 blkdev_ioctl+0x274/0x6d0 block/ioctl.c:698
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe4217ab4a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe73ad6c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffe73ad6df8 RCX: 00007fe4217ab4a9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 00007fe42181e610 R08: 00007ffe73ad6df8 R09: 00007ffe73ad6df8
R10: 00007ffe73ad6df8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe73ad6de8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
