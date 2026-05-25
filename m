Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62748386564
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740667; cv=none; b=R5k6cPjQJQVZiggBLN68cvIGcw1B2//K5i+YbzdTCM1uiz9XgPgPjY8FAe8Ozp0FWvM8fA6c7ncHO4ZSjCSayyH+iGxmtvmGw4AM6J8NgqqyqG7EGASTW8XKFgNyqD5I8DxspWbu080+hiTv7MnNapy6m+JRE9k9D6ogem54nIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740667; c=relaxed/simple;
	bh=BEQxlz881jcwUfFQV7K6Dsfi8h11SN/xISvlDoPCUoE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=awY+6nVE+6Kv9bQ1e6lvpYj0S/aQbZnyFxjnoW/swU86Y1CDEaOqoLK6IBDl6TYJ4rBTI2z8LlCj886ILzn9IZotLIuqrerIJEwIBIGtwYMizFSdgk1ozx8Vkfa6JeBsQ9eYFtGCUsISXoBPaIY2EkSVIiuAQl0uA6U/FvfDby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7e60737a946so3123528a34.1
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 13:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740664; x=1780345464;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flZ0mNdqYevbyN3WrjudUTCNkv2RvkYkMrtaO7peVa4=;
        b=FHsRj4KtemiLA7oTSd+V00KYOygLgZyyM8n6C5LXybiojAx5qxXRpGnXngwqVtnVMy
         p2d6nFlu4GHxh4LFFeXmrApiWFSfejbBVNO+hrS2XCqMWbhcgrFZzmGZJcaPH4wXNui9
         L/14DTSdcUGVYSBQBZjyYsWtrdGQ9PtgH+70/LQEUtUPJVfE1sCf2SahwFa/PCgJjhXy
         xTwFtbqcHce5S+GOnGWoIGdEs1BcmphWdO7Yfh2N250a7xTGHc3XlvtOKZq4kkgHrUjZ
         +fnywLf9PiQvs5B3+0POtQNLvsmjOrB1IrL5IwTAPK3rMa3QzieVKd7F7KP0BYqIXmzl
         lM6A==
X-Forwarded-Encrypted: i=1; AFNElJ8SfK4BOQGAzbPeR7Se+xa3nmpY1/4vvyOwD+wnwdseRqMuSk8j0iDwxhBkOtvidDROU14nggHuJ11FbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZy5VKVRw/GxmRBDNVGoFNEBeexX59suyJ9GBB5dkr5Vf8roO
	t97iBFP6TtGaauQQJWM4VARDDaeW8uHl0TfZEDDTTHaEoaiqbv5Q8P1EUmgrdjvpJKu+i5K0RsF
	APzkF9sxOUBxfnJY9sg5ExZT3teRgzcByfwE5QWFIT+LRKVileK2yTPN+EVk=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6bee:b0:696:63dc:cac9 with SMTP id
 006d021491bc7-69d7eb6c5a6mr6133226eaf.23.1779740664288; Mon, 25 May 2026
 13:24:24 -0700 (PDT)
Date: Mon, 25 May 2026 13:24:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a14aff8.050a0220.2385e8.0019.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_request_module (2)
From: syzbot <syzbot+fb0ff9bfe34ad282ebd4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c1ecb239fa34 Add linux-next specific files for 20260522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=136a20ee580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77a9211ff284de54
dashboard link: https://syzkaller.appspot.com/bug?extid=fb0ff9bfe34ad282ebd4
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4cb88c910144/disk-c1ecb239.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a9bc938cf88/vmlinux-c1ecb239.xz
kernel image: https://storage.googleapis.com/syzbot-assets/684f1e33f264/bzImage-c1ecb239.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb0ff9bfe34ad282ebd4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.2.2988/16485 is trying to acquire lock:
ffffffff8e94e518 (major_names_lock){+.+.}-{4:4}, at: blk_probe_dev block/genhd.c:881 [inline]
ffffffff8e94e518 (major_names_lock){+.+.}-{4:4}, at: blk_request_module+0x35/0x2a0 block/genhd.c:897

but task is already holding lock:
ffffffff8e0756d8 (system_transition_mutex){+.+.}-{4:4}, at: software_resume+0x47/0x4c0 kernel/power/hibernate.c:1022

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (system_transition_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       lock_system_sleep+0x49/0x70 kernel/power/main.c:71
       disk_store+0xa7/0x500 kernel/power/hibernate.c:1217
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

-> #6 (&of->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       kernfs_seq_start+0x5c/0x420 fs/kernfs/file.c:172
       seq_read_iter+0x3f8/0xe20 fs/seq_file.c:226
       new_sync_read fs/read_write.c:493 [inline]
       vfs_read+0x58b/0xa80 fs/read_write.c:574
       ksys_read+0x156/0x270 fs/read_write.c:717
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&p->lock){+.+.}-{4:4}:
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

