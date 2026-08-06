Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08243EE1F2
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004609; cv=none; b=NWe4yORDtwWlMRIRR1i3SltPRd1knxEWD1lUkdDZT1nIcroTeiINq7xKkX4sid519uXwLf+2d9l5WtVF/pobz+bejPXIKRJQQBzfRpeZ12QE/B4HyQXeLM0qeN43MNUkdT2Iw2auG9YNLFP3mAdMAgwC7NfTaZ2R//Uq4i5xUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004609; c=relaxed/simple;
	bh=UO+o/95epXEW/Av3Ob3eDNhBrn8sus0iRXBFpH2iPlA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=twaMFGtVjjpFhscqxO3Wf5PwIRCx3teBU/hadLcW4SOFAVS67VZZk3XEOtzQfK4zM+hvGcdDNTLVeenfhoteHMaPmVZ3IaWZdEC11XcljlWe1b7PnKgrBw28XE5RGe9+z0FV77xdASDWsWdA6Dej6AZ413sCjcnimezdXDLNH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6a196857c7aso2067204eaf.2
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 01:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004607; x=1786609407;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G5QgnN1c3jhVM8B0M3msjTGTt0Ije+vyz+04BR9YD9E=;
        b=oosFDf2Mpu3m6mBdITq67XvCZFl+hK8yUiueaDINzDMz4fTWZ7c3SdmnMldgB8AMdN
         fVfAYIiuZ94xULE1AWLkNh9ap6K0VWc4kiz64J21aoGWzYRbB4F7UW6nCwxddULJabsu
         tFbANlKZh9H0UC2GfDuvRFK2Bj0e79LNhZiOf+MAnlPy8e9+vW+hxCnEE6SJHaJ0SGFl
         5kKaa+lTnsY7Z1QLnm15ELMW8Ip02sSgwQmqOaP6mNidgTvElOyUCRZvrQtwVkCGR1cL
         MwITU3ruQ26KK3YqQBDY9Oo9GHiqYRdFLBb1K3cnKMzhCTPofxlLVAcLuHWWThT//+tC
         cHrg==
X-Forwarded-Encrypted: i=1; AHgh+RoO+diNDj1snrwBl+PlEB0ImBg12/29kNduHCdB3cmUkU8NE3Iz43meph+zUSPpTVRzuO9K96PzvdSATQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ2YNMQAS1X4XN+t8D6z5w/8NSo4ErKxyZ03hceacNT5mQvF1P
	e5dmbNMD9TC9jpXbiCsLWSm63D+ETNUgpixSnoohwOTPBy67IK3tPKdbR+H7jnpmp1cENZpHDeh
	7N4PqrBQvPEHxNbMpvlNuNOk1mGBNehskOMZFMZrczN5uBDCq+a7ePvxsGjA=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b07:b0:6a3:7a25:c09b with SMTP id
 006d021491bc7-6ae96ef02c6mr7118674eaf.20.1786004606747; Thu, 06 Aug 2026
 01:23:26 -0700 (PDT)
Date: Thu, 06 Aug 2026 01:23:26 -0700
In-Reply-To: <69ea5ab9.a00a0220.17a17.0046.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74447e.9c11d2ce.289b96.0098.GAE@google.com>
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in blk_mq_free_rqs
From: syzbot <syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13aa729e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cde12eeb298bab70
dashboard link: https://syzkaller.appspot.com/bug?extid=e90526cab23b9efcd03c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a58e49580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc11fd08a0
R13: 00007ffc11fd08c0 R14: 0000000000000007 R15: 00007ffc11fd08e0
 </TASK>
block nbd7: shutting down sockets
==================================================================
BUG: KASAN: slab-out-of-bounds in blk_mq_free_rqs+0xde/0x680 block/blk-mq.c:-1
Read of size 8 at addr ffff888026385588 by task syz-executor425/5940

CPU: 0 UID: 0 PID: 5940 Comm: syz-executor425 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 blk_mq_free_rqs+0xde/0x680 block/blk-mq.c:-1
 blk_mq_free_map_and_rqs+0x40/0xf0 block/blk-mq.c:4148
 blk_mq_free_sched_tags block/blk-mq-sched.c:425 [inline]
 blk_mq_free_sched_res+0xeb/0x280 block/blk-mq-sched.c:436
 elevator_change_done+0x1d2/0x5c0 block/elevator.c:639
 elevator_change+0x34f/0x480 block/elevator.c:685
 elv_iosched_store+0x504/0x630 block/elevator.c:826
 queue_attr_store+0x207/0x2b0 block/blk-sysfs.c:906
 kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3427ac2437
Code: 48 89 fa 4c 89 df e8 88 15 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffc11fd0710 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000555594bc4400 RCX: 00007f3427ac2437
RDX: 0000000000000004 RSI: 00007f3427afdc5b RDI: 0000000000000007
RBP: 0000000000000007 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007f3427afdc5b
R13: 00007ffc11fd08c0 R14: 0000000000000007 R15: 00007ffc11fd08e0
 </TASK>

Allocated by task 1:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_node_noprof+0x584/0x7d0 mm/slub.c:5346
 _kmalloc_array_node_noprof include/linux/slab.h:1294 [inline]
 blk_mq_alloc_tag_set+0x533/0x1000 block/blk-mq.c:4894
 nbd_dev_add+0x30e/0xb60 drivers/block/nbd.c:1970
 nbd_init+0x15f/0x1e0 drivers/block/nbd.c:2729
 do_one_initcall+0x250/0x870 init/main.c:1347
 do_initcall_level+0x10a/0x1a0 init/main.c:1409
 do_initcalls+0x59/0xa0 init/main.c:1425
 kernel_init_freeable+0x29d/0x3e0 init/main.c:1658
 kernel_init+0x1d/0x1d0 init/main.c:1548
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888026385580
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 8-byte region [ffff888026385580, ffff888026385588)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888026385f80 pfn:0x26385
flags: 0x80000000000200(workingset|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000200 ffff88801a017500 ffffea0000972d90 ffffea0000a02cd0
raw: ffff888026385f80 0000000800800075 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2c00(GFP_NOIO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 7259242334, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x262a/0x26a0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3380
 new_slab mm/slub.c:3426 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x330/0x690 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_node_track_caller_noprof+0x62d/0x7c0 mm/slub.c:5471
 __kmemdup_nul mm/util.c:64 [inline]
 kstrdup+0x42/0x100 mm/util.c:84
 kobject_set_name_vargs+0x61/0x110 lib/kobject.c:274
 device_create_groups_vargs drivers/base/core.c:4450 [inline]
 device_create+0x23d/0x300 drivers/base/core.c:4493
 bdi_register_va+0x9c/0x7d0 mm/backing-dev.c:1099
 bdi_register+0xe2/0x140 mm/backing-dev.c:1131
 __add_disk+0x7da/0xe30 block/genhd.c:529
 add_disk_fwnode+0x100/0x3a0 block/genhd.c:593
 add_disk include/linux/blkdev.h:800 [inline]
 nbd_dev_add+0x733/0xb60 drivers/block/nbd.c:2021
 nbd_init+0x15f/0x1e0 drivers/block/nbd.c:2729
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888026385480: fa fc fc fc 07 fc fc fc 05 fc fc fc 05 fc fc fc
 ffff888026385500: 05 fc fc fc 00 fc fc fc fa fc fc fc 00 fc fc fc
>ffff888026385580: 00 fc fc fc 07 fc fc fc 07 fc fc fc 07 fc fc fc
                      ^
 ffff888026385600: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff888026385680: fa fc fc fc 02 fc fc fc 05 fc fc fc 00 fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
