Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19FF375AB8
	for <linux-block@vger.kernel.org>; Sun, 24 May 2026 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779665369; cv=none; b=jpr2D/qGPpjRuL7RgEBOCvbHKKDaD98BSckV+TK/JfQtDt+K1rTRlRcVm1WsVZwwWmnBKHkG2bRHvXg+7xfqa+FYCT9cSfe70DpRXQnUX/D1rJ0bvN+aoGRhJVfrOcuTlwDTGHxMC0BQerU1nqQsGdv+UXE8Lrk2ShKUwq5JFU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779665369; c=relaxed/simple;
	bh=wNYm0t1P14qJ5QVb1LqTO4zTqcWynHS/2BTUps+kPy8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ijm2A/0EpY0e0YSjVbI5lfSlUkccP4gn26TpVKhSyEfMRbuvcndyqkw7OJvH4Fb692qBFD9jFevIXMFlblWF0o/hD/E3CjuU/ivhxRJyZytEVmdPqWZyywNsGZk9TEH+qAcCQZx0EPJfHIeyWdkd5NalJiO8o+nUn3DFyFt9SB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-69d77a8f5caso2938119eaf.3
        for <linux-block@vger.kernel.org>; Sun, 24 May 2026 16:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779665367; x=1780270167;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1tVT08qMKwM4LEWiR7dp2rhaqpG7vbi83pDn6j2sArM=;
        b=lEWz+wA/QTiqgi2rPYvhHsQgyj2a4VTeMwDu+ODmAEfPFxM48zg/XwO6KScSh8zruo
         Ei4Z4S8oeaI8DpkSvLJqyssJ5z+Un/rUiIrsnZ/yOfvJw3etWwZrgJss5p/TUEQnYqTM
         XssBxLbF37CihChapievCHvD+gym1ftMV9iBJTJTDmiNkEwlma5l7jWs+rUwka/fJVBJ
         Mtics1Sj+2E+YaorShVYGsFfqSDcCQuzq3RDMdGQs0ceW9cWrXUrgV3/iaZOBDlcmXJb
         +BfEmS81paT5eFUKbYK4m7UnI3QGKjCYww/7EH6t2ZK000q5nrm3L5fF962XrZ9rytPb
         i4Dg==
X-Forwarded-Encrypted: i=1; AFNElJ9cI2O9o16y1bxMw8xS4G1vudA0PCbEuGHqAAlYkRXZCQ0jt+f4e2w7gxiDw3MuG78BW16PCQsU8TzKnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlTKbEXwhfsbZ/ELeo+4fCqaHTjLoqOq4r3hgtTXszNPatSj6
	kDo1RAaKTNAyMfcGrRzjbnQ0pfnv/TxFXHhDLLsVtUW2WcawkuXCJxOf3W1JnlrqKmwylA3/vCo
	Z5ZFYvXqXrsfUGa2WGoVPFEPj1RikoRxzB+TtbZtTZjItLDnl4mUhv9ZTPrg=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c9f:b0:69d:9547:c961 with SMTP id
 006d021491bc7-69d9547d11fmr4043550eaf.22.1779665366889; Sun, 24 May 2026
 16:29:26 -0700 (PDT)
Date: Sun, 24 May 2026 16:29:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1389d6.a70a0220.74ee.0000.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in bdev_open
From: syzbot <syzbot+0f427123ae84b3ba6dc7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c1ecb239fa34 Add linux-next specific files for 20260522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e5db06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0299bf0261ddd5
dashboard link: https://syzkaller.appspot.com/bug?extid=0f427123ae84b3ba6dc7
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b8845b668755/disk-c1ecb239.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/517b638d908a/vmlinux-c1ecb239.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd5e3b587fce/bzImage-c1ecb239.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f427123ae84b3ba6dc7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.0.336/7301 is trying to acquire lock:
ffff88801b3974c8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xcc0 block/bdev.c:953

