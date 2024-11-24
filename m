Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA5136E
	for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732437383; cv=none; b=CVGliYmRGnzZynwMNAdEMehU/SmsZ4y5wxd6JDxFaRbeWErkpTeLWuGQ1hnUR+D4RqEInS0cvNYrfZK3zOLPRoXSsupXcQR+r8puXHlCCXV7vcePEZmJhAMsVyrFsXfbq3gGXipG4zpq5M3D+hGFBDU0y3+4OzdEwU9Ua3fc3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732437383; c=relaxed/simple;
	bh=JkmwgBLDyQ2bVFoLK1s8PWJ7t+R8TZKqsNvkKIFDAV0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BTj5NwRxOZFWDPbFzP6eyZFKkBrGMSfnxter9Yalv0ezdaOOMfMzY83XNsi6nBMSOr2jDEoo2QZnR8hOpIVmrYfwvem9Es3XI2EzXTn7Bs4Ae9E0MjsEdLuD5gyCkTBFGXFNjc0J9gb9CEIczWGvOsQ71W/pjJfwILbFG+shHBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a763f42b35so26129795ab.1
        for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 00:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732437381; x=1733042181;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/ewoyvFNfVAOHRi5HG4K9bmQjnMa6rWTzvVQA3+ASU=;
        b=Tdv4ke0wn49Y3rHowuKTmmaE+J53phS3Su1P5v9XrgWOx5WHz7SjUsiXjJMg/GDmm0
         sFBov2sm80f+H0FeMPetyogHyygQJNmtFfsrpmZlw/x2OyE89ftQDHKjrpyA8icj/UP/
         7yZYPPSWmassr6sjkx8gaBrcyvWCQT9UdsZpkHf/E9ASXNmGNpFSeh7Iwaf9FS0ZjgWp
         MvAhl5PLxihcPb1bpnUzed383WSpLLMSI5n9NKNcWWOprKWgyiHZSH3n6RioS9u9GT9g
         nxkHUcxcjFDC5JR59kqC/OnQZZ5gDmW+yCruwwIUtm96hkPZpIn9MqQiGskBt152HQH8
         nKOg==
X-Forwarded-Encrypted: i=1; AJvYcCXTIq94Bg7C8oBMOUgps5wHCfcoe1W6ey1boPSLfRnmfuxQySmRqT3CbDA3PUaygeTjpRMG4wkhYjNo7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMrfqNVM4Ij0JMhpRPDGtOz/oJJVEqcK/QQQ70GcHIvWcd1Y3g
	TKhKczSu5hj1ArQGZ8Okwcl1kj4s4aKiTe8TgYJSIZDqjaHxCipa60IGmT6PnPx42dOaZ0+kfxm
	gFgIeiPLuLnO3P7WQOzqC9H5zwtNgFgKWdB9lo/y5sGzTUUnj4Bxe0is=
X-Google-Smtp-Source: AGHT+IGfkKbJnnigNubfrulo5DsLfJBjCu4mn9pawKPviMdwwlYonOS0sBBpdroWzqj4WxM74XU/amabFRdBPaAVHt9wa0F/CLOL
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3a79ad5ba54mr80533455ab.11.1732437380775; Sun, 24 Nov 2024
 00:36:20 -0800 (PST)
Date: Sun, 24 Nov 2024 00:36:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6742e584.050a0220.1cc393.0038.GAE@google.com>
Subject: [syzbot] [nbd?] possible deadlock in __nbd_set_size
From: syzbot <syzbot+143deed0891e0c211d8f@syzkaller.appspotmail.com>
To: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1129b6e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2406be795e8a5f4
dashboard link: https://syzkaller.appspot.com/bug?extid=143deed0891e0c211d8f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-228a1157.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/663df7d9ff83/vmlinux-228a1157.xz
kernel image: https://storage.googleapis.com/syzbot-assets/354a15c7eb5d/bzImage-228a1157.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+143deed0891e0c211d8f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-08446-g228a1157fb9f #0 Not tainted
------------------------------------------------------
syz.0.799/8860 is trying to acquire lock:
ffff88810761df00 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:945 [inline]
ffff88810761df00 (&q->limits_lock){+.+.}-{4:4}, at: __nbd_set_size+0x2c0/0x730 drivers/block/nbd.c:351

