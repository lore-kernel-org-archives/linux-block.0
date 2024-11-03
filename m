Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762F189BA0
	for <linux-block@vger.kernel.org>; Sun,  3 Nov 2024 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730672371; cv=none; b=MbXq6zupQwe7JjlhAuvzkxK+BuVKDSLLldYMBMS3AChrT9UWlIkVjDXUHS/HL42dvz1JFxn20RkOcSy+hqFzd0afXfz4aLficiYEa5AEAr4rHuApPReL1dUjD541eCbF10vpcCdeQe3D8pPzz/RfG7ac8tfQLqnpmmwvcPmyd28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730672371; c=relaxed/simple;
	bh=bO9OJotYEzM2+vVRB5il0EnhrqFe5lgqyaf6ZsQf/Q4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VpMDOv/eoPowFxyXyb5rJPhcsDzMy6EeUE1Hwgn82lJRh4AZ+r6rvQKDMiyHJabo6HF+JWp9BZc1oV+BNu8W1JqSs3IR15vxZbC7vyrz+sR/amaXLIm9+G2MqqUG4XbogQ142l9ahauCxZ1s5znju/zxIM3rl7mZmi//qTKrqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so39657035ab.0
        for <linux-block@vger.kernel.org>; Sun, 03 Nov 2024 14:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730672368; x=1731277168;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZIgSmxRYm8E+xa5d7Au2QP17BqgW2Q7/r/PyOGlTVo=;
        b=Ncu15pcHIAvSJGOPBHhba5uynhnuzKUuHNhwhhCcOA6ZJtn/zvSL2v2+Ext+ZsiSgs
         2iorw6UiQGgN41BjMm7OdL1XyXzI6C+XLNIuMdJYdM21TSsrkVwhHvwnSvkSv5HgWAI1
         6tIHlOoNI4yq9CDOh9V5VqFUIKRN8BvkWp2k8CS5A24bs3l/eovDYyy+uZFdptYx858L
         Kvxw+FVA6UO5uOQ3rFDy1fYP2NFrx5u2MLcutI1mMos87KsHHEfoYSa6+hIMThvTgsOr
         CrpaqFRZGc6pvoTFSU2sPzbURX+nez9KtyO4ScuALdWAqlc7tvxAZ1jRyQuP1COZEW04
         mGBw==
X-Forwarded-Encrypted: i=1; AJvYcCXJEwYeJOpPr7pTdG+9lszMa+pur3IJZu5pPmrxJ5sXAwXulyVem8DczSZQYviRm/aq+c0lEPoE8v8KqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MtjsyXTHd4Wnu0AFRLEKll66CgNiqwzPepOSPMxO9q6YQpfh
	Yv1ZP9862T5k0OheCrZfaL8fFsF90U66NezkG3IH70/Ys9Ubi+xivRCtiZmkzQvRdn08TX73SU3
	tknPMXoY76pok3s6e6M0XmqtvCo3n3e4Qv/9odHJD8Vsbb3wi06ixCaA=
X-Google-Smtp-Source: AGHT+IGEcWcWl7bGZfPIF94SJSQTObO7kdMGWvP5SyTeJURLHfWp1YQ01L634BbBAjTVcWBkYfIv5i0qVIi4aog4SyE3l7Su2C0t
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3a6:b360:c6e5 with SMTP id
 e9e14a558f8ab-3a6b360c89amr93253375ab.16.1730672368513; Sun, 03 Nov 2024
 14:19:28 -0800 (PST)
Date: Sun, 03 Nov 2024 14:19:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727f6f0.050a0220.3c8d68.0aa9.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in __submit_bio
From: syzbot <syzbot+949ae54e95a2fab4cbb4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f26630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=949ae54e95a2fab4cbb4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102632a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16749340580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/61af3e8f2dbd/mount_0.gz

The issue was bisected to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13eafaa7980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=101afaa7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17eafaa7980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+949ae54e95a2fab4cbb4@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

exFAT-fs (loop0): failed to load upcase table (idx : 0x00012153, chksum : 0x822ffc2e, utbl_chksum : 0xe619d30d)
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor382/6007 is trying to acquire lock:
ffff8881427474e8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: __submit_bio+0x2c2/0x560 block/blk-core.c:629

