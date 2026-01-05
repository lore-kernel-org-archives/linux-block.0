Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366F28B40E
	for <linux-block@vger.kernel.org>; Mon,  5 Jan 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631502; cv=none; b=Mi6GgZ6bHSdY/c7QhNccPYp25z3ooW3tUnWphkhLtQMBSFO9on05s07SqeQzqyAr3FLTrIC58ZHTwT06+Rg2iH7mMP3f4sUUa10PRv7dZ81ximkoNSezJAnoYtaq+uWzdMjZInGzEaqDHsFdTrZ2yNJ3eSKQskMfcOyC2J+565M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631502; c=relaxed/simple;
	bh=q3oBIJBCKsgETtCPP1VXg2X9fdRdjcqRRDj8EfShKmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMtHNB3kpiyg6V2qmVtbvqIiMX8XiBQbRKcfj0dUcLB9XVCWGbP7vQyzmegg1XWZZ1n3sSCXmVQ3zmgdKAUVTnHiE5+aYV7m2PE6QbEetaELrmNQCWSqZFMh8QHucCmWYNNWzyhJfSste/qLgojdaMd6ksN08QMPbnq6QFPDQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dgiBx5Bl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dgiBx5Bl"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-802e9abb429so21221b3a.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767631500; x=1768236300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6BL2qPpVVqiVwXY3IB51McHsnbFfXZf1WvJyfM78Xk=;
        b=dgiBx5BlzLP/Ac9sW4gKVy6SEc1PSKMUt8WxGEEmLugL3iSMye3W/7CSXkyYzqn0YC
         p3yszztnQy/B5FjrWkH121uWLhZJ4nE9SceH5Fh9WWaFS4TxYErtvLdCFTU5Oyj7pKi8
         yvOJnYug0j0S3RD8axAMeu7Ayw7TP+onu9hJCu+cyPAJnzc+GgM/oNDl5gG8nVop9UOy
         /4rQvsSZkmYGQIvXDzpYliVP/s88blwyxdQ4cv1CJPLuildY5bSa5AJLWiJJ6vJMkPJQ
         aL87zu4SRfRAa9y/jw6fR2hbTqdom1XIyMo1zapI0cEddGYQo+u3bLguPcxYJ+xnoAgE
         uxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631500; x=1768236300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6BL2qPpVVqiVwXY3IB51McHsnbFfXZf1WvJyfM78Xk=;
        b=mgJ1hQKTlL+rRk8nl2YQWuuP5h67852owfqrVeweryvNrOyQiqHX7SHxq6/ssc/YED
         nPEXSHCSZEIDyaFhi2O37OMRlVOWUd8+KlZN2/3yujDrjpt/pLpLkQTeha4rKe1FcUOQ
         MfEvr3xh+fGyRhfXETv5mrT75szmekoP8wmyr2VbAjvFh2nsBA5cxMAGDkbRkvthq76p
         uGXPCLSApeLK8KoYX52Bwp+Ej/VmJX0KURBzWfg3s5l6L1QkqRggTllwDu4CqoSWvxgy
         aJ7vHstizBnTZrmeA+KV7vOHcvX8JMpuvnZ0q1Og2de0FQR9mTmWi3bz+Phr8pu2gRZO
         lKTA==
X-Forwarded-Encrypted: i=1; AJvYcCV1+ubKsXV4IFAIOXBdyfbCe1NHpC047VtN1ortiECSlKBLF2FNGG5k+CC8WB46ZjzaZnURK6uKFZbVrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp81eCdstDkl2O4SUF4niv0HwJ9K87CReJfsxkR/00MKfQzqhU
	itMhHblZDtfl0gK5z0Uql2keP1QRz/AOTxKvf//y+DmwPj9fLD9gVsAxcFKxVPEuw+4KV7mlxMr
	s/ugkZ84B9oCFO+ORt7LGPBeXfsa3Rcmf7Y+zNvDfMQ==
X-Gm-Gg: AY/fxX4Ee8aqSERq1uOZyIqUTNRs+XTklUoRwpycJyZZgwYw0gHrE6EGEhEKHXwBfUh
	RI95PVyZKHfBWBNvh3DWrspbCMgAvKpyIoj+g67PldxL3c6Ts+PLx7syD8/+YzS+C1miu/KEIK6
	Jla85fC0pLWhQJQtWmU0P3W56ZxZAg+5e1lNsu/MnEjjeRVSmpmjDtp27ycyYrjWoUkOBz+UuwD
	B+emyrG2qJPkJ5+cxpz//bKF0SzmOSKExmRRWleN5HkdZBBdr3OQZwwBFFU2iMziVmjiqux
X-Google-Smtp-Source: AGHT+IF8k9ZANyOFgf4uVHZiLOyEIYQd/42XmN4OjyQ1CnRUZ4eFH6gAsgBHijDU+QbTdIeIftviRS4WQOARay1ZyAA=
X-Received: by 2002:a05:7022:4298:b0:11e:3e9:3e9b with SMTP id
 a92af1059eb24-121723088c9mr25211029c88.6.1767631499550; Mon, 05 Jan 2026
 08:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103004529.1582405-1-csander@purestorage.com>
 <20260103004529.1582405-5-csander@purestorage.com> <aVkkSxNNUBMz9E61@fedora>
