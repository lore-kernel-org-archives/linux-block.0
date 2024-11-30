Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556E19F121
	for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732982369; cv=none; b=oHSsVkPXtP21jZE5ChvCwDgffWTYAi5zo+AWKsbJhQcAMXBgVsaVdmbdacUXi27NHHPg++Xb3XV7CW8yZ4+touTAsGj0MiUtMJzoMrvabBnd4tbl6PcMTBs1DO5woTrFeqMEMLZtWnMHC5BdLhyxh45sBab/VYUNCdDqJpQK7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732982369; c=relaxed/simple;
	bh=bcdNDokqH+OiVRw+A8jIObIH06ox30nu+WY3/5jH7Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQvKQ41aCQY3pbm9sKd3qo7UCyuhMXb4e7QrKWGjWp/gHyNHyrtfm4JvLHlDzOxMhoILhJOpIP78hF3iog4QtrgI6imw6b42WRX6iCFQTGO7ZmWYtiHg+kd2mxDM777TxiYBLNCDxQf7uxmB4zjUTTPJ3/6vW8LboX3dMa4bhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSy2boF6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSy2boF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732982366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3sp9ITqS00f1w2cVwkTebqJbheBN3iCrob7vB6Qx7c=;
	b=DSy2boF6qCclhEM9xruSnundzawP1XHeH8im2rubYOF5fF1ggIzC555AB76sBn9y/V1ynK
	TiDS5UndU7Lv6etgHhb8KIXrMWNb6OSfuz7vsOdHfNHY3L5yxTxo97Lv8jEa4p3YYiduMf
	ITTmdTzoGeVxyo4LtbodAbEOrQ+nij0=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-LjTSuliaMIu_j2jpSPusYQ-1; Sat, 30 Nov 2024 10:59:24 -0500
X-MC-Unique: LjTSuliaMIu_j2jpSPusYQ-1
X-Mimecast-MFC-AGG-ID: LjTSuliaMIu_j2jpSPusYQ
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4af1681b7ddso589210137.3
        for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 07:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732982364; x=1733587164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3sp9ITqS00f1w2cVwkTebqJbheBN3iCrob7vB6Qx7c=;
        b=tJXg1zwf32iYZGgG0n2vs9SVrtBoJvyi/O42k/ULliHIeqnPKcexHk/mklQhv9AZV3
         pb/yeveubeYPfJakIfsWItb5mHwuO2PO878VF6lYl2gwv6tMR5Sq1GwSSYzGjIsmnDUW
         thSmwgoLSa8zE2Se0Y/RBMABxfNyM2f7Yk3klJfQETSAvsqdei8ENrJ5VLdKRm9awbn4
         J72teqBXCMPkvZLbZVJ045I1C4yupzAq7MBm+x/TVeI9CHpPcC2N2/eTS2huvLuC9Wnr
         EG0HgYDPD2UjHrbtu+Sqxqncml9ZajwgLB45jOf6AP7NBOFMFnIfnxR0cK72E/mLqWqZ
         juCA==
X-Forwarded-Encrypted: i=1; AJvYcCWsd5RjjCtOwEBVPwF6vjw26vw1bY0LafICBm39knjyeKP48oogYNs+aqNcjAzw9AifhMOVbWdsHIiCeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVCHX/eyA+J1Ws0wokZUbbxCt7GAegacmJ/molIxK4KGJLnd0
	tni8E8gfkBJwjwSuBwlzge5xog5JI6FVGKWxBftbX6FnEZYqI0oOVFsvzoj0kSHR0Eka/ZCOJWI
	LwjnWGgfufe9ZzCHQOgFSWgeOYBK7WOsdtuo1Rz4KAWlfn9V+piX6TRYuntgvKA1JDTDw+q70XS
	pdn05O1BFkX2ndKca0u5H2YeZVDEnaRWpjZOA=
X-Gm-Gg: ASbGncum8372E5ASEAYth/OoyjyzdK607oQSx+noOVFceUYKAs9o4PU+1Tim4KAQG58
	gvanrvmZEPp9i4ScgF6sipkbDx6ZVlcxy
X-Received: by 2002:a05:6102:32c1:b0:4af:4a71:e35 with SMTP id ada2fe7eead31-4af4a710f6emr17947648137.27.1732982364203;
        Sat, 30 Nov 2024 07:59:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4oaFHosIDKY7f3WBekgHYIqS0EOw6XcWkfbPmScRohRzmYmfm2E+p3FDCVbGkVV/07+rt3W9NEuZzOIH+9Ac=
X-Received: by 2002:a05:6102:32c1:b0:4af:4a71:e35 with SMTP id
 ada2fe7eead31-4af4a710f6emr17947628137.27.1732982362448; Sat, 30 Nov 2024
 07:59:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <674adfe5.050a0220.253251.00da.GAE@google.com>
In-Reply-To: <674adfe5.050a0220.253251.00da.GAE@google.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 30 Nov 2024 23:59:11 +0800
Message-ID: <CAFj5m9L0f8QVtevytwmgua8ZP4qjLLpm6DnKmP3gHZ+0evA0mg@mail.gmail.com>
Subject: Re: [syzbot] [block?] [trace?] possible deadlock in do_page_mkwrite (2)
To: syzbot <syzbot+1682a0f52e34640bb386@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 5:50=E2=80=AFPM syzbot
<syzbot+1682a0f52e34640bb386@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7eef7e306d3c Merge tag 'for-6.13/dm-changes' of git://git=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11da21e858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dba7de3ed028e6=
710
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D1682a0f52e34640=
bb386
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/450015008b3e/dis=
k-7eef7e30.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9bea6e0ac594/vmlinu=
x-7eef7e30.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e1b46c65494c/b=
zImage-7eef7e30.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+1682a0f52e34640bb386@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.12.0-syzkaller-09567-g7eef7e306d3c #0 Not tainted
> ------------------------------------------------------
> syz.5.3623/19452 is trying to acquire lock:
> ffff88805e392518 (sb_pagefaults){++++}-{0:0}, at: do_page_mkwrite+0x17a/0=
x380 mm/memory.c:3176
>
> but task is already holding lock:
> ffff888035510ba0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock incl=
ude/linux/mmap_lock.h:163 [inline]
> ffff888035510ba0 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefull=
y mm/memory.c:6149 [inline]
> ffff888035510ba0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0=
x35/0x6a0 mm/memory.c:6209
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #6 (&mm->mmap_lock){++++}-{4:4}:
>        __might_fault mm/memory.c:6751 [inline]
>        __might_fault+0x11b/0x190 mm/memory.c:6744
>        _inline_copy_from_user include/linux/uaccess.h:162 [inline]
>        _copy_from_user+0x29/0xd0 lib/usercopy.c:18
>        copy_from_user include/linux/uaccess.h:212 [inline]
>        __blk_trace_setup+0xa8/0x180 kernel/trace/blktrace.c:626
>        blk_trace_setup+0x47/0x70 kernel/trace/blktrace.c:648
>        sg_ioctl_common drivers/scsi/sg.c:1114 [inline]
>        sg_ioctl+0x65e/0x2750 drivers/scsi/sg.c:1156
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:906 [inline]
>        __se_sys_ioctl fs/ioctl.c:892 [inline]
>        __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #5 (&q->debugfs_mutex){+.+.}-{4:4}:

It should be fixed in:

git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
for-6.14/block

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?=
h=3Dfor-6.14/block

