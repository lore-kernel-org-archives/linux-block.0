Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189C1DFE0A
	for <linux-block@vger.kernel.org>; Mon, 31 Mar 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743428067; cv=none; b=qFg5SMAD7ZzIq4gyXg7HGZCP0oGX7KGO8oBxsdZAqrzDuUr9hwEuSrAWuUYVBH+UHPpklrMYCFw7vq3bDUH9TN6KaTr7Kj2WjtvjXWHGRCNUGIV8LIyuaNB+CV6Hl79NmC/Fd5I7KevUxWFLsAbC7debc76VLoY0sMPa26ekdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743428067; c=relaxed/simple;
	bh=DR/e9ZYOyQJ7GMHQSjkZRG/SSgpMVoinIvZeVn3cdu8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h3lwukuRV7jRHLl2XyaR0OwolBzz87IkkW0codRA4u7/XyskG5bG900WQ4fCRyoRPqIqQyFyA6yBgqpqp/XnyjGl/0Hde2lKV7sEyuV4maE3CDGTEcUL9603e1y0/1LRoyVg4oNop8QXff0JYjenaZbU6grtnqoeAAyJ/ewOQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d5b3819ff9so39421705ab.0
        for <linux-block@vger.kernel.org>; Mon, 31 Mar 2025 06:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743428064; x=1744032864;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwQ8MLlZO6I5kNDZrUdF7/a0DC1Byt2qediNDuihNmY=;
        b=Je923phtLrlrRX07mLXZcSK2TVyKZ4/TZMSvV9z0/p/4ax65HU/06+qIKWJ7AbLgcb
         5OafEKIMs4uLHa2TpYY9JMVUD+4ff+4ZpDRZXXVVeTYllWEk7yQ7hRkCRctB+LuXyXU6
         HfCaCbp0fgLdFZrULwt6kOUQDdjSCIZGqUk90/6xL3eNtNmDwSbpbn6V7PCnBF0Ks/eC
         kWiem9TjzvkJGKwRnZUhECpfGZRYfNXPQztO7wGxMCM9R8LWLXXBqRacvD/bFA7VxLT6
         4NArZXyMHs/TmJf4xlCXIR9I9i1XNlu0wfgDhkVzHw+tv9+gyf88BBDj/8zh1K+m1AD3
         lM9g==
X-Forwarded-Encrypted: i=1; AJvYcCXRqaPjOEHBVEvyyNGS8CGvj//GrU3JdTBjGXmec9doJFeMTXFZba0gQ5zRTIpJXn+YlGChqArzIIEROA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMnYzLcWC92/G5hzxMr/3MpEwDEhjBEOKvt2JBHrl9zvDiHNs9
	QeXty1kIpI5hcXb/IRgfACUgX6XtDHw1nJg1YIJgGLX38Nq8N1azXbnsskYXu9udC5SpB29dADs
	QiEE5Mymh5uWyIgANa4lSSjN2p8SiUcaZzS0FkW1BMHaFOrHgP4Buft8=
X-Google-Smtp-Source: AGHT+IHbCxze2FL2yt/zA2ZNEYpoRnO92fkBBh0We60v8+hNu8i0+N6BsMeglxvo/N9EZGcKmSIKxnrd3WNKpAauE4yVcd8AAP5D
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148f:b0:3d4:6ec8:c63c with SMTP id
 e9e14a558f8ab-3d5e09cd973mr65727275ab.17.1743428064389; Mon, 31 Mar 2025
 06:34:24 -0700 (PDT)
Date: Mon, 31 Mar 2025 06:34:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ea99e0.050a0220.3c3d88.0042.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_mq_freeze_queue_nomemsave
From: syzbot <syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aa918db707fb Merge tag 'bpf_try_alloc_pages' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1776ec3f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c654e2bc7f36976
dashboard link: https://syzkaller.appspot.com/bug?extid=9dd7dbb1a4b915dee638
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81273eda411b/disk-aa918db7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a2d1a79f3011/vmlinux-aa918db7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df851fa81fd2/bzImage-aa918db7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com

