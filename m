Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE70182BC
	for <linux-block@vger.kernel.org>; Sat, 31 May 2025 01:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748655400; cv=none; b=U10QAGGM1F01G4TDXNeu1Id3tjzCED4VterRg/fkgyYIOkMzqoiB0o17Rbw9pzOon89Q9RIZBEI75KWjvatvEeIWtjrhr/EPHBOHDslR+QFU6H8igb3rCRY+KVGgUYUCuBZxsoQXYntyYaEhcv92JzPPIKnJfyHhVVAtLq4HhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748655400; c=relaxed/simple;
	bh=NDbcqiotW/Z0gxJopkCIMaEX69V/79WqKi4k5TSIVBY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BuEUuEmkhwG8xFsRE2KcpiUIKTtw2TRIob0YmjiPZonXEwpjCTiAbT/+umHKbJBcjCZDqT1QLF22274wbJApzqaVmumVv5iCFL57QbN6ZINHLPJNx8z+27l4srQTcS0M2TAWSdrxC7OwyQapC8MMmD9tTtEyuOagG4O8KeDXMts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86d0aa2dc99so60856839f.1
        for <linux-block@vger.kernel.org>; Fri, 30 May 2025 18:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748655397; x=1749260197;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glgCJaTFbFLoXNg9qggTj7EXnYTQ0NdygohSikmt3oY=;
        b=m2Qx2oimLbRAtGOtOB66ViN7LlCWhYW17VaLhd0SViWW16lxIPgDkgTgMvCZs0Ds6y
         zm2+sZPh2EI9oLhKhxgChctv7tkI4mEa/stxDmujJWKQZhqqEyDdF0/kggNX1L+ttV4l
         RL5sF10JM7L2fcOYbjya02va0WK8jwA4dvaZgZoj7kh2WRrsEU0qoPPMqPDwLNz/IgWg
         UyYrDp696vI6L+6zDKlko0h0cl3Soza+w6OjLCFM+AqnvLrWhLQkbQdt3EIeu6aQiL6a
         mmYGAShdOvc/yzcuo4075yr/O2FbsSsWOHgwJJwtVkJwdMvaGe3FCnyAtoQZK4b6jguK
         rd3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUV86y+vVWC3RWYFNn2QR7tg76bgHyDQs4A3XisVd9p1Sh7Skjax2SYYaNelemJc5suIpJ8kizB0yc6KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5y4ybiq0974hFKcXM6lVaLvyw3b9k+kT7jQ3v7SBAUU7uI5H
	I9llgj4aHa5cyh5zxtD9eM6wOc4ZeZTuVqnmOoANj37Ut6mKG7ObkD/J4qFLHdJm4MHShSEgnP8
	H3N8f0jRkZII0ebIytZElZuRzlw5PTbZ7g/str/vtE91QIeksTCjlTOpvoJk=
X-Google-Smtp-Source: AGHT+IFRhMxJeWZGKpLKfEoXgRotd0us3i4+zShDoeEGLUBYz4xz/GhOCEy2hiMBTXHGkSmyMyAarjxK2+Tn6QGkkLsZmchh3HFF
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3810:b0:3dc:90fc:282d with SMTP id
 e9e14a558f8ab-3dd9cbd3f78mr38787245ab.16.1748655397360; Fri, 30 May 2025
 18:36:37 -0700 (PDT)
Date: Fri, 30 May 2025 18:36:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683a5d25.a00a0220.68b4a.0002.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in elevator_change
From: syzbot <syzbot+ccae337393ac17091c34@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    785cdec46e92 Merge tag 'x86-core-2025-05-25' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d026d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7ed3189f3c3d3f3
dashboard link: https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156e7882580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101c3170580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af5446d375b0/disk-785cdec4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb59d48f91fb/vmlinux-785cdec4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/188617605a08/bzImage-785cdec4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccae337393ac17091c34@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.15.0-syzkaller-01958-g785cdec46e92 #0 Not tainted
------------------------------------------------------
syz-executor347/5865 is trying to acquire lock:
ffff888142f38fa8 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x103/0x400 block/elevator.c:677

