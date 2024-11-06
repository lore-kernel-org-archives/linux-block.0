Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A218F2DF
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730860825; cv=none; b=W73vDLhf63AIzrnQUwebFG3J3zsKZp6TYQ3S7F0oq/e6oKLxjmma6Ie/zkIhqZcq9f6RZ9JlWExU4llngASxIsYw+lhy5sly5x3HDvoxbg6pmuv777w97RrC1d8YlHZZR+31BHWOMVpq9Q/wJMOkW4/E/ACirh54Hk2nfqRMWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730860825; c=relaxed/simple;
	bh=u71oxFQ0BbNcjNqYXJyzZwn5VrBKxOKp/CHnzvq6jTU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OHCZ/PtvZnOtvGybzTbxYYYQKhWZVamN9Dm/BM8yn6V5vjPdo3beUUMbNtiF7RnRI2sXPk+BQprdyDJ5QV2Q1MNCmbnGFOkIt/cvd4T6DY6AT/LZF5iMXPoyBBwPITMLtLeMTlOCiJ+/1T+cXNxcpmVDGuGrm9+JkXYLKK4SL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4f32b0007so61441855ab.1
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2024 18:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730860822; x=1731465622;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRRYYW8+CJ0RgBbu2SCSYRPh5rC9lLWQJnEO13Krag8=;
        b=cRA+FAmHAOadJehpYURv9V7D+tWttwX7hb20ckCbBzKSa1C7FR91HJfRqzw7+/Fr4j
         OJ0bRFDIqUwMjPMvVMpX3/B8nlzOqedD8wCvElspjSGezV9WdDPnTo2omcNWIM4EizQB
         SSgh/G2QH6MJFyUfU0Pv+IO5kEMF/e8OGIFkGVca3mkBdTWaJCADAMuc6sGoa+D1O7/X
         Vvpg8BXpmGJQpxSP63WTgULMDuDazQT8TRknG6JANZVsf3bLRnrq48cE0L2bcmOZjkFI
         UEpV6AxPTxvqY0i9jAWdK/d4YgdKo+RfkFsvjoOZBt1K2dLKsfMVsJw9sF+YLi0GFcJj
         eEdA==
X-Forwarded-Encrypted: i=1; AJvYcCVDfCTt1rWcwdtp14pO0QNW1X8rKs2WvaBc/eIf6ouaTvG8NLelgvLA/9wcDjYPYbGmTbxbeYXP7a0x1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzb5ETdEbo0T5Auy7l7cipAguX3ge3hbE914k++Zlnr6RwJCNg
	fdyKUCa5pHWjAT2dpWhTCrG0EtA3TpsYVOMvewPSiR2NYiB63/0/6NWFPbWLkF+KH6nYBcQgCLm
	44vdXXAocbWLCTldXq7+fD8/cTcwgsCxwGdyOiKkMNnEj7ajhzV1aHuo=
X-Google-Smtp-Source: AGHT+IGoaGtRwgzj5aT4wlsWrWFRqru+tH6uN0IGYzSwWwjxvn3rUPwBmc3Xf6YkOjRCuBfpA/6XrZGbol6W3svWHCNDM6sh6+fa
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3287:b0:3a6:c43d:1325 with SMTP id
 e9e14a558f8ab-3a6c43d1556mr129046755ab.8.1730860822543; Tue, 05 Nov 2024
 18:40:22 -0800 (PST)
Date: Tue, 05 Nov 2024 18:40:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ad716.050a0220.2a847.1a9e.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_mq_alloc_request
From: syzbot <syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e59aa7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=ca7d7c797fee31d2b474
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1250b630580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/760a8c88d0c3/disk-c88416ba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46e4b0a851a2/vmlinux-c88416ba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/428e2c784b75/bzImage-c88416ba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.12.0-rc5-next-20241101-syzkaller #0 Not tainted
--------------------------------------------
udevd/6086 is trying to acquire lock:
ffff8880288261c0 (&q->q_usage_counter(queue)#67){++++}-{0:0}, at: blk_mq_alloc_request+0x26b/0xab0 block/blk-mq.c:626

but task is already holding lock:
ffff8880288261c0 (&q->q_usage_counter(queue)#67){++++}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
ffff8880288261c0 (&q->q_usage_counter(queue)#67){++++}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&q->q_usage_counter(queue)#67);
  lock(&q->q_usage_counter(queue)#67);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by udevd/6086:
 #0: ffff888034a534c8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf0/0xc50 block/bdev.c:904
 #1: ffff888028826188 (&q->q_usage_counter(io)#81){+.+.}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
 #1: ffff888028826188 (&q->q_usage_counter(io)#81){+.+.}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187
 #2: ffff8880288261c0 (&q->q_usage_counter(queue)#67){++++}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
 #2: ffff8880288261c0 (&q->q_usage_counter(queue)#67){++++}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187

stack backtrace:
CPU: 0 UID: 0 PID: 6086 Comm: udevd Not tainted 6.12.0-rc5-next-20241101-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 blk_queue_enter+0xe1/0x600 block/blk-core.c:328
 blk_mq_alloc_request+0x26b/0xab0 block/blk-mq.c:626
 scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
 scsi_execute_cmd+0x177/0x1090 drivers/scsi/scsi_lib.c:304
 ioctl_internal_command+0x16a/0x7f0 drivers/scsi/scsi_ioctl.c:79
 scsi_set_medium_removal+0x15a/0x340 drivers/scsi/scsi_ioctl.c:139
 sd_open+0x43c/0x610 drivers/scsi/sd.c:1564
 blkdev_get_whole+0x8e/0x450 block/bdev.c:689
 bdev_open+0x2d4/0xc50 block/bdev.c:916
 blkdev_open+0x389/0x4f0 block/fops.c:627
 do_dentry_open+0xbe1/0x1b70 fs/open.c:962
 vfs_open+0x3e/0x330 fs/open.c:1092
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1419
 do_sys_open fs/open.c:1434 [inline]
 __do_sys_openat fs/open.c:1450 [inline]
 __se_sys_openat fs/open.c:1445 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1445
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f21713169a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffec20c7d50 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00005559ea473800 RCX: 00007f21713169a4
RDX: 00000000000a0800 RSI: 00005559ea474730 RDI: 00000000ffffff9c
RBP: 00005559ea474730 R08: 0000000000000006 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 00005559ea468070 R14: 0000000000000001 R15: 00005559ea457910
 </TASK>
udevd[6086]: inotify_add_watch(7, /dev/sde, 10) failed: No such file or directory
sd 6:0:0:1: [sde] Test Unit Ready failed: Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
udevd[6086]: inotify_add_watch(7, /dev/sde, 10) failed: No such file or directory
udevd[6086]: inotify_add_watch(7, /dev/sdd, 10) failed: No such file or directory


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
