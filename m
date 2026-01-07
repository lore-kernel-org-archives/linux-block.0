Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269335EDB9
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807929; cv=none; b=gTV8APjWp8ZsxpDqO7oMgBBIdgGK9dctLqA8xdfyYyh3JrUajZsQhwpcF0r2e7N7UE1nE2HS+1EH0WGRm+eB1FTouqrdBLcG3NqtWFteFYSbFlpkPKPtNdCjIml7VUD4njXG3GrfAtAZ5aIppnZyx0Vz1rSQMlWFHjcyB/YZIvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807929; c=relaxed/simple;
	bh=jCKjePub3POo12duPtYPOuSdHEgDLQZESG1PLQByCW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxBV6Ik1E26hmPwBp/dEQHYpUiQN7S8z7ExGscLsPJGWJcLPMDItkdCGgtilDR6a7CCRZ2uQPDPgXZcmyu26LhOwQn7kngN8CrNS4dP0G/xY9HJqYuVrhiT2Dx/UpVhWjdNQp0PuzBNTRnOhj2H9dcIOsCbSKWAntkv7YibkJnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WHiLiGgg; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WHiLiGgg"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11dd21d402cso81428c88.2
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 09:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767807922; x=1768412722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foZsXxtRErGvrhfIirA1Tid8BKr7EP+JHKEkLuwIADo=;
        b=WHiLiGggcACeXS3mPM9Dxr9m6Lld59I2nTw+jT9ZATnbDxiPIQniGTS9d9h03G1CAD
         qcTNOOp1ZHV3gVZQT5zGy3EUmsMH5Nur2bU3tuEbMqxKBBR7Yc5vckC/9+e4E9EQfZ/Q
         av7DjQwsm7uF4l9LPoftSfMvEGf2Ggq94Gg5BIEOQ0VDZ4s3jZmRmr1uzY93PlwHJMk1
         NJOGP6Nej1WkgIr7LrcKSYOYnlmdJTstHvA6mbwACaObcMrW/flBBAJIE8IF7vzppQTU
         HWVvOheyIxDmOmIDfXLXWrUDZPnqMWX402ECoK712WFfwMx58w9t8HcvMSicu/kqJWcj
         au9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807922; x=1768412722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foZsXxtRErGvrhfIirA1Tid8BKr7EP+JHKEkLuwIADo=;
        b=lBoBGVW4bC3wFl5teq+81THnyVl/In3bd4IaqePadNcTcRPqdlic7vyPxvo5+nECF2
         Gt4yshzhgIp3vxfwniGLNFS4juxDQkJtnPVtKZOUZG4VSUorrX6pDtCpb+VudH2nVcXc
         l/4w6859m1J5L2iJFDOwi4ZchP8mWVvg8V/MspZVCDqv5omIrFYv1hBZR8wPPVQQ9tzE
         BhF2RC5LzfD9dliisQIOncNWpsjLT4YRWH50IUb0lFmGrBfdoatc1Y92JgADnFA+32vu
         Drz9qWYw33Pb4PcqySuA7TJB5iTNBSQukGjQOnLzO3dEqz3JPn6hb32+B0TuchsPuhGg
         ++aw==
X-Forwarded-Encrypted: i=1; AJvYcCUiuc2YyQ+TtgGd/8MbeE17xfrv/uMym6878RbWVgVdvIh+/Mtcl0kLk3zS1flf1PmfzGSkgfeVfrRFEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YykgNiDS7y1cPK2A4MmHMPl81CLlR/XJZ7EfAeQwlJkS/GkpDUx
	DB/Qpyvex+d7OD9+e1ZskOSoCAL2WyR4ANTF4/z/Vb2MvevtIDY/9GLW9YtxBf4gCl1H1Sfntbf
	KNMaHcAO4IFmDwCmYq5XgRSBUh+6eWkIUvrUpx3c3tQ==
X-Gm-Gg: AY/fxX4w0lPS50iej1BFMRbJSoi70iQGszubWPyc6UAoGiIHv34a+E9bYtg+YoXZXDZ
	l0I1YOdDU6AkZk2/6ApYlsYPsXqeKCiluq/pALQJ+UzCFzVgdpBCjgGPFZ2lHxqgUHZTOsBsRRF
	IA0a1P5uQiFwAMj4rtDBPv+JmqHYlrWpSTDUQiTZ+V2S38hiuIrd/EY671j0taqVNrkeNKhUBsq
	oxmN0I6W8eofYkw2ZwrwgGyyv8Zfl21oMRlSvv7ELmXuGNEIC+gUlbV5wrYo880QWyQhuJj
