Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBA1B372C
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719678; cv=none; b=HFAb4V6CKkQl0aOUeBDVlRh2qcP62PPnhXueM8hKExzupJZBv3ZhmnmQ9C+QTlg76d0GHrRgKTwomjbpK5s9xsLm6LwmnCjyknnogxVu/bfx3bMJCFIA5AZ//qHSb1gMMmOyd5DBN0MGntYit5KHIeSXROBWzBkf/ARAD0Hr0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719678; c=relaxed/simple;
	bh=g0Jvq01ekc2p2fE5T0wALH3L2L59ZQq+bs14tVLItLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VG+qFNQy7fydCrl+f3eEMYF/J5CK7C7+m+IbCHjXnscp3lX6UgCvCQPdA2sQnBeQ6VzsmvAe5G+Rf4cuLZXXqtc1LdfSHnrVPmBrEmHTvzHNtrXk4FEw0pR10azTCE/mlSUdS7yjYCu/7UM4lvArv1Llfo6qejXZb2eTg6yf3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.238])
	by sina.com (10.185.250.22) with ESMTP
	id 6728AFAD00003B11; Mon, 4 Nov 2024 19:27:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9662897602657
X-SMAIL-UIID: 8B4B0F5DD50F45A49F83C169A34A77A4-20241104-192745-1
From: Hillf Danton <hdanton@sina.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: syzbot <syzbot+949ae54e95a2fab4cbb4@syzkaller.appspotmail.com>,
	axboe@kernel.dk,
	hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in __submit_bio
Date: Mon,  4 Nov 2024 19:27:32 +0800
Message-Id: <20241104112732.3144-1-hdanton@sina.com>
In-Reply-To: <6727f6f0.050a0220.3c8d68.0aa9.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 03 Nov 2024 14:19:28 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f26630580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
> dashboard link: https://syzkaller.appspot.com/bug?extid=949ae54e95a2fab4cbb4
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102632a7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16749340580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/61af3e8f2dbd/mount_0.gz
> 
> The issue was bisected to:
> 
> commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Oct 25 00:37:20 2024 +0000
> 
>     block: model freeze & enter queue as lock for supporting lockdep
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13eafaa7980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=101afaa7980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17eafaa7980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+949ae54e95a2fab4cbb4@syzkaller.appspotmail.com
> Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")
> 
> exFAT-fs (loop0): failed to load upcase table (idx : 0x00012153, chksum : 0x822ffc2e, utbl_chksum : 0xe619d30d)
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor382/6007 is trying to acquire lock:
> ffff8881427474e8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: __submit_bio+0x2c2/0x560 block/blk-core.c:629
> 
> but task is already holding lock:
> ffff888034dd00e8 (&sbi->s_lock){+.+.}-{4:4}, at: exfat_create+0x1a2/0x5a0 fs/exfat/namei.c:553
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&sbi->s_lock){+.+.}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
>        exfat_lookup+0x140/0x18f0 fs/exfat/namei.c:701
>        lookup_open fs/namei.c:3573 [inline]
>        open_last_lookups fs/namei.c:3694 [inline]
>        path_openat+0x11a7/0x3590 fs/namei.c:3930
>        do_filp_open+0x235/0x490 fs/namei.c:3960
>        do_sys_openat2+0x13e/0x1d0 fs/open.c:1419
>        do_sys_open fs/open.c:1434 [inline]
>        __do_sys_openat fs/open.c:1450 [inline]
>        __se_sys_openat fs/open.c:1445 [inline]
>        __x64_sys_openat+0x247/0x2a0 fs/open.c:1445
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #1 (&sb->s_type->i_mutex_key#15){++++}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        down_write+0x99/0x220 kernel/locking/rwsem.c:1577
>        inode_lock include/linux/fs.h:817 [inline]
>        __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1536
>        exfat_file_fsync+0xf9/0x1d0 fs/exfat/file.c:524
>        __loop_update_dio+0x1a4/0x500 drivers/block/loop.c:204

	blk_mq_freeze_queue(lo->lo_queue);
	blk_freeze_queue_start(q);
		percpu_ref_kill(&q->q_usage_counter);
		blk_freeze_acquire_lock(q, false, false);
	blk_mq_freeze_queue_wait(q);
		wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));

While waiting for the q_usage_counter to drop to zero, percpu_ref_tryget is 
allowed by the define of wait, so the acquire_read in bio_queue_enter() makes
no sense.

>        loop_set_status+0x62b/0x8f0 drivers/block/loop.c:1290
>        lo_ioctl+0xcbc/0x1f50
>        blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:907 [inline]
>        __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&q->q_usage_counter(io)#17){++++}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849

static inline int bio_queue_enter(struct bio *bio)
{
	struct request_queue *q = bdev_get_queue(bio->bi_bdev);

	if (blk_try_enter_queue(q, false)) {
		//
		// q_usage_counter is not zero otherwise
		// percpu_ref_tryget_live_rcu() failed
		//
		rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
		rwsem_release(&q->io_lockdep_map, _RET_IP_);
		return 0;
	}
	return __bio_queue_enter(q, bio);
}

>        bio_queue_enter block/blk.h:75 [inline]
>        blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3069
>        __submit_bio+0x2c2/0x560 block/blk-core.c:629
>        __submit_bio_noacct_mq block/blk-core.c:710 [inline]
>        submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
>        submit_bh fs/buffer.c:2819 [inline]
>        __sync_dirty_buffer+0x23d/0x390 fs/buffer.c:2857
>        exfat_set_volume_dirty+0x5d/0x80 fs/exfat/super.c:124
>        exfat_create+0x1aa/0x5a0 fs/exfat/namei.c:554
>        lookup_open fs/namei.c:3595 [inline]
>        open_last_lookups fs/namei.c:3694 [inline]
>        path_openat+0x1c03/0x3590 fs/namei.c:3930
>        do_filp_open+0x235/0x490 fs/namei.c:3960
>        do_sys_openat2+0x13e/0x1d0 fs/open.c:1419
>        do_sys_open fs/open.c:1434 [inline]
>        __do_sys_openat fs/open.c:1450 [inline]
>        __se_sys_openat fs/open.c:1445 [inline]
>        __x64_sys_openat+0x247/0x2a0 fs/open.c:1445
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &q->q_usage_counter(io)#17 --> &sb->s_type->i_mutex_key#15 --> &sbi->s_lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&sbi->s_lock);
>                                lock(&sb->s_type->i_mutex_key#15);
>                                lock(&sbi->s_lock);
>   rlock(&q->q_usage_counter(io)#17);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by syz-executor382/6007:
>  #0: ffff888034b8a420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
>  #1: ffff88807733e330 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: inode_lock include/linux/fs.h:817 [inline]
>  #1: ffff88807733e330 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: open_last_lookups fs/namei.c:3691 [inline]
>  #1: ffff88807733e330 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: path_openat+0x89a/0x3590 fs/namei.c:3930
>  #2: ffff888034dd00e8 (&sbi->s_lock){+.+.}-{4:4}, at: exfat_create+0x1a2/0x5a0 fs/exfat/namei.c:553
