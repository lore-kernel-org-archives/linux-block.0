Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D83090CA
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466816; cv=pass; b=IHzjJx6jS5xgHaJm5Er2DI+WvyHeigmrXVCtO81sQu3ESWjQHgE6S4hxyKpsNLsHC0Lj7BGbtRn0PZgIxUmmcJODUszR0F77eTmEUn7x6VWpovrnI/xoOFXfG42p7XA+LdMFZ5vCi4guwcRNuN85D9iT1AhxZNn3y6rZSNOsef0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466816; c=relaxed/simple;
	bh=TViPj64sjo1o8+P1CIFaQ11hGldjJ+i9pH8rFSg2dxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMNPPltfnC+YcGkYnOTUA0r71aw6FutCLItGzA/righP3v77F+C7FLnb0lPztouXiYoRyAX9uDRjonomGOgrUfoz/NFJDvUjtxHVbqnPOfZDtHY4QaNIhKkg9cK4GNLIEqgK1KCUe3903BW/gTbchprgQNIPUrPhC/cahvnXBjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DiwFYazl; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiwFYazl"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014b5d8551so88791cf.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 14:33:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769466813; cv=none;
        d=google.com; s=arc-20240605;
        b=RX60u5CraY9BUJfkoXQXNq/uE2TpxKyjywugxyojzdxj21FrjRwkLgp7po09ZH1Sg5
         +/66ttFkWhyVSqAvS6+PiBdpYSbGMZOu+vNGAU9BuzXGewurhlo/m1Zanw8lFIydjt7S
         MtEVLPNSp/V5yBOB06raIpiXNQ7YAG16rqRFCl5CKVScKrzC4/XEQUsNII09L09/31gq
         9Gow0ftfcz7AZ2dmMVR3vxZVWAaSwCS7u/drhnxkH4FKCyUz3k5zwKuncg7TJVkbRi+/
         ttH40ivvMKv37nYtT/V0LI+41A7yY0wK5GeQMm0U6KmrEgIKnYD3xlcgN7+IZfP0vGXp
         +q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mackZotkIKvwV0WRbHOpinSiGL+O/1eaZatL1YEdROs=;
        fh=dX81sQ00qe/ezzG4nSXrhVRHPGtZundroj19aqsuUL8=;
        b=VnmuEDrD5drmJdr8zY6DzxXCa4iIQehL/WyK2kDiJz98+DbFEr6Un3AVdIPn6laqxS
         I9a3PP60pvq3OwAe5PGMLXLxJGAkR19Ik7iCePyGo8Tx7fNokWktEOmsZFHNd2jOGwi7
         XxjgSldMHQN687CqALov/iPTDqbfixrAbILGAlr/HuD0dqyw1rPJqn2dgE5HVNV2fqx0
         Simuk+kSS2N6Ps391qz9QUBXFEZlQIYn48KNmCIoTntsvyShRqBu3dcP+qWLmrCqyUlI
         OsTtq9AMOKSAQlrVK9BlzgnDewjdP37T2BA3MlokFmP7krCCBqCnNNFxpl80zYW56cvX
         eLJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769466813; x=1770071613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mackZotkIKvwV0WRbHOpinSiGL+O/1eaZatL1YEdROs=;
        b=DiwFYazli70ne+BRDC5C52/2AJ54MjC10y1T8eppiJXLT3tE7SO77LyDr9VJBv5JYG
         syRec4n31V+/OXWjxE1gt0ps7/5USVipji5zV4QYmrdXUSHrKMNltpE4t+J1sEPMwtl5
         jpAdJL26Jb2LCxq4uMooGhPQhTPq01Os0hk7ozbuNF8olLMGH2/R8DS81RaBJIhFBoGv
         J8eMvOFchpWB7xVcEWf0cdvYvHnh0DEtvT25/FXLSsofPFr50DjwVh3rKd/4sXEZnR1d
         XWGV7dpKLn4BjZOk2RUOBcEKZTp7ilQQ5x6CCf9EWns9rm1fwZPLNYEBlqEGMJyV4kj2
         KEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769466813; x=1770071613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mackZotkIKvwV0WRbHOpinSiGL+O/1eaZatL1YEdROs=;
        b=HIt95wBVBLXZBD46LGT1PgYpvAwxyM/Lufr0Q0/iw9Z0rQKVP0eF4iQrZ6AIl0T4JN
         aaTJZ2IONouaoGNAJ8to8caYVgvbX+ggCy2g/SbU1xWme5EcZ0pJrmVXD7brlvN2SMdQ
         l6ksaF/0gWfPVSgCE1Kp/da048xZv+PFHn//2IpvUgAxrJ9+RZuLo6+gr/1boKz7uaKC
         9lTXj7KT+EJCuO4MgglO+Qk/qVHUa0eXj6651FapjUv4oyyRBFUCcrOJkGYYfs4eJEA/
         r0FHxTittaV17TEk06aNgfYYo5+7Dgw7i6P+QDeAeIIHgGWFkTc2vFGCQpZW2SzNwfCe
         97kA==
