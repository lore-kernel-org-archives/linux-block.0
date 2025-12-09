Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825DB26FDB3
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 23:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321460; cv=none; b=M4nWe59gsoBAv3T6bV/j0/7mQ0UskcqfFAadWvzr2aY7+M87IntNWNN5vECnZVowpXdNoYMbrs+vV2O4dGRsGYpRzTf9kdQDBSGaNrR0wWbeiXPl/L8xxQF4u2CrPHLPkk0e6+NazFDgfbtLeIgl2jI7UsvtIcUsDdLDiIRBLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321460; c=relaxed/simple;
	bh=NIVro1SOQdLPBOyeKJj/zTfkwKR6IFDoV2cm2TcN7iI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZzTQFBuUPGisJiiJ4P+86cvhhKq5HXHnZlfFDdCaIBPZNHz33pCo7r9rZ4ZTbiGX3eEOwRYdmn7wln+ZmYm8nEvESHbayFv+lKUY96g7tIbSM8f3Jz7CgxHR9lGJs9/0ugX+mADE4HdbYVg3CsTDGENoIj08RXPGDZOdvFgZAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-657a467228eso9323633eaf.0
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 15:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765321457; x=1765926257;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCz8Pzju1wHYNulx//WuZW8IfSTFFeX5t6v95K7DqYU=;
        b=AIG6y3hjt/pj388HoT2f/XslH5DrxYE2eDCYuIQfMW85kPz6cM39xSPHcui6mF3XRz
         RFuvl/pH5k3vu0sdTeOkYZ5fn1QhV655EdA4Cwrx0VJGetmGjE8nex/L47igv84PXuxP
         2D3vD5bv/bOyrj6GGLuJTh4TdR2XaLryWZkYXqoSgk/9S58thggh5wVeBlZf15xLfVG+
         FX9KrXA6K8W7qLJy6lHNuNr3jSdgXsPxuoTwZuqtuBKB46jo/OugygDWlbiVFx7O/Srl
         wuDcL9N1mr7g0lNNpu8ObfHFiOOwUpWiPb4R37+DvxdVldpmTr1rvKugVCNZk4bqn/ho
         HqDA==
X-Forwarded-Encrypted: i=1; AJvYcCUjxeVpFMcMP7y1ZB1oqW96guQpKLYa3SQ0pXa2KJrYpfAsv/roHT/KRUeoiK7Yve/Z4m3ukPzGEea2/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzziCxr0c8M67d6rVYQxV55ZZ05/rCHNQ7kvzQevkPhu0/NP6xl
	HLWHOPngacYlKhVhGmTPPHAfmvg/9tEmpQ0gFzMMjQh7QpXIqixdGWCjiViPtyJK3XuXzpRN1NL
	swddFxcGFNkLbIIvVLFTC9OJC/NMVVs3MlsZF0KxIxxzwSnnRonsRnyEbSNI=
X-Google-Smtp-Source: AGHT+IFoFj6ZgxiVHTn9gFK42Fs7KhnTjjPx7upH6Ts29YjeUH5YRmXunujf/Vsa1vCbALJCU+T/rcFimDL9YZ02ASflUQkyIwUI
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:160d:b0:659:9a49:8fdb with SMTP id
 006d021491bc7-65b2ad3a2c9mr258625eaf.84.1765321457629; Tue, 09 Dec 2025
 15:04:17 -0800 (PST)
Date: Tue, 09 Dec 2025 15:04:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6938aaf1.050a0220.1ff09b.000c.GAE@google.com>
Subject: [syzbot] [block?] [trace?] INFO: task hung in relay_open (2)
From: syzbot <syzbot+16ea22f26882d7e46f35@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6987d58a9cbc Add linux-next specific files for 20251205
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10bf76b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=16ea22f26882d7e46f35
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c88992580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/59159f6ab772/disk-6987d58a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f1f1b2a92c01/vmlinux-6987d58a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ff8485477cfd/bzImage-6987d58a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16ea22f26882d7e46f35@syzkaller.appspotmail.com

INFO: task syz.2.19:6056 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.19        state:D stack:25248 pid:6056  tgid:6055  ppid:5947   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 relay_open+0x3b8/0x920 kernel/relay.c:517
 blk_trace_setup_prepare+0x425/0x5a0 kernel/trace/blktrace.c:716
 blk_trace_setup+0x244/0x3d0 kernel/trace/blktrace.c:789
 blk_trace_ioctl+0x2f9/0x6e0 kernel/trace/blktrace.c:935
 blkdev_ioctl+0x4a2/0x710 block/ioctl.c:780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fea2af8f749
RSP: 002b:00007fea2bf0d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fea2b1e5fa0 RCX: 00007fea2af8f749
RDX: 0000200000000240 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007fea2b013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fea2b1e6038 R14: 00007fea2b1e5fa0 R15: 00007ffde1a3bc48
 </TASK>
INFO: task syz.4.21:6058 blocked for more than 145 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.21        state:D stack:26184 pid:6058  tgid:6057  ppid:5957   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 relay_open+0x3b8/0x920 kernel/relay.c:517
 blk_trace_setup_prepare+0x425/0x5a0 kernel/trace/blktrace.c:716
 blk_trace_setup+0x244/0x3d0 kernel/trace/blktrace.c:789
 blk_trace_ioctl+0x2f9/0x6e0 kernel/trace/blktrace.c:935
 blkdev_ioctl+0x4a2/0x710 block/ioctl.c:780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f046d78f749
