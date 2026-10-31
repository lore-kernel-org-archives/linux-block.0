Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793489435;
	b=cEe3eMw5Q1MAwACi6R5PaSWhMKya0cOJNVT9cF8hxgJHlTaz8lYcK5plIreAyUF2WgGv
	 G61QrlUQaMogYNfCIXwxTv/kN/BEBFSklNYZpMnOuNEurLXUWiCiroeoS1rhEtOFYGkmO
	 9yLU+/L5JhPh+Zc7ka3XEVEUiqX6y8ov8ANhIoWdyjsIp6SaTNpqT24dFI3RyJlxK55py
	 hZ/blvSXAB7ltYNCS65xXjnB8nI9pzpc1S+ywGdtpeFRjrYRqd7OXh/0ctruuoXKuzPJx
	 Ch7viqSqy8itZ4S7QHsK5qUk4RBfXZDO+rsKeEkisUNkUEdlqnFbvvU19mxS+V94OFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793489435;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=bMXdYf40lKlc5rUWt1QwX7vhQRVSzRHCuoOLZErOiyE=;
	b=fz4nDVQCjXPdxcSdouUPkcZ32fns2NbnZ6SgobehsVHN4uk6hiPtEEaBDZCMX78aJhyR
	 961QLyf82FbqoUdvXTrLr1LhMwillkJXRK3zUBU1D8u9Nx6LPHlNrZutiT9THlgcutvQM
	 HTaqDd8rXroYlD4ayUaBShz8FZVH2ZP72uDpa+vsfckeBBCP4uHHQ8vpJILZt4kqcbqfe
	 OReJKkokCkr4OCVppqCcFehmlRjIUZTuNy85MVq4HEB3Ne43kzk1Lv1KlidDng1eGEcQ7
	 n+T+xDzRkFyzJV3aF3QA7opd1uL69e6QbD0zwH4wdGdNlqi5gaJNen6+tGZrhEQ4kkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.161.70
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1776606A31A
	for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 23:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1776606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-70b8894d6c1so2585405eaf.0
        for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 16:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793489434; x=1794094234;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMXdYf40lKlc5rUWt1QwX7vhQRVSzRHCuoOLZErOiyE=;
        b=l+b8tqBLccNNHvoNQoqsDn9WEXexF1OMLPqiE/h+BCpkrhEFj3RBvjm7qPbdRFP6pb
         Upqg7Bp3JBOKvh7VQAxQoJyMPcWXWstbjVQT6udf2jpfb3nAOmuI+e6r5z8JQEAtlt8Y
         o48drI55/SELNoOhC5GN5q2niQ4UxdvUshYDba03rhRhm5UxuNEgax0yI1bgIVv15gY1
         NRQaCUa4cWFDG0Z2ATVAiiYC0lHyOvRW3SuhhU+TQGx9AzYr/04Valqs+FYIBoBZ3d5I
         j5wTgPTLfn8D/W4Nrue2ZwH6Y6PvDNyYIbOKgWpejLp84++q7Lj1IHM4JvyU7d94PHTP
         MXdA==
X-Forwarded-Encrypted: i=1; AKwUvBzMcbNz6mjVmOp0kmVGBU8gYF6lvRwRjUwGbQG0pmYCJmBjmQFaRbtTPpKG/tmkkWe12pd+hhSS1GcAmg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKCtDbDJzxWqFBNuKnpUczVP2U3KEE2NrvLhdz/epnyOtFjHWbN
	ciSWzHeimV00lQY/Ofz0x6dP+E/hxHEN7lctwH7t43by+kLpTexA8UcEg6Pru5E2FpHmhavIIQ/
	ei4s0u9v6Yv1PmakJs2SxjajwFXvV4E9M7PUlZbT8VMfRL9BVHXLTdeumACk=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6820:180e:b0:6dc:8f59:6b97 with SMTP id
 006d021491bc7-714ddf5d4dcmr4934191eaf.38.1793489433943; Sat, 31 Oct 2026
 16:30:33 -0700 (PDT)
Date: Sat, 31 Oct 2026 16:30:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae67a19.6552420f.2a0efc.001e.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in wbt_init_enable_default
From: syzbot <syzbot+e2e1def00b1be94f0a22@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    151a134a4e6e Add linux-next specific files for 20261027
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16cfed21580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f530fbb08d65d27a
dashboard link: https://syzkaller.appspot.com/bug?extid=e2e1def00b1be94f0a22
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1d27f58c2b6/disk-151a134a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2670074ce19/vmlinux-151a134a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1588f5d40496/bzImage-151a134a.xz