loop5: detected capacity change from 2048 to 64
======================================================
WARNING: possible circular locking dependency detected
6.14.0-syzkaller-10764-gaa918db707fb #0 Not tainted
------------------------------------------------------
syz.5.738/7855 is trying to acquire lock:
ffffffff9068dfe8 (uevent_sock_mutex){+.+.}-{4:4}, at: uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
ffffffff9068dfe8 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
ffffffff9068dfe8 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_env+0xb36/0x1870 lib/kobject_uevent.c:608

but task is already holding lock:
ffff888025874ea8 (&q->q_usage_counter(io)#22){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#22){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x179/0x290 block/blk-mq.c:4349
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4396
       loop_add+0x496/0xb70 drivers/block/loop.c:2067
       loop_init+0x164/0x270 drivers/block/loop.c:2302
       do_one_initcall+0x123/0x6e0 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1567
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3914 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3928
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4089 [inline]
       slab_alloc_node mm/slub.c:4167 [inline]
       kmem_cache_alloc_node_noprof+0x57/0x3b0 mm/slub.c:4239
       __alloc_skb+0x2b2/0x380 net/core/skbuff.c:658
       alloc_skb include/linux/skbuff.h:1340 [inline]
       alloc_uevent_skb+0x7d/0x210 lib/kobject_uevent.c:289
       uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
       kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
       kobject_uevent_env+0xca4/0x1870 lib/kobject_uevent.c:608
       kobject_synth_uevent+0x7d4/0x8a0 lib/kobject_uevent.c:207
       bus_uevent_store+0x3d/0x90 drivers/base/bus.c:832
       bus_attr_store+0x74/0xb0 drivers/base/bus.c:172
       sysfs_kf_write+0x11a/0x170 fs/sysfs/file.c:139
       kernfs_fop_write_iter+0x354/0x510 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:591 [inline]
       vfs_write+0x5bd/0x1180 fs/read_write.c:684
       ksys_write+0x12a/0x240 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (uevent_sock_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain kernel/locking/lockdep.c:3909 [inline]
       __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
       lock_acquire kernel/locking/lockdep.c:5866 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
       __mutex_lock_common kernel/locking/mutex.c:587 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:732
       uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
       kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
       kobject_uevent_env+0xb36/0x1870 lib/kobject_uevent.c:608
       set_capacity_and_notify+0x1ca/0x240 block/genhd.c:102
       loop_set_size drivers/block/loop.c:210 [inline]
       loop_set_status+0x94a/0xb90 drivers/block/loop.c:1306
       loop_set_status64 drivers/block/loop.c:1415 [inline]
       lo_ioctl+0x729/0x26d0 drivers/block/loop.c:1582
       blkdev_ioctl+0x277/0x6d0 block/ioctl.c:698
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  uevent_sock_mutex --> fs_reclaim --> &q->q_usage_counter(io)#22

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#22);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#22);
  lock(uevent_sock_mutex);

 *** DEADLOCK ***

3 locks held by syz.5.738/7855:
 #0: ffff8880259e4b68 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_set_status+0x2a/0xb90 drivers/block/loop.c:1275
 #1: ffff888025874ea8 (&q->q_usage_counter(io)#22){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215
 #2: ffff888025874ee0 (&q->q_usage_counter(queue)#21){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215

stack backtrace:
CPU: 0 UID: 0 PID: 7855 Comm: syz.5.738 Not tainted 6.14.0-syzkaller-10764-gaa918db707fb #0 PREEMPT(full) 
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
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:732
 uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
 kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 kobject_uevent_env+0xb36/0x1870 lib/kobject_uevent.c:608
 set_capacity_and_notify+0x1ca/0x240 block/genhd.c:102
 loop_set_size drivers/block/loop.c:210 [inline]
 loop_set_status+0x94a/0xb90 drivers/block/loop.c:1306
 loop_set_status64 drivers/block/loop.c:1415 [inline]
 lo_ioctl+0x729/0x26d0 drivers/block/loop.c:1582
 blkdev_ioctl+0x277/0x6d0 block/ioctl.c:698
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f74ac58d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f74ad427038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f74ac7a5fa0 RCX: 00007f74ac58d169
RDX: 00002000000007c0 RSI: 0000000000004c04 RDI: 0000000000000006
RBP: 00007f74ac60e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f74ac7a5fa0 R15: 00007ffc990fb088
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
