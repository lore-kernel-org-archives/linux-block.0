Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22123FEC
	for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724803766; cv=none; b=S2A3t3rNsIrEXkKPMqLHVm4gnMcYMxwvxBkXpLopGDbyXvBsGOvWdsBb6q6yRFDdT+P+8UxxkJmf8nwiLWsOREfwyOJjQeaFre7TJZSRv5vs6RGRzeJOejkAEcwoXZ2LLf/VmazgVIAM4KzDU3HCn5U0oKl6x8MRzXmEnBhOocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724803766; c=relaxed/simple;
	bh=C8fD5panZ210r/D/tBcDchgP3ZX/6MaNCFThGV8IP2c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I8BgKP7H7gc0BUWTmu0Ioexx8+/ijhSOLxHQAlj3nYOFHyp527iA+ED7HKiH8eqp8nP/7itaE9jR1vONXzE8TEt46jdPL4N1K0BV2eREH87pFTQ2rtqw2FoghLHqS+DUdUcv42gPTHJQvn9n0oT2Cf22KnNuXtscpNF2X2zvOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d27488930so63537535ab.3
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 17:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724803763; x=1725408563;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIlGSjSTGXCkoQxP2Q7ztK9xtaSfDET5t8dTeJZsy7Y=;
        b=czePAOhARnf0RvzpDUZfRvl70n9oaluoDKG1JyANneSDxGVTyQnDUPYFJ2RWADrQw4
         WdPVRoBsOarZQbViy6ODea0zAM0ZNmspP1Y2mFA/dk9Ey2iF2+Iqez97vVWy5YxwZUS1
         mwU4yjVIVE1+uRFNY2I/w7kNlF4TW09nwHgBzUbhdhYvexvuDOp33S296uVAbJO5iNhF
         /WsRMBTCiJUWU/M81dRTv/TdR7kUlZ/m690Lb/VP0k0QhIMfT7f1AgjYaWw4z4P7DiJP
         n49FK+ckOfg4IuxGvz5NBom/NF+60mPkCHDupOwJzW1QMi2FDWeGr7lazszeCpUMNo5f
         s7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Nj3sxJ2xKA+fo93ebWNkb6TJ9XJmD+fkT855XQrtjFRX7JG0dR3ijGl8gFzkIFkFCHNJDxg5O89F4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kaq3d4M/gGEF3+BlOeBYpTytMdgQlzfWGyesfrMdMJKz0zY0
	w3lOYaRk1oHqcRmeBi3hggJH2oGHuzm3IkLAM5t95eyu2+9WIkL0GcXUlgPHGnI6gve9n22A1uM
	huyx13tF16vHEonwErUDX9gC1clWDbliO4mWS3IUAjAudTsvWqjhKIvA=
X-Google-Smtp-Source: AGHT+IFVmCoca5qyOaaQWx1dOqzHKSo85liVM7EVPIV8c75fL9AiQYa8v8BvKNDGfjZljmWikgZPIiIl/KZjrqu0GJQY4ROkFnqR
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156e:b0:39b:3c0c:c3a4 with SMTP id
 e9e14a558f8ab-39f325f4585mr259355ab.2.1724803762895; Tue, 27 Aug 2024
 17:09:22 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:09:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009848bf0620b32ba5@google.com>
Subject: [syzbot] [nbd?] INFO: task hung in nbd_queue_rq
From: syzbot <syzbot+30c16035531e3248dcbc@syzkaller.appspotmail.com>
To: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4186c8d9e6af net: ftgmac100: Ensure tx descriptor updates ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14c293a3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1898c8f2a37/disk-4186c8d9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3316a5f48942/vmlinux-4186c8d9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d209b04373d6/bzImage-4186c8d9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30c16035531e3248dcbc@syzkaller.appspotmail.com

INFO: task udevd:5231 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-syzkaller-00139-g4186c8d9e6af #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:21400 pid:5231  tgid:5231  ppid:1      flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 wait_for_reconnect drivers/block/nbd.c:1023 [inline]
 nbd_handle_cmd drivers/block/nbd.c:1065 [inline]
 nbd_queue_rq+0x7cd/0x2f70 drivers/block/nbd.c:1123
 blk_mq_dispatch_rq_list+0xb89/0x1b30 block/blk-mq.c:2032
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xb8a/0x1840 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xcb/0x140 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x576/0xae0 block/blk-mq.c:2245
 blk_mq_flush_plug_list+0x1115/0x1880 block/blk-mq.c:2794
 __blk_flush_plug+0x420/0x500 block/blk-core.c:1198
 blk_finish_plug block/blk-core.c:1225 [inline]
 __submit_bio+0x422/0x560 block/blk-core.c:623
 __submit_bio_noacct_mq block/blk-core.c:696 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:725
 submit_bh fs/buffer.c:2829 [inline]
 block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2456
 filemap_read_folio+0x1a0/0x790 mm/filemap.c:2355
 do_read_cache_folio+0x134/0x820 mm/filemap.c:3789
 read_mapping_folio include/linux/pagemap.h:913 [inline]
 read_part_sector+0xb3/0x330 block/partitions/core.c:712
 adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:138 [inline]
 blk_add_partitions block/partitions/core.c:579 [inline]
 bdev_disk_changed+0x72c/0x13d0 block/partitions/core.c:683
 blkdev_get_whole+0x2d2/0x450 block/bdev.c:700
 bdev_open+0x2d4/0xc60 block/bdev.c:909
 blkdev_open+0x3e8/0x570 block/fops.c:630
 do_dentry_open+0x970/0x1440 fs/open.c:959
 vfs_open+0x3e/0x330 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2b3e/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff5279169a4
