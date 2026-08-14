Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66716DEB1
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666471; cv=none; b=JKef6FIsnafFlShJvmbHeEDtUST8cwVzUFhBS8fRLHLeD1ag3yQafFjB/w4PbOc73jRIUyRvm6NwzYRCV2n4GcgdFOu14+bFxlUytXXusTaRXJpRsISovLLnWNU4tcWwwObLq1g0UIWs4wrp8d4vEjI8JFEVYfNBThXPmrKJqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666471; c=relaxed/simple;
	bh=9qr9IE8c2P2jq+z162fx57XJxi0xfWCZ27IGJg5JZmI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cj1M4J20SSa2UVnlrkAtvLm8GePNn2OVOlAbNkzuTCN+tFzDAI2jK2pySJB7TsJWRG1O2URgsVdR0CXVHr33Dbfs+QEB0OTGcnMkmjL4FTbpM1fPo+eoICCs76b5hW87H++gm6aSyWtodRzmx/xjx81WcgoWTgla7GTVwlKR9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-485ebc5706cso1898017b6e.0
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 17:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786666468; x=1787271268;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ja7SjhEzE+n5djMzigJ+mZ037NujOfkeHtoAmnylPUk=;
        b=I08ku9IVXa3Jlbyupct7DqIKTpYPgZKhhzaR/2wSkTYnMaOC56F8jdfmWqV1YS8Zj7
         eOJ9cK1/7YzSXDHleg7WZZknmv+ALxxP60hrDuuSWDUz/hbv7GRkP2TiJEk8hlpBsxxm
         ly2TFdQ4SKmMtxztWSDBqTWT6EDWMOZXa3rAakeOgSQl1zepz6Y+YdLwIp4uFEGcre7r
         k7cePmCRVnj5c7u5IIL5FlWmK9vOLo+IpGnbiAVuHR1BKSQrzOdFsu1y75QQf1W0l1zJ
         NtO7cLuGTMy1u0k5h6MB7V4zQarZ2WEMSGWXvw9J5Mbj0slIekLHlrN8MHzR+HluCdM8
         wD0Q==
X-Forwarded-Encrypted: i=1; AHgh+RqUaFeH+sWWddgVVv8oy2g4acVplyf51PSkvXcap2wIV5XL26JnhFweUNi51FIgc7l54f9tuRLB22pocQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVXFEdltglP0RN9KxzsEGiHmcWwyOThYTTegHQJqWneI6rSSh
	4+9DTlY2V8XmVrXMbNwGkdUx+D/UKYlUDCshQVo15DhiK3BR2NsDP4QA2Zf44TFoZVsWBJlSOvO
	MYA3wGQSJduntwD/z5HcniwEZTGi9+ov4P3BEYVY2b52CXAxuSxKp8wYbvcM=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1996:b0:496:9ee:e538 with SMTP id
 5614622812f47-4b228008b82mr7675111b6e.5.1786666468499; Thu, 13 Aug 2026
 17:14:28 -0700 (PDT)
Date: Thu, 13 Aug 2026 17:14:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7e5de4.0d56fcf3.329e18.024b.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in loop_configure
From: syzbot <syzbot+a201cc2f7513691d4ed0@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b8c8af514d7 Add linux-next specific files for 20260807
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b61132580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d343b54cc50df0f
dashboard link: https://syzkaller.appspot.com/bug?extid=a201cc2f7513691d4ed0
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/71ff4edcb608/disk-6b8c8af5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f5fa331d8f2/vmlinux-6b8c8af5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f993558ec63b/bzImage-6b8c8af5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a201cc2f7513691d4ed0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.7.1110/11577 is trying to acquire lock:
ffffffff8ec88b00 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:314 [inline]
ffffffff8ec88b00 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4636 [inline]
ffffffff8ec88b00 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4974 [inline]
ffffffff8ec88b00 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub.c:5413 [inline]
ffffffff8ec88b00 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_noprof+0xbc/0x710 mm/slub.c:5439

