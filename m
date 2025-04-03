Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006519C558
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669267; cv=none; b=Ywm27v2WLfonUKjySXjANz4xYj6jOjHNLbjCx5/aAOF+KjDjA3u91GTEut/DpcnUTMf1qQfZ2RgyvJ0OB8L890gQguhllGn569b6TbvabR7LmP2XLvarBVgJO0DSPA/79FJZNQxsM6X2ue/m7vi9CcODn1a0g7TrvB1uVmXwTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669267; c=relaxed/simple;
	bh=Os64dDL4fdbaJ0OtgQLdb+EBopDm4qug5PRmFzn8/qw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T543K2D5LLssWdOKHK0yzwXqo5nCs5NtoLp1JC+vU2vSZjEfWgug1CZ8w2475Htzxk9wJgtgk329kDmnQ3h79CxuQLPUrs33klYKX5tSI8hzHwFuahIiGqIuqN2Txj2SmIkUgmsyTE3wGKuMQYwmgxLqoZQL9pjwzeaMdUETt70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d458e61faaso7908025ab.0
        for <linux-block@vger.kernel.org>; Thu, 03 Apr 2025 01:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743669265; x=1744274065;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOMqihNPVzS31r1t9c+x+ekSMUYUpXWeipZaaZGDe4U=;
        b=Stn5mrXBrO4P6oJF3QJ01Qa3BA8AHOoL0bWHhT9kRXPF6GV+QmfPDcelazyiekCq2a
         xg6/TciAOQS0cyh/oTj0setXrSs0ggqebxBZiF+11SAtdMKVpLh5cJ7QS+8a1TgOQmeR
         Kuh+I9dvM4m5Xmjkgl7khs9+OTp5GAK5hzdHLp/kz/6RR63LEgpK+F9dbjr/SU6jzAbK
         +77PrGQJEbVZzcXICaPect67aQa5Yrxx3Xu8MLN9jMJmoLnnLnt36C/lUuJnbIEoN3r/
         yivHGof0n0IJIcv5BodcB+M9xHejvyo2oygy1qIDmOoZCYtvdNQMO68WJE8Aha9L3Tar
         9J2w==
X-Forwarded-Encrypted: i=1; AJvYcCWlvpQhMSKy8z53F868QM3mhvhpfVHJSaCR9wu0LxJJj0Ks16eBgK1+x/3EIZYr/YU8mjInI+2lwvkyNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fBDN2vyQsVPl2TKPKECKAI3l2327ECIt1j7J4GL6H9d3Koox
	UKrHHDIkg2HPB5kMaCA6qNQOJEx7MoFAG2DkSmeoT/anzzzpvOlYm6pf1t8+mSP6hKsCQhbiI0l
	zwMzYLLlYTzIyXo+BYcR3jH9+GS6QEb0ZJO4/Q8v/9Qo90WbGi3sgPLU=
X-Google-Smtp-Source: AGHT+IF8666uAbezsqgMerCBMkWt+Hogg0famXNzMMnPgOPyRQRLhjZS4ylUC0XOJXjpzL0ykwyDkBYr1UeLmTknPB8ie5brafmE
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b707:0:b0:3d4:2306:fbb6 with SMTP id
 e9e14a558f8ab-3d6dcbb773bmr22404045ab.10.1743669264809; Thu, 03 Apr 2025
 01:34:24 -0700 (PDT)
Date: Thu, 03 Apr 2025 01:34:24 -0700
In-Reply-To: <67ea99e0.050a0220.3c3d88.0042.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ee4810.050a0220.9040b.016e.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_freeze_queue_nomemsave
From: syzbot <syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a1b5bd45d4ee Merge tag 'usb-6.15-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1711cfb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adffebefc9feb9d6
dashboard link: https://syzkaller.appspot.com/bug?extid=9dd7dbb1a4b915dee638
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ee494c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13df5998580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-a1b5bd45.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/588b4d489b63/vmlinux-a1b5bd45.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51ead797f7ae/bzImage-a1b5bd45.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-syzkaller-12886-ga1b5bd45d4ee #0 Not tainted
------------------------------------------------------
syz-executor170/5939 is trying to acquire lock:
ffffffff906953a8 (uevent_sock_mutex){+.+.}-{4:4}, at: uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
ffffffff906953a8 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
ffffffff906953a8 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_env+0xb36/0x1870 lib/kobject_uevent.c:608

