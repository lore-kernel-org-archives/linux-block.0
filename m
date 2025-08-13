Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11B2F99B4
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115349; cv=none; b=VZ2/egEhEZhNXmGWoQQXX2z2LoTO3RDSi9sPZer4PC3KBT0X07L0V74NmoBNZNp12sdGQGgP0zc4zEx/3UldmP/Zu4/7Z1mfn1cf8DINsbkCZuZ5viO7Sksn084ArO8yuuSCYK7/nrKEEhzQunJyhT9mXzm7xbGFTsycR2y8R3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115349; c=relaxed/simple;
	bh=FAWNJnHpFs04BGWXP2cFHQ3CKFKAb1CSTmcfl/1FK44=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hmfv/abHS0Nk20svZrQ5ganpTJra8vNR19k7THeCMGjhgGgRlmEQOLx0YB46De+Bo3vhqGMxQ82iHJyg7uSUtwVVRvePe1Gkd7A36TrpxhyJWE0vaSdMkunf+F6315WUHYPWr1+V4lrr9s61kZl27xBQ22ABxCSSGEVlTue4kT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-88432da0cfdso49254339f.1
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 13:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755115347; x=1755720147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QNRM1KyLnIG8pcT6H30bEhCq+dJOlyHPpfKCNHwrQE=;
        b=wEwfi/F9K8MkUjz0MHWmRE+q6oY88onnRpjS+mg8KDwn+uEXI0GZEcx9GBCpr5Wu/K
         gVYqwnKuVAcD0FKO8yhAQcf1lQXxqNmEo4zaV05Oq2k2lcFxko8BBP0a0qNIUJkeiZ/A
         xxTjngHbnWNHFgb0ipNceAzmsc7+xvKH9i76ZgBiqNUz0gjnpPC89SHCCRxqyOAZ+PE7
         /1Rq8wiuwHf9YFVAwHAagsUfeToMz7VKszodhAFQIE8Wo3gt1E3VWDPxlNZCegUzjOQv
         a0/LMpsLZeBvSOLsR/+dEN+OkO30ye7Oosc0AWOE5eAEn/ryJXYnw79UvJqAL3r4EHml
         1V7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/fDitHQVfK/eV9YP8cyBA2yNTTNydOyOKKYmuVZiyY4+xUphxE0B/LPKj3ffdMEkJ3lgfIUwRW2EUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVt8gLuBMBzurANV3ETKWflQJ6KqOD7CmVi77iGz2Q+rYON+ie
	G+0VSN1eW6Qbjq5qXezT0MXbsNE49Pf6I/os1RfdyeL8pnsF2lkqKhV9Wq9NPBpXftawsXc46EA
	U/Ru4j35bNvYp+KF/sG2OQZvnAI/8rQY7/WktZEHdV7ChP7T5aduXAGLFnEo=
X-Google-Smtp-Source: AGHT+IEwCzbdLGuT3itGlKYWRnzUmuuDF7DP0HfniJteADae+M7HM5sdGQvnTR8yfp8HehT39PmXOW+JYv8FCSQ9z/PxMTnQEoXm
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1553:b0:864:a228:92b4 with SMTP id
 ca18e2360f4ac-8843382d729mr70750539f.7.1755115346828; Wed, 13 Aug 2025
 13:02:26 -0700 (PDT)
Date: Wed, 13 Aug 2025 13:02:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689cef52.050a0220.7f033.015e.GAE@google.com>
Subject: [syzbot] [block?] KASAN: slab-use-after-free Read in update_io_ticks (3)
From: syzbot <syzbot+64b38a1abee64ab9246e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c30a13538d9f Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1044d434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e143c1cd9dadd720
dashboard link: https://syzkaller.appspot.com/bug?extid=64b38a1abee64ab9246e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c30a1353.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8cefa7e1536e/vmlinux-c30a1353.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68b8ee3da77f/bzImage-c30a1353.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64b38a1abee64ab9246e@syzkaller.appspotmail.com