AI-generated root cause summary:
A race between disk registration in dm_setup_md_queue() and concurrent device
removal (dm_destroy() -> blk_mark_disk_dead()) causes the queue freeze lockdep
state tracking in block/blk-mq.c and block/blk.h to become inconsistent.
Although rq_qos_add() freezes and subsequently unfreezes the queue during
wbt_init_enable_default(), blk_unfreeze_release_lock() skips releasing
q->io_lockdep_map because the disk was concurrently marked dead/dying. When
wbt_init_enable_default() immediately proceeds to acquire q->debugfs_mutex,
lockdep detects an apparent circular locking dependency against the leaked
lockdep map. In production kernels without CONFIG_LOCKDEP, the queue is properly
unfrozen and no deadlock or memory corruption occurs.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=e2e1def00b1be94f0a22

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2e1def00b1be94f0a22@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L      
------------------------------------------------------
syz.2.182/6581 is trying to acquire lock:
ffff8880288865c8 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_debugfs_lock_nomemsave block/blk.h:800 [inline]
ffff8880288865c8 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_debugfs_lock block/blk.h:814 [inline]
ffff8880288865c8 (&q->debugfs_mutex){+.+.}-{4:4}, at: wbt_init_enable_default+0x146/0x220 block/blk-wbt.c:794

