Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5C4A21
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931820; cv=none; b=YFJ71fHj8Irb/wZNqKTKM4JAoI380LTSCh1jukKoHAJ2AjbqXDKYzoYZfeLysTmOjIw4A774niz0aHrtb6rkYNsAvKXfWBnTanWPTnnxiUAYlszyOiyxCD/xW07I8fEpg4IVC+y5/IIhQqY1qeWxrvjve18hjebRmCqhD784B9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931820; c=relaxed/simple;
	bh=8pCGR0oWQsL/zrulkS68E97X7kUV6uH/q9mLsS22jZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYBndWP3wdHSSfgYjBtB11Kg8ooW0PMDxKuPZQUEw6jtA0hpWKrV3bXiSUP8Z7k+xLt2t7vWxtUXevvcNGo4SflzSbAwwst/KKLUdI6HZUSqiCK66R18Bbp2kjbuyE2qrTkwx/Kb+3xar69G/oiuiQctde96UhhDz0sxOxSlGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FxBCAKBY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FxBCAKBY"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2264aefc3b5so14463485ad.0
        for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742931818; x=1743536618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BMCkyqXqh/cZutpqeBhbEl3alZwGc4iqYZYwunOAvY=;
        b=FxBCAKBY6f9/oi0ZrxDyjUYQJheiyBm83ggAg48YsIF6xC6Gu5BtZ46gkHVCWmYLx9
         jkwrzwcQ5sMEEnz1Ax+hOy1mn+IHusItZ90mBbcLRk9cndSBTJWWzsLyGLzZBEDY5Ty2
         Ng1452vJYY2prMJINKwhHs4gSVIdUyt/jaDE0hs+aRiJts9ef6JuOK3cdOhMqzth2jrM
         68LlZRNgbFqFOiuZZtoLZPIrXm7KepJ4+0y5Cf3qDM1VUMPdVFyf5j5wQGnXKORP3mb6
         +gSdHkGMccUV5IgWyFByJnBguc4i6eQ2JLP671wBDNq0y+/amRKmBKvSEPzGxANL7SC+
         NMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742931818; x=1743536618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BMCkyqXqh/cZutpqeBhbEl3alZwGc4iqYZYwunOAvY=;
        b=RicDB1wIvR34wAVIkPG8S65rmRDwIcF3Y691GakLIVl8F+otxP82k2HnhGaKB0extb
         lbFSHIZTgTXcoJ1dVSvXmCtS5FrurnQh5Z4AxSP2S7HwyEar7I0cq+GDvxZVUHggUOD2
         L2rdQHEotp9UC9+7PqLR5wE9scAlcWYLwhsi9/+pfPXZO5WP6Xe5nGzyeGmHacqFPohn
         bgMrSmpvtek2YqZBD76uQcvakoYIz+wQ7h5AuyJcItxbdED9OTlshEYS4PZYiKodTQfF
         Nj4NvTXI55KrZ++Rx5gFB0j4gFYWCRoT3EuGozIqzCw4wmRQ+eGytQeHJzLFUP1YW6yy
         dtMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY+bUFKGq7Zb35WnkiZCZxD/71gM1xJNdm1lonssrXUbazn2FMQU6Z7q+nzk4q8wb3RnvgWjYGJIijOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVdHLTxAiLpK0Eh+vNYWNjESt/qWxC/tk81aqP0PJifN7HN+Z
	w+EY7Dx+sXiJ0rZ4DESMxnsWXSGo5R5lOpNXjbMHNiVdkqxDUy40DSi4OswI5qOPCBCOHwyD0Dx
	xV4fnkZFpviKvtO8TVuVx45nmOC77YdCBYiRNKQ==
X-Gm-Gg: ASbGncu4IJgzb/CaSwULUe8zhhU19LOm51l72SgnVRWDCTBl1MdOIuYqGmGbno04RJt
	LiLyaKmB/3D+C9EeYG4D3qLUvjOgm8Ws2b+atguii04sR55xe+o6zFAftnz04Z2FziPKsX7QqCP
	e0ifXRGP0ewvsLxe4CgWxE9SHz
X-Google-Smtp-Source: AGHT+IHVY3zfJID9ukncnoAFGijme5y/FvdL8B0djR3QSWjPQX12duGznltyLRDp34ibFtM6XKQvELwqmZb+sLiW7EQ=
X-Received: by 2002:a17:903:2306:b0:21f:519:6bc6 with SMTP id
 d9443c01a7336-22780def9c3mr102015095ad.9.1742931817507; Tue, 25 Mar 2025
 12:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324134905.766777-1-ming.lei@redhat.com> <20250324134905.766777-5-ming.lei@redhat.com>
 <CADUfDZo4jmifYJwDRsX0FMemxDiuRu_XG6GV6+drVUOgDk3QwQ@mail.gmail.com> <Z-IDwx3mv6I90hhg@fedora>
