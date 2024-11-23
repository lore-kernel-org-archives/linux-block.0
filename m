Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571724A0A
	for <linux-block@vger.kernel.org>; Sat, 23 Nov 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732378885; cv=none; b=kp+SnKbSc60S44q9WWwv+rKaWLrTNdXsH41PWZjYdz/hXdxX1ZDYD9EDhlMVlXIMGA35rKMM389f5uRKgLS5NHne+lIz7m6rA5uKOimx+PZZ+z7rDWO+s4ECgR6I5kJ9yc0yUSn7yAAGGzYxlYtwNtpEq9VNVhHfvA4FPo+tiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732378885; c=relaxed/simple;
	bh=4TPQGsievqHl/PSqlZtdWS5StOymM/C3V+wFLo5gH6k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XmgliCwJ2Ib7DelkcehLn499ObRNt3uQKkARrcc5vCJ8Y3SmMWNa+VlIMQSwpHksdAl4da3ytMKfmS+X/FzYREoGm6JrOQBpPnzHhEJs66cL+NFwpCWYwElg8EFlyaW4J66Da12SkpVNvIml6Mb7ziTotWvry4ec4gzW0/AM4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a77085a3d7so29791325ab.1
        for <linux-block@vger.kernel.org>; Sat, 23 Nov 2024 08:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732378882; x=1732983682;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jy8UjwrVX3VLzymIx7ABQvSzSupfkFE9MjdPt0wK7Ww=;
        b=j2I2coWRgV/BX4/wAyhcL1pfeULLlYiftH5ldrmkvaOpwvsamJM8/kHfgH+u8aGohe
         xT3Zij8+hUnYHPn2/tPHwz0wLcJSEqSU1x8zvxw7vO5OjPq1/CBSY8XNWY257HhYliLv
         mRJCOgMLH/FVIKk5hyFwVpgsXY66dAwbYZUWJPyTCriuwz04wOdBIUKnhhGwqiTFZKnR
         5md7VcM23e0qB+kDhDVHKY/Op6/YgMVjFs8cPVtHa1CRW1XCJnmJ9JdLyz+/sQpx8xMx
         LbGQlyOh2kBRVFApW44ANgIjfY5H1+2COo6UZ1OSVraqO8Yn8Jc+aG88b5dqw60/QGeL
         G1zw==
X-Forwarded-Encrypted: i=1; AJvYcCWv9ZlQeMQySiQBsL7ptQoI0ic2zfSSXrRwtq9PacGKMXd2VSbM48W5pXIdJji2nFrIOVRK8RBJHO3/AA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8oezrHf9fpYFM3umiZpZZdxytHC2EjR6mccs4KPYmNKyl/UG
	UJzbOOZ1SLlZ19QFfgXRaSqW6DRubbyOgdQPZ94G50VlYphqV0axsax3RRzhGfeL5s8QjeQlSQf
	9jxCMjVGuW3YG8fm+tyVlfs9TtMsO1Aa20Nwq/sMCu+6Id5IWt9f/0PY=
X-Google-Smtp-Source: AGHT+IG8F6qA+OuyszWGkPdw0udRaNSsQ5JnCnjcgm1m8VyG9cSxoZ8UgddhqiNV4SB+lknaD3J6Y8RSM1eDUxb8q9pda9lpup5S
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c542:0:b0:3a7:ab88:8c0 with SMTP id
 e9e14a558f8ab-3a7ab88093bmr13792765ab.10.1732378882580; Sat, 23 Nov 2024
 08:21:22 -0800 (PST)
Date: Sat, 23 Nov 2024 08:21:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67420102.050a0220.1cc393.0019.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in __blk_mq_update_nr_hw_queues
From: syzbot <syzbot+bf3d9d590d7fce48d1d9@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fcc79e1714e8 Merge tag 'net-next-6.13' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1086bec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c04b80691ccbb7
dashboard link: https://syzkaller.appspot.com/bug?extid=bf3d9d590d7fce48d1d9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f68aa5d85643/disk-fcc79e17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad99781945ae/vmlinux-fcc79e17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c4059c60213/bzImage-fcc79e17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf3d9d590d7fce48d1d9@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-05480-gfcc79e1714e8 #0 Not tainted
------------------------------------------------------
syz.3.2079/14299 is trying to acquire lock:
ffff8880258cf170 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_elv_switch_none block/blk-mq.c:4847 [inline]
ffff8880258cf170 (&q->sysfs_lock){+.+.}-{4:4}, at: __blk_mq_update_nr_hw_queues+0x446/0x14e0 block/blk-mq.c:4925

