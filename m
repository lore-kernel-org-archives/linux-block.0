Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B1163
	for <linux-block@vger.kernel.org>; Sun, 23 Feb 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740319048; cv=none; b=aZmeQaba3IQ0HKHeN6jsokautmnN0WkUD0kf16QULCvxBVJ2ElRLPDrh0K5Zy114OBfrTz6g9epWzQ5L1KS+u9QBhAbq/Qm7l9lWKpT4x6W8iMi0QmmRorJ0bVseS8H3uoySLpaMYwdyyQMiCmoI8U8S6Lhax5nyR3fYzHkxywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740319048; c=relaxed/simple;
	bh=bbmHql+FRJ1pS09WwC4Owd5pEOGJ7s2Tar00eTSNI+4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h0HDiUu/Ais5wqzqFskepX26QEt6Xz8F/hndHyzgtlG87nUivhCG2Z9FU3FvnYqbrQSWN/2acaYVt/8XbpCbHTDVdt1oSHi6qJooJyvKUyT1WgwLXMEzqi5HPg6XTNKxL87vAae6MbBKC6xmyxPRyHVPFKz3KjpjsISH+nEhJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so76198865ab.0
        for <linux-block@vger.kernel.org>; Sun, 23 Feb 2025 05:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740319045; x=1740923845;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAsXP6p0Kc1LrGSY5zDgeFjFxhpFk/wWGe4ZlvZ2LSw=;
        b=uUBYf8BSmDdtqayPaK0oSvpG3PjnyfhOWgyDknGgKxnj8g5Y+zDBRtw8Kc0Np2FMBz
         443Z5mm5QywYh8tCeTNBo9UQbDy2w/5pXbK28pZE79CH7gUrnzikCLcbM+Miwhmy6NwF
         EzXaWZbyyXo2xRnT3QC9vc6G+yOO24S03aY1fZSnsfS9XSaEY9jrkdz1z7s21546JTLY
         XPrmOKy2oL7+hK+5XmDZXftZDaIpelQIVSQNwHEi0jy3oOVVQ8kRP7nWXHmv4hzccoEQ
         XAfgif2cZZdjGvKwdlQtpW6JGwPF9b1OJfqSUFf2XSL1R1S/AEGXG2/mjvSD/Sp4ZITt
         4BLw==
X-Forwarded-Encrypted: i=1; AJvYcCVo1twSRzEvfxGEnJ16oHY/IypaWi/CN16riVtkpbUu/a+F9XxDp4iE69qe/N/gV/rEwZwG8iyOu6kUvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKKqWdJL6jbLNx28VJ28NwaVOSqlP/fevNGzNTwZGkmN+M30p
	VaJvpzyXWByuo6mnFQqYcwopnockPByFsGBUuChl8XCUyU5Ucir2W6y5qBks5CpuyfMz43EjOrq
	CpZ9krqrxDQFsJessHrAHp+yzwknwbPX/+WxIN/nhM//OmuBOlVMyXkk=
X-Google-Smtp-Source: AGHT+IFFKzpl8aysTMsF9IOElcFuY2+I2wTJyXK9DhmKS1MtMWKtRlH+u2OFw9CMNfjfLY9cB0gJn+92MiCetKnu/z4ZfixV/6Xs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caa:b0:3d0:21f0:98f3 with SMTP id
 e9e14a558f8ab-3d2cb545cb9mr89311175ab.21.1740319045460; Sun, 23 Feb 2025
 05:57:25 -0800 (PST)
Date: Sun, 23 Feb 2025 05:57:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bb2945.050a0220.bbfd1.0027.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in sync_bdevs (3)
From: syzbot <syzbot+97bc0b256218ed6df337@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    27102b38b8ca Merge tag 'v6.14-rc3-smb3-client-fix-part2' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141867a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b50606b738b9b4cc
dashboard link: https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e4a4cb1d821f/disk-27102b38.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b202823ad5c/vmlinux-27102b38.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b275a1e58dd4/bzImage-27102b38.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97bc0b256218ed6df337@syzkaller.appspotmail.com

INFO: task syz.9.1460:12718 blocked for more than 143 seconds.
      Not tainted 6.14.0-rc3-syzkaller-00295-g27102b38b8ca #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.9.1460      state:D stack:26360 pid:12718 tgid:12712 ppid:11416  task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6914
 __mutex_lock_common kernel/locking/mutex.c:662 [inline]
 __mutex_lock+0x817/0x1010 kernel/locking/mutex.c:730
 sync_bdevs+0x1ae/0x340 block/bdev.c:1246
 ksys_sync+0xe2/0x1c0 fs/sync.c:105
 __do_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff23d38d169
