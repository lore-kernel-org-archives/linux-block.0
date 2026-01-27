Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA4329C57
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539894; cv=pass; b=QFFgQi9ss9zPhW27F7inEfb/I8cxf0A1fKVcs/gUx+HxMJnig4dUz27ejafGk/nPH7lEmuT0wkCzxRn7lvqgJFSx2IunKa4r3jBxSuMsyZPwcqauDKtdil3J1Q26lYcI5fwdkxCZFZL6SPUbv4BjFOA/nd7EHOjpwJeRd2xyEWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539894; c=relaxed/simple;
	bh=G8um55qi4WhUkmeT/SHO15f1IyrS1vKluP6I3if/RBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmNzFWNX/b6U5/PRZkDXz6gR6/s+1rHsz8+lQ8gvuMWG97V1POdq+5tMdkLZy4idM25KADkt4WmEr9+8t14BqkQrDkfz2nFsJgNAwc8Y2iTdIwOFaV2qSYzP9VvfvmJvTm4y9TyzTojB6b0LkqGnSzINjWpjFL1Kxx9+4uTKq4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9Tefuab; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9Tefuab"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7a23f5915so39489655ad.2
        for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 10:51:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769539890; cv=none;
        d=google.com; s=arc-20240605;
        b=LgHstT9eiMrjsvo/gropujMhZ78+xg7j9xamCJGVF4hWNAlxLbOzcsiNK9wBVNe7YL
         2/rsEH49Bkk8Spxjpeu4YqpOyv0su4/6k4yAtDhjBaOC1uoiBdgVhnY3e4menWHngfr/
         n1pPL4QNSEKbOL3TYBCcgxYvUZdP8RAuZLtCC9iq0ZVMLytHV9NKlPYTFeCzgOwFjXWq
         4TEs6QL/pshXX6LIWUGKn+0gmM2H55CSr6MiEYQs0IlGclNJbvq55TeQvN2IFng97umS
         qytz63IOKDFwq10dPwg0TMh57xOd301eczuEtZXbR2kooeofSJ9wW5K8t9uzklHMDgu8
         UB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ZQeTNPkxXp69ol8Z73/dPpyrDbveradQi2tvfEY8nI=;
        fh=qM1dw9Gc15hb9C0bePpi1lXjtiadfQCmdEuu8gXn+uM=;
        b=eHQGYPigEX7YbUMbjrHaZSjP9brwDV9teCqqnQ+PmyUVFfMWnKSBST1wg6Q2MnfJ5q
         OcaguSbjQ/Kcfod/iXAE2dU3eBZmfq/pMpeFDlamn19OQQYPGLD1Dd/tKePLSsnMEWe/
         nzxI4gdAqJxu1/2p3wtVmCrZaVy/5lIZYm0DckTbQLAb9+l1P1kSj7wiDIUValYxNWqv
         wObzWzin01dtXzjyBqoJ9SwshbGWZTyh/GP/nHZzYb/fySmzzlkx3XAO5B1A7lL1dfcw
         Fd5WwNvpjI03ZT6DP8epcy0E5KM977hQUWD2bB7WYzBlpeA9Ru8pIQkVWRs6EUyDmd31
         LyAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769539890; x=1770144690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZQeTNPkxXp69ol8Z73/dPpyrDbveradQi2tvfEY8nI=;
        b=U9TefuabQq9ZI1wXx3V4QVXtOa0MiCqc/pQOCfLXiCQsUEgZ2j9JOWgbb7codCM8KJ
         JyOc0t7JUeLiQpPiRdvoZ03TSS+ZsGdBSVxUYTpT7UqV9I5uqxjQdLVbfk0XaxoKNXAH
         Fk3jaLWNLLYj4M/tKBdU+lhtfbat1UuJ+KI8Vv6NH7N9scmvlHRX7lqUrGp1UNv5WQfr
         G7eV9m1bJSJFokTCg1Vj22k26TVas+y6dN0pwIcLwHAe8W0fdA54cmRwjv0o9LvwlBVJ
         L5kpozThC5vw+navht3Zt0QQ54mNjIXk4NSC+qU3vsm4FWVx3yziHI9HkOfxJ53w7FEP
         NcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539890; x=1770144690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ZQeTNPkxXp69ol8Z73/dPpyrDbveradQi2tvfEY8nI=;
        b=JA7ANkVmcwcBix/3yhf/DHq4g9PIKT5nsBusMfk1n6JS47mRhILTE57ZNQPwQ0mZpn
         fcAc9oguRFxDbqUGP0mgko9TE48v/7ZN2atw4BULsEXTFnnhjuCN2OjfxSzhMle/66Mz
         dYuqzTxo3IbPEOQ1u7J4NH7EckZAtz4WAWirJP6+O+M8sDx+DaagdXBzorzAgG1VTorw
         tA8IyYPW4CD9AizPAbIwx3tfdBmGvtINGZxOIRYuSQqcBIUMeXrcJAkypqPSaWfo9c63
         HM+KMGZoSbbOJjCg3SqhtnQ/SN3HLdEyJyryW1QEzUIwSxqGRXAQbF9BUyDZVUBg6rMW
         iI4w==