but task is already holding lock:
ffff888142f38a70 (&q->q_usage_counter(io)#55){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:205

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(io)#55){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x175/0x290 block/blk-mq.c:4396
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4443
       nbd_dev_add+0x4a0/0xbc0 drivers/block/nbd.c:1933
       nbd_init+0x181/0x320 drivers/block/nbd.c:2670
       do_one_initcall+0x120/0x6e0 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1567
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4060 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4074
       might_alloc include/linux/sched/mm.h:318 [inline]
       prepare_alloc_pages+0x162/0x610 mm/page_alloc.c:4742
       __alloc_frozen_pages_noprof+0x18b/0x23f0 mm/page_alloc.c:4963
       __alloc_pages_noprof+0xb/0x1b0 mm/page_alloc.c:5008
       __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
       alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
       pcpu_alloc_pages mm/percpu-vm.c:95 [inline]
       pcpu_populate_chunk+0x110/0xb00 mm/percpu-vm.c:285
       pcpu_alloc_noprof+0x86a/0x1470 mm/percpu.c:1870
       xt_percpu_counter_alloc+0x13e/0x1b0 net/netfilter/x_tables.c:1931
       find_check_entry.constprop.0+0xbc/0x9b0 net/ipv4/netfilter/ip_tables.c:526
       translate_table+0xc98/0x1720 net/ipv4/netfilter/ip_tables.c:716
       ipt_register_table+0x102/0x430 net/ipv4/netfilter/ip_tables.c:1742
       iptable_raw_table_init+0x63/0x90 net/ipv4/netfilter/iptable_raw.c:49
       xt_find_table_lock+0x2e1/0x520 net/netfilter/x_tables.c:1260
       xt_request_find_table_lock+0x28/0xf0 net/netfilter/x_tables.c:1285
       get_info+0x190/0x610 net/ipv4/netfilter/ip_tables.c:963
       do_ipt_get_ctl+0x169/0xa10 net/ipv4/netfilter/ip_tables.c:1659
       nf_getsockopt+0x7c/0xe0 net/netfilter/nf_sockopt.c:116
       ip_getsockopt+0x18c/0x1e0 net/ipv4/ip_sockglue.c:1777
       tcp_getsockopt+0x9e/0x100 net/ipv4/tcp.c:4727
       do_sock_getsockopt+0x3ff/0x800 net/socket.c:2357
       __sys_getsockopt+0x123/0x1b0 net/socket.c:2386
       __do_sys_getsockopt net/socket.c:2393 [inline]
       __se_sys_getsockopt net/socket.c:2390 [inline]
       __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2390
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (pcpu_alloc_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       pcpu_alloc_noprof+0xb4a/0x1470 mm/percpu.c:1782
       init_alloc_hint lib/sbitmap.c:16 [inline]
       sbitmap_init_node+0x2fd/0x770 lib/sbitmap.c:126
       sbitmap_queue_init_node+0x41/0x560 lib/sbitmap.c:438
       bt_alloc block/blk-mq-tag.c:542 [inline]
       blk_mq_init_tags+0x12d/0x2b0 block/blk-mq-tag.c:565
       blk_mq_alloc_rq_map block/blk-mq.c:3538 [inline]
       blk_mq_alloc_map_and_rqs+0x237/0xf60 block/blk-mq.c:4094
       blk_mq_sched_alloc_map_and_rqs block/blk-mq-sched.c:386 [inline]
       blk_mq_init_sched+0x30c/0x610 block/blk-mq-sched.c:485
       elevator_switch+0x1e1/0x7f0 block/elevator.c:595
       elevator_change+0x2ac/0x400 block/elevator.c:679
       elevator_set_default+0x292/0x320 block/elevator.c:737
       blk_register_queue+0x393/0x4f0 block/blk-sysfs.c:879
       __add_disk+0x74a/0xf00 block/genhd.c:524
       add_disk_fwnode+0x13f/0x5d0 block/genhd.c:593
       add_disk include/linux/blkdev.h:764 [inline]
       nbd_dev_add+0x791/0xbc0 drivers/block/nbd.c:1963
       nbd_init+0x181/0x320 drivers/block/nbd.c:2670
       do_one_initcall+0x120/0x6e0 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1567
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&q->elevator_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       elevator_change+0x103/0x400 block/elevator.c:677
       elv_iosched_store+0x2eb/0x3a0 block/elevator.c:792
       queue_attr_store+0x276/0x320 block/blk-sysfs.c:805
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x354/0x510 fs/kernfs/file.c:334
       iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
       do_splice_from fs/splice.c:935 [inline]
       direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
       splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
       do_splice_direct_actor fs/splice.c:1201 [inline]
       do_splice_direct+0x174/0x240 fs/splice.c:1227
       do_sendfile+0xb06/0xe50 fs/read_write.c:1370
       __do_sys_sendfile64 fs/read_write.c:1431 [inline]
       __se_sys_sendfile64 fs/read_write.c:1417 [inline]
       __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1417
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#55

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#55);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#55);
  lock(&q->elevator_lock);

 *** DEADLOCK ***

6 locks held by syz-executor347/5865:
 #0: ffff8880365d0428 (sb_writers#7){.+.+}-{0:0}, at: splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
 #1: ffff8880694ac488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x510 fs/kernfs/file.c:325
 #2: ffff888141f30b48 (kn->active#59){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b2/0x510 fs/kernfs/file.c:326
 #3: ffff888026444188 (&set->update_nr_hwq_lock){.+.+}-{4:4}, at: elv_iosched_store+0x337/0x3a0 block/elevator.c:790
 #4: ffff888142f38a70 (&q->q_usage_counter(io)#55){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:205
 #5: ffff888142f38aa8 (&q->q_usage_counter(queue)#7){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:205

stack backtrace:
CPU: 1 UID: 0 PID: 5865 Comm: syz-executor347 Not tainted 6.15.0-syzkaller-01958-g785cdec46e92 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2046
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
 elevator_change+0x103/0x400 block/elevator.c:677
 elv_iosched_store+0x2eb/0x3a0 block/elevator.c:792
 queue_attr_store+0x276/0x320 block/blk-sysfs.c:805
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x354/0x510 fs/kernfs/file.c:334
 iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
 do_splice_from fs/splice.c:935 [inline]
 direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
 splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x174/0x240 fs/splice.c:1227
 do_sendfile+0xb06/0xe50 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64 fs/read_write.c:1417 [inline]
 __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f705a0b5f59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc11bbeec8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f705a0b5f59
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffc11bbea30 R09: 00007ffc11bbea30
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffc11bbef00 R14: 00007ffc11bbef40 R15: 0000000000000000
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
