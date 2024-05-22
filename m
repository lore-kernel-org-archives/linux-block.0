Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652262594
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716338799; cv=none; b=satbQkGBF8zxfnCsI+ujnrunhbItNAlgTJwobAuD8U73UiW4Wv3kKttfZ0RtGl0DCgN45HJX6mXbXaomvRTu6XstBwZ9vh6NNfIjtDy5ge77odPy6W3jsa6IGs070mVVT2S9ra2dBKMjSUZCfdJs4Rf+EGt1DV8GbdqDfURIpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716338799; c=relaxed/simple;
	bh=7BY9RRmh2VxZZEuSvcnwCMC9/YP698MeCwYo///rW6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lG5ONx7c/eJQ+c5A5vZJ5EMbvNnegCKtNQGP2VHbkLxZnlTqVOTwtZOBRtZRmh5iWiNvJgvog5MU2JuYfqslXmWwL+Dnc56a6a7QxVYhFarhpyXV2EunWfrbcs+GogwEjE1WYVTUh5J3ba/uvGqo+kT0xoyAmZhvyvObLB+bFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoOo9nhH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoOo9nhH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716338796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzEDAxoabsUEZMbG3hl5HQi6iHnRf8Nl1CTVdR+bflc=;
	b=UoOo9nhH2BUbP81ZxohAUZiVPsWDg9pqUdEQNb1rNcn0XeXJ2lJC0/l1th5arDAJkQiUg5
	LbcmDLWisvOL2pYo8/zJqyFp9rP//LQ3elPEGRoldNsJYKiWEV8QpwXCDaTrM2PqjH0VFg
	kGx/vP29jgwktafJnh4KLmL8lTXJWhY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-5ukKK2IfM9m4-ljNqLK05g-1; Tue, 21 May 2024 20:46:30 -0400
X-MC-Unique: 5ukKK2IfM9m4-ljNqLK05g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-354c964f74aso1773839f8f.0
        for <linux-block@vger.kernel.org>; Tue, 21 May 2024 17:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716338789; x=1716943589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzEDAxoabsUEZMbG3hl5HQi6iHnRf8Nl1CTVdR+bflc=;
        b=R9QuYklzQ4IMRJOGGyGbS47BZsOeY9l8IGNGHj6WMHCFSIKybv2QIsWp39hsq2uN1I
         a267xPpoTiUAYUkfu8YB/0D3amDMcKdcGQ4Sp6AofZIuvJJpe+I/Xqa80n4Pd8Wurlp+
         3o021Nrf0s59gz5s44WW8T4rVFfzF8Bo0ElyS6Zsjj+xJCZYgDKybLlsLaFglgtkIdtx
         NfXuvb2cbswLsf95pLL8+MFsTKeBqwkpaj5wgm3/EM5vk5ndQtciy4wX7sBzQDoaKlL4
         sdPoEp3+D1lFFyKigdjh6KPOC2WJO00euPBIvDHl7HE/klKZRLp8iHogjHkjeyXLcjje
         PIOw==
X-Gm-Message-State: AOJu0Yw2TnHShuNFedHURiHV0p7L4L0qLZO7LFUIWWVZILCoOjDRNDQW
	glmtII1RLUblwUGHz3g2YfoVUGowJsqBmCSA4i/bbdxvUHNoNfAz1aoeXbzkVQC8p+WOxOvGJ1I
	mFoCSdxRDtR0rjhsli4OnwfhE8VYd9YuYa1K0HZhryDGnd35U6drtcl7FnEUbIMCT0iD4+Yyc6Z
	moAM0jkObf8wAfl4JFD4fWMIlCZAf/5xeO7/g=
X-Received: by 2002:a5d:5551:0:b0:351:d3e2:c091 with SMTP id ffacd0b85a97d-354d8ccc817mr280084f8f.14.1716338789161;
        Tue, 21 May 2024 17:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH803zTZAlHW8RmQX2UUect5Ovp9GTkq/vRtljmi6erFRzzLrXu2m8K40SYmpvYmNO/bD7pTlC1tCAROotS5FE=
X-Received: by 2002:a5d:5551:0:b0:351:d3e2:c091 with SMTP id
 ffacd0b85a97d-354d8ccc817mr280077f8f.14.1716338788669; Tue, 21 May 2024
 17:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGS2=Ypq9_X23syZw8tpybjc_hPk7dQGqdYNbpw0KKN1A1wbNA@mail.gmail.com>
 <ae36c333-29fe-1bfd-9558-894b614e916d@huaweicloud.com> <CAGS2=YrG7+k7ufEcX5NY2GFy69A7QQwq6BCku2biLHXVEOxWow@mail.gmail.com>
 <a053e948-791c-3233-3791-83bf9ea90bde@huaweicloud.com>
In-Reply-To: <a053e948-791c-3233-3791-83bf9ea90bde@huaweicloud.com>
From: Guangwu Zhang <guazhang@redhat.com>
Date: Wed, 22 May 2024 08:46:17 +0800
Message-ID: <CAGS2=YrkFxiQxWCPyuLgdb_DJHkfXm=nCG9egRHpQ9MG8tEXWA@mail.gmail.com>
Subject: Re: [bug report] Internal error isnullstartblock(got.br_startblock) a
 t line 6005 of file fs/xfs/libxfs/xfs_bmap.c.
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, 
	fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Could not reproduce the error after applying your four patches
thanks.

