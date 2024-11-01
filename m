Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF51CEAAC
	for <linux-block@vger.kernel.org>; Fri,  1 Nov 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485764; cv=none; b=qeokmy2Qf/OdddsBbjsAsvvPs5wlpdWp0mwvrb/WkwM47oxPoU4HamDLpZE2AczgDKK06IJdgPHRoujvVDVIPMogX+UVT4/EHlei6wTYP5eesS70dRGnbG4KRq+2YiPMlGIju/lh8IeotzrAKrRpWUMyyUdKuhUF8wneZB/zBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485764; c=relaxed/simple;
	bh=bj+Z2+fK7QDnvOoriellPY4+kBoaVnOhGS4odslSkvs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JTaw/akBlmWsEOZ936K8XSh262s4TKuCdKauxlURRZ9V4zAKV3l6F1jGahAX13VCb+ea3bobFHLVQ15TNEIhZXkHlpDOQkoaZXQVNFs2630gULoukaoy15bLfeGwe4sU/c6qbyUrnAoRddXMes7PLh3J4c+KHc2A82iCcXt1GOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3f7b8b116so24149205ab.0
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2024 11:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730485761; x=1731090561;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3vpi1OtBL8kt4ooyM45FruA/dePfdJoBpblx/DDJSw=;
        b=wYiNi3pQ2vj9m343bMYmyfNzcVFXDhkQaPLf/TAZzk966bfzyUsJS0Pby+knHNeWiT
         E8Eb5yqZ3fjzkNkhDysdjEU04LzQojbIopM85UTdddgptZkI7vycQAFjFN8kiA4af8El
         3c6xhLZNVQ21aJ24y9eUs37L4Yzf1JduzCEt/4Q9NzKbig4fhY2XyIi/g7iFIAAwRFyp
         CX5pN/aRQUKb6WU2ZrYfSwpVuM9DI7MG+23287SVlONhiUsmJzM4pNcG+Vyi5DCUczlu
         Z7m6rFNT/6pocgR+/OU9IRGMKDOExkqROf/CMQ5T0GpO+G3kI9eUizcbgSravKi5YuXa
         pjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOPwrIT0XUhSBw6LC2M1ZoxplL1AwTxC9qjGHH2osNmvKIuuVpoCJEWA3etyuOyduQv5AnqcGfT13hgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPH5ZRt65mrL5sAdU4qQkQjy2PSzKNPkQ0kk8hqWtYIpiTTGAc
	xmRfSIom8Rs/sqSn04FXeUjTamfOX/qc0qngFg3GT+3mIrw/6GtVQdQ8l5LzSOmhDvdNvAXytBt
	m4xuV2XjBBniEwK4XqAhQUwrNVsSWm8g1Io+rzlOVOQjIaSyJg8g3etk=
X-Google-Smtp-Source: AGHT+IH2fGGDjbGNAUswpIeICQIHOFI8a9e6JxTAYScOehBjCz9wkpnXujxXVYy06+99WjW3XaVed7sg9+fb87+SpcGkVU4y85ZJ
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:339f:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a6a94a3944mr52344175ab.6.1730485761737; Fri, 01 Nov 2024
 11:29:21 -0700 (PDT)
Date: Fri, 01 Nov 2024 11:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67251e01.050a0220.529b6.0161.GAE@google.com>
Subject: [syzbot] [block?] [trace?] possible deadlock in blk_trace_ioctl
From: syzbot <syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10016630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c16289c8c99b02cac1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125a9340580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
------------------------------------------------------
syz.0.15/6016 is trying to acquire lock:
ffff88807ef8bde0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xaa/0x120 mm/memory.c:6751

but task is already holding lock:
ffff8881437a2fc0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_ioctl+0xdd/0x9a0 kernel/trace/blktrace.c:735

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->debugfs_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x3fa/0x830 block/blk-mq-sched.c:473
       elevator_init_mq+0x1d8/0x2d0 block/elevator.c:605
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

-> #2 (&q->q_usage_counter(io)#66){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3069
       __submit_bio+0x2c2/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       ext4_io_submit fs/ext4/page-io.c:377 [inline]
       io_submit_add_bh fs/ext4/page-io.c:418 [inline]
       ext4_bio_write_folio+0x123a/0x1d70 fs/ext4/page-io.c:560
       mpage_submit_folio+0x1af/0x230 fs/ext4/inode.c:1921
       mpage_map_and_submit_buffers fs/ext4/inode.c:2167 [inline]
       mpage_map_and_submit_extent fs/ext4/inode.c:2299 [inline]
       ext4_do_writepages+0x1d1d/0x3d20 fs/ext4/inode.c:2724
       ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2813
       do_writepages+0x35d/0x870 mm/page-writeback.c:2702
       __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1656
       writeback_sb_inodes+0x80c/0x1370 fs/fs-writeback.c:1952
       __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2023
       wb_writeback+0x42f/0xbd0 fs/fs-writeback.c:2134
       wb_check_background_flush fs/fs-writeback.c:2204 [inline]
       wb_do_writeback fs/fs-writeback.c:2292 [inline]
       wb_workfn+0xc58/0x1090 fs/fs-writeback.c:2319
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (jbd2_handle){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       start_this_handle+0x1eb4/0x2110 fs/jbd2/transaction.c:448
       jbd2__journal_start+0x2da/0x5d0 fs/jbd2/transaction.c:505
       __ext4_journal_start_sb+0x239/0x600 fs/ext4/ext4_jbd2.c:112
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0x92/0x110 fs/ext4/inode.c:5981
       __mark_inode_dirty+0x2ee/0xe90 fs/fs-writeback.c:2491
       generic_update_time fs/inode.c:2110 [inline]
       inode_update_time fs/inode.c:2123 [inline]
       touch_atime+0x413/0x690 fs/inode.c:2195
       file_accessed include/linux/fs.h:2538 [inline]
       ext4_file_mmap+0x18c/0x540 fs/ext4/file.c:797
       call_mmap include/linux/fs.h:2182 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2287 [inline]
       __mmap_new_vma mm/vma.c:2351 [inline]
       __mmap_region+0x2204/0x2cd0 mm/vma.c:2452
       mmap_region+0x226/0x2c0 mm/mmap.c:1373
       do_mmap+0x8f0/0x1000 mm/mmap.c:496
       vm_mmap_pgoff+0x214/0x430 mm/util.c:580
       ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6751
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
       blk_trace_ioctl+0x1ad/0x9a0 kernel/trace/blktrace.c:740
       blkdev_ioctl+0x40c/0x6a0 block/ioctl.c:682
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &q->q_usage_counter(io)#66 --> &q->debugfs_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->debugfs_mutex);
                               lock(&q->q_usage_counter(io)#66);
                               lock(&q->debugfs_mutex);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz.0.15/6016:
 #0: ffff8881437a2fc0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_ioctl+0xdd/0x9a0 kernel/trace/blktrace.c:735

stack backtrace:
CPU: 0 UID: 0 PID: 6016 Comm: syz.0.15 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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
 __might_fault+0xc6/0x120 mm/memory.c:6751
 _inline_copy_from_user include/linux/uaccess.h:162 [inline]
 _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:212 [inline]
 __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
 blk_trace_ioctl+0x1ad/0x9a0 kernel/trace/blktrace.c:740
 blkdev_ioctl+0x40c/0x6a0 block/ioctl.c:682
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5890d7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe77be6aa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5890f35f80 RCX: 00007f5890d7e719
RDX: 0000000000000000 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f5890df132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5890f35f80 R14: 00007f5890f35f80 R15: 0000000000000304
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
