Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C715A59
	for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732421123; cv=none; b=rlbvQOGxmJJXM01Q71BnogwhBT9ZvNxZMY2eplV1nDW28vilXqKPbVee3866iCh+aDTL+3AXe0jZYvz+agft9xil5PVn+znyRRQTUrW3evI2fjfAGTuMrvoCpF4pxm7UlQfAFJi6JrqOACFs8Mo9OzrlqkEDFI1D/COLrTZkT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732421123; c=relaxed/simple;
	bh=YCOj/JeoCAycr9jdz8D3EMwTzuQel8zf+TdD3SAjhkc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XpIkK9fmr+COk/eDhmtUKv8FJbClgTqHiu40vwe+oCto+suOue3AKBOVzbN/NR8OOlLQev3o2E4ItjXlrj0eCreunP83CQFxoczCyh2bsAATLbXPmkAgpEJGRnZIuSEKq+2wkibPps4rzFFaIWzBTJvFWZqdTDPNiT/LmYW3UBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a77a808c27so35976475ab.1
        for <linux-block@vger.kernel.org>; Sat, 23 Nov 2024 20:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732421120; x=1733025920;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvyA8Fcq7n5MWGe6tHs8ESU/jP713NuJTLsOZQbo+Qo=;
        b=nudvugQJXyO5lDf3W+s2L36JVAK6KRsE+uBQTodl8TA/Kef0zix94IoEqDckojBOgb
         EUE7I/kTd3DyXlytQDRyBXOegWonVkjZ88HlnUCr/aelI7BdfxHMmMUOvtAPvHmhoeJH
         mLwdBG4Az9bdgz7gTmGaF7aBzEWAeVXTQeDORGWIGvxa4+fI2yyXI27vWiScpnUyit76
         WFmPxnXOmEhQA21olD4jouk52cqSF6ns0aHEZH47zuEtyGyOeG6WYpHGu0V0cLhKsUoq
         rZ3OqDBtQMlpuLZMV/3lhMmpn/onkulOCZisfCv0FyGhOVUQCfb/0xJ60YDsnWjk+zdx
         6z9g==
X-Forwarded-Encrypted: i=1; AJvYcCWCy7/R8oqsqYhCud6sgomE2KqJ/Pd4GLDDIYsSJmcfDeqWxCZr5l7/RWDVpAvFmvi2rx5HR6jHVjBGzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrq52ljZfuithhOc6pV3K/a0r9QkM+Wcj72TcSGRp0YtMPSKb
	KbJSGGuWy9YIJ/Np/LhyZGs/Aio2/IXyrcVL7EN2MjpgVbf+KwyM6GmnmqQStafwFMjYCQyHlkv
	kkNe8Go1/M7prXZ1PtCrfvIT1t+rLcMXs8EiOSs60KNVwpTTg/wt1iwc=
X-Google-Smtp-Source: AGHT+IHXe1GncEpdNQK6Xcq/GFmvnHXvAYt5XA9+hJwRhV5R4PzVEYdGZ5oiz8SF9aoyMksdyZrO6JFUWOzDes7I7s8OuHcWb2vx
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:3a7:96cc:8cc1 with SMTP id
 e9e14a558f8ab-3a79acfb369mr84305585ab.5.1732421120694; Sat, 23 Nov 2024
 20:05:20 -0800 (PST)
Date: Sat, 23 Nov 2024 20:05:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6742a600.050a0220.1cc393.002e.GAE@google.com>
Subject: [syzbot] [nbd?] possible deadlock in nbd_set_size
From: syzbot <syzbot+966c3b607cb094ce7299@syzkaller.appspotmail.com>
To: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5c93bfec0be Merge tag 'x86-mm-2024-11-18' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a9875f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc0e771bc3a6cf07
dashboard link: https://syzkaller.appspot.com/bug?extid=966c3b607cb094ce7299
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd46e8a61d2c/disk-a5c93bfe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bec1baa1daec/vmlinux-a5c93bfe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bace1a48b99a/bzImage-a5c93bfe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+966c3b607cb094ce7299@syzkaller.appspotmail.com

netlink: 4 bytes leftover after parsing attributes in process `syz.0.832'.
netlink: 36 bytes leftover after parsing attributes in process `syz.0.832'.
======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-01518-ga5c93bfec0be #0 Not tainted
------------------------------------------------------
syz.0.832/9739 is trying to acquire lock:
ffff8881423af290 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:945 [inline]
ffff8881423af290 (&q->limits_lock){+.+.}-{4:4}, at: __nbd_set_size drivers/block/nbd.c:351 [inline]
ffff8881423af290 (&q->limits_lock){+.+.}-{4:4}, at: nbd_set_size+0x2e0/0x8f0 drivers/block/nbd.c:388

