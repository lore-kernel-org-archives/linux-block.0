Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD515382F;
	Wed, 19 Jun 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816389; cv=none; b=B1pZBA1aUZ3fho84tbbw7x7a1+WwICQFfZ6i1M2b81r99VsAu9rqD8mvEE8kvc4Ay8G1BPD5Xwf0lXhY6DGgAAi0rMLlp0SskgBh1PJgvhpfoPZATnEH6Cicx+xcrwJGCjhGyFTjgTAF64zSkYjEvfBPVtRl/f+Q7u/q+guhvrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816389; c=relaxed/simple;
	bh=6YqZxcm83vpurH0rt6GpPHd/Crvf4o1d4oMnDTnOY1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixSJn7MxbBlH2DVcAyYPys6cdZm9CfNqdrXVXqcR2RHGwReNR8FB7aSiiYaxzMeSKpU3GISDLgRaNYCyl+c9v8wuGBT6sIfQtj6W7w8vAmWbo/n/e/0AU+n0R1to3i82yB/TySm6YdWEheF5iMBTbZpVNG48SRXiTJOqlC9kdU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxMLdwT9; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxMLdwT9"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-797a7f9b52eso1729585a.2;
        Wed, 19 Jun 2024 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718816385; x=1719421185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDzwqJUNGpd3ExrB77/2J3f2Tep+iv1xzWugmtBOTOY=;
        b=hxMLdwT9wgOVCroyJYaN0TzLWHsb3hTPMBs2scDAwPu+qXHwERCLfpIZZFeYjropH/
         QVUUQ8Lge/I6G5SY/DtwntZRTum3h2+i7hpDp7CATx/HUnHGvH6kfvaa9e13Lo58cgZa
         mndJ4TwDOC4LnuuONUGNKStS5sgeehmHlRBgRuvF1UAFW5vqoSOhk/qbm2WgEVvjIWdk
         9kvHFO2Rw4T782ibNNdsQAYgzpWyCilq4P5uH6ZvPpDkqtXDBLju3UhOmiWLGHWQM4jG
         BYdOvkWJe5urQbSRVCUlt9fpKIA9e0U6IYS+f5TTIUt7V/ay/SyL4Ak58MLX2vR8lPA6
         kGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718816385; x=1719421185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDzwqJUNGpd3ExrB77/2J3f2Tep+iv1xzWugmtBOTOY=;
        b=aV4K2nDszOvKh1hp/Ke1M0MS++pKjLWX2dRYma2wpewCZ7MgV7KbsEMBNErCqeO2Et
         ghdBiA4QxTZkEXBf543DdfB5L9cHaPQBgngQJpYek8quFNKOGFzVXFwwgYeLLWgQCx4Y
         CblxvGtphtbC4jkZXwULg8ZjVVIUd+mwI0zyumVMQu9yMMt8Sfs4XUMe/G9WZV4PsEzE
         8demrvcr+fz8EVoSQfeNuibTlddCnJ5B9fKKuMJpH5BMy76ROHqPGBbdiXtSfs5E0fKm
         Da8RtzPKj8FS3Sz2lvibn4ZhoCUBfOsUSW6uLajCj2s0L+ztnANlzcqQCCdZC6TPAQ5l
         fkOA==
X-Forwarded-Encrypted: i=1; AJvYcCWchnoVfj9YuYDdmae4Fajd0sQ+h8cwvWQbuu2TeXKfE08RfeZbwSLWKVatiade2YJeLQYzxkBzrkuUi57+kGU7sWKW0auE7ZXNQSo2vUfKqLlL8zM9KCAxoDDib7i5YBZ+7YUzvYHtF3E=
X-Gm-Message-State: AOJu0YwwoUsWqvTh+UUWhXKAVCI3wZN3GBK2RTbOVFw5Vga0psGV+hXY
	BVutxH5EU7fnD5h5DCqwDy/sAIXD3l8PMqOzfOTy3EMRqV1TKqdUSEU34lruu06lqXF3ZLycTpL
	lI8y0XgoL+lWjWPdUke8WbB8nFE8=