RSP: 002b:00007ff23e2a4038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007ff23d5a6080 RCX: 00007ff23d38d169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ff23d5a6080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff23d5a6080 R15: 00007ffd923384c8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6746
2 locks held by dhcpcd/5493:
 #0: ffffffff8feba148 (vlan_ioctl_mutex){+.+.}-{4:4}, at: sock_ioctl+0x661/0x8e0 net/socket.c:1280
 #1: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: vlan_ioctl_handler+0x112/0x9d0 net/8021q/vlan.c:553
2 locks held by getty/5589:
 #0: ffff8880358380a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x616/0x1770 drivers/tty/n_tty.c:2211
5 locks held by kworker/u8:25/6689:
 #0: ffff88801beed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801beed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18e0 kernel/workqueue.c:3317
 #1: ffffc90003587c60 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90003587c60 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3317
 #2: ffffffff8fec8a10 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x17a/0xd60 net/core/net_namespace.c:606
 #3: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_batch+0xdc/0x880 net/core/dev.c:12423
 #4: ffffffff8eb3e438 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:302 [inline]
 #4: ffffffff8eb3e438 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x381/0x820 kernel/rcu/tree_exp.h:996
3 locks held by kworker/u8:27/6698:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18e0 kernel/workqueue.c:3317
 #1: ffffc90003517c60 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90003517c60 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3317
 #2: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:285
2 locks held by kworker/1:8/7442:
3 locks held by kworker/u8:19/9812:
 #0: ffff88814d158948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88814d158948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18e0 kernel/workqueue.c:3317
 #1: ffffc90004a5fc60 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90004a5fc60 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3317
 #2: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:129 [inline]
 #2: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x10e/0x16a0 net/ipv6/addrconf.c:4190
1 lock held by udevd/10037:
 #0: ffff888025c624c8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf0/0xc50 block/bdev.c:903
2 locks held by syz-executor/11273:
 #0: ffff8880b863e958 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:606
 #1: ffff8880b8728948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x41d/0x7a0 kernel/sched/psi.c:987
1 lock held by syz.9.1460/12718:
 #0: ffff888025c624c8 (&disk->open_mutex){+.+.}-{4:4}, at: sync_bdevs+0x1ae/0x340 block/bdev.c:1246
1 lock held by syz-executor/13586:
 #0: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:335 [inline]
 #0: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc55/0x1d30 net/core/rtnetlink.c:4021
2 locks held by syz-executor/13681:
 #0: ffffffff8f6528e0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8f6528e0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8f6528e0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:564
 #1: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:335 [inline]
 #1: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc55/0x1d30 net/core/rtnetlink.c:4021
1 lock held by syz-executor/13696:
 #0: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:335 [inline]
 #0: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc55/0x1d30 net/core/rtnetlink.c:4021
1 lock held by syz-executor/13727:
 #0: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:335 [inline]
 #0: ffffffff8fed51c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc55/0x1d30 net/core/rtnetlink.c:4021

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.14.0-rc3-syzkaller-00295-g27102b38b8ca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:236 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:399
 kthread+0x7ab/0x920 kernel/kthread.c:464
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 975 Comm: kworker/u8:6 Not tainted 6.14.0-rc3-syzkaller-00295-g27102b38b8ca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: bat_events batadv_nc_worker
RIP: 0010:mark_lock+0x12c/0x360 kernel/locking/lockdep.c:4729
Code: c7 c7 e0 a2 2a 8c 48 c7 c6 e0 a5 2a 8c e8 5c 51 e4 ff 90 0f 0b 90 90 90 31 db 48 83 c3 60 48 89 d8 48 c1 e8 03 42 80 3c 28 00 <74> 08 48 89 df e8 da cd 8b 00 41 bc 01 00 00 00 44 85 33 74 16 44
RSP: 0018:ffffc90003d4f808 EFLAGS: 00000046
RAX: 1ffffffff27d8625 RBX: ffffffff93ec3128 RCX: ffffffff819d29ca
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff94549840
RBP: 0000000000000009 R08: ffffffff94549847 R09: 1ffffffff28a9308
R10: dffffc0000000000 R11: fffffbfff28a9309 R12: ffff88802660e4d4
R13: dffffc0000000000 R14: 0000000000000200 R15: ffff88802660e540
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f7c979178 CR3: 000000003149a000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 mark_usage kernel/locking/lockdep.c:4672 [inline]
 __lock_acquire+0xc3e/0x2100 kernel/locking/lockdep.c:5182
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0xec/0x610 net/batman-adv/network-coding.c:719
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xac0/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7ab/0x920 kernel/kthread.c:464
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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
