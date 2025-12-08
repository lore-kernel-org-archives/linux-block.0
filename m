Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B11E5201
	for <linux-block@vger.kernel.org>; Mon,  8 Dec 2025 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765172968; cv=none; b=uFW9qydW+tR9i3pRoP16J/ZZsjAwUE9F4uAQ5jRBnXJunqhj5jRaQkZCeMItlRTwOrOpt0PC27n4boVwVQ/u548gPAm6mdB0q9dzEf8kAbtlFmFSag1RTmodY5lBsBfYWWjc1TrSlmi6z2jnFXrvvrIg/d2h3DMOjh1sOXeReig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765172968; c=relaxed/simple;
	bh=PRbhkcGOGipGK6PBaX4D2n/fJshIEwqiz174F0/gfGg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gUEceTU4hcLkTS6r3xi6tNI+o2wc2HlTA7kgKMG/pZSwPSpcCHvO3esbhrWDq+/M8hbFcpkeKQ3xK3H1USDjAgOlulhAxvyjUgAPXdffqRno3n086x45khPwzzmfbJoQt7xpObRqWJ/NwrLClXxQ0sb9Do1EBwGL/79YPGl8trI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-657a6c9d45eso2882533eaf.2
        for <linux-block@vger.kernel.org>; Sun, 07 Dec 2025 21:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765172966; x=1765777766;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uB7yrKY0hrTzQqv4ql1IJM/oh+UO8767T9tYsIvqbhg=;
        b=KRQVW/WK76am0kV+UQpQDbx1lEThPC9acmBaMhl49Zta/oRDwVg3JYW04sLkkSJz6d
         8tk05HsRpWhFZKQj83a4EsqL+ymyMdofgctHmPUYEr2oWdTq7s8s5QflORueGROZox+R
         i7xXs3Cq4w/DkDzrcG4Fed4vTO1h+uoZOZmtWbI4vdXmxL4AE97tuVGUHjELBuNxhidJ
         HCn5Ovkjm2KBRlRZjUo8WaNAGNxNkQ3lznJw3sfdFrMM3RRpvaX9EdaONtHFCPNbXuap
         Kc9mZkFKd5vi0NGaPzDk1HZC+ZVQPM2r2JXuLPR9p+zPtFkok6MgGOBSx+dW4WjKr3FX
         TcVA==
X-Forwarded-Encrypted: i=1; AJvYcCXSregBFDtPhrFFFkl3mClc5Si1SGI5kHmiQ5G3TxXAeNHi/INKqYohoEvHZUBukvUtalPWfB8GaPXmnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mRA2PN7BgKWQ30aFbDc7FyaGE+GJ9K+4KlxYviewbMfBShC7
	maNoUZkJQYbPypVwLRYRZNP72dJv3FHcDT4JXsBR+r/mQ1UJxzDEftQgUkrycy+zzdFry6MsAvr
	Sr/ESexvU5py0UGWDG2cuEPjVdEQw7JSqFCyc7I7yDpn9Y+glMRkp4mkD7Bw=
X-Google-Smtp-Source: AGHT+IHQ45xuP3AwiYRibMszyzHO1B9QqK8pW8h1Js/AX13skjyS+rNBBYwz62sPf6CSstIHjYRxvKaR9NZFekruHZ5dbO2tbtSt
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:811:b0:659:9a49:90c5 with SMTP id
 006d021491bc7-6599a977508mr2915965eaf.68.1765172966181; Sun, 07 Dec 2025
 21:49:26 -0800 (PST)
