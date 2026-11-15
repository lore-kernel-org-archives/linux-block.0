Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753324;
	b=IUXyiOCfOwc5vJhRDaQC4rTW9UvWs+UHIF7BGi6oqRyjP3KkNRIkJOOjDkOqakMWzJnC
	 bOR64ULx3SCbHbSkJWP86wi5YLDx98diRMA8GWcUwIT8ACEQjXDFgXlAeDtnmDpNOFda3
	 2gANFELXj0wQjhozKeBziQmyiANbB6tZIMU2u4AHj4MBInBAor8pJ8oELodet0AqkbM6T
	 Xlhw8vC/8ybpEebngZCaHi39ZqM+Pvx0K7pOhKG7tnvVfvQbOJVhyCjSPAU17geCVPdnK
	 Af6XJiys8s0DsCnKYDvHJfVKtbKC/nQOGJvYAOcdREfgns4mc89AOqEEs7y0G27aQog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753324;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=ZR+ct1BlyfsQpj8tJxWd+p0AnYqKGIjonighQ8kjDfI=;
	b=xnOBLGIh9I5MsK63FYIy2laGYHirUltiWR3aIrYPxXoL2cJ8JPjjn1n4EAsaxCjspkdC
	 nqr/MALywikOTA7ASVtNMUs+N4ffk0AgD5NrMsY0o8nrEtYgXdNJBigGLfuDaTxT6ayw7
	 FBq0oPpzptS2Dr0RN7opTwCpjDePGwhqNt+XCp0IuBWIVwn2Cew96li2y/w51o69ltEej
	 zOUxYXEFfBU7JE+X9CtSh3NOqYdQuAPG0fFxJ5pshtdCKN67oyioyO4V0UWURobAas2tp
	 wQyUWyxtM6MWHt4K4VTqZAwFO1OcKx0Jt57axfwpZ8iwM8yo45r2NwypKeDfQlXryWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45F606A31E
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 14:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D45F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b597558c4cso3038374b6e.1
        for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 06:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794753323; x=1795358123;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZR+ct1BlyfsQpj8tJxWd+p0AnYqKGIjonighQ8kjDfI=;
        b=eAFDFwMM6ZtmdpwrBh5vMhFl/6jR+ZjKuarLWxlsXwAfbIhrqx6iXKm47qvvXRTbng
         4PAWQbOQnD94oOK8k/4HCQa7omzVtChkaO4byXiBSehmjP075ulaFcE7N1B/DTGog5Of
         a4P44flKFUNfey8t341LDTvmcqb81DHnxcW5ks1F44ReFNefPf16X/Z2df0nGlQFE0g8
         9XczMjfg2nxo2AL/+o0sYQoqUivEv3m8QWLPVJmD2x2vVVLstNiaFhjAemsR7F4Zj1ku
         ucMQ+G+xDzJLArAFciYpCGhYCdmoSSu/4kJd4MD+Tc5kIA3ESzILxenPN19p8uCzFxFG
         f8BA==
X-Forwarded-Encrypted: i=1; AL+hErHjZetsCzxOghE+Uy6U/lNIZGa7UlARmXjMqJuId/Per/CeXUFDOCAXCSeAQXJHByKPX+rHtIA5wfX+rQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/G1kAROLkG3i1k7CqbHpvqaw0Bj8xXU+o+/lbry5IA1OX18v6s
	QGG8lm5qWWHfR8d6ciRTcoGEe2TE5jlqxq10QxzdQ6wxbA8zeLEDjcVJ7oFaDMvRynjNndd9MIZ
	hhVf+2tXVyHXWtyD8NntwMaMjC34dDWdqWSV9w5PdZDQ0qcn6EJjYeYIVsAw=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c211:b0:53c:8f0e:ee3e with SMTP id
 5614622812f47-56e647dead7mr6941205b6e.36.1794753323551; Sun, 15 Nov 2026
 06:35:23 -0800 (PST)
Date: Sun, 15 Nov 2026 06:35:23 -0800
In-Reply-To: <6ae67a19.6552420f.2a0efc.001e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af9c32b.84fe3b82.798c4.0003.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in wbt_init_enable_default
From: syzbot <syzbot+e2e1def00b1be94f0a22@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    23c62304dde2 Merge tag 'for-linus-7.4a-rc3-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152e564d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cf189394a856f11
dashboard link: https://syzkaller.appspot.com/bug?extid=e2e1def00b1be94f0a22
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17944d3d580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-23c62304.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f7bce229a50/vmlinux-23c62304.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a152fd539c6/bzImage-23c62304.xz