X-Forwarded-Encrypted: i=1; AJvYcCVbYXSNZjILs53kqoEfAggLX1DXfZGDo+ZRTJIiegOTpeZFf1xTKTwzt6BKJ3/T92MZcDpJDQfQZDL/Pw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6J1llj7RBbapCqto65LNCdDIvjISdY5gS/KZF/KfwZAUfbwcN
	oVu/IKY31aQyq353qHYJOqxlDESgiLx9W0bCr+aRlFjJIBC3gUI8pqAY7VvbDVULltTXVHddDBo
	LpzGPzPmY6XZBMb2oh/xGH4u1fYOhrr7DZ6e4mJnxjDa/xE1qn1wL4NiOVY0=
X-Gm-Gg: AZuq6aIY/hQdoe3hewR1igrtGNEFlFBjpiMHz3YS2kBXXIJXF5aXkwTiuLLz7wFG87m
	VdJuw/0PF/GG363V1N8YX5QHttJfOEIuMXYcle54v5+OBMSOM6xLd/PSj2M8i4CmWzsq4DRF5Nt
	0L7Co2/0RaM7qAXAMOksYm4hlWdqQnxHw6mG+Nc0fyYIdVueD4jCAGFLO9sOF0U54c2V+4Jg8TW
	RxywcUC6O9IzwR4aVaNrS2gSdIsyq6vnqGqxg8I08ZJxr2LIOEMmFJxeDsHwo/i3HfKWw==
X-Received: by 2002:ac8:7e81:0:b0:4ed:70d6:6618 with SMTP id
 d75a77b69052e-5031434c53bmr5070331cf.10.1769466812800; Mon, 26 Jan 2026
 14:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <697400dc.a70a0220.35de72.000a.GAE@google.com> <20260124113148.2398-1-hdanton@sina.com>
 <CAJuCfpEcqAiK-z=EZ5im12F2wfGHYogiMHaTC4t5uopLmBKQPw@mail.gmail.com>
In-Reply-To: <CAJuCfpEcqAiK-z=EZ5im12F2wfGHYogiMHaTC4t5uopLmBKQPw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Jan 2026 14:33:21 -0800
X-Gm-Features: AZwV_QjG0HdzQ3mdcLwZReNt28tz9EkyAA5jdwVASXhwRJhBie71_qIvsEwDqNU
Message-ID: <CAJuCfpEJUeQcpfbh-0KTsp1UdTs5yrKTbvAV6QOKdQHJZ2HWww@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in blkdev_read_iter
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com>, axboe@kernel.dk, 
	linux-block@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 9:20=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sat, Jan 24, 2026 at 3:32=E2=80=AFAM Hillf Danton <hdanton@sina.com> w=