but task is already holding lock:
ffff888025c00fe8 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:1101 [inline]
ffff888025c00fe8 (&q->limits_lock){+.+.}-{4:4}, at: loop_configure+0x787/0xdc0 drivers/block/loop.c:1083

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->limits_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       queue_limits_start_update include/linux/blkdev.h:1101 [inline]
       loop_set_dio drivers/block/loop.c:1460 [inline]
       lo_simple_ioctl drivers/block/loop.c:1528 [inline]
       lo_ioctl+0x16ca/0x2150 drivers/block/loop.c:1594
       blkdev_ioctl+0x5e3/0x740 block/ioctl.c:798
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#26){++++}-{0:0}:
       blk_alloc_queue+0x544/0x690 block/blk-core.c:504
       blk_mq_alloc_queue block/blk-mq.c:4420 [inline]
       __blk_mq_alloc_disk+0x194/0x390 block/blk-mq.c:4467
       loop_add+0x480/0xb40 drivers/block/loop.c:2071
       loop_init+0xd7/0x160 drivers/block/loop.c:2310
       do_one_initcall+0x250/0x870 init/main.c:1359
       do_initcall_level+0x10a/0x1a0 init/main.c:1421
       do_initcalls+0x59/0xa0 init/main.c:1437
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1672
       kernel_init+0x22/0x1d0 init/main.c:1562
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x15ff/0x2e50 kernel/locking/lockdep.c:5254
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
       __fs_reclaim_acquire mm/page_alloc.c:4433 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4447
       might_alloc include/linux/sched/mm.h:314 [inline]
       slab_pre_alloc_hook mm/slub.c:4636 [inline]
       slab_alloc_node mm/slub.c:4974 [inline]
       __do_kmalloc_node mm/slub.c:5413 [inline]
       __kmalloc_noprof+0xbc/0x710 mm/slub.c:5439
       _kmalloc_noprof include/linux/slab.h:995 [inline]
       btrfs_calc_avail_data_space fs/btrfs/super.c:1631 [inline]
       btrfs_statfs+0xc2a/0x1b40 fs/btrfs/super.c:1781
       statfs_by_dentry fs/statfs.c:66 [inline]
       vfs_statfs+0x147/0x2d0 fs/statfs.c:90
       loop_get_discard_config drivers/block/loop.c:774 [inline]
       loop_update_limits+0x375/0x920 drivers/block/loop.c:984
       loop_configure+0x7d2/0xdc0 drivers/block/loop.c:1084
       lo_ioctl+0xad5/0x2150 drivers/block/loop.c:1564
       blkdev_ioctl+0x5e3/0x740 block/ioctl.c:798
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &q->q_usage_counter(io)#26 --> &q->limits_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->limits_lock);
                               lock(&q->q_usage_counter(io)#26);
                               lock(&q->limits_lock);
  lock(fs_reclaim);

 *** DEADLOCK ***

locks held by syz.7.1110/11577: 2, last CPU#0:
 #0: ffff888025eba430 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_global_lock_killable drivers/block/loop.c:119 [inline]
 #0: ffff888025eba430 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_configure+0x35d/0xdc0 drivers/block/loop.c:1038
 #1: ffff888025c00fe8 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:1101 [inline]
 #1: ffff888025c00fe8 (&q->limits_lock){+.+.}-{4:4}, at: loop_configure+0x787/0xdc0 drivers/block/loop.c:1083

stack backtrace:
CPU: 0 UID: 0 PID: 11577 Comm: syz.7.1110 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2059
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2191
 check_prev_add kernel/locking/lockdep.c:3181 [inline]
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x15ff/0x2e50 kernel/locking/lockdep.c:5254
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
 __fs_reclaim_acquire mm/page_alloc.c:4433 [inline]
 fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4447
 might_alloc include/linux/sched/mm.h:314 [inline]
 slab_pre_alloc_hook mm/slub.c:4636 [inline]
 slab_alloc_node mm/slub.c:4974 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0xbc/0x710 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 btrfs_calc_avail_data_space fs/btrfs/super.c:1631 [inline]
 btrfs_statfs+0xc2a/0x1b40 fs/btrfs/super.c:1781
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x147/0x2d0 fs/statfs.c:90
 loop_get_discard_config drivers/block/loop.c:774 [inline]
 loop_update_limits+0x375/0x920 drivers/block/loop.c:984
 loop_configure+0x7d2/0xdc0 drivers/block/loop.c:1084
 lo_ioctl+0xad5/0x2150 drivers/block/loop.c:1564
 blkdev_ioctl+0x5e3/0x740 block/ioctl.c:798
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3bf279e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3bf36b4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3bf2a26180 RCX: 00007f3bf279e0d9
RDX: 00002000000005c0 RSI: 0000000000004c0a RDI: 0000000000000008
RBP: 00007f3bf2835024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3bf2a26218 R14: 00007f3bf2a26180 R15: 00007ffd1bede9c8
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
