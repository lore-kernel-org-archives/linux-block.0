Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328531E8345
	for <linux-block@vger.kernel.org>; Sun, 20 Apr 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745151689; cv=none; b=Afo742KtTMrsCaEqgW9spMZWWMDQgaGviTWU2TGrCPU6cYz5jImLwdEYktWtxcj+rHXqphG+Oedmb0+yH5a2smmgPd4GUVtHsY0XdT6sveKQ8j/ZZQpjUNaTk66qpnhxEreupySm83ZA2JYk3tQZtKRTZ3FGuBbI+bgy0vqwL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745151689; c=relaxed/simple;
	bh=ztFEzRnjVhIndfKf6vw0XEWAJPubIKG8eS6DKW8QIkw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gr2syjY6PyFyLxDZ05d+DQ4BzWGbVakBeu4VMxDe6xKBTTDjup6+xQhzkM0u1gSERehKi3NQgX4HCR3ICcP3wK7hnGYRyF3LGoIzQsLxFvbaHHA5pWaMxhiTbeG16oNWWFPoX3bZbQRthjJdy3SCDe5Ti2X1U4ZHrciym7faYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43d3338d7so60441635ab.0
        for <linux-block@vger.kernel.org>; Sun, 20 Apr 2025 05:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745151686; x=1745756486;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03P9UkrpSbqv75RkUB1qqxFHQXqXBFS9amv2g3lrgac=;
        b=jGUmaYCmYhjzCycsh7dfDl24udA713BPb+d5j0u713UHQU2UoRZHIhDCKG1sPqVYeG
         Mj/prDFelpweleffKoD8MatQ6jnHuP9rl11CPCaZ23AuUa09mUUB07CGbO9t6TssOJds
         l4kATxehws05bmedAPCoW+0IovDtesuhbbYi8EGyUm3t0jYL2Dkby9ED6WGuUw6tjiBX
         U5+VVzIpRLBOcuZRePxq9OcJcLHOsofPyK5kB0UDTVY8oVltoohU48ulaN50XN1ZUNgT
         MArWuLOcAHtFE+ApUhO8PO9g/yRRGkqjG/HEt5dLgUuuv3+LFUkScSMgT4lYJVJF665l
         X7gg==
X-Forwarded-Encrypted: i=1; AJvYcCVd9WM0h5UKR3WHb1Os1tgQ0FOUv5zAo+sF55TuEM7CbX/C6TLidbafWTOgKWKmTiaH/4K0y70yStZpZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF2PkLtI59EQAgPuo+iqVBXIPAJ6D4Di+sbgGL+ltPcvdfkEZx
	+OFwH9uPznzMI5mm8wwgJKHAlVAVnKWz2/NbfkUNK/uNDG5t9J5l8CUE/5ZV4meCN3aQYxspItb
	Wwh8eA/xx2VbZ+bYxSWzcEEaNg/pNLO4CTDNBKHZrGQ8QKbZLbuk8fwc=
X-Google-Smtp-Source: AGHT+IEHj0x10FexwFCp/AQFUpSzQsNrIr/jcwObWiUuQJ+6wypnaw+08MIVB4mIiZBgT+ONsuS7qtWtWCjbOBaT4Vg6Ib3I0z4b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:3d3:d132:2ce8 with SMTP id
 e9e14a558f8ab-3d88eda88a0mr70417595ab.9.1745151686364; Sun, 20 Apr 2025
 05:21:26 -0700 (PDT)
Date: Sun, 20 Apr 2025 05:21:26 -0700
In-Reply-To: <00000000000035b2ce06197bd027@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6804e6c6.050a0220.243d89.0032.GAE@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_open
From: syzbot <syzbot+5c6179f2c4f1e111df11@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    119009db2674 Merge tag 'vfs-6.15-rc3.fixes.2' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cc4c70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6bd70427e8b567f
dashboard link: https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168f7bac580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c746991d9a8/disk-119009db.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7dc89ed0561e/vmlinux-119009db.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4412f446b5ee/bzImage-119009db.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d5121c60f666/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c6179f2c4f1e111df11@syzkaller.appspotmail.com

