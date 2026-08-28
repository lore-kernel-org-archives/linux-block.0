Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB5448B8E
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919168; cv=none; b=HtQd1/fmCUDkW06pwJDPCM15NCYlaprK8ypzAkZpHTlcAwPCv39EEUZVoYaPUG+b+mUtd0TbLlf8yJXUobL9+7sXqfIVwkTdNeAXVtXAMgflpq1q7NXyPInUKtCl6LbcRNABlTEgpeR8cjLCBDywmLmmkpARcSMxP2/LInszBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919168; c=relaxed/simple;
	bh=MsNZv5s/RwAZMU96Mx+TI/sfDCxgGCeCIyBQ2e8WTUs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FxI8ab2trRpPBsyLKp0Yvy0bYDkR88m3WyM85aAbHdDagDs2yrcfBj27BNR+UAl0rdV1vDx9HleNSGtDn/P6xoRE0n00nYDkS+hUxm64yM4tLUSrUgzlHosPr1xPx5TvwHQmPiO1DDsOpX4gH8RGDoeVa4lc31gNYXIi5YegD6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b28d9952a5so1338597b6e.1
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 05:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919145; x=1788523945;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alQ8oeVWc2ZBL/pXzz6CDgP2XPI36xfWhQD0N0kqV/M=;
        b=XBOM73mL8PzR3Q/jM2tONLL+H+/85pSg9T1vNT0ZSD3Z/5FxwrPezQ9EHGpeFDlbzP
         0SRT4iNa9ZjmF5j7QlA6S6eaBQGq+DWEGvZ90CtbbnySsJ8gZrNKUGiqV8Yn5/LZPqtG
         B8ZkP2rJ7rUodZk0PWY6Xtpq5iI8VODxP0vNSn4zGHCh8JrRb1y9t+VTQCw0EYVGJevC
         pCtyez+DvwLtk6d3EvThYMR5325ws46Sr9XTVz+prg3YDa0op7TPYryafBBiWX17Z7pG
         /ySHY4yrKJJNqNBdodw9Y2tQGt/OOToyaGZxkBDAvTUZOanXN69Om+OJCkJ/8v3XwHYC
         73Dw==
X-Gm-Message-State: AFuF++mXXv1cevOrXs3pYYDz8ECqiE7HvRYC/Syaq8d+erFPbLS+1IDv
	4Y8I8n9aC+ndB0Eqx/3gw/V3sXUTcQv6ZYAh6Du72s3uXQH7rBKx74GqAsFUNc16WTRhRpHWkQU
	87o5QGas/w1hvEozW5fDkKP90/gjADoca/gYsr+N5ZQdfeIExleJJTtW8638=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f51:b0:4b3:1a95:4160 with SMTP id
 5614622812f47-4b39830200emr6333465b6e.18.1787919144994; Fri, 28 Aug 2026
 05:12:24 -0700 (PDT)
Date: Fri, 28 Aug 2026 05:12:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a917b28.4d659fcc.734b4.001e.GAE@google.com>
Subject: [syzbot] [trace?] [block?] KASAN: slab-use-after-free Read in blk_log_remap
From: syzbot <syzbot+4dfd96209d744263a972@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1070f625580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=4dfd96209d744263a972
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10608c15580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4dfd96209d744263a972@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in blk_log_remap+0x128/0x150 kernel/trace/blktrace.c:1635
Read of size 8 at addr ffff888046c23000 by task syz-executor875/6044

CPU: 1 UID: 0 PID: 6044 Comm: syz-executor875 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 blk_log_remap+0x128/0x150 kernel/trace/blktrace.c:1635
 print_one_line+0x22f/0x430 kernel/trace/blktrace.c:1757
 print_trace_fmt kernel/trace/trace.c:3071 [inline]
 print_trace_line+0x97d/0x1790 kernel/trace/trace.c:3237
 tracing_read_pipe+0x586/0xd60 kernel/trace/trace.c:5446
 vfs_read+0x1e4/0xb40 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb70f890b9e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007fb70f8201a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fb70f8216c0 RCX: 00007fb70f890b9e
RDX: 0000000000001000 RSI: 00007fb70f820210 RDI: 0000000000000006
RBP: 0000000000000021 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 0000000000000000 R14: 00007ffe57b20df0 R15: 00007ffe57b20ed8
 </TASK>

