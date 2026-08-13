Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA858314B95
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598258; cv=none; b=mjgQQggVOlAaS44K1YKjDaKTtnKBXVczohL3AsiE8iKL/OoLEFTuUJTqkVx9YT9440Qfhv2rkzLyVg3hxU31+Q/t48DYj5BkwB/l/rYuEbvBArBnm5MVSIy2pcH+P+GULWq/KITvH9hSQgQqEcVY/z7/sdzULeu61ingroG0kNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598258; c=relaxed/simple;
	bh=DTlfCt/dnTqT1iwlYFLOnUTSZeZf1RNhF41VMf81wks=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BXA2ZLIEhpDnHYvJbOFCdu+M/pGkg5sEFYPfdl7H/GdywbYy0PXW7QFL7cyu373BJc9Wojs3gUTrJ7YoPvIU0GlBOen24fWRDzMSFZvxrMzoAam59sfFU6Beu5e+VP7VxBTt0ALvNXpg2N6a3fIMHhIAm3+b3edt1Jy2BcuPV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4ab260600easo745069b6e.1
        for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 22:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786598248; x=1787203048;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hM5DZqNTFKbSdqexd8s5sfaEc9sprn3Y/lejP2IpkLo=;
        b=V53SjV2gLHS08Ul2d/Ez4i88PIy1otwkOB8QM68YybgF31sRSjENvmmpwvFSsWtZwD
         mpP/cwgZAusNErB+vMPVWAf8colH0ow1Fl19BIincE78jaksF3wa1PD3UlcFOYFiMLKD
         /dNoekEZdR9qk2cdOZs+WCb9iQn6uGpWZ6Qwy0Vpmoo0dyzkE8xbWm+O7/Y5PUUEzt+3
         TB9bqYXLmNIT2+lgfXQRW+8m4jMtHKy/pj44F4ZQ79CezaZm/MSDe8zZW6RA+fdWwYGr
         QIzqXHFuQkiNyveLXREFDjV5iTi3viapfN4eyFc4uDnBcZS5g/UxaRKNRf+6TN17Ha8F
         51ew==
X-Forwarded-Encrypted: i=1; AHgh+Rqj8boM+LNNySJWftIyNoejwbAU/jPPZs96UerI0byCO+eWJMeQZtpdbg9nwPqsQeO8tEdtN/GJW9jmjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqzWgNhUgquhrwTzRd01Jt1xPYPXFKTBDIqD46SzbD5usvL1w
	U3UX44CbYGKjCkKOZ7dIvMevP9bXr1eUqJNaW1ft8WTtV9vhIZL+tnWmjXQyJR7LVGY/K1fAGrF
	m073slZJafiP6jJuNmkmX2wOTXQHJ4gkjy95TdF8oMz+IXRsNQhpYjTNpzwM=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:148b:b0:495:ca1b:7865 with SMTP id
 5614622812f47-4b228202540mr2579042b6e.11.1786598248105; Wed, 12 Aug 2026
 22:17:28 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:17:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7d5368.d5f0ebe7.22d851.0013.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in lo_ioctl
From: syzbot <syzbot+cc0de396bac84da51919@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b8c8af514d7 Add linux-next specific files for 20260807
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1615c079580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d343b54cc50df0f
dashboard link: https://syzkaller.appspot.com/bug?extid=cc0de396bac84da51919
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/71ff4edcb608/disk-6b8c8af5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f5fa331d8f2/vmlinux-6b8c8af5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f993558ec63b/bzImage-6b8c8af5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc0de396bac84da51919@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.4.8555/6352 is trying to acquire lock:
ffff88802688d118 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:1101 [inline]
ffff88802688d118 (&q->limits_lock){+.+.}-{4:4}, at: loop_set_dio drivers/block/loop.c:1460 [inline]
ffff88802688d118 (&q->limits_lock){+.+.}-{4:4}, at: lo_simple_ioctl drivers/block/loop.c:1528 [inline]
ffff88802688d118 (&q->limits_lock){+.+.}-{4:4}, at: lo_ioctl+0x16ca/0x2150 drivers/block/loop.c:1594