I/O error, dev loop0, sector 2424 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
==================================================================
BUG: KASAN: slab-use-after-free in update_io_ticks+0x9a/0x260 block/blk-core.c:1018
Read of size 8 at addr ffff88803215e7a8 by task kworker/u4:11/3027

CPU: 0 UID: 0 PID: 3027 Comm: kworker/u4:11 Not tainted 6.16.0-syzkaller-12250-gc30a13538d9f #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: loop0 loop_workfn
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 update_io_ticks+0x9a/0x260 block/blk-core.c:1018
 blk_account_io_done+0x19b/0x780 block/blk-mq.c:1055
 __blk_mq_end_request_acct block/blk-mq.c:1129 [inline]
 __blk_mq_end_request+0x2af/0x600 block/blk-mq.c:1135
 lo_rw_aio_complete drivers/block/loop.c:327 [inline]
 lo_rw_aio+0xd75/0xfa0 drivers/block/loop.c:401
 do_req_filebacked drivers/block/loop.c:-1 [inline]
 loop_handle_cmd drivers/block/loop.c:1910 [inline]
 loop_process_work+0x835/0xf90 drivers/block/loop.c:1945
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5362:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_lru_noprof+0x1c6/0x3d0 mm/slub.c:4248
 bdev_alloc_inode+0x29/0x90 block/bdev.c:364
 alloc_inode+0x67/0x1b0 fs/inode.c:346
 new_inode+0x22/0x170 fs/inode.c:1145
 bdev_alloc+0x26/0x380 block/bdev.c:461
 add_partition+0x1c3/0x8e0 block/partitions/core.c:326
 blk_add_partition block/partitions/core.c:564 [inline]
 blk_add_partitions block/partitions/core.c:633 [inline]
 bdev_disk_changed+0xb50/0x14b0 block/partitions/core.c:693
 loop_reread_partitions drivers/block/loop.c:439 [inline]
 loop_set_status+0x85a/0xb40 drivers/block/loop.c:1265
 lo_ioctl+0x9af/0x1d00 drivers/block/loop.c:-1
 blkdev_ioctl+0x5a8/0x6d0 block/ioctl.c:705
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4782
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3123 [inline]
 call_rcu+0x157/0x9c0 kernel/rcu/tree.c:3243
 destroy_inode fs/inode.c:401 [inline]
 evict+0x847/0x9c0 fs/inode.c:834
 device_release+0x99/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 blkdev_release+0x15/0x20 block/fops.c:699
 __fput+0x449/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803215e780
 which belongs to the cache bdev_cache of size 2792
The buggy address is located 40 bytes inside of
 freed 2792-byte region [ffff88803215e780, ffff88803215f268)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x32158
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888052e26701
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801bed7280 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800b000b 00000000f5000000 ffff888052e26701
head: 04fff00000000040 ffff88801bed7280 dead000000000122 0000000000000000
head: 0000000000000000 00000000800b000b 00000000f5000000 ffff888052e26701
head: 04fff00000000003 ffffea0000c85601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 11814848371, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 kmem_cache_alloc_lru_noprof+0x288/0x3d0 mm/slub.c:4248
 bdev_alloc_inode+0x29/0x90 block/bdev.c:364
 alloc_inode+0x67/0x1b0 fs/inode.c:346
 new_inode+0x22/0x170 fs/inode.c:1145
 bdev_alloc+0x26/0x380 block/bdev.c:461
 __alloc_disk_node+0x11c/0x540 block/genhd.c:1464
 __blk_mq_alloc_disk+0x196/0x340 block/blk-mq.c:4451
 nbd_dev_add+0x46c/0xae0 drivers/block/nbd.c:1943
 nbd_init+0x168/0x1f0 drivers/block/nbd.c:2680
 do_one_initcall+0x233/0x820 init/main.c:1269
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803215e680: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff88803215e700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88803215e780: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88803215e800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803215e880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