RSP: 002b:00007fff30a69670 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055d33c0dfe10 RCX: 00007ff5279169a4
RDX: 00000000000a0800 RSI: 000055d33c0f5570 RDI: 00000000ffffff9c
RBP: 000055d33c0f5570 R08: 0000000000000001 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 000055d33c0c7a90 R14: 0000000000000002 R15: 000055d33c0be910
 </TASK>
INFO: task udevd:5245 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc4-syzkaller-00139-g4186c8d9e6af #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:21632 pid:5245  tgid:5245  ppid:1      flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 wait_for_reconnect drivers/block/nbd.c:1023 [inline]
 nbd_handle_cmd drivers/block/nbd.c:1065 [inline]
 nbd_queue_rq+0x7cd/0x2f70 drivers/block/nbd.c:1123
 blk_mq_dispatch_rq_list+0xb89/0x1b30 block/blk-mq.c:2032
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xb8a/0x1840 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xcb/0x140 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x576/0xae0 block/blk-mq.c:2245
 blk_mq_flush_plug_list+0x1115/0x1880 block/blk-mq.c:2794
 __blk_flush_plug+0x420/0x500 block/blk-core.c:1198
 blk_finish_plug block/blk-core.c:1225 [inline]
 __submit_bio+0x422/0x560 block/blk-core.c:623
 __submit_bio_noacct_mq block/blk-core.c:696 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:725
 submit_bh fs/buffer.c:2829 [inline]
 block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2456
 filemap_read_folio+0x1a0/0x790 mm/filemap.c:2355
 do_read_cache_folio+0x134/0x820 mm/filemap.c:3789
 read_mapping_folio include/linux/pagemap.h:913 [inline]
 read_part_sector+0xb3/0x330 block/partitions/core.c:712
 adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:138 [inline]
 blk_add_partitions block/partitions/core.c:579 [inline]
 bdev_disk_changed+0x72c/0x13d0 block/partitions/core.c:683
 blkdev_get_whole+0x2d2/0x450 block/bdev.c:700
 bdev_open+0x2d4/0xc60 block/bdev.c:909
 blkdev_open+0x3e8/0x570 block/fops.c:630
 do_dentry_open+0x970/0x1440 fs/open.c:959
 vfs_open+0x3e/0x330 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2b3e/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff5279169a4
RSP: 002b:00007fff30a69670 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055d33c0dfe10 RCX: 00007ff5279169a4
RDX: 00000000000a0800 RSI: 000055d33c0d2640 RDI: 00000000ffffff9c
RBP: 000055d33c0d2640 R08: 0000000000000001 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 000055d33c0d3540 R14: 0000000000000002 R15: 000055d33c0be910
 </TASK>
INFO: task udevd:5757 blocked for more than 145 seconds.
      Not tainted 6.11.0-rc4-syzkaller-00139-g4186c8d9e6af #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:21848 pid:5757  tgid:5757  ppid:1      flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 wait_for_reconnect drivers/block/nbd.c:1023 [inline]
 nbd_handle_cmd drivers/block/nbd.c:1065 [inline]
 nbd_queue_rq+0x7cd/0x2f70 drivers/block/nbd.c:1123
 blk_mq_dispatch_rq_list+0xb89/0x1b30 block/blk-mq.c:2032
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xb8a/0x1840 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xcb/0x140 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x576/0xae0 block/blk-mq.c:2245
 blk_mq_flush_plug_list+0x1115/0x1880 block/blk-mq.c:2794
 __blk_flush_plug+0x420/0x500 block/blk-core.c:1198
 blk_finish_plug block/blk-core.c:1225 [inline]
 __submit_bio+0x422/0x560 block/blk-core.c:623
 __submit_bio_noacct_mq block/blk-core.c:696 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:725
 submit_bh fs/buffer.c:2829 [inline]
 block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2456
 filemap_read_folio+0x1a0/0x790 mm/filemap.c:2355
 do_read_cache_folio+0x134/0x820 mm/filemap.c:3789
 read_mapping_folio include/linux/pagemap.h:913 [inline]
 read_part_sector+0xb3/0x330 block/partitions/core.c:712
 adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:138 [inline]
 blk_add_partitions block/partitions/core.c:579 [inline]
 bdev_disk_changed+0x72c/0x13d0 block/partitions/core.c:683
 blkdev_get_whole+0x2d2/0x450 block/bdev.c:700
 bdev_open+0x2d4/0xc60 block/bdev.c:909
 blkdev_open+0x3e8/0x570 block/fops.c:630
 do_dentry_open+0x970/0x1440 fs/open.c:959
 vfs_open+0x3e/0x330 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2b3e/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff5279169a4
