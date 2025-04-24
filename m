Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502F203706
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482117; cv=none; b=p+0mgd+MhNy0EPiio1HwEpDg0NMv9j5FALyIT0Vc35DPMUqSayHNsrZ1YQKZN62Z2zf+tga1XUVCPboBxDquEbTnoZXjkH9qjm/I22pJHVW5avTs+4EytP7IF3KKRhtRE8PBTnnGFyMekN2SOZ1c3PTlU+DiPM4V+7ZsHBaLI5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482117; c=relaxed/simple;
	bh=7LSwA9/RC1GNwfG+lCcud3yw0cCVDeqP5nGelatoTRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtHjUqNRs4Upxa2FeUpCfZ7yHqVp2ot+QUm5z2GMDhRQ/pgodoUq3gHVwPk/vBgNJ8PJjMHgGohJN7y/bGM56DnsDQjaQtTYKPh+QRbGjNjen5lgqzatPXlCtD2V5E02wg4lkpW0QRzr8zoJ/Yz2f7TYz2YqGsPy/9fRBZyOfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6ajkbTx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6ajkbTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745482114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIBcAPIsvRbbtPBYFtUV3aaspfe/f5XOnaHKo0o0ZIA=;
	b=Q6ajkbTxtXYJWfgA+QbBEV1bSdby8b7AWHaGtiyGRhg1FgKMMWEllRm1vMZRVHazym9y7b
	8NxQrhBUkn0Thjt3hM/ANISwi1AjnBNqelSUJqskAk9PVyUHKZbwH5b8B26BKmgpwf6rYu
	1yfN8+6cc4mkQ6aJYk85CqgrafuYsjc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-aHODNue0Mqyf2b6FIepaoA-1; Thu, 24 Apr 2025 04:08:32 -0400
X-MC-Unique: aHODNue0Mqyf2b6FIepaoA-1
X-Mimecast-MFC-AGG-ID: aHODNue0Mqyf2b6FIepaoA_1745482112
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-224192ff68bso6860825ad.1
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 01:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745482112; x=1746086912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIBcAPIsvRbbtPBYFtUV3aaspfe/f5XOnaHKo0o0ZIA=;
        b=EqrkXuw2O4s0kJMWTbfg2cwkam3hepJVINCew9TkHlrtychISWssIHEmYNnoujMYFf
         qmdHXKsJ94RlXiJ/5GMKvDTO8P8PZv9NaZ/bv9MPlYab/Puk7550ylCWPZVcARW6JOhc
         7fwhmYHU7pZLgZa/RIRATtgJmzcP/7W3BznbOpBQAgAsE9EBEHdZtm67QCuXv9qBh3Ks
         p4WCc/GBtQUox4tT4aDTPIHtLpaFcz/TEZQl3Cx+ME04WhXxNO5LqWB46RMQVv7ONr0R
         WLLyGdcNQezJw5/IdA1raXq5xsiwIU8pd7MmrJIqT6d2L2dpfPOeksUAwPuPRLs21Gef
         5uRA==
X-Forwarded-Encrypted: i=1; AJvYcCW2IhhHtTx3T8j03iZdrjRp5BAgAf5NvowULVsJoH64GZWBPKUNJnj3aLz6M9/d8vAZRgF2+6ZY7JOWvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxecKpce6EdH4Cyjll6bujlXSl+x4OPOWkHgcaY5CEebihTuXRa
	D30MBFj/j7YCJy1yIS6MJxzfVVkzQa5ON9z2tnRVfEVt3miuQDj9Woseri4B9TXlZhj4QeCtNdo
	rG8u0OuvDCIwSjoKoJG4Irzxb/zYFOf5E+smwY41lmFSWqpWZ4cCbBjBKEuQNe9sSGerIzA8zJI
	vx8nq82HBC7CTqUvpNlHe70ZTCq8pf8FhFEH4=
X-Gm-Gg: ASbGncvcG5URKEjwlOLps94kHmohu7ANoQvab36a9Pgkw5VfAYCrI1H22HOfHXY+g0S
	EFqFiSSFmjJBVjEA5kvhG/DKRABpuNxj2kd0nst4Jo0NCsV+Pbk9xxbvOS1dTpnlDe9g=
