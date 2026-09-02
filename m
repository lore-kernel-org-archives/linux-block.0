Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4D47DD71
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373537; cv=none; b=Wrasyk2YQ0IyxxXeRi11janrDU/SW4XJYCEA41IxKgQHTE06HYPRYnxjP4bIc1ip54wzlOwA6UofEh+FrKkGvjAcBJGk3Jec2ErHFbAZiQeGJe+Lml5Xybf3kM/bXQCF8Cd6Eo9eKQ3JAWIwtujFAOrRhRURHkuOpXwzsINlA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373537; c=relaxed/simple;
	bh=AAr6+E1y4y2pBBf5f/au/7TNHvKoFu+cwfQlgDm8heE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fVOU0A3T3O5Ntqh/xYsItziT4ggfdHAeSFvpw/+ON+Ci2GNF42CLVxqf0JSQuwz1NEeIK0RzCUOUzCyDIIW349OZKuumy24o5CwOdGLbqndf3LVExSzIhKJ3axAX1/YLCoyDm9XJ1DMsVpOyH2by05aIf9LfAWV9l51iJU7ghek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6b34e02c466so170263eaf.1
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 11:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373534; x=1788978334;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SnPbsxDO3W40hbAE1g6nz4DIsFHz/xmSs6V4dMsXXg=;
        b=meyc7vhcVcW7RZP20GZ0TJnkq0hYD3OM/ZdOPq2wMk0aTiqA6e8pd+oUOz+ptaPqwF
         FE6EWXWGs/OCie93NUx6HY3NtIcmHLA8mxMmHzk2AarpVydERV7GrHGLCitR3bjoJit7
         GgnJpmF9nUSRgo6G9st7ugAhiiQNkNXdkf7QDTfOQYp60uOmbiouifQNjqTC0WqgsmlP
         hou1FevaVxjCW7XM76BZXveajVRtoIGXD5CNWsj2E9w/cafQ2auGoDHkWYsfBSsgOAwp
         OCm1p/acLcLWzo7TMFbg6I/7F5NyaybMZZ8lk9l26vHin1VjHmlqhbjs9tkcY6VET0hO
         nwvQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUY2jEPVFC91gqVQfdE3Xg6lWEtWq8pQXigqGWHfgTk20TmTJcKDkg+RaD83h8hh+BDJqQqbZN/H+S6g==@vger.kernel.org
X-Gm-Message-State: AFuF++mMpeBTLeccqVUlKpiT1TixxOkKOQ6K+9EOSolwhCXyGMZ4ogT9
	fJ6ODZ3yBz70gQ8judXVrQYDocX/TYPphnr0UpBZ5NMHL3gQycmxgieWlEU/J/x/RTc/yvOCg+0
	eKPHctVy/Cg8B7EFm2mRr9No9WVPy+nOKjQWUaIjtzEBPNiNbf+B75e5ACjw=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a06:b0:6b1:a146:1297 with SMTP id
 006d021491bc7-6b582a61ba0mr1096925eaf.1.1788373534597; Wed, 02 Sep 2026
 11:25:34 -0700 (PDT)
Date: Wed, 02 Sep 2026 11:25:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a986a1e.27a413cd.1e878c.000e.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in queue_requests_store (3)
From: syzbot <syzbot+65e679ca2c660840635a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    45c13f3f9e3b Merge tag 'hwlock-v7.3' of git://git.kernel.o..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=1755ae25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6a4e008e57a0e64
dashboard link: https://syzkaller.appspot.com/bug?extid=65e679ca2c660840635a
compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-45c13f3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/de92b7834d98/vmlinux-45c13f3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cc3fde89c915/Image-45c13f3f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65e679ca2c660840635a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G        W    L     
------------------------------------------------------
syz.4.3610/13943 is trying to acquire lock:
ffff000015008580 (&q->elevator_lock){+.+.}-{4:4}, at: queue_requests_store+0x28c/0x4e0 block/blk-sysfs.c:124

