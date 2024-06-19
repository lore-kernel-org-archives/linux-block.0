Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8A1586C0
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718823017; cv=none; b=N93DNKu+7RCgGzDFDLkZF2XUXWkUJznMOmY50bR3pMQZPN9Xtyv9qLs4o03bk3HttmTHxY5ADaszRDg6hUQ1pylBmQZHVZbXoL7q6CUV8bXho6JSpfPa6ArnPhCeKFM4MqZAXizQwxfrgue0mNb8/6WPb6wjQXZ25JhBdL6rwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718823017; c=relaxed/simple;
	bh=4RSq8sWW/mHJkKqBaWcW37bWPJm3MVZQNhRy+yS6AWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFK46HdPwamRu+DRQsT41pMMF8ONRUn0kjl4wzAdQ924UPJ0sUregPPUYdU9qCaOLBTaAnLlPqVh1gI04fYUQaAo3lGdinevmMsKSyRgzwINh/oOYaSnR/ubJAlB5un2eDXo7tAVEXF2WKLFuq8bYkpoOm9cN3JRTttj+TlHJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6vs6LLd; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6vs6LLd"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-80d6cf96e22so86821241.0
        for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718823015; x=1719427815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuPnBomZe0Xk2eQHT1++xcdmG4tOYlp5lhA77KrxQfM=;
        b=i6vs6LLdDPyShkIm/z9oHSOsc/AXuparO7zitqGA2UUV14Ai36Xtaw3EGhYZANRCgS
         NgSgajlWbDH60zJdWzq50AQOpC58fOAJEt2kG9eWcC1Mpj7tc7hRayAYU4Jppb4HJwMZ
         hBX+zE0ZLtrPabYv3ocFgiYtKcdNBp2oiZ7EzRVLu4fgaPdEZb0WWMiiBb7/sTUQn1MT
         +25mRHCsdLTAyPrZEsPyitUNHbSvU8YM6ZIUMUkQhR7SUlaRdEZCPVzJNcfofH3y6RjM
         tcmpa6PfSOZ14+ooddn0O7K7bRhGOpfaWFeu/ABx4WPl3Js2uCp/8pPPMDd5IkffJZme
         6ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718823015; x=1719427815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuPnBomZe0Xk2eQHT1++xcdmG4tOYlp5lhA77KrxQfM=;
        b=xLq9bgij0ZiT8sG2Ijafa0zXAUePzsTr09pEVG3SS/nKXav0hYt7iCwntry8WQ6n1Y
         KXDpqRntqBntnk+3imSKV4IPd5TIZ32GOkct31NsoR3yGC9uASTNz3kS5S/pg1EUy35i
         zKGFt9g6b5AlwdCFz6/m1MrDSK/DwPUg7JZK8uop9R0eDMn7c/X4AJoUY/C5OFRS7Pnf
         +kFDCq3rE0UCUJLsDhH0Gl3Wc2Cv/U5UstoHPI8tzAm/pajRLGrrUbpH5aophNEp0dzq
         ejij+kgt0OliBnhcBBlF7zQh3I95VxwfkK4uhUI9ZcaQAtN2WaviKJV4rjtJkIi+ABYx
         2eIg==
X-Forwarded-Encrypted: i=1; AJvYcCWQPz9IyHPrj32zLdXrE7tThKpR419g2YvdN33THSb9RbEH2L4Pgm3BbA0yoW2n5hzdTfMa377uI4xxuoILJFsQLBduENuDSA/EJM4=
X-Gm-Message-State: AOJu0YyE1VzVcQXQzreML+fSodqta5agdbJHDr5dydD8kQsPSnXxNWVM
	RbjAcf9gDkAjVfVQ1o+pcmVY8xgtjliZ9BGHsmnfSUuvPBQXtYj1I0OrC1Jtaig8mWoK1LNFsuj
	5RtqzKYAxXzkNPsL2VGILfBgx1QevjD05O9Ej
X-Google-Smtp-Source: AGHT+IFNg3encb4gjg+oaKv3d96aPN2bFamfSHIp4BU7GaTZm4WYmo3NnO+PTZAYnNp35sTtfMcp8RW+oDqt4RnqEhk=
X-Received: by 2002:a05:6102:2385:b0:48f:19af:d2a8 with SMTP id
 ada2fe7eead31-48f19afdb73mr1689770137.11.1718823015032; Wed, 19 Jun 2024
 11:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000dc2e3d061b3d519c@google.com> <CAOuNp5n7qaZnZ_5+kjfA6MD3QO=XDhE01G1ofN3rp72um-D2+w@mail.gmail.com>