but task is already holding lock:
ffffffff8e74bdd8 (major_names_lock){+.+.}-{4:4}, at: blk_probe_dev block/genhd.c:881 [inline]
ffffffff8e74bdd8 (major_names_lock){+.+.}-{4:4}, at: blk_request_module+0x35/0x2a0 block/genhd.c:897

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (major_names_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       blk_probe_dev block/genhd.c:881 [inline]
       blk_request_module+0x35/0x2a0 block/genhd.c:897
       blkdev_get_no_open+0x3f/0xe0 block/bdev.c:833
       bdev_file_open_by_dev+0xa0/0x240 block/bdev.c:1054
       swsusp_check+0x56/0x490 kernel/power/swap.c:1571
       software_resume+0x51/0x4c0 kernel/power/hibernate.c:1023
       resume_store+0x333/0x4f0 kernel/power/hibernate.c:1307
       kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
       iter_file_splice_write+0x9a6/0x10f0 fs/splice.c:736
       do_splice_from fs/splice.c:936 [inline]
       direct_splice_actor+0x104/0x160 fs/splice.c:1159
       splice_direct_to_actor+0x545/0xc80 fs/splice.c:1103
       do_splice_direct_actor fs/splice.c:1202 [inline]
       do_splice_direct+0x19b/0x2a0 fs/splice.c:1228
       do_sendfile+0x547/0x7e0 fs/read_write.c:1372
       __do_sys_sendfile64 fs/read_write.c:1433 [inline]
       __se_sys_sendfile64+0x144/0x1a0 fs/read_write.c:1419
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (system_transition_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       lock_system_sleep+0x49/0x70 kernel/power/main.c:71
       resume_store+0x2ff/0x4f0 kernel/power/hibernate.c:1300
       kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
       iter_file_splice_write+0x9a6/0x10f0 fs/splice.c:736
       do_splice_from fs/splice.c:936 [inline]
       direct_splice_actor+0x104/0x160 fs/splice.c:1159
       splice_direct_to_actor+0x545/0xc80 fs/splice.c:1103
       do_splice_direct_actor fs/splice.c:1202 [inline]
       do_splice_direct+0x19b/0x2a0 fs/splice.c:1228
       do_sendfile+0x547/0x7e0 fs/read_write.c:1372
       __do_sys_sendfile64 fs/read_write.c:1433 [inline]
       __se_sys_sendfile64+0x144/0x1a0 fs/read_write.c:1419
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&of->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       kernfs_seq_start+0x5c/0x420 fs/kernfs/file.c:172
       seq_read_iter+0x3f8/0xe20 fs/seq_file.c:226
       copy_splice_read+0x605/0xab0 fs/splice.c:362
       do_splice_read fs/splice.c:980 [inline]
       splice_direct_to_actor+0x483/0xc80 fs/splice.c:1084
       do_splice_direct_actor fs/splice.c:1202 [inline]
       do_splice_direct+0x19b/0x2a0 fs/splice.c:1228
       do_sendfile+0x547/0x7e0 fs/read_write.c:1372
       __do_sys_sendfile64 fs/read_write.c:1433 [inline]
       __se_sys_sendfile64+0x144/0x1a0 fs/read_write.c:1419
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&p->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       seq_read_iter+0xb8/0xe20 fs/seq_file.c:183
       lo_rw_aio+0xc80/0xf00 include/linux/percpu-rwsem.h:-1
       do_req_filebacked drivers/block/loop.c:435 [inline]
       loop_handle_cmd drivers/block/loop.c:1941 [inline]
       loop_process_work+0x92a/0x11b0 drivers/block/loop.c:1976
       process_one_work+0x98b/0x1630 kernel/workqueue.c:3318
       process_scheduled_works kernel/workqueue.c:3401 [inline]
       worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 ((work_completion)(&worker->work)){+.+.}-{0:0}:
       process_one_work+0x8d7/0x1630 kernel/workqueue.c:3294
       process_scheduled_works kernel/workqueue.c:3401 [inline]
       worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 ((wq_completion)loop1){+.+.}-{0:0}:
       touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:4033
       __flush_workqueue+0x14b/0x14f0 kernel/workqueue.c:4075
       drain_workqueue+0xd3/0x390 kernel/workqueue.c:4239
       __loop_clr_fd drivers/block/loop.c:1130 [inline]
       lo_release+0x287/0x8f0 drivers/block/loop.c:1767
       bdev_release+0x541/0x660 block/bdev.c:-1
       blkdev_release+0x15/0x20 block/fops.c:705
       __fput+0x461/0xa70 fs/file_table.c:510
       fput_close_sync+0x11f/0x240 fs/file_table.c:615
       __do_sys_close fs/open.c:1511 [inline]
       __se_sys_close fs/open.c:1496 [inline]
       __x64_sys_close+0x7e/0x110 fs/open.c:1496
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&disk->open_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3167 [inline]
       check_prevs_add kernel/locking/lockdep.c:3286 [inline]
       validate_chain kernel/locking/lockdep.c:3910 [inline]
       __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       bdev_open+0xe0/0xcc0 block/bdev.c:953
       bdev_file_open_by_dev+0x1be/0x240 block/bdev.c:1067
       disk_scan_partitions+0x1c1/0x2c0 block/genhd.c:387
       add_disk_final block/genhd.c:416 [inline]
       add_disk_fwnode+0x321/0x480 block/genhd.c:610
       add_disk include/linux/blkdev.h:794 [inline]
       brd_alloc+0x5c9/0x7d0 drivers/block/brd.c:340
       blk_probe_dev block/genhd.c:884 [inline]
       blk_request_module+0x27d/0x2a0 block/genhd.c:-1
       blkdev_get_no_open+0x3f/0xe0 block/bdev.c:833
       bdev_file_open_by_dev+0xa0/0x240 block/bdev.c:1054
       swsusp_check+0x56/0x490 kernel/power/swap.c:1571
       software_resume+0x51/0x4c0 kernel/power/hibernate.c:1023
       resume_store+0x333/0x4f0 kernel/power/hibernate.c:1307
       kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x629/0xba0 fs/read_write.c:688
       ksys_write+0x156/0x270 fs/read_write.c:740
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &disk->open_mutex --> system_transition_mutex --> major_names_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(major_names_lock);
                               lock(system_transition_mutex);
                               lock(major_names_lock);
  lock(&disk->open_mutex);

 *** DEADLOCK ***

6 locks held by syz.0.336/7301:
 #0: ffff888011240528 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1260
 #1: ffff888035564480 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2733 [inline]
 #1: ffff888035564480 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff88801efe3078 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:343
 #3: ffff88801eec5c38 (kn->active#59){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #3: ffff88801eec5c38 (kn->active#59){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x232/0x540 fs/kernfs/file.c:344
 #4: ffffffff8de756d8 (system_transition_mutex){+.+.}-{4:4}, at: software_resume+0x47/0x4c0 kernel/power/hibernate.c:1022
 #5: ffffffff8e74bdd8 (major_names_lock){+.+.}-{4:4}, at: blk_probe_dev block/genhd.c:881 [inline]
 #5: ffffffff8e74bdd8 (major_names_lock){+.+.}-{4:4}, at: blk_request_module+0x35/0x2a0 block/genhd.c:897

stack backtrace:
CPU: 1 UID: 0 PID: 7301 Comm: syz.0.336 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2045
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3167 [inline]
 check_prevs_add kernel/locking/lockdep.c:3286 [inline]
 validate_chain kernel/locking/lockdep.c:3910 [inline]
 __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
 mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
 bdev_open+0xe0/0xcc0 block/bdev.c:953
 bdev_file_open_by_dev+0x1be/0x240 block/bdev.c:1067
 disk_scan_partitions+0x1c1/0x2c0 block/genhd.c:387
 add_disk_final block/genhd.c:416 [inline]
 add_disk_fwnode+0x321/0x480 block/genhd.c:610
 add_disk include/linux/blkdev.h:794 [inline]
 brd_alloc+0x5c9/0x7d0 drivers/block/brd.c:340
 blk_probe_dev block/genhd.c:884 [inline]
 blk_request_module+0x27d/0x2a0 block/genhd.c:-1
 blkdev_get_no_open+0x3f/0xe0 block/bdev.c:833
 bdev_file_open_by_dev+0xa0/0x240 block/bdev.c:1054
 swsusp_check+0x56/0x490 kernel/power/swap.c:1571
 software_resume+0x51/0x4c0 kernel/power/hibernate.c:1023
 resume_store+0x333/0x4f0 kernel/power/hibernate.c:1307
 kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f157962ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f157783c028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f15798a6180 RCX: 00007f157962ce59
RDX: 0000000000000024 RSI: 0000200000000040 RDI: 000000000000000d
RBP: 00007f15796c2d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f15798a6218 R14: 00007f15798a6180 R15: 00007fffa4f29e08
 </TASK>
block device autoloading is deprecated and will be removed.
PM: Image not found (code -22)


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