but task is already holding lock:
ffff8881423aec40 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_set_size+0xe0/0x8f0 drivers/block/nbd.c:387

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x23a0 block/blk-mq.c:3092
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       mpage_bio_submit_read fs/mpage.c:75 [inline]
       mpage_readahead+0x7da/0x930 fs/mpage.c:377
       read_pages+0x176/0x830 mm/readahead.c:160
       page_cache_ra_unbounded+0x774/0x8a0 mm/readahead.c:290
       do_page_cache_ra mm/readahead.c:320 [inline]
       force_page_cache_ra mm/readahead.c:349 [inline]
       page_cache_sync_ra+0x3c5/0xad0 mm/readahead.c:562
       page_cache_sync_readahead include/linux/pagemap.h:1394 [inline]
       filemap_get_pages+0x621/0x2540 mm/filemap.c:2547
       filemap_read+0x45c/0xf50 mm/filemap.c:2647
       blkdev_read_iter+0x2d8/0x430 block/fops.c:767
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x991/0xb70 fs/read_write.c:565
       ksys_read+0x18f/0x2b0 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (mapping.invalidate_lock#2){.+.+}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0xd54/0x1950 mm/filemap.c:3352
       __do_fault+0x135/0x460 mm/memory.c:4882
       do_shared_fault mm/memory.c:5361 [inline]
       do_fault mm/memory.c:5435 [inline]
       do_pte_missing mm/memory.c:3965 [inline]
       handle_pte_fault+0x1105/0x6820 mm/memory.c:5766
       __handle_mm_fault mm/memory.c:5909 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6077
       do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:57
       copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
       raw_copy_to_user arch/x86/include/asm/uaccess_64.h:147 [inline]
       _inline_copy_to_user include/linux/uaccess.h:197 [inline]
       _copy_to_user+0x8b/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:225 [inline]
       msr_read+0x184/0x260 arch/x86/kernel/msr.c:69
       vfs_read+0x1fc/0xb70 fs/read_write.c:563
       ksys_read+0x18f/0x2b0 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6716
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
       blk_trace_ioctl+0x1ad/0x9a0 kernel/trace/blktrace.c:740
       blkdev_ioctl+0x40c/0x6a0 block/ioctl.c:682
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->debugfs_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x3fa/0x830 block/blk-mq-sched.c:473
       elevator_init_mq+0x20e/0x320 block/elevator.c:610
       add_disk_fwnode+0x10d/0xf80 block/genhd.c:413
       sd_probe+0xba6/0x1100 drivers/scsi/sd.c:4024
       really_probe+0x2b8/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       blk_queue_enter+0xe1/0x600 block/blk-core.c:328
       blk_mq_alloc_request+0x4fa/0xaa0 block/blk-mq.c:652
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x177/0x1090 drivers/scsi/scsi_lib.c:304
       read_capacity_16+0x2b4/0x1450 drivers/scsi/sd.c:2655
       sd_read_capacity drivers/scsi/sd.c:2824 [inline]
       sd_revalidate_disk+0x1013/0xbce0 drivers/scsi/sd.c:3734
       sd_probe+0x9fa/0x1100 drivers/scsi/sd.c:4010
       really_probe+0x2b8/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->limits_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:945 [inline]
       __nbd_set_size drivers/block/nbd.c:351 [inline]
       nbd_set_size+0x2e0/0x8f0 drivers/block/nbd.c:388
       nbd_genl_connect+0x157c/0x1c80 drivers/block/nbd.c:2139
       genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2541
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
       netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
       netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
       sock_sendmsg_nosec net/socket.c:711 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:726
       ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2581
       ___sys_sendmsg net/socket.c:2635 [inline]
       __sys_sendmsg+0x269/0x350 net/socket.c:2667
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->limits_lock --> mapping.invalidate_lock#2 --> &q->q_usage_counter(io)#49

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#49);
                               lock(mapping.invalidate_lock#2);
                               lock(&q->q_usage_counter(io)#49);
  lock(&q->limits_lock);

 *** DEADLOCK ***

5 locks held by syz.0.832/9739:
 #0: ffffffff8fd2f490 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fd2f348 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fd2f348 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fd2f348 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 #2: ffff8880256a9998 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_genl_connect+0xc26/0x1c80 drivers/block/nbd.c:2049
 #3: ffff8881423aec40 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_set_size+0xe0/0x8f0 drivers/block/nbd.c:387
 #4: ffff8881423aec78 (&q->q_usage_counter(queue)#33){+.+.}-{0:0}, at: nbd_set_size+0xe0/0x8f0 drivers/block/nbd.c:387

stack backtrace:
CPU: 1 UID: 0 PID: 9739 Comm: syz.0.832 Not tainted 6.12.0-syzkaller-01518-ga5c93bfec0be #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 queue_limits_start_update include/linux/blkdev.h:945 [inline]
 __nbd_set_size drivers/block/nbd.c:351 [inline]
 nbd_set_size+0x2e0/0x8f0 drivers/block/nbd.c:388
 nbd_genl_connect+0x157c/0x1c80 drivers/block/nbd.c:2139
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2541
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2581
 ___sys_sendmsg net/socket.c:2635 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efd8f57e759
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efd90381038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007efd8f735f80 RCX: 00007efd8f57e759
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000008
RBP: 00007efd8f5f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007efd8f735f80 R15: 00007ffd8969a0a8
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
