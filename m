Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CF1C1F21
	for <linux-block@vger.kernel.org>; Sat,  1 Mar 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740824306; cv=none; b=O3F2K2vDWCnZMiuQD8yJvn+rRRnJJxQsD4hvuToN87C9pA9/Pvesz+BnQ/rEMaUdoJJGnzsyKFLC5pboLm815EHdd0bJwhwIXhlaG7CIzc6ZQO4/vs8BrTqihWqkyBi+1EVOXJd089NoAmE0kVFwA6Elssuc9Sh/oI2+oWyhk2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740824306; c=relaxed/simple;
	bh=LF1NWYuexmvpdqvzdNC/2kacyxGX+sLWOyWcZnlUp0U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UDdh6l2pGfO16tZV1iQJnPBQ4zWHPIffMLFF2/pVAV1FxccF7dZNYR41BwlwL+1FvZt27MFwCvwmFa6z5o7OzezCI1bJBEsB5puhJGTVQk3yBeb35dKsHfID7luGxwZs91FV1p3gs1dsqGY4s1/P81d8jYJPsocOW989X9+2kPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d3d949fd42so57727145ab.3
        for <linux-block@vger.kernel.org>; Sat, 01 Mar 2025 02:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740824303; x=1741429103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EH2y93bHXj71Kw63Uw07BaiM6CAmoQ5kN7vXGKhg+xY=;
        b=J2mXex5oO7bfGA7th6EMibTF5agpuFJEr0rLSw5kdqJ9tmzCe3ukwsRqOUpuDuuV85
         XVvET7qIs8HW+XqAyeLEDaJawXnkSgBMNbnCSkP8yAfWIWsnIiEONDQcUmW2PhJCIVwe
         F+FCDXcIXBxOQZMjyOk9XMZO6LIIjcHmkluDnDwFaAi24hrFuTZrQErVFf1nUZnmqgr3
         aSBf945TpREA1wnUpu52VL4lmV3GVPQQvgXaAQNs4+I2OWB6gms/GUZIqgxDL+s81p/0
         1s9FfzBT3pnxGLsjWFKrWNWPPn5/wI6Z2D1pktqtUm3fQpk4At7ABqwcqEQkchCOM3O8
         YNfw==
X-Forwarded-Encrypted: i=1; AJvYcCXE8oV51iOaeB5umdjlaFazSO8uvgkVvoja65SZlVws8Ue4/Y+gV7ZclYnupBp6YZTnQxCm5UUaNrHxcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXHVaD3Whqh+oDQZhtbXDMPPpZtlSNNlCsfIRQd27MdrCT0BqY
	kCt+TuzgOr2U8Zygy5f2nZnOZZUXHokO7TNyB/OWUPbXvg5dUT4sTr1hQT75RoY/8s32BO+zWq0
	9uIoum05BwCbnhPfv5oOYpJLufNuzGaL+fAhIDNmW68RdZVLdfyaBWp8=
X-Google-Smtp-Source: AGHT+IFfCyXisaAb5rsYo6B7ZOu6Dc97mQA06+CoC+2ay7NJibVnlO0bfiPbWndfMwAO2pQCMEpjtOuCwPvkyChys6jkiCytOUdc
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2411:b0:3d3:ce83:527c with SMTP id
 e9e14a558f8ab-3d3e6e63990mr75804385ab.1.1740824303673; Sat, 01 Mar 2025
 02:18:23 -0800 (PST)
Date: Sat, 01 Mar 2025 02:18:23 -0800
In-Reply-To: <6741e9d0.050a0220.1cc393.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c2deef.050a0220.dc10f.0164.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_set_status
From: syzbot <syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    276f98efb64a Merge tag 'block-6.14-20250228' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f2c864580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b4c41bdaeea1964
dashboard link: https://syzkaller.appspot.com/bug?extid=9b145229d11aa73e4571
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106ac8b7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f2c864580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-276f98ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a036150d62e/vmlinux-276f98ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0b6c8e5972f/bzImage-276f98ef.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/de45c54e91e8/mount_2.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1259c5a8580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/ff2aa30ba41a/mount_7.gz
mounted in repro #3: https://storage.googleapis.com/syzbot-assets/cfbc483567aa/mount_9.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1772c864580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com