X-Google-Smtp-Source: AGHT+IHE4mNx6/EMhhE5Or86ECvZZOb/iAYbIUUmJtHg2DAtEbvcnnTp6HLgFs9IPt8sjIMcE7uikPBBa3Di7ryRAg8=
X-Received: by 2002:a05:7022:6723:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-121f8b7d702mr1418887c88.4.1767807922014; Wed, 07 Jan 2026
 09:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103004529.1582405-1-csander@purestorage.com>
 <20260103004529.1582405-5-csander@purestorage.com> <aVkkSxNNUBMz9E61@fedora>
 <CADUfDZqF2rWRQVptMjM7JedkkHfM-K+V65=odLcdrc3OM9jsJg@mail.gmail.com> <aVxrih4F_V58QM3S@fedora>
In-Reply-To: <aVxrih4F_V58QM3S@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 7 Jan 2026 09:45:08 -0800
X-Gm-Features: AQt7F2oQrIk8nn83VQl3xbYGKbxt4bDu3LODYmdTykNvo8yQW48q6KDA6Ua86Y8
Message-ID: <CADUfDZpyYfUGC0zD76E--xVMOwBsf_NoLwax2n+0fVBOAjAODA@mail.gmail.com>
Subject: Re: [PATCH v2 04/19] ublk: set request integrity params in ublksrv_io_desc
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 5:55=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 08:44:48AM -0800, Caleb Sander Mateos wrote:
> > On Sat, Jan 3, 2026 at 6:14=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Fri, Jan 02, 2026 at 05:45:14PM -0700, Caleb Sander Mateos wrote:
> > > > Indicate to the ublk server when an incoming request has integrity =
data
> > > > by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags fi=
eld.
> > > > If the ublk device doesn't support integrity, the request will neve=
r
> > > > provide integrity data. If the ublk device supports integrity, the
> > > > request may omit the integrity buffer only if metadata_size matches=
 the
> > > > PI tuple size determined by csum_type. In this case, the ublk serve=
r
> > > > should internally generate/verify the protection information from t=
he
> > > > data and sector offset.
> > > > Set the UBLK_IO_F_CHECK_{GUARD,REFTAG,APPTAG} flags based on the
> > > > request's BIP_CHECK_{GUARD,REFTAG,APPTAG} flags, indicating whether=
 to
> > > > verify the guard, reference, and app tags in the protection informa=
tion.
> > > > The expected reference tag (32 or 48 bits) and app tag (16 bits) ar=
e
> > > > indicated in ublksrv_io_desc's new struct ublksrv_io_integrity inte=
grity
> > > > field. This field is unioned with the addr field to avoid changing =
the
> > >
> > > It might be fine to set per-rq app_tag, but bios in one request might=
 have
> > > different app_tag in case of io merge actually.
> >
> > I based this logic largely on the code under if (ns->head->ms) in
> > nvme_setup_rw(). That also assumes a single app_tag for the request.
> > Sounds like an existing bug if bios with different app_tags can be
> > merged together?
>
> Looks it is true.
>
> >
> > >
> > > Also block layer builds ref_tag for each internal, please see
> >
> > What do you mean by "internal"? "interval"?
> >
> > > t10_pi_generate() and ext_pi_crc64_generate().
> >
> > Yes, the reftag increases by 1 for each integrity interval. That's why
> > it suffices for an NVMe command reading multiple blocks to specify
> > only the expected reftag for the first block; the reftags for
> > subsequent blocks are incremented accordingly.
> >
> > Actually, I think we probably don't need to communicate the reftag
> > seed to the ublk server. NVMe doesn't use the reftag seed (which can
> > be overridden by struct uio_meta's seed field). Instead,
> > nvme_set_ref_tag() always uses the offset into the block device
> > divided by the integrity interval size, as required by all the
> > existing csum_type formats the kernel supports. So a ublk server could
> > just use the start_sector field of struct ublksrv_io_desc to compute
> > the expected reftags. And using start_sector as the reftag also means
> > merging requests would preserve their expected reftags.
>
> IMO, this way looks fine from user viewpoint, especially aligning with NV=
Me.
>
> >
> > >
> > > So looks this way is wrong.
> > >
> > > More importantly reusing iod->addr for other purpose not related with=
 IO
> > > buffer is very unfriendly for adding new features, and one lesson is =
for ZONED support
> > > by reusing ublksrv_io_cmd->addr for zoned's append lba.
> >
> > That's a fair point.
>
> One candidate is add per-IO mmaped meta area, which can be flexible to
> cover more use cases.
>
> >
> > >
> > > For example, there is chance to support dma-buf based zero copy for u=
blk, and
> > > please see the io-uring dma-buf support[1], and iod->addr might carry=
 IO buffer info