In-Reply-To: <aVkkSxNNUBMz9E61@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 5 Jan 2026 08:44:48 -0800
X-Gm-Features: AQt7F2oLATeVcsBIU8okZcBk_MFEK1W5141SRB_Yq7_1i_fxRUD7vLCBZiqM1qY
Message-ID: <CADUfDZqF2rWRQVptMjM7JedkkHfM-K+V65=odLcdrc3OM9jsJg@mail.gmail.com>
Subject: Re: [PATCH v2 04/19] ublk: set request integrity params in ublksrv_io_desc
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 6:14=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Fri, Jan 02, 2026 at 05:45:14PM -0700, Caleb Sander Mateos wrote:
> > Indicate to the ublk server when an incoming request has integrity data
> > by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.
> > If the ublk device doesn't support integrity, the request will never
> > provide integrity data. If the ublk device supports integrity, the
> > request may omit the integrity buffer only if metadata_size matches the
> > PI tuple size determined by csum_type. In this case, the ublk server
> > should internally generate/verify the protection information from the
> > data and sector offset.
> > Set the UBLK_IO_F_CHECK_{GUARD,REFTAG,APPTAG} flags based on the
> > request's BIP_CHECK_{GUARD,REFTAG,APPTAG} flags, indicating whether to
> > verify the guard, reference, and app tags in the protection information=
.
> > The expected reference tag (32 or 48 bits) and app tag (16 bits) are
> > indicated in ublksrv_io_desc's new struct ublksrv_io_integrity integrit=
y
> > field. This field is unioned with the addr field to avoid changing the
>
> It might be fine to set per-rq app_tag, but bios in one request might hav=
e
> different app_tag in case of io merge actually.

I based this logic largely on the code under if (ns->head->ms) in
nvme_setup_rw(). That also assumes a single app_tag for the request.
Sounds like an existing bug if bios with different app_tags can be
merged together?

>
> Also block layer builds ref_tag for each internal, please see

What do you mean by "internal"? "interval"?

> t10_pi_generate() and ext_pi_crc64_generate().

Yes, the reftag increases by 1 for each integrity interval. That's why
it suffices for an NVMe command reading multiple blocks to specify
only the expected reftag for the first block; the reftags for
subsequent blocks are incremented accordingly.

Actually, I think we probably don't need to communicate the reftag
seed to the ublk server. NVMe doesn't use the reftag seed (which can
be overridden by struct uio_meta's seed field). Instead,
nvme_set_ref_tag() always uses the offset into the block device
divided by the integrity interval size, as required by all the
existing csum_type formats the kernel supports. So a ublk server could
just use the start_sector field of struct ublksrv_io_desc to compute
the expected reftags. And using start_sector as the reftag also means
merging requests would preserve their expected reftags.

>
> So looks this way is wrong.
>
> More importantly reusing iod->addr for other purpose not related with IO
> buffer is very unfriendly for adding new features, and one lesson is for =
ZONED support
> by reusing ublksrv_io_cmd->addr for zoned's append lba.

That's a fair point.

>
> For example, there is chance to support dma-buf based zero copy for ublk,=
 and
> please see the io-uring dma-buf support[1], and iod->addr might carry IO =
buffer info
> in dma-buf format in future.
>
> [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gm=
ail.com/#t
>
>
> > size of struct ublksrv_io_desc. UBLK_F_INTEGRITY requires
> > UBLK_F_USER_COPY and the addr field isn't used for UBLK_F_USER_COPY, so
> > the two fields aren't needed simultaneously.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c      | 43 +++++++++++++++++++++++++++++++----
> >  include/uapi/linux/ublk_cmd.h | 27 ++++++++++++++++++++--
> >  2 files changed, 64 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 2f9316febf83..51469e0627ff 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -316,10 +316,36 @@ static inline bool ublk_dev_is_zoned(const struct=
 ublk_device *ub)
> >  static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
> >  {
> >       return ubq->flags & UBLK_F_ZONED;
> >  }
> >
> > +static void ublk_setup_iod_buf(const struct ublk_queue *ubq,
> > +                            const struct request *req,
> > +                            struct ublksrv_io_desc *iod)
> > +{
> > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > +     if (ubq->flags & UBLK_F_INTEGRITY) {
> > +             struct bio_integrity_payload *bip;
> > +             sector_t ref_tag_seed;
> > +
> > +             if (!blk_integrity_rq(req))
> > +                     return;
> > +
> > +             bip =3D bio_integrity(req->bio);
> > +             ref_tag_seed =3D bip_get_seed(bip);
>
> As mentioned, t10_pi_generate() and ext_pi_crc64_generate() builds
> per-internal ref tag.

As mentioned, the reftags for subsequent intervals can be computed by
simply incrementing the seed. If the seed is assumed to always be
start_sector >> (interval_exp - SECTOR_SHIFT), then it may not be
necessary to communicate ref_tag_seed at all.

>
>
> > +             iod->integrity.ref_tag_lo =3D ref_tag_seed;
> > +             iod->integrity.ref_tag_hi =3D ref_tag_seed >> 32;
> > +             iod->integrity.app_tag =3D bip->app_tag;
>
> In case of io merge, each bio may have different ->app_tag.

It seems like it would make more sense to prevent merging bios with
different app_tags. In the common case where a request contains a
single bio, which has a single app_tag, it would be much more
efficient to communicate only the 1 app_tag instead of having to pass
a separate app_tag for every logical block/integrity interval.

>
> Given you have to copy meta data via user copy, I suggest to follow the P=
I
> standard and make it per-internal.

How are you suggesting the ublk server access bip->app_tag and
bip_get_seed(bip) (if overriding the reftag seed is supported)? Would
the ublk server need to make another user copy syscall?

Or would you prefer I drop the BIP_CHECK_* flag support from this
patch set for now?

Thanks,
Caleb
