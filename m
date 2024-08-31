Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAD13A885
	for <linux-block@vger.kernel.org>; Sat, 31 Aug 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725092310; cv=none; b=aZx1E4TUbGZ5ngoaSdd4jgxsYM+2R7nGBCjwZ7trAThfLZUAcPH6Q/9XJW7nkOGwAot8XSOVjX+vPWq2A2ETt2Lu+WYZXetI5L+2Tm2gkyHPzM+I2YEYFudIyK4lLCXajoJGtcn7lU/s6Gbx61c/WULiwsszUHtdISvaRoUVh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725092310; c=relaxed/simple;
	bh=0I3OuNI4VvJ0paAIVemwa2/EnT8j8anwqHeYAfhX7t0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ofJSbtuPqN1E16D5EItBjFwxUQW6Rh+INKVU49V9oL2f2h6ZLvTpfrQfpzt3ev7GJoFlav99Xs+Qb0N9Dm4ENUeZianY/aVQy/pvvY7hoGHPmjsjrzQomjkApiKKOwJdErlbxd7qR6d1sJNYaU95D/h5Rv2/C72idEG7UaUq/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d4b5b9fa0so32449845ab.1
        for <linux-block@vger.kernel.org>; Sat, 31 Aug 2024 01:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725092307; x=1725697107;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knjAS1tQN3ZYyFOE90oanJOXIlzxSaZ8B1nrjE0bm7U=;
        b=ByU1vz3XPCkPZErWuEP/SXX/Hn1iwlTT2UDY7rHno/ClHG+pZ4BETrB+6IbrrcKoYA
         TSVz9v/7mk0nXqyaBRdqnbQEWae/K2RcHOx9qcMP1yTkPLYdI2mf/lTbnRgVD+47/ahZ
         nnW3jj+VGUMtSytlbxWBaTPrVuTeUhx8f4A31G48J49jgGHE7/9iL955nRi2nmki6Q71
         JZR3UILC14AYbaUFlhRbaWElkHIflsGz6IunNhHMPpD/h7IGJANTOZFEU0Pe0CFD/aXS
         lUsyS3vJwHzF7wfx9hgVRopSqxM07mNauDIlE4SYC+mewRXAG080yU5DZCZG0avLUYuh
         cmDw==
X-Forwarded-Encrypted: i=1; AJvYcCXl773N2wzeuHzU1iflrhHSePgjKNgMX4dSmB6zqe8QbNt8c+DUmcpuRkPPfViCeCaq409J+hEllZX0wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpssZ4G9A29qoUwewtDRrmQYn7q+ED8DVYleEzR7iZNkEgpjf
	dW1vrSWgvxo22ZB1lV7VeJH5iEN8IvXfrZ0OdO7Fqk7haQFYLFiMVc8ZDiMtTBGeyQAPhdWWmhs
	29aqFrlM27HU/LRZee0TGgfQY9pavQ9J+3Y2xdCMSuTrT3gKnZUspMyE=
X-Google-Smtp-Source: AGHT+IGGxVkVSWEwkp9kKfHlbZgnGGZtuK2niNMJFZNLFBLsM7Ki98U0u0/zK9zMxKwKQP+aBpILbMiyE06Zs8n3URZd0WXxN+3R
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d83:b0:39d:3043:1f20 with SMTP id
 e9e14a558f8ab-39f410838a3mr3454885ab.5.1725092307467; Sat, 31 Aug 2024
 01:18:27 -0700 (PDT)
Date: Sat, 31 Aug 2024 01:18:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003112240620f65a5e@google.com>
Subject: [syzbot] [block?] INFO: task hung in set_blocksize
From: syzbot <syzbot+3c0a6dfa116ca1e1ad1c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d5d547aa7b51 Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10323863980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d806687521800cad
dashboard link: https://syzkaller.appspot.com/bug?extid=3c0a6dfa116ca1e1ad1c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d66b93c08fc0/disk-d5d547aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bcc11a0a62dd/vmlinux-d5d547aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ff8c492340ac/bzImage-d5d547aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c0a6dfa116ca1e1ad1c@syzkaller.appspotmail.com

INFO: task syz.1.815:10479 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc5-syzkaller-00081-gd5d547aa7b51 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.815       state:D stack:24624 pid:10479 tgid:10474 ppid:10004  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 io_schedule+0x8d/0x110 kernel/sched/core.c:7401
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1307
 truncate_inode_pages_range+0xaaf/0xfc0 mm/truncate.c:396
 kill_bdev block/bdev.c:90 [inline]
 set_blocksize+0x2f4/0x360 block/bdev.c:172
 sb_set_blocksize+0x47/0xf0 block/bdev.c:181
 ocfs2_get_sector+0x9f/0x500 fs/ocfs2/super.c:1756
 ocfs2_sb_probe fs/ocfs2/super.c:747 [inline]
 ocfs2_fill_super+0x3c7/0x5880 fs/ocfs2/super.c:988
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3bb2179ef9
RSP: 002b:00007f3bb2ee3038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f3bb2316208 RCX: 00007f3bb2179ef9
RDX: 0000000020000a40 RSI: 0000000020000a00 RDI: 0000000020000000
RBP: 00007f3bb21e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000008004 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3bb2316208 R15: 00007fffcfb52258
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e738320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e738320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e738320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
4 locks held by kworker/u8:4/63:
 #0: ffff8880162e3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff8880162e3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900015e7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900015e7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fa6b290 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffffffff8e73d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 #3: ffffffff8e73d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
