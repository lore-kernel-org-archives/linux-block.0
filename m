Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA44533D6
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786922904; cv=none; b=iUMUhhtgd1QehKcpUUZLZKIgJqm6AwzH6GPDfLvYeKATlU0iTyeRxmVIM6e7JeJX+1MPObPiVzLg6tQl4Z/ylyfQJhRthQFI6JQUrgyTvBhR5ZgJlXdagfxgPPEUOANG/EZ9IIeFsRAkYRZ26uMK9t8KM38nP5g1Wyqx+0RWgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786922904; c=relaxed/simple;
	bh=tesCpZbrkK/1UuElcWZ71/okuj5bvhishlUnWaKoBM0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RuDQgdIIdaq62CXUkw1P36VoVuql4dMw3yvY75lAJbZRBWrWh6yq3DqC9hXsWsT3OA6NaKi8TaML8nQ2gBoRctUYGMwSfTCKvARoA6vvnRkcL25qOtvakB2/yGHx/vdu/OGgNLEF+izieG9ePlDw5SVxCW5KNnL8VFGbXQDY8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-48e5de5a23cso2954955b6e.0
        for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 16:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786922901; x=1787527701;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffuW2TmZXTgFV5IC1qwh6AWCnqfK3ifTsxchtqnc3tY=;
        b=bxHhzFIT/ya0T0jgCuCOXanx0n76rkMKQoSocckPnXZp2pbjo9e1os7kwvc2e0btrZ
         XLwHJNa5mY3BYeSNWra+0kgl4tyNMLt9pQZiPpwNDTjFmWTUPaDVj0lH4RrtK9h3QdMU
         K1u6LgInFvRBDak9SxD9VTy+4tFYD9pSPN8hzN3rYJduNLEwbxLQhwA3Y0+ER2oIExTK
         qDn9vlIZs6Dy0WRI7WPRe9m0707hhJ4ZiKLoRJCKL81octuq3anYJQAOtzxBapAaaCK5
         ypDU/XMLtZyaGKmtjrMl6myyP9oLtlZ14WdyWpsAj0nB5aRnabL2LyRUBdygJKF7srCO
         hBOQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNlBjsiOHsF8BRz8fBt6FLgsn7FmbUIiLE/PpnNB9BVT1PkbvGliU36NcnjvNQCAuiu62in0Dz0gmAMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWV059YE/1FzKNKwtVWWd1szaDY34KME4aoWWc4Qpvrre+8eEH
	6RAtxJQRrKbhHixdB9NTOybgk9awRF1eFwPvmcYzNtM4P37lXEq4TbL4dRYFix3VNRsE0GZmikT
	zFQXcW5Y1FhLqpSnHp5BUEe5FeKM7xe3EFpptrZsjtO7L+EmQlc1Bd62p8Gs=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1912:b0:496:b7c:274b with SMTP id
 5614622812f47-4b241ecce60mr17110773b6e.19.1786922901327; Sun, 16 Aug 2026
 16:28:21 -0700 (PDT)
Date: Sun, 16 Aug 2026 16:28:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a824795.10853dc7.22f513.0015.GAE@google.com>
Subject: [syzbot] [exfat?] possible deadlock in fat_count_free_clusters (2)
From: syzbot <syzbot+e6f6bc2e3e041d4d72dd@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linkinjeon@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28d012efb432 Add linux-next specific files for 20260812
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=154f8ac6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a13c7bc480b5c3f
dashboard link: https://syzkaller.appspot.com/bug?extid=e6f6bc2e3e041d4d72dd
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de882be6df4b/disk-28d012ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/412cb9fb7e2d/vmlinux-28d012ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d7096c27f1b/bzImage-28d012ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6f6bc2e3e041d4d72dd@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 128
FAT-fs (loop2): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
FAT-fs (loop2): Invalid FSINFO signature: 0x41615252, 0x80417272 (sector = 1)
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.2.7389/30564 is trying to acquire lock:
ffff888076f5c0a8 (&sbi->fat_lock){+.+.}-{4:4}, at: lock_fat fs/fat/fatent.c:285 [inline]
ffff888076f5c0a8 (&sbi->fat_lock){+.+.}-{4:4}, at: fat_count_free_clusters+0x157/0xb40 fs/fat/fatent.c:729