rote:
> >
> > Add Lorenzo and Suren
>
> Thanks!
>
> >
> > > Date: Fri, 23 Jan 2026 15:14:36 -0800
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    24d479d26b25 Linux 6.19-rc6
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D100033fa5=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D185947683=
2863c41
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D4e70c8e0a20=
17b432f7a
> > > compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Bi=
nutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11451b9=
a580000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1045e8525=
80000
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-asse=
ts/d900f083ada3/non_bootable_disk-24d479d2.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/d0f3c47f6869/vm=
linux-24d479d2.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/8002315137=
03/bzImage-24d479d2.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> > >
> > > WARNING: possible circular locking dependency detected
> > > syzkaller #0 Not tainted
> > > ------------------------------------------------------
> > > syz.0.17/6091 is trying to acquire lock:
> > > ffff8881061287a8 (
> > > &sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock_shared includ=
e/linux/fs.h:1042 [inline]
> > > &sb->s_type->i_mutex_key#8){++++}-{4:4}, at: blkdev_read_iter+0x19e/0=
x500 block/fops.c:855
> > >
> > > but task is already holding lock:
> > > ffff888012aa0448 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x10e/0xed0=
 mm/mmap_lock.c:334
> > >
> > > which lock already depends on the new lock.
> > >
> > >
> > > the existing dependency chain (in reverse order) is:
> > >
> > > -> #2 (vm_lock){++++}-{0:0}:
> > >        __vma_enter_locked+0x260/0x770 mm/mmap_lock.c:72
> > >        __vma_start_write+0x21/0x160 mm/mmap_lock.c:104
> > >        vma_start_write include/linux/mmap_lock.h:213 [inline]
> > >        mprotect_fixup+0x4e3/0xb80 mm/mprotect.c:768
> > >        setup_arg_pages+0x4a2/0xbb0 fs/exec.c:670
> > >        load_elf_binary+0xb5b/0x4fe0 fs/binfmt_elf.c:1028
> > >        search_binary_handler fs/exec.c:1669 [inline]
> > >        exec_binprm fs/exec.c:1701 [inline]
> > >        bprm_execve fs/exec.c:1753 [inline]
> > >        bprm_execve+0x8c2/0x1620 fs/exec.c:1729
> > >        kernel_execve+0x2ef/0x3b0 fs/exec.c:1919
> > >        try_to_run_init_process init/main.c:1506 [inline]
> > >        kernel_init+0x14a/0x2b0 init/main.c:1634
> > >        ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
> > >        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> > >
> > > -> #1 (&mm->mmap_lock){++++}-{4:4}:
> > >        __might_fault mm/memory.c:7174 [inline]
> > >        __might_fault+0x113/0x190 mm/memory.c:7168
> > >        _copy_to_iter+0x1c2/0x1710 lib/iov_iter.c:196
> > >        copy_page_to_iter lib/iov_iter.c:374 [inline]
> > >        copy_page_to_iter+0x12a/0x1e0 lib/iov_iter.c:361
> > >        copy_folio_to_iter include/linux/uio.h:204 [inline]
> > >        filemap_read+0x6b1/0xe40 mm/filemap.c:2851
> > >        blkdev_read_iter+0x1ac/0x500 block/fops.c:856
> > >        new_sync_read fs/read_write.c:491 [inline]
> > >        vfs_read+0x8bf/0xcf0 fs/read_write.c:572
> > >        ksys_read+0x12a/0x250 fs/read_write.c:715
> > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> > >        check_prev_add kernel/locking/lockdep.c:3165 [inline]
> > >        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> > >        validate_chain kernel/locking/lockdep.c:3908 [inline]
> > >        __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
> > >        lock_acquire kernel/locking/lockdep.c:5868 [inline]
> > >        lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
> > >        down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
> > >        inode_lock_shared include/linux/fs.h:1042 [inline]
> > >        blkdev_read_iter+0x19e/0x500 block/fops.c:855
> > >        __kernel_read+0x3f3/0xbf0 fs/read_write.c:530
> > >        freader_fetch+0x1d7/0x9d0 lib/buildid.c:100
> > >        __build_id_parse.isra.0+0xdd/0x6c0 lib/buildid.c:297
> > >        do_procmap_query+0xb0e/0x1080 fs/proc/task_mmu.c:733
> > >        procfs_procmap_ioctl+0x9d/0xe0 fs/proc/task_mmu.c:813
> > >        vfs_ioctl fs/ioctl.c:51 [inline]
> > >        __do_sys_ioctl fs/ioctl.c:597 [inline]
> > >        __se_sys_ioctl fs/ioctl.c:583 [inline]
> > >        __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
>
> It looks like:
> #0 is executing PROCMAP_QUERY ioclt, read-locks vm_lock and then calls
> build_id_parse()->__build_id_parse(...,
> may_fault=3Dtrue)->__kernel_read() which eventually takes
> inode->i_rwsem.
> #1 is a file-backed page fault which asserts that it might take
> mmap_lock for read.
> #2 is load_elf_binary()->mprotect_fixup() which write-locks both
> mmap_lock and vm_lock. I'm guessing it already holds inode->i_rwsem
> before write-locking these locks.
>
> Originally I thought the issue is most liley introduced in
> d9d1c2d81797 ("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under
> per-vma locks"). But if #2 indeed takes inode->i_rwsem before
> write-locking mmap_lock, then the problem should exist even before
> that change when we didn't use vm_lock and relied on mmap_lock...
>
> I'll try to analyze this more before attempting a fix.

I was able to reproduce the same issue even after reverting
d9d1c2d81797. The deadlock in this case is simpler and involves
mmap_lock instead of vm_lock (see below).
Looks like the race is between the read() syscall and do_procmap_query().
I'll continue investigating, in the meantime CC'ing Andrii.

[   62.320932][ T9229]
[   62.321471][ T9229] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   62.323016][ T9229] WARNING: possible circular locking dependency detect=
ed
[   62.324618][ T9229] 6.19.0-rc6-00001-g40bea6261b2a #42 Not tainted
[   62.326013][ T9229] ----------------------------------------------------=
--
[   62.327560][ T9229] hillf/9229 is trying to acquire lock:
[   62.328821][ T9229] ffff888145b7b5a8
(&sb->s_type->i_mutex_key#8){++++}-{4:4}, at:
blkdev_read_iter+0x2a7/0x4e0
[   62.331102][ T9229]
[   62.331102][ T9229] but task is already holding lock:
[   62.332722][ T9229] ffff888183a6e540 (&mm->mmap_lock){++++}-{4:4},
at: do_procmap_query+0x39f/0x1050
[   62.334795][ T9229]
[   62.334795][ T9229] which lock already depends on the new lock.
[   62.334795][ T9229]
[   62.337072][ T9229]
[   62.337072][ T9229] the existing dependency chain (in reverse order) is:
[   62.338998][ T9229]
[   62.338998][ T9229] -> #1 (&mm->mmap_lock){++++}-{4:4}:
[   62.340646][ T9229]        __might_fault+0xed/0x170
[   62.341763][ T9229]        _copy_to_iter+0x118/0x1720
[   62.342913][ T9229]        copy_page_to_iter+0x12d/0x1e0
[   62.344167][ T9229]        filemap_read+0x720/0x10a0
[   62.345298][ T9229]        blkdev_read_iter+0x2b5/0x4e0
[   62.346480][ T9229]        vfs_read+0x7f4/0xae0
[   62.347518][ T9229]        ksys_read+0x12a/0x250
[   62.348584][ T9229]        do_syscall_64+0xcb/0xf80
[   62.349707][ T9229]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   62.351116][ T9229]
[   62.351116][ T9229] -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
[   62.353012][ T9229]        __lock_acquire+0x1509/0x26d0
[   62.354213][ T9229]        lock_acquire+0x185/0x340
[   62.355323][ T9229]        down_read+0x98/0x490
[   62.356441][ T9229]        blkdev_read_iter+0x2a7/0x4e0
[   62.357619][ T9229]        __kernel_read+0x39a/0xa90
[   62.358767][ T9229]        freader_fetch+0x1d5/0xa80
[   62.359927][ T9229]        __build_id_parse.isra.0+0xea/0x6a0
[   62.361232][ T9229]        do_procmap_query+0xd75/0x1050
[   62.362434][ T9229]        procfs_procmap_ioctl+0x7a/0xb0
[   62.363687][ T9229]        __x64_sys_ioctl+0x18e/0x210
[   62.364863][ T9229]        do_syscall_64+0xcb/0xf80
[   62.365977][ T9229]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   62.367394][ T9229]
[   62.367394][ T9229] other info that might help us debug this:
[   62.367394][ T9229]
[   62.369637][ T9229]  Possible unsafe locking scenario:
[   62.369637][ T9229]
[   62.371237][ T9229]        CPU0                    CPU1
[   62.372441][ T9229]        ----                    ----
[   62.373687][ T9229]   rlock(&mm->mmap_lock);
[   62.374688][ T9229]
lock(&sb->s_type->i_mutex_key#8);
[   62.376444][ T9229]                                lock(&mm->mmap_lock);
[   62.377956][ T9229]   rlock(&sb->s_type->i_mutex_key#8);
[   62.379165][ T9229]
[   62.379165][ T9229]  *** DEADLOCK ***
[   62.379165][ T9229]
[   62.380952][ T9229] 1 lock held by hillf/9229:
[   62.381971][ T9229]  #0: ffff888183a6e540
(&mm->mmap_lock){++++}-{4:4}, at: do_procmap_query+0x39f/0x1050
[   62.384162][ T9229]
[   62.384162][ T9229] stack backtrace:
[   62.385458][ T9229] CPU: 3 UID: 0 PID: 9229 Comm: hillf Not tainted
6.19.0-rc6-00001-g40bea6261b2a #42 PREEMPT(full)
[   62.385471][ T9229] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[   62.385477][ T9229] Call Trace:
[   62.385482][ T9229]  <TASK>
[   62.385487][ T9229]  dump_stack_lvl+0x100/0x190
[   62.385505][ T9229]  print_circular_bug.cold+0x185/0x1d5
[   62.385521][ T9229]  check_noncircular+0x14a/0x170
[   62.385534][ T9229]  __lock_acquire+0x1509/0x26d0
[   62.385547][ T9229]  lock_acquire+0x185/0x340
[   62.385557][ T9229]  ? blkdev_read_iter+0x2a7/0x4e0
[   62.385569][ T9229]  ? __pfx___might_resched+0x10/0x10
[   62.385583][ T9229]  down_read+0x98/0x490
[   62.385593][ T9229]  ? blkdev_read_iter+0x2a7/0x4e0
[   62.385603][ T9229]  ? __pfx_down_read+0x10/0x10
[   62.385612][ T9229]  ? lock_acquire+0x185/0x340
[   62.385622][ T9229]  ? is_bpf_text_address+0x25/0x1a0
[   62.385634][ T9229]  blkdev_read_iter+0x2a7/0x4e0
[   62.385645][ T9229]  __kernel_read+0x39a/0xa90
[   62.385658][ T9229]  ? __pfx___kernel_read+0x10/0x10
[   62.385671][ T9229]  ? __lock_acquire+0x481/0x26d0
[   62.385683][ T9229]  freader_fetch+0x1d5/0xa80
[   62.385697][ T9229]  ? find_held_lock+0x2b/0x80
[   62.385712][ T9229]  ? __pfx_freader_fetch+0x10/0x10
[   62.385725][ T9229]  ? __asan_memset+0x27/0x50
[   62.385737][ T9229]  __build_id_parse.isra.0+0xea/0x6a0
[   62.385751][ T9229]  ? __pfx___build_id_parse.isra.0+0x10/0x10
[   62.385766][ T9229]  ? __pfx_find_vma+0x10/0x10
[   62.385774][ T9229]  ? __might_fault+0x129/0x170
[   62.385788][ T9229]  do_procmap_query+0xd75/0x1050
[   62.385798][ T9229]  ? __pfx_do_procmap_query+0x10/0x10
[   62.385807][ T9229]  ? __sanitizer_cov_trace_switch+0x53/0x90
[   62.385817][ T9229]  ? do_vfs_ioctl+0x226/0x13b0
[   62.385828][ T9229]  ? __pfx_do_vfs_ioctl+0x10/0x10
[   62.385839][ T9229]  ? putname+0xfc/0x1b0
[   62.385846][ T9229]  ? putname+0x101/0x1b0
[   62.385857][ T9229]  ? __x64_sys_openat+0x143/0x210
[   62.385867][ T9229]  procfs_procmap_ioctl+0x7a/0xb0
[   62.385877][ T9229]  ? __pfx_procfs_procmap_ioctl+0x10/0x10
[   62.385888][ T9229]  __x64_sys_ioctl+0x18e/0x210
[   62.385899][ T9229]  do_syscall_64+0xcb/0xf80
[   62.385913][ T9229]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   62.385923][ T9229] RIP: 0033:0x412209
[   62.385931][ T9229] Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f
44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8
64 89 01 48
[   62.385940][ T9229] RSP: 002b:00007fff380d5588 EFLAGS: 00000217
ORIG_RAX: 0000000000000010
[   62.385950][ T9229] RAX: ffffffffffffffda RBX: 00007fff380d56c8
RCX: 0000000000412209
[   62.385956][ T9229] RDX: 0000200000000180 RSI: 00000000c0686611
RDI: 0000000000000004
[   62.385962][ T9229] RBP: 00007fff380d55a0 R08: 0000000000000000
R09: 00007fff380d5640
[   62.385968][ T9229] R10: 0000000000000000 R11: 0000000000000217
R12: 00007fff380d56b8
[   62.385974][ T9229] R13: 0000000000000002 R14: 00000000004a0e40
R15: 0000000000000002
[   62.385982][ T9229]  </TASK>



>
> > > other info that might help us debug this:
> > >
> > > Chain exists of:
> > >   &sb->s_type->i_mutex_key#8 --> &mm->mmap_lock --> vm_lock
> > >
> > >  Possible unsafe locking scenario:
> > >
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   rlock(vm_lock);
> > >                                lock(&mm->mmap_lock);
> > >                                lock(vm_lock);
> > >   rlock(&sb->s_type->i_mutex_key#8);
> > >
> > >  *** DEADLOCK ***
> > >
> > > 1 lock held by syz.0.17/6091:
> > >  #0: ffff888012aa0448 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x10e/=
0xed0 mm/mmap_lock.c:334
> > >
> > > stack backtrace:
> > > CPU: 2 UID: 0 PID: 6091 Comm: syz.0.17 Not tainted syzkaller #0 PREEM=
PT(full)
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debia=
n-1.16.3-2~bpo12+1 04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:94 [inline]
> > >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> > >  print_circular_bug+0x275/0x340 kernel/locking/lockdep.c:2043
> > >  check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
> > >  check_prev_add kernel/locking/lockdep.c:3165 [inline]
> > >  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> > >  validate_chain kernel/locking/lockdep.c:3908 [inline]
> > >  __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
> > >  lock_acquire kernel/locking/lockdep.c:5868 [inline]
> > >  lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
> > >  down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
> > >  inode_lock_shared include/linux/fs.h:1042 [inline]
> > >  blkdev_read_iter+0x19e/0x500 block/fops.c:855
> > >  __kernel_read+0x3f3/0xbf0 fs/read_write.c:530
> > >  freader_fetch+0x1d7/0x9d0 lib/buildid.c:100
> > >  __build_id_parse.isra.0+0xdd/0x6c0 lib/buildid.c:297
> > >  do_procmap_query+0xb0e/0x1080 fs/proc/task_mmu.c:733
> > >  procfs_procmap_ioctl+0x9d/0xe0 fs/proc/task_mmu.c:813
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:597 [inline]
> > >  __se_sys_ioctl fs/ioctl.c:583 [inline]
> > >  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7ff1a238f7c9
> > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007ffebbe538b8 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
0
> > > RAX: ffffffffffffffda RBX: 00007ff1a25e5fa0 RCX: 00007ff1a238f7c9
> > > RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000004
> > > RBP: 00007ff1a2413f91 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 00007ff1a25e5fa0 R14: 00007ff1a25e5fa0 R15: 0000000000000003
> > >  </TASK>
