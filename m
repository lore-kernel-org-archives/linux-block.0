Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555738B7AA
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786922259; cv=none; b=HR08NZh3k5Ot/o9w1SCHyvjonRmSewSE4nXNOkg9UFpwLV3lmebnYYJz2q6LQ5qaTBbRx/gX/wlE5BnqDpyxDcmh799BjDwbTeZ7ZKUe7+Kn33DWR+ApWpPEqEnQFPljR66hq9qTHLJZHBWVhL0YwemUspRTyav5xCmWRNXfHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786922259; c=relaxed/simple;
	bh=lHfFIB7oIONpY+HKUvouDCxc1Ccd26t1/+qKjCtnEA4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f6K0mutXAiDjoNfwLXJqsBaXuzP1yHF2lBLtiiK4paCd5dwD05UphwLS7oHsZAezHgTwwSpQoi7f3GYXo8DIAZpyUTZiCMfve8ZjvLvuBZZlRAgfZDBMtZH9DGQGmDiOoc5OJD0rTitnMD3hYVdCjtX4x6RTUNt1naRdp5sRUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7e9e741693bso3762129a34.0
        for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 16:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786922257; x=1787527057;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=djcC6f7hbWrlo69GufLdnmUm94cjd0gpFF3QrxH4P+o=;
        b=msKyMGMH7rTTLDE50Z+sTFfefeFoBERu9gOULrV3OaQjxSQILHpzgHtIfddpN8u0Yo
         PXYTj+GhZ1TO4WSPJY63QHec3AzJTn8NcBNCGD/AxLrliFp0PAwKK+/2HpKy3zHnkvuY
         atRYKnJxHS533Zq3Htq9jlfSr8zriifPKWYI6u5L7tQ6tmxTaGL44anDQ0tsnaKokeoa
         WWBKQJ48/FiTwZDg7+e+vYCSd9sBWYh1tNMJmUgtitzX3jckXpW4jzD0Bu0PzgmGD0V0
         s6VgE2llTjuM1ONZGDKLAkiwiDSgEAEGZpIL78amvbahGOrL1UFNRPVToLbXjC5dYeha
         hyFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqwmd9Fwq9970O9Q/jBiRv0ZX2wMlMD16YFKhqJplEHVUdFuTU7abJPO924dyrE+j6Ndsb6l3o6r846jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+SvrO0M6fEoyyMF/ymchy1gSrBlN/7Q9UkN2iBJR4jNNGPt7d
	gSJ1/hSzCSR1mbTSfCvObLheIrBafbQL8Cm0NochudD4eDSbelbCbAZRRgJCAylrZGLRoFPFC8t
	dsuTV8pzndmZWrLOP3tOO/lpy+qWg0/2ps8Y1beUDoL4j3lBwm+3OpRg4IiM=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee83:0:b0:6ac:a994:8a02 with SMTP id
 006d021491bc7-6b0d618ec21mr19779371eaf.12.1786922256822; Sun, 16 Aug 2026
 16:17:36 -0700 (PDT)
Date: Sun, 16 Aug 2026 16:17:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a824510.dbb3a75c.20434b.003b.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in submit_bio_noacct_nocheck (2)
From: syzbot <syzbot+ab02331ccbc7523c65ab@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28d012efb432 Add linux-next specific files for 20260812
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=108db225580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a13c7bc480b5c3f
dashboard link: https://syzkaller.appspot.com/bug?extid=ab02331ccbc7523c65ab
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de882be6df4b/disk-28d012ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/412cb9fb7e2d/vmlinux-28d012ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d7096c27f1b/bzImage-28d012ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab02331ccbc7523c65ab@syzkaller.appspotmail.com

loop7: detected capacity change from 0 to 8192
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.7.6727/29554 is trying to acquire lock:
ffff888026c5f020 (&q->q_usage_counter(io)#24){++++}-{0:0}, at: __submit_bio_noacct_mq block/blk-core.c:756 [inline]
ffff888026c5f020 (&q->q_usage_counter(io)#24){++++}-{0:0}, at: submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:790

but task is already holding lock:
ffff88805b4b80a8 (&sbi->fat_lock){+.+.}-{4:4}, at: lock_fat fs/fat/fatent.c:285 [inline]
ffff88805b4b80a8 (&sbi->fat_lock){+.+.}-{4:4}, at: fat_alloc_clusters+0x1f2/0xe30 fs/fat/fatent.c:482

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->fat_lock){+.+.}-{4:4}:
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

-> #1 (&q->limits_lock){+.+.}-{4:4}:
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

-> #0 (&q->q_usage_counter(io)#24){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x15ff/0x2e50 kernel/locking/lockdep.c:5254
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
       bio_queue_enter block/blk.h:95 [inline]
       blk_mq_submit_bio+0x7f8/0x2a70 block/blk-mq.c:3127
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
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->q_usage_counter(io)#24 --> &q->limits_lock --> &sbi->fat_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->fat_lock);
                               lock(&q->limits_lock);
                               lock(&sbi->fat_lock);
  rlock(&q->q_usage_counter(io)#24);

 *** DEADLOCK ***

locks held by syz.7.6727/29554: 4, last CPU#0:
 #0: ffff8880357fc460 (sb_writers#17){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:494
 #1: ffff88806a592260 (&sb->s_type->i_mutex_key#32/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #1: ffff88806a592260 (&sb->s_type->i_mutex_key#32/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2918 [inline]
 #1: ffff88806a592260 (&sb->s_type->i_mutex_key#32/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2942 [inline]
 #1: ffff88806a592260 (&sb->s_type->i_mutex_key#32/1){+.+.}-{4:4}, at: filename_create+0x200/0x370 fs/namei.c:5092
 #2: ffff88805b4b81b8 (&sbi->s_lock){+.+.}-{4:4}, at: vfat_mkdir+0x10f/0x300 fs/fat/namei_vfat.c:858
 #3: ffff88805b4b80a8 (&sbi->fat_lock){+.+.}-{4:4}, at: lock_fat fs/fat/fatent.c:285 [inline]
 #3: ffff88805b4b80a8 (&sbi->fat_lock){+.+.}-{4:4}, at: fat_alloc_clusters+0x1f2/0xe30 fs/fat/fatent.c:482

stack backtrace:
CPU: 0 UID: 0 PID: 29554 Comm: syz.7.6727 Tainted: G             L      syzkaller #0 PREEMPT(full) 
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
 bio_queue_enter block/blk.h:95 [inline]
 blk_mq_submit_bio+0x7f8/0x2a70 block/blk-mq.c:3127
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
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f165a19cf47
Code: 00 66 90 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 db f7 ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 b8 02 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f165b14be58 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f165b14bee0 RCX: 00007f165a19cf47
RDX: 00000000000001ff RSI: 0000200000000240 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000000240
R13: 00007f165b14bea0 R14: 0000000000000000 R15: 0000000000000000
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