XFS (loop0): Quotacheck needed: Please wait.
XFS (loop0): Quotacheck: Done.
loop0: detected capacity change from 32768 to 32704
======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc4-syzkaller-00212-g276f98efb64a #0 Not tainted
------------------------------------------------------
syz-executor594/5306 is trying to acquire lock:
ffffffff9023b5a8 (uevent_sock_mutex){+.+.}-{4:4}, at: uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
ffffffff9023b5a8 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_net_broadcast+0x280/0x580 lib/kobject_uevent.c:410

but task is already holding lock:
ffff8880348c1c38 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:920 [inline]
ffff8880348c1c38 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: loop_set_status+0x213/0x800 drivers/block/loop.c:1277

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       bio_queue_enter block/blk.h:78 [inline]
       blk_mq_submit_bio+0x14e1/0x25d0 block/blk-mq.c:3091
       __submit_bio+0x2cf/0x6a0 block/blk-core.c:628
       __submit_bio_noacct_mq block/blk-core.c:715 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:744
       xfs_buf_submit_bio fs/xfs/xfs_buf.c:1558 [inline]
       xfs_buf_submit+0xa71/0xf40 fs/xfs/xfs_buf.c:1666
       _xfs_buf_read fs/xfs/xfs_buf.c:806 [inline]
       xfs_buf_read_map+0x40f/0xa50 fs/xfs/xfs_buf.c:873
       xfs_trans_read_buf_map+0x260/0xab0 fs/xfs/xfs_trans_buf.c:304
       xfs_trans_read_buf fs/xfs/xfs_trans.h:212 [inline]
       xfs_read_agf+0x2dc/0x630 fs/xfs/libxfs/xfs_alloc.c:3378
       xfs_alloc_read_agf+0x196/0xbe0 fs/xfs/libxfs/xfs_alloc.c:3413
       xfs_alloc_fix_freelist+0x608/0x1bc0 fs/xfs/libxfs/xfs_alloc.c:2877
       xfs_alloc_vextent_prepare_ag+0xf9/0x6b0 fs/xfs/libxfs/xfs_alloc.c:3543
       xfs_alloc_vextent_iterate_ags+0x141/0x950 fs/xfs/libxfs/xfs_alloc.c:3727
       xfs_alloc_vextent_start_ag+0x3f6/0x950 fs/xfs/libxfs/xfs_alloc.c:3816
       xfs_bmap_btalloc_best_length fs/xfs/libxfs/xfs_bmap.c:3764 [inline]
       xfs_bmap_btalloc fs/xfs/libxfs/xfs_bmap.c:3809 [inline]
       xfs_bmapi_allocate+0x1af5/0x3650 fs/xfs/libxfs/xfs_bmap.c:4222
       xfs_bmapi_write+0xb91/0x1b50 fs/xfs/libxfs/xfs_bmap.c:4551
       xfs_dquot_disk_alloc+0x5f4/0xe20 fs/xfs/xfs_dquot.c:381
       xfs_qm_dqread+0x1a3/0x630 fs/xfs/xfs_dquot.c:720
       xfs_qm_dqget+0x2bb/0x6f0 fs/xfs/xfs_dquot.c:932
       xfs_qm_quotacheck_dqadjust+0xeb/0x5e0 fs/xfs/xfs_qm.c:1333
       xfs_qm_dqusage_adjust+0x6a8/0x850 fs/xfs/xfs_qm.c:1466
       xfs_iwalk_ag_recs+0x4e3/0x820 fs/xfs/xfs_iwalk.c:209
       xfs_iwalk_run_callbacks+0x218/0x470 fs/xfs/xfs_iwalk.c:370
       xfs_iwalk_ag+0xa9a/0xbb0 fs/xfs/xfs_iwalk.c:476
       xfs_iwalk_ag_work+0xfb/0x1b0 fs/xfs/xfs_iwalk.c:625
       xfs_pwork_work+0x7f/0x190 fs/xfs/xfs_pwork.c:47
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3319
       worker_thread+0x870/0xd30 kernel/workqueue.c:3400
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&xfs_nondir_ilock_class){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
       xfs_reclaim_inode fs/xfs/xfs_icache.c:1037 [inline]
       xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1729 [inline]
       xfs_icwalk_ag+0x1211/0x1ac0 fs/xfs/xfs_icache.c:1811
       xfs_icwalk fs/xfs/xfs_icache.c:1859 [inline]
       xfs_reclaim_inodes_nr+0x2b0/0x390 fs/xfs/xfs_icache.c:1103
       super_cache_scan+0x40f/0x4b0 fs/super.c:227
       do_shrink_slab+0x72d/0x1160 mm/shrinker.c:437
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:664
       shrink_one+0x43b/0x850 mm/vmscan.c:4868
       shrink_many mm/vmscan.c:4929 [inline]
       lru_gen_shrink_node mm/vmscan.c:5007 [inline]
       shrink_node+0x379b/0x3e20 mm/vmscan.c:5978
       kswapd_shrink_node mm/vmscan.c:6807 [inline]
       balance_pgdat mm/vmscan.c:6999 [inline]
       kswapd+0x20f3/0x3b10 mm/vmscan.c:7264
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __fs_reclaim_acquire mm/page_alloc.c:3853 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3867
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4066 [inline]
       slab_alloc_node mm/slub.c:4144 [inline]
       kmem_cache_alloc_node_noprof+0x48/0x380 mm/slub.c:4216
       __alloc_skb+0x1c3/0x440 net/core/skbuff.c:596
       alloc_skb include/linux/skbuff.h:1331 [inline]
       alloc_uevent_skb+0x74/0x230 lib/kobject_uevent.c:289
       uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
       kobject_uevent_net_broadcast+0x2fd/0x580 lib/kobject_uevent.c:410
       kobject_uevent_env+0x57d/0x8e0 lib/kobject_uevent.c:608
       kobject_synth_uevent+0x4ef/0xae0 lib/kobject_uevent.c:207
       bus_uevent_store+0x116/0x170 drivers/base/bus.c:832
       kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0xacf/0xd10 fs/read_write.c:679
       ksys_write+0x18f/0x2b0 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (uevent_sock_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
       uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
       kobject_uevent_net_broadcast+0x280/0x580 lib/kobject_uevent.c:410
       kobject_uevent_env+0x57d/0x8e0 lib/kobject_uevent.c:608
       set_capacity_and_notify+0x265/0x2d0 block/genhd.c:102
       loop_set_size drivers/block/loop.c:234 [inline]
       loop_set_status+0x496/0x800 drivers/block/loop.c:1292
       lo_ioctl+0xce6/0x2870
       blkdev_ioctl+0x5d0/0x6f0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  uevent_sock_mutex --> &xfs_nondir_ilock_class --> &q->q_usage_counter(io)#17

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#17);
                               lock(&xfs_nondir_ilock_class);
                               lock(&q->q_usage_counter(io)#17);
  lock(uevent_sock_mutex);

 *** DEADLOCK ***

3 locks held by syz-executor594/5306:
 #0: ffff888033a61360 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_set_status+0x2b/0x800 drivers/block/loop.c:1261
 #1: ffff8880348c1c38 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:920 [inline]
 #1: ffff8880348c1c38 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: loop_set_status+0x213/0x800 drivers/block/loop.c:1277
 #2: ffff8880348c1c70 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:920 [inline]
 #2: ffff8880348c1c70 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: loop_set_status+0x213/0x800 drivers/block/loop.c:1277

stack backtrace:
CPU: 0 UID: 0 PID: 5306 Comm: syz-executor594 Not tainted 6.14.0-rc4-syzkaller-00212-g276f98efb64a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
 uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
 kobject_uevent_net_broadcast+0x280/0x580 lib/kobject_uevent.c:410
 kobject_uevent_env+0x57d/0x8e0 lib/kobject_uevent.c:608
 set_capacity_and_notify+0x265/0x2d0 block/genhd.c:102
 loop_set_size drivers/block/loop.c:234 [inline]
 loop_set_status+0x496/0x800 drivers/block/loop.c:1292
 lo_ioctl+0xce6/0x2870
 blkdev_ioctl+0x5d0/0x6f0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f286b010099
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec2b9f008 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000400000000000 RCX: 00007f286b010099
RDX: 00004000000000c0 RSI: 0000000000004c02 RDI: 0000000000000006
RBP: 0000400000000100 R08: 0000000000000000 R09: 000055557300d4c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffec2b9f030
R13: 00007ffec2b9f258 R14: 431bde82d7b634db R15: 00007f286b05903b
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
