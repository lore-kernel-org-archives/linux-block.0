Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4925B0B5
	for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514251; cv=none; b=dKnAgxlQV1l/hLVlpCK0yfD8xw1uAP1hjK4br1tM8LoCF/w6tanz47pVRZpjiy04bKq3r6Jnzq+Mxg4B6U5HMpIElf0OKSrzYbLcRFGdp8D0eU7qrbv14LTZLQULa1LeRiIEK3SZ85Z5hG1X9XE8AIMfrQ3aeE8yHnwVmTueB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514251; c=relaxed/simple;
	bh=QRIdQluCk3QLosPqfo96XSsuBkfKYf8CUwC0syWuSlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQ2lMiPCTupxDMBhy1gVbKTBXAmXXfM/CZQ9NA0dIEz6eoPC4jnXawXd6sHHG9xJ+aF2B8kNO61dKd1NcBqofsQNte9BOkneRMRcQCpmFnIe3cTAfiQYrzwMq7ZH4bK+puk6YCWU8kJ+MtG/iHY5sH/yBaY7uvccUGZjlcZthjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=RPN0BxPf; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="RPN0BxPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1784514247;
	bh=woWadxQghcjkXbDzp/H/WystQ4Rj24Ob6vmjFHJmPOI=;
	h=From:Subject:Date:Message-ID;
	b=RPN0BxPfhUk8mg0CKcPivBstCEJ6GxOfgX96ZQF2j3Qi5o23+OYX6ccObviRuFaTS
	 26LRAjwDV1k/PJChVTuMnFHYiZ1Mqfv+xlltnFdPs+6c2vsxrMtdBNp8lx+82k9UFO
	 E8Z0LMEoQQVDPdwqEnGJhMIK+HdsCj7QKXhxJLPg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.152.105])
	by sina.com (10.54.253.34) with ESMTP
	id 6A5D86BA000022B7; Mon, 20 Jul 2026 10:23:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3486996292308
X-SMAIL-UIID: 383306E85FA74E3F94EC87EA1A0B0347-20260720-102357-1
From: Hillf Danton <hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Mon, 20 Jul 2026 10:23:43 +0800
Message-ID: <20260720022345.593-1-hdanton@sina.com>
In-Reply-To: <20260629052854.252-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Jun 28, 2026 at 10:29 PM Hillf Danton <hdanton@sina.com> wrote:
> For archive purpose, syzbot report [1] where udp was not invovled defies
> what is fixed in d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep
> circular dependency") -- "Since the UDP socket and the NBD TCP/TLS socket
> are different, this is a false positive."
>
>
> [1] Subject: [syzbot] [net?] possible deadlock in inet_shutdown (3)
> https://lore.kernel.org/lkml/69c37e6a.a70a0220.234938.0045.GAE@google.com/
>
For archive purpose, syzbot report [2] shows deadlock without either udp or
tcp invovled. But it sounds false positive because kernfs node is removed
while the filesystem is filling super block.

[2] Subject: [syzbot] [kernfs?] possible deadlock in kernfs_remove_by_name_ns (2)
https://lore.kernel.org/lkml/6a5ca0b7.f1649fcc.2a4208.03f3.GAE@google.com/

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4329 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4343
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4565 [inline]
       slab_alloc_node mm/slub.c:4925 [inline]
       kmem_cache_alloc_lru_noprof+0x65/0x5f0 mm/slub.c:4978
       alloc_inode+0xb8/0x1b0 fs/inode.c:340
       iget_locked+0x131/0x6a0 fs/inode.c:1477
       kernfs_get_inode+0x4f/0x770 fs/kernfs/inode.c:252
       kernfs_fill_super fs/kernfs/mount.c:308 [inline]
       kernfs_get_tree+0x5cd/0x980 fs/kernfs/mount.c:392
       vfs_get_tree+0x92/0x2a0 fs/super.c:1694
       fc_mount fs/namespace.c:1198 [inline]
       do_new_mount_fc fs/namespace.c:3765 [inline]
       do_new_mount+0x319/0xdc0 fs/namespace.c:3841
       do_mount fs/namespace.c:4174 [inline]
       __do_sys_mount fs/namespace.c:4390 [inline]
       __se_sys_mount+0x31d/0x420 fs/namespace.c:4367
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&root->kernfs_rwsem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       down_write+0x96/0x200 kernel/locking/rwsem.c:1631
       kernfs_remove_by_name_ns+0x4e/0x140 fs/kernfs/dir.c:1792
       _cfg80211_unregister_wdev+0x133/0x5a0 net/wireless/core.c:1420
       ieee80211_if_remove+0x289/0x340 net/mac80211/iface.c:2432
       ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:254
       rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
       cfg80211_remove_virtual_intf+0x221/0x3f0 net/wireless/util.c:3006
       cfg80211_destroy_ifaces+0x23f/0x300 net/wireless/core.c:436
       cfg80211_destroy_iface_wk+0x21/0x30 net/wireless/core.c:464
       process_one_work kernel/workqueue.c:3322 [inline]
       process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
