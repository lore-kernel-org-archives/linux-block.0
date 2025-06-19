Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AAA22756A
	for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332578; cv=none; b=JsstLKVO0wH5N/P0oCSVu9KZU3GQGHyppYQ8f/TrA5PuNQVsgUEEB6zptCMUjfzpXmkWeRm4qrMjxvQl4t8vzXrgA/0YxPWcg2P9EMsP/4wc1LraWnLNq6664NfGQQPFrjFeS70C6+UQoyj51ki2YOKecx5RxwD+qSOYrLEmRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332578; c=relaxed/simple;
	bh=e0skP2wgHcDLar+1R1EpRVRuKiR3o3lQHV+r5AP3Deg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JKuq6JqlDwpc5+/WqhyigGYktcZ/W8qTmZOBnmb9Tr9tXi6tej2VVMzy6tE/dp2Z2VScKyCLapigwi1yTh8gaDkcgG4gNAa33eTxk/WPMLgobn7Hc59Wqzgf+9RJpWviBdTLme/rF83xZStkY8C1cJN4vMHHbNXlbx4AnI/fIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddcf82bb53so5645075ab.3
        for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 04:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332574; x=1750937374;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0bpKo0a444ovW4sWpz4EXcZcoHocoxfjWX98q//TTg=;
        b=ZUKItFH5vS5VViCdYhm1eIhgWvpdeRL8ST4wequ3wewYszUSyvbxMrdG51QJKUO2cH
         zGNzciBonjYBPJSR4Q3TCJjqveAJt/joSKz0+KY/doongdERr9rNTj3qmCETKM86dzPN
         +rSHQZxPcN5kD5e1KAnLqxPcV+w7tfW86sfWiFK9O/olglylWW4AGS6aFs9QxDmxFIt4
         jg8rWfMP2rRjQ3xZK7o/SuVrBBivxjg3zZTemsJkK7uXVKz+LpLX1tFg9FJbVH2WrZI5
         T5eCcwc0BWxsvVkVLnTojbpXhphgLYYDY6Fk600fOL7k3BmEweybX3D5rpcJLojOWn3x
         d0DA==
X-Forwarded-Encrypted: i=1; AJvYcCUUv4tuwDxK65iyKIMTxQS759EpGEMOan9m3iotiByTX/NnIYawKsxgFbcLBildQ2zBW1viOH1jbZyPMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xGWsrmecKv/5uMf+ynoE4yGMIoT4lGXjwMYcwR+unCXLmK1L
	d6RP0keBbFNZmQ8/QPZBjxY9mw2t3MRNz3lDGEg5o/p4cueXhGuQ6ACbwDdwx8otoh+lL9rHXz/
	4fkXt7kZB/iEc08P/udmWdoOzjy2dmckdHFXo45dvtBTpl7C6Y3OI1HFEiqA=
X-Google-Smtp-Source: AGHT+IH68r2tyy8nUBLxmmlVx0TaFawKz0a5suFWdAOObJenx/Ssp9C4XyqCfaJeLR8RhuYVQGNrvDW+X1+s4plJVIDdH+/YfHQc
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2583:b0:3dd:d18c:126f with SMTP id
 e9e14a558f8ab-3de07d50c73mr217896225ab.10.1750332574669; Thu, 19 Jun 2025
 04:29:34 -0700 (PDT)
Date: Thu, 19 Jun 2025 04:29:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6853f49e.a00a0220.137b3.0006.GAE@google.com>
Subject: [syzbot] [nbd?] possible deadlock in nbd_open
From: syzbot <syzbot+ea702c2366971b7fc6e4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    306e57988197 Merge patch "riscv: defconfig: run savedefcon..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10721e82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=618b9468db3872f5
dashboard link: https://syzkaller.appspot.com/bug?extid=ea702c2366971b7fc6e4
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-306e5798.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5fee9bbe87f3/vmlinux-306e5798.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e959580bb405/Image-306e5798.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea702c2366971b7fc6e4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc1-syzkaller-g306e57988197 #0 Not tainted
------------------------------------------------------
syz.4.1189/8748 is trying to acquire lock:
ffffaf801a39a230 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_open+0x3c0/0x6fe drivers/block/nbd.c:1703