Allocated by task 5868:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4586 [inline]
 slab_alloc_node mm/slub.c:4919 [inline]
 kmem_cache_alloc_noprof+0x26b/0x6a0 mm/slub.c:4933
 __kernfs_new_node+0xd2/0xa10 fs/kernfs/dir.c:665
 kernfs_new_node+0x117/0x150 fs/kernfs/dir.c:751
 __kernfs_create_file+0x53/0x350 fs/kernfs/file.c:1050
 sysfs_add_file_mode_ns+0x207/0x3c0 fs/sysfs/file.c:316
 create_files fs/sysfs/group.c:82 [inline]
 internal_create_group+0x593/0xfb0 fs/sysfs/group.c:189
 internal_create_groups+0x9d/0x150 fs/sysfs/group.c:229
 device_add_groups drivers/base/core.c:2911 [inline]
 device_add_attrs drivers/base/core.c:2975 [inline]
 device_add+0x71a/0x1970 drivers/base/core.c:3715
 netdev_register_kobject+0x1df/0x410 net/core/net-sysfs.c:2340
 register_netdevice+0x15b6/0x25a0 net/core/dev.c:11503
 xfrmi_create net/xfrm/xfrm_interface_core.c:252 [inline]
 xfrmi_newlink+0x22e/0x560 net/xfrm/xfrm_interface_core.c:855
 rtnl_newlink_create net/core/rtnetlink.c:3969 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4098 [inline]
 rtnl_newlink+0x1697/0x2620 net/core/rtnetlink.c:4215
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:7132
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x48b/0x4e0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2284
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5124:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2678 [inline]
 slab_free mm/slub.c:6372 [inline]
 kmem_cache_free+0x127/0x6b0 mm/slub.c:6499
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x5a2/0x10e0 kernel/rcu/tree.c:2897
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 do_softirq kernel/softirq.c:546 [inline]
 do_softirq+0xaf/0xf0 kernel/softirq.c:533
 __local_bh_enable_ip+0xff/0x120 kernel/softirq.c:473
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __alloc_skb+0x5db/0x710 net/core/skbuff.c:699
 alloc_skb include/linux/skbuff.h:1384 [inline]
 alloc_skb_with_frags+0xdd/0x760 net/core/skbuff.c:6775
 sock_alloc_send_pskb+0x801/0x980 net/core/sock.c:3012
 unix_dgram_sendmsg+0x3c7/0x1810 net/unix/af_unix.c:2144
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x48b/0x4e0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2284
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0xa5/0x9b0 kernel/rcu/tree.c:3159
 kernfs_put.part.0+0x3a6/0xaa0 fs/kernfs/dir.c:618
 kernfs_put fs/kernfs/dir.c:1787 [inline]
 kernfs_remove_by_name_ns+0xf3/0x120 fs/kernfs/dir.c:1798
 kernfs_remove_by_name include/linux/kernfs.h:644 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x8b/0x1b0 fs/sysfs/group.c:328
 sysfs_remove_groups fs/sysfs/group.c:352 [inline]
 sysfs_remove_groups+0x60/0xb0 fs/sysfs/group.c:344
 device_remove_groups drivers/base/core.c:2918 [inline]
 device_remove_attrs+0x203/0x290 drivers/base/core.c:3054
 device_del+0x36e/0x9b0 drivers/base/core.c:3964
 unregister_netdevice_many_notify+0x1503/0x2150 net/core/dev.c:12551
 ops_exit_rtnl_list net/core/net_namespace.c:188 [inline]
 ops_undo_list+0x8ff/0xab0 net/core/net_namespace.c:249
 cleanup_net+0x499/0x920 net/core/net_namespace.c:706
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888046c23000
 which belongs to the cache kernfs_node_cache of size 176
The buggy address is located 0 bytes inside of
 freed 176-byte region [ffff888046c23000, ffff888046c230b0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888046c23690 pfn:0x46c23
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801dede500 ffffea00011b07d0 ffffea00011b09d0
raw: ffff888046c23690 0000000800110009 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5868, tgid 5868 (syz-executor), ts 72534727158
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35b0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3267 [inline]
 allocate_slab mm/slub.c:3382 [inline]
 new_slab+0xa5/0x640 mm/slub.c:3428
 refill_objects+0xe3/0x410 mm/slub.c:7305
 refill_sheaf mm/slub.c:2805 [inline]
 __pcs_replace_empty_main+0x372/0x680 mm/slub.c:4677
 alloc_from_pcs mm/slub.c:4775 [inline]
 slab_alloc_node mm/slub.c:4907 [inline]
 kmem_cache_alloc_noprof+0x46e/0x6a0 mm/slub.c:4933
 __kernfs_new_node+0xd2/0xa10 fs/kernfs/dir.c:665
 kernfs_new_node+0x117/0x150 fs/kernfs/dir.c:751
 kernfs_create_link+0xcc/0x240 fs/kernfs/symlink.c:39
 sysfs_do_create_link_sd+0x90/0x140 fs/sysfs/symlink.c:44
 sysfs_do_create_link fs/sysfs/symlink.c:80 [inline]
 sysfs_create_link+0x61/0xc0 fs/sysfs/symlink.c:92
 netdev_adjacent_sysfs_add net/core/dev.c:8764 [inline]
 __netdev_adjacent_dev_insert+0x819/0xbf0 net/core/dev.c:8820
 __netdev_adjacent_dev_link_lists net/core/dev.c:8897 [inline]
 __netdev_adjacent_dev_link_neighbour net/core/dev.c:8926 [inline]
 __netdev_upper_dev_link+0x3d8/0x7e0 net/core/dev.c:8986
 netdev_master_upper_dev_link+0x9f/0xd0 net/core/dev.c:9061
 batadv_hardif_enable_interface+0x87c/0xf80 net/batman-adv/hard-interface.c:845
page last free pid 5793 tgid 5793 ts 69952822053 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 free_pages_prepare+0x586/0xe00 mm/page_alloc.c:1463
 __free_contig_range_common+0x14f/0x250 mm/page_alloc.c:7060
 __free_contig_range mm/page_alloc.c:7105 [inline]
 free_pages_bulk+0x12a/0x200 mm/page_alloc.c:5322
 vm_area_free_pages+0xad/0x2b0 mm/vmalloc.c:3462
 vfree mm/vmalloc.c:3511 [inline]
 vfree+0x108/0x730 mm/vmalloc.c:3485
 kcov_put kernel/kcov.c:447 [inline]
 kcov_put kernel/kcov.c:443 [inline]
 kcov_close+0x34/0x60 kernel/kcov.c:554
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x951/0x2ae0 kernel/exit.c:1008
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1151
 get_signal+0x1ec7/0x21e0 kernel/signal.c:3046
 arch_do_signal_or_restart+0x91/0x7e0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x139/0x700 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888046c22f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888046c22f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888046c23000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888046c23080: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb
 ffff888046c23100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
