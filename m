Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9462C0271
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764797306; cv=none; b=tKoW0w7aiJXp+J9ngnqWQFLdmdaTRBhiRcuTe1/dvhZIkHQ0h9sxepwCjiLFRRigKuySH0USe2RATP/phgvcQdsDEMSJnBVPFXKZkMFKQHF2Crfvg22Z9zL2VdzVvTixsSD7J26WqNxgDkcYrjFBeSURve1nENzgVOVQ8Y1IKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764797306; c=relaxed/simple;
	bh=f+K+aX/mNBZb+LG8JROmAZQAidoAsW+ASV4BgI9gvbo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=evDpugToYEFM1uPs8tndM9eMVi0f+QRk1wyxSbdMmK5ddshyYlKUEZvUmMY0snh3Baq/9nOVtmh+Kfv40i448is9FaFZSRXTModVNwQyxkxRCtozdp9rUVirSanluuRV5s296XIIxXnSQCUEJ2W/xMRfXSiSkXtbr1BjwkfIh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4510650af52so262480b6e.3
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 13:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764797303; x=1765402103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dZlUS5HZ27P8V3O7na3VnTbdQVdrVSsz2kOKYSMpJM=;
        b=iq0aWVAYs4Sb1Jx5r/X++pD6VQw/CvXywAukc/67Gn6WEPNZ2GCqz6tLoQ+b4YcG45
         MSZc47KPZWXeR5wcX3Qa7I/XIPP5zYiI5qSwj11DQfbeBEPLH7uCjJCK7ZNF3mJfHbfB
         tQOY0xprgWS+kNG4cMHNbF9pSOTmjaL4tgfoAuXoPoSN8w15uQTUh+TrwpUQVggZQJl9
         N0C/nPahAJ8O8lwwvyIX5HsAO3A/aE/xLOhaAuK3UTo6FDK54MCoDpxDHOE2THN4Tqcb
         TBF3PScXqewp/Q16EJ8jA7q6dgBapPoL1+D8DaLAef9wpnYVrtSBbfqdNCL3HPafaFUs
         8cXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1dGR10g+RbxFW3o2TJS0DFELlxHyZ9bmfsa7APGsrkrl9XoMH8AcFirwQxcmWJ+fgw4F7jEgZd+za6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQ/6eapg65v8IODBcwmgaU3CCS4j8DC/oDS9b06nYFffhyebi
	Og0LeI5+n4tMyo7D27NNTa0sJ5jOcMB92W0t/myHKlvR6Su7yJFDfttJBNTk/zPTjycpCxavrUn
	LB7cuY4ArYKty7gsggeTd/y2AYngVTe0HYkaw45oRbv/+UmCOEJ+GXsWUxJo=
X-Google-Smtp-Source: AGHT+IHuuOng1zmi6ftbhBwdcHCse0fRadUnYIQlAovoDUEWD84+PjonPKDcCUKMhrWrnj2/hSVLJJoqxG1c7GeCCDOII2xr74Ye
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2216:b0:450:275c:87d8 with SMTP id
 5614622812f47-45379e492demr300558b6e.32.1764797302965; Wed, 03 Dec 2025
 13:28:22 -0800 (PST)
Date: Wed, 03 Dec 2025 13:28:22 -0800
In-Reply-To: <000000000000cf2c4c061ee07a3d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6930ab76.a70a0220.d98e3.01ba.GAE@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in read_part_sector (2)
From: syzbot <syzbot+82de77d3f217960f087d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4de44542991e Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1525f512580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0b6a854526a37e
dashboard link: https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1764d4c2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/780f42d09193/disk-4de44542.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/953583251b3f/vmlinux-4de44542.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0cbf55634459/bzImage-4de44542.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82de77d3f217960f087d@syzkaller.appspotmail.com