but task is already holding lock:
ffffffff88e269e8 (nbd_index_mutex){+.+.}-{4:4}, at: nbd_open+0x98/0x6fe drivers/block/nbd.c:1690

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (nbd_index_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
       mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
       nbd_open+0x98/0x6fe drivers/block/nbd.c:1690
       blkdev_get_whole+0x8a/0x266 block/bdev.c:730
       bdev_open+0x292/0xce6 block/bdev.c:957
       blkdev_open+0x264/0x39a block/fops.c:676
       do_dentry_open+0x97e/0x171e fs/open.c:964
       vfs_open+0xbe/0x380 fs/open.c:1094
       do_open fs/namei.c:3887 [inline]
       path_openat+0x1bd8/0x2a82 fs/namei.c:4046
       do_filp_open+0x19c/0x380 fs/namei.c:4073
       do_sys_openat2+0x11a/0x1c2 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __riscv_sys_openat+0x178/0x1fe fs/open.c:1463
       syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
       do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:341
       handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

-> #2 (&disk->open_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
       mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
       __del_gendisk+0x132/0xac6 block/genhd.c:706
       del_gendisk+0xf6/0x19a block/genhd.c:819
       nbd_dev_remove+0x3c/0xf2 drivers/block/nbd.c:268
       nbd_dev_remove_work+0x1c/0x26 drivers/block/nbd.c:284
       process_one_work+0x96a/0x1f32 kernel/workqueue.c:3238
       process_scheduled_works kernel/workqueue.c:3321 [inline]
       worker_thread+0x5ce/0xde8 kernel/workqueue.c:3402
       kthread+0x39c/0x7d4 kernel/kthread.c:464
       ret_from_fork_kernel+0x2a/0xbb2 arch/riscv/kernel/process.c:214
       ret_from_fork_kernel_asm+0x16/0x18 arch/riscv/kernel/entry.S:327

-> #1 (&set->update_nr_hwq_lock){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       down_write+0x9c/0x19a kernel/locking/rwsem.c:1577
       blk_mq_update_nr_hw_queues+0x3e/0xb86 block/blk-mq.c:5041
       nbd_start_device+0x140/0xb2c drivers/block/nbd.c:1476
       nbd_genl_connect+0xae0/0x1b24 drivers/block/nbd.c:2201
       genl_family_rcv_msg_doit+0x206/0x2e6 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x514/0x78e net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x206/0x3be net/netlink/af_netlink.c:2534
       genl_rcv+0x36/0x4c net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x4f0/0x82c net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x85e/0xdd6 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg+0xcc/0x160 net/socket.c:727
       ____sys_sendmsg+0x63e/0x79c net/socket.c:2566
       ___sys_sendmsg+0x144/0x1e6 net/socket.c:2620
       __sys_sendmsg+0x188/0x246 net/socket.c:2652
       __do_sys_sendmsg net/socket.c:2657 [inline]
       __se_sys_sendmsg net/socket.c:2655 [inline]
       __riscv_sys_sendmsg+0x70/0xa2 net/socket.c:2655
       syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
       do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:341
       handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

-> #0 (&nbd->config_lock){+.+.}-{4:4}:
       check_noncircular+0x132/0x146 kernel/locking/lockdep.c:2178
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x12b2/0x24ea kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
       mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
       nbd_open+0x3c0/0x6fe drivers/block/nbd.c:1703
       blkdev_get_whole+0x8a/0x266 block/bdev.c:730
       bdev_open+0x292/0xce6 block/bdev.c:957
       blkdev_open+0x264/0x39a block/fops.c:676
       do_dentry_open+0x97e/0x171e fs/open.c:964
       vfs_open+0xbe/0x380 fs/open.c:1094
       do_open fs/namei.c:3887 [inline]
       path_openat+0x1bd8/0x2a82 fs/namei.c:4046
       do_filp_open+0x19c/0x380 fs/namei.c:4073
       do_sys_openat2+0x11a/0x1c2 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __riscv_sys_openat+0x178/0x1fe fs/open.c:1463
       syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
       do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:341
       handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

other info that might help us debug this:

Chain exists of:
  &nbd->config_lock --> &disk->open_mutex --> nbd_index_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(nbd_index_mutex);
                               lock(&disk->open_mutex);
                               lock(nbd_index_mutex);
  lock(&nbd->config_lock);

 *** DEADLOCK ***

2 locks held by syz.4.1189/8748:
 #0: ffffaf801a3a2358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0x3d0/0xce6 block/bdev.c:945
 #1: ffffffff88e269e8 (nbd_index_mutex){+.+.}-{4:4}, at: nbd_open+0x98/0x6fe drivers/block/nbd.c:1690

stack backtrace:
CPU: 0 UID: 0 PID: 8748 Comm: syz.4.1189 Not tainted 6.16.0-rc1-syzkaller-g306e57988197 #0 PREEMPT 
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80078bbe>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:132
[<ffffffff8000327a>] show_stack+0x30/0x3c arch/riscv/kernel/stacktrace.c:138
[<ffffffff8006103e>] __dump_stack lib/dump_stack.c:94 [inline]
[<ffffffff8006103e>] dump_stack_lvl+0x12e/0x1a6 lib/dump_stack.c:120
[<ffffffff800610d2>] dump_stack+0x1c/0x24 lib/dump_stack.c:129
[<ffffffff802ce116>] print_circular_bug+0x254/0x29a kernel/locking/lockdep.c:2046
[<ffffffff802ce28e>] check_noncircular+0x132/0x146 kernel/locking/lockdep.c:2178
[<ffffffff802d1468>] check_prev_add kernel/locking/lockdep.c:3168 [inline]
[<ffffffff802d1468>] check_prevs_add kernel/locking/lockdep.c:3287 [inline]
[<ffffffff802d1468>] validate_chain kernel/locking/lockdep.c:3911 [inline]
[<ffffffff802d1468>] __lock_acquire+0x12b2/0x24ea kernel/locking/lockdep.c:5240
[<ffffffff802d32de>] lock_acquire kernel/locking/lockdep.c:5871 [inline]
[<ffffffff802d32de>] lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
[<ffffffff8630e424>] __mutex_lock_common kernel/locking/mutex.c:602 [inline]
[<ffffffff8630e424>] __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
[<ffffffff8630f564>] mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
[<ffffffff82c3fb3a>] nbd_open+0x3c0/0x6fe drivers/block/nbd.c:1703
[<ffffffff81531ca6>] blkdev_get_whole+0x8a/0x266 block/bdev.c:730
[<ffffffff81532f2e>] bdev_open+0x292/0xce6 block/bdev.c:957
[<ffffffff81539df6>] blkdev_open+0x264/0x39a block/fops.c:676
[<ffffffff80be5b4e>] do_dentry_open+0x97e/0x171e fs/open.c:964
[<ffffffff80bea7aa>] vfs_open+0xbe/0x380 fs/open.c:1094
[<ffffffff80c3d1ba>] do_open fs/namei.c:3887 [inline]
[<ffffffff80c3d1ba>] path_openat+0x1bd8/0x2a82 fs/namei.c:4046
[<ffffffff80c3e200>] do_filp_open+0x19c/0x380 fs/namei.c:4073
[<ffffffff80beb5f4>] do_sys_openat2+0x11a/0x1c2 fs/open.c:1437
[<ffffffff80bebff6>] do_sys_open fs/open.c:1452 [inline]
[<ffffffff80bebff6>] __do_sys_openat fs/open.c:1468 [inline]
[<ffffffff80bebff6>] __se_sys_openat fs/open.c:1463 [inline]
[<ffffffff80bebff6>] __riscv_sys_openat+0x178/0x1fe fs/open.c:1463
[<ffffffff800769ae>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff862fcc32>] do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:341
[<ffffffff863250ca>] handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197


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