RSP: 002b:00007f046e673038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f046d9e5fa0 RCX: 00007f046d78f749
RDX: 0000200000000240 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f046d813f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f046d9e6038 R14: 00007f046d9e5fa0 R15: 00007fffac8419a8
 </TASK>
INFO: task syz.3.20:6060 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.20        state:D stack:26776 pid:6060  tgid:6059  ppid:5954   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 relay_open+0x3b8/0x920 kernel/relay.c:517
 blk_trace_setup_prepare+0x425/0x5a0 kernel/trace/blktrace.c:716
 blk_trace_setup+0x244/0x3d0 kernel/trace/blktrace.c:789
 blk_trace_ioctl+0x2f9/0x6e0 kernel/trace/blktrace.c:935
 blkdev_ioctl+0x4a2/0x710 block/ioctl.c:780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f92ec78f749
RSP: 002b:00007f92ed544038 EFLAGS: 00000246
 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f92ec9e5fa0 RCX: 00007f92ec78f749
RDX: 0000200000000240 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f92ec813f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f92ec9e6038 R14: 00007f92ec9e5fa0 R15: 00007fffaeee7358
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df419e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df419e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8df419e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
3 locks held by kworker/u8:7/1150:
 #0: ffff88814c8c7948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x841/0x15a0 kernel/workqueue.c:3236
 #1: ffffc90003ddfb80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x868/0x15a0 kernel/workqueue.c:3237
 #2: ffffffff8f310348 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8f310348 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x112/0x14b0 net/ipv6/addrconf.c:4194
2 locks held by klogd/5190:
3 locks held by udevd/5201:
2 locks held by dhcpcd/5495:
2 locks held by getty/5585:
 #0: ffff88814c2ba0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x449/0x1460 drivers/tty/n_tty.c:2211
3 locks held by syz-execprog/5825:
 #0: 
ffff88807d8b9bc0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:410 [inline]
ffff88807d8b9bc0 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/mmap_lock.c:390 [inline]
ffff88807d8b9bc0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x32/0x300 mm/mmap_lock.c:450
 #1: ffff88807ec85280 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:1092 [inline]
 #1: ffff88807ec85280 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_fault+0x8ff/0x1290 mm/filemap.c:3556
 #2: ffffffff8e04f820 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4374 [inline]
 #2: ffffffff8e04f820 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xb8/0x300 mm/page_alloc.c:4399
6 locks held by syz-execprog/5826:
1 lock held by syz-execprog/5827:
 #0: ffff88807ec85280 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:1092 [inline]
 #0: ffff88807ec85280 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_fault+0x8ff/0x1290 mm/filemap.c:3556
2 locks held by syz-executor/5834:
3 locks held by syz.1.18/6054:
2 locks held by syz.2.19/6056:
 #0: ffff88814173d520 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
 #1: ffffffff8df98a48 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x3b8/0x920 kernel/relay.c:517
2 locks held by syz.4.21/6058:
 #0: ffff888140b91bf0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
 #1: ffffffff8df98a48 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x3b8/0x920 kernel/relay.c:517
2 locks held by syz.3.20/6060:
 #0: ffff888140b908e0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
 #1: ffffffff8df98a48 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x3b8/0x920 kernel/relay.c:517
2 locks held by syz.6.23/6210:
 #0: ffff888140b94210 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
 #1: ffffffff8df98a48 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x3b8/0x920 kernel/relay.c:517
2 locks held by syz.5.22/6211:
 #0: ffff888140b92f00
 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
 #1: 
ffffffff8df98a48 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x3b8/0x920 kernel/relay.c:517
2 locks held by syz.9.26/6214:
 #0: ffff888140b97b40 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
 #1: ffffffff8df98a48 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x3b8/0x920 kernel/relay.c:517
2 locks held by syz.7.24/6216:
 #0: ffff888140b95520 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
 #1: ffffffff8df98a48 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x3b8/0x920 kernel/relay.c:517
2 locks held by syz.8.25/6218:
 #0: ffff888140b96830 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
 #1: ffffffff8df98a48 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x3b8/0x920 kernel/relay.c:517
2 locks held by syz.0.27/6323:
 #0: ffff88814173af00 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
 #1: ffffffff8df98a48 (relay_channels_mutex){+.+.}-{4:4}, at: relay_open+0x3b8/0x920 kernel/relay.c:517
1 lock held by syz.2.29/6335:
 #0: ffff88814173d520 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
1 lock held by syz.1.28/6340:
 #0: ffff88814173c210 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
1 lock held by syz.3.30/6342:
 #0: ffff888140b908e0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
1 lock held by syz.4.31/6344:
 #0: ffff888140b91bf0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
1 lock held by syz.6.32/6466:
 #0: ffff888140b94210 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
1 lock held by syz.9.34/6490:
 #0: ffff888140b97b40 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788
1 lock held by syz.5.33/6494:
 #0: ffff888140b92f00 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0x21c/0x3d0 kernel/trace/blktrace.c:788


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