RSP: 002b:00007fff30a69670 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055d33c0f6020 RCX: 00007ff5279169a4
RDX: 00000000000a0800 RSI: 000055d33c0bf700 RDI: 00000000ffffff9c
RBP: 000055d33c0bf700 R08: 0000000000000001 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 000055d33c0c7a90 R14: 0000000000000002 R15: 000055d33c0be910
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
3 locks held by kworker/0:2/59:
 #0: ffff888015880948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015880948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffff8880b9228948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:989
 #2: ffff8880b922a718 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
2 locks held by getty/4989:
 #0: ffff88802aaca0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by udevd/5231:
 #0: ffff888020a0e4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff88801f6b3a10 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff88801f6b3a10 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff88801f6b3a10 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888020b30180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/5245:
 #0: ffff8880206be4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff88801fc48410 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff88801fc48410 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff88801fc48410 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888020bb0180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/5757:
 #0: ffff888020ab24c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff88801f705110 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff88801f705110 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff88801f705110 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888021000180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by kworker/u8:9/6349:
 #0: ffff88802a3f4948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802a3f4948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90019d2fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90019d2fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc845c8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4194
2 locks held by syz.3.565/6932:
 #0: ffffffff8fce9d30 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec07228 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1956
1 lock held by syz-executor/9823:
 #0: ffffffff8e93d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 #0: ffffffff8e93d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
3 locks held by syz-executor/9925:
 #0: ffffffff8fc845c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc845c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
 #1: ffff88802ca9d428 (&wg->device_update_lock){+.+.}-{3:3}, at: wg_open+0x22d/0x420 drivers/net/wireguard/device.c:50
 #2: ffffffff8e93d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:296 [inline]
 #2: ffffffff8e93d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:958

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc4-syzkaller-00139-g4186c8d9e6af #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 9925 Comm: syz-executor Not tainted 6.11.0-rc4-syzkaller-00139-g4186c8d9e6af #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__lock_release kernel/locking/lockdep.c:5413 [inline]
RIP: 0010:lock_release+0x1c3/0xa30 kernel/locking/lockdep.c:5780
Code: 80 3c 3b 00 74 08 4c 89 f7 e8 a9 d6 8a 00 48 8b 9c 24 b0 00 00 00 fa 48 c7 c7 40 e2 0a 8c e8 e4 f2 46 0a 65 ff 05 fd 93 92 7e <48> 8d 94 24 80 00 00 00 48 c1 ea 03 42 0f b6 04 3a 84 c0 0f 85 6e
RSP: 0018:ffffc90000a18ce0 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 0000000000000046 RCX: ffffffff816ff570
RDX: 0000000000000000 RSI: ffffffff8c0ae240 RDI: ffffffff8c606d40
RBP: ffffc90000a18e10 R08: ffffffff9017f32f R09: 1ffffffff202fe65
R10: dffffc0000000000 R11: fffffbfff202fe66 R12: 1ffff920001431a8
R13: ffffffff8180ca80 R14: ffffc90000a18d90 R15: dffffc0000000000
FS:  000055558a9d4500(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3fd4ce8178 CR3: 000000007e6b8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [inline]
 _raw_spin_unlock_irqrestore+0x79/0x140 kernel/locking/spinlock.c:194
 hrtimer_interrupt+0x540/0x990 kernel/time/hrtimer.c:1825
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2010 [inline]
RIP: 0010:vprintk_emit+0x5ac/0x7c0 kernel/printk/printk.c:2347
Code: 06 20 00 4c 21 e3 0f 85 3a 01 00 00 e8 1d 01 20 00 4d 89 ec 4d 85 ff 75 07 e8 10 01 20 00 eb 06 e8 09 01 20 00 fb 44 8b 3c 24 <48> c7 c7 20 3d 81 8e 31 f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00
RSP: 0018:ffffc900169deb20 EFLAGS: 00000293
RAX: ffffffff81738a37 RBX: 0000000000000000 RCX: ffff888063078000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900169dec10 R08: ffffffff81738a15 R09: 1ffffffff26e6909
R10: dffffc0000000000 R11: fffffbfff26e690a R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffffff81738895 R15: 000000000000003e
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4912
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4923
 _dev_printk+0x135/0x180 drivers/base/core.c:4952
 ieee80211_init_rate_ctrl_alg+0x5a2/0x620 net/mac80211/rate.c:1006
 ieee80211_register_hw+0x2c73/0x3e10 net/mac80211/main.c:1519
 mac80211_hwsim_new_radio+0x2a9f/0x4a90 drivers/net/wireless/virtual/mac80211_hwsim.c:5519
 hwsim_new_radio_nl+0xece/0x2290 drivers/net/wireless/virtual/mac80211_hwsim.c:6203
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f40bc77bd0c
Code: 2a 5a 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5a 02 00 48 8b
RSP: 002b:00007ffde70ed440 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f40bd444620 RCX: 00007f40bc77bd0c
RDX: 0000000000000024 RSI: 00007f40bd444670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffde70ed494 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f40bd444670 R15: 0000000000000000
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