In-Reply-To: <Z-IDwx3mv6I90hhg@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 25 Mar 2025 12:43:26 -0700
X-Gm-Features: AQ5f1Jq20vMaXFC5PczMZvnY05Sskpy2habWzGN322yEzlCG3SkcgwB-0xXrcQQ
Message-ID: <CADUfDZpv-EmJy+GZcWL=q5MHg4ovae_kg8k+ewcdrwNTQ_zK9g@mail.gmail.com>
Subject: Re: [PATCH 4/8] ublk: add segment parameter
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:16=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Mar 24, 2025 at 03:26:06PM -0700, Caleb Sander Mateos wrote:
> > On Mon, Mar 24, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > IO split is usually bad in io_uring world, since -EAGAIN is caused an=
d
> > > IO handling may have to fallback to io-wq, this way does hurt perform=
ance.
> > >
> > > ublk starts to support zero copy recently, for avoiding unnecessary I=
O
> > > split, ublk driver's segment limit should be aligned with backend
> > > device's segment limit.
> > >
> > > Another reason is that io_buffer_register_bvec() needs to allocate bv=
ecs,
> > > which number is aligned with ublk request segment number, so that big
> > > memory allocation can be avoided by setting reasonable max_segments l=
imit.
> > >
> > > So add segment parameter for providing ublk server chance to align
> > > segment limit with backend, and keep it reasonable from implementatio=
n
> > > viewpoint.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 15 ++++++++++++++-
> > >  include/uapi/linux/ublk_cmd.h |  9 +++++++++
> > >  2 files changed, 23 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index acb6aed7be75..53a463681a41 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -74,7 +74,7 @@
> > >  #define UBLK_PARAM_TYPE_ALL                                \
> > >         (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> > >          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > > -        UBLK_PARAM_TYPE_DMA_ALIGN)
> > > +        UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > >
> > >  struct ublk_rq_data {
> > >         struct kref ref;
> > > @@ -580,6 +580,13 @@ static int ublk_validate_params(const struct ubl=
k_device *ub)
> > >                         return -EINVAL;
> > >         }
> > >
> > > +       if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
> > > +               const struct ublk_param_segment *p =3D &ub->params.se=
g;
> > > +
> > > +               if (!is_power_of_2(p->seg_boundary_mask + 1))
> > > +                       return -EINVAL;
> >
> > Looking at blk_validate_limits(), it seems like there are some
> > additional requirements? Looks like seg_boundary_mask has to be at
> > least PAGE_SIZE - 1
>
> Yeah, it isn't done in ublk because block layer runs the check, and it
> will be failed when starting the device. That said we take block layer's
> default setting, which isn't good from UAPI viewpoint, since block
> layer may change the default setting.

Even though blk_validate_limits() rejects it, it appears to log a
warning. That seems undesirable for something controllable from
userspace.
/*
 * By default there is no limit on the segment boundary alignment,
 * but if there is one it can't be smaller than the page size as
 * that would break all the normal I/O patterns.
 */
if (!lim->seg_boundary_mask)
        lim->seg_boundary_mask =3D BLK_SEG_BOUNDARY_MASK;
if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
        return -EINVAL;

>
> Also it is bad to associate device property with PAGE_SIZE which is
> a variable actually. The latest kernel has replaced PAGE_SIZE with 4096
> for segment limits.
>
> I think we can take 4096 for validation here.
>
> > and max_segment_size has to be at least PAGE_SIZE
> > if virt_boundary_mask is set?
>
> If virt_boundary_mask is set, max_segment_size will be ignored usually
> except for some stacking devices.

Sorry, I had it backwards. The requirement is if virt_boundary_mask is
*not* set:
/*
 * Stacking device may have both virtual boundary and max segment
 * size limit, so allow this setting now, and long-term the two
 * might need to move out of stacking limits since we have immutable
 * bvec and lower layer bio splitting is supposed to handle the two
 * correctly.
 */
if (lim->virt_boundary_mask) {
        if (!lim->max_segment_size)
                lim->max_segment_size =3D UINT_MAX;
} else {
        /*
         * The maximum segment size has an odd historic 64k default that
         * drivers probably should override.  Just like the I/O size we
         * require drivers to at least handle a full page per segment.
         */
        if (!lim->max_segment_size)
                lim->max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
        if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
                return -EINVAL;
}

Best,
Caleb
