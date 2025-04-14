Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B802283688
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628847; cv=none; b=a+4rkqpg4KugDllP4aN9ZH9/9CekYpUIbSYvxAZLLKCVHVfrkrdwui9zIFlr+q342QtBvzRh23uavs5U5CCq1Ea0E2ZVxC/5Cz1cp/vsLIlBWHUF32MruvA2FlgskivMB9VtD3xzgZF4r9z5OGWEF+55YlKLpg/jpbG0O9krZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628847; c=relaxed/simple;
	bh=G7TF4q7dZRaiEscsGkoiTtlH96Gu3YAx3lP58fif8+Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qiro6WascZoeyd5UAoFFxy09Xmmz4ZUZnqgYkUMGYmy0xXAowhEt1C52PVmgdLkin8WrsoGopaCqpD7Oge57mq0iIp41NV4u1aweP4xBNoeW5FYWIX67Wv4ZEFUA2p4q7lQPZziAjLKqmuP9uuBsLCsyYxj8WdgWHBNZz7rgNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d5bb1708e4so46750875ab.3
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 04:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628844; x=1745233644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcf+ERrLGDY27q9rz4Z2xEgCWwkHIxm/gM/aEPEcN6c=;
        b=tJNRHcfoZVCN5e4/aUAIxu84z5FelvZk7zrMYA4ONuUXFDzs0vVqkWxdkyZqFU1bbU
         VI+/jS9A2cf3B0VXdAeljInOhCW1CzY1ci7j8J296MmjEPPnfw7QNNiwYbgIF4yYen/K
         XTVNWzNwb1kDNwrEgEUTpsuHkluQui4T8KasCSuMPBRLs9Mlo0mTCTQH3yIo7dAXZ7EG
         uHoO/PTzGyywGSrMMKfhaOuGWEeXIBykWtUWTHz+MSIDQdZm5HS0C7iqllKu1XT6Helu
         0LGGqb+koxOQaoov44Ds8BSg/B30Q96kixUssmw+ATChoU2H5QLTxqu7/482CGaxUH2y
         KF1A==
X-Forwarded-Encrypted: i=1; AJvYcCXdmcVVUEA1XI8AYTS8+etzfTKT6mP7HA82jNsyKAXNRk9Bin1fDdfUjoCxLzK+TJctqLKQhGcAg7qdCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj67pfcaRaAV3mTXPbBpHgHhfOMafPnc2uKeJnmPNeLg9CZxJX
	s4D3lI54cbU1bUpCfbDOdcauHnDyx0XoNvyKbYzG/1ZuzS4gtR0ZOvjznefO9UW+RsRWThJIFjA
	atZF0R+go1i1vU3FUokML0CfwU72fK07k1SJPX7c5mn26mSalVZ/rewU=
X-Google-Smtp-Source: AGHT+IEoZWsHnF8N1MfzQODaqss8ETR3MjQbePJOcN0Rc70Cbyx6GhWc9RfLq9oiv3uSbJr1tJehq9R8t05J8xyyxjHb6XzNhb4Q
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1888:b0:3d4:244b:db20 with SMTP id
 e9e14a558f8ab-3d7ec265c11mr109601905ab.16.1744628844017; Mon, 14 Apr 2025
 04:07:24 -0700 (PDT)
Date: Mon, 14 Apr 2025 04:07:23 -0700
In-Reply-To: <67f097e0.050a0220.0a13.022a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fcec6b.050a0220.3483fc.0027.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in queue_wb_lat_store
From: syzbot <syzbot+5a9d5d7faa80fa15e3db@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8ffd015db85f Linux 6.15-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a66a3f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae323da55fbd6522
dashboard link: https://syzkaller.appspot.com/bug?extid=5a9d5d7faa80fa15e3db
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ecdf4c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123420cc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b7a7f5609ad8/disk-8ffd015d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c8cb2488367a/vmlinux-8ffd015d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c99e36835459/bzImage-8ffd015d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a9d5d7faa80fa15e3db@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor134/5835 is trying to acquire lock:
ffff8880260c0f98 (&q->elevator_lock){+.+.}-{4:4}, at: queue_wb_lat_store+0x187/0x3d0 block/blk-sysfs.c:596

but task is already holding lock:
ffff8880260c0a68 (&q->q_usage_counter(io)#62){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#62){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x179/0x290 block/blk-mq.c:4348
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4395
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
       slab_pre_alloc_hook mm/slub.c:4102 [inline]
       slab_alloc_node mm/slub.c:4180 [inline]
       kmem_cache_alloc_noprof+0x53/0x3b0 mm/slub.c:4207
       __kernfs_new_node+0xd2/0x8a0 fs/kernfs/dir.c:637
       kernfs_new_node+0x13c/0x1e0 fs/kernfs/dir.c:713
       kernfs_create_dir_ns+0x4c/0x1a0 fs/kernfs/dir.c:1081
       sysfs_create_dir_ns+0x13a/0x2b0 fs/sysfs/dir.c:59
       create_dir lib/kobject.c:73 [inline]
       kobject_add_internal+0x2c4/0x9b0 lib/kobject.c:240
       kobject_add_varg lib/kobject.c:374 [inline]
       kobject_add+0x16e/0x240 lib/kobject.c:426
       elv_register_queue+0xd3/0x2a0 block/elevator.c:462
       blk_register_queue+0x37e/0x500 block/blk-sysfs.c:874
       add_disk_fwnode+0x911/0x13a0 block/genhd.c:505
       add_disk include/linux/blkdev.h:779 [inline]
       nbd_dev_add+0x78e/0xbb0 drivers/block/nbd.c:1963
       nbd_init+0x181/0x320 drivers/block/nbd.c:2670
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
       queue_wb_lat_store+0x187/0x3d0 block/blk-sysfs.c:596
       queue_attr_store+0x270/0x310 block/blk-sysfs.c:799
       sysfs_kf_write+0xef/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x351/0x510 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:591 [inline]
       vfs_write+0x5ba/0x1180 fs/read_write.c:684
       ksys_write+0x12a/0x240 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#62

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#62);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#62);
  lock(&q->elevator_lock);

 *** DEADLOCK ***

6 locks held by syz-executor134/5835:
 #0: ffff88802ae609b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2a2/0x370 fs/file.c:1213
 #1: ffff888024454420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x240 fs/read_write.c:736
 #2: ffff888033450088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x510 fs/kernfs/file.c:325
 #3: ffff888140fb55a8 (kn->active#47){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b2/0x510 fs/kernfs/file.c:326
 #4: ffff8880260c0a68 (&q->q_usage_counter(io)#62){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215
 #5: ffff8880260c0aa0 (&q->q_usage_counter(queue)#14){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215

stack backtrace:
CPU: 1 UID: 0 PID: 5835 Comm: syz-executor134 Not tainted 6.15.0-rc2-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
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
 queue_wb_lat_store+0x187/0x3d0 block/blk-sysfs.c:596
 queue_attr_store+0x270/0x310 block/blk-sysfs.c:799
 sysfs_kf_write+0xef/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x351/0x510 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x5ba/0x1180 fs/read_write.c:684
 ksys_write+0x12a/0x240 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f217454ee39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f21744e8218 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f21745d8318 RCX: 00007f217454ee39
RDX: 00000000fffffdef RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f21745d8310 R08: 00007ffee7802e27 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f21745a6004
R13: 0000200000000150 R14: 0000200000000140 R15: 00000000fffffdef
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