but task is already holding lock:
ffff8880258cec40 (&q->q_usage_counter(io)#52){++++}-{0:0}, at: blk_mq_freeze_queue block/blk-mq.c:212 [inline]
ffff8880258cec40 (&q->q_usage_counter(io)#52){++++}-{0:0}, at: __blk_mq_update_nr_hw_queues+0x1fc/0x14e0 block/blk-mq.c:4918

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&q->q_usage_counter(io)#52){++++}-{0:0}:
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1fc4/0x24c0 block/blk-mq.c:3092
       __submit_bio+0x384/0x540 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x6fb/0xd70 block/blk-core.c:739
       submit_bio_noacct+0x93a/0x1e10 block/blk-core.c:868
       submit_bh fs/buffer.c:2825 [inline]
       block_read_full_folio+0x812/0xa50 fs/buffer.c:2452
       filemap_read_folio+0xc6/0x2a0 mm/filemap.c:2367
       filemap_update_page mm/filemap.c:2451 [inline]
       filemap_get_pages+0x1560/0x1be0 mm/filemap.c:2572
       filemap_read+0x3ca/0xd70 mm/filemap.c:2647
       blkdev_read_iter+0x187/0x480 block/fops.c:767
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x87f/0xbe0 fs/read_write.c:565
       ksys_read+0x12b/0x250 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (mapping.invalidate_lock#2){++++}-{4:4}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0x62e/0x2820 mm/filemap.c:3352
       __do_fault+0x10a/0x490 mm/memory.c:4882
       do_read_fault mm/memory.c:5297 [inline]
       do_fault mm/memory.c:5431 [inline]
       do_pte_missing+0xec5/0x3e70 mm/memory.c:3965
       handle_pte_fault mm/memory.c:5766 [inline]
       __handle_mm_fault+0x100a/0x2a10 mm/memory.c:5909
       handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077
       faultin_page mm/gup.c:1187 [inline]
       __get_user_pages+0x8d9/0x3b50 mm/gup.c:1485
       populate_vma_page_range+0x27f/0x3a0 mm/gup.c:1923
       __mm_populate+0x1d6/0x380 mm/gup.c:2026
       do_mlock+0x40a/0x7d0 mm/mlock.c:653
       __do_sys_mlock mm/mlock.c:661 [inline]
       __se_sys_mlock mm/mlock.c:659 [inline]
       __x64_sys_mlock+0x59/0x80 mm/mlock.c:659
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&mm->mmap_lock){++++}-{4:4}:
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

-> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       blk_register_queue+0x13c/0x550 block/blk-sysfs.c:774
       add_disk_fwnode+0x785/0x1300 block/genhd.c:493
       add_disk include/linux/blkdev.h:751 [inline]
       brd_alloc.isra.0+0x5a2/0x840 drivers/block/brd.c:399
       brd_init+0x12b/0x1d0 drivers/block/brd.c:479
       do_one_initcall+0x128/0x700 init/main.c:1266
       do_initcall_level init/main.c:1328 [inline]
       do_initcalls init/main.c:1344 [inline]
       do_basic_setup init/main.c:1363 [inline]
       kernel_init_freeable+0x5c7/0x900 init/main.c:1577
       kernel_init+0x1c/0x2b0 init/main.c:1466
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->sysfs_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       blk_mq_elv_switch_none block/blk-mq.c:4847 [inline]
       __blk_mq_update_nr_hw_queues+0x446/0x14e0 block/blk-mq.c:4925
       blk_mq_update_nr_hw_queues+0x2a/0x40 block/blk-mq.c:4985
       nbd_start_device+0x15b/0xd70 drivers/block/nbd.c:1413
       nbd_start_device_ioctl drivers/block/nbd.c:1464 [inline]
       __nbd_ioctl drivers/block/nbd.c:1539 [inline]
       nbd_ioctl+0x21a/0xfd0 drivers/block/nbd.c:1579
       blkdev_ioctl+0x276/0x6d0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->sysfs_lock --> mapping.invalidate_lock#2 --> &q->q_usage_counter(io)#52

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#52);
                               lock(mapping.invalidate_lock#2);
                               lock(&q->q_usage_counter(io)#52);
  lock(&q->sysfs_lock);

 *** DEADLOCK ***

4 locks held by syz.3.2079/14299:
 #0: ffff888025abc198 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_ioctl+0x151/0xfd0 drivers/block/nbd.c:1572
 #1: ffff888025abc0d8 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x20/0x40 block/blk-mq.c:4984
 #2: ffff8880258cec40 (&q->q_usage_counter(io)#52){++++}-{0:0}, at: blk_mq_freeze_queue block/blk-mq.c:212 [inline]
 #2: ffff8880258cec40 (&q->q_usage_counter(io)#52){++++}-{0:0}, at: __blk_mq_update_nr_hw_queues+0x1fc/0x14e0 block/blk-mq.c:4918
 #3: ffff8880258cec78 (&q->q_usage_counter(queue)#36){+.+.}-{0:0}, at: blk_mq_freeze_queue block/blk-mq.c:212 [inline]
 #3: ffff8880258cec78 (&q->q_usage_counter(queue)#36){+.+.}-{0:0}, at: __blk_mq_update_nr_hw_queues+0x1fc/0x14e0 block/blk-mq.c:4918

stack backtrace:
CPU: 1 UID: 0 PID: 14299 Comm: syz.3.2079 Not tainted 6.12.0-syzkaller-05480-gfcc79e1714e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
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
 blk_mq_elv_switch_none block/blk-mq.c:4847 [inline]
 __blk_mq_update_nr_hw_queues+0x446/0x14e0 block/blk-mq.c:4925
 blk_mq_update_nr_hw_queues+0x2a/0x40 block/blk-mq.c:4985
 nbd_start_device+0x15b/0xd70 drivers/block/nbd.c:1413
 nbd_start_device_ioctl drivers/block/nbd.c:1464 [inline]
 __nbd_ioctl drivers/block/nbd.c:1539 [inline]
 nbd_ioctl+0x21a/0xfd0 drivers/block/nbd.c:1579
 blkdev_ioctl+0x276/0x6d0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa86fb7e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa8709f0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa86fd36080 RCX: 00007fa86fb7e819
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000005
RBP: 00007fa86fbf175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa86fd36080 R15: 00007fffdaf89998
 </TASK>
block nbd3: shutting down sockets


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