INFO: task udevd:5846 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc2-syzkaller-00471-g119009db2674 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:23512 pid:5846  tgid:5846  ppid:5202   task_flags:0x400140 flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1b33/0x51f0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x163/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 __mutex_lock_common kernel/locking/mutex.c:678 [inline]
 __mutex_lock+0x805/0x10c0 kernel/locking/mutex.c:746
 bdev_open+0xf7/0xcd0 block/bdev.c:907
 blkdev_open+0x38e/0x4e0 block/fops.c:652
 do_dentry_open+0xdec/0x1960 fs/open.c:956
 vfs_open+0x3b/0x370 fs/open.c:1086
 do_open fs/namei.c:3880 [inline]
 path_openat+0x2caf/0x35d0 fs/namei.c:4039
 do_filp_open+0x284/0x4e0 fs/namei.c:4066
 do_sys_openat2+0x12b/0x1d0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x249/0x2a0 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc5ff7169a4
RSP: 002b:00007ffc6e4b2f70 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc5ff7169a4
RDX: 0000000000080000 RSI: 000055b8bd28da40 RDI: 00000000ffffff9c
RBP: 000055b8bd28da40 R08: 000055b8bd2822c0 R09: 00007fc5ff7f1c10
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055b8bd2822c0 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
1 lock held by kdevtmpfs/26:
 #0: ffff88801c2e0950 (&type->i_mutex_dir_key/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:902 [inline]
 #0: ffff88801c2e0950 (&type->i_mutex_dir_key/1){+.+.}-{4:4}, at: __kern_path_locked+0x1ca/0x430 fs/namei.c:2765
1 lock held by khungtaskd/31:
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x30/0x180 kernel/locking/lockdep.c:6764
3 locks held by kworker/u8:2/36:
 #0: ffff88814d40b148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88814d40b148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x990/0x18e0 kernel/workqueue.c:3319
 #1: ffffc90000ad7c60 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90000ad7c60 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9cb/0x18e0 kernel/workqueue.c:3319
 #2: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x110/0x16a0 net/ipv6/addrconf.c:4195
3 locks held by kworker/u8:3/53:
 #0: ffff88801b089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801b089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x990/0x18e0 kernel/workqueue.c:3319
 #1: ffffc90000be7c60 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90000be7c60 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x9cb/0x18e0 kernel/workqueue.c:3319
 #2: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:303
5 locks held by kworker/u8:7/2967:
 #0: ffff88801bef3948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801bef3948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x990/0x18e0 kernel/workqueue.c:3319
 #1: ffffc9000b7d7c60 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000b7d7c60 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x9cb/0x18e0 kernel/workqueue.c:3319
 #2: ffffffff900de750 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x17c/0xd60 net/core/net_namespace.c:608
 #3: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_batch+0xde/0x880 net/core/dev.c:12524
 #4: ffffffff8ed43438 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:304 [inline]
 #4: ffffffff8ed43438 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x384/0x830 kernel/rcu/tree_exp.h:998
2 locks held by kworker/u8:8/2985:
 #0: ffff88801b089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801b089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x990/0x18e0 kernel/workqueue.c:3319
 #1: ffffc9000b9f7c60 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000b9f7c60 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9cb/0x18e0 kernel/workqueue.c:3319
1 lock held by udevd/5202:
 #0: ffff888143356358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf7/0xcd0 block/bdev.c:907
2 locks held by getty/5592:
 #0: ffff88803189e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036e32f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x5bb/0x1700 drivers/tty/n_tty.c:2222
1 lock held by udevd/5846:
 #0: ffff8880254c6358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf7/0xcd0 block/bdev.c:907
1 lock held by syz.1.17/6075:
 #0: ffff8880254c6358 (&disk->open_mutex){+.+.}-{4:4}, at: loop_reread_partitions drivers/block/loop.c:435 [inline]
 #0: ffff8880254c6358 (&disk->open_mutex){+.+.}-{4:4}, at: loop_set_status+0x7be/0xb20 drivers/block/loop.c:1243