but task is already holding lock:
ffff888024a13528 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:1101 [inline]
ffff888024a13528 (&q->limits_lock){+.+.}-{4:4}, at: loop_configure+0x787/0xdc0 drivers/block/loop.c:1083

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->limits_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       queue_limits_start_update include/linux/blkdev.h:1101 [inline]
       loop_set_dio drivers/block/loop.c:1460 [inline]
       lo_simple_ioctl drivers/block/loop.c:1528 [inline]
       lo_ioctl+0x16ca/0x2150 drivers/block/loop.c:1594
       blkdev_ioctl+0x5e3/0x740 block/ioctl.c:798
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#24){++++}-{0:0}:
       bio_queue_enter block/blk.h:95 [inline]
       blk_mq_submit_bio+0x7f8/0x2a70 block/blk-mq.c:3127
       __submit_bio_noacct_mq block/blk-core.c:756 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:790
       bio_await block/bio.c:1578 [inline]
       submit_bio_wait+0x12a/0x250 block/bio.c:1596
       blkdev_issue_discard+0x133/0x1e0 block/blk-lib.c:94
       sb_issue_discard include/linux/blkdev.h:1207 [inline]
       fat_free_clusters+0x430/0xbf0 fs/fat/fatent.c:593
       fat_free fs/fat/file.c:379 [inline]
       fat_truncate_blocks+0x896/0xc00 fs/fat/file.c:397
       fat_write_failed fs/fat/inode.c:219 [inline]
       fat_write_begin+0x127/0x150 fs/fat/inode.c:234
       cont_expand_zero fs/buffer.c:2434 [inline]
       cont_write_begin+0x2d6/0xac0 fs/buffer.c:2496
       fat_write_begin+0x7a/0x150 fs/fat/inode.c:230
       generic_perform_write+0x2d5/0x8f0 mm/filemap.c:4374
       generic_file_write_iter+0xae/0x330 mm/filemap.c:4517
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_pwrite64 fs/read_write.c:794 [inline]
       __do_sys_pwrite64 fs/read_write.c:802 [inline]
       __se_sys_pwrite64 fs/read_write.c:799 [inline]
       __x64_sys_pwrite64+0x196/0x220 fs/read_write.c:799
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sbi->fat_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x15ff/0x2e50 kernel/locking/lockdep.c:5254
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       lock_fat fs/fat/fatent.c:285 [inline]
       fat_count_free_clusters+0x157/0xb40 fs/fat/fatent.c:729
       fat_statfs+0x135/0x400 fs/fat/inode.c:874
       statfs_by_dentry fs/statfs.c:66 [inline]
       vfs_statfs+0x147/0x2d0 fs/statfs.c:90
       loop_get_discard_config drivers/block/loop.c:774 [inline]
       loop_update_limits+0x375/0x920 drivers/block/loop.c:984
       loop_configure+0x7d2/0xdc0 drivers/block/loop.c:1084
       lo_ioctl+0xad5/0x2150 drivers/block/loop.c:1564
       blkdev_ioctl+0x5e3/0x740 block/ioctl.c:798
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sbi->fat_lock --> &q->q_usage_counter(io)#24 --> &q->limits_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->limits_lock);
                               lock(&q->q_usage_counter(io)#24);
                               lock(&q->limits_lock);
  lock(&sbi->fat_lock);

 *** DEADLOCK ***

locks held by syz.2.7389/30564: 2, last CPU#1:
 #0: ffff888024aba430 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_global_lock_killable drivers/block/loop.c:119 [inline]
 #0: ffff888024aba430 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_configure+0x35d/0xdc0 drivers/block/loop.c:1038
 #1: ffff888024a13528 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:1101 [inline]
 #1: ffff888024a13528 (&q->limits_lock){+.+.}-{4:4}, at: loop_configure+0x787/0xdc0 drivers/block/loop.c:1083

stack backtrace:
CPU: 1 UID: 0 PID: 30564 Comm: syz.2.7389 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2059
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2191
 check_prev_add kernel/locking/lockdep.c:3181 [inline]
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x15ff/0x2e50 kernel/locking/lockdep.c:5254
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
 lock_fat fs/fat/fatent.c:285 [inline]
 fat_count_free_clusters+0x157/0xb40 fs/fat/fatent.c:729
 fat_statfs+0x135/0x400 fs/fat/inode.c:874
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x147/0x2d0 fs/statfs.c:90
 loop_get_discard_config drivers/block/loop.c:774 [inline]
 loop_update_limits+0x375/0x920 drivers/block/loop.c:984
 loop_configure+0x7d2/0xdc0 drivers/block/loop.c:1084
 lo_ioctl+0xad5/0x2150 drivers/block/loop.c:1564
 blkdev_ioctl+0x5e3/0x740 block/ioctl.c:798
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f704bd9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f704cc92028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f704c025fa0 RCX: 00007f704bd9e0d9
RDX: 00002000000005c0 RSI: 0000000000004c0a RDI: 0000000000000004
RBP: 00007f704be35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f704c026038 R14: 00007f704c025fa0 R15: 00007ffda9ce6638
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