but task is already holding lock:
ffff88802688cae0 (&q->q_usage_counter(io)#26){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
ffff88802688cae0 (&q->q_usage_counter(io)#26){++++}-{0:0}, at: loop_set_dio drivers/block/loop.c:1455 [inline]
ffff88802688cae0 (&q->q_usage_counter(io)#26){++++}-{0:0}, at: lo_simple_ioctl drivers/block/loop.c:1528 [inline]
ffff88802688cae0 (&q->q_usage_counter(io)#26){++++}-{0:0}, at: lo_ioctl+0x1688/0x2150 drivers/block/loop.c:1594

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#26){++++}-{0:0}:
       bio_queue_enter block/blk.h:95 [inline]
       blk_mq_submit_bio+0x7fa/0x2a40 block/blk-mq.c:3127
       __submit_bio_noacct_mq block/blk-core.c:756 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:790
       bh_submit fs/buffer.c:1146 [inline]
       __bread_slow fs/buffer.c:1157 [inline]
       __bread_gfp+0x1e9/0x380 fs/buffer.c:1403
       sb_bread include/linux/buffer_head.h:344 [inline]
       fat12_ent_bread+0x156/0x570 fs/fat/fatent.c:77
       fat_ent_read_block+0x391/0x4b0 fs/fat/fatent.c:450
       fat_alloc_clusters+0x434/0xe30 fs/fat/fatent.c:498
       fat_alloc_new_dir+0x160/0xb90 fs/fat/dir.c:1184
       vfat_mkdir+0x13a/0x300 fs/fat/namei_vfat.c:861
       vfs_mkdir+0x40c/0x620 fs/namei.c:5410
       filename_mkdirat+0x285/0x510 fs/namei.c:5443
       __do_sys_mkdirat fs/namei.c:5464 [inline]
       __se_sys_mkdirat+0x35/0x150 fs/namei.c:5461
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&sbi->fat_lock){+.+.}-{4:4}:
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
       do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&q->limits_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x15ff/0x2e50 kernel/locking/lockdep.c:5254
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
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
       do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->limits_lock --> &sbi->fat_lock --> &q->q_usage_counter(io)#26

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#26);
                               lock(&sbi->fat_lock);
                               lock(&q->q_usage_counter(io)#26);
  lock(&q->limits_lock);

 *** DEADLOCK ***

locks held by syz.4.8555/6352: 3, last CPU#1:
 #0: ffff8880267e7430 (&lo->lo_mutex){+.+.}-{4:4}, at: lo_simple_ioctl drivers/block/loop.c:1520 [inline]
 #0: ffff8880267e7430 (&lo->lo_mutex){+.+.}-{4:4}, at: lo_ioctl+0x7c4/0x2150 drivers/block/loop.c:1594
 #1: ffff88802688cae0 (&q->q_usage_counter(io)#26){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 #1: ffff88802688cae0 (&q->q_usage_counter(io)#26){++++}-{0:0}, at: loop_set_dio drivers/block/loop.c:1455 [inline]
 #1: ffff88802688cae0 (&q->q_usage_counter(io)#26){++++}-{0:0}, at: lo_simple_ioctl drivers/block/loop.c:1528 [inline]
 #1: ffff88802688cae0 (&q->q_usage_counter(io)#26){++++}-{0:0}, at: lo_ioctl+0x1688/0x2150 drivers/block/loop.c:1594
 #2: ffff88802688cb18 (&q->q_usage_counter(queue)#10){+.+.}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 #2: ffff88802688cb18 (&q->q_usage_counter(queue)#10){+.+.}-{0:0}, at: loop_set_dio drivers/block/loop.c:1455 [inline]
 #2: ffff88802688cb18 (&q->q_usage_counter(queue)#10){+.+.}-{0:0}, at: lo_simple_ioctl drivers/block/loop.c:1528 [inline]
 #2: ffff88802688cb18 (&q->q_usage_counter(queue)#10){+.+.}-{0:0}, at: lo_ioctl+0x1688/0x2150 drivers/block/loop.c:1594

stack backtrace:
CPU: 1 UID: 0 PID: 6352 Comm: syz.4.8555 Tainted: G             L      syzkaller #0 PREEMPT(full) 
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
 queue_limits_start_update include/linux/blkdev.h:1101 [inline]
 loop_set_dio drivers/block/loop.c:1460 [inline]
 lo_simple_ioctl drivers/block/loop.c:1528 [inline]
 lo_ioctl+0x16ca/0x2150 drivers/block/loop.c:1594
 blkdev_ioctl+0x5e3/0x740 block/ioctl.c:798
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f450119e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f45020e0028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4501426090 RCX: 00007f450119e0d9
RDX: 0000000000000000 RSI: 0000000000004c08 RDI: 0000000000000008
RBP: 00007f4501235024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4501426128 R14: 00007f4501426090 R15: 00007ffee924f4a8
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
