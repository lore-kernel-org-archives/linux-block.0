Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9122D060C
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480565; cv=pass; b=adtnpLkXGH+E4cM/Lkx3kwh/xtuwCd67Ej9w5dCiE6BnR1/06VMehV4+CM6psiahkNxl38OEuMV4nnM8vl7JYcwMeGWT8Ca49Hw/ucwEnrPPAsbHv3aPpnKCwVEixDefqzGft2CxAhCNX8rxVw0fKPA1+LAOteRlgl+AvDYFr2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480565; c=relaxed/simple;
	bh=FKVotkp388nrP8YXXBUj0wOInXxb3BxyaFj/l036Dp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhhMqJoH0SBalMGgEyAd8YCMOOUqH8x1dyqXV/wf1+d53HFwsne9kl/P4zOyGES/e1Avqh4j4e0vXP209436J2Z7PyZ7VIUV+/DjhM1xis44h1Cssc607jjv0F0qGNN4oxtv1jeGoQDQGxfKzBb/99FCdJ0doq2iuKYvEEDhs54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gPSmOZL; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gPSmOZL"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014acad6f2so157481cf.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 18:22:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769480562; cv=none;
        d=google.com; s=arc-20240605;
        b=kHbzP8Lgf7GENT1g00FercH1FxjQqrQASqXh0cfXYNKC1yP9/xDuOCJ4MOKwOJknOI
         OVdkzfqB2N3Pn2uQVkApZPuKGP3a/GwoQoYdXMNd/T9A7OaBhXlxbjFVlusUGGTmzUTC
         lGydJ0dL9x7Ez9p/Z9gBbK2cBBQMiW/081ZNZ55HBjKmg+lZ5S4G0Z0gkIrWDjKvreqv
         gf6F5EV7uRyBHCdJC6zHM34AEyhDaYUC46KTJpFIjV9fHrMu/82AUbsl/2o1a+bwyOnJ
         /FhpJedWHop2BniSSVpAFDgU+t+VCviTaGXPbMHM2eA8eNWJxYdzZKTyGSD/6MWCVFxT
         BrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OHSjF43OnNhZzIy1ezrcIZtPo8nY/C7yOJGwOUOyScY=;
        fh=xRuq2O3NvJ1fCAJHL3c+zczI9JCLIw/SddbtqcY8244=;
        b=jvDv7LYIBYs6CbCn5C79hwyz0CPIHex2sXo6ilCyLPScSexVNALNtDbNd36I5Hfgd7
         QttzHLfHWcf8zMBK079Wc/+FhwWA5EUx8V3D2E9TdqtGoNmUxJlD1kXtvFm6YKBcEdtU
         jz2dxKwRWOnHMqm9gUAVKZeuHEiyDPl/GChDHP9KCV3dADbHIvO6hFkt4i3z7wzdcisl
         dqEuS+5q0E3KC8DsRJp/PrVI7QUhTjBRmct6dUndszmz9VaM0NvlB2qNMA+KpZdCL8C6
         9qUVLe5V0tHZ06QN1rePgIjkekWqkjcibz911N72r5Q1MMBnWe+6JUmRfikMjmNjA+xT
         kF4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769480562; x=1770085362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHSjF43OnNhZzIy1ezrcIZtPo8nY/C7yOJGwOUOyScY=;
        b=2gPSmOZLp6ffn0GtjmjLcLsW3BBR5sja5eMc3CH6IHa7P01UEJKgMmxFTB8QkOQEi0
         dJTJMBQOEBrhrYfzBQ4Ygasf/kI3TFtaed03uDGrU3ci3S67W6xDXdxQSeSfPPvNOQbq
         d+HiO13O+4YkrDwoH/Z8c1ZSMJ+/X1KuTburu9b5UQi4zJB0icLlMoyBN15RKl+HcBWH
         Dml+6MC5VKWYuk0aC/83GMB7u9alQNR7L1JUwKPzMqKXkCHZcfHtT+QrIs6HnXHqjlKK
         U9dVsWbRjLZ20D141eFV8K3/Et1TAZMDjgQHaeUqcgfODNUpKWPvmxVOABuhN21oYXqu
         Jp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769480562; x=1770085362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OHSjF43OnNhZzIy1ezrcIZtPo8nY/C7yOJGwOUOyScY=;
        b=oogZ34/dcagVyTyNwvyrZOX6fNy+mZelB2XMR7IDKG/FXqHWaBVrfQwnr5X4RYzFqq
         XcUeBsTF1Rl5RbPWwWPDFsR27ruih+vl6vMGKM7CXf7hH5c40NgBRjNfXmTDNb3lQtXE
         48e4GP1LRaf7Rohr3VjoZRKlTvkOIBPQLUbxXtQQB283qE0/IACIB8l5HfTZATPmIzhF
         01xUAEHKOl2FsElq6F+nqVS55T4RBWylM/xtiNcZ6ryG7kbWWNY4i8a7OU+aW2couT5S
         s1fOh1vIujF4pUAZVcFQbVVxrJwjnH2SzlvqiopiHWPwew9x2jW5JT/JrvdHEHxrvS00
         w6yw==