1 lock held by syz.5.21/6507:
 #0: ffff888143356358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x17e/0x700 block/bdev.c:1090
1 lock held by syz-executor/7129:
 #0: ffff8880254c6358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf7/0xcd0 block/bdev.c:907
1 lock held by syz-executor/7173:
 #0: ffff888143350358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x17e/0x700 block/bdev.c:1090
1 lock held by syz-executor/7195:
 #0: ffff888143352358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x17e/0x700 block/bdev.c:1090
1 lock held by syz-executor/7330:
 #0: ffff888143356358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf7/0xcd0 block/bdev.c:907
1 lock held by syz-executor/7999:
 #0: ffff888143366358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x17e/0x700 block/bdev.c:1090
1 lock held by syz-executor/8148:
 #0: ffff8880254c6358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf7/0xcd0 block/bdev.c:907
1 lock held by syz-executor/8358:
 #0: ffff888143350358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf7/0xcd0 block/bdev.c:907
1 lock held by syz-executor/8620:
 #0: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x831/0x11b0 net/ipv6/addrconf.c:5028
1 lock held by syz.0.36/8685:
 #0: ffff8880254c4358 (&disk->open_mutex){+.+.}-{4:4}, at: loop_reread_partitions drivers/block/loop.c:435 [inline]
 #0: ffff8880254c4358 (&disk->open_mutex){+.+.}-{4:4}, at: loop_set_status+0x7be/0xb20 drivers/block/loop.c:1243
2 locks held by syz-executor/8944:
 #0: ffffffff9060bc38 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff9060bc38 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff9060bc38 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:570
 #1: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xd68/0x1fe0 net/core/rtnetlink.c:4064
2 locks held by syz-executor/8961:
 #0: ffffffff900de750 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:514
 #1: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock_killable include/linux/rtnetlink.h:145 [inline]
 #1: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: register_netdev+0x18/0x50 net/core/dev.c:11123
1 lock held by syz-executor/9091:
 #0: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff900eb288 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x406/0x1c40 net/ipv4/devinet.c:979
1 lock held by modprobe/9199:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc2-syzkaller-00471-g119009db2674 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x4ab/0x4e0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:437
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted 6.15.0-rc2-syzkaller-00471-g119009db2674 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound nsim_dev_trap_report_work
RIP: 0010:lockdep_recursion_finish kernel/locking/lockdep.c:-1 [inline]
RIP: 0010:lock_release+0x204/0x3e0 kernel/locking/lockdep.c:5889
Code: c3 7f d3 4c 89 ef 4c 89 fe 48 8b 54 24 18 e8 d3 3b 00 00 48 8d 1d ac 96 c6 11 4c 8b 34 24 48 c7 c7 f1 7f 4c 8e e8 7c 56 89 0a <b8> ff ff ff ff 65 0f c1 05 af d2 c6 11 83 f8 01 0f 85 bf 00 00 00
RSP: 0000:ffffc900001273a0 EFLAGS: 00000082
RAX: 0000000000000001 RBX: ffffffff93651020 RCX: 0000000000000004
RDX: 0000000000000000 RSI: ffffffff8e4c7ff1 RDI: ffffffff8ca0e180
RBP: ffff88801c680b90 R08: ffffc9000012753f R09: 0000000000000000
R10: ffffc90000127530 R11: fffff52000024ea8 R12: 0000000000000004
R13: ffff88801c680000 R14: 0000000000000206 R15: ffffffff8ed3df20
FS:  0000000000000000(0000) GS:ffff8881250cf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6fb6a38440 CR3: 000000000eb38000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0x1a9f/0x23b0 arch/x86/kernel/unwind_orc.c:680
 arch_stack_walk+0x11e/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x11a/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x9d/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4341 [inline]
 __kmalloc_node_track_caller_noprof+0x295/0x4d0 mm/slub.c:4360
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:599
 __alloc_skb+0x1f2/0x480 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1340 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x260/0xb50 drivers/net/netdevsim/dev.c:851
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