> > > in dma-buf format in future.
> > >
> > > [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silenc=
e@gmail.com/#t
>
> BTW, PI data size is often small, and it belongs to kernel, there could b=
e

The integrity data buffer isn't necessarily kernel memory. With
IORING_RW_ATTR_FLAG_PI, userspace can use a buffer from its address
space for the integrity data.

> chance to define PI data as pre-mapped DMA-BUF, then almost all drivers c=
an
> benefit from avoiding the runtime dma mapping for meta. But that may be o=
ne
> bigger thing.

Yes, I think it would be a significant amount of work to use
pre-mapped buffers for integrity data. I'd like to avoid that in this
patch set and focus on just the ublk integrity data support.

>
> > >
> > >
> > > > size of struct ublksrv_io_desc. UBLK_F_INTEGRITY requires
> > > > UBLK_F_USER_COPY and the addr field isn't used for UBLK_F_USER_COPY=
, so
> > > > the two fields aren't needed simultaneously.
> > > >
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c      | 43 +++++++++++++++++++++++++++++++=
----
> > > >  include/uapi/linux/ublk_cmd.h | 27 ++++++++++++++++++++--
> > > >  2 files changed, 64 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index 2f9316febf83..51469e0627ff 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -316,10 +316,36 @@ static inline bool ublk_dev_is_zoned(const st=
ruct ublk_device *ub)
> > > >  static inline bool ublk_queue_is_zoned(const struct ublk_queue *ub=
q)
> > > >  {
> > > >       return ubq->flags & UBLK_F_ZONED;
> > > >  }
> > > >
> > > > +static void ublk_setup_iod_buf(const struct ublk_queue *ubq,
> > > > +                            const struct request *req,
> > > > +                            struct ublksrv_io_desc *iod)
> > > > +{
> > > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > > > +     if (ubq->flags & UBLK_F_INTEGRITY) {
> > > > +             struct bio_integrity_payload *bip;
> > > > +             sector_t ref_tag_seed;
> > > > +
> > > > +             if (!blk_integrity_rq(req))
> > > > +                     return;
> > > > +
> > > > +             bip =3D bio_integrity(req->bio);
> > > > +             ref_tag_seed =3D bip_get_seed(bip);
> > >
> > > As mentioned, t10_pi_generate() and ext_pi_crc64_generate() builds
> > > per-internal ref tag.
> >
> > As mentioned, the reftags for subsequent intervals can be computed by
> > simply incrementing the seed. If the seed is assumed to always be
> > start_sector >> (interval_exp - SECTOR_SHIFT), then it may not be
> > necessary to communicate ref_tag_seed at all.
>
> Fair enough, but this should be documented in UAPI interface.
>
> >
> > >
> > >
> > > > +             iod->integrity.ref_tag_lo =3D ref_tag_seed;
> > > > +             iod->integrity.ref_tag_hi =3D ref_tag_seed >> 32;
> > > > +             iod->integrity.app_tag =3D bip->app_tag;
> > >
> > > In case of io merge, each bio may have different ->app_tag.
> >
> > It seems like it would make more sense to prevent merging bios with
> > different app_tags. In the common case where a request contains a
> > single bio, which has a single app_tag, it would be much more
> > efficient to communicate only the 1 app_tag instead of having to pass
> > a separate app_tag for every logical block/integrity interval.
>
> OK.
>
> >
> > >
> > > Given you have to copy meta data via user copy, I suggest to follow t=
he PI
> > > standard and make it per-internal.
> >
> > How are you suggesting the ublk server access bip->app_tag and
> > bip_get_seed(bip) (if overriding the reftag seed is supported)? Would
> > the ublk server need to make another user copy syscall?
> >
> > Or would you prefer I drop the BIP_CHECK_* flag support from this
> > patch set for now?
>
> I can understand the motivation, and extra syscall should be avoided for
> communicating reftag & apptag only, given you have explained both can be
> per-request instead of per-interval.
>
> But iod->addr should be avoided for this purpose, otherwise, new feature
> can conflict with this usage easily.
>
> But per-io mmapped area can solve this issue, the meta size can be one pa=
rameter
> of `ublksrv_ctrl_dev_info` with feature flag of UBLK_F_MMAPED_IO_META, wh=
at
> do you think of this way?

Are you thinking this userspace-mapped region would consist of one u16
app_tag per ublk I/O descriptor? It seems a bit complex to introduce
an additional userspace-mapped region just to communicate the app_tag.
What do you think about making the size of the I/O descriptor
information dependent on the feature flags? Basically extend
ublksrv_io_desc with an app_tag field if UBLK_F_INTEGRITY is set. This
mechanism could be extended to communicate other per-request
information in the future.

Thanks,
Caleb