but task is already holding lock:
ffff88810761d8b0 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_set_size drivers/block/nbd.c:387 [inline]
ffff88810761d8b0 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_start_device+0x8ef/0xd70 drivers/block/nbd.c:1456

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1fb6/0x24c0 block/blk-mq.c:3092
       __submit_bio+0x384/0x540 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x698/0xd70 block/blk-core.c:739
       submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
       mpage_bio_submit_read fs/mpage.c:75 [inline]
       mpage_readahead+0x41d/0x590 fs/mpage.c:377
       read_pages+0x1a8/0xdc0 mm/readahead.c:160
       page_cache_ra_unbounded+0x3c0/0x6c0 mm/readahead.c:290
       do_page_cache_ra mm/readahead.c:320 [inline]
       force_page_cache_ra+0x24b/0x340 mm/readahead.c:349
       page_cache_sync_ra+0x110/0x9c0 mm/readahead.c:562
       page_cache_sync_readahead include/linux/pagemap.h:1394 [inline]
       filemap_get_pages+0xd7b/0x1be0 mm/filemap.c:2547
       filemap_read+0x3ca/0xd70 mm/filemap.c:2647
       blkdev_read_iter+0x187/0x480 block/fops.c:767
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x87f/0xbe0 fs/read_write.c:565
       ksys_read+0x12b/0x250 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (mapping.invalidate_lock#2){.+.+}-{4:4}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0x2e0/0x2820 mm/filemap.c:3333
       __do_fault+0x10a/0x490 mm/memory.c:4882
       do_shared_fault mm/memory.c:5361 [inline]
       do_fault mm/memory.c:5435 [inline]
       do_pte_missing+0x1a8/0x3e70 mm/memory.c:3965
       handle_pte_fault mm/memory.c:5766 [inline]
       __handle_mm_fault+0x100a/0x2a10 mm/memory.c:5909
       handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077
       faultin_page mm/gup.c:1187 [inline]
       __get_user_pages+0x8d9/0x3b50 mm/gup.c:1485
       __get_user_pages_locked mm/gup.c:1751 [inline]
       faultin_page_range+0x24a/0x980 mm/gup.c:1975
       madvise_populate mm/madvise.c:943 [inline]
       do_madvise+0x4db/0x760 mm/madvise.c:1458
       __do_sys_madvise mm/madvise.c:1477 [inline]
       __se_sys_madvise mm/madvise.c:1475 [inline]
       __x64_sys_madvise+0xa9/0x110 mm/madvise.c:1475
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault mm/memory.c:6716 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6709
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x29/0xd0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup+0xa8/0x180 kernel/trace/blktrace.c:626
       blk_trace_ioctl+0x163/0x290 kernel/trace/blktrace.c:740
       blkdev_ioctl+0x109/0x6d0 block/ioctl.c:682
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->debugfs_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x42b/0x640 block/blk-mq-sched.c:473
       elevator_init_mq+0x2cd/0x420 block/elevator.c:610
       add_disk_fwnode+0x113/0x1300 block/genhd.c:413
       sd_probe+0xa86/0x1000 drivers/scsi/sd.c:4024
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x23e/0xa90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
       __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
       bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x1d3/0x290 drivers/base/dd.c:987
       async_run_entry_fn+0x9c/0x530 kernel/async.c:129
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (&q->q_usage_counter(queue)#51){++++}-{0:0}:
       blk_queue_enter+0x50f/0x640 block/blk-core.c:328
       blk_mq_alloc_request+0x59b/0x950 block/blk-mq.c:652
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x1eb/0xf40 drivers/scsi/scsi_lib.c:304
       read_capacity_16+0x213/0xe10 drivers/scsi/sd.c:2655
       sd_read_capacity drivers/scsi/sd.c:2824 [inline]
       sd_revalidate_disk.isra.0+0x1a06/0xa8d0 drivers/scsi/sd.c:3734
       sd_probe+0x904/0x1000 drivers/scsi/sd.c:4010
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x23e/0xa90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
       __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
       bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x1d3/0x290 drivers/base/dd.c:987
       async_run_entry_fn+0x9c/0x530 kernel/async.c:129
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->limits_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:945 [inline]
       __nbd_set_size+0x2c0/0x730 drivers/block/nbd.c:351
       nbd_set_size drivers/block/nbd.c:388 [inline]
       nbd_start_device+0x8fd/0xd70 drivers/block/nbd.c:1456
       nbd_genl_connect+0x1204/0x1c00 drivers/block/nbd.c:2139
       genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2541
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
       netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1347
       netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1891
       sock_sendmsg_nosec net/socket.c:711 [inline]
       __sock_sendmsg net/socket.c:726 [inline]
       ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2583
       ___sys_sendmsg+0x135/0x1e0 net/socket.c:2637
       __sys_sendmsg+0x16e/0x220 net/socket.c:2669
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
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

5 locks held by syz.0.799/8860:
 #0: ffffffff8ff7b250 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ff7b308 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8ff7b308 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8ff7b308 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:57 [inline]
 #1: ffffffff8ff7b308 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x580/0x800 net/netlink/genetlink.c:1209
 #2: ffff888026494198 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_genl_connect+0xa1b/0x1c00 drivers/block/nbd.c:2049
 #3: ffff88810761d8b0 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_set_size drivers/block/nbd.c:387 [inline]
 #3: ffff88810761d8b0 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_start_device+0x8ef/0xd70 drivers/block/nbd.c:1456
 #4: ffff88810761d8e8 (&q->q_usage_counter(queue)#33){+.+.}-{0:0}, at: nbd_set_size drivers/block/nbd.c:387 [inline]
 #4: ffff88810761d8e8 (&q->q_usage_counter(queue)#33){+.+.}-{0:0}, at: nbd_start_device+0x8ef/0xd70 drivers/block/nbd.c:1456

stack backtrace:
CPU: 1 UID: 0 PID: 8860 Comm: syz.0.799 Not tainted 6.12.0-syzkaller-08446-g228a1157fb9f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
 queue_limits_start_update include/linux/blkdev.h:945 [inline]
 __nbd_set_size+0x2c0/0x730 drivers/block/nbd.c:351
 nbd_set_size drivers/block/nbd.c:388 [inline]
 nbd_start_device+0x8fd/0xd70 drivers/block/nbd.c:1456
 nbd_genl_connect+0x1204/0x1c00 drivers/block/nbd.c:2139
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2541
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2583
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2637
 __sys_sendmsg+0x16e/0x220 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcb6717e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcb6804d038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fcb67335fa0 RCX: 00007fcb6717e819
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 000000000000000a
RBP: 00007fcb671f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fcb67335fa0 R15: 00007fff7ae9a428
 </TASK>
nbd0: detected capacity change from 0 to 256


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
