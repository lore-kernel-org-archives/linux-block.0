Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD1C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 01:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C1B61040
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 01:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhJYBho (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 21:37:44 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34488 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhJYBhn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 21:37:43 -0400
Received: by mail-io1-f71.google.com with SMTP id k20-20020a5d97d4000000b005da6f3b7dc7so7895931ios.1
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 18:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HhAh/hspzjXtSqf+AOc9+5I5WBlmVDfYWU4MZkROhuI=;
        b=gj8tlUNm5Ec/SSY7k/zA2fLbeDsWLVPveflVsvcgnh1yNPlS8X9P93YxguiLw2F/fP
         Xo1q052DDe0h+pyGZH97sMF32JlsWh19dq/ctGSvrMPAcFv64oZKtmFt3NeQFJwGOeLU
         0xOLuj1/n0qipn4bEQw6OT5DcpkPWwKWHREDVECOz4Ivkr2oKklyOLBo+H5GiczJ+SDR
         /okTkh9rgd5QYkwPqfqghAgJnW4wAh80WTghGqc+aueOQy1g9Lj/jeJFbgbPaqilhu/Y
         hcjd2llHuS9nJJDzpL2hJ6OmYpWPKtTHWK7H6hGpsACNkFZFQKx/BhXKOUkXgLa2wFWM
         FMlg==
X-Gm-Message-State: AOAM531X5NQbsziPP2efxP+5018Bp4MBZdBDTPIGRig7Y8dgccmr8tuW
        o5bJf2iFFi5vajtlYJ2PPO0rX44FkvU2UgThg5HI8RK4xpDq
X-Google-Smtp-Source: ABdhPJzhz50WKNSJlKHdJcskNEnoMKX58eddpObVG3K9sy37eu75L2WR/8JTHphjzapW1RUK7ZmHrmttYKmm5cmiCJ/URsUH13fe
MIME-Version: 1.0
X-Received: by 2002:a02:7f17:: with SMTP id r23mr3992065jac.47.1635125722143;
 Sun, 24 Oct 2021 18:35:22 -0700 (PDT)
Date:   Sun, 24 Oct 2021 18:35:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4e1e105cf235f15@google.com>
Subject: [syzbot] KASAN: use-after-free Read in blk_mq_sched_tags_teardown
From:   syzbot <syzbot+412ca156285f619b8b62@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, gregkh@linuxfoundation.org, hare@suse.de,
        john.garry@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    51dba6e335ff Add linux-next specific files for 20211020
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10171dc8b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1adca843ed814d57
dashboard link: https://syzkaller.appspot.com/bug?extid=412ca156285f619b8b62
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f768b4b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1295a8c7300000

The issue was bisected to:

commit 645db34e50501aac141713fb47a315e5202ff890
Author: John Garry <john.garry@huawei.com>
Date:   Tue Oct 5 10:23:36 2021 +0000

    blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1597e130b00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1797e130b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1397e130b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+412ca156285f619b8b62@syzkaller.appspotmail.com
Fixes: 645db34e5050 ("blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()")

==================================================================
BUG: KASAN: use-after-free in blk_mq_sched_tags_teardown+0x2a1/0x2d0 block/blk-mq-sched.c:544
Read of size 4 at addr ffff8880760b81e0 by task systemd-udevd/6750

CPU: 1 PID: 6750 Comm: systemd-udevd Not tainted 5.15.0-rc6-next-20211020-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 blk_mq_sched_tags_teardown+0x2a1/0x2d0 block/blk-mq-sched.c:544
 blk_mq_exit_sched+0x21f/0x300 block/blk-mq-sched.c:674
 __elevator_exit+0x28/0x40 block/elevator.c:194
 blk_exit_queue block/blk-sysfs.c:750 [inline]
 blk_release_queue+0x25c/0x490 block/blk-sysfs.c:804
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 disk_release+0x173/0x230 block/genhd.c:1089
 device_release+0x9f/0x240 drivers/base/core.c:2230
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3501
 blkdev_close+0x6a/0x80 block/fops.c:448
 __fput+0x286/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc7c26c8270
Code: 73 01 c3 48 8b 0d 38 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 59 c1 20 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
RSP: 002b:00007ffd26f73c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007fc7c26c8270
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007fc7c3582710 R08: 000055da33920730 R09: 000055da33905200
R10: 00007fc7c35828c0 R11: 0000000000000246 R12: 0000000000000000
R13: 000055da3392ecc0 R14: 0000000000000003 R15: 000000000000000e
 </TASK>

Allocated by task 2936:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:595 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 scsi_host_alloc+0x2c/0x1120 drivers/scsi/hosts.c:382
 usb_stor_probe1+0x45/0x162b drivers/usb/storage/usb.c:952
 alauda_probe+0x89/0x1d0 drivers/usb/storage/alauda.c:1234
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3394
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3394
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2563
 hub_port_connect drivers/usb/core/hub.c:5348 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5716
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 6750:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1726
 slab_free mm/slub.c:3491 [inline]
 kfree+0xf6/0x560 mm/slub.c:4539
 device_release+0x9f/0x240 drivers/base/core.c:2230
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3501
 device_release+0x9f/0x240 drivers/base/core.c:2230
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3501
 scsi_device_dev_release_usercontext+0x97e/0xdd0 drivers/scsi/scsi_sysfs.c:502
 execute_in_process_context+0x37/0x150 kernel/workqueue.c:3358
 device_release+0x9f/0x240 drivers/base/core.c:2230
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3501
 scsi_device_put+0x74/0xa0 drivers/scsi/scsi.c:550
 scsi_disk_put drivers/scsi/sd.c:691 [inline]
 sd_release+0x124/0x290 drivers/scsi/sd.c:1507
 blkdev_put_whole block/bdev.c:693 [inline]
 blkdev_put+0x2fb/0x9e0 block/bdev.c:955
 blkdev_close+0x6a/0x80 block/fops.c:448
 __fput+0x286/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xf5/0x120 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1353
 __queue_work+0x5ca/0xf30 kernel/workqueue.c:1519
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1461 [inline]
 __run_timers.part.0+0x49f/0xa20 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558

The buggy address belongs to the object at ffff8880760b8000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 480 bytes inside of
 8192-byte region [ffff8880760b8000, ffff8880760ba000)
The buggy address belongs to the page:
page:ffffea0001d82e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x760b8
head:ffffea0001d82e00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888010c42280
raw: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2936, ts 74318146894, free_ts 74302716229
 prep_new_page mm/page_alloc.c:2416 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4147
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5386
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
 alloc_slab_page mm/slub.c:1770 [inline]
 allocate_slab mm/slub.c:1907 [inline]
 new_slab+0x32d/0x4a0 mm/slub.c:1970
 ___slab_alloc+0x947/0x1040 mm/slub.c:3001
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3088
 slab_alloc_node mm/slub.c:3179 [inline]
 slab_alloc mm/slub.c:3220 [inline]
 __kmalloc+0x303/0x320 mm/slub.c:4397
 kmalloc include/linux/slab.h:595 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 scsi_host_alloc+0x2c/0x1120 drivers/scsi/hosts.c:382
 usb_stor_probe1+0x45/0x162b drivers/usb/storage/usb.c:952
 alauda_probe+0x89/0x1d0 drivers/usb/storage/alauda.c:1234
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1336 [inline]
 free_pcp_prepare+0x373/0x870 mm/page_alloc.c:1387
 free_unref_page_prepare mm/page_alloc.c:3307 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3386
 __unfreeze_partials+0x343/0x360 mm/slub.c:2502
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3212 [inline]
 slab_alloc mm/slub.c:3220 [inline]
 kmem_cache_alloc+0x209/0x390 mm/slub.c:3225
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags+0x9a/0xe0 include/linux/audit.h:323
 user_path_at_empty+0x2b/0x60 fs/namei.c:2800
 do_readlinkat+0xcd/0x2f0 fs/stat.c:443
 __do_sys_readlinkat fs/stat.c:470 [inline]
 __se_sys_readlinkat fs/stat.c:467 [inline]
 __x64_sys_readlinkat+0x93/0xf0 fs/stat.c:467
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff8880760b8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880760b8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880760b8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff8880760b8200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880760b8280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
