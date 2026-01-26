Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41734D38D
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448063; cv=pass; b=SOT7mIX+t4ZEeo8DY1/LqPxDJgNMOmPqPgmcrjRYpoJG3UoTwqYski33svk2ceShEm9J8iW+dbiB2iaMMapaE8s+ZUDD73MASc9c+JhBPQTDazBfGaPYuA9fWGSbzV30nC0mafYMIPmkG2VL2VF0YVtXA0WTzLihWLOUBLwq3HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448063; c=relaxed/simple;
	bh=Inm8zAeOZ4i0aFVnkGqk31jw6G/Fpiv/pzfbKja+moI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB44SmY0PqdprMrYL6rgyzgV+JQLhYlI3uafU2COIqo+dJwswJL8HQhzR7UXeMOZ/rO2hA+PJwICYQhOrPIyu/nrNcWNYmvzO5JTjV15cNb92AlRjlVIZfWAcCJNjH0XD9kbaLGnYtzaIP+bUEM/s0XC339Am1S5MXrw44WZb/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSFigcV8; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSFigcV8"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014acad6f2so946211cf.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 09:20:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769448055; cv=none;
        d=google.com; s=arc-20240605;
        b=Oh0A19YsjJPg35oBQg9sU0nS9TpcfyyRkEb017qrg/hotBhaIdI3mi/HEpyurm1Qp2
         LHvwWljwQsCQMn3lCOHzW2q6iGrp4EQskcfjUF+LEsjaWGOmyqkYzZO/0WZ79Ak7me2t
         mhnKRPBTyv1BxQRclDSQN/7Mm9y/o98xRpHcaudHcwRc5AYiq+bBrOn9InE9i1R6Ukmn
         dlluAeI4JwloSZaTYJTc1Wo+lWmZ3nnv/bXZ8qeNZrlJHxm03FOaJggZFump6+Q1kB4s
         f906abPrn4vJWfKVDMHZbYQrEVh2KM5vC63m5OWyXRVpB7pYvHnueqVEk7JQE75nq9bL
         YoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p7APez++HU18X32QySejJYuFhFmHW/DtgVmQ1nohA+Y=;
        fh=o4oeihGa7zfpZe+YZSb3kcCsxGR04/Tj7xDqnfYqChU=;
        b=Q83dug8cByPkujjcwdEEuIMFjY9rmE7uySjBOemX816baxjf6jb3rejf+ZJpdiOylv
         JvVFoHzwnSlxHZaPUzWz6tJyn8etCapPVCoyL0H99jUpZCN0QCyg0VLBhfYztzuzAiTc
         mS1euiqnwEH+cr9BI8eDrM8hwI677Nf6osWojyPv9/51eMLE/7kPx5jDPMmo4KJ5b4X+
         +snfjtuHgtS4Le/pV0oFp1AhQKie3t5kti7/FwsR/tTYiQTR7vrzFF1S0JCanjkY88Jb
         Hw1zAd153G5LguPuY/hQzX/2NVhJ2dWiMkNUJ9EcbptzLUE08qR7JN3moo3QNJUjkmx4
         7LTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769448055; x=1770052855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7APez++HU18X32QySejJYuFhFmHW/DtgVmQ1nohA+Y=;
        b=aSFigcV8TrIf+IB2OJ196/FrriqcxozoJ++Q9PSeJXesxRn+OcYMlgYkuAmuYiN2By
         xTGXsTfAjzyRsQg62TfzTRph84/mXxuTWx1DUdMF8dBKzl+UDLv/1RDlrgZhTbc8LllA
         me43+DgpuhISyOCTtzGu1xwlsHGfc9KNr4zLZ5PncpePZZwpeJ86hhxTQ94T3SWmBD1A
         HdJk6DUoAXUSDbPXOxypcctNFBje+MGq8iHzeRnF+eAZarMwM+l0ioZY+iNKV9RnFSzq
         949E3rvTiXf16WPrarSYH9p6r2GpwkDZkg8VSiUYL7JNcQRm9+WCl+s7UX4thuVaLaiK
         FITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448055; x=1770052855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p7APez++HU18X32QySejJYuFhFmHW/DtgVmQ1nohA+Y=;
        b=Sb+yVvKdkbcSXPzoHkuw61SYHAj0FwkNfTTF4daZ4t8Ef5qwasFaZ4b7HCeD4i9pbs
         q3OhYG9PTmWYhHg4me8d9qByBpUTTKwBgFZ4t6tjAHOTeVPjXxRpq9AeMk5MMlIuFK4X
         imAH+CbQKw9U91R126Hue6oUL/hBiwwFUqWdraOBVLq5AwA3tT6LxcT4Rf+fR+khLw2H
         3WgBpp6tF519mD1vTrmbBRRd43GqT6Fl3TLPAYzUjRt9KajQhoujpwg3u5QCgG2QZva4
         um3eaQM6hDTzODhGBEkCRQ7LC/grfF4M+H5JRPiUr7ffzivt0xpWWltRV4OJcfFarWst
         Dbwg==
