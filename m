Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53C3D9535
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259749; cv=none; b=F7CmPQInAGQC1KR44jqPkoPoeHRU23CA2BKix2+kZ7VtbeNZO/WSKtporcyrz79KOwryTsnjZ2xWESKd0PxGGSlpCwkwOX9gKjfeeDC8dPpJq3JBbF7cq3W1C5hfVUMFJDiZfEGUYBYuPrJYqWl7Q3thh/iHp8mrMGS22UPMqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259749; c=relaxed/simple;
	bh=svUM0Mp+YSR8yTwMicGs3ZmGDvzIZktVo9Q2lXQgO2c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=umZgWulcd4JFzrGrggXmZxuTKODtpiJV3TDSsIJwDMqfEHELd3V4W6Q5ZWbpA8fSBWWWfmaQcXwj1ra82NNwCxweWcKBiNIR92Otpe1nKOVqnZ3hOcXooS5gcOfc/bwvhXNktzPR7HtcfoczzrYfHbN19mphAtR9ZZDrU2FxHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4ab4af22d09so490178b6e.0
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 14:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787259746; x=1787864546;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GB4j5ZzEbHNjh+qE2dE1EgxaCeO9pNVK6hZY0hWhFP8=;
        b=RQsV26qt86LxOWjOgjI3Y9UmGEXbptBGtFwCxz6dAwuIB+7BsdQt2MTyt/gP85ZFp3
         2+iEnIPEYrn4DrchysU9E7rhL6ImoPSdQfXfK6V/BP+Ju22SXyhNnUxYbxcjBYio95Up
         Ll+usnQQi3Xvd1MgUaYJa0mKIgU3LHs1n+k7EFFOOZJK33zbKTRhmB7R40CDJql7SREh
         z3eCj8Rq/moLEgC4GjHkjFEjQk648H8IXUEMxusGBDrqsRSfwUZkz4oCWAjixY3NSeWy
         MCOME8bLkaaQCP9xzkFFZ9KeaXhRtlHduGpgYl+hbgVIQaNlkghSuMbuY0+hKT8/C3ay
         Eb1w==
X-Forwarded-Encrypted: i=1; AHgh+Rr8SjJ8XSvBNuBVE/PuutDTB709+9HeDxknHwuTUmO4Bap/q5Q84JUpf1yCPFZnApqoB0cTRADMfgl+4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQcUolFbAf4mM2eze9HDpighbZrpQ4CGX0Zs9v7/VxYNcSuQh
	FN8IlkTABtmUyD/6GePZjxLenSaKDFeLmi8XX6+fFfLTzlPwGqRhM278l9KfX4io+xSa5Bjcjok
	TUH77iBpsSVjtDmsYMHzXlKM8lcDmcat1CFaem+kMmUSKeV/MmbrBxpmcM78=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1188:b0:4b2:3e72:bab1 with SMTP id
 5614622812f47-4b2ef24f8e1mr1021177b6e.6.1787259746343; Thu, 20 Aug 2026
 14:02:26 -0700 (PDT)
Date: Thu, 20 Aug 2026 14:02:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a876b62.4d75e56a.c9a88.004b.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in ocfs2_read_blocks (2)
From: syzbot <syzbot+b03f9cd50db23adeeb71@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    4477a78374a5 Add linux-next specific files for 20260814
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D129b9949580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9b32a36dd637b06=
f
dashboard link: https://syzkaller.appspot.com/bug?extid=3Db03f9cd50db23adee=
b71
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-=
1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/994c1c8c560e/disk-=
4477a783.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd54543d69ae/vmlinux-=
4477a783.xz
kernel image: https://storage.googleapis.com/syzbot-assets/407cdf8f3fc2/bzI=
mage-4477a783.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+b03f9cd50db23adeeb71@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L    =20
------------------------------------------------------
syz.3.993/9951 is trying to acquire lock:
ffff8880724887d0 (&oi->ip_io_mutex){+.+.}-{4:4}, at: ocfs2_read_blocks+0x1e=
f/0x14d0 fs/ocfs2/buffer_head_io.c:229

