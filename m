Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0814690
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753928078; cv=none; b=HKJd9cTTOFTgZ/UpIW/UEtuaSaZSL8xFj6FNt0rmsZjiSX+uiCtGRdMafmXEpzxvo4RAZjodcOIcSHj5MB5fHmI6JKqoFH+xbFKVBA9DDGubnHTt4725Ye1oNcPKnKMZjOvZUtLQz2kr0t2t6HHkm26Abfwi9rq8TLh8KaSnT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753928078; c=relaxed/simple;
	bh=PtdtWbfSwsTFIdvQnjmV9oEGOciY0JSHBJVRlxzGeOw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=anw91LsIuRWD17yZkmA50xCoZFmPK3okDnqjAYimd92kkkWEhzkz5jlJCbDUflO/os9P6NJIvSkx1IavoBuWmmSlGeN2h1HUMxJ/ifiRJYxQX9s12LeYzKNcCpwtIYfaEi9BjTsaaNGdMjWd2RJ6n4A9wxVlXfwyb875Dv4+VV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e3d310b012so6976665ab.3
        for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 19:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753928076; x=1754532876;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8LN82KfcOn/0r6hArwrNITctrGhPFAps37niPBX6GA=;
        b=AEeX1PYi8DWlME/BEHFEPSWzWd6EGM908auZPHux+HEEUTEzoq3pom+759sh4MNcIq
         VtRhtvm5WIufI5hbWAakG2bIzl0u9LKuZ6RfYTD2+fzlbMrC44a0Wvfy/jeOX2WUogZp
         4mg30cKjQyXMT49JyY0D366X9X7kEY6kbgTZYNX7d7dygyxvJUbxhlI5XcQvWJH1p/Rc
         5TFBrVk3lTGJQVfwHgWGzUh9BI08Gu8bvnwp42pCMI9YOxQKBpeJbA2zju3iDofhf15m
         rirTvAshDq0U4Zm/NVHZrywd2H2SNUwiP/P23yW0Mqg2iDqtOc1kAZ/8PP1hUcByK3Sr
         a/8w==
X-Forwarded-Encrypted: i=1; AJvYcCWRv4gnSgK6v6WydHTX16ZJQsGavCrWzDp3IP1iQJLczIwcckzgKscNWoGABnXWW8np6RsGTk93ozrxvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAkSSjFqxLMjBAc35QY7/GdrPF03CMwThs+m26k4waXUH4TEP
	YErNeemV/uXOhtFWRCgimj6Ekb3EL4N5BmbNFTHpTk6Jae1uaZSquWLmiD2Li4R5nNxIfzntpBa
	C7fxyeE+zAhslngROGkgTUYzWXXN94lGvW0cztCN7VFVtURhXyVCR5fExQEg=
X-Google-Smtp-Source: AGHT+IHfrW2I3iy1zEHBpfBt4MEcIOr/sBXoPNGPZ2JnNw0WXqO2uRZnlQ8KRmGFbMrhmROW1fej4/pTLXAokJGKAHH8c7+l9/5b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9e:b0:3dd:b808:be68 with SMTP id
 e9e14a558f8ab-3e3f62800edmr105194965ab.16.1753928075702; Wed, 30 Jul 2025
 19:14:35 -0700 (PDT)
Date: Wed, 30 Jul 2025 19:14:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688ad18b.a00a0220.26d0e1.0033.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in del_gendisk (2)
From: syzbot <syzbot+aea0dfef449ccf91636b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    302f88ff3584 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152528a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27aea6dad68e0c0c
dashboard link: https://syzkaller.appspot.com/bug?extid=aea0dfef449ccf91636b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-302f88ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b375ab423051/vmlinux-302f88ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/133b9f21ac36/bzImage-302f88ff.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aea0dfef449ccf91636b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc7-syzkaller-00127-g302f88ff3584 #0 Not tainted
------------------------------------------------------
syz.7.6877/31320 is trying to acquire lock:

but task is already holding lock:
ffff8880417fe368 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0x136/0x1e0 block/genhd.c:822

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&set->update_nr_hwq_lock){++++}-{4:4}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1577
       blk_mq_update_nr_hw_queues+0x32/0xcb0 block/blk-mq.c:5041
       nbd_start_device+0x172/0xcd0 drivers/block/nbd.c:1476
       nbd_start_device_ioctl drivers/block/nbd.c:1527 [inline]
       __nbd_ioctl drivers/block/nbd.c:1602 [inline]
       nbd_ioctl+0x219/0xda0 drivers/block/nbd.c:1642
       compat_blkdev_ioctl+0x2eb/0x7a0 block/ioctl.c:760
       __do_compat_sys_ioctl fs/ioctl.c:1005 [inline]
       __se_compat_sys_ioctl fs/ioctl.c:948 [inline]
       __ia32_compat_sys_ioctl+0x23f/0x370 fs/ioctl.c:948
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&nbd->config_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
       refcount_dec_and_mutex_lock+0x51/0xc0 lib/refcount.c:118
       nbd_config_put+0x31/0x750 drivers/block/nbd.c:1423
       nbd_release+0xb7/0x190 drivers/block/nbd.c:1735
       blkdev_put_whole+0xb0/0xf0 block/bdev.c:721
       bdev_release+0x47e/0x6d0 block/bdev.c:1144
       blkdev_release+0x15/0x20 block/fops.c:684
       __fput+0x402/0xb70 fs/file_table.c:465
       fput_close_sync+0x118/0x260 fs/file_table.c:570
       __do_sys_close fs/open.c:1589 [inline]
       __se_sys_close fs/open.c:1574 [inline]
       __x64_sys_close+0x8b/0x120 fs/open.c:1574
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&disk->open_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
       __del_gendisk+0xf5/0xbd0 block/genhd.c:710
       del_gendisk+0x13e/0x1e0 block/genhd.c:823
       loop_remove drivers/block/loop.c:2083 [inline]
       loop_control_remove drivers/block/loop.c:2142 [inline]
       loop_control_ioctl+0x4f1/0x630 drivers/block/loop.c:2180
       __do_compat_sys_ioctl fs/ioctl.c:1005 [inline]
       __se_compat_sys_ioctl fs/ioctl.c:948 [inline]
       __ia32_compat_sys_ioctl+0x23f/0x370 fs/ioctl.c:948
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

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

1 lock held by syz.7.6877/31320:
 #0: ffff8880417fe368 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0x136/0x1e0 block/genhd.c:822

stack backtrace:
CPU: 0 UID: 0 PID: 31320 Comm: syz.7.6877 Not tainted 6.16.0-rc7-syzkaller-00127-g302f88ff3584 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2046
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:747
 __del_gendisk+0xf5/0xbd0 block/genhd.c:710
 del_gendisk+0x13e/0x1e0 block/genhd.c:823
 loop_remove drivers/block/loop.c:2083 [inline]
 loop_control_remove drivers/block/loop.c:2142 [inline]
 loop_control_ioctl+0x4f1/0x630 drivers/block/loop.c:2180
 __do_compat_sys_ioctl fs/ioctl.c:1005 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:948 [inline]
 __ia32_compat_sys_ioctl+0x23f/0x370 fs/ioctl.c:948
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf70be579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 0000000000004c81
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