X-Forwarded-Encrypted: i=1; AJvYcCVMgD1Sxmg8kvI/j4TjcDFIkI65ZFoQ/9sjor1u7xxEmmMGRCFjYzV59JU/oMwbSqDRqAOWyr53wh4QvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxF1tvE4cuVzhZuc274DIIZ/nOBXdjm1r57LOfEr8H+3S/kTvl
	ou0OpTXM96E+uGnaUHDkIIdRNIPA3NTpmZMTv43WvZHq6GT/S8b0kXO7InsKbYCVFpoDFvMXoJJ
	v+0jC1qlp9QQUmKeZGpsE1SGc+2lwcZU=
X-Gm-Gg: AZuq6aKjtSKXgBuNJHzmE+CJ2ADqeH8agRfGVMMiGNDD154poW3JGe30wiDZUYyii33
	39QTHCn3KanPVmGBBBJ1hpP45K3GCsy6br9QCHt7eRZ6+UukRqqMdHtx6fcEBpztrL5l6Rv2P5F
	XmyAy7CBQmtei0BiHXd+30gZmOt++6XIN7JlS7r3WjgUglEh4M/+UVr6qefPOk6LZmRuWMbl2Cs
	Jn41MkA2+A7hxttGKgpZxpqhUlNBSgGAR1AHLA7AjMj/7c4YsJvamgLe2HlFXe8vFiZWcuBzLvE
	0cDJ6XmP3aM=
X-Received: by 2002:a17:90a:ee88:b0:353:3f04:1b78 with SMTP id
 98e67ed59e1d1-353fecd096emr1737019a91.4.1769539890073; Tue, 27 Jan 2026
 10:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <697400dc.a70a0220.35de72.000a.GAE@google.com> <20260124113148.2398-1-hdanton@sina.com>
 <CAJuCfpEcqAiK-z=EZ5im12F2wfGHYogiMHaTC4t5uopLmBKQPw@mail.gmail.com>
 <CAJuCfpEJUeQcpfbh-0KTsp1UdTs5yrKTbvAV6QOKdQHJZ2HWww@mail.gmail.com> <CAJuCfpF_a=-kTZLdOzZpKrWhO2CyowwT+PdZ7_tP-cXxe23DiQ@mail.gmail.com>
In-Reply-To: <CAJuCfpF_a=-kTZLdOzZpKrWhO2CyowwT+PdZ7_tP-cXxe23DiQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Jan 2026 10:51:18 -0800
X-Gm-Features: AZwV_QiA0zOEZwy3CGiU5Z7PZD-Lu8x_VhA2pfyCwt-cEsRO07_OBuI3OkaSFLA
Message-ID: <CAEf4BzZxEVSFtu7uozpr-7NvRqt2WqjzmHrvQgG6TDoJQ9p_AQ@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in blkdev_read_iter
To: Suren Baghdasaryan <surenb@google.com>
Cc: Hillf Danton <hdanton@sina.com>, 
	syzbot <syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com>, axboe@kernel.dk, 
	linux-block@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 6:22=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Jan 26, 2026 at 2:33=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Mon, Jan 26, 2026 at 9:20=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Sat, Jan 24, 2026 at 3:32=E2=80=AFAM Hillf Danton <hdanton@sina.co=
