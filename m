Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84BB157493
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748315550; cv=none; b=EuiqS2a/wPF0ZW7Xy4/dV1RHKR5FnMv9v5Re7IwR/4EcWZVbW7UZtLw/l33VZS13/gA5hK9DfMr57glotVOhEAfWT2E9K/0pVgXWrsekWuCpeDy7zgbIicbevSqpCmTdrZqeu9iNXwF5gQNQcWe8Wsi+X30ZuVp5FWIKA+WnZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748315550; c=relaxed/simple;
	bh=U4LpTYyTwADRmF/QKAfXm6rKofwm3BNPv0UdECr4OG4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YE8i0+cQUjC2IjuGVu/ty43qcwIHbw5sWxTYYUIEkFms1/3D56/9Xr+f6VhESDl2iSTIPoEhmXGkAGzon1RO4hnb+zQ6GsEp08YkRXab7SDn3uAYVgbatibgpy5hT6KDdm5yeMwGf//KqmumyPoMQoHgJAkbqM0Hnjrkpkvkco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3dc898196bbso21637045ab.0
        for <linux-block@vger.kernel.org>; Mon, 26 May 2025 20:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748315548; x=1748920348;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35VpTjqFvnAHoLNvFopoa0dDNUoSe+iXlwYJq0OqlGs=;
        b=b+WIjY5OVgRnQtKLlR0IcZFEGZEWGOaJAWvWlx9DLY6tWt4fNKB+Ll7YiHpDBAiwG9
         HjyAAxE2EmWw79lkpQy2zAwb8xuUFiuVlRRKynN8v6Zn0vndQ8LnLsGJ0PxLcHGCVYZj
         FiI6fTbRNa3hx0ehpUDcoOsuDh/IswnXnHQCV9uB4QHe97CqyySZ6t9x+IQpEjEkb4i2
         EBiwP94tOxxJVzS/gsZOKKmLbLUVUniCAtFOZnRQmzXWg4GG2o6UdyFLwCLu20MWbd+D
         GpwNl9P8g5ogc6yO1U7J1NbHpnEJtI7B0xIhsEpXae+wNHBUia3X4B0rkGvNWaid9beY
         WbXA==
X-Forwarded-Encrypted: i=1; AJvYcCUP9lpX/r2vKdnzDOPtWl/WpdPBTRHuCvLXHmTgKd2w+eI6jFfkGjvFWJlfhTjY/dhf+5j0L+fNalYHBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgyvY3eMHVc6Y2vBYHzZrnzIqOF2FHcNK75RgRY1JnbzLn2TR
	o8/0wMZWwmXR6LuG6QL5jDvda6CILZTeVgFsZdS9syHV8oqc+tLavuHS9+yoi3ZNyMT89DRb38+
	39HVmUV1NMAlwHD7VRoRuic3Y6D91GUxK+KP2rlYkcn9ZEmGEmT45MYY4ues=
X-Google-Smtp-Source: AGHT+IEgJNfoqYmJMxCerA5HxPIIkVQ3LeaakodcEOhHYkEi+oXjt6ZPOPUPkVx753l2aLDJll8xaxNAXvnUT1hEaZ+kvmqrQFp/
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f12:b0:3dc:7fa4:847 with SMTP id
 e9e14a558f8ab-3dc9ae82f17mr101307575ab.9.1748315547798; Mon, 26 May 2025
 20:12:27 -0700 (PDT)
Date: Mon, 26 May 2025 20:12:27 -0700
In-Reply-To: <6834671a.a70a0220.253bc2.0098.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68352d9b.a70a0220.253bc2.009e.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ddddf9d64f73 Merge tag 'perf-core-2025-05-25' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f87882580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd18a1001092f95b
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11825df4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fb7ad4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ddddf9d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc551d1d4e46/vmlinux-ddddf9d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d26a6de23b0e/bzImage-ddddf9d6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.15.0-syzkaller-01599-gddddf9d64f73 #0 Not tainted
------------------------------------------------------
kworker/u4:9/1091 is trying to acquire lock:
ffff888011362358 (&disk->open_mutex){+.+.}-{4:4}, at: __del_gendisk+0x129/0x9e0 block/genhd.c:706

but task is already holding lock:
ffff88801bb55188 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0xe0/0x160 block/genhd.c:818

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&set->update_nr_hwq_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
       blk_mq_update_nr_hw_queues+0x3b/0x14c0 block/blk-mq.c:5041
       nbd_start_device+0x16c/0xac0 drivers/block/nbd.c:1476
       nbd_genl_connect+0x1250/0x1930 drivers/block/nbd.c:2201
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg+0x219/0x270 net/socket.c:727
       ____sys_sendmsg+0x505/0x830 net/socket.c:2566
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
       __sys_sendmsg net/socket.c:2652 [inline]
       __do_sys_sendmsg net/socket.c:2657 [inline]
       __se_sys_sendmsg net/socket.c:2655 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&nbd->config_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
       refcount_dec_and_mutex_lock+0x30/0xa0 lib/refcount.c:118
       nbd_config_put+0x2c/0x790 drivers/block/nbd.c:1423
       nbd_release+0xfe/0x140 drivers/block/nbd.c:1735
       bdev_release+0x533/0x650 block/bdev.c:-1
       blkdev_release+0x15/0x20 block/fops.c:684
       __fput+0x449/0xa70 fs/file_table.c:465
       fput_close_sync+0x119/0x200 fs/file_table.c:570
       __do_sys_close fs/open.c:1589 [inline]
       __se_sys_close fs/open.c:1574 [inline]
       __x64_sys_close+0x7f/0x110 fs/open.c:1574
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&disk->open_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
       __del_gendisk+0x129/0x9e0 block/genhd.c:706
       del_gendisk+0xe8/0x160 block/genhd.c:819
       nbd_dev_remove drivers/block/nbd.c:268 [inline]
       nbd_dev_remove_work+0x47/0xe0 drivers/block/nbd.c:284
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
       kthread+0x711/0x8a0 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  &disk->open_mutex --> &nbd->config_lock --> &set->update_nr_hwq_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&set->update_nr_hwq_lock);
                               lock(&nbd->config_lock);
                               lock(&set->update_nr_hwq_lock);
  lock(&disk->open_mutex);

 *** DEADLOCK ***

3 locks held by kworker/u4:9/1091:
 #0: ffff88801f317148 ((wq_completion)nbd-del){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801f317148 ((wq_completion)nbd-del){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc90002647c60 ((work_completion)(&nbd->remove_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90002647c60 ((work_completion)(&nbd->remove_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: ffff88801bb55188 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0xe0/0x160 block/genhd.c:818

stack backtrace:
CPU: 0 UID: 0 PID: 1091 Comm: kworker/u4:9 Not tainted 6.15.0-syzkaller-01599-gddddf9d64f73 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: nbd-del nbd_dev_remove_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
 __del_gendisk+0x129/0x9e0 block/genhd.c:706
 del_gendisk+0xe8/0x160 block/genhd.c:819
 nbd_dev_remove drivers/block/nbd.c:268 [inline]
 nbd_dev_remove_work+0x47/0xe0 drivers/block/nbd.c:284
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
