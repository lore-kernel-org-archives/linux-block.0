Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCD3EBF0C
	for <linux-block@vger.kernel.org>; Sat, 24 Jan 2026 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769254653; cv=none; b=JkDUYhbrME7klE52iBwF47sQwYPdhY2QcRzbimGI+qoRq3k3AV9XfJl5XYavCrT4buOhgStOSDfq/RQ/hz3Dhh06ipMkYXnRlXli0yrsJVr4YzR1XdqcTh+dz+qkW2dCJ7dG7iMf/XT1NDdhtmMQdE0JFaQvxkuFpbS0Ev7gYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769254653; c=relaxed/simple;
	bh=UFaEYa7MpiUAxEkzN2PJE9LInV/P1aYmKFExDlQQelQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0j4eQ8mKQ24Gizx8cSuS1coQm16zcpvfqkt5x1+OD8rh6tuzJcbPMXX1DEMHczk9sxVBvqr/iH+5yf2RIThjYnDJsypanoZyd8jZMWA43p18wQ3LB1osC3QBRo5svrv59IMl0SzIa9dNpN6fuvfJYgCpFKmZuDPnmiUWjbwwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=iJG7v2JF; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="iJG7v2JF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1769254648;
	bh=qkOEQgaEwy9leZy1ujQ4H2JefbzU2lHbydy/pVzpG10=;
	h=From:Subject:Date:Message-ID;
	b=iJG7v2JFvLL+vHKpFpnCr9FeJnUoChzxbD5kBVK6B7Euu2wAHtDFs+SUlFTHBzEM8
	 xGWsuGXzybAeDL4zo+mMICT/BjNCeKzcVwK95hZvl5cywbstpqJ1I2s+nGTQ+nrmEU
	 Zubr88iwl0vtDjPwVv+faSSh8+54e1/LBTauY0Dk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.160])
	by sina.com (10.54.253.34) with ESMTP
	id 6974ADAE00002209; Sat, 24 Jan 2026 19:32:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1296846291920
X-SMAIL-UIID: 99F37E143FD540628EBE341A8B8EE97B-20260124-193201-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in blkdev_read_iter
Date: Sat, 24 Jan 2026 19:31:47 +0800
Message-ID: <20260124113148.2398-1-hdanton@sina.com>
In-Reply-To: <697400dc.a70a0220.35de72.000a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Lorenzo and Suren

> Date: Fri, 23 Jan 2026 15:14:36 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    24d479d26b25 Linux 6.19-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=100033fa580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1859476832863c41
> dashboard link: https://syzkaller.appspot.com/bug?extid=4e70c8e0a2017b432f7a
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11451b9a580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1045e852580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-24d479d2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d0f3c47f6869/vmlinux-24d479d2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/800231513703/bzImage-24d479d2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> 
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> syz.0.17/6091 is trying to acquire lock:
> ffff8881061287a8 (
> &sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:1042 [inline]
> &sb->s_type->i_mutex_key#8){++++}-{4:4}, at: blkdev_read_iter+0x19e/0x500 block/fops.c:855
> 
> but task is already holding lock:
> ffff888012aa0448 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x10e/0xed0 mm/mmap_lock.c:334
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (vm_lock){++++}-{0:0}:
>        __vma_enter_locked+0x260/0x770 mm/mmap_lock.c:72
>        __vma_start_write+0x21/0x160 mm/mmap_lock.c:104
>        vma_start_write include/linux/mmap_lock.h:213 [inline]
>        mprotect_fixup+0x4e3/0xb80 mm/mprotect.c:768
>        setup_arg_pages+0x4a2/0xbb0 fs/exec.c:670
>        load_elf_binary+0xb5b/0x4fe0 fs/binfmt_elf.c:1028
>        search_binary_handler fs/exec.c:1669 [inline]
>        exec_binprm fs/exec.c:1701 [inline]
>        bprm_execve fs/exec.c:1753 [inline]
>        bprm_execve+0x8c2/0x1620 fs/exec.c:1729
>        kernel_execve+0x2ef/0x3b0 fs/exec.c:1919
>        try_to_run_init_process init/main.c:1506 [inline]
>        kernel_init+0x14a/0x2b0 init/main.c:1634
>        ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> 
> -> #1 (&mm->mmap_lock){++++}-{4:4}:
>        __might_fault mm/memory.c:7174 [inline]
>        __might_fault+0x113/0x190 mm/memory.c:7168
>        _copy_to_iter+0x1c2/0x1710 lib/iov_iter.c:196
>        copy_page_to_iter lib/iov_iter.c:374 [inline]
>        copy_page_to_iter+0x12a/0x1e0 lib/iov_iter.c:361
>        copy_folio_to_iter include/linux/uio.h:204 [inline]
>        filemap_read+0x6b1/0xe40 mm/filemap.c:2851
>        blkdev_read_iter+0x1ac/0x500 block/fops.c:856
>        new_sync_read fs/read_write.c:491 [inline]
>        vfs_read+0x8bf/0xcf0 fs/read_write.c:572
>        ksys_read+0x12a/0x250 fs/read_write.c:715
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain kernel/locking/lockdep.c:3908 [inline]
>        __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
>        lock_acquire kernel/locking/lockdep.c:5868 [inline]
>        lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
>        down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
>        inode_lock_shared include/linux/fs.h:1042 [inline]
>        blkdev_read_iter+0x19e/0x500 block/fops.c:855
>        __kernel_read+0x3f3/0xbf0 fs/read_write.c:530
>        freader_fetch+0x1d7/0x9d0 lib/buildid.c:100
>        __build_id_parse.isra.0+0xdd/0x6c0 lib/buildid.c:297
>        do_procmap_query+0xb0e/0x1080 fs/proc/task_mmu.c:733
>        procfs_procmap_ioctl+0x9d/0xe0 fs/proc/task_mmu.c:813
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:597 [inline]
>        __se_sys_ioctl fs/ioctl.c:583 [inline]
>        __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &sb->s_type->i_mutex_key#8 --> &mm->mmap_lock --> vm_lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   rlock(vm_lock);
>                                lock(&mm->mmap_lock);
>                                lock(vm_lock);
>   rlock(&sb->s_type->i_mutex_key#8);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by syz.0.17/6091:
>  #0: ffff888012aa0448 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x10e/0xed0 mm/mmap_lock.c:334
> 
> stack backtrace:
> CPU: 2 UID: 0 PID: 6091 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_circular_bug+0x275/0x340 kernel/locking/lockdep.c:2043
>  check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3165 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>  validate_chain kernel/locking/lockdep.c:3908 [inline]
>  __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
>  lock_acquire kernel/locking/lockdep.c:5868 [inline]
>  lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
>  down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
>  inode_lock_shared include/linux/fs.h:1042 [inline]
>  blkdev_read_iter+0x19e/0x500 block/fops.c:855
>  __kernel_read+0x3f3/0xbf0 fs/read_write.c:530
>  freader_fetch+0x1d7/0x9d0 lib/buildid.c:100
>  __build_id_parse.isra.0+0xdd/0x6c0 lib/buildid.c:297
>  do_procmap_query+0xb0e/0x1080 fs/proc/task_mmu.c:733
>  procfs_procmap_ioctl+0x9d/0xe0 fs/proc/task_mmu.c:813
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff1a238f7c9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffebbe538b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ff1a25e5fa0 RCX: 00007ff1a238f7c9
> RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000004
> RBP: 00007ff1a2413f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ff1a25e5fa0 R14: 00007ff1a25e5fa0 R15: 0000000000000003
>  </TASK>