m> wrote:
> > > >
> > > > Add Lorenzo and Suren
> > >
> > > Thanks!
> > >
> > > >
> > > > > Date: Fri, 23 Jan 2026 15:14:36 -0800
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    24d479d26b25 Linux 6.19-rc6
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10003=
3fa580000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D18594=
76832863c41
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D4e70c8e=
0a2017b432f7a
> > > > > compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GN=
U Binutils for Debian) 2.40
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D114=
51b9a580000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1045e=
852580000
> > > > >
> > > > > Downloadable assets:
> > > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-=
assets/d900f083ada3/non_bootable_disk-24d479d2.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/d0f3c47f686=
9/vmlinux-24d479d2.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/800231=
513703/bzImage-24d479d2.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to =
the commit:
> > > > > Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.co=
m
> > > > >
> > > > > WARNING: possible circular locking dependency detected
> > > > > syzkaller #0 Not tainted
> > > > > ------------------------------------------------------
> > > > > syz.0.17/6091 is trying to acquire lock:
> > > > > ffff8881061287a8 (
> > > > > &sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock_shared in=
clude/linux/fs.h:1042 [inline]
> > > > > &sb->s_type->i_mutex_key#8){++++}-{4:4}, at: blkdev_read_iter+0x1=
9e/0x500 block/fops.c:855
> > > > >
> > > > > but task is already holding lock:
> > > > > ffff888012aa0448 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x10e/0=
xed0 mm/mmap_lock.c:334
> > > > >
> > > > > which lock already depends on the new lock.
> > > > >
> > > > >
> > > > > the existing dependency chain (in reverse order) is:
> > > > >
> > > > > -> #2 (vm_lock){++++}-{0:0}:
> > > > >        __vma_enter_locked+0x260/0x770 mm/mmap_lock.c:72
> > > > >        __vma_start_write+0x21/0x160 mm/mmap_lock.c:104
> > > > >        vma_start_write include/linux/mmap_lock.h:213 [inline]
> > > > >        mprotect_fixup+0x4e3/0xb80 mm/mprotect.c:768
> > > > >        setup_arg_pages+0x4a2/0xbb0 fs/exec.c:670
> > > > >        load_elf_binary+0xb5b/0x4fe0 fs/binfmt_elf.c:1028
> > > > >        search_binary_handler fs/exec.c:1669 [inline]
> > > > >        exec_binprm fs/exec.c:1701 [inline]
> > > > >        bprm_execve fs/exec.c:1753 [inline]
> > > > >        bprm_execve+0x8c2/0x1620 fs/exec.c:1729
> > > > >        kernel_execve+0x2ef/0x3b0 fs/exec.c:1919
> > > > >        try_to_run_init_process init/main.c:1506 [inline]
> > > > >        kernel_init+0x14a/0x2b0 init/main.c:1634
> > > > >        ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
> > > > >        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> > > > >
> > > > > -> #1 (&mm->mmap_lock){++++}-{4:4}:
> > > > >        __might_fault mm/memory.c:7174 [inline]
> > > > >        __might_fault+0x113/0x190 mm/memory.c:7168
> > > > >        _copy_to_iter+0x1c2/0x1710 lib/iov_iter.c:196
> > > > >        copy_page_to_iter lib/iov_iter.c:374 [inline]
> > > > >        copy_page_to_iter+0x12a/0x1e0 lib/iov_iter.c:361
> > > > >        copy_folio_to_iter include/linux/uio.h:204 [inline]
> > > > >        filemap_read+0x6b1/0xe40 mm/filemap.c:2851
> > > > >        blkdev_read_iter+0x1ac/0x500 block/fops.c:856
> > > > >        new_sync_read fs/read_write.c:491 [inline]
> > > > >        vfs_read+0x8bf/0xcf0 fs/read_write.c:572
> > > > >        ksys_read+0x12a/0x250 fs/read_write.c:715
> > > > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > > >        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> > > > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > >
> > > > > -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> > > > >        check_prev_add kernel/locking/lockdep.c:3165 [inline]
> > > > >        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> > > > >        validate_chain kernel/locking/lockdep.c:3908 [inline]
> > > > >        __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
> > > > >        lock_acquire kernel/locking/lockdep.c:5868 [inline]
> > > > >        lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
> > > > >        down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
> > > > >        inode_lock_shared include/linux/fs.h:1042 [inline]
> > > > >        blkdev_read_iter+0x19e/0x500 block/fops.c:855
> > > > >        __kernel_read+0x3f3/0xbf0 fs/read_write.c:530
> > > > >        freader_fetch+0x1d7/0x9d0 lib/buildid.c:100
> > > > >        __build_id_parse.isra.0+0xdd/0x6c0 lib/buildid.c:297
> > > > >        do_procmap_query+0xb0e/0x1080 fs/proc/task_mmu.c:733
> > > > >        procfs_procmap_ioctl+0x9d/0xe0 fs/proc/task_mmu.c:813
> > > > >        vfs_ioctl fs/ioctl.c:51 [inline]
> > > > >        __do_sys_ioctl fs/ioctl.c:597 [inline]
> > > > >        __se_sys_ioctl fs/ioctl.c:583 [inline]
> > > > >        __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> > > > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > > >        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> > > > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > >
> > >
> > > It looks like:
> > > #0 is executing PROCMAP_QUERY ioclt, read-locks vm_lock and then call=
s
> > > build_id_parse()->__build_id_parse(...,
> > > may_fault=3Dtrue)->__kernel_read() which eventually takes
> > > inode->i_rwsem.
> > > #1 is a file-backed page fault which asserts that it might take
> > > mmap_lock for read.
> > > #2 is load_elf_binary()->mprotect_fixup() which write-locks both
> > > mmap_lock and vm_lock. I'm guessing it already holds inode->i_rwsem
> > > before write-locking these locks.
> > >
> > > Originally I thought the issue is most liley introduced in
> > > d9d1c2d81797 ("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under
> > > per-vma locks"). But if #2 indeed takes inode->i_rwsem before
> > > write-locking mmap_lock, then the problem should exist even before
> > > that change when we didn't use vm_lock and relied on mmap_lock...
> > >
> > > I'll try to analyze this more before attempting a fix.
> >
> > I was able to reproduce the same issue even after reverting
> > d9d1c2d81797. The deadlock in this case is simpler and involves
> > mmap_lock instead of vm_lock (see below).
> > Looks like the race is between the read() syscall and do_procmap_query(=
).
> > I'll continue investigating, in the meantime CC'ing Andrii.
>
> So, here is a cleaner version of that report (with d9d1c2d81797 reverted)=
:
>
>  -> #1 (&mm->mmap_lock){++++}-{4:4}:
>         __might_fault+0xed/0x170
>         _copy_to_iter+0x118/0x1720
>         copy_page_to_iter+0x12d/0x1e0
>         filemap_read+0x720/0x10a0
>         blkdev_read_iter+0x2b5/0x4e0
>         vfs_read+0x7f4/0xae0
>         ksys_read+0x12a/0x250
>         do_syscall_64+0xcb/0xf80
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
>         __lock_acquire+0x1509/0x26d0
>         lock_acquire+0x185/0x340
>         down_read+0x98/0x490
>         blkdev_read_iter+0x2a7/0x4e0
>         __kernel_read+0x39a/0xa90
>         freader_fetch+0x1d5/0xa80
>         __build_id_parse.isra.0+0xea/0x6a0
>         do_procmap_query+0xd75/0x1050
>         procfs_procmap_ioctl+0x7a/0xb0
>         __x64_sys_ioctl+0x18e/0x210
>         do_syscall_64+0xcb/0xf80
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  other info that might help us debug this:
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    rlock(&mm->mmap_lock);
>                                 lock(&sb->s_type->i_mutex_key#8);
>                                 lock(&mm->mmap_lock);
>    rlock(&sb->s_type->i_mutex_key#8);
>
>   *** DEADLOCK ***
>
> Both threads are calling blkdev_read_iter(), which uses
> inode_lock_shared() to read-lock inode->i_rwsem. I'm not sure why CPU1
> shows lock() instead of rlock(). So both threads read-lock
> inode->i_rwsem and mmap_lock but in a different order. IIUC, with
> read-locks this should not deadlock until some other thread
> write-locks the mmap_lock in between and this becomes a real deadlock:
>
>         CPU0       CPU1         CPU2
>         ----       ----         ----
>    rlock(&mm->mmap_lock);
>                                 rlock(&sb->s_type->i_mutex_key#8);
>                    wlock(&mm->mmap_lock) <-- waiting for CPU0
>                                 rlock(&mm->mmap_lock); <-- waiting for CP=
U1
>    rlock(&sb->s_type->i_mutex_key#8); <-- waiting for CPU2
>
> I believe in the original report this write-locking thread was the one
> calling mprotect_fixup().
>
> Per https://docs.kernel.org/mm/process_addrs.html#lock-ordering,
> inode->i_rwsem should be locked before mm->mmap_lock, so
> procfs_procmap_ioctl() has to be fixed to follow this lock ordering.
> One possibility I can think of is to use build_id_parse_nofault()
> first and if it fails because the required page is not faulted, we do
> freader_init_from_file(), then drop the mmap/vma lock and execute
> freader_fetch() outside of these locks to fault in that page. Once
> that's done, we'll retry the whole operation and this time
> build_id_parse_nofault() should pass (unless we already evicted that
> page, which is extremely unlikely and in that case, we'll retry
> again).
>
> I tried a POC with build_id_parse_nofault() but without the whole
> dance with freader_init_from_file/freader_fetch and the deadlock is
> gone. Andrii, WDYT?

I don't like it :) Too much complexity, _nofault() variant only makes
sense for BPF in non-sleepable contexts. I think this can be fixed
simpler and cleaner. We don't need to hold VMA lock while fetching
build ID. Build ID works with vma's vm_file, so we can just get its
reference, drop vma lock, then fetch build id. Below diff passes our
BPF selftests. Might need to think about a bit leaner code changes,
but the idea should be clear. Diff below will be butchered by gmail,
but you can fetch it at [0]. Do you mind validating that deadlock is
gone? Thanks!

[0] https://git.kernel.org/pub/scm/linux/kernel/git/andrii/bpf-next.git/com=
mit/?h=3Dprocmap-query-vma-deadlock-fix&id=3D7faf95b63a8a7ac6e78b6d90101c94=
bfa6ecdfd1

Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Tue Jan 27 10:46:04 2026 -0800

    procfs: avoid fetching build ID while holding VMA lock

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 81dfc26bfae8..564bf82e3731 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -656,6 +656,7 @@ static int do_procmap_query(struct mm_struct *mm,
void __user *uarg)
        struct proc_maps_locking_ctx lock_ctx =3D { .mm =3D mm };
        struct procmap_query karg;
        struct vm_area_struct *vma;
+       struct file *vm_file =3D NULL;
        const char *name =3D NULL;
        char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf =3D NULL;
        __u64 usize;
@@ -720,6 +721,9 @@ static int do_procmap_query(struct mm_struct *mm,
void __user *uarg)
                karg.dev_major =3D MAJOR(inode->i_sb->s_dev);
                karg.dev_minor =3D MINOR(inode->i_sb->s_dev);
                karg.inode =3D inode->i_ino;
+
+               if (karg.build_id_size)
+                       vm_file =3D get_file(vma->vm_file);
        } else {
                karg.vma_offset =3D 0;
                karg.dev_major =3D 0;
@@ -727,21 +731,6 @@ static int do_procmap_query(struct mm_struct *mm,
void __user *uarg)
                karg.inode =3D 0;
        }

-       if (karg.build_id_size) {
-               __u32 build_id_sz;
-
-               err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
-               if (err) {
-                       karg.build_id_size =3D 0;
-               } else {
-                       if (karg.build_id_size < build_id_sz) {
-                               err =3D -ENAMETOOLONG;
-                               goto out;
-                       }
-                       karg.build_id_size =3D build_id_sz;
-               }
-       }
-
        if (karg.vma_name_size) {
                size_t name_buf_sz =3D min_t(size_t, PATH_MAX,
karg.vma_name_size);
                const struct path *path;
@@ -779,6 +768,28 @@ static int do_procmap_query(struct mm_struct *mm,
void __user *uarg)
        query_vma_teardown(&lock_ctx);
        mmput(mm);

+       if (karg.build_id_size) {
+               __u32 build_id_sz;
+
+               err =3D -ENOENT;
+               if (vm_file)
+                       err =3D build_id_parse_file(vm_file,
build_id_buf, &build_id_sz);
+               if (err) {
+                       karg.build_id_size =3D 0;
+               } else {
+                       if (karg.build_id_size < build_id_sz) {
+                               err =3D -ENAMETOOLONG;
+                               goto out;
+                       }
+                       karg.build_id_size =3D build_id_sz;
+               }
+       }
+
+       if (vm_file) {
+               fput(vm_file);
+               vm_file =3D NULL;
+       }
+
        if (karg.vma_name_size &&
copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
                                               name, karg.vma_name_size)) {
                kfree(name_buf);
@@ -797,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm,
void __user *uarg)

 out:
        query_vma_teardown(&lock_ctx);
+       if (vm_file)
+               fput(vm_file);
        mmput(mm);
        kfree(name_buf);
        return err;
diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 831c1b4b626c..7acc06b22fb7 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -7,7 +7,10 @@
 #define BUILD_ID_SIZE_MAX 20

 struct vm_area_struct;
+struct file;
+
 int build_id_parse(struct vm_area_struct *vma, unsigned char
*build_id, __u32 *size);
+int build_id_parse_file(struct file *file, unsigned char *build_id,
__u32 *size);
 int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char
*build_id, __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_s=
ize);

diff --git a/lib/buildid.c b/lib/buildid.c
index aaf61dfc0919..c0002129d526 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -271,7 +271,7 @@ static int get_build_id_64(struct freader *r,
unsigned char *build_id, __u32 *si
 /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
 #define MAX_FREADER_BUF_SZ 64

-static int __build_id_parse(struct vm_area_struct *vma, unsigned char
*build_id,
+static int __build_id_parse(struct file *file, unsigned char *build_id,
                            __u32 *size, bool may_fault)
 {
        const Elf32_Ehdr *ehdr;
@@ -279,11 +279,7 @@ static int __build_id_parse(struct vm_area_struct
*vma, unsigned char *build_id,
        char buf[MAX_FREADER_BUF_SZ];
        int ret;

-       /* only works for page backed storage  */
-       if (!vma->vm_file)
-               return -EINVAL;
-
-       freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_faul=
t);
+       freader_init_from_file(&r, buf, sizeof(buf), file, may_fault);

        /* fetch first 18 bytes of ELF header for checks */
        ehdr =3D freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
@@ -324,7 +320,11 @@ static int __build_id_parse(struct vm_area_struct
*vma, unsigned char *build_id,
  */
 int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char
*build_id, __u32 *size)
 {
-       return __build_id_parse(vma, build_id, size, false /* !may_fault */=
);
+       /* only works for page backed storage  */
+       if (!vma->vm_file)
+               return -EINVAL;
+
+       return __build_id_parse(vma->vm_file, build_id, size, false /*
!may_fault */);
 }

 /*
@@ -340,7 +340,16 @@ int build_id_parse_nofault(struct vm_area_struct
*vma, unsigned char *build_id,
  */
 int build_id_parse(struct vm_area_struct *vma, unsigned char
*build_id, __u32 *size)
 {
-       return __build_id_parse(vma, build_id, size, true /* may_fault */);
+       /* only works for page backed storage  */
+       if (!vma->vm_file)
+               return -EINVAL;
+
+       return __build_id_parse(vma->vm_file, build_id, size, true /*
may_fault */);
+}
+
+int build_id_parse_file(struct file *file, unsigned char *build_id,
__u32 *size)
+{
+       return __build_id_parse(file, build_id, size, true /* may_fault */)=
;
 }

 /**


>
> >
> > [   62.320932][ T9229]
> > [   62.321471][ T9229] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   62.323016][ T9229] WARNING: possible circular locking dependency de=
tected
> > [   62.324618][ T9229] 6.19.0-rc6-00001-g40bea6261b2a #42 Not tainted
> > [   62.326013][ T9229] ------------------------------------------------=
------
> > [   62.327560][ T9229] hillf/9229 is trying to acquire lock:
> > [   62.328821][ T9229] ffff888145b7b5a8
> > (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at:
> > blkdev_read_iter+0x2a7/0x4e0
> > [   62.331102][ T9229]
> > [   62.331102][ T9229] but task is already holding lock:
> > [   62.332722][ T9229] ffff888183a6e540 (&mm->mmap_lock){++++}-{4:4},
> > at: do_procmap_query+0x39f/0x1050
> > [   62.334795][ T9229]
> > [   62.334795][ T9229] which lock already depends on the new lock.
> > [   62.334795][ T9229]
> > [   62.337072][ T9229]
> > [   62.337072][ T9229] the existing dependency chain (in reverse order)=
 is:
> > [   62.338998][ T9229]
> > [   62.338998][ T9229] -> #1 (&mm->mmap_lock){++++}-{4:4}:
> > [   62.340646][ T9229]        __might_fault+0xed/0x170
> > [   62.341763][ T9229]        _copy_to_iter+0x118/0x1720
> > [   62.342913][ T9229]        copy_page_to_iter+0x12d/0x1e0
> > [   62.344167][ T9229]        filemap_read+0x720/0x10a0
> > [   62.345298][ T9229]        blkdev_read_iter+0x2b5/0x4e0
> > [   62.346480][ T9229]        vfs_read+0x7f4/0xae0
> > [   62.347518][ T9229]        ksys_read+0x12a/0x250
> > [   62.348584][ T9229]        do_syscall_64+0xcb/0xf80
> > [   62.349707][ T9229]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [   62.351116][ T9229]
> > [   62.351116][ T9229] -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> > [   62.353012][ T9229]        __lock_acquire+0x1509/0x26d0
> > [   62.354213][ T9229]        lock_acquire+0x185/0x340
> > [   62.355323][ T9229]        down_read+0x98/0x490
> > [   62.356441][ T9229]        blkdev_read_iter+0x2a7/0x4e0
> > [   62.357619][ T9229]        __kernel_read+0x39a/0xa90
> > [   62.358767][ T9229]        freader_fetch+0x1d5/0xa80
> > [   62.359927][ T9229]        __build_id_parse.isra.0+0xea/0x6a0
> > [   62.361232][ T9229]        do_procmap_query+0xd75/0x1050
> > [   62.362434][ T9229]        procfs_procmap_ioctl+0x7a/0xb0
> > [   62.363687][ T9229]        __x64_sys_ioctl+0x18e/0x210
> > [   62.364863][ T9229]        do_syscall_64+0xcb/0xf80
> > [   62.365977][ T9229]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [   62.367394][ T9229]
> > [   62.367394][ T9229] other info that might help us debug this:
> > [   62.367394][ T9229]
> > [   62.369637][ T9229]  Possible unsafe locking scenario:
> > [   62.369637][ T9229]
> > [   62.371237][ T9229]        CPU0                    CPU1
> > [   62.372441][ T9229]        ----                    ----
> > [   62.373687][ T9229]   rlock(&mm->mmap_lock);
> > [   62.374688][ T9229]
> > lock(&sb->s_type->i_mutex_key#8);
> > [   62.376444][ T9229]                                lock(&mm->mmap_lo=
ck);
> > [   62.377956][ T9229]   rlock(&sb->s_type->i_mutex_key#8);
> > [   62.379165][ T9229]
> > [   62.379165][ T9229]  *** DEADLOCK ***
> > [   62.379165][ T9229]
> > [   62.380952][ T9229] 1 lock held by hillf/9229:
> > [   62.381971][ T9229]  #0: ffff888183a6e540
> > (&mm->mmap_lock){++++}-{4:4}, at: do_procmap_query+0x39f/0x1050
> > [   62.384162][ T9229]
> > [   62.384162][ T9229] stack backtrace:
> > [   62.385458][ T9229] CPU: 3 UID: 0 PID: 9229 Comm: hillf Not tainted
> > 6.19.0-rc6-00001-g40bea6261b2a #42 PREEMPT(full)
> > [   62.385471][ T9229] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> > [   62.385477][ T9229] Call Trace:
> > [   62.385482][ T9229]  <TASK>
> > [   62.385487][ T9229]  dump_stack_lvl+0x100/0x190
> > [   62.385505][ T9229]  print_circular_bug.cold+0x185/0x1d5
> > [   62.385521][ T9229]  check_noncircular+0x14a/0x170
> > [   62.385534][ T9229]  __lock_acquire+0x1509/0x26d0
> > [   62.385547][ T9229]  lock_acquire+0x185/0x340
> > [   62.385557][ T9229]  ? blkdev_read_iter+0x2a7/0x4e0
> > [   62.385569][ T9229]  ? __pfx___might_resched+0x10/0x10
> > [   62.385583][ T9229]  down_read+0x98/0x490
> > [   62.385593][ T9229]  ? blkdev_read_iter+0x2a7/0x4e0
> > [   62.385603][ T9229]  ? __pfx_down_read+0x10/0x10
> > [   62.385612][ T9229]  ? lock_acquire+0x185/0x340
> > [   62.385622][ T9229]  ? is_bpf_text_address+0x25/0x1a0
> > [   62.385634][ T9229]  blkdev_read_iter+0x2a7/0x4e0
> > [   62.385645][ T9229]  __kernel_read+0x39a/0xa90
> > [   62.385658][ T9229]  ? __pfx___kernel_read+0x10/0x10
> > [   62.385671][ T9229]  ? __lock_acquire+0x481/0x26d0
> > [   62.385683][ T9229]  freader_fetch+0x1d5/0xa80
> > [   62.385697][ T9229]  ? find_held_lock+0x2b/0x80
> > [   62.385712][ T9229]  ? __pfx_freader_fetch+0x10/0x10
> > [   62.385725][ T9229]  ? __asan_memset+0x27/0x50
> > [   62.385737][ T9229]  __build_id_parse.isra.0+0xea/0x6a0
> > [   62.385751][ T9229]  ? __pfx___build_id_parse.isra.0+0x10/0x10
> > [   62.385766][ T9229]  ? __pfx_find_vma+0x10/0x10
> > [   62.385774][ T9229]  ? __might_fault+0x129/0x170
> > [   62.385788][ T9229]  do_procmap_query+0xd75/0x1050
> > [   62.385798][ T9229]  ? __pfx_do_procmap_query+0x10/0x10
> > [   62.385807][ T9229]  ? __sanitizer_cov_trace_switch+0x53/0x90
> > [   62.385817][ T9229]  ? do_vfs_ioctl+0x226/0x13b0
> > [   62.385828][ T9229]  ? __pfx_do_vfs_ioctl+0x10/0x10
> > [   62.385839][ T9229]  ? putname+0xfc/0x1b0
> > [   62.385846][ T9229]  ? putname+0x101/0x1b0
> > [   62.385857][ T9229]  ? __x64_sys_openat+0x143/0x210
> > [   62.385867][ T9229]  procfs_procmap_ioctl+0x7a/0xb0
> > [   62.385877][ T9229]  ? __pfx_procfs_procmap_ioctl+0x10/0x10
> > [   62.385888][ T9229]  __x64_sys_ioctl+0x18e/0x210
> > [   62.385899][ T9229]  do_syscall_64+0xcb/0xf80
> > [   62.385913][ T9229]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [   62.385923][ T9229] RIP: 0033:0x412209
> > [   62.385931][ T9229] Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f
> > 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> > 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8
> > 64 89 01 48
> > [   62.385940][ T9229] RSP: 002b:00007fff380d5588 EFLAGS: 00000217
> > ORIG_RAX: 0000000000000010
> > [   62.385950][ T9229] RAX: ffffffffffffffda RBX: 00007fff380d56c8
> > RCX: 0000000000412209
> > [   62.385956][ T9229] RDX: 0000200000000180 RSI: 00000000c0686611
> > RDI: 0000000000000004
> > [   62.385962][ T9229] RBP: 00007fff380d55a0 R08: 0000000000000000
> > R09: 00007fff380d5640
> > [   62.385968][ T9229] R10: 0000000000000000 R11: 0000000000000217
> > R12: 00007fff380d56b8
> > [   62.385974][ T9229] R13: 0000000000000002 R14: 00000000004a0e40
> > R15: 0000000000000002
> > [   62.385982][ T9229]  </TASK>
> >
> >
> >
> > >
> > > > > other info that might help us debug this:
> > > > >
> > > > > Chain exists of:
> > > > >   &sb->s_type->i_mutex_key#8 --> &mm->mmap_lock --> vm_lock
> > > > >
> > > > >  Possible unsafe locking scenario:
> > > > >
> > > > >        CPU0                    CPU1
> > > > >        ----                    ----
> > > > >   rlock(vm_lock);
> > > > >                                lock(&mm->mmap_lock);
> > > > >                                lock(vm_lock);
> > > > >   rlock(&sb->s_type->i_mutex_key#8);
> > > > >
> > > > >  *** DEADLOCK ***
> > > > >
> > > > > 1 lock held by syz.0.17/6091:
> > > > >  #0: ffff888012aa0448 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x=
10e/0xed0 mm/mmap_lock.c:334
> > > > >
> > > > > stack backtrace:
> > > > > CPU: 2 UID: 0 PID: 6091 Comm: syz.0.17 Not tainted syzkaller #0 P=
REEMPT(full)
> > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-d=
ebian-1.16.3-2~bpo12+1 04/01/2014
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __dump_stack lib/dump_stack.c:94 [inline]
> > > > >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> > > > >  print_circular_bug+0x275/0x340 kernel/locking/lockdep.c:2043
> > > > >  check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
> > > > >  check_prev_add kernel/locking/lockdep.c:3165 [inline]
> > > > >  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> > > > >  validate_chain kernel/locking/lockdep.c:3908 [inline]
> > > > >  __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
> > > > >  lock_acquire kernel/locking/lockdep.c:5868 [inline]
> > > > >  lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
> > > > >  down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
> > > > >  inode_lock_shared include/linux/fs.h:1042 [inline]
> > > > >  blkdev_read_iter+0x19e/0x500 block/fops.c:855
> > > > >  __kernel_read+0x3f3/0xbf0 fs/read_write.c:530
> > > > >  freader_fetch+0x1d7/0x9d0 lib/buildid.c:100
> > > > >  __build_id_parse.isra.0+0xdd/0x6c0 lib/buildid.c:297
> > > > >  do_procmap_query+0xb0e/0x1080 fs/proc/task_mmu.c:733
> > > > >  procfs_procmap_ioctl+0x9d/0xe0 fs/proc/task_mmu.c:813
> > > > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > > > >  __do_sys_ioctl fs/ioctl.c:597 [inline]
> > > > >  __se_sys_ioctl fs/ioctl.c:583 [inline]
> > > > >  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> > > > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > > >  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > RIP: 0033:0x7ff1a238f7c9
> > > > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d =
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > > > > RSP: 002b:00007ffebbe538b8 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00010
> > > > > RAX: ffffffffffffffda RBX: 00007ff1a25e5fa0 RCX: 00007ff1a238f7c9
> > > > > RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000004
> > > > > RBP: 00007ff1a2413f91 R08: 0000000000000000 R09: 0000000000000000
> > > > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > > > R13: 00007ff1a25e5fa0 R14: 00007ff1a25e5fa0 R15: 0000000000000003
> > > > >  </TASK>
