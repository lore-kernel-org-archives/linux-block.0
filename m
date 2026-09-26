Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A135202A
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790394219; cv=none; b=BHaAq+m/n7ThMe4ncHgnw2QZaDgVQpyEMQ+OJCxoi7oyf/kP1+tZPih5GTfV0dD2J5PgvtTVtELgJY6PdBfuElZH9sG3JU0Q6WwfJjERS/Jbve5AIyte4nKZcROcy7IovDbwrsmEBD2KLIWJhNTNDkjQDffVmErMOHmgrmzbblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790394219; c=relaxed/simple;
	bh=wWM7R5ZQsiSnbrgcOHKR9c/zY1X8rLuCD5XcSaVI3j8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Dvy/aj9exL1xYP5EqXZdS2yu0TWdqisFY0qQ8syVZPJLUs5BNYQ/5jhHb8NqVqVlfWyjFAwEUKyw1Xz5VBhT+Dj+jC2ADogKP1kR65X+3CB5zIfr4QkVZ505cvyzFclxqJaYY4Z+eobtN9oYB+kbVEPXjiJdy20r1pYpAq37VmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b2f2b8d88fso2669025b6e.2
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 20:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790394214; x=1790999014;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2z6tUl0ZMVMS5NVheiYbVnlHfU4wooxdjmTT4h9Zss=;
        b=k2dhFkVy18fOPYrf/y+ddy2Kepypau3mKgi4YPxIw6qu2f63/f+DXSjmlJ/rHPnSnN
         l69JQy4D9FtV2BF3IvL0Cbf/oTVbxJ9Za0Mcwzje4fkdw5yF3yptSwedqonZXQudHMM3
         xSK05YYeu/M+C5J05uQLXC0lHvr6h6wwtPT7yV5St10aNKHTYMgPW4YLNPe0NidlXSqX
         8IcyY8+MY+4xkXZEOEL8hMvovDTjp/YvAsXA5QSoGUpDzYMP3WGlOzcbwKY9uSXIgprK
         FlXtsA9u/p/urBVJC/JvYWirIEtchJcPSilKvJw+el1AFynCkVJu/2D18SqCkS7Fj1IR
         SBaA==
X-Forwarded-Encrypted: i=1; AKwUvByK9sKJ27XeoicOe4G7G3/kErJjVb5NHzGKTm5TSdRFChWcStI9v9t3u3spZI2RzIT8SNqZF+10OwaPyA==@vger.kernel.org
X-Gm-Message-State: AFuF++l7Cd60j7XCLOC6/kOfDfRERe+6NPwx5tInu1JLqblQ3pKsng6p
	gkYV4N5/QDRM5iGAl6PegiYAwPWi+CJI5nlTEBiF7kRv3WvpRK2ND+eT1Ua1xNh50LTIQqdRerK
	14UTJ22kpzgwrAbEeXSueEwhII5IlC9ISgoY13Qpg2OeS29giE2qXZJ45ooo=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:244d:b0:4cb:f21c:a794 with SMTP id
 5614622812f47-4d72982faf8mr8432441b6e.28.1790394213837; Fri, 25 Sep 2026
 20:43:33 -0700 (PDT)
Date: Fri, 25 Sep 2026 20:43:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab73f65.80e1c6cc.1e8e5f.0041.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in __bio_queue_enter (3)
From: syzbot <syzbot+90895f5bfaa7243c2d20@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    12fec40907fa Merge tag 'nf-26-09-18' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1112c515580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3be6e434b07ebb6
dashboard link: https://syzkaller.appspot.com/bug?extid=90895f5bfaa7243c2d20
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f7525580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12213805580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a49602a7524f/disk-12fec409.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62c2686deb3b/vmlinux-12fec409.xz
kernel image: https://storage.googleapis.com/syzbot-assets/22e54abf9b3b/bzImage-12fec409.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90895f5bfaa7243c2d20@syzkaller.appspotmail.com