X-Forwarded-Encrypted: i=1; AJvYcCVSyQrl7IfhFktL4jYHkHMOhHNzj3Qx0SlFk5u6Ic0osY1fcVCA8eaHQSiYqsrbXda2bgytxvUwqdabDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjeuV/Jso/Jnf4xyfYc0ufixI/yi8USRbqpFVM3hgSGlETMf8I
	44lTasSfVt4lmkoPtWy4EK9udY1WLK00c54Kqlzm21XUFiwj9P27nalbJYQQNXU2TN1AhsF3ExI
	XkYyCBk9rhF1t8wYzNtWH7EDHNrG/agvqDP9evFO5
X-Gm-Gg: AZuq6aKTWdUMoULuBh4BWXHL2nIAWZO+CR7UvGjFTCaqpaNlwilyrIV2wW1OAoNmblg
	wHlUafSqBVYMHnd63ig5uH7YZRhIxd7qDMYwUEPVQosobuV7UMl4zN/yZ+448Fi5kdMqrEwFXN0
	hm0Ur7AP51+l0n1Vq6zPievjGIG/Prh+p35XcVHZEamDvPYtnmgMn29jODTIJWcE36XWBICm9oG
	7TJh2HxKdfrLeMYV6VSV51z7VBZ57YrQb2Uly7xHTKMISIfpmGdDbGpEGb7e62/f7KU0w==
X-Received: by 2002:a05:622a:1:b0:4ed:ff79:e678 with SMTP id
 d75a77b69052e-5031460c5bbmr12761811cf.18.1769448054567; Mon, 26 Jan 2026
 09:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <697400dc.a70a0220.35de72.000a.GAE@google.com> <20260124113148.2398-1-hdanton@sina.com>
In-Reply-To: <20260124113148.2398-1-hdanton@sina.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Jan 2026 09:20:43 -0800
X-Gm-Features: AZwV_QjN0MTy89Cv_uUZhJM67pJS7MJrnu33QJJk62Z-m3gDLWs3VFenxC3gr_g
Message-ID: <CAJuCfpEcqAiK-z=EZ5im12F2wfGHYogiMHaTC4t5uopLmBKQPw@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in blkdev_read_iter
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com>, axboe@kernel.dk, 
	linux-block@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 3:32=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> Add Lorenzo and Suren

Thanks!