but task is already holding lock:
ffff000015008060 (&q->q_usage_counter(io)#51){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x18/0x30 block/blk-mq.c:206

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&q->q_usage_counter(io)#51){++++}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x3d0/0x44c kernel/locking/lockdep.c:5843
       blk_alloc_queue+0x4e0/0x640 block/blk-core.c:504
       blk_mq_alloc_queue+0x148/0x224 block/blk-mq.c:4420
       __blk_mq_alloc_disk+0x20/0x120 block/blk-mq.c:4467
       null_add_dev+0x9bc/0x17a8 drivers/block/null_blk/main.c:2017
       null_create_dev drivers/block/null_blk/main.c:2114 [inline]
       null_init+0x248/0x2f4 drivers/block/null_blk/main.c:2178
       do_one_initcall+0x134/0xb20 init/main.c:1357
       do_initcall_level init/main.c:1419 [inline]
       do_initcalls init/main.c:1435 [inline]
       do_basic_setup init/main.c:1455 [inline]
       kernel_init_freeable+0x5ec/0x670 init/main.c:1670
       kernel_init+0x2c/0x14c init/main.c:1560
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854

-> #3 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x3d0/0x44c kernel/locking/lockdep.c:5843
       __fs_reclaim_acquire mm/page_alloc.c:4375 [inline]
       fs_reclaim_acquire+0x130/0x158 mm/page_alloc.c:4389
       might_alloc include/linux/sched/mm.h:316 [inline]
       slab_pre_alloc_hook mm/slub.c:4636 [inline]
       slab_alloc_node mm/slub.c:4974 [inline]
       __kmalloc_cache_node_noprof+0x6c/0x634 mm/slub.c:5578
       _kmalloc_node_noprof include/linux/slab.h:1196 [inline]
       __get_vm_area_node+0x118/0x2ec mm/vmalloc.c:3238
       __vmalloc_node_range_noprof+0x198/0x1024 mm/vmalloc.c:4065
       __vmalloc_node_noprof+0xe4/0x14c mm/vmalloc.c:4166
       vmalloc_noprof+0x24/0x30 mm/vmalloc.c:4201
       mtdblock_writesect+0x41c/0x5b8 drivers/mtd/mtdblock.c:242
       do_blktrans_request drivers/mtd/mtd_blkdevs.c:88 [inline]
       mtd_blktrans_work drivers/mtd/mtd_blkdevs.c:152 [inline]
       mtd_queue_rq+0x744/0x1694 drivers/mtd/mtd_blkdevs.c:179
       blk_mq_dispatch_rq_list+0x2e0/0x177c block/blk-mq.c:2117
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0x830/0xe60 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0x7c/0x114 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0xf0/0x278 block/blk-mq.c:2531
       process_one_work+0x830/0x1c00 kernel/workqueue.c:3387
       process_scheduled_works kernel/workqueue.c:3470 [inline]
       worker_thread+0x42c/0xc90 kernel/workqueue.c:3551
       kthread+0x2ec/0x384 kernel/kthread.c:436
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854

-> #2 (&new->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x3d0/0x44c kernel/locking/lockdep.c:5843
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x150/0x1530 kernel/locking/mutex.c:821
       mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:874
       mtd_blktrans_work drivers/mtd/mtd_blkdevs.c:151 [inline]
       mtd_queue_rq+0x2a4/0x1694 drivers/mtd/mtd_blkdevs.c:179
       blk_mq_dispatch_rq_list+0x2e0/0x177c block/blk-mq.c:2117
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0x830/0xe60 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0x7c/0x114 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0xf0/0x278 block/blk-mq.c:2531
       process_one_work+0x830/0x1c00 kernel/workqueue.c:3387
       process_scheduled_works kernel/workqueue.c:3470 [inline]
       worker_thread+0x42c/0xc90 kernel/workqueue.c:3551
       kthread+0x2ec/0x384 kernel/kthread.c:436
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854

-> #1 (set->srcu){.+.+}-{0:0}:
       lock_sync+0xf0/0x16c kernel/locking/lockdep.c:5934
       srcu_lock_sync include/linux/srcu.h:210 [inline]
       __synchronize_srcu+0xa8/0x280 kernel/rcu/srcutree.c:1462
       synchronize_srcu_expedited kernel/rcu/srcutree.c:1502 [inline]
       synchronize_srcu+0x168/0x7d0 kernel/rcu/srcutree.c:1558
       blk_mq_wait_quiesce_done block/blk-mq.c:284 [inline]
       blk_mq_wait_quiesce_done block/blk-mq.c:281 [inline]
       blk_mq_quiesce_queue block/blk-mq.c:304 [inline]
       blk_mq_quiesce_queue+0xf4/0x160 block/blk-mq.c:299
       elevator_switch+0x118/0x430 block/elevator.c:576
       elevator_change+0x294/0x420 block/elevator.c:681
       elevator_set_default+0x210/0x2b8 block/elevator.c:754
       blk_register_queue+0x36c/0x500 block/blk-sysfs.c:992
       __add_disk+0x510/0xb48 block/genhd.c:524
       add_disk_fwnode+0x110/0x3e0 block/genhd.c:593
       device_add_disk+0x14/0x20 block/genhd.c:623
       add_disk include/linux/blkdev.h:798 [inline]
       nbd_dev_add+0x5f8/0x9b4 drivers/block/nbd.c:2026
       nbd_init+0x190/0x1b0 drivers/block/nbd.c:2743
       do_one_initcall+0x134/0xb20 init/main.c:1357
       do_initcall_level init/main.c:1419 [inline]
       do_initcalls init/main.c:1435 [inline]
       do_basic_setup init/main.c:1455 [inline]
       kernel_init_freeable+0x5ec/0x670 init/main.c:1670
       kernel_init+0x2c/0x14c init/main.c:1560
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854

-> #0 (&q->elevator_lock){+.+.}-{4:4}:
       check_prev_add+0x114/0xca0 kernel/locking/lockdep.c:3181
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x13f4/0x1a5c kernel/locking/lockdep.c:5253
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x3d0/0x44c kernel/locking/lockdep.c:5843
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x150/0x1530 kernel/locking/mutex.c:821
       mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:874
       queue_requests_store+0x28c/0x4e0 block/blk-sysfs.c:124
       queue_attr_store+0x1f8/0x260 block/blk-sysfs.c:906
       sysfs_kf_write+0xc4/0x10c fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x2a4/0x460 fs/kernfs/file.c:345
       do_iter_readv_writev+0x3d8/0x6dc fs/read_write.c:828
       vfs_writev+0x258/0x6e8 fs/read_write.c:1058
       do_writev+0xfc/0x280 fs/read_write.c:1104
       __do_sys_writev fs/read_write.c:1172 [inline]
       __se_sys_writev fs/read_write.c:1169 [inline]
       __arm64_sys_writev+0x74/0xa4 fs/read_write.c:1169
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x74/0x240 arch/arm64/kernel/syscall.c:49
       el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:121
       do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:140
       el0_svc+0x58/0x2a4 arch/arm64/kernel/entry-common.c:758
       el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:777
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590

other info that might help us debug this:

Chain exists of:
  &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#51

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#51);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#51);
  lock(&q->elevator_lock);

 *** DEADLOCK ***

locks held by syz.4.3610/13943: 7, last CPU#0:
 #0: ffff00001466cef0 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x1e4/0x294 fs/file.c:1259
 #1: ffff00002894a460 (sb_writers#7){.+.+}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 #1: ffff00002894a460 (sb_writers#7){.+.+}-{0:0}, at: __sb_start_write include/linux/fs/super.h:19 [inline]
 #1: ffff00002894a460 (sb_writers#7){.+.+}-{0:0}, at: sb_start_write include/linux/fs/super.h:125 [inline]
 #1: ffff00002894a460 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2754 [inline]
 #1: ffff00002894a460 (sb_writers#7){.+.+}-{0:0}, at: vfs_writev+0x3c8/0x6e8 fs/read_write.c:1056
 #2: ffff000015b25c80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e4/0x460 fs/kernfs/file.c:336
 #3: ffff00001554ce18 (kn->active#61){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #3: ffff00001554ce18 (kn->active#61){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x22c/0x460 fs/kernfs/file.c:337
 #4: ffff0000155951f8 (&set->update_nr_hwq_lock){++++}-{4:4}, at: queue_requests_store+0xe4/0x4e0 block/blk-sysfs.c:88
 #5: ffff000015008060 (&q->q_usage_counter(io)#51){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x18/0x30 block/blk-mq.c:206
 #6: ffff000015008098 (&q->q_usage_counter(queue)#34){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x18/0x30 block/blk-mq.c:206

stack backtrace:
CPU: 0 UID: 0 PID: 13943 Comm: syz.4.3610 Tainted: G        W    L      syzkaller #0 PREEMPT 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x7c/0xb0 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_circular_bug+0x23c/0x284 kernel/locking/lockdep.c:2059
 check_noncircular+0x174/0x194 kernel/locking/lockdep.c:2191
 check_prev_add+0x114/0xca0 kernel/locking/lockdep.c:3181
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x13f4/0x1a5c kernel/locking/lockdep.c:5253
 lock_acquire kernel/locking/lockdep.c:5886 [inline]
 lock_acquire+0x3d0/0x44c kernel/locking/lockdep.c:5843
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x150/0x1530 kernel/locking/mutex.c:821
 mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:874
 queue_requests_store+0x28c/0x4e0 block/blk-sysfs.c:124
 queue_attr_store+0x1f8/0x260 block/blk-sysfs.c:906
 sysfs_kf_write+0xc4/0x10c fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x2a4/0x460 fs/kernfs/file.c:345
 do_iter_readv_writev+0x3d8/0x6dc fs/read_write.c:828
 vfs_writev+0x258/0x6e8 fs/read_write.c:1058
 do_writev+0xfc/0x280 fs/read_write.c:1104
 __do_sys_writev fs/read_write.c:1172 [inline]
 __se_sys_writev fs/read_write.c:1169 [inline]
 __arm64_sys_writev+0x74/0xa4 fs/read_write.c:1169
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x74/0x240 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:140
 el0_svc+0x58/0x2a4 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590


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
