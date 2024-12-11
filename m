Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0917D358
	for <linux-block@vger.kernel.org>; Wed, 11 Dec 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929590; cv=none; b=g9E1/JEmoilwzEZ0KCuyzgqBLJaGKNzYMsLNQpIDbtrQo4diT/TAPbmpdZumxhzoZ7v5YrHW6Zzwmq7542E+CiaiY+dfzevm3ZxKjYaeB6/ygmwvPqaPu/RBwQyqgCxh3zb/D6n2HDP7JtvbkF4vakWlPoWfihpf3H78tIBbFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929590; c=relaxed/simple;
	bh=NmpAnILvPNq7punKvcddVxTnQumBH/NikbGUqjUWn5s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cXjC5uudRZoCZNRJ0kNtSErP0hSaL+PVVKbOJXro/KNj6CtqrU1XrbKdFLjvCwVi/S9/ZtZLzznJudvb2dPSXG4VLSGRGW+eneOQu5d2N0B73BbuZpTrn04robm3W2XJUS5LQGJAVjsdJNsGSyY+45N22Bko/2cxk8fPBimwubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a81684bac0so74869315ab.0
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2024 07:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929587; x=1734534387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gaUYI5cByp4Zmv5bZepzdCSlOzaNF2jEDmYrdIDkh8I=;
        b=OMGFgosfTjEaz6ZNyskhXS/JXiF7RsMJa6D71UrHgs60AjGHWgu0regu31KUB0QX1q
         X3STNSWRgOS+F0CEF0QHrPQTp/XB2R3a0s3gA8RF9YvdU5BrWlnUk8FvJ5xKBb/IN7tG
         iZpdDG4EpftchesfE/jEXSr+GtruLkatp65KPmuuZpAXCVMumi9gVXKVMb13OEgpFHmH
         UL/edKU+iG8ekRtC06hqQYdj4ANj7MTFnLxpAholzSbu2fDmwqlCFkZcDxrrJgyaEu6V
         nIcF3yi+mopWjhGg5LgZTy0s6idFziny8hctB3x5MTyntt8o9BgwFxiEzI2UvYQTbNol
         tmuw==
X-Forwarded-Encrypted: i=1; AJvYcCUg28em113/JqtWLTQnE51zJGySBJLFleIEY6GrZPE/3Or/pLx4ksdvhUDN3EBjyf3F5N+Q/KhE1OP1Iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRy3XGD6O1E+RKAUFUsMMSmd8CF06IPMsVzpKRjfw4gjUpHePe
	hba7yC8iU6ciCp09waY5magCutl7Rvv6xjf3pr1oYl5UHbMBAJjjXzDajhE1QYrvQPB9XZeXjuK
	N95MmmAReJWUbKaiDWeOrmPOSo4Xft7kJqMBw4FmWYAN3Xhwk3tkAJck=
X-Google-Smtp-Source: AGHT+IEjH6VSzXlnjeSu+dr+sBDBIEJkj9URlE5L/m2GKVJLQiv3ouC6AVx0QoX7z7c+89xds2vD+fAbcdSw17avYjcNdXLHM3WG
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:3a7:87f2:b013 with SMTP id
 e9e14a558f8ab-3ac2c1002d1mr641345ab.4.1733929586943; Wed, 11 Dec 2024
 07:06:26 -0800 (PST)
Date: Wed, 11 Dec 2024 07:06:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759aa72.050a0220.17f54a.003c.GAE@google.com>
Subject: [syzbot] [block?] KASAN: slab-use-after-free Read in update_io_ticks (2)
From: syzbot <syzbot+085c0366f5a7bfd7b82d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7cb1b4663150 Merge tag 'locking_urgent_for_v6.13_rc3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b36b30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=085c0366f5a7bfd7b82d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7cb1b466.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13e083329dab/vmlinux-7cb1b466.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe3847d08513/bzImage-7cb1b466.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+085c0366f5a7bfd7b82d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in update_io_ticks+0xa6/0x2d0 block/blk-core.c:1011
Read of size 8 at addr ffff888031e4dc28 by task kworker/u4:0/11

CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: loop0 loop_workfn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 update_io_ticks+0xa6/0x2d0 block/blk-core.c:1011
 blk_account_io_done+0x199/0x740 block/blk-mq.c:1047
 __blk_mq_end_request_acct block/blk-mq.c:1121 [inline]
 __blk_mq_end_request+0x270/0x5d0 block/blk-mq.c:1127
 loop_handle_cmd drivers/block/loop.c:1926 [inline]
 loop_process_work+0x1bc8/0x21c0 drivers/block/loop.c:1944
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5314:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_lru_noprof+0x1dd/0x390 mm/slub.c:4172
 bdev_alloc_inode+0x29/0x90 block/bdev.c:323
 alloc_inode+0x65/0x1a0 fs/inode.c:336
 new_inode_pseudo fs/inode.c:1174 [inline]
 new_inode+0x22/0x1d0 fs/inode.c:1193
 bdev_alloc+0x26/0x380 block/bdev.c:420
 add_partition+0x1b6/0x8a0 block/partitions/core.c:326
 blk_add_partition block/partitions/core.c:564 [inline]
 blk_add_partitions block/partitions/core.c:633 [inline]
 bdev_disk_changed+0xb22/0x13f0 block/partitions/core.c:693
 loop_reread_partitions drivers/block/loop.c:534 [inline]
 loop_set_status+0x70c/0x8f0 drivers/block/loop.c:1302
 lo_ioctl+0xcbc/0x1f50
 blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1093:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4700
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 do_softirq+0x11b/0x1e0 kernel/softirq.c:462
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:389
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_nc_purge_paths+0x312/0x3b0 net/batman-adv/network-coding.c:471
 batadv_nc_worker+0x328/0x610 net/batman-adv/network-coding.c:720
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 destroy_inode fs/inode.c:391 [inline]
 evict+0x836/0x9a0 fs/inode.c:827
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 blkdev_release+0x15/0x20 block/fops.c:635
 __fput+0x23c/0xa50 fs/file_table.c:450
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888031e4dc00
 which belongs to the cache bdev_cache of size 2784
The buggy address is located 40 bytes inside of
 freed 2784-byte region [ffff888031e4dc00, ffff888031e4e6e0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x31e48
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888040306f81
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801c2ea3c0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800b000b 00000001f5000000 ffff888040306f81
head: 04fff00000000040 ffff88801c2ea3c0 dead000000000122 0000000000000000
head: 0000000000000000 00000000800b000b 00000001f5000000 ffff888040306f81
head: 04fff00000000003 ffffea0000c79201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 1, tgid 1 (swapper/0), ts 11146018873, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2408
 allocate_slab+0x5a/0x2b0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_lru_noprof+0x26c/0x390 mm/slub.c:4172
 bdev_alloc_inode+0x29/0x90 block/bdev.c:323
 alloc_inode+0x65/0x1a0 fs/inode.c:336
 new_inode_pseudo fs/inode.c:1174 [inline]
 new_inode+0x22/0x1d0 fs/inode.c:1193
 bdev_alloc+0x26/0x380 block/bdev.c:420
 __alloc_disk_node+0x12b/0x580 block/genhd.c:1375
 __blk_mq_alloc_disk+0x244/0x3d0 block/blk-mq.c:4392
 nbd_dev_add+0x50f/0xc60 drivers/block/nbd.c:1871
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888031e4db00: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff888031e4db80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888031e4dc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888031e4dc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888031e4dd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