X-Google-Smtp-Source: AGHT+IHgWZR86aet8NsFk6QADc3RY1LxeuyuNwE1KbtbYTnws2GoYWXftQeSoOkEBq6x4/iqOopzwgpA16mmiRZz1I4=
X-Received: by 2002:a0c:e407:0:b0:6b4:f902:4ade with SMTP id
 6a1803df08f44-6b501e3f9c7mr32557086d6.29.1718816385281; Wed, 19 Jun 2024
 09:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000dc2e3d061b3d519c@google.com>
In-Reply-To: <000000000000dc2e3d061b3d519c@google.com>
From: Santosh Pradhan <santosh.pradhan@gmail.com>
Date: Wed, 19 Jun 2024 22:29:32 +0530
Message-ID: <CAOuNp5n7qaZnZ_5+kjfA6MD3QO=XDhE01G1ofN3rp72um-D2+w@mail.gmail.com>
Subject: Re: [syzbot] [block?] KCSAN: data-race in block_uevent / inc_diskseq (2)
To: syzbot <syzbot+c147f9175ec6cc7bd73b@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,
I guess this can be fixed by READ_ONCE(disk->diskseq) while reading
and WRITE_ONCE(disk->diskseq, atomic64_inc_return(&diskseq)) in
inc_diskseq() to avoid data race.

I can probably send a patch if my understanding is correct.

Best Regards,
Santosh


On Wed, Jun 19, 2024 at 5:57=E2=80=AFPM syzbot
<syzbot+c147f9175ec6cc7bd73b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3d54351c64e8 Merge tag 'lsm-pr-20240617' of git://git.ker=
n..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12426cfa98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcd45aedbb3f76=
37b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc147f9175ec6cc7=
bd73b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ba0a777cccff/dis=
k-3d54351c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a78193318c92/vmlinu=
x-3d54351c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/54456f3d3bfe/b=
zImage-3d54351c.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c147f9175ec6cc7bd73b@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in block_uevent / inc_diskseq
>
> write to 0xffff888101f05220 of 8 bytes by task 3101 on cpu 0:
>  inc_diskseq+0x2c/0x40 block/genhd.c:1472
>  disk_force_media_change+0x9f/0xf0 block/disk-events.c:297
>  __loop_clr_fd+0x270/0x3f0 drivers/block/loop.c:1193
>  loop_clr_fd drivers/block/loop.c:1276 [inline]
>  lo_ioctl+0xea6/0x1330 drivers/block/loop.c:1578
>  blkdev_ioctl+0x35f/0x450 block/ioctl.c:676
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xd3/0x150 fs/ioctl.c:893
>  __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:893
>  x64_sys_call+0x1581/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:=
17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888101f05220 of 8 bytes by task 3091 on cpu 1:
>  block_uevent+0x31/0x50 block/genhd.c:1206
>  dev_uevent+0x2f3/0x380 drivers/base/core.c:2687
>  uevent_show+0x11e/0x210 drivers/base/core.c:2745
>  dev_attr_show+0x3a/0xa0 drivers/base/core.c:2437
>  sysfs_kf_seq_show+0x17c/0x250 fs/sysfs/file.c:59
>  kernfs_seq_show+0x7c/0x90 fs/kernfs/file.c:205
>  seq_read_iter+0x2d7/0x940 fs/seq_file.c:230
>  kernfs_fop_read_iter+0xc6/0x310 fs/kernfs/file.c:279
>  new_sync_read fs/read_write.c:395 [inline]
>  vfs_read+0x5e6/0x6e0 fs/read_write.c:476
>  ksys_read+0xeb/0x1b0 fs/read_write.c:619
>  __do_sys_read fs/read_write.c:629 [inline]
>  __se_sys_read fs/read_write.c:627 [inline]
>  __x64_sys_read+0x42/0x50 fs/read_write.c:627
>  x64_sys_call+0x27e5/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:=
1
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x0000000000000045 -> 0x0000000000000048
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 3091 Comm: udevd Not tainted 6.10.0-rc4-syzkaller-00035-g3d54=
351c64e8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/07/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
>