INFO: task udevd:5881 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:21736 pid:5881  tgid:5881  ppid:5195   task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 io_schedule+0x80/0xd0 kernel/sched/core.c:7871
 folio_wait_bit_common+0x6b0/0xb80 mm/filemap.c:1330
 folio_put_wait_locked mm/filemap.c:1494 [inline]
 do_read_cache_folio+0x1aa/0x590 mm/filemap.c:4019
 read_mapping_folio include/linux/pagemap.h:999 [inline]
 read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
 adfspart_check_POWERTEC+0x8c/0xf30 block/partitions/acorn.c:454
 check_partition block/partitions/core.c:141 [inline]
 blk_add_partitions block/partitions/core.c:589 [inline]
 bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
 blkdev_get_whole+0x380/0x510 block/bdev.c:748
 bdev_open+0x31e/0xd30 block/bdev.c:957
 blkdev_open+0x457/0x600 block/fops.c:701
 do_dentry_open+0x953/0x13f0 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1097
 do_open fs/namei.c:3975 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4134
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4c282a7407
RSP: 002b:00007ffdb4725950 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f4c2895a880 RCX: 00007f4c282a7407
RDX: 00000000000a0800 RSI: 00005636cc3d6810 RDI: ffffffffffffff9c
RBP: 00005636cc376910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00005636cc38b830
R13: 00005636cc384190 R14: 0000000000000000 R15: 00005636cc38b830
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3d6e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3d6e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8df3d6e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
1 lock held by klogd/5184:
 #0: ffff8880b883a218 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:638
2 locks held by getty/5586:
 #0: ffff88803332b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by udevd/5881:
 #0: ffff888144370358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:945
2 locks held by dhcpcd/28194:
 #0: ffff88807a754260 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1700 [inline]
 #0: ffff88807a754260 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcd0 net/packet/af_packet.c:3197
 #1: ffffffff8df43178 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
 #1: ffffffff8df43178 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f6/0x730 kernel/rcu/tree_exp.h:957
2 locks held by syz.0.10501/28195:
 #0: ffff888060739908 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
 #0: ffff888060739908 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:661 [inline]
 #0: ffff888060739908 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1455
 #1: ffffffff8df43178 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
 #1: ffffffff8df43178 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x3b9/0x730 kernel/rcu/tree_exp.h:957

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 28198 Comm: syz.0.10502 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:400
Code: e8 3e 09 ab fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 cf cc 10 fd 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f c3 cc cc cc cc cc 44 89 f9 80 e1 07
RSP: 0018:ffffc9000dc5eb70 EFLAGS: 00000002
RAX: 1ffffffff335f300 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: ffffffff99afa1d0 R08: ffff888143300237 R09: 1ffff11028660046
R10: dffffc0000000000 R11: ffffffff8514fa20 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff99af9f40 R15: 0000000000000000
FS:  00007f3e13a0b6c0(0000) GS:ffff88812612e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001ac0 CR3: 000000001b6d8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr+0x1a1/0x2f0 drivers/tty/serial/8250/8250_port.c:1961
 fifo_wait_for_lsr drivers/tty/serial/8250/8250_port.c:3234 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3257 [inline]
 serial8250_console_write+0x134c/0x1ba0 drivers/tty/serial/8250/8250_port.c:3342
 console_emit_next_record kernel/printk/printk.c:3111 [inline]
 console_flush_all+0x6f3/0xb10 kernel/printk/printk.c:3199
 __console_flush_and_unlock kernel/printk/printk.c:3258 [inline]
 console_unlock+0xbb/0x190 kernel/printk/printk.c:3298
 vprintk_emit+0x4c5/0x590 kernel/printk/printk.c:2423
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 nbd_genl_connect+0x9b0/0x18f0 drivers/block/nbd.c:2141
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e12b8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3e13a0b038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3e12de5fa0 RCX: 00007f3e12b8f749
RDX: 0000000020000000 RSI: 0000200000001ac0 RDI: 0000000000000005
RBP: 00007f3e12c13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3e12de6038 R14: 00007f3e12de5fa0 R15: 00007fff079ed2f8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
