Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636CD23535E
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762574489; cv=none; b=QH5Y2jdWlnwIMeFSTwiQeRERv90VpFByypC8HB9DqxrdXaf9widGoO0hLqj1O7+r9riiuh4uUX1v/OfORQue8zax0ghETBspIg+Y6Nrlub1ovZHKNbnaNccaqF+M0UtRTeAxvA3swCxuc8p7a9qe+tJVrXxjBZdFidd+mt9UXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762574489; c=relaxed/simple;
	bh=679CCx0Mjyk8sR0Ed/UiMndqrqMGUzmqQI0hQU3W1K8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WZ0Sa/MMCVTCQvQxRvsJAsQasPzOJN3dY5aqvI0YvEDXanXOGWzGioCPkZe5AoqqMpV2rsDizkUC5T55aH9bpTaubsA6/9nSLzU7LnrgAztEarrzbbnUUYUeIYrNapsNxWZTPpy8opktKkvsMLbZu6EGqWU8GdIo+jkm+YNtapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4333052501cso15708905ab.2
        for <linux-block@vger.kernel.org>; Fri, 07 Nov 2025 20:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762574486; x=1763179286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZayVuwne5RPjgu24eL/vYWkKondkC7H5ToXJVWPy0k=;
        b=rG6O9G8MG/dkxt4f/iMzCjZR4RR8l4fsgDqdsPuh4AOiFI9oiIOr98V2CUc9hp6fGi
         4+dKGEm+PHWpXuxMjnrIOZwJ/IyfAYobMYePfZFCODekg91kVug5xEVZ3JiYH4f611v2
         kwTFTz6OpZG+0VTUiEo7eOu/QvrLfRTiGA+Qvfkk9KK/tUc+ByVvNSoyp+2n9VVGW7f/
         +xrUoumzkP0kZ8sb4VwHH7XcSW1t7wQU7VVYcSsWTrzIY/hsljSpOkkHZnLwcCb2n+QJ
         fynchwE2wc9A0w3XilpCjOQEDtkGCMpGa+ZLuWdslYq5QjSdncGp/hsorvZd2aNbf3VQ
         8hbA==
X-Forwarded-Encrypted: i=1; AJvYcCU1SbfowhfOk4HGHKd8BFzJxxM8QSGDwm5au2PT5Me3sH5q9UdH11ipUFPbwxhYdpYSTvBBJIPU7nKitQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMP1WyCk+khmKn6hkM7caZRmmpU7MCyAmaahjt+JUYU4BrGBJ
	9vGHd+1ZCh1OgtIgOjKPNyTPmi91BlOoTjDE+W4PKQoFxfHTwGNMpq6NWIlm0lD+R4nQpYhmg0I
	oYQHP7OQ6ROmh3uM+Di9I9bYdo48ciIMdxKbU2Wdo5fJ0y+xlvLZ65g7yqzE=
X-Google-Smtp-Source: AGHT+IFu9xP1zhSNlyygRKbceParQpjsVyZQ73lPbVX6pNfjMz2g0BFnN8SiU2TArtPnjOS5YrNN41Nt/3nLMaJLiN9GG25DCMPG
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4d:b0:433:2920:a0fe with SMTP id
 e9e14a558f8ab-43367d29a62mr26460295ab.0.1762574486517; Fri, 07 Nov 2025
 20:01:26 -0800 (PST)
Date: Fri, 07 Nov 2025 20:01:26 -0800
In-Reply-To: <68dea1d7.050a0220.25d7ab.07bc.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ec096.a70a0220.22f260.0070.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
From: syzbot <syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    da32d155f4a8 Merge tag 'gpio-fixes-for-v6.18-rc5' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118faa58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103d4412580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/811f765ca0a8/disk-da32d155.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f6516907c8f/vmlinux-da32d155.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45682ff9dc9c/bzImage-da32d155.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/cb5a9fd06f24/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13312a92580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/d496dd2d1446/mount_6.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1516117c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:170
Read of size 1 at addr ffff888030dcba68 by task ksoftirqd/1/30

CPU: 1 UID: 0 PID: 30 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:580
 kasan_check_byte include/linux/kasan.h:401 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:170
 rtlock_slowlock_locked+0x3821/0x4010 kernel/locking/rtmutex.c:1871
 rtlock_slowlock kernel/locking/rtmutex.c:1895 [inline]
 rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
 __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
 rt_spin_lock+0x158/0x3e0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 __wake_up_common_lock+0x2f/0x1e0 kernel/sched/wait.c:124
 blk_update_request+0x57e/0xe60 block/blk-mq.c:998
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1160
 blk_complete_reqs block/blk-mq.c:1235 [inline]
 blk_done_softirq+0x10a/0x160 block/blk-mq.c:1240
 handle_softirqs+0x22f/0x710 kernel/softirq.c:622
 run_ksoftirqd+0xac/0x210 kernel/softirq.c:1063
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 7682:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x1ef/0x6c0 mm/slub.c:5767
 kmalloc_noprof include/linux/slab.h:957 [inline]
 lbmLogInit fs/jfs/jfs_logmgr.c:1821 [inline]
 lmLogInit+0x3db/0x19e0 fs/jfs/jfs_logmgr.c:1269
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x4e1/0xfa0 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xe9/0x670 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x754/0xd80 fs/jfs/super.c:532
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5925:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6634 [inline]
 kfree+0x197/0x950 mm/slub.c:6841
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1864 [inline]
 lmLogShutdown+0x441/0x830 fs/jfs/jfs_logmgr.c:1683
 lmLogClose+0x28a/0x520 fs/jfs/jfs_logmgr.c:1459
 jfs_umount+0x2ef/0x3c0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888030dcba00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 104 bytes inside of
 freed 256-byte region [ffff888030dcba00, ffff888030dcbb00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x30dca
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ff26b40 ffffea000157d380 dead000000000003
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ff26b40 ffffea000157d380 dead000000000003
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 0080000000000001 ffffea0000c37281 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5919, tgid 5919 (syz-executor), ts 100669428717, free_ts 100657311754
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3055 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3228
 new_slab mm/slub.c:3282 [inline]
 ___slab_alloc+0xb10/0x1400 mm/slub.c:4651
 __slab_alloc+0xc6/0x1f0 mm/slub.c:4774
 __slab_alloc_node mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:5272 [inline]
 __do_kmalloc_node mm/slub.c:5645 [inline]
 __kmalloc_noprof+0x14b/0x7d0 mm/slub.c:5658
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kmalloc_array_noprof include/linux/slab.h:1003 [inline]
 security_inode_init_security+0x107/0x3f0 security/security.c:1868
 __ext4_new_inode+0x3314/0x3cb0 fs/ext4/ialloc.c:1325
 ext4_mkdir+0x3cb/0xc50 fs/ext4/namei.c:3007
 vfs_mkdir+0x306/0x510 fs/namei.c:4453
 do_mkdirat+0x247/0x590 fs/namei.c:4486
 __do_sys_mkdir fs/namei.c:4508 [inline]
 __se_sys_mkdir fs/namei.c:4506 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4506
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 20 tgid 20 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xfb6/0x1140 mm/page_alloc.c:2906
 mm_free_pgd kernel/fork.c:541 [inline]
 __mmdrop+0xb5/0x4f0 kernel/fork.c:683
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core kernel/rcu/tree.c:2861 [inline]
 rcu_cpu_kthread+0xbf6/0x1b50 kernel/rcu/tree.c:2949
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888030dcb900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888030dcb980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888030dcba00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888030dcba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888030dcbb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