-> #4 ((work_completion)(&worker->work)){+.+.}-{0:0}:
       process_one_work+0x8d7/0x1630 kernel/workqueue.c:3294
       process_scheduled_works kernel/workqueue.c:3401 [inline]
       worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 ((wq_completion)loop8){+.+.}-{0:0}:
       touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:4033
       __flush_workqueue+0x14b/0x14f0 kernel/workqueue.c:4075
       drain_workqueue+0xd3/0x390 kernel/workqueue.c:4239
       __loop_clr_fd drivers/block/loop.c:1130 [inline]
       lo_release+0x287/0x8f0 drivers/block/loop.c:1767
       bdev_release+0x541/0x660 block/bdev.c:-1
       blkdev_release+0x15/0x20 block/fops.c:705
       __fput+0x461/0xa70 fs/file_table.c:510
       task_work_run+0x1d9/0x270 kernel/task_work.c:233
       exit_task_work include/linux/task_work.h:40 [inline]
       do_exit+0x70f/0x22c0 kernel/exit.c:1004
       do_group_exit+0x21b/0x2d0 kernel/exit.c:1147
       get_signal+0x1284/0x1330 kernel/signal.c:3038
       arch_do_signal_or_restart+0xbc/0x840 arch/x86/kernel/signal.c:337
       __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
       exit_to_user_mode_loop+0x8c/0x4d0 kernel/entry/common.c:98
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
       syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
       do_syscall_64+0x33e/0x560 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&disk->open_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       __del_gendisk+0x127/0x980 block/genhd.c:710
       del_gendisk+0xe7/0x160 block/genhd.c:823
       loop_remove+0x42/0xc0 drivers/block/loop.c:2136
       loop_control_remove drivers/block/loop.c:2195 [inline]
       loop_control_ioctl+0x4ba/0x5b0 drivers/block/loop.c:2237
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&set->update_nr_hwq_lock){++++}-{4:4}:
       down_read+0x97/0x200 kernel/locking/rwsem.c:1568
       add_disk_fwnode+0xe7/0x480 block/genhd.c:596
       add_disk include/linux/blkdev.h:794 [inline]
       loop_add+0x86e/0xb50 drivers/block/loop.c:2108
       blk_probe_dev block/genhd.c:884 [inline]
       blk_request_module+0x27d/0x2a0 block/genhd.c:-1
       blkdev_get_no_open+0x3f/0xe0 block/bdev.c:833
       blkdev_open+0x1f5/0x620 block/fops.c:688
       do_dentry_open+0x83d/0x13e0 fs/open.c:947
       vfs_open+0x3b/0x350 fs/open.c:1052
       do_open fs/namei.c:4688 [inline]
       path_openat+0x2eea/0x3960 fs/namei.c:4847
       do_file_open+0x23e/0x4a0 fs/namei.c:4876
       do_sys_openat2+0x115/0x200 fs/open.c:1368
       do_sys_open fs/open.c:1374 [inline]
       __do_sys_openat fs/open.c:1390 [inline]
       __se_sys_openat fs/open.c:1385 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1385
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (major_names_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3167 [inline]
       check_prevs_add kernel/locking/lockdep.c:3286 [inline]
       validate_chain kernel/locking/lockdep.c:3910 [inline]
       __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
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
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x629/0xba0 fs/read_write.c:688
       ksys_write+0x156/0x270 fs/read_write.c:740
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  major_names_lock --> &of->mutex --> system_transition_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(system_transition_mutex);
                               lock(&of->mutex);
                               lock(system_transition_mutex);
  lock(major_names_lock);

 *** DEADLOCK ***

5 locks held by syz.2.2988/16485:
 #0: ffff88803c6b3528 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1260
 #1: ffff8880354b8480 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2733 [inline]
 #1: ffff8880354b8480 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff88803cf6d878 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1df/0x540 fs/kernfs/file.c:343
 #3: ffff88801e299698 (kn->active#62){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #3: ffff88801e299698 (kn->active#62){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x232/0x540 fs/kernfs/file.c:344
 #4: ffffffff8e0756d8 (system_transition_mutex){+.+.}-{4:4}, at: software_resume+0x47/0x4c0 kernel/power/hibernate.c:1022

stack backtrace:
CPU: 0 UID: 0 PID: 16485 Comm: syz.2.2988 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
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
 blk_probe_dev block/genhd.c:881 [inline]
 blk_request_module+0x35/0x2a0 block/genhd.c:897
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
RIP: 0033:0x7f29a11dce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f299f436028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f29a1455fa0 RCX: 00007f29a11dce59
RDX: 0000000000000012 RSI: 0000200000000040 RDI: 0000000000000004
RBP: 00007f29a1272d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f29a1456038 R14: 00007f29a1455fa0 R15: 00007fff13825808
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
