Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F03594E;
	Fri, 25 Jul 2025 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753418257; cv=none; b=WBakyrHkNSIht/9rmYWQORClGCAd6w4KYSYViq1NlLS3fq1Z+34LsCnRzR1Kj9IIzDMEKcTGCdLU7Y13AwSO+XnvnRrRkb5CeY6mUWOmVZ4Afo/CXGnSM6tynjSH7zu/BB8EFUeyVjmM6cIOuKdTVukdYLxszhuLpqWGXB5KC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753418257; c=relaxed/simple;
	bh=FrGZQqhqiJNfiy8XaaJy1KHk9OErj3qSStWy5M2KbD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jbf98UtvlgpnnLzU1NnPNSXiXN/Gyywub5UWBv58e7kxGSOnRcWtJN/AR5wA4ju/1kPbjmD3N7dPouLq0ySMBnMZH++mdYPUwPJ27bSt1Z/vBSKWmgt0JbH9E8tNz6YUB/GNBWui6TniuJR7xV8LmYt2WM5uHWGMz80eFzfLthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4R8mCiH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4R8mCiH"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so276025666b.2;
        Thu, 24 Jul 2025 21:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753418254; x=1754023054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5qfbmAa22Zw0aVP198gDNOWjHFGpsuuIMHC3dQwPbw=;
        b=B4R8mCiHUj2bexIt9R5ydzYJR5aDTomeFd2Z+9RLYCLtlRQHas9dxPbfNBaqbqioth
         p513fQgeqOvSCr5Re6oNdJ4RharZgNglvkhOXr6MANkrb8f71GuXVGycBZQPz1vAfNgo
         qPPRKj/VTjdp1CDnhabkU004Xz9g/8binJl+V2b/MI4CD2EjlxdLoMDJsZBAmM+BQPIg
         BjLcHPpQyuoegFe/IEpzwJKpPSa9qKrH9zwoLJwC2Mf21bWXK3UQ4DDsx2DkK7ODpMrA
         JWeKu3cutnZ8/YytR7VCIriw01jmB2h5CsirJhsdvHCa/GDKweyD0j9azV6vR7oobWDA
         HUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753418254; x=1754023054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5qfbmAa22Zw0aVP198gDNOWjHFGpsuuIMHC3dQwPbw=;
        b=pMBIkwMNHX+EtZRGavFi9HW971eBf3Pe6L9d24xSM11/vq7BQeCFqOvUdpsT/rrygB
         un6BbyFq3Jy0TG8AbAKi+024r+2lg0TrvJwbIhUAflul77NDYlCDWlBP916lzvgm055F
         sKbcUwaXFaaRxM1CzuxqkKYt83vzBPjIP8G5ZVVMu4oHRWtd2YTajJs+Vw6Z5b73S8M/
         KVhdLmSuMiQknk/CO+pubwMNGq99I0JD8UZXSfiQHei9AzoPZ/TM5pMTtWME3PVEg5x/
         juYi1TkeA9t99v6YHpvhtpYfF162cvSmWQ3kk+2o3NPs3De93uczpG5FuspyiOqN38cM
         +x4g==
X-Forwarded-Encrypted: i=1; AJvYcCWfu5mBAv512+L6IKbju1XlEX+XoxkXeU0QmWVEyE4J/L/I07ulCsaWp7kCAEfkhRq0DgMph2y7avYOag==@vger.kernel.org, AJvYcCXzkHNN1kzU6Q9evWABI8H6TlD/0XNCNJmf6yw6H6qr/CdUodo5EUWATCzbiwS50jS4v/tiVpgG6Py2wFQo@vger.kernel.org
X-Gm-Message-State: AOJu0YyrS5bCHFaLJmXhDZMZoVvEpFF8Ahje2tBB/EqeHdA7FHZPFpq7
	1L+AdQvHyCo0sgfYGgSe3xviTAwZnP6FnFkgfgtpFoxKYYGJtl25rptptOKYdEGga9z+OChOCt/
	K6wrA8k0n5IVPvyiSeoIXLSeWUpfLNmgowc3HQ3vd
X-Gm-Gg: ASbGnct/RhsxsVdkRP+JHjaHHnLK18119lE3X9VFSKhWc7ZSaBlEK7rc+jYqHUcXDqe
	NmHs+MpRH4Q3hMFdUY1g5GqbuFxg/4rmUQfrHCTW2vE15YvBGa9VnVC+PAH/e/6QpKHAZZBzqiu
	9qUJXYB0fDaqQC4eNA4d5xuVbYKFCvzln1VIp9naWFjnbtHS0tF4GCM3rQqpJLWV8bDQf10r7Uj
	Gs+yQRWaiFPxBOyEBcr4mN35Oao9D3b/ZOQ02SkpGoyj3vY