>
> > Date: Fri, 23 Jan 2026 15:14:36 -0800
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    24d479d26b25 Linux 6.19-rc6
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D100033fa580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D18594768328=
63c41
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D4e70c8e0a2017=
b432f7a
> > compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binu=
tils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11451b9a5=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1045e852580=
000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/d900f083ada3/non_bootable_disk-24d479d2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/d0f3c47f6869/vmli=
nux-24d479d2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/800231513703=
/bzImage-24d479d2.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> >
> > WARNING: possible circular locking dependency detected
> > syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz.0.17/6091 is trying to acquire lock:
> > ffff8881061287a8 (
> > &sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock_shared include/=
linux/fs.h:1042 [inline]
> > &sb->s_type->i_mutex_key#8){++++}-{4:4}, at: blkdev_read_iter+0x19e/0x5=
00 block/fops.c:855
> >
> > but task is already holding lock:
> > ffff888012aa0448 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x10e/0xed0 m=
m/mmap_lock.c:334
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #2 (vm_lock){++++}-{0:0}:
> >        __vma_enter_locked+0x260/0x770 mm/mmap_lock.c:72
> >        __vma_start_write+0x21/0x160 mm/mmap_lock.c:104
> >        vma_start_write include/linux/mmap_lock.h:213 [inline]
> >        mprotect_fixup+0x4e3/0xb80 mm/mprotect.c:768
> >        setup_arg_pages+0x4a2/0xbb0 fs/exec.c:670
> >        load_elf_binary+0xb5b/0x4fe0 fs/binfmt_elf.c:1028
> >        search_binary_handler fs/exec.c:1669 [inline]
> >        exec_binprm fs/exec.c:1701 [inline]
> >        bprm_execve fs/exec.c:1753 [inline]
> >        bprm_execve+0x8c2/0x1620 fs/exec.c:1729
> >        kernel_execve+0x2ef/0x3b0 fs/exec.c:1919
> >        try_to_run_init_process init/main.c:1506 [inline]
> >        kernel_init+0x14a/0x2b0 init/main.c:1634
> >        ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
> >        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> >
> > -> #1 (&mm->mmap_lock){++++}-{4:4}:
> >        __might_fault mm/memory.c:7174 [inline]
> >        __might_fault+0x113/0x190 mm/memory.c:7168
> >        _copy_to_iter+0x1c2/0x1710 lib/iov_iter.c:196
> >        copy_page_to_iter lib/iov_iter.c:374 [inline]
> >        copy_page_to_iter+0x12a/0x1e0 lib/iov_iter.c:361
> >        copy_folio_to_iter include/linux/uio.h:204 [inline]
> >        filemap_read+0x6b1/0xe40 mm/filemap.c:2851
> >        blkdev_read_iter+0x1ac/0x500 block/fops.c:856
> >        new_sync_read fs/read_write.c:491 [inline]
> >        vfs_read+0x8bf/0xcf0 fs/read_write.c:572
> >        ksys_read+0x12a/0x250 fs/read_write.c:715
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> >        check_prev_add kernel/locking/lockdep.c:3165 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> >        validate_chain kernel/locking/lockdep.c:3908 [inline]
> >        __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
> >        lock_acquire kernel/locking/lockdep.c:5868 [inline]
> >        lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
> >        down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
> >        inode_lock_shared include/linux/fs.h:1042 [inline]
> >        blkdev_read_iter+0x19e/0x500 block/fops.c:855
> >        __kernel_read+0x3f3/0xbf0 fs/read_write.c:530
> >        freader_fetch+0x1d7/0x9d0 lib/buildid.c:100
> >        __build_id_parse.isra.0+0xdd/0x6c0 lib/buildid.c:297
> >        do_procmap_query+0xb0e/0x1080 fs/proc/task_mmu.c:733
> >        procfs_procmap_ioctl+0x9d/0xe0 fs/proc/task_mmu.c:813
> >        vfs_ioctl fs/ioctl.c:51 [inline]
> >        __do_sys_ioctl fs/ioctl.c:597 [inline]
> >        __se_sys_ioctl fs/ioctl.c:583 [inline]
> >        __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >

It looks like:
#0 is executing PROCMAP_QUERY ioclt, read-locks vm_lock and then calls
build_id_parse()->__build_id_parse(...,
may_fault=3Dtrue)->__kernel_read() which eventually takes
inode->i_rwsem.
#1 is a file-backed page fault which asserts that it might take
mmap_lock for read.
#2 is load_elf_binary()->mprotect_fixup() which write-locks both
mmap_lock and vm_lock. I'm guessing it already holds inode->i_rwsem
before write-locking these locks.

Originally I thought the issue is most liley introduced in
d9d1c2d81797 ("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under
per-vma locks"). But if #2 indeed takes inode->i_rwsem before
write-locking mmap_lock, then the problem should exist even before
that change when we didn't use vm_lock and relied on mmap_lock...

I'll try to analyze this more before attempting a fix.

> > other info that might help us debug this:
> >
> > Chain exists of:
> >   &sb->s_type->i_mutex_key#8 --> &mm->mmap_lock --> vm_lock
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   rlock(vm_lock);
> >                                lock(&mm->mmap_lock);
> >                                lock(vm_lock);
> >   rlock(&sb->s_type->i_mutex_key#8);
> >
> >  *** DEADLOCK ***
> >
> > 1 lock held by syz.0.17/6091:
> >  #0: ffff888012aa0448 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x10e/0x=
ed0 mm/mmap_lock.c:334
> >
> > stack backtrace:
> > CPU: 2 UID: 0 PID: 6091 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT=
(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> >  print_circular_bug+0x275/0x340 kernel/locking/lockdep.c:2043
> >  check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
> >  check_prev_add kernel/locking/lockdep.c:3165 [inline]
> >  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> >  validate_chain kernel/locking/lockdep.c:3908 [inline]
> >  __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
> >  lock_acquire kernel/locking/lockdep.c:5868 [inline]
> >  lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
> >  down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
> >  inode_lock_shared include/linux/fs.h:1042 [inline]
> >  blkdev_read_iter+0x19e/0x500 block/fops.c:855
> >  __kernel_read+0x3f3/0xbf0 fs/read_write.c:530
> >  freader_fetch+0x1d7/0x9d0 lib/buildid.c:100
> >  __build_id_parse.isra.0+0xdd/0x6c0 lib/buildid.c:297
> >  do_procmap_query+0xb0e/0x1080 fs/proc/task_mmu.c:733
> >  procfs_procmap_ioctl+0x9d/0xe0 fs/proc/task_mmu.c:813
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:597 [inline]
> >  __se_sys_ioctl fs/ioctl.c:583 [inline]
> >  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7ff1a238f7c9
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffebbe538b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007ff1a25e5fa0 RCX: 00007ff1a238f7c9
> > RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000004
> > RBP: 00007ff1a2413f91 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ff1a25e5fa0 R14: 00007ff1a25e5fa0 R15: 0000000000000003
> >  </TASK>