Date: Sun, 07 Dec 2025 21:49:26 -0800
In-Reply-To: <67256f23.050a0220.35b515.017e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693666e6.a70a0220.38f243.0088.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in blk_update_request
From: syzbot <syzbot+1d38eedcb25a3b5686a7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ba65a4e7120a Merge tag 'clk-for-linus' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c6aeb4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8750900a7c493a0b
dashboard link: https://syzkaller.appspot.com/bug?extid=1d38eedcb25a3b5686a7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1584321a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0a7549a1a1ed/disk-ba65a4e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e00dd3537134/vmlinux-ba65a4e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/30616aa8fe95/bzImage-ba65a4e7.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/9cdaa4551a87/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10570a1a580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/cf44fc97da6f/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d38eedcb25a3b5686a7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in rt_spin_lock+0x88/0x3e0 kernel/locking/spinlock_rt.c:56
Read of size 1 at addr ffff88802d4f0ca8 by task ksoftirqd/0/15

CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:573
 kasan_check_byte include/linux/kasan.h:401 [inline]
 lock_acquire+0x84/0x340 kernel/locking/lockdep.c:5842
 rt_spin_lock+0x88/0x3e0 kernel/locking/spinlock_rt.c:56
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 __wake_up_common_lock+0x2f/0x1e0 kernel/sched/wait.c:124
 blk_update_request+0x57e/0xe60 block/blk-mq.c:1006
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1168
 blk_complete_reqs block/blk-mq.c:1243 [inline]
 blk_done_softirq+0x10a/0x160 block/blk-mq.c:1248
 handle_softirqs+0x226/0x6d0 kernel/softirq.c:622
 run_ksoftirqd+0xac/0x210 kernel/softirq.c:1063
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 6143:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x1fb/0x6d0 mm/slub.c:5771
 kmalloc_noprof include/linux/slab.h:957 [inline]
 lbmLogInit fs/jfs/jfs_logmgr.c:1821 [inline]
 lmLogInit+0x3d0/0x19e0 fs/jfs/jfs_logmgr.c:1269
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x4e1/0xfa0 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xe9/0x670 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x754/0xd80 fs/jfs/super.c:532
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2a0 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3712
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6143:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6663 [inline]
 kfree+0x1bd/0x900 mm/slub.c:6871
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1864 [inline]
 lmLogInit+0x1137/0x19e0 fs/jfs/jfs_logmgr.c:1415
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x4e1/0xfa0 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xe9/0x670 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x754/0xd80 fs/jfs/super.c:532
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2a0 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3712
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802d4f0c00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 168 bytes inside of
 freed 256-byte region [ffff88802d4f0c00, ffff88802d4f0d00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2d4f0
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ff26b40 ffffea00009c2900 dead000000000004
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ff26b40 ffffea00009c2900 dead000000000004
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 0080000000000001 ffffea0000b53c01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 16081569570, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xb10/0x1400 mm/slub.c:4651
 __slab_alloc+0xc6/0x1f0 mm/slub.c:4774
 __slab_alloc_node mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:5246 [inline]
 __do_kmalloc_node mm/slub.c:5651 [inline]
 __kvmalloc_node_noprof+0x327/0x940 mm/slub.c:7129
 v4l2_ctrl_new+0x9d5/0x1790 drivers/media/v4l2-core/v4l2-ctrls-core.c:2112
 v4l2_ctrl_new_std+0x24d/0x2f0 drivers/media/v4l2-core/v4l2-ctrls-core.c:2266
 handler_new_ref+0x153/0x9c0 drivers/media/v4l2-core/v4l2-ctrls-core.c:1853
 v4l2_ctrl_add_handler+0x19f/0x290 drivers/media/v4l2-core/v4l2-ctrls-core.c:2416
 vivid_create_controls+0x2f57/0x3a60 drivers/media/test-drivers/vivid/vivid-ctrls.c:2051
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1933 [inline]
 vivid_probe+0x41b5/0x7150 drivers/media/test-drivers/vivid/vivid-core.c:2095
 platform_probe+0xf9/0x190 drivers/base/platform.c:1446
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0xad0 drivers/base/dd.c:659
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802d4f0b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802d4f0c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802d4f0c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88802d4f0d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802d4f0d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