AI-generated root cause summary:
A race between disk registration in dm_setup_md_queue() and concurrent device
removal (dm_destroy() -> blk_mark_disk_dead()) causes the queue freeze lockdep
state tracking in block/blk-mq.c and block/blk.h to become inconsistent.
Although rq_qos_add() freezes and subsequently unfreezes the queue during
wbt_init_enable_default(), blk_unfreeze_release_lock() skips releasing
q->io_lockdep_map because the disk was concurrently marked dead/dying. When
wbt_init_enable_default() immediately proceeds to acquire q->debugfs_mutex,
lockdep detects an apparent circular locking dependency against the leaked
lockdep map. In production kernels without CONFIG_LOCKDEP, the queue is properly
unfrozen and no deadlock or memory corruption occurs.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=e2e1def00b1be94f0a22

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2e1def00b1be94f0a22@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.1.1969/12485 is trying to acquire lock:
ffff88803a2da498 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_debugfs_lock_nomemsave block/blk.h:816 [inline]
ffff88803a2da498 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_debugfs_lock block/blk.h:830 [inline]
ffff88803a2da498 (&q->debugfs_mutex){+.+.}-{4:4}, at: wbt_init_enable_default+0xf6/0x170 block/blk-wbt.c:794

but task is already holding lock:
ffff88803a2d9c50 (&q->q_usage_counter(io)#1954){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:206

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(io)#1954){++++}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       blk_alloc_queue+0x610/0x790 block/blk-core.c:505
       __blk_alloc_disk+0xa0/0x170 block/genhd.c:1527
       alloc_dev drivers/md/dm.c:2349 [inline]
       dm_create+0x5e8/0x1530 drivers/md/dm.c:2563
       dev_create+0x121/0x2a0 drivers/md/dm-ioctl.c:977
       ctl_ioctl+0x4d2/0xcc0 drivers/md/dm-ioctl.c:2221
       dm_ctl_ioctl+0x22/0x30 drivers/md/dm-ioctl.c:2243
       vfs_ioctl fs/ioctl.c:52 [inline]
       __do_sys_ioctl fs/ioctl.c:598 [inline]
       __se_sys_ioctl fs/ioctl.c:584 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:584
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __fs_reclaim_acquire mm/page_alloc.c:4375 [inline]
       fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4389
       might_alloc include/linux/sched/mm.h:316 [inline]
       slab_pre_alloc_hook mm/slub.c:4673 [inline]
       slab_alloc_node mm/slub.c:5011 [inline]
       kmem_cache_alloc_lru_noprof+0x5f/0x6a0 mm/slub.c:5066
       __d_alloc+0x34/0xad0 fs/dcache.c:1967
       d_alloc+0x4a/0x1e0 fs/dcache.c:2053
       lookup_one_qstr_excl+0x171/0x250 fs/namei.c:1812
       __start_dirop fs/namei.c:2926 [inline]
       start_dirop+0x59/0xb0 fs/namei.c:2948
       simple_start_creating+0xf9/0x110 fs/libfs.c:2281
       debugfs_start_creating.part.0+0x7b/0x150 fs/debugfs/inode.c:397
       debugfs_start_creating fs/debugfs/inode.c:371 [inline]
       debugfs_create_dir+0x6c/0x440 fs/debugfs/inode.c:575
       regulator_init+0x97/0x180 drivers/regulator/core.c:6787
       do_one_initcall+0x11c/0x6f0 init/main.c:1419
       do_initcall_level init/main.c:1481 [inline]
       do_initcalls init/main.c:1497 [inline]
       do_basic_setup init/main.c:1517 [inline]
       kernel_init_freeable+0x6ea/0x7b0 init/main.c:1732
       kernel_init+0x21/0x1e0 init/main.c:1622
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (&sb->s_type->i_mutex_key#3/1){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       down_write_nested+0x8f/0x1f0 kernel/locking/rwsem.c:1757
       inode_lock_nested include/linux/fs.h:1072 [inline]
       __start_dirop fs/namei.c:2924 [inline]
       start_dirop+0x4b/0xb0 fs/namei.c:2948
       simple_start_creating+0xf9/0x110 fs/libfs.c:2281
       debugfs_start_creating.part.0+0x7b/0x150 fs/debugfs/inode.c:397
       debugfs_start_creating fs/debugfs/inode.c:371 [inline]
       debugfs_create_dir+0x6c/0x440 fs/debugfs/inode.c:575
       blk_register_queue+0x199/0x640 block/blk-sysfs.c:968
       __add_disk+0x7dd/0xf10 block/genhd.c:531
       add_disk_fwnode+0x279/0x480 block/genhd.c:604
       add_disk include/linux/blkdev.h:799 [inline]
       brd_alloc.isra.0+0x5ab/0x820 drivers/block/brd.c:340
       brd_init+0x167/0x190 drivers/block/brd.c:420
       do_one_initcall+0x11c/0x6f0 init/main.c:1419
       do_initcall_level init/main.c:1481 [inline]
       do_initcalls init/main.c:1497 [inline]
       do_basic_setup init/main.c:1517 [inline]
       kernel_init_freeable+0x6ea/0x7b0 init/main.c:1732
       kernel_init+0x21/0x1e0 init/main.c:1622
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&q->debugfs_mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19f/0x1c10 kernel/locking/mutex.c:821
       blk_debugfs_lock_nomemsave block/blk.h:816 [inline]
       blk_debugfs_lock block/blk.h:830 [inline]
       wbt_init_enable_default+0xf6/0x170 block/blk-wbt.c:794
       blk_register_queue+0x4b8/0x640 block/blk-sysfs.c:995
       __add_disk+0x7dd/0xf10 block/genhd.c:531
       add_disk_fwnode+0x118/0x480 block/genhd.c:600
       add_disk include/linux/blkdev.h:799 [inline]
       dm_setup_md_queue+0x1e2/0x550 drivers/md/dm.c:2632
       table_load+0x4e8/0x7b0 drivers/md/dm-ioctl.c:1661
       ctl_ioctl+0x4d2/0xcc0 drivers/md/dm-ioctl.c:2221
       dm_ctl_ioctl+0x22/0x30 drivers/md/dm-ioctl.c:2243
       vfs_ioctl fs/ioctl.c:52 [inline]
       __do_sys_ioctl fs/ioctl.c:598 [inline]
       __se_sys_ioctl fs/ioctl.c:584 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:584
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->debugfs_mutex --> fs_reclaim --> &q->q_usage_counter(io)#1954

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#1954);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#1954);
  lock(&q->debugfs_mutex);

 *** DEADLOCK ***

locks held by syz.1.1969/12485: 6, on CPU#2:
 #0: ffff888059796190 (&md->type_lock){+.+.}-{4:4}, at: table_load+0x22d/0x7b0 drivers/md/dm-ioctl.c:1644
 #1: ffff8880597960e8 (&md->table_devices_lock){+.+.}-{4:4}, at: dm_setup_md_queue+0x1ab/0x550 drivers/md/dm.c:2631
 #2: ffff8880464629c0 (&set->update_nr_hwq_lock){++++}-{4:4}, at: add_disk_fwnode+0x107/0x480 block/genhd.c:599
 #3: ffff88803a2da200 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_register_queue+0x10a/0x640 block/blk-sysfs.c:965
 #4: ffff88803a2d9c50 (&q->q_usage_counter(io)#1954){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:206
 #5: ffff88803a2d9c88 (&q->q_usage_counter(queue)#63){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:206

stack backtrace:
CPU: 2 UID: 0 PID: 12485 Comm: syz.1.1969 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x19f/0x1c10 kernel/locking/mutex.c:821
 blk_debugfs_lock_nomemsave block/blk.h:816 [inline]
 blk_debugfs_lock block/blk.h:830 [inline]
 wbt_init_enable_default+0xf6/0x170 block/blk-wbt.c:794
 blk_register_queue+0x4b8/0x640 block/blk-sysfs.c:995
 __add_disk+0x7dd/0xf10 block/genhd.c:531
 add_disk_fwnode+0x118/0x480 block/genhd.c:600
 add_disk include/linux/blkdev.h:799 [inline]
 dm_setup_md_queue+0x1e2/0x550 drivers/md/dm.c:2632
 table_load+0x4e8/0x7b0 drivers/md/dm-ioctl.c:1661
 ctl_ioctl+0x4d2/0xcc0 drivers/md/dm-ioctl.c:2221
 dm_ctl_ioctl+0x22/0x30 drivers/md/dm-ioctl.c:2243
 vfs_ioctl fs/ioctl.c:52 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1219da94d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f121aca8028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f121a025fa0 RCX: 00007f1219da94d9
RDX: 0000200000000380 RSI: 00000000c138fd09 RDI: 0000000000000004
RBP: 00007f1219e3804e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f121a026038 R14: 00007f121a025fa0 R15: 00007ffd63a60148
 </TASK>
device-mapper: ioctl: device has been removed from the dev hash table.
