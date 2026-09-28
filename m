Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62640EB8D
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632488; cv=none; b=GnQ7IC621UBv01vBaA/VoGlrmiP+X6YntbhruZaC6yFVwyirskLhLezIsFTPXVHjBzIl8GUoy93V0kxwObmBAozGfwnYH4AvBVquowg7ltV9ZlQX8EmEHLvsKR9CdgFacjUb7AzDQF0vRBRG9csoQc7SqQzTY/tvHPdsBP/SKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632488; c=relaxed/simple;
	bh=F/lYJq93HE3KTkDMJDD1Xx9Dsvnevs2QAzx6ZjMsIA0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gaKlzIdByWypOeJohdb4wmoG3O0QAsCUvMYiC/kKikJ26+dDhh8TTXbhcryTls9wpmFIZPks+OGedBp1eDEli4N7wBzrr7wxhPAXMy5g6JftkQlTU0oOqWmrO4//LY/DJb8WlSsnEb1ZK4edP35IcL846NoHqMfBo6EcL4DncMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a45b3f0bdfso6095251b6e.1
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 14:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790632486; x=1791237286;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ck1aEFhy8Ab2Jarz1ZL0rFiozc8SHcmEaFtnwSHvuZU=;
        b=NDMZ69kUX5/yRM5t5AFwykF930PTM6S3CikI+IYJy84c9nTm1wzv3e4hr7bJuBzOJy
         bHepiIZz5WST6UIKRDPzyJM1lXB2EaXqYsSs7CegtSBLUui51xJpulP5lPrHCRR1oOxH
         7yaNXLiMmEKr+/xssDT0VfoNwmlvbLyvq1f1LWtjzqvPVAHp/zw/7KTeTeakWu9yhs2B
         o1thtHhwczl1eFjoKujw1bBS/SNb2FQDl0IrgyOLbIHq1GvkFHyOF21vZngLZIJrcO3x
         nguGPuWrPKLM204Jm4XtkcbiOVH8KiPZRZ9fUAJQLIAEYgtomDsgc3jYyk/CQNmkh4++
         tC7g==
X-Forwarded-Encrypted: i=1; AKwUvBwheAlbnf+1+LmD8U5+KlfXEIOVBpIG8YHlBC9iRRdxT77vVFt9C9f+30LQ18BrDvyaxrNMNqiIaVV/pA==@vger.kernel.org
X-Gm-Message-State: AFuF++k6PxtYlKlSQLdGyaTJBdC8/bJf0QhzAaoEZlvKs4c+7n3dRXR4
	xZ7HrS17Aa4uEG1XpjYhG65iekZWWNyjkIbMAN+TFKwei/p6kKQFWNB8zzmVOrqqQaEU5sCohCF
	sW+vhAMgR1dCnoSbG3v0isCedWNDng60QpSt2PiJOe2Po1dkOURdeUt/OxLQ=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:50a9:b0:4b9:e65b:8c34 with SMTP id
 5614622812f47-4d72aa5b00dmr16932936b6e.34.1790632485787; Mon, 28 Sep 2026
 14:54:45 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:54:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abae225.69bd487b.a6f8c.0009.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_revalidate_disk_zones
From: syzbot <syzbot+b0910be96b7c31314822@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f5f84daefcd9 Add linux-next specific files for 20260925
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1630ce05580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be00179930e43a43
dashboard link: https://syzkaller.appspot.com/bug?extid=b0910be96b7c31314822
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168dcac9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15627605580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e42cbc7060af/disk-f5f84dae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e80a7ee494ac/vmlinux-f5f84dae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f41cc55a1308/bzImage-f5f84dae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0910be96b7c31314822@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/u8:10/3352 is trying to acquire lock:
ffff88801fae6450 (&disk->zone_revalidate_mutex){+.+.}-{4:4}, at: blk_revalidate_disk_zones+0x1c5/0x1650 block/blk-zoned.c:2560