X-Forwarded-Encrypted: i=1; AJvYcCUiUtGpJxQPKJ+TvCDGLDzxj/SST13M+C0d8Sf2uEG/TatzwLq0Qq+9IG07C8Omjl5CXLwaUqZygXGjLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmT06IwEjcIUPp6idbC5L4ZPzOoOCiWQYOwHzrD4Rv0BGiBntz
	nxCsC0/KWNXEmWkmg1EqX6SwbI7AU7LfnJQSJXkeotP3n0wOzXWiFKJs6KqWaP4bpMlOeVi8eJz
	egeQYX4YzTbKVy4cOFp7MV+38GvuGPqz51SQfEzdm
X-Gm-Gg: AZuq6aLVBM4keepsegwqLq8K5UC9ZmV3nBKA7iNVy3OcPD+EhCs1iR6FexXOyJ45ouZ
	8ZR6qRKut2a+vh78ar3LgMnIAXTpEYt9KwNWckzE0hWBzJDiA5M9C9jTVITcKcGJvCLU0M06m8v
	PYNUS4oG80xTsuaSGHBkA3/YYyxTLlGa/cWGI1OQKG9I0ht6p9DFNbZ8e/8vulxC0AQ+d7GNOmo
	aQY1ZtAKnCVldgXRrcSFm1hf7k36Le7dVE6ohE1KcQz/oRQAZ1ATdxi3d6DyAugGoQIaw==
X-Received: by 2002:ac8:5801:0:b0:502:f07e:854c with SMTP id
 d75a77b69052e-5032f4543d7mr900961cf.6.1769480561647; Mon, 26 Jan 2026
 18:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <697400dc.a70a0220.35de72.000a.GAE@google.com> <20260124113148.2398-1-hdanton@sina.com>
 <CAJuCfpEcqAiK-z=EZ5im12F2wfGHYogiMHaTC4t5uopLmBKQPw@mail.gmail.com> <CAJuCfpEJUeQcpfbh-0KTsp1UdTs5yrKTbvAV6QOKdQHJZ2HWww@mail.gmail.com>
In-Reply-To: <CAJuCfpEJUeQcpfbh-0KTsp1UdTs5yrKTbvAV6QOKdQHJZ2HWww@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Jan 2026 18:22:30 -0800
X-Gm-Features: AZwV_QhgBEFhB5JcSIaENdWQmwwSZMM99HLcmA66zN-PUgOjFXKx_NbR2gAH7bo
Message-ID: <CAJuCfpF_a=-kTZLdOzZpKrWhO2CyowwT+PdZ7_tP-cXxe23DiQ@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in blkdev_read_iter
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com>, axboe@kernel.dk, 
	linux-block@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 2:33=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Jan 26, 2026 at 9:20=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Sat, Jan 24, 2026 at 3:32=E2=80=AFAM Hillf Danton <hdanton@sina.com>=
 wrote:
