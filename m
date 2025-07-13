Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3C1EFF96
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752421349; cv=none; b=M9kIFscq5dQhefuT4t6x/RBP8X3ckdJSVRWfevYH8Q6jNw1nrKAmSDCYkFMWDS12axSyevBixdblRb2ncS6TVo+RsBt+NrivxSrfAe0W776ZfBxLxmePPOYF04LcjVCRng2IM7Y4GdyEqbs4v287RWoaoeAtkB2G9YVomHW3R0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752421349; c=relaxed/simple;
	bh=SaFYluBU+L+EYzFViX2l+6YawcQJbA76Ws9TbT3hGSU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s2DV+VPpGaqCxay7Mmp+ApBUwViMyaam5cp2ddl+cfeUKXWknFKzO8tPKfFFWuOCTBaQzJ32GrZ+GbKo74KWZbPCG8ec+e5FMmi+QrEWK4JZX2Z0h5XwnADnwu9N695vd3aiAHr3Tgl11QAXAw2NUyYdny4VZzWb/84aQ0ITXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddd5cd020dso75810055ab.0
        for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 08:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752421346; x=1753026146;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOb0TIfN8eHX0SzWrBMQOe29Zvzw5phJWhvtKlA/Fp8=;
        b=gabiX+M2Q01FKmECdYXlCX2hwQMZE7o6EnuW42f8Qasir1ouMWF8NkzFbGjY32BHkY
         99ZumtWhGV8Dqj5TeZoUci3LQnzwUAgXjTzFDZq4t4L+TuY3r8aoRuv8W6aDOItLKPa0
         GluepTZuNalVMwD4qVfu4qCcLYnx9c0I0ZGSB0uXyqe/+CJgDy82MzlaGmbhFGAyW2L4
         sCNX44GkIO9F82Xk7iqemhswwlPUitjsHCVTSFkKokMeQb8Z7ilfhpO8r23cSQpE7+7K
         9/lZd1v1eZ8f9cxVYFvgIKLYd8ykxZXmUrJKkdgWJ7oe6X1BQJplvl4jAvnZGpbR7EqW
         /32w==
X-Forwarded-Encrypted: i=1; AJvYcCUswbEU0j94wKNuwqtI6r9zm9Yqsgdnshwe1US8QLCIGC5cohdr5bGAMkFkjuzrg3o9IQ4lgFOdpxG2+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YydQuRu8bB1m/4ary8dphBpvs6eQT9JZhpD1RkixfXYuVAuIpYT
	bJM9jI9vt3v5UeyWt7msRa1RuLByNx+Db4LMNEdp60mIHILidh4CEm0wHsMt1oX3w6XI17ZuGR6
	rR8xjyp141alp2Vi/7xV1Hw42H3sP25gFvfXs4AyooLN4UvMinTQeNuM8pJo=
X-Google-Smtp-Source: AGHT+IFRVrtttzsUxeyRKyVsTokGYkDp53kgP/r6h2NuUf/w/BT/E7I9sf0VqkHuw1273BnuE+E90ztK5C2blx3c9y0ueo9X7hUJ
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1708:b0:3df:32c4:30da with SMTP id
 e9e14a558f8ab-3e253317f3amr123614855ab.12.1752421346056; Sun, 13 Jul 2025
 08:42:26 -0700 (PDT)
Date: Sun, 13 Jul 2025 08:42:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6873d3e2.a70a0220.3b380f.0038.GAE@google.com>
Subject: [syzbot] [nbd?] INFO: task hung in nbd_disconnect_and_put
From: syzbot <syzbot+aa56a8f25e07970eef7f@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, josef@toxicpanda.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nbd@other.debian.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d7a0577c9db gcc-15: disable '-Wunterminated-string-initia..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1646e7ac580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bbffc3b5b4301e1
dashboard link: https://syzkaller.appspot.com/bug?extid=aa56a8f25e07970eef7f
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fab1688104be/disk-9d7a0577.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1c06b313afed/vmlinux-9d7a0577.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f0781f867fd/bzImage-9d7a0577.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa56a8f25e07970eef7f@syzkaller.appspotmail.com

INFO: task syz.0.2226:13602 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc3-syzkaller-00001-g9d7a0577c9db #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.2226      state:D stack:22024 pid:13602 tgid:13600 ppid:5827   task_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1b33/0x51f0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x163/0x360 kernel/sched/core.c:6860
 schedule_timeout+0xb1/0x2b0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x32f/0x600 kernel/sched/completion.c:148
 __flush_workqueue+0x579/0x1280 kernel/workqueue.c:4000
 nbd_disconnect_and_put+0xac/0x2d0 drivers/block/nbd.c:2242
 nbd_genl_disconnect+0x4a2/0x7a0 drivers/block/nbd.c:2281
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb38/0xf00 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:727
 ____sys_sendmsg+0x523/0x860 net/socket.c:2566
 ___sys_sendmsg net/socket.c:2620 [inline]
 __sys_sendmsg+0x271/0x360 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1614f8e169
RSP: 002b:00007f1615e92038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f16151b5fa0 RCX: 00007f1614f8e169
RDX: 0000000020000004 RSI: 00002000000001c0 RDI: 0000000000000012
RBP: 00007f1615010a68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f16151b5fa0 R15: 00007ffd5f7d41d8
 </TASK>
INFO: task syz.3.2228:13608 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc3-syzkaller-00001-g9d7a0577c9db #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.2228      state:D stack:27728 pid:13608 tgid:13606 ppid:5834   task_flags:0x400140 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1b33/0x51f0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x163/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 __mutex_lock_common kernel/locking/mutex.c:678 [inline]
 __mutex_lock+0x805/0x10c0 kernel/locking/mutex.c:746
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:727
 __sys_sendto+0x365/0x4c0 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc55038fffc
RSP: 002b:00007fc551291ec0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fc551291fc0 RCX: 00007fc55038fffc
RDX: 0000000000000028 RSI: 00007fc551292010 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007fc551291f14 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000004
R13: 00007fc551291f68 R14: 00007fc551292010 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x30/0x180 kernel/locking/lockdep.c:6764
2 locks held by kworker/u9:0/55:
 #0: ffff8880259b3148 ((wq_completion)nbd0-recv){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff8880259b3148 ((wq_completion)nbd0-recv){+.+.}-{0:0}, at: process_scheduled_works+0x990/0x18e0 kernel/workqueue.c:3319
 #1: ffffc9000100fc60 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000100fc60 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9cb/0x18e0 kernel/workqueue.c:3319
2 locks held by getty/5584:
 #0: ffff88803686a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036be2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x5bb/0x1700 drivers/tty/n_tty.c:2222
7 locks held by kworker/u9:9/5846:
 #0: ffff88807cabb948 ((wq_completion)hci9){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88807cabb948 ((wq_completion)hci9){+.+.}-{0:0}, at: process_scheduled_works+0x990/0x18e0 kernel/workqueue.c:3319
 #1: ffffc90004ec7c60 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90004ec7c60 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9cb/0x18e0 kernel/workqueue.c:3319
 #2: ffff8880380c8d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff8880380c8078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1f1/0xeb0 net/bluetooth/hci_sync.c:5597
 #4: ffffffff90251468 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2051 [inline]
 #4: ffffffff90251468 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1269
 #5: ffff88807a923b38 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_conn_del+0x71/0x690 net/bluetooth/l2cap_core.c:1761
 #6: ffffffff8ed43438 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:336 [inline]
 #6: ffffffff8ed43438 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x454/0x830 kernel/rcu/tree_exp.h:998
7 locks held by kworker/u8:13/5966:
 #0: ffff88801b089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801b089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x990/0x18e0 kernel/workqueue.c:3319
 #1: ffffc9000b2dfc60 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000b2dfc60 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9cb/0x18e0 kernel/workqueue.c:3319
 #2: ffff88805d9b0250 (&devlink->lock_key#5){+.+.}-{4:4}, at: nsim_dev_trap_report_work+0x57/0xb50 drivers/net/netdevsim/dev.c:838
 #3: ffffffff9a9d7de0 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x190/0x5c0 lib/debugobjects.c:818
 #4: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 #4: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0xb8/0x23b0 arch/x86/kernel/unwind_orc.c:479
 #5: ffff8880b873df00 (&c->lock){-.-.}-{3:3}, at: local_lock_acquire include/linux/local_lock_internal.h:38 [inline]
 #5: ffff8880b873df00 (&c->lock){-.-.}-{3:3}, at: put_cpu_partial+0x72/0x250 mm/slub.c:3246
 #6: ffff88801b07b078 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #6: ffff88801b07b078 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: __pte_offset_map_lock+0x1bd/0x310 mm/pgtable-generic.c:402
3 locks held by syz.0.2226/13602:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
 #2: ffff8880259a7998 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_disconnect_and_put+0x30/0x2d0 drivers/block/nbd.c:2234
2 locks held by syz.3.2228/13608:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz.1.2236/13634:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz.1.2236/13636:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz.1.2236/13640:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz.1.2236/13642:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz.1.2236/13644:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz.4.2243/13654:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz.2.2244/13656:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz.2.2244/13658:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13666:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13668:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13686:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13697:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13699:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13716:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13718:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13731:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13744:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13746:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13763:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13765:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13782:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13789:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209
2 locks held by syz-executor/13798:
 #0: ffffffff9014f790 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff9014f648 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x125/0xf00 net/netlink/genetlink.c:1209

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc3-syzkaller-00001-g9d7a0577c9db #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x4ab/0x4e0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:437
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 2896 Comm: kworker/u8:6 Not tainted 6.15.0-rc3-syzkaller-00001-g9d7a0577c9db #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__this_cpu_preempt_check+0x0/0x20 lib/smp_processor_id.c:65
Code: ff f4 e8 a3 ca 01 f5 eb a9 e8 5c e0 ff ff 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 89 fe 48 c7 c7 80 e2 a0 8c e9 bd fe ff ff cc cc cc
RSP: 0018:ffffc9000b727928 EFLAGS: 00000046
RAX: eb5a65c3d50a3195 RBX: ffff8880308dbc00 RCX: 0000000000000006
RDX: 0000000000000006 RSI: ffffffff8e4c80af RDI: ffffffff8e635648
RBP: ffffc9000b727a10 R08: ffffffff905ebb77 R09: 1ffffffff20bd76e
R10: dffffc0000000000 R11: fffffbfff20bd76f R12: 1ffff920016e4f30
R13: dffffc0000000000 R14: ffffffff93651020 R15: ffffffff8183d708
FS:  0000000000000000(0000) GS:ffff8881250cf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555be4730600 CR3: 000000000eb38000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lockdep_hardirqs_on+0x9d/0x150 kernel/locking/lockdep.c:4473
 __local_bh_enable_ip+0x168/0x200 kernel/softirq.c:412
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_nc_purge_paths+0x312/0x3b0 net/batman-adv/network-coding.c:471
 batadv_nc_worker+0x365/0x610 net/batman-adv/network-coding.c:722
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
