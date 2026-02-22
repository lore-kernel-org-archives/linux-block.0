Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0FB17C203;
	Sun, 22 Feb 2026 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771796812; cv=none; b=PwKwX408tC/wnlLC8LaYSr7Ay/2hIq+0Zj6cm4wtA8z5zQYNZi64Eb437or2z7uuBr8XZfyPxT6yQeK6U1vxJEaA65AIngw/P6nIo3W5bW2u5rVfyEllhqRV0WYy8cWGIgOuq6daq2C/Z33HGa8jgQK8hjbIi0X286SvKawvfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771796812; c=relaxed/simple;
	bh=PShAnn5NkbThhv3yFxSNY6IBmrCp7uHLu1e2LOKxblc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qRi9CyaNCGHEd4bkW4BL11totIXzinE8zbgN2NQjZftD07L82sfDc0j0p/GMEs97wp550ueO3wgIO1tmNqKu16XinmAZ81/S37TXpo+J+yiuaGQEje0C7A8qoESlbWeF1YuJ9VK2fSYVVqAA2mQiXUQO2KE5xGcuycEa1X14nNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+Dg4TQU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+Dg4TQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE0AC116D0;
	Sun, 22 Feb 2026 21:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771796811;
	bh=PShAnn5NkbThhv3yFxSNY6IBmrCp7uHLu1e2LOKxblc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q+Dg4TQUKfByCnYHWVLn9v5mJM7/dAoa7hDC+q7BGu2o+DBc8e4C+Eo0gevRvMHpV
	 TgWcdDkOVwynCi853Q6J7XMxTvZ2THLCvLwt2UpA51wI5I9fxdNI+mfdoQ658ZtfXO
	 KL7P83I05UD9VirIsd8S2wpykgQdZKeheWl69rBRMWZ9U77Z7rXTsIA9asRvTEKcG3
	 54B6LDeyZz96Jjk4W3Fpiec9fPuxhJV5opLyN03N3XAzFnVR/NypDZ94CrJKrveaBA
	 seBd7iLl06TZEJ2qBGF5B5gE/32vBPcr8prsjuQg34xBdR6YAlipPCV683+9kND56Q
	 agX8wle1UKW7A==
From: Thomas Gleixner <tglx@kernel.org>
To: syzbot <syzbot+0b6ec149bb8b98bd9485@syzkaller.appspotmail.com>,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com, x86@kernel.org
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 nbd@other.debian.org
Subject: Re: [syzbot] [kernel?^W NDB] possible deadlock in worker_thread (3)
In-Reply-To: <69988ebc.a70a0220.2c38d7.0142.GAE@google.com>
References: <69988ebc.a70a0220.2c38d7.0142.GAE@google.com>
Date: Sun, 22 Feb 2026 22:46:48 +0100
Message-ID: <87bjhgwiwn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 20 2026 at 08:41, syzbot wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    635c467cc14e Add linux-next specific files for 20260213
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15339b3a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61690c38d1398936
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b6ec149bb8b98bd9485
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/78b3d15ca8e6/disk-635c467c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a95f3d108ef4/vmlinux-635c467c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e58086838b24/bzImage-635c467c.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0b6ec149bb8b98bd9485@syzkaller.appspotmail.com
>
> block nbd1: Receive control failed (result -32)
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> kworker/u9:3/5827 is trying to acquire lock:
> ffff8880275b9a78 (&nbd->config_lock){+.+.}-{4:4}, at: refcount_dec_and_mutex_lock+0x30/0xa0 lib/refcount.c:118
>
> but task is already holding lock:
> ffffc90003bd7c40 ((work_completion)(&args->work)#3){+.+.}-{0:0}, at: process_one_work+0x87c/0x1650 kernel/workqueue.c:3255
>
> which lock already depends on the new lock.

This is clearly a NDB issue and the lockdep splat is pretty clear.

Cc'ed the maintainer and left the report intact.

>
> the existing dependency chain (in reverse order) is:
>
> -> #2 ((work_completion)(&args->work)#3){+.+.}-{0:0}:
>        process_one_work+0x895/0x1650 kernel/workqueue.c:3255
>        process_scheduled_works kernel/workqueue.c:3362 [inline]
>        worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
>        kthread+0x388/0x470 kernel/kthread.c:467
>        ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> -> #1 ((wq_completion)nbd3-recv){+.+.}-{0:0}:
>        touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:3994
>        __flush_workqueue+0x14b/0x14f0 kernel/workqueue.c:4036
>        nbd_disconnect_and_put+0x9e/0x2c0 drivers/block/nbd.c:2264
>        nbd_genl_disconnect+0x4a9/0x590 drivers/block/nbd.c:2303
>        genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1115
>        genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>        genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1210
>        netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>        netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>        netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
>        netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
>        sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
>        __sock_sendmsg net/socket.c:752 [inline]
>        ____sys_sendmsg+0x589/0x8c0 net/socket.c:2610
>        ___sys_sendmsg+0x2a5/0x360 net/socket.c:2664
>        __sys_sendmsg net/socket.c:2696 [inline]
>        __do_sys_sendmsg net/socket.c:2701 [inline]
>        __se_sys_sendmsg net/socket.c:2699 [inline]
>        __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2699
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #0 (&nbd->config_lock){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain kernel/locking/lockdep.c:3908 [inline]
>        __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
>        lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
>        refcount_dec_and_mutex_lock+0x30/0xa0 lib/refcount.c:118
>        nbd_config_put+0x2c/0x580 drivers/block/nbd.c:1434
>        recv_work+0x1cc1/0x1d90 drivers/block/nbd.c:1026
>        process_one_work+0x949/0x1650 kernel/workqueue.c:3279
>        process_scheduled_works kernel/workqueue.c:3362 [inline]
>        worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
>        kthread+0x388/0x470 kernel/kthread.c:467
>        ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> other info that might help us debug this:
>
> Chain exists of:
>   &nbd->config_lock --> (wq_completion)nbd3-recv --> (work_completion)(&args->work)#3
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock((work_completion)(&args->work)#3);
>                                lock((wq_completion)nbd3-recv);
>                                lock((work_completion)(&args->work)#3);
>   lock(&nbd->config_lock);
>
>  *** DEADLOCK ***
>
> 2 locks held by kworker/u9:3/5827:
>  #0: ffff8880275c9148 ((wq_completion)nbd1-recv){+.+.}-{0:0}, at: process_one_work+0x855/0x1650 kernel/workqueue.c:3254
>  #1: ffffc90003bd7c40 ((work_completion)(&args->work)#3){+.+.}-{0:0}, at: process_one_work+0x87c/0x1650 kernel/workqueue.c:3255
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 5827 Comm: kworker/u9:3 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
> Workqueue: nbd1-recv recv_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
>  check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3165 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>  validate_chain kernel/locking/lockdep.c:3908 [inline]
>  __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
>  lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
>  __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>  __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
>  refcount_dec_and_mutex_lock+0x30/0xa0 lib/refcount.c:118
>  nbd_config_put+0x2c/0x580 drivers/block/nbd.c:1434
>  recv_work+0x1cc1/0x1d90 drivers/block/nbd.c:1026
>  process_one_work+0x949/0x1650 kernel/workqueue.c:3279
>  process_scheduled_works kernel/workqueue.c:3362 [inline]
>  worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
>  kthread+0x388/0x470 kernel/kthread.c:467
>  ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> block nbd1: shutting down sockets
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