but task is already holding lock:
ffff888026afda68 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_upda=
te include/linux/blkdev.h:1101 [inline]
ffff888026afda68 (&q->limits_lock){+.+.}-{4:4}, at: loop_configure+0x787/0x=
dc0 drivers/block/loop.c:1083

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
       ocfs2_read_blocks+0x85e/0x14d0 fs/ocfs2/buffer_head_io.c:324
       ocfs2_read_inode_block_full fs/ocfs2/inode.c:1968 [inline]
       ocfs2_read_inode_block+0xe0/0x190 fs/ocfs2/inode.c:1980
       ocfs2_get_clusters+0x341/0xc00 fs/ocfs2/extent_map.c:625
       ocfs2_extent_map_get_blocks+0x202/0x6a0 fs/ocfs2/extent_map.c:678
       ocfs2_read_virt_blocks+0x283/0x9c0 fs/ocfs2/extent_map.c:1001
       ocfs2_read_dir_block fs/ocfs2/dir.c:522 [inline]
       ocfs2_find_entry_el fs/ocfs2/dir.c:790 [inline]
       ocfs2_find_entry+0x3c3/0x2050 fs/ocfs2/dir.c:1165
       ocfs2_find_files_on_disk+0xe0/0x340 fs/ocfs2/dir.c:2082
       ocfs2_lookup_ino_from_name+0x52/0x100 fs/ocfs2/dir.c:2104
       _ocfs2_get_system_file_inode fs/ocfs2/sysfile.c:133 [inline]
       ocfs2_get_system_file_inode+0x32f/0x810 fs/ocfs2/sysfile.c:110
       ocfs2_init_global_system_inodes+0x318/0x6e0 fs/ocfs2/super.c:461
       ocfs2_initialize_super fs/ocfs2/super.c:2192 [inline]
       ocfs2_fill_super+0x456e/0x6840 fs/ocfs2/super.c:993
       get_tree_bdev_flags+0x430/0x4f0 fs/super.c:1887
       vfs_get_tree+0x92/0x2a0 fs/super.c:1947
       fc_mount fs/namespace.c:1198 [inline]
       do_new_mount_fc fs/namespace.c:3772 [inline]
       do_new_mount+0x319/0xdc0 fs/namespace.c:3848
       do_mount fs/namespace.c:4181 [inline]
       __do_sys_mount fs/namespace.c:4397 [inline]
       __se_sys_mount+0x31d/0x420 fs/namespace.c:4374
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&oi->ip_io_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x15ff/0x2e50 kernel/locking/lockdep.c:5254
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       ocfs2_read_blocks+0x1ef/0x14d0 fs/ocfs2/buffer_head_io.c:229
       ocfs2_read_inode_block_full fs/ocfs2/inode.c:1968 [inline]
       ocfs2_read_inode_block+0xe0/0x190 fs/ocfs2/inode.c:1980
       ocfs2_assign_bh fs/ocfs2/dlmglue.c:2415 [inline]
       ocfs2_inode_lock_full_nested+0x2bb/0x1b30 fs/ocfs2/dlmglue.c:2510
       ocfs2_statfs+0x1ba/0xa70 fs/ocfs2/super.c:1577
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
  &oi->ip_io_mutex --> &q->q_usage_counter(io)#24 --> &q->limits_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->limits_lock);
                               lock(&q->q_usage_counter(io)#24);
                               lock(&q->limits_lock);
  lock(&oi->ip_io_mutex);

 *** DEADLOCK ***

locks held by syz.3.993/9951: 2, last CPU#1:
 #0: ffff888026af3430 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_global_lock_kil=
lable drivers/block/loop.c:119 [inline]
 #0: ffff888026af3430 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_configure+0x35d=
/0xdc0 drivers/block/loop.c:1038
 #1: ffff888026afda68 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start=
_update include/linux/blkdev.h:1101 [inline]
 #1: ffff888026afda68 (&q->limits_lock){+.+.}-{4:4}, at: loop_configure+0x7=
87/0xdc0 drivers/block/loop.c:1083

stack backtrace:
CPU: 1 UID: 0 PID: 9951 Comm: syz.3.993 Tainted: G             L      syzka=
ller #0 PREEMPT(full)=20
Tainted: [L]=3DSOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 07/24/2026
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
 ocfs2_read_blocks+0x1ef/0x14d0 fs/ocfs2/buffer_head_io.c:229
 ocfs2_read_inode_block_full fs/ocfs2/inode.c:1968 [inline]
 ocfs2_read_inode_block+0xe0/0x190 fs/ocfs2/inode.c:1980
 ocfs2_assign_bh fs/ocfs2/dlmglue.c:2415 [inline]
 ocfs2_inode_lock_full_nested+0x2bb/0x1b30 fs/ocfs2/dlmglue.c:2510
 ocfs2_statfs+0x1ba/0xa70 fs/ocfs2/super.c:1577
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
RIP: 0033:0x7f61a979e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f61aa701028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f61a9a26180 RCX: 00007f61a979e0d9
RDX: 0000200000001800 RSI: 0000000000004c0a RDI: 0000000000000005
RBP: 00007f61a9835024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f61a9a26218 R14: 00007f61a9a26180 R15: 00007ffd47e4a038
 </TASK>
loop8: detected capacity change from 0 to 7
Dev loop8: unable to read RDB block 7
 loop8: unable to read partition table
loop8: partition table beyond EOD, truncated
loop_reread_partitions: partition scan of loop8 (=EF=BF=BD=E8=A2=ABx=EF=BF=
=BD^>=EF=BF=BD) failed (rc=3D-5)


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
