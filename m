Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060AC8462
	for <linux-block@vger.kernel.org>; Sun, 24 May 2026 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779629785; cv=none; b=rgpvlK+wnhzTKFFOE2Ce9HblCk2Vqq0cpY2NHlVgUWGaFegOF/XjJoSMZOpHgqqdLruy0GUymKnoHby4nG4pu/A9GMzddMJ5Glitw3PlWJFIXUmTMO9TOf0ggeHM7mogISvxYpH87Vd7994nbka/NUHP2mmbV1kItQ8BqlXdKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779629785; c=relaxed/simple;
	bh=RUF88D4oxokI6ytz04k5oknLm9XIlC+0WgbXkUL8igU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tVgT1jUMyqcTYb0KAb0sJ0Xc+sW43meQtiVmDfVzD6JDRQ/dB9gMRf4Q6RO4l6NLJFNkZwQlazUf976fZO4OP2euLtcOSb4Nzv7U8je298SUYYYHtJK1AZ7Evhp1Dv9KxPbmCbR6/iiEPSgZyzAqMnGUU7v2s4VKrlTcGtj9LcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-69d92a86e3bso1677297eaf.1
        for <linux-block@vger.kernel.org>; Sun, 24 May 2026 06:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779629782; x=1780234582;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZoo+gfHiL9v2AlEyKRRsGzRo7Lz5LerxSDL2g5j4AU=;
        b=Yme2FYjjVgj3UNS04wVkkZU8UqTi3/6BxijQhhEI9z/7o8WfoMKkkc9RvypeAFR1OI
         YAAumESXfxuvqIMVAUMiz9H0o9MqMhzA6nKBSVIHM5miaaaD0tYwDOLa/kSXRKCYkDGo
         georijqcoOWJlEMLakYwb6Ztc9LqjV87kT8u1+YhzrHkOL6HMJDJ4QqxUD87+wv/LQc9
         yJd8WB83+O4m9OAKsJx4+QfTaXu6ffor/+xUY04tQUE2wUGWi//+hAmmpiUhBdoj0ljI
         2dszzyLFDFVPHap6cqN1Cs0d1pg8EDqM0YlL4xJNsErd9kCQ9yMvhDn5r6Vg2h4HrZu5
         9dBg==
X-Forwarded-Encrypted: i=1; AFNElJ+HhB9FOJG98/9gOhXHdJDnnwJFNBXRLZdkC9iBKr3gJPsj4ELm3GuLUuXtog1jQGtOeaPvzTdOuDYbiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVkxlVqoNxY9TngSSTuPP9sedW50ihRTEUqVKzCVX2/Y2Gex5
	953qhUMb0n951L8zGrki9tg0v0zzXjbfrYtFUaihibmpJdAIPc0MWav9F59fzNT98btwVewhrvQ
	VHWZ9tNCGv3WQLARM4UgvJtNy6NqcizvBgjIOHnfRGUg48a1vjvsw0xF/ZUQ=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8186:b0:696:25d4:1e62 with SMTP id
 006d021491bc7-69d7ead4e83mr5563720eaf.2.1779629781709; Sun, 24 May 2026
 06:36:21 -0700 (PDT)
Date: Sun, 24 May 2026 06:36:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a12fed5.050a0220.3c3a9.000b.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in bdev_release (2)
From: syzbot <syzbot+2f62807dc3239b8f584e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c1ecb239fa34 Add linux-next specific files for 20260522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=153a947e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77a9211ff284de54
dashboard link: https://syzkaller.appspot.com/bug?extid=2f62807dc3239b8f584e
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4cb88c910144/disk-c1ecb239.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a9bc938cf88/vmlinux-c1ecb239.xz
kernel image: https://storage.googleapis.com/syzbot-assets/684f1e33f264/bzImage-c1ecb239.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f62807dc3239b8f584e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
udevd/5769 is trying to acquire lock:
ffff88805ecd4938 ((wq_completion)loop4){+.+.}-{0:0}, at: touch_wq_lockdep_map+0xb5/0x180 kernel/workqueue.c:4033

but task is already holding lock:
ffff88802674c4c8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x1af/0x660 block/bdev.c:1136

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&disk->open_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       bdev_open+0xe0/0xcc0 block/bdev.c:953
       bdev_file_open_by_dev+0x1be/0x240 block/bdev.c:1067
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

-> #4 (system_transition_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       lock_system_sleep+0x49/0x70 kernel/power/main.c:71
       resume_store+0x2ff/0x4f0 kernel/power/hibernate.c:1300
       kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x629/0xba0 fs/read_write.c:688
       ksys_write+0x156/0x270 fs/read_write.c:740
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&of->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       kernfs_seq_start+0x5c/0x420 fs/kernfs/file.c:172
       traverse+0x164/0x580 fs/seq_file.c:107
       seq_read_iter+0xd09/0xe20 fs/seq_file.c:196
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

-> #2 (&p->lock){+.+.}-{4:4}:
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

-> #1 ((work_completion)(&worker->work)){+.+.}-{0:0}:
       process_one_work+0x8d7/0x1630 kernel/workqueue.c:3294
       process_scheduled_works kernel/workqueue.c:3401 [inline]
       worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 ((wq_completion)loop4){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3167 [inline]
       check_prevs_add kernel/locking/lockdep.c:3286 [inline]
       validate_chain kernel/locking/lockdep.c:3910 [inline]
       __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
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

other info that might help us debug this:

Chain exists of:
  (wq_completion)loop4 --> system_transition_mutex --> &disk->open_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&disk->open_mutex);
                               lock(system_transition_mutex);
                               lock(&disk->open_mutex);
  lock((wq_completion)loop4);

 *** DEADLOCK ***

1 lock held by udevd/5769:
 #0: ffff88802674c4c8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x1af/0x660 block/bdev.c:1136

stack backtrace:
CPU: 0 UID: 0 PID: 5769 Comm: udevd Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
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
RIP: 0033:0x7f836530a407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffd5e8529c0 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007f836521c880 RCX: 00007f836530a407
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 00007f836521c6e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 000055c60f674190 R14: 0000000000000008 R15: 000055c60f683f10
 </TASK>


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