INFO: task udevd:5676 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:25736 pid:5676  tgid:5676  ppid:4984   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7277
 __schedule_loop kernel/sched/core.c:7354 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7369
 __bio_queue_enter+0x369/0x7f0 block/blk-core.c:396
 bio_queue_enter block/blk.h:99 [inline]
 blk_mq_submit_bio+0x776/0x2a70 block/blk-mq.c:3127
 __submit_bio_noacct_mq block/blk-core.c:756 [inline]
 submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:790
 bh_submit fs/buffer.c:1146 [inline]
 block_read_full_folio+0x581/0x810 fs/buffer.c:2359
 filemap_read_folio+0x12c/0x3a0 mm/filemap.c:2520
 do_read_cache_folio+0x354/0x590 mm/filemap.c:4156
 read_mapping_folio include/linux/pagemap.h:1015 [inline]
 read_part_sector+0xb6/0x2b0 block/partitions/core.c:724
 adfspart_check_ICS+0xb1/0x960 block/partitions/acorn.c:357
 check_partition block/partitions/core.c:143 [inline]
 blk_add_partitions block/partitions/core.c:591 [inline]
 bdev_disk_changed+0x851/0x17a0 block/partitions/core.c:695
 blkdev_get_whole+0x372/0x510 block/bdev.c:793
 bdev_open+0x324/0xd70 block/bdev.c:1002
 blkdev_open+0x461/0x600 block/fops.c:674
 do_dentry_open+0x816/0x1380 fs/open.c:996
 vfs_open+0x3b/0x340 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x1443/0x1d60 fs/namei.c:5000
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f77b02a7407
RSP: 002b:00007ffe9ad1c750 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f77b0965880 RCX: 00007f77b02a7407
RDX: 00000000000a0800 RSI: 000055a197e52f80 RDI: ffffffffffffff9c
RBP: 000055a197e39910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000055a197e4dba0
R13: 000055a197e47190 R14: 0000000000000000 R15: 000055a197e4dba0
 </TASK>
INFO: task syz.0.17:5845 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:24640 pid:5845  tgid:5844  ppid:5783   task_flags:0x480140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7277
 __schedule_loop kernel/sched/core.c:7354 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7369
 blk_mq_freeze_queue_wait+0x101/0x180 block/blk-mq.c:191
 blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 queue_limits_commit_update_frozen+0x55/0xd0 block/blk-settings.c:590
 nbd_set_size+0x4c5/0x7d0 drivers/block/nbd.c:383
 nbd_genl_size_set drivers/block/nbd.c:2111 [inline]
 nbd_genl_reconfigure+0x7e1/0x1040 drivers/block/nbd.c:2444
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2575
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2713
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
 __sys_sendmsg net/socket.c:2799 [inline]
 __do_sys_sendmsg net/socket.c:2804 [inline]
 __se_sys_sendmsg net/socket.c:2802 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2802
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5d2239e159
RSP: 002b:00007f5d232a7028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5d22625fa0 RCX: 00007f5d2239e159
RDX: 0000000000040080 RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007f5d2243506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5d22626038 R14: 00007f5d22625fa0 R15: 00007fff9d2e9788
 </TASK>

Showing all locks held in the system:
locks held by khungtaskd/31: 1, last CPU#0:
 #0: ffffffff8ed5c8e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c8e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c8e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6871
locks held by getty/5374: 2, on CPU#1:
 #0: ffff88803565e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000322b2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by udevd/5676: 1, on CPU#0:
 #0: ffff888025b18350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xde/0xd70 block/bdev.c:990
locks held by syz.0.17/5845: 6, on CPU#0:
 #0: ffffffff902c4448 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
 #2: ffff888025a59260 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_genl_reconfigure+0x4a6/0x1040 drivers/block/nbd.c:2435
 #3: ffff888025c90fe8 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:1101 [inline]
 #3: ffff888025c90fe8 (&q->limits_lock){+.+.}-{4:4}, at: nbd_set_size+0x284/0x7d0 drivers/block/nbd.c:375
 #4: ffff888025c909b0 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 #4: ffff888025c909b0 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: queue_limits_commit_update_frozen+0x55/0xd0 block/blk-settings.c:590
 #5: ffff888025c909e8 (&q->q_usage_counter(queue)#33){+.+.}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 #5: ffff888025c909e8 (&q->q_usage_counter(queue)#33){+.+.}-{0:0}, at: queue_limits_commit_update_frozen+0x55/0xd0 block/blk-settings.c:590
locks held by syz-executor/5847: 2, on CPU#1:
 #0: ffffffff902c4448 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
locks held by syz-executor/5871: 2, on CPU#1:
 #0: ffffffff902c4448 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
locks held by syz-executor/5897: 2, on CPU#1:
 #0: ffffffff902c4448 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff902c4280 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:123
 nmi_trigger_cpumask_backtrace+0x17d/0x390 lib/nmi_backtrace.c:66
 trigger_all_cpu_backtrace include/linux/nmi.h:164 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: ac 88 02 c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d b3 c1 23 00 fb f4 <e9> 8c 08 03 00 cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffc900001a7e40 EFLAGS: 00000246
RAX: 00000000000caff3 RBX: ffffffff819bb370 RCX: 8000000000000001
RDX: 0000000000000001 RSI: ffffffff8e4140f9 RDI: ffffffff8c6da080
RBP: ffffc900001a7f10 R08: ffff8880b8733a1b R09: 1ffff110170e6743
R10: dffffc0000000000 R11: ffffed10170e6744 R12: 0000000000000000
R13: 1ffff11003cd1bb8 R14: 1ffff92000034fd0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124dce000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7e3889e9c CR3: 000000000eb48000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/kernel/process.c:767 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:768
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x2e0/0x540 kernel/sched/idle.c:355
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:454
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x157
 </TASK>


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