but task is already holding lock:
ffff88802ac3a5a0 (&q->q_usage_counter(io)#75){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
ffff88802ac3a5a0 (&q->q_usage_counter(io)#75){++++}-{0:0}, at: nvme_update_ns_info+0x3ac/0x1200 drivers/nvme/host/core.c:2583

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(io)#75){++++}-{0:0}:
       blk_alloc_queue+0x544/0x690 block/blk-core.c:504
       __blk_alloc_disk+0xe3/0x1d0 block/genhd.c:1527
       nvme_mpath_alloc_disk+0x5c2/0x8b0 drivers/nvme/host/multipath.c:769
       nvme_alloc_ns_head drivers/nvme/host/core.c:4049 [inline]
       nvme_init_ns_head drivers/nvme/host/core.c:4153 [inline]
       nvme_alloc_ns drivers/nvme/host/core.c:4267 [inline]
       nvme_scan_ns+0x2e22/0x46c0 drivers/nvme/host/core.c:4483
       async_run_entry_fn+0x9d/0x430 kernel/async.c:129
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4365 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4379
       might_alloc include/linux/sched/mm.h:316 [inline]
       slab_pre_alloc_hook mm/slub.c:4673 [inline]
       slab_alloc_node mm/slub.c:5011 [inline]
       __kmalloc_cache_node_noprof+0x66/0x620 mm/slub.c:5695
       _kmalloc_node_noprof include/linux/slab.h:1196 [inline]
       alloc_worker kernel/workqueue.c:2853 [inline]
       init_rescuer+0x167/0x530 kernel/workqueue.c:6002
       workqueue_init+0x214/0x680 kernel/workqueue.c:8517
       kernel_init_freeable+0x26b/0x3e0 init/main.c:1658
       kernel_init+0x22/0x1d0 init/main.c:1563
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (wq_pool_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       __alloc_workqueue+0xe8d/0x21d0 kernel/workqueue.c:6201
       alloc_workqueue_va kernel/workqueue.c:6253 [inline]
       alloc_workqueue_noprof+0xe3/0x210 kernel/workqueue.c:6269
       disk_alloc_zone_resources block/blk-zoned.c:2101 [inline]
       blk_revalidate_disk_zones+0x8d1/0x1650 block/blk-zoned.c:2575
       null_add_dev+0x12b8/0x1d70 drivers/block/null_blk/main.c:2056
       nullb_device_power_store+0x240/0x380 drivers/block/null_blk/main.c:511
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&disk->zone_revalidate_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       blk_revalidate_disk_zones+0x1c5/0x1650 block/blk-zoned.c:2560
       nvme_mpath_revalidate_zones+0x106/0x1c0 drivers/nvme/host/multipath.c:301
       nvme_update_ns_info+0x984/0x1200 drivers/nvme/host/core.c:2620
       nvme_alloc_ns drivers/nvme/host/core.c:4293 [inline]
       nvme_scan_ns+0x34c1/0x46c0 drivers/nvme/host/core.c:4483
       async_run_entry_fn+0x9d/0x430 kernel/async.c:129
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  &disk->zone_revalidate_mutex --> fs_reclaim --> &q->q_usage_counter(io)#75

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#75);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#75);
  lock(&disk->zone_revalidate_mutex);

 *** DEADLOCK ***

locks held by kworker/u8:10/3352: 4, last CPU#0:
 #0: ffff88801c29b948 ((wq_completion)async){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801c29b948 ((wq_completion)async){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801c29b948 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3460 [inline]
 #0: ffff88801c29b948 ((wq_completion)async){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3578
 #1: ffffc9000f277c40 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000f277c40 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000f277c40 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3460 [inline]
 #1: ffffc9000f277c40 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3578
 #2: ffff88802ac3a5a0 (&q->q_usage_counter(io)#75){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 #2: ffff88802ac3a5a0 (&q->q_usage_counter(io)#75){++++}-{0:0}, at: nvme_update_ns_info+0x3ac/0x1200 drivers/nvme/host/core.c:2583
 #3: ffff88802ac3a5d8 (&q->q_usage_counter(queue)#58){+.+.}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 #3: ffff88802ac3a5d8 (&q->q_usage_counter(queue)#58){+.+.}-{0:0}, at: nvme_update_ns_info+0x3ac/0x1200 drivers/nvme/host/core.c:2583

stack backtrace:
CPU: 0 UID: 0 PID: 3352 Comm: kworker/u8:10 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: async async_run_entry_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
 blk_revalidate_disk_zones+0x1c5/0x1650 block/blk-zoned.c:2560
 nvme_mpath_revalidate_zones+0x106/0x1c0 drivers/nvme/host/multipath.c:301
 nvme_update_ns_info+0x984/0x1200 drivers/nvme/host/core.c:2620
 nvme_alloc_ns drivers/nvme/host/core.c:4293 [inline]
 nvme_scan_ns+0x34c1/0x46c0 drivers/nvme/host/core.c:4483
 async_run_entry_fn+0x9d/0x430 kernel/async.c:129
 process_one_work kernel/workqueue.c:3495 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
nvmet: Created nvm controller 9 for subsystem testsubsys for NQN nqn.2014-08.org.nvmexpress:uuid:5dcefdd2-eda3-4d66-a2a4-c36f6ffd95da.
nvmet: Created nvm controller 14 for subsystem testsubsys for NQN nqn.2014-08.org.nvmexpress:uuid:5dcefdd2-eda3-4d66-a2a4-c36f6ffd95da.
nvmet: Created nvm controller 33 for subsystem testsubsys for NQN nqn.2014-08.org.nvmexpress:uuid:5dcefdd2-eda3-4d66-a2a4-c36f6ffd95da.
nvmet: Created nvm controller 35 for subsystem testsubsys for NQN nqn.2014-08.org.nvmexpress:uuid:5dcefdd2-eda3-4d66-a2a4-c36f6ffd95da.
nvmet: Created nvm controller 36 for subsystem testsubsys for NQN nqn.2014-08.org.nvmexpress:uuid:5dcefdd2-eda3-4d66-a2a4-c36f6ffd95da.
nvmet: Created nvm controller 38 for subsystem testsubsys for NQN nqn.2014-08.org.nvmexpress:uuid:5dcefdd2-eda3-4d66-a2a4-c36f6ffd95da.
nvmet: Created nvm controller 48 for subsystem testsubsys for NQN nqn.2014-08.org.nvmexpress:uuid:5dcefdd2-eda3-4d66-a2a4-c36f6ffd95da.
nvmet: Created nvm controller 68 for subsystem testsubsys for NQN nqn.2014-08.org.nvmexpress:uuid:5dcefdd2-eda3-4d66-a2a4-c36f6ffd95da.


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
