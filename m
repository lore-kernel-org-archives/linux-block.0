Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9353DDDD0
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086265; cv=none; b=UjPvCsJI56GpEjl2WyuXMCthWNKCSD9VB2DRKnimjeeQoFYDSzDJf7eRa5LbuZsniRPpg6mVPp0ywZ1ppxIN1dTwbEwn3wUN2ElTH2lSB4S9IBwIe0zLb02z8BoT0DuAvt6Fuq01q5Qo5eOM8snjwBxu0GBnhIPH9YBsmKbYOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086265; c=relaxed/simple;
	bh=KV5VMm7/VC1hJWQOBiL4rGD/rH+9kOHRjNhc8r+FI9g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DfGCg4JtZkqtHku9gv0fAUhKiodW2aKdTMud5wiWIRS9TQjALMXy8rtmXZ/M4LxpIcDR6sO8aUpuzI3Sg9w4YJJhW8Z5016qTmdbjPl/SQ2Dki4zBUVFctKLIPgV+qmB6h54csPr384NJSQuQISvJqsva5jFkiczMUbgQflbOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7e6243b98a4so9143709a34.2
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 13:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780086263; x=1780691063;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0TQxfICKBbu6glso4OaEWkl0BSNliKzRICC8t754e4=;
        b=XGcNwGi2ik2AKMBMKDzkGftc9sXqC4A/1lHUMMUiTee1JDkgzKajSokxwvwluiMDL5
         6aCPPluEam35YHFpLWpgeLMg4aKBa8GznrZDZ2vULcZnjomJjyaFRb/3qt/ibwrYWnFx
         JQTotjcLcbdQXAayQdbhlh96GOUXC87tVSoPIdfK33BAe7mdAbRVVdxRyiNEVaEFcg4S
         +KJnZMQPb+N5g9RT3Owk0qv5/BNhPW8A/E8Y2gHJzZl2sgIlvNcmSsL/N6VqXOd9hNsY
         egSqOb8hk5IUatWRuKS3Qs+8jS+73gVHkUISncJXvako+iReliecbLUDWtDWcGqwFoyg
         VQiw==
X-Forwarded-Encrypted: i=1; AFNElJ8iWCTRfP+od3FKxg3NfLQljH8dFBwLv/e1bVYYZ7nRoljlcy/NOECKBiNGOxVcSOt9JKtKqFDG2jkWWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRUvS5BLJOCVWIW2ZGpi+ptShFWpzLq56lsHhvKfdXJIlD/xm
	QfkQjoOvQPA9txYcz+KYB3upb1YFj6wKyEwRvoJ336QNQ09LQj+4kBUZVd9m3dKn4wkEoo8+Ukp
	9BqZzYTxc7iRmRavIOfJM/539ZKyD7amf2Jd59KpLmR3qjcqiZGudASImuAo=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2904:b0:69d:e555:224f with SMTP id
 006d021491bc7-69e1019b557mr458102eaf.6.1780086263124; Fri, 29 May 2026
 13:24:23 -0700 (PDT)