In-Reply-To: <CAOuNp5n7qaZnZ_5+kjfA6MD3QO=XDhE01G1ofN3rp72um-D2+w@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 19 Jun 2024 20:49:37 +0200
Message-ID: <CANpmjNO7uiz=zKmTkXGO5cn1BUDuPNC3MS7Vdgua0i2bdqeMjQ@mail.gmail.com>
Subject: Re: [syzbot] [block?] KCSAN: data-race in block_uevent / inc_diskseq (2)
To: Santosh Pradhan <santosh.pradhan@gmail.com>
Cc: syzbot <syzbot+c147f9175ec6cc7bd73b@syzkaller.appspotmail.com>, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Jun 2024 at 19:00, Santosh Pradhan <santosh.pradhan@gmail.com> w=
rote:
>
> Hi All,
> I guess this can be fixed by READ_ONCE(disk->diskseq) while reading
> and WRITE_ONCE(disk->diskseq, atomic64_inc_return(&diskseq)) in
> inc_diskseq() to avoid data race.
>
> I can probably send a patch if my understanding is correct.

What you propose fixes the underlying data race. However, I wonder if
there is a race condition that needs to be taken care of: whatever
sees the string "DISKSEQ=3D<seqnum>" can end up with either the old
value or new value (in this case 45 or 48 respectively). Is whoever
uses this string tolerant to the value randomly changing?

> Best Regards,
> Santosh
>
>
> On Wed, Jun 19, 2024 at 5:57=E2=80=AFPM syzbot
> <syzbot+c147f9175ec6cc7bd73b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    3d54351c64e8 Merge tag 'lsm-pr-20240617' of git://git.k=
ern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12426cfa980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcd45aedbb3f=
7637b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc147f9175ec6c=
c7bd73b
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/ba0a777cccff/d=
isk-3d54351c.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/a78193318c92/vmli=
nux-3d54351c.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/54456f3d3bfe=
/bzImage-3d54351c.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+c147f9175ec6cc7bd73b@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in block_uevent / inc_diskseq
> >
> > write to 0xffff888101f05220 of 8 bytes by task 3101 on cpu 0:
> >  inc_diskseq+0x2c/0x40 block/genhd.c:1472
> >  disk_force_media_change+0x9f/0xf0 block/disk-events.c:297
> >  __loop_clr_fd+0x270/0x3f0 drivers/block/loop.c:1193
> >  loop_clr_fd drivers/block/loop.c:1276 [inline]
> >  lo_ioctl+0xea6/0x1330 drivers/block/loop.c:1578
> >  blkdev_ioctl+0x35f/0x450 block/ioctl.c:676
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> >  __se_sys_ioctl+0xd3/0x150 fs/ioctl.c:893
> >  __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:893
> >  x64_sys_call+0x1581/0x2d70 arch/x86/include/generated/asm/syscalls_64.=
h:17
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff888101f05220 of 8 bytes by task 3091 on cpu 1:
> >  block_uevent+0x31/0x50 block/genhd.c:1206
> >  dev_uevent+0x2f3/0x380 drivers/base/core.c:2687
> >  uevent_show+0x11e/0x210 drivers/base/core.c:2745
> >  dev_attr_show+0x3a/0xa0 drivers/base/core.c:2437
> >  sysfs_kf_seq_show+0x17c/0x250 fs/sysfs/file.c:59
> >  kernfs_seq_show+0x7c/0x90 fs/kernfs/file.c:205
> >  seq_read_iter+0x2d7/0x940 fs/seq_file.c:230
> >  kernfs_fop_read_iter+0xc6/0x310 fs/kernfs/file.c:279
> >  new_sync_read fs/read_write.c:395 [inline]
> >  vfs_read+0x5e6/0x6e0 fs/read_write.c:476
> >  ksys_read+0xeb/0x1b0 fs/read_write.c:619
> >  __do_sys_read fs/read_write.c:629 [inline]
> >  __se_sys_read fs/read_write.c:627 [inline]
> >  __x64_sys_read+0x42/0x50 fs/read_write.c:627
> >  x64_sys_call+0x27e5/0x2d70 arch/x86/include/generated/asm/syscalls_64.=
h:1
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > value changed: 0x0000000000000045 -> 0x0000000000000048
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 3091 Comm: udevd Not tainted 6.10.0-rc4-syzkaller-00035-g3d=
54351c64e8 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 06/07/2024
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CAOuNp5n7qaZnZ_5%2BkjfA6MD3QO%3DXDhE01G1ofN3rp72um-D2%2Bw%=
40mail.gmail.com.