> > >
> > > Add Lorenzo and Suren
> >
> > Thanks!
> >
> > >
> > > > Date: Fri, 23 Jan 2026 15:14:36 -0800
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    24d479d26b25 Linux 6.19-rc6
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D100033f=
a580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1859476=
832863c41
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D4e70c8e0a=
2017b432f7a
> > > > compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU =
Binutils for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11451=
b9a580000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1045e85=
2580000
> > > >
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-as=
sets/d900f083ada3/non_bootable_disk-24d479d2.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/d0f3c47f6869/=
vmlinux-24d479d2.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/80023151=
3703/bzImage-24d479d2.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> > > >
> > > > WARNING: possible circular locking dependency detected
> > > > syzkaller #0 Not tainted
> > > > ------------------------------------------------------
> > > > syz.0.17/6091 is trying to acquire lock:
> > > > ffff8881061287a8 (
> > > > &sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock_shared incl=
ude/linux/fs.h:1042 [inline]
> > > > &sb->s_type->i_mutex_key#8){++++}-{4:4}, at: blkdev_read_iter+0x19e=
/0x500 block/fops.c:855
> > > >
> > > > but task is already holding lock:
> > > > ffff888012aa0448 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x10e/0xe=
d0 mm/mmap_lock.c:334
> > > >
> > > > which lock already depends on the new lock.
> > > >
> > > >
> > > > the existing dependency chain (in reverse order) is:
> > > >
> > > > -> #2 (vm_lock){++++}-{0:0}:
> > > >        __vma_enter_locked+0x260/0x770 mm/mmap_lock.c:72
> > > >        __vma_start_write+0x21/0x160 mm/mmap_lock.c:104
> > > >        vma_start_write include/linux/mmap_lock.h:213 [inline]
> > > >        mprotect_fixup+0x4e3/0xb80 mm/mprotect.c:768
> > > >        setup_arg_pages+0x4a2/0xbb0 fs/exec.c:670
> > > >        load_elf_binary+0xb5b/0x4fe0 fs/binfmt_elf.c:1028
> > > >        search_binary_handler fs/exec.c:1669 [inline]
> > > >        exec_binprm fs/exec.c:1701 [inline]
> > > >        bprm_execve fs/exec.c:1753 [inline]
> > > >        bprm_execve+0x8c2/0x1620 fs/exec.c:1729
> > > >        kernel_execve+0x2ef/0x3b0 fs/exec.c:1919
> > > >        try_to_run_init_process init/main.c:1506 [inline]
> > > >        kernel_init+0x14a/0x2b0 init/main.c:1634
> > > >        ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
> > > >        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> > > >
> > > > -> #1 (&mm->mmap_lock){++++}-{4:4}:
> > > >        __might_fault mm/memory.c:7174 [inline]
> > > >        __might_fault+0x113/0x190 mm/memory.c:7168
> > > >        _copy_to_iter+0x1c2/0x1710 lib/iov_iter.c:196
> > > >        copy_page_to_iter lib/iov_iter.c:374 [inline]
> > > >        copy_page_to_iter+0x12a/0x1e0 lib/iov_iter.c:361
> > > >        copy_folio_to_iter include/linux/uio.h:204 [inline]
> > > >        filemap_read+0x6b1/0xe40 mm/filemap.c:2851
> > > >        blkdev_read_iter+0x1ac/0x500 block/fops.c:856
> > > >        new_sync_read fs/read_write.c:491 [inline]
> > > >        vfs_read+0x8bf/0xcf0 fs/read_write.c:572
> > > >        ksys_read+0x12a/0x250 fs/read_write.c:715
> > > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> > > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> > > >        check_prev_add kernel/locking/lockdep.c:3165 [inline]
> > > >        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> > > >        validate_chain kernel/locking/lockdep.c:3908 [inline]
> > > >        __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
> > > >        lock_acquire kernel/locking/lockdep.c:5868 [inline]
> > > >        lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
> > > >        down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
> > > >        inode_lock_shared include/linux/fs.h:1042 [inline]
> > > >        blkdev_read_iter+0x19e/0x500 block/fops.c:855
> > > >        __kernel_read+0x3f3/0xbf0 fs/read_write.c:530
> > > >        freader_fetch+0x1d7/0x9d0 lib/buildid.c:100
> > > >        __build_id_parse.isra.0+0xdd/0x6c0 lib/buildid.c:297
> > > >        do_procmap_query+0xb0e/0x1080 fs/proc/task_mmu.c:733
> > > >        procfs_procmap_ioctl+0x9d/0xe0 fs/proc/task_mmu.c:813
> > > >        vfs_ioctl fs/ioctl.c:51 [inline]
> > > >        __do_sys_ioctl fs/ioctl.c:597 [inline]
> > > >        __se_sys_ioctl fs/ioctl.c:583 [inline]
> > > >        __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> > > >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >        do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> > > >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> >
> > It looks like:
> > #0 is executing PROCMAP_QUERY ioclt, read-locks vm_lock and then calls
> > build_id_parse()->__build_id_parse(...,
> > may_fault=3Dtrue)->__kernel_read() which eventually takes
> > inode->i_rwsem.
> > #1 is a file-backed page fault which asserts that it might take
> > mmap_lock for read.
> > #2 is load_elf_binary()->mprotect_fixup() which write-locks both
> > mmap_lock and vm_lock. I'm guessing it already holds inode->i_rwsem
> > before write-locking these locks.
> >
> > Originally I thought the issue is most liley introduced in
> > d9d1c2d81797 ("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under
> > per-vma locks"). But if #2 indeed takes inode->i_rwsem before
> > write-locking mmap_lock, then the problem should exist even before
> > that change when we didn't use vm_lock and relied on mmap_lock...
> >
> > I'll try to analyze this more before attempting a fix.
>
> I was able to reproduce the same issue even after reverting
> d9d1c2d81797. The deadlock in this case is simpler and involves
> mmap_lock instead of vm_lock (see below).
> Looks like the race is between the read() syscall and do_procmap_query().
> I'll continue investigating, in the meantime CC'ing Andrii.

So, here is a cleaner version of that report (with d9d1c2d81797 reverted):

 -> #1 (&mm->mmap_lock){++++}-{4:4}:
        __might_fault+0xed/0x170
        _copy_to_iter+0x118/0x1720
        copy_page_to_iter+0x12d/0x1e0
        filemap_read+0x720/0x10a0
        blkdev_read_iter+0x2b5/0x4e0
        vfs_read+0x7f4/0xae0
        ksys_read+0x12a/0x250
        do_syscall_64+0xcb/0xf80
        entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
        __lock_acquire+0x1509/0x26d0
        lock_acquire+0x185/0x340
        down_read+0x98/0x490
        blkdev_read_iter+0x2a7/0x4e0
        __kernel_read+0x39a/0xa90
        freader_fetch+0x1d5/0xa80
        __build_id_parse.isra.0+0xea/0x6a0
        do_procmap_query+0xd75/0x1050
        procfs_procmap_ioctl+0x7a/0xb0
        __x64_sys_ioctl+0x18e/0x210
        do_syscall_64+0xcb/0xf80
        entry_SYSCALL_64_after_hwframe+0x77/0x7f

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   rlock(&mm->mmap_lock);
                                lock(&sb->s_type->i_mutex_key#8);
                                lock(&mm->mmap_lock);
   rlock(&sb->s_type->i_mutex_key#8);

  *** DEADLOCK ***

Both threads are calling blkdev_read_iter(), which uses
inode_lock_shared() to read-lock inode->i_rwsem. I'm not sure why CPU1
shows lock() instead of rlock(). So both threads read-lock
inode->i_rwsem and mmap_lock but in a different order. IIUC, with
read-locks this should not deadlock until some other thread
write-locks the mmap_lock in between and this becomes a real deadlock:

        CPU0       CPU1         CPU2
        ----       ----         ----
   rlock(&mm->mmap_lock);
                                rlock(&sb->s_type->i_mutex_key#8);
                   wlock(&mm->mmap_lock) <-- waiting for CPU0
                                rlock(&mm->mmap_lock); <-- waiting for CPU1
   rlock(&sb->s_type->i_mutex_key#8); <-- waiting for CPU2

I believe in the original report this write-locking thread was the one
calling mprotect_fixup().

Per https://docs.kernel.org/mm/process_addrs.html#lock-ordering,
inode->i_rwsem should be locked before mm->mmap_lock, so
procfs_procmap_ioctl() has to be fixed to follow this lock ordering.
One possibility I can think of is to use build_id_parse_nofault()
first and if it fails because the required page is not faulted, we do
freader_init_from_file(), then drop the mmap/vma lock and execute
freader_fetch() outside of these locks to fault in that page. Once
that's done, we'll retry the whole operation and this time
build_id_parse_nofault() should pass (unless we already evicted that
page, which is extremely unlikely and in that case, we'll retry
again).

I tried a POC with build_id_parse_nofault() but without the whole
dance with freader_init_from_file/freader_fetch and the deadlock is
gone. Andrii, WDYT?

>
> [   62.320932][ T9229]
> [   62.321471][ T9229] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   62.323016][ T9229] WARNING: possible circular locking dependency dete=
cted
> [   62.324618][ T9229] 6.19.0-rc6-00001-g40bea6261b2a #42 Not tainted
> [   62.326013][ T9229] --------------------------------------------------=
----
> [   62.327560][ T9229] hillf/9229 is trying to acquire lock:
> [   62.328821][ T9229] ffff888145b7b5a8
> (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at:
> blkdev_read_iter+0x2a7/0x4e0
> [   62.331102][ T9229]
> [   62.331102][ T9229] but task is already holding lock:
> [   62.332722][ T9229] ffff888183a6e540 (&mm->mmap_lock){++++}-{4:4},
> at: do_procmap_query+0x39f/0x1050
> [   62.334795][ T9229]
> [   62.334795][ T9229] which lock already depends on the new lock.
> [   62.334795][ T9229]
> [   62.337072][ T9229]
> [   62.337072][ T9229] the existing dependency chain (in reverse order) i=
s:
> [   62.338998][ T9229]
> [   62.338998][ T9229] -> #1 (&mm->mmap_lock){++++}-{4:4}:
> [   62.340646][ T9229]        __might_fault+0xed/0x170
> [   62.341763][ T9229]        _copy_to_iter+0x118/0x1720
> [   62.342913][ T9229]        copy_page_to_iter+0x12d/0x1e0
> [   62.344167][ T9229]        filemap_read+0x720/0x10a0
> [   62.345298][ T9229]        blkdev_read_iter+0x2b5/0x4e0
> [   62.346480][ T9229]        vfs_read+0x7f4/0xae0
> [   62.347518][ T9229]        ksys_read+0x12a/0x250
> [   62.348584][ T9229]        do_syscall_64+0xcb/0xf80
> [   62.349707][ T9229]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   62.351116][ T9229]
> [   62.351116][ T9229] -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> [   62.353012][ T9229]        __lock_acquire+0x1509/0x26d0
> [   62.354213][ T9229]        lock_acquire+0x185/0x340
> [   62.355323][ T9229]        down_read+0x98/0x490
> [   62.356441][ T9229]        blkdev_read_iter+0x2a7/0x4e0
> [   62.357619][ T9229]        __kernel_read+0x39a/0xa90
> [   62.358767][ T9229]        freader_fetch+0x1d5/0xa80
> [   62.359927][ T9229]        __build_id_parse.isra.0+0xea/0x6a0
> [   62.361232][ T9229]        do_procmap_query+0xd75/0x1050
> [   62.362434][ T9229]        procfs_procmap_ioctl+0x7a/0xb0
> [   62.363687][ T9229]        __x64_sys_ioctl+0x18e/0x210
> [   62.364863][ T9229]        do_syscall_64+0xcb/0xf80
> [   62.365977][ T9229]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   62.367394][ T9229]
> [   62.367394][ T9229] other info that might help us debug this:
> [   62.367394][ T9229]
> [   62.369637][ T9229]  Possible unsafe locking scenario:
> [   62.369637][ T9229]
> [   62.371237][ T9229]        CPU0                    CPU1
> [   62.372441][ T9229]        ----                    ----
> [   62.373687][ T9229]   rlock(&mm->mmap_lock);
> [   62.374688][ T9229]
> lock(&sb->s_type->i_mutex_key#8);
> [   62.376444][ T9229]                                lock(&mm->mmap_lock=
);
> [   62.377956][ T9229]   rlock(&sb->s_type->i_mutex_key#8);
> [   62.379165][ T9229]
> [   62.379165][ T9229]  *** DEADLOCK ***
> [   62.379165][ T9229]
> [   62.380952][ T9229] 1 lock held by hillf/9229:
> [   62.381971][ T9229]  #0: ffff888183a6e540
> (&mm->mmap_lock){++++}-{4:4}, at: do_procmap_query+0x39f/0x1050
> [   62.384162][ T9229]
> [   62.384162][ T9229] stack backtrace:
> [   62.385458][ T9229] CPU: 3 UID: 0 PID: 9229 Comm: hillf Not tainted
> 6.19.0-rc6-00001-g40bea6261b2a #42 PREEMPT(full)
> [   62.385471][ T9229] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [   62.385477][ T9229] Call Trace:
> [   62.385482][ T9229]  <TASK>
> [   62.385487][ T9229]  dump_stack_lvl+0x100/0x190
> [   62.385505][ T9229]  print_circular_bug.cold+0x185/0x1d5
> [   62.385521][ T9229]  check_noncircular+0x14a/0x170
> [   62.385534][ T9229]  __lock_acquire+0x1509/0x26d0
> [   62.385547][ T9229]  lock_acquire+0x185/0x340
> [   62.385557][ T9229]  ? blkdev_read_iter+0x2a7/0x4e0
> [   62.385569][ T9229]  ? __pfx___might_resched+0x10/0x10
> [   62.385583][ T9229]  down_read+0x98/0x490
> [   62.385593][ T9229]  ? blkdev_read_iter+0x2a7/0x4e0
> [   62.385603][ T9229]  ? __pfx_down_read+0x10/0x10
> [   62.385612][ T9229]  ? lock_acquire+0x185/0x340
> [   62.385622][ T9229]  ? is_bpf_text_address+0x25/0x1a0
> [   62.385634][ T9229]  blkdev_read_iter+0x2a7/0x4e0
> [   62.385645][ T9229]  __kernel_read+0x39a/0xa90
> [   62.385658][ T9229]  ? __pfx___kernel_read+0x10/0x10
> [   62.385671][ T9229]  ? __lock_acquire+0x481/0x26d0
> [   62.385683][ T9229]  freader_fetch+0x1d5/0xa80
> [   62.385697][ T9229]  ? find_held_lock+0x2b/0x80
> [   62.385712][ T9229]  ? __pfx_freader_fetch+0x10/0x10
> [   62.385725][ T9229]  ? __asan_memset+0x27/0x50
> [   62.385737][ T9229]  __build_id_parse.isra.0+0xea/0x6a0
> [   62.385751][ T9229]  ? __pfx___build_id_parse.isra.0+0x10/0x10
> [   62.385766][ T9229]  ? __pfx_find_vma+0x10/0x10
> [   62.385774][ T9229]  ? __might_fault+0x129/0x170
> [   62.385788][ T9229]  do_procmap_query+0xd75/0x1050
> [   62.385798][ T9229]  ? __pfx_do_procmap_query+0x10/0x10
> [   62.385807][ T9229]  ? __sanitizer_cov_trace_switch+0x53/0x90
> [   62.385817][ T9229]  ? do_vfs_ioctl+0x226/0x13b0
> [   62.385828][ T9229]  ? __pfx_do_vfs_ioctl+0x10/0x10
> [   62.385839][ T9229]  ? putname+0xfc/0x1b0
> [   62.385846][ T9229]  ? putname+0x101/0x1b0
> [   62.385857][ T9229]  ? __x64_sys_openat+0x143/0x210
> [   62.385867][ T9229]  procfs_procmap_ioctl+0x7a/0xb0
> [   62.385877][ T9229]  ? __pfx_procfs_procmap_ioctl+0x10/0x10
> [   62.385888][ T9229]  __x64_sys_ioctl+0x18e/0x210
> [   62.385899][ T9229]  do_syscall_64+0xcb/0xf80
> [   62.385913][ T9229]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   62.385923][ T9229] RIP: 0033:0x412209
> [   62.385931][ T9229] Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f
> 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8
> 64 89 01 48
> [   62.385940][ T9229] RSP: 002b:00007fff380d5588 EFLAGS: 00000217
> ORIG_RAX: 0000000000000010
> [   62.385950][ T9229] RAX: ffffffffffffffda RBX: 00007fff380d56c8
> RCX: 0000000000412209
> [   62.385956][ T9229] RDX: 0000200000000180 RSI: 00000000c0686611
> RDI: 0000000000000004
> [   62.385962][ T9229] RBP: 00007fff380d55a0 R08: 0000000000000000
> R09: 00007fff380d5640
> [   62.385968][ T9229] R10: 0000000000000000 R11: 0000000000000217
> R12: 00007fff380d56b8
> [   62.385974][ T9229] R13: 0000000000000002 R14: 00000000004a0e40
> R15: 0000000000000002
> [   62.385982][ T9229]  </TASK>
>
>
>
> >
> > > > other info that might help us debug this:
> > > >
> > > > Chain exists of:
> > > >   &sb->s_type->i_mutex_key#8 --> &mm->mmap_lock --> vm_lock
> > > >
> > > >  Possible unsafe locking scenario:
> > > >
> > > >        CPU0                    CPU1
> > > >        ----                    ----
> > > >   rlock(vm_lock);
> > > >                                lock(&mm->mmap_lock);
> > > >                                lock(vm_lock);
> > > >   rlock(&sb->s_type->i_mutex_key#8);
> > > >
> > > >  *** DEADLOCK ***
> > > >
> > > > 1 lock held by syz.0.17/6091:
> > > >  #0: ffff888012aa0448 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x10=
e/0xed0 mm/mmap_lock.c:334
> > > >
> > > > stack backtrace:
> > > > CPU: 2 UID: 0 PID: 6091 Comm: syz.0.17 Not tainted syzkaller #0 PRE=
EMPT(full)
> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-deb=
ian-1.16.3-2~bpo12+1 04/01/2014
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:94 [inline]
> > > >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> > > >  print_circular_bug+0x275/0x340 kernel/locking/lockdep.c:2043
> > > >  check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
> > > >  check_prev_add kernel/locking/lockdep.c:3165 [inline]
> > > >  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> > > >  validate_chain kernel/locking/lockdep.c:3908 [inline]
> > > >  __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
> > > >  lock_acquire kernel/locking/lockdep.c:5868 [inline]
> > > >  lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
> > > >  down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
> > > >  inode_lock_shared include/linux/fs.h:1042 [inline]
> > > >  blkdev_read_iter+0x19e/0x500 block/fops.c:855
> > > >  __kernel_read+0x3f3/0xbf0 fs/read_write.c:530
> > > >  freader_fetch+0x1d7/0x9d0 lib/buildid.c:100
> > > >  __build_id_parse.isra.0+0xdd/0x6c0 lib/buildid.c:297
> > > >  do_procmap_query+0xb0e/0x1080 fs/proc/task_mmu.c:733
> > > >  procfs_procmap_ioctl+0x9d/0xe0 fs/proc/task_mmu.c:813
> > > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > > >  __do_sys_ioctl fs/ioctl.c:597 [inline]
> > > >  __se_sys_ioctl fs/ioctl.c:583 [inline]
> > > >  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> > > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > RIP: 0033:0x7ff1a238f7c9
> > > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > > > RSP: 002b:00007ffebbe538b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010
> > > > RAX: ffffffffffffffda RBX: 00007ff1a25e5fa0 RCX: 00007ff1a238f7c9
> > > > RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000004
> > > > RBP: 00007ff1a2413f91 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > > R13: 00007ff1a25e5fa0 R14: 00007ff1a25e5fa0 R15: 0000000000000003
> > > >  </TASK>