Zhang Yi <yi.zhang@huaweicloud.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=BA=8C 19:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/5/21 18:06, Guangwu Zhang wrote:
> > Hi,
> > I use the below script reproduce the error.
> >
> >         mkdir -p /media/xfs
> >         mkdir -p /media/scratch
> >         dev0=3D$(losetup --find)
> >         dd if=3D/dev/zero of=3D1.tar bs=3D1G count=3D1
> >         dd if=3D/dev/zero of=3D2.tar bs=3D1G count=3D1
> >         losetup $dev0 1.tar
> >         dev1=3D$(losetup --find)
> >         losetup $dev1 2.tar
> >         mkfs.xfs -f $dev0
> >         mkfs.xfs -f $dev1
> >         mount $dev0 /media/xfs
> >         mount $dev1 /media/scratch
> >         export TEST_DEV=3D"$(mount | grep '/media/xfs' | awk '{ print $=
1 }')"
> >         export TEST_DIR=3D"/media/xfs"
> >         export SCRATCH_DEV=3D"$(mount | grep '/media/scratch' | awk '{
> > print $1 }')"
> >         export SCRATCH_MNT=3D"/media/scratch"
> >
> >         git clone git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> >         cd xfstests-dev
> >         make
> >         for i in $(seq 20);do
> >             ./check generic/461
> >         done
> >
> > @YI,  Could you list your 4 patch links here ?  the kernel don't work
> > well after apply the patch [1]
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D5ce5674187c345dc31534d2024c09ad8ef29b7ba
> >
>
> Please try:
>
> 5ce5674187c3 ("xfs: convert delayed extents to unwritten when zeroing pos=
t eof blocks")
> 2e08371a83f1 ("xfs: make xfs_bmapi_convert_delalloc() to allocate the tar=
get offset")
> fc8d0ba0ff5f ("xfs: make the seq argument to xfs_bmapi_convert_delalloc()=
 optional")
> bb712842a85d ("xfs: match lock mode in xfs_buffered_write_iomap_begin()")
>
> Yi.
>
> >
> > Zhang Yi <yi.zhang@huaweicloud.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=BA=8C 13:05=E5=86=99=E9=81=93=EF=BC=9A
> >
> >>
> >> On 2024/5/20 19:48, Guangwu Zhang wrote:
> >>> Hi,
> >>> I get a xfs error when run xfstests  generic/461 testing with
> >>> linux-block for-next branch.
> >>> looks it easy to reproduce with s390x arch.
> >>>
> >>> kernel info :
> >>> commit 04d3822ddfd11fa2c9b449c977f340b57996ef3d
> >>> 6.9.0+
> >>> reproducer
> >>> git clone xfstests
> >>>  ./check generic/461
> >>>
> >>>
> >>
> >> I guess this issue should be fixed by 5ce5674187c3 ("xfs: convert dela=
yed
> >> extents to unwritten when zeroing post eof blocks"), please merge this=
 commit
> >> series (include 4 patches) and try again.
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D5ce5674187c345dc31534d2024c09ad8ef29b7ba
> >>
> >> Yi.
> >>
> >>> [ 5322.046654] XFS (loop1): Internal error isnullstartblock(got.br_st=
artblock) a
> >>> t line 6005 of file fs/xfs/libxfs/xfs_bmap.c.  Caller xfs_bmap_insert=
_extents+0x
> >>> 2ee/0x420 [xfs]
> >>> [ 5322.046859] CPU: 0 PID: 157526 Comm: fsstress Kdump: loaded Not ta=
inted 6.9.0
> >>> + #1
> >>> [ 5322.046863] Hardware name: IBM 8561 LT1 400 (z/VM 7.2.0)
> >>> [ 5322.046864] Call Trace:
> >>> [ 5322.046866]  [<0000022f504d8fc4>] dump_stack_lvl+0x8c/0xb0
> >>> [ 5322.046876]  [<0000022ed00fc308>] xfs_corruption_error+0x70/0xa0 [=
xfs]
> >>> [ 5322.046955]  [<0000022ed00b7206>] xfs_bmap_insert_extents+0x3fe/0x=
420 [xfs]
> >>> [ 5322.047024]  [<0000022ed00f55a6>] xfs_insert_file_space+0x1be/0x24=
8 [xfs]
> >>> [ 5322.047105]  [<0000022ed00ff1dc>] xfs_file_fallocate+0x244/0x400 [=
xfs]
> >>> [ 5322.047186]  [<0000022f4fe90000>] vfs_fallocate+0x218/0x338
> >>> [ 5322.047190]  [<0000022f4fe9112e>] ksys_fallocate+0x56/0x98
> >>> [ 5322.047193]  [<0000022f4fe911aa>] __s390x_sys_fallocate+0x3a/0x48
> >>> [ 5322.047196]  [<0000022f505019d2>] __do_syscall+0x23a/0x2c0
> >>> [ 5322.047200]  [<0000022f50511d20>] system_call+0x70/0x98
> >>> [ 5322.054644] XFS (loop1): Corruption detected. Unmount and run xfs_=
repair
> >>> [ 5322.977488] XFS (loop1): User initiated shutdown received.
> >>> [ 5322.977505] XFS (loop1): Log I/O Error (0x6) detected at xfs_fs_go=
ingdown+0xb
> >>> 4/0xf8 [xfs] (fs/xfs/xfs_fsops.c:458).  Shutting down filesystem.
> >>> [ 5322.977772] XFS (loop1): Please unmount the filesystem and rectify=
 the proble
> >>> m(s)
> >>> [ 5322.977877] loop1: writeback error on inode 755831, offset 32768, =
sector 1804
> >>> 712
> >>> 00:00:00
> >>>
> >>>
> >>> .
> >>>
> >>
> >>
> >
> >
> > --
> > Guangwu Zhang
> > Thanks
> >
>


--=20
Guangwu Zhang
Thanks