X-Received: by 2002:a17:903:238e:b0:224:1c1:4aba with SMTP id d9443c01a7336-22db3db0f63mr20382345ad.50.1745482111808;
        Thu, 24 Apr 2025 01:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9QCt1+uWV0hbcvfKshe4MEvAT+8cYmunuoojCcFbrOrf3foAV6szwZqkcwyD4r4JChprCKBZyHc1ES6rtmRM=
X-Received: by 2002:a17:903:238e:b0:224:1c1:4aba with SMTP id
 d9443c01a7336-22db3db0f63mr20382045ad.50.1745482111469; Thu, 24 Apr 2025
 01:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422142628.1553523-1-hch@lst.de> <20250422142628.1553523-16-hch@lst.de>
 <11b02dfa-9f71-48ac-9d20-ba5a6e44f289@kernel.org>
In-Reply-To: <11b02dfa-9f71-48ac-9d20-ba5a6e44f289@kernel.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 24 Apr 2025 10:08:19 +0200
X-Gm-Features: ATxdqUFTuhjv2n6cEKl2JrhrhPyh6bRjf4GKJQJ_KzadIMn25rxqpw5We26zq08
Message-ID: <CAHc6FU7Y5QKGB1pFL8A0-3VOX2i5LY92d9AYhWqgHMzxL30m4A@mail.gmail.com>
Subject: Re: [PATCH 15/17] gfs2: use bdev_rw_virt in gfs2_read_super
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, 
	Coly Li <colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 8:23=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
> On 4/22/25 23:26, Christoph Hellwig wrote:
> > Switch gfs2_read_super to allocate the superblock buffer using kmalloc
> > which falls back to the page allocator for PAGE_SIZE allocation but
> > gives us a kernel virtual address and then use bdev_rw_virt to perform
> > the synchronous read into it.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>
> One nit below.
>
> > ---
> >  fs/gfs2/ops_fstype.c | 24 +++++++++---------------
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> > index e83d293c3614..7c1014ba7ac7 100644
> > --- a/fs/gfs2/ops_fstype.c
> > +++ b/fs/gfs2/ops_fstype.c
> > @@ -226,28 +226,22 @@ static void gfs2_sb_in(struct gfs2_sbd *sdp, cons=
t struct gfs2_sb *str)
> >
> >  static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int =
silent)
> >  {
> > -     struct super_block *sb =3D sdp->sd_vfs;
> > -     struct page *page;
> > -     struct bio_vec bvec;
> > -     struct bio bio;
> > +     struct gfs2_sb *sb;
> >       int err;
> >
> > -     page =3D alloc_page(GFP_KERNEL);
> > -     if (unlikely(!page))
> > +     sb =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> > +     if (unlikely(!sb))
> >               return -ENOMEM;
> > -
> > -     bio_init(&bio, sb->s_bdev, &bvec, 1, REQ_OP_READ | REQ_META);
> > -     bio.bi_iter.bi_sector =3D sector * (sb->s_blocksize >> 9);
> > -     __bio_add_page(&bio, page, PAGE_SIZE, 0);
> > -
> > -     err =3D submit_bio_wait(&bio);
> > +     err =3D bdev_rw_virt(sdp->sd_vfs->s_bdev,
> > +                     sector * (sdp->sd_vfs->s_blocksize >> 9), sb, PAG=
E_SIZE,
>
> While at it, use SECTOR_SHIFT here ?

This is hardcoded in several places; I can clean it up separately.

> > +                     REQ_OP_READ | REQ_META);
> >       if (err) {
> >               pr_warn("error %d reading superblock\n", err);
> > -             __free_page(page);
> > +             kfree(sb);
> >               return err;
> >       }
> > -     gfs2_sb_in(sdp, page_address(page));
> > -     __free_page(page);
> > +     gfs2_sb_in(sdp, sb);
> > +     kfree(sb);
> >       return gfs2_check_sb(sdp, silent);
> >  }
> >

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas

