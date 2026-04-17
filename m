Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421A363C46
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432990; cv=none; b=FL53/FsZu9WLQUQUxU+Sv4FJglDjrA/bJX4PoOIXICKQ3+D/XnKySCU8Lfm4BDu1bvYW3QQw4nG80Ood6PA6/5QYDLQW7WWQZSI9TNR8qFD+vdGJ1xty+gV7TBoe1WWv7f4PYNsbk+hNy5SRxf+3oDkGqaOb7kuh1vlI244zxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432990; c=relaxed/simple;
	bh=mYRwj+f0dSCvG27DPAHmZw2TkqgtqjxgsW1C7+qpAqg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r7gq0H6wpd9k7N06i6bMh3msgJsCkP9l1xb2QQ5mwIEJPm835jwmRV6GNxLygMB0i17fDeBgP3dYOPgIW6YoE2pkbG3kpjZcUGusTsxOYuahrE7om/qrjAfxlfmFBnj6HnLC1E0xYpeYgRQ/p/I32P5L0z87E6w2y3OZ0cSuqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-66b612efb4aso1129878eaf.0
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 06:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432987; x=1777037787;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8r8RQcT+lHsJ9VyQYtdTFQmXzQ7eSInwRbXM7y4+8og=;
        b=ZfE4B2cgLwymhUYFOqguvsP7rE9mtbtJ6/rv+gXu4S8w34UImqqbqg+TOmgr9OZ8hw
         AqNggJn16Vj3+HQXfrAdQYbVZeIMxFk1ak7YVOEroN8NHqHm0dP0DnkMy3yMS2Kby8WA
         UmePLPKnlofWrMFP2rHO6vekVQ8pdo5Pj58yyFvlB6k1HiiJqwB3Lj6B1nwB6enLZ8Kr
         NWQjpHfKS4i7ealyjQWGKORIUylbc1hx2ec+1zM3MduoykWxKWF5OJgx+IDbO9LDHnIs
         L3K+z2hgFOy506hMkN0m++rM94ALBt392tEjInwdgVad8dADknka9C6/NOPZN+S9ECIm
         pW9A==
X-Forwarded-Encrypted: i=1; AFNElJ+p7U39irh/hrDYV28i+zc402WOJQGcB29p0SxyIxzbzb6tEqSOq/5GyXKSI2T610evmcPBK9oNjV6t+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOI63EtpHX5MPXvDsb4fYiQ1KK9JZp+Olbnr7PSW6HJaFlbsia
	lYy2YnaGRRbSY+libCjHMK420c1GpaR13EANK1HPslp6+qdsfZpiAHpkiRoQUvYoZCGUOGsuup/
	PAjhiiNs7+j817ntt1RVUPAZ/+wiw0J1uuFlNF5rUNdk/6rACcpwHYgU1z9A=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:c897:0:b0:686:f60b:dde8 with SMTP id
 006d021491bc7-694637d78f4mr970678eaf.24.1776432987265; Fri, 17 Apr 2026
 06:36:27 -0700 (PDT)
Date: Fri, 17 Apr 2026 06:36:27 -0700
In-Reply-To: <68b016f0.a00a0220.1337b0.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e2375b.050a0220.1de265.0024.GAE@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in queue_limits_commit_update_frozen
From: syzbot <syzbot+f272bbfbf8498ddadea5@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    1f5ffc672165 Fix mismerge of the arm64 / timer-core interr..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=162a24ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95729ed00549063a
dashboard link: https://syzkaller.appspot.com/bug?extid=f272bbfbf8498ddadea5
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e41ba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b552538b97f/disk-1f5ffc67.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/724a3a1d69d7/vmlinux-1f5ffc67.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea684969e2c2/bzImage-1f5ffc67.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f272bbfbf8498ddadea5@syzkaller.appspotmail.com

INFO: task syz.0.17:6086 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:25416 pid:6086  tgid:6086  ppid:5943   task_flags:0x480140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x17b4/0x5680 kernel/sched/core.c:7183
 __schedule_loop kernel/sched/core.c:7262 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7277
 blk_mq_freeze_queue_wait+0x101/0x180 block/blk-mq.c:191
 blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 queue_limits_commit_update_frozen+0x55/0xd0 block/blk-settings.c:590
 nbd_set_size+0x454/0x680 drivers/block/nbd.c:374
 nbd_genl_size_set drivers/block/nbd.c:2069 [inline]
 nbd_genl_reconfigure+0x7f5/0x1ea0 drivers/block/nbd.c:2373
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f197e79c819
RSP: 002b:00007ffdd46f8ca8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f197ea15fa0 RCX: 00007f197e79c819
RDX: 0000000000000000 RSI: 0000200000000100 RDI: 0000000000000004
RBP: 00007f197e832c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f197ea15fac R14: 00007f197ea15fa0 R15: 00007f197ea15fa0
 </TASK>
INFO: task syz.3.27:6088 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.27        state:D stack:27336 pid:6088  tgid:6088  ppid:5948   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x17b4/0x5680 kernel/sched/core.c:7183
 __schedule_loop kernel/sched/core.c:7262 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7277
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7334
 __mutex_lock_common kernel/locking/mutex.c:712 [inline]
 __mutex_lock+0x7f5/0x1550 kernel/locking/mutex.c:806
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x672/0x710 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3f2135d04e
RSP: 002b:00007ffeeed0eab8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00005555561e6500 RCX: 00007f3f2135d04e
RDX: 000000000000001c RSI: 00007ffeeed0ec30 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffeeed0eb34 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffeeed0eb88 R14: 00007ffeeed0ec30 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u8:1/13:
1 lock held by khungtaskd/30:
 #0: ffffffff8e95d020 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e95d020 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e95d020 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5579:
 #0: ffff888035f540a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000322b2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45c/0x13a0 drivers/tty/n_tty.c:2211
1 lock held by udevd/5842:
 #0: ffff8880268fb350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:953
1 lock held by udevd/5879:
 #0: ffff8880268ff350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:953
1 lock held by udevd/5880:
 #0: ffff8880269d3350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:953
2 locks held by syz-executor/5944:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/5946:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by kworker/u9:4/5954:
 #0: ffff888026b15140 ((wq_completion)nbd6-recv){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3263 [inline]
 #0: ffff888026b15140 ((wq_completion)nbd6-recv){+.+.}-{0:0}, at: process_scheduled_works+0xa35/0x1860 kernel/workqueue.c:3371
 #1: ffffc900047d7c40 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3264 [inline]
 #1: ffffc900047d7c40 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa70/0x1860 kernel/workqueue.c:3371
2 locks held by syz-executor/5957:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
1 lock held by udevd/5959:
 #0: ffff88802684f350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:953
1 lock held by udevd/6082:
 #0: ffff888026a97350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:953
1 lock held by udevd/6085:
 #0: ffff888026a93350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:953
6 locks held by syz.0.17/6086:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
 #2: ffff888026893a60 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_genl_reconfigure+0x4c1/0x1ea0 drivers/block/nbd.c:2364
 #3: ffff8880268cc7c8 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:1097 [inline]
 #3: ffff8880268cc7c8 (&q->limits_lock){+.+.}-{4:4}, at: nbd_set_size+0x263/0x680 drivers/block/nbd.c:354
 #4: ffff8880268cc190 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 #4: ffff8880268cc190 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: queue_limits_commit_update_frozen+0x55/0xd0 block/blk-settings.c:590
 #5: ffff8880268cc1c8 (&q->q_usage_counter(queue)#33){+.+.}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 #5: ffff8880268cc1c8 (&q->q_usage_counter(queue)#33){+.+.}-{0:0}, at: queue_limits_commit_update_frozen+0x55/0xd0 block/blk-settings.c:590
2 locks held by syz.3.27/6088:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6097:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6099:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6119:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6120:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6136:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6146:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6148:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6171:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6172:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6188:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6201:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
2 locks held by syz-executor/6203:
 #0: ffffffff8fe3ddc8 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe3dc00 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xfaa/0x1000 kernel/hung_task.c:515
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:63
Code: 5b 74 02 e9 c3 f6 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d e3 4d 16 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffffff8e607dc0 EFLAGS: 00000242
RAX: 000000000016be61 RBX: ffffffff819a67ea RCX: 0000000080000001
RDX: 0000000000000001 RSI: ffffffff8dfb65fa RDI: ffffffff8c27f000
RBP: ffffffff8e607eb0 R08: ffff8880b86339db R09: 1ffff110170c673b
R10: dffffc0000000000 R11: ffffed10170c673c R12: 0000000000000000
R13: 1ffffffff1cd25d8 R14: 0000000000000000 R15: 1ffffffff1cd25d8
FS:  0000000000000000(0000) GS:ffff888125245000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bbb9380660 CR3: 0000000074fb4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/kernel/process.c:766 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x36a/0x5f0 kernel/sched/idle.c:352
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:451
 rest_init+0x2de/0x300 init/main.c:762
 start_kernel+0x38a/0x3e0 init/main.c:1220
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x147
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