X-Google-Smtp-Source: AGHT+IHN4e+8xOJtDrQmUijtD9Yq0H/dZiT8+QWZHZqgY+m3xxDFwmJUyWJnbohaK8bPXNhfTi3ahO5MmQ3Z9S+XUoU=
X-Received: by 2002:a17:907:2d28:b0:ae0:da2f:dcf3 with SMTP id
 a640c23a62f3a-af61a0f7525mr61470466b.59.1753418253526; Thu, 24 Jul 2025
 21:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711084708.2714436-1-arnd@kernel.org> <szmagqqo6lx36ozaqd5qf72xnzoi4e23jbfehjli6rfbvhps6w@if2cvmlgvmxv>
 <b6346235-cc66-4ce0-8768-52a1a89fd699@app.fastmail.com> <u67ijiie6n2w3crfpuipprrmkocja7bxadlo3sbr47w7hysjgj@rjduhmczwwdz>
In-Reply-To: <u67ijiie6n2w3crfpuipprrmkocja7bxadlo3sbr47w7hysjgj@rjduhmczwwdz>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 25 Jul 2025 10:06:55 +0530
X-Gm-Features: Ac12FXwTiBt13Lx9Z4RABH16IySuYuSuKUjMY43hsoMpk7aPA4d3WeI2CipenNs
Message-ID: <CACzX3AsRd__fXb9=CJPTTJC494SDnYAtYrN2=+bZgMCvM6UQDg@mail.gmail.com>
Subject: Re: [PATCH] [v2] block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()
To: Klara Modin <klarasmodin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Caleb Sander Mateos <csander@purestorage.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 3:46=E2=80=AFPM Klara Modin <klarasmodin@gmail.com>=
 wrote:
>
> On 2025-07-18 07:56:49 +0200, Arnd Bergmann wrote:
> > On Fri, Jul 18, 2025, at 01:37, Klara Modin wrote:
> >
> > >> diff --git a/block/ioctl.c b/block/ioctl.c
> > >> index 9ad403733e19..af2e22e5533c 100644
> > >> --- a/block/ioctl.c
> > >> +++ b/block/ioctl.c
> > >> @@ -566,9 +566,11 @@ static int blkdev_common_ioctl(struct block_dev=
ice *bdev, blk_mode_t mode,
> > >>                           void __user *argp)
> > >>  {
> > >>    unsigned int max_sectors;
> > >> +  int ret;
> > >>
> > >> -  if (_IOC_NR(cmd) =3D=3D _IOC_NR(FS_IOC_GETLBMD_CAP))
> > >> -          return blk_get_meta_cap(bdev, cmd, argp);
> > >
> > >> +  ret =3D blk_get_meta_cap(bdev, cmd, argp);
> > >> +  if (ret !=3D -ENOIOCTLCMD)
> > >> +          return ret;
> > >
> > > This check seems to be incomplete. In the case when BLK_DEV_INTEGRITY=
 is
> > > disabled the ioctl can never complete as blk_get_meta_cap will then
> > > always return -EOPNOTSUPP. Or should the !BLK_DEV_INTEGRITY stub be
> > > changed to return -ENOIOCTLCMD instead?
> >
> > Ah, I did miss the stub.
> >
> > > It makes e.g. cryptsetup fail in my initramfs. Adding -EOPNOTSUPP to =
the
> > > check fixes it for me:
> > >
> > > diff --git a/block/ioctl.c b/block/ioctl.c
> > > index af2e22e5533c..7d5361fd1b7d 100644
> > > --- a/block/ioctl.c
> > > +++ b/block/ioctl.c
> > > @@ -569,7 +569,7 @@ static int blkdev_common_ioctl(struct block_devic=
e
> > > *bdev, blk_mode_t mode,
> > >     int ret;
> > >
> > >     ret =3D blk_get_meta_cap(bdev, cmd, argp);
> > > -   if (ret !=3D -ENOIOCTLCMD)
> > > +   if (ret !=3D -EOPNOTSUPP && ret !=3D -ENOIOCTLCMD)
> > >             return ret;
> > >
> > >     switch (cmd) {
> >
> > I think returning -ENOIOCTLCMD from the stub makes more sense,
> > but I don't know what the motivation for the -EOPNOTSUPP was.
> >
> >      Arnd
>
> Should I send a patch changing the stub? At least from reading
> Documentation/driver-api/ioctl.rst it seems clear that only -ENOIOCTLCMD
> or -ENOTTY is correct when the command number is unknown.
>
> I didn't find any particular reason in 9eb22f7fedfc ("fs: add ioctl to
> query metadata and protection info capabilities") for the -EOPNOTSUPP
> return.

Hi Klara,

Thanks for pointing this out =E2=80=94 I had originally used -EOPNOTSUPP
because the ioctl command is recognized, but the operation isn=E2=80=99t
supported when CONFIG_BLK_DEV_INTEGRITY=3Dn.
That said, I agree that returning -ENOIOCTLCMD from the stub might be
more appropriate in this context.

Thanks,
Anuj

>
> Regards,
> Klara Modin
>