but task is already holding lock:
ffff888028885d80 (&q->q_usage_counter(io)#73){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:953 [inline]
ffff888028885d80 (&q->q_usage_counter(io)#73){++++}-{0:0}, at: rq_qos_add+0x15b/0x370 block/blk-rq-qos.c:341

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(io)#73){++++}-{0:0}:
       blk_alloc_queue+0x544/0x690 block/blk-core.c:505
       __blk_alloc_disk+0xe3/0x1d0 block/genhd.c:1527
       alloc_dev drivers/md/dm.c:2349 [inline]
       dm_create+0x476/0xf70 drivers/md/dm.c:2563
       dev_create+0x1f7/0x400 drivers/md/dm-ioctl.c:977
       ctl_ioctl drivers/md/dm-ioctl.c:2221 [inline]
       dm_ctl_ioctl+0x9ec/0xe10 drivers/md/dm-ioctl.c:2243
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4363 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4377
       might_alloc include/linux/sched/mm.h:316 [inline]
       slab_pre_alloc_hook mm/slub.c:4673 [inline]
       slab_alloc_node mm/slub.c:5011 [inline]
       kmem_cache_alloc_lru_noprof+0x65/0x5f0 mm/slub.c:5066
       __d_alloc+0x37/0x820 fs/dcache.c:1924
       d_alloc+0x4b/0x190 fs/dcache.c:2010
       lookup_one_qstr_excl+0xd8/0x360 fs/namei.c:1806
       __start_dirop fs/namei.c:2920 [inline]
       start_dirop+0x5c/0x90 fs/namei.c:2942
       simple_start_creating+0xcc/0x110 fs/libfs.c:2308
       debugfs_start_creating+0xca/0x1b0 fs/debugfs/inode.c:397
       debugfs_create_dir+0x24/0x350 fs/debugfs/inode.c:575
       regulator_init+0x6c/0x110 drivers/regulator/core.c:6787
       do_one_initcall+0x250/0x870 init/main.c:1419
       do_initcall_level+0x10a/0x1a0 init/main.c:1481
       do_initcalls+0x59/0xa0 init/main.c:1497
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1732
       kernel_init+0x22/0x1d0 init/main.c:1622
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (&sb->s_type->i_mutex_key#3/1){+.+.}-{4:4}:
       down_write_nested+0x98/0x200 kernel/locking/rwsem.c:1757
       inode_lock_nested include/linux/fs.h:1069 [inline]
       __start_dirop fs/namei.c:2918 [inline]
       start_dirop+0x4f/0x90 fs/namei.c:2942
       simple_start_creating+0xcc/0x110 fs/libfs.c:2308
       debugfs_start_creating+0xca/0x1b0 fs/debugfs/inode.c:397
       debugfs_create_dir+0x24/0x350 fs/debugfs/inode.c:575
       blk_register_queue+0x189/0x4f0 block/blk-sysfs.c:968
       __add_disk+0x6b8/0xdb0 block/genhd.c:531
       add_disk_fwnode+0x143/0x3a0 block/genhd.c:604
       add_disk include/linux/blkdev.h:801 [inline]
       brd_alloc+0x5a9/0x7c0 drivers/block/brd.c:340
       brd_init+0xc1/0x120 drivers/block/brd.c:420
       do_one_initcall+0x250/0x870 init/main.c:1419
       do_initcall_level+0x10a/0x1a0 init/main.c:1481
       do_initcalls+0x59/0xa0 init/main.c:1497
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1732
       kernel_init+0x22/0x1d0 init/main.c:1622
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&q->debugfs_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       blk_debugfs_lock_nomemsave block/blk.h:800 [inline]
       blk_debugfs_lock block/blk.h:814 [inline]
       wbt_init_enable_default+0x146/0x220 block/blk-wbt.c:794
       blk_register_queue+0x420/0x4f0 block/blk-sysfs.c:995
       __add_disk+0x6b8/0xdb0 block/genhd.c:531
       add_disk_fwnode+0x100/0x3a0 block/genhd.c:600
       add_disk include/linux/blkdev.h:801 [inline]
       dm_setup_md_queue+0x23d/0x4f0 drivers/md/dm.c:2632
       table_load+0x4fd/0x8a0 drivers/md/dm-ioctl.c:1661
       ctl_ioctl drivers/md/dm-ioctl.c:2221 [inline]
       dm_ctl_ioctl+0x9ec/0xe10 drivers/md/dm-ioctl.c:2243
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->debugfs_mutex --> fs_reclaim --> &q->q_usage_counter(io)#73

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#73);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#73);
  lock(&q->debugfs_mutex);

 *** DEADLOCK ***

locks held by syz.2.182/6581: 6, last CPU#0:
 #0: ffff88807ce11190 (&md->type_lock){+.+.}-{4:4}, at: table_load+0x1dd/0x8a0 drivers/md/dm-ioctl.c:1644
 #1: ffff88807ce110e8 (&md->table_devices_lock){+.+.}-{4:4}, at: dm_setup_md_queue+0x20b/0x4f0 drivers/md/dm.c:2631
 #2: ffff888035d3ad78 (&set->update_nr_hwq_lock){.+.+}-{4:4}, at: add_disk_fwnode+0xea/0x3a0 block/genhd.c:599
 #3: ffff888028886330 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_register_queue+0x10d/0x4f0 block/blk-sysfs.c:965
 #4: ffff888028885d80 (&q->q_usage_counter(io)#73){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:953 [inline]
 #4: ffff888028885d80 (&q->q_usage_counter(io)#73){++++}-{0:0}, at: rq_qos_add+0x15b/0x370 block/blk-rq-qos.c:341
 #5: ffff888028885db8 (&q->q_usage_counter(queue)#54){+.+.}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:953 [inline]
 #5: ffff888028885db8 (&q->q_usage_counter(queue)#54){+.+.}-{0:0}, at: rq_qos_add+0x15b/0x370 block/blk-rq-qos.c:341

stack backtrace:
CPU: 0 UID: 0 PID: 6581 Comm: syz.2.182 Tainted: G             L       syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
 blk_debugfs_lock_nomemsave block/blk.h:800 [inline]
 blk_debugfs_lock block/blk.h:814 [inline]
 wbt_init_enable_default+0x146/0x220 block/blk-wbt.c:794
 blk_register_queue+0x420/0x4f0 block/blk-sysfs.c:995
 __add_disk+0x6b8/0xdb0 block/genhd.c:531
 add_disk_fwnode+0x100/0x3a0 block/genhd.c:600
 add_disk include/linux/blkdev.h:801 [inline]
 dm_setup_md_queue+0x23d/0x4f0 drivers/md/dm.c:2632
 table_load+0x4fd/0x8a0 drivers/md/dm-ioctl.c:1661
 ctl_ioctl drivers/md/dm-ioctl.c:2221 [inline]
 dm_ctl_ioctl+0x9ec/0xe10 drivers/md/dm-ioctl.c:2243
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f876af9f559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f876be1d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f876b225fa0 RCX: 00007f876af9f559
RDX: 0000200000000380 RSI: 00000000c138fd09 RDI: 0000000000000004
RBP: 00007f876b036b20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f876b226038 R14: 00007f876b225fa0 R15: 00007ffe8962be28
 </TASK>
device-mapper: ioctl: device has been removed from the dev hash table.


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