Date: Fri, 29 May 2026 13:24:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a19f5f7.5099cdd9.8e407.0004.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in loop_process_work
From: syzbot <syzbot+78ad2c6a58c0a1faa5f5@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c1ecb239fa34 Add linux-next specific files for 20260522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12fa6336580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77a9211ff284de54
dashboard link: https://syzkaller.appspot.com/bug?extid=78ad2c6a58c0a1faa5f5
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4cb88c910144/disk-c1ecb239.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a9bc938cf88/vmlinux-c1ecb239.xz
kernel image: https://storage.googleapis.com/syzbot-assets/684f1e33f264/bzImage-c1ecb239.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78ad2c6a58c0a1faa5f5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
kworker/u8:15/1491 is trying to acquire lock:
ffff88805e1a6480 (sb_writers#5){.+.+}-{0:0}, at: do_req_filebacked drivers/block/loop.c:433 [inline]
ffff88805e1a6480 (sb_writers#5){.+.+}-{0:0}, at: loop_handle_cmd drivers/block/loop.c:1941 [inline]
ffff88805e1a6480 (sb_writers#5){.+.+}-{0:0}, at: loop_process_work+0x637/0x11b0 drivers/block/loop.c:1976

but task is already holding lock:
ffffc90006e27c40 ((work_completion)(&worker->work)){+.+.}-{0:0}, at: process_one_work+0x8be/0x1630 kernel/workqueue.c:3294

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 ((work_completion)(&worker->work)){+.+.}-{0:0}:
       process_one_work+0x8d7/0x1630 kernel/workqueue.c:3294
       process_scheduled_works kernel/workqueue.c:3401 [inline]
       worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #6 ((wq_completion)loop4){+.+.}-{0:0}:
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

-> #5 (&disk->open_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       __del_gendisk+0x127/0x980 block/genhd.c:710
       del_gendisk+0xe7/0x160 block/genhd.c:823
       nbd_dev_remove drivers/block/nbd.c:268 [inline]
       nbd_dev_remove_work+0x47/0xe0 drivers/block/nbd.c:284
       process_one_work+0x98b/0x1630 kernel/workqueue.c:3318
       process_scheduled_works kernel/workqueue.c:3401 [inline]
       worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #4 (&set->update_nr_hwq_lock){++++}-{4:4}:
       down_read+0x97/0x200 kernel/locking/rwsem.c:1568
       add_disk_fwnode+0xe7/0x480 block/genhd.c:596
       add_disk include/linux/blkdev.h:794 [inline]
       nbd_dev_add+0x72c/0xb50 drivers/block/nbd.c:1984
       nbd_genl_connect+0x965/0x1c80 drivers/block/nbd.c:2125
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
       sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
       __sock_sendmsg net/socket.c:812 [inline]
       ____sys_sendmsg+0x55c/0x870 net/socket.c:2716
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2770
       __sys_sendmsg net/socket.c:2802 [inline]
       __do_sys_sendmsg net/socket.c:2807 [inline]
       __se_sys_sendmsg net/socket.c:2805 [inline]
       __x64_sys_sendmsg+0x1c3/0x2a0 net/socket.c:2805
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (genl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       genl_lock net/netlink/genetlink.c:35 [inline]
       genl_lock_all net/netlink/genetlink.c:48 [inline]
       genl_register_family+0x7b9/0x17b0 net/netlink/genetlink.c:784
       vdpa_init+0x39/0x70 drivers/vdpa/vdpa.c:1565
       do_one_initcall+0x250/0x870 init/main.c:1347
       do_initcall_level+0x104/0x190 init/main.c:1409
       do_initcalls+0x59/0xa0 init/main.c:1425
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1658
       kernel_init+0x1d/0x1d0 init/main.c:1548
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (cb_lock){++++}-{4:4}:
       down_read+0x97/0x200 kernel/locking/rwsem.c:1568
       genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
       sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
       __sock_sendmsg net/socket.c:812 [inline]
       sock_sendmsg+0x1ca/0x2d0 net/socket.c:835
       splice_to_socket+0xae5/0x11f0 fs/splice.c:884
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0xef8/0x1940 fs/splice.c:1349
       __do_splice fs/splice.c:1431 [inline]
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice+0x353/0x490 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&pipe->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       iter_file_splice_write+0x1f3/0x10f0 fs/splice.c:682
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0xef8/0x1940 fs/splice.c:1349
       __do_splice fs/splice.c:1431 [inline]
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice+0x353/0x490 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_writers#5){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3167 [inline]
       check_prevs_add kernel/locking/lockdep.c:3286 [inline]
       validate_chain kernel/locking/lockdep.c:3910 [inline]
       __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write include/linux/fs/super.h:125 [inline]
       kiocb_start_write include/linux/fs.h:2767 [inline]
       lo_rw_aio+0xb1b/0xf00 drivers/block/loop.c:401
       do_req_filebacked drivers/block/loop.c:433 [inline]
       loop_handle_cmd drivers/block/loop.c:1941 [inline]
       loop_process_work+0x637/0x11b0 drivers/block/loop.c:1976
       process_one_work+0x98b/0x1630 kernel/workqueue.c:3318
       process_scheduled_works kernel/workqueue.c:3401 [inline]
       worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  sb_writers#5 --> (wq_completion)loop4 --> (work_completion)(&worker->work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&worker->work));
                               lock((wq_completion)loop4);
                               lock((work_completion)(&worker->work));
  rlock(sb_writers#5);

 *** DEADLOCK ***

2 locks held by kworker/u8:15/1491:
 #0: ffff888022729938 ((wq_completion)loop5){+.+.}-{0:0}, at: process_one_work+0x897/0x1630 kernel/workqueue.c:3293
 #1: ffffc90006e27c40 ((work_completion)(&worker->work)){+.+.}-{0:0}, at: process_one_work+0x8be/0x1630 kernel/workqueue.c:3294

stack backtrace:
CPU: 0 UID: 0 PID: 1491 Comm: kworker/u8:15 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: loop5 loop_workfn
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
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs/super.h:19 [inline]
 sb_start_write include/linux/fs/super.h:125 [inline]
 kiocb_start_write include/linux/fs.h:2767 [inline]
 lo_rw_aio+0xb1b/0xf00 drivers/block/loop.c:401
 do_req_filebacked drivers/block/loop.c:433 [inline]
 loop_handle_cmd drivers/block/loop.c:1941 [inline]
 loop_process_work+0x637/0x11b0 drivers/block/loop.c:1976
 process_one_work+0x98b/0x1630 kernel/workqueue.c:3318
 process_scheduled_works kernel/workqueue.c:3401 [inline]
 worker_thread+0xb49/0x1140 kernel/workqueue.c:3482
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
