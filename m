Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA921148F
	for <linux-block@vger.kernel.org>; Mon, 31 Mar 2025 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430643; cv=none; b=jyPIXQVKhbORd4Bk6m80xK0lKQ7nuhiIilVikCvrVukgHcJxBceJz7Pa+GcWnBGFSfA7dLCTV0WXao39NYzazlnia8Tq7eEv4AXEpfOKRNRjOKBV/6v64Kp8kZ7MW0i1c5zWSHhbNUv3QojmXvHUqBZ5WYxSdTZE0RfnySG592w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430643; c=relaxed/simple;
	bh=bNUiw3kjNnY54qfS00GYE+/p+kWr3Rqi1g0RrhSOrSw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZCqkaLs2+Tv7bHMWB6dURxgqS3bDhY1DjWhovkqvYoSZrTMtCh0KXcEcUcu9yH/N13OnxZGmN7F7ThRqUqqZchl0oOblKG76wuXGeld8Zcpq5xxKpC8jgHtozh87Eb13BT32WdZ4L2r/kGiZGweP6CYBHKANWk3T8s+s+Tbl7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d5d6c997d2so29952325ab.0
        for <linux-block@vger.kernel.org>; Mon, 31 Mar 2025 07:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743430641; x=1744035441;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEnLau8C9yTFjycIROrk+DLt+cGTsSvTqjUBAy0+9oM=;
        b=hcWuQONlLHNU/2oOFhEKzt8pJDyVQ1MmDCFlEdckp/fMcSv36MRNBlFIC+fQN3WXMY
         M1pAEfH9Gg/rpYQwotfTkXtLrhKGJiANuN6BfjTC39QVdobczxkdBGqn1Baruox6tG5K
         pQneEjKHWLvWUX0/JmV21UXwnxoox2p8hBbPVJCMuKq6qZx+2YTgFYSnf5EO8XRh/Njm
         K4qbE2wZawUUq4X/ja/f/e5dzAOQWQYp6pVQPAJW/VRYGmXg2hq9gkRJNWv/66fjg/Op
         SN0bNc9zm9ZD+NikP5sgAZu+uF7/OS1L7YA4ZoV+BypKlWEvJD9z+uL2atapxTuFWOPJ
         nHvw==
X-Forwarded-Encrypted: i=1; AJvYcCXd65uX0xR8TzTAB4jqk8MpwnWVTaOzYPhziFkstAcb0hkPRTFGJvlMiYfE5VZ6ZZFYWjn+jqVG2exqlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFsy1oHi2jnWJs6ssytmW942D1QZdxt0YZK18VNSbkV2pZcjZ
	vEU1dhFJlPFwR95vgsE8SNuYHFDmt2tbjuTt8r74AFBPgv+W8C9XdawL2f4g+QhekP9nvCAApdZ
	mM/cbbTTm0EX5W/bvmyd1XwYP1aQiA6VCv3dhTKXig7Iy+aUix/a1FL8=
X-Google-Smtp-Source: AGHT+IE7qRDCDADzm3Rs83YYCtT1kPEmyIjVagY0VJ9AgQwZJ53xPbur/iphBcMlqyyotQm58dcMF4xMb5s/WfVS0KzCtCTHIZuI
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3d3:ddb3:fe4e with SMTP id
 e9e14a558f8ab-3d5e09344f1mr86852135ab.13.1743430640947; Mon, 31 Mar 2025
 07:17:20 -0700 (PDT)
Date: Mon, 31 Mar 2025 07:17:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67eaa3f0.050a0220.3c3d88.0045.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in queue_requests_store
From: syzbot <syzbot+48928935f5008dde0a41@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f16bb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7163a109ac459a8
dashboard link: https://syzkaller.appspot.com/bug?extid=48928935f5008dde0a41
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c1e198580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158cfa4c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc7dc9f0d9a7/disk-1a9239bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f555a3ae03d3/vmlinux-1a9239bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55f6ea74eaf2/bzImage-1a9239bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48928935f5008dde0a41@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-syzkaller-05877-g1a9239bb4253 #0 Not tainted
------------------------------------------------------
syz-executor161/5834 is trying to acquire lock:
ffff8881437b1958 (&q->elevator_lock){+.+.}-{4:4}, at: queue_requests_store+0x1c7/0x310 block/blk-sysfs.c:80

but task is already holding lock:
ffff8881437b1428 (&q->q_usage_counter(io)#29){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#29){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x179/0x290 block/blk-mq.c:4349
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

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3853 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3867
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
       __mutex_lock_common kernel/locking/mutex.c:587 [inline]
       __mutex_lock+0x19a/0xb00 kernel/locking/mutex.c:732
       queue_requests_store+0x1c7/0x310 block/blk-sysfs.c:80
       queue_attr_store+0x270/0x310 block/blk-sysfs.c:799
       sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
       kernfs_fop_write_iter+0x349/0x510 fs/kernfs/file.c:334
       iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
       do_splice_from fs/splice.c:935 [inline]
       direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
       splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
       do_splice_direct_actor fs/splice.c:1201 [inline]
       do_splice_direct+0x174/0x240 fs/splice.c:1227
       do_sendfile+0xafd/0xe50 fs/read_write.c:1368
       __do_sys_sendfile64 fs/read_write.c:1429 [inline]
       __se_sys_sendfile64 fs/read_write.c:1415 [inline]
       __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#29

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#29);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#29);
  lock(&q->elevator_lock);

 *** DEADLOCK ***

5 locks held by syz-executor161/5834:
 #0: ffff88803625a420 (sb_writers#7){.+.+}-{0:0}, at: splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
 #1: ffff888028f3e488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x287/0x510 fs/kernfs/file.c:325
 #2: ffff888022fb55a8 (kn->active#47){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2aa/0x510 fs/kernfs/file.c:326
 #3: ffff8881437b1428 (&q->q_usage_counter(io)#29){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215
 #4: ffff8881437b1460 (&q->q_usage_counter(queue)#20){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215

stack backtrace:
CPU: 0 UID: 0 PID: 5834 Comm: syz-executor161 Not tainted 6.14.0-syzkaller-05877-g1a9239bb4253 #0 PREEMPT(full) 
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
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0x19a/0xb00 kernel/locking/mutex.c:732
 queue_requests_store+0x1c7/0x310 block/blk-sysfs.c:80
 queue_attr_store+0x270/0x310 block/blk-sysfs.c:799
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x349/0x510 fs/kernfs/file.c:334
 iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
 do_splice_from fs/splice.c:935 [inline]
 direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
 splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x174/0x240 fs/splice.c:1227
 do_sendfile+0xafd/0xe50 fs/read_write.c:1368
 __do_sys_sendfile64 fs/read_write.c:1429 [inline]
 __se_sys_sendfile64 fs/read_write.c:1415 [inline]
 __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5e82d252e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe14bb84d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007ffe14bb86a8 RCX: 00007f5e82d252e9
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00007f5e82d98610 R08: 0000000000000000 R09: 00007ffe14bb86a8
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe14bb8698 R14: 0000000000000001 R15: 0000000


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
