Received: from mail-qt1-f206.google.com (mail-qt1-f206.google.com [209.85.160.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B73D994
	for <linux-block@vger.kernel.org>; Mon, 26 May 2025 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748264744; cv=none; b=A8Yjw8qilEGddQmMY8mIzRIF3KevUBdpw9jyJqbIL0t15yTujA6OhuAJkDVkxqKWtvI8Z60PtqyDoni828ENL/hSr+yv1sHcn6And7teTGyAQUSjLsMbp5vK8FT2+dm/DDI0UQnCT2Tn+SIR+GLiuvAS05o4i4ajO2a1bjTPFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748264744; c=relaxed/simple;
	bh=zCcY6cRVvQXJqG00Q04hZ7naRc+dOEBgBzQijIA4Ud4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dOP2dC3U8tjcHoVRE2lzfj2kvj+KHhn3gQoIdH9vJpr8dEAlpdS9ZLuVkJE1XLiu/1C+rphyzJmq14apn6xlTn4VYMD6roe8b9Qh7zt1Nx6nxv9uRoOHn8DQ7KPAVOyQ2FNkUS9t3WR/k2ii72qEERAEeoBTReDTBqzrT1teD2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-qt1-f206.google.com with SMTP id d75a77b69052e-47682f9e7b9so34802911cf.2
        for <linux-block@vger.kernel.org>; Mon, 26 May 2025 06:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748264742; x=1748869542;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tjIeaqhbjUxk08SItdc4sW30n7YS8azipOHS4/dbGg=;
        b=qFafWafpRkOKWYUzBOz5QbrlI6HVXlR4PLEX+pLpsXvJOcOS1GrGEvO5FUIz9czLPN
         ASKSs8ay+GyLwRxcrKL7WuVO62EXZP/BE66KtYj+HSAdIpK89CMnIMuFxqPpT5lWbiBq
         /8iIrPJKm+jusqyesm+sN7NyRtpjbyceKeKB3M3tOV8KzHBrOuBJCQPnVT2D29QKrVLM
         IRR3zy8cLeL1wx64YjrwqcnT0y0CiSVs+Y2Hl4kiK7mGr3cOOCOrDNAfAMPImBHWbr12
         YtzFCbQslsQAAADqh1/Lmm9izkDR1VmTz8Fomhd0kEKXBFrG5ewraN6fWNDmY/zzwuKO
         8ccw==
X-Forwarded-Encrypted: i=1; AJvYcCXIk+FV8bTjZypHWOHMJAbGbmFlAfuGvkv8BDPrCrzcyVqp7Yn339/j7ig5Hv0whbVsJj4lNTDsxrNMQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxySNHU6qQaBOODvLz03sCWzVzns1Khv7OOEIlUcgVuRJTaWze
	5TLZt9Fd4sNlyAV3MDrl5xivwzHFvzNAHJpoHCATVJqDitcWkGE4VDjN1HuYyo/Hmkl4hEXyu4y
	W1Iv+AK1jCNHu+Rh8ELOBl9UeJtJ6gRXQTSjvZq+rw9pyPX4cpRXqmrhmxvE=
X-Google-Smtp-Source: AGHT+IFwhe/7yR6dfKx0iB5eSoM4alWJ8HSB8PkYiw2nhBWt0CjRtDAt2ES1XyarjVttMsOdxXLxZ9tP8FvOP3DIC0pU9g1XHZEP
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4c8e:b0:867:667d:18dd with SMTP id
 ca18e2360f4ac-86cbb7befa4mr802900839f.1.1748264730850; Mon, 26 May 2025
 06:05:30 -0700 (PDT)
Date: Mon, 26 May 2025 06:05:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6834671a.a70a0220.253bc2.0098.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3be1a7a31fbd Add linux-next specific files for 20250526
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1573bad4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ab703e8a19430df
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/33e6b012d232/disk-3be1a7a3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f92328298470/vmlinux-3be1a7a3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5cbdb6f4a5c/bzImage-3be1a7a3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc7-next-20250526-syzkaller #0 Not tainted
------------------------------------------------------
syz.4.1558/11720 is trying to acquire lock:
ffff888142bb3358 (&disk->open_mutex){+.+.}-{4:4}, at: __del_gendisk+0x129/0x9e0 block/genhd.c:706

but task is already holding lock:
ffff888142bb2368 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0xe0/0x160 block/genhd.c:818

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&set->update_nr_hwq_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
       blk_mq_update_nr_hw_queues+0x3b/0x14c0 block/blk-mq.c:5041
       nbd_start_device+0x16c/0xac0 drivers/block/nbd.c:1476
       nbd_genl_connect+0x1250/0x1930 drivers/block/nbd.c:2201
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:727
       ____sys_sendmsg+0x505/0x830 net/socket.c:2566
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
       __sys_sendmsg net/socket.c:2652 [inline]
       __do_sys_sendmsg net/socket.c:2657 [inline]
       __se_sys_sendmsg net/socket.c:2655 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&nbd->config_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
       refcount_dec_and_mutex_lock+0x30/0xa0 lib/refcount.c:118
       nbd_config_put+0x2c/0x790 drivers/block/nbd.c:1423
       nbd_release+0xfe/0x140 drivers/block/nbd.c:1735
       bdev_release+0x536/0x650 block/bdev.c:-1
       blkdev_release+0x15/0x20 block/fops.c:684
       __fput+0x44c/0xa70 fs/file_table.c:467
       fput_close_sync+0x119/0x200 fs/file_table.c:572
       __do_sys_close fs/open.c:1589 [inline]
       __se_sys_close fs/open.c:1574 [inline]
       __x64_sys_close+0x7f/0x110 fs/open.c:1574
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&disk->open_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
       __del_gendisk+0x129/0x9e0 block/genhd.c:706
       del_gendisk+0xe8/0x160 block/genhd.c:819
       loop_remove+0x42/0xc0 drivers/block/loop.c:2081
       loop_control_remove drivers/block/loop.c:2140 [inline]
       loop_control_ioctl+0x4a6/0x590 drivers/block/loop.c:2178
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

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

1 lock held by syz.4.1558/11720:
 #0: ffff888142bb2368 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0xe0/0x160 block/genhd.c:818

stack backtrace:
CPU: 0 UID: 0 PID: 11720 Comm: syz.4.1558 Not tainted 6.15.0-rc7-next-20250526-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
 __del_gendisk+0x129/0x9e0 block/genhd.c:706
 del_gendisk+0xe8/0x160 block/genhd.c:819
 loop_remove+0x42/0xc0 drivers/block/loop.c:2081
 loop_control_remove drivers/block/loop.c:2140 [inline]
 loop_control_ioctl+0x4a6/0x590 drivers/block/loop.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f301358e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f30113f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f30137b5fa0 RCX: 00007f301358e969
RDX: 0000000000000000 RSI: 0000000000004c81 RDI: 0000000000000003
RBP: 00007f3013610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f30137b5fa0 R15: 00007fffe9613fd8
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