but task is already holding lock:
ffff888025aa6228 (&q->q_usage_counter(io)#24){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#24){++++}-{0:0}:
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
       __fs_reclaim_acquire mm/page_alloc.c:4028 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4042
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4102 [inline]
       slab_alloc_node mm/slub.c:4180 [inline]
       kmem_cache_alloc_node_noprof+0x57/0x3b0 mm/slub.c:4252
       __alloc_skb+0x2b2/0x380 net/core/skbuff.c:658
       alloc_skb include/linux/skbuff.h:1340 [inline]
       alloc_uevent_skb+0x7d/0x210 lib/kobject_uevent.c:289
       uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
       kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
       kobject_uevent_env+0xca4/0x1870 lib/kobject_uevent.c:608
       kobject_synth_uevent+0x7d4/0x8a0 lib/kobject_uevent.c:207
       bus_uevent_store+0x3d/0x90 drivers/base/bus.c:832
       bus_attr_store+0x71/0xb0 drivers/base/bus.c:172
       sysfs_kf_write+0xef/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x351/0x510 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:591 [inline]
       vfs_write+0x5ba/0x1180 fs/read_write.c:684
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
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
       kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
       kobject_uevent_env+0xb36/0x1870 lib/kobject_uevent.c:608
       loop_set_size drivers/block/loop.c:211 [inline]
       loop_set_size drivers/block/loop.c:208 [inline]
       loop_set_status+0x9c7/0xb90 drivers/block/loop.c:1306
       loop_set_status_old+0x162/0x1d0 drivers/block/loop.c:1405
       lo_ioctl+0x695/0x26d0 drivers/block/loop.c:1575
       blkdev_ioctl+0x274/0x6d0 block/ioctl.c:698
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  uevent_sock_mutex --> fs_reclaim --> &q->q_usage_counter(io)#24

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#24);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#24);
  lock(uevent_sock_mutex);

 *** DEADLOCK ***

3 locks held by syz-executor170/5939:
 #0: ffff888025c4fb68 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_set_status+0x2a/0xb90 drivers/block/loop.c:1275
 #1: ffff888025aa6228 (&q->q_usage_counter(io)#24){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215
 #2: ffff888025aa6260 (&q->q_usage_counter(queue)#20){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:215

stack backtrace:
CPU: 0 UID: 0 PID: 5939 Comm: syz-executor170 Not tainted 6.14.0-syzkaller-12886-ga1b5bd45d4ee #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
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
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
 uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
 kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 kobject_uevent_env+0xb36/0x1870 lib/kobject_uevent.c:608
 loop_set_size drivers/block/loop.c:211 [inline]
 loop_set_size drivers/block/loop.c:208 [inline]
 loop_set_status+0x9c7/0xb90 drivers/block/loop.c:1306
 loop_set_status_old+0x162/0x1d0 drivers/block/loop.c:1405
 lo_ioctl+0x695/0x26d0 drivers/block/loop.c:1575
 blkdev_ioctl+0x274/0x6d0 block/ioctl.c:698
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b0284a229
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeda6302f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffeda6304c8 RCX: 00007f5b0284a229
RDX: 0000200000000080 RSI: 0000000000004c02 RDI: 0000000000000003
RBP: 00007f5b028bd610 R08: 00007ffeda6304c8 R09: 00007ffeda6304c8
R10: 00007ffeda6304c8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffeda6304b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