2 locks held by dhcpcd/4890:
 #0: ffffffff8fa5ca48 (vlan_ioctl_mutex){+.+.}-{3:3}, at: sock_ioctl+0x664/0x8e0 net/socket.c:1303
 #1: ffffffff8fa77e48 (rtnl_mutex){+.+.}-{3:3}, at: vlan_ioctl_handler+0x112/0x9d0 net/8021q/vlan.c:553
2 locks held by getty/4984:
 #0: ffff88802b0d20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000312b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/0:3/5231:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003507d00 (free_ipc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003507d00 (free_ipc_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e73d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 #2: ffffffff8e73d6f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
3 locks held by kworker/u8:13/5775:
 #0: ffff888015489148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015489148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90015f87d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90015f87d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fa77e48 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
3 locks held by kworker/u8:17/5781:
1 lock held by syz.2.148/5904:
1 lock held by syz.0.781/10292:
3 locks held by kworker/u8:2/10327:
 #0: ffff88802a733948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802a733948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003997d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003997d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fa77e48 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4194
1 lock held by syz.1.815/10479:
 #0: ffff88806adb40e0 (&type->s_umount_key#82/1){+.+.}-{3:3}, at: alloc_super+0x221/0x9d0 fs/super.c:344
3 locks held by syz-executor/10796:
 #0: ffff88801f46cd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff88801f46cd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_unregister_dev+0x203/0x510 net/bluetooth/hci_core.c:2692
 #1: ffff88801f46c078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x572/0x11a0 net/bluetooth/hci_sync.c:5145
 #2: ffffffff8fbe3928 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:1977 [inline]
 #2: ffffffff8fbe3928 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_hash_flush+0xa6/0x240 net/bluetooth/hci_conn.c:2592
1 lock held by syz-executor/10816:
 #0: ffffffff8fa77e48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa77e48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/10935:
 #0: ffffffff8fa77e48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa77e48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
2 locks held by syz-executor/10948:
 #0: ffffffff8fa6b290 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c6/0x7b0 net/core/net_namespace.c:504
 #1: ffffffff8fa77e48 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc5-syzkaller-00081-gd5d547aa7b51 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 10816 Comm: syz-executor Not tainted 6.11.0-rc5-syzkaller-00081-gd5d547aa7b51 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__kasan_record_aux_stack+0x9f/0xc0 mm/kasan/generic.c:540
Code: 48 01 fe 48 39 f3 77 03 48 89 de 4c 89 ff e8 e8 30 f4 ff 48 89 c3 49 63 87 bc 00 00 00 48 85 c0 74 18 48 01 c3 74 13 8b 43 08 <89> 43 0c 31 ff 44 89 f6 e8 94 cc ff ff 89 43 08 5b 41 5e 41 5f 5d
RSP: 0018:ffffc90003e4f8f8 EFLAGS: 00000282
RAX: 0000000000000000 RBX: ffff88805ebd9358 RCX: ffffea00017af600
RDX: 0000000000000000 RSI: ffff88805ebd9180 RDI: ffff8880162fec80
RBP: 0000000000000280 R08: ffffffff8142c2ec R09: 1ffffffff1fee4e5
R10: dffffc0000000000 R11: fffffbfff1fee4e6 R12: dffffc0000000000
R13: ffff88805ebd9180 R14: 0000000000000001 R15: ffff8880162fec80
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002017f000 CR3: 000000000e534000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 task_work_add+0xb8/0x450 kernel/task_work.c:66
 fput+0x11c/0x210 fs/file_table.c:482
 filp_close+0x28/0x40 fs/open.c:1540
 close_files fs/file.c:433 [inline]
 put_files_struct+0x1b6/0x360 fs/file.c:448
 do_exit+0xa10/0x27f0 kernel/exit.c:877
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 get_signal+0x16a1/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffba437bd8c
Code: Unable to access opcode bytes at 0x7ffba437bd62.
RSP: 002b:00007ffeec38c290 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: 000000000000002c RBX: 00007ffba5044620 RCX: 00007ffba437bd8c
RDX: 000000000000002c RSI: 00007ffba5044670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffeec38c2e4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007ffba5044670 R15: 0000000000000000
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