but task is already holding lock:
ffff888034dd00e8 (&sbi->s_lock){+.+.}-{4:4}, at: exfat_create+0x1a2/0x5a0 fs/exfat/namei.c:553

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->s_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       exfat_lookup+0x140/0x18f0 fs/exfat/namei.c:701
       lookup_open fs/namei.c:3573 [inline]
       open_last_lookups fs/namei.c:3694 [inline]
       path_openat+0x11a7/0x3590 fs/namei.c:3930
       do_filp_open+0x235/0x490 fs/namei.c:3960
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1419
       do_sys_open fs/open.c:1434 [inline]
       __do_sys_openat fs/open.c:1450 [inline]
       __se_sys_openat fs/open.c:1445 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1445
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&sb->s_type->i_mutex_key#15){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:817 [inline]
       __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1536
       exfat_file_fsync+0xf9/0x1d0 fs/exfat/file.c:524
       __loop_update_dio+0x1a4/0x500 drivers/block/loop.c:204
       loop_set_status+0x62b/0x8f0 drivers/block/loop.c:1290
       lo_ioctl+0xcbc/0x1f50
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3069
       __submit_bio+0x2c2/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2819 [inline]
       __sync_dirty_buffer+0x23d/0x390 fs/buffer.c:2857
       exfat_set_volume_dirty+0x5d/0x80 fs/exfat/super.c:124
       exfat_create+0x1aa/0x5a0 fs/exfat/namei.c:554
       lookup_open fs/namei.c:3595 [inline]
       open_last_lookups fs/namei.c:3694 [inline]
       path_openat+0x1c03/0x3590 fs/namei.c:3930
       do_filp_open+0x235/0x490 fs/namei.c:3960
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1419
       do_sys_open fs/open.c:1434 [inline]
       __do_sys_openat fs/open.c:1450 [inline]
       __se_sys_openat fs/open.c:1445 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1445
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->q_usage_counter(io)#17 --> &sb->s_type->i_mutex_key#15 --> &sbi->s_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_lock);
                               lock(&sb->s_type->i_mutex_key#15);
                               lock(&sbi->s_lock);
  rlock(&q->q_usage_counter(io)#17);

 *** DEADLOCK ***

3 locks held by syz-executor382/6007:
 #0: ffff888034b8a420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88807733e330 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: inode_lock include/linux/fs.h:817 [inline]
 #1: ffff88807733e330 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: open_last_lookups fs/namei.c:3691 [inline]
 #1: ffff88807733e330 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: path_openat+0x89a/0x3590 fs/namei.c:3930
 #2: ffff888034dd00e8 (&sbi->s_lock){+.+.}-{4:4}, at: exfat_create+0x1a2/0x5a0 fs/exfat/namei.c:553

stack backtrace:
CPU: 0 UID: 0 PID: 6007 Comm: syz-executor382 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
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
 bio_queue_enter block/blk.h:75 [inline]
 blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3069
 __submit_bio+0x2c2/0x560 block/blk-core.c:629
 __submit_bio_noacct_mq block/blk-core.c:710 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
 submit_bh fs/buffer.c:2819 [inline]
 __sync_dirty_buffer+0x23d/0x390 fs/buffer.c:2857
 exfat_set_volume_dirty+0x5d/0x80 fs/exfat/super.c:124
 exfat_create+0x1aa/0x5a0 fs/exfat/namei.c:554
 lookup_open fs/namei.c:3595 [inline]
 open_last_lookups fs/namei.c:3694 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3930
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1419
 do_sys_open fs/open.c:1434 [inline]
 __do_sys_openat fs/open.c:1450 [inline]
 __se_sys_openat fs/open.c:1445 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1445
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd567e88559
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe5ed3b418 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fd567ed10aa RCX: 00007fd567e88559
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 0023706f6f6c2f76 R09: 00007ffe5ed3b450
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe5ed3b43c
R13: 0000000000000028 R14: 431bde82d7b634db R15: 00007ffe5ed3b470
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
