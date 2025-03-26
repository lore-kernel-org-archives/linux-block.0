Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BC1F63E8
	for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007408; cv=none; b=fWuSnl0oK0nSkB5Ic+cFkjEeoI2swx6smiqRigPYiufWBeingwT+NBnoTxHilTJIbqlBciVZ0p1cKuqYmZmRLL1J/oMC6RKEl3iCv1jiHZeEwHX2GVyIXTuFUTseZl2zLbKM7nvEzBxjlMUoJKJ7a5wp1VYbHYdIIsFU4J+iJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007408; c=relaxed/simple;
	bh=n6+3qn0dgMDhLyTF7igz+yOUvAFAF7NoKlECeCu5EKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9fPFpUhaOWlnj4AVzhlrDdy78eJGU/20a9EG1HdswiVOrCOZXLv0fHXvj9Wtnd9RQKb2bWa0E52fmfl7WtSOSIIdbMy3R5EjX6MS1L0dqqB1/vVlbCwJTLdWiP6SMi9TzFwkwm4FqaxAh6BiUZOoCb585lHxAHHiSGwgkJDXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XtlLre1O; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XtlLre1O"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so1910240a91.0
        for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743007406; x=1743612206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLzOQ+BdGkOXJhBkBzUQ0CiAN35NUo3v4I6j8y4k9CM=;
        b=XtlLre1O9b5N0ZGc4GbDSJiZ3koWGzst/xki4CZJhOPjYsXta0XQlPJsTLgeDCcrQv
         8EXcMB+GT5ibxB3oWif8BWhtM6LHBu+KHD3KUfDHLQFmSYYils5uuBzox9zOiAdyO8Fu
         74zLHiVzHslP4sDr6VoBKsxQoWNUxtVpxi+jGl8NarDCMXKFUzvC1OYWlaWyT5I6sK41
         Ku7FSuRNLwQwgfSCeg7/0nPB5xY+eeLCXr/xufUGBjAwNNxLQOPf1+J5stwdxVUf+kP3
         UGcDjxxrYmMNOxcoeeoLZ3MGvlgUniWhi0XseeN2qyIl6LZqUg0VFaPBHSfhSAOizGkA
         gNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007406; x=1743612206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLzOQ+BdGkOXJhBkBzUQ0CiAN35NUo3v4I6j8y4k9CM=;
        b=FcLl5rcpSuoN84NZ+zx8S7EpUkdT0wNVPgyZISGF4aiOTbsjw7CMLSkPMad0Nx53TO
         amnMuvJq5zhGfIcnexuzNexsAu/J8jXz1cJwRUrEJGxbePsXCqJ9iNS96Q+O3T4sGf8K
         cN9QGPMzDrXGg8VafNBk6MEdnbO3eZGEnp+Hv5IVqygscHavZJ6LCXl+VK/uiDjQ8Rvr
         rM3REW0dZGoU8r+L0ir84/Ce6fUwdIJ4Epdb1hQZnnRNU/dzkESimgprwNdw0m9/NRlM
         oLxFD6SUtv3GcOpsODeRdmRgMLZvgVV2Xqa8sZE8G4FhqAphgQbNqD5VPBW0CSsFTtcv
         diUg==
X-Forwarded-Encrypted: i=1; AJvYcCUDcd0cctSQIQWA8j1HKcfY7KI5AF4mvb56nBIBP7voDGJxUvOBIWbenj5XRLh1exD5x2HJBwu34Dt24A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvY4ImJAhcc4HbLYGc44I6zZsa55o5ZxZYsasDk7KfP+3MW7FO
	7B1X/vG7a+B1be6sCIDKjOY+TrP25wclUx4MSfhK1GjuItxq4srcqiZixm+Hq5lCDaAg5JZt1mE
	Zsc+jzLx65RTP+2eRkuBqZTLA4Ia1RUknr7cUfw==
X-Gm-Gg: ASbGncstQC8rbAgK2xKM+SzO5CNP0MvxQjQZF2FsHmnU30e+WF7Vr1eFu5czPUBkg3A
	pN5tXK0PSGX+ihX1upZ3nQSpL06nwLQutwClSVPG97MnXfCAL+pMW1Lp5WyjrcOL1z5AS9UGZwr
	T4drirg8ULoiP4Cq5m2RGtF10z
X-Google-Smtp-Source: AGHT+IGBx+NXadhv5vzICZHD/MdabwncvO9n3RJC/a5uKMLLXNJgmfFIxI5h8sK9fEQgAz27rEr2Js82vuTfOXLsZzA=
X-Received: by 2002:a17:90b:1b05:b0:301:1c11:aa7a with SMTP id
 98e67ed59e1d1-303a83c3c36mr186600a91.3.1743007405442; Wed, 26 Mar 2025
 09:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324134905.766777-1-ming.lei@redhat.com> <20250324134905.766777-5-ming.lei@redhat.com>
 <CADUfDZo4jmifYJwDRsX0FMemxDiuRu_XG6GV6+drVUOgDk3QwQ@mail.gmail.com>
 <Z-IDwx3mv6I90hhg@fedora> <CADUfDZpv-EmJy+GZcWL=q5MHg4ovae_kg8k+ewcdrwNTQ_zK9g@mail.gmail.com>
 <Z-NjqBgCc0qduUmd@fedora>
In-Reply-To: <Z-NjqBgCc0qduUmd@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 26 Mar 2025 09:43:13 -0700
X-Gm-Features: AQ5f1JqTJQTAoJC3JASlVsJXil1SHeQY-0UPfT8vDZCuavceriH3FnEiXQWFlTc
Message-ID: <CADUfDZrHUbpRPkZ2UafmET7dd_0aex8o01fB4tiLkzDz5p0phw@mail.gmail.com>
Subject: Re: [PATCH 4/8] ublk: add segment parameter
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 7:17=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Mar 25, 2025 at 12:43:26PM -0700, Caleb Sander Mateos wrote:
> > On Mon, Mar 24, 2025 at 6:16=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Mon, Mar 24, 2025 at 03:26:06PM -0700, Caleb Sander Mateos wrote:
> > > > On Mon, Mar 24, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > IO split is usually bad in io_uring world, since -EAGAIN is cause=
d and
> > > > > IO handling may have to fallback to io-wq, this way does hurt per=
formance.
> > > > >
> > > > > ublk starts to support zero copy recently, for avoiding unnecessa=
ry IO
> > > > > split, ublk driver's segment limit should be aligned with backend
> > > > > device's segment limit.
> > > > >
> > > > > Another reason is that io_buffer_register_bvec() needs to allocat=
e bvecs,
> > > > > which number is aligned with ublk request segment number, so that=
 big
> > > > > memory allocation can be avoided by setting reasonable max_segmen=
ts limit.
> > > > >
> > > > > So add segment parameter for providing ublk server chance to alig=
n
> > > > > segment limit with backend, and keep it reasonable from implement=
ation
> > > > > viewpoint.
> > > > >
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c      | 15 ++++++++++++++-
> > > > >  include/uapi/linux/ublk_cmd.h |  9 +++++++++
> > > > >  2 files changed, 23 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index acb6aed7be75..53a463681a41 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -74,7 +74,7 @@
> > > > >  #define UBLK_PARAM_TYPE_ALL                                \
> > > > >         (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> > > > >          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > > > > -        UBLK_PARAM_TYPE_DMA_ALIGN)
> > > > > +        UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > > > >
> > > > >  struct ublk_rq_data {
> > > > >         struct kref ref;
> > > > > @@ -580,6 +580,13 @@ static int ublk_validate_params(const struct=
 ublk_device *ub)
> > > > >                         return -EINVAL;
> > > > >         }
> > > > >
> > > > > +       if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
> > > > > +               const struct ublk_param_segment *p =3D &ub->param=
s.seg;
> > > > > +
> > > > > +               if (!is_power_of_2(p->seg_boundary_mask + 1))
> > > > > +                       return -EINVAL;
> > > >
> > > > Looking at blk_validate_limits(), it seems like there are some
> > > > additional requirements? Looks like seg_boundary_mask has to be at
> > > > least PAGE_SIZE - 1
> > >
> > > Yeah, it isn't done in ublk because block layer runs the check, and i=
t
> > > will be failed when starting the device. That said we take block laye=
r's
> > > default setting, which isn't good from UAPI viewpoint, since block
> > > layer may change the default setting.
> >
> > Even though blk_validate_limits() rejects it, it appears to log a
> > warning. That seems undesirable for something controllable from
> > userspace.
> > /*
> >  * By default there is no limit on the segment boundary alignment,
> >  * but if there is one it can't be smaller than the page size as
> >  * that would break all the normal I/O patterns.
> >  */
> > if (!lim->seg_boundary_mask)
> >         lim->seg_boundary_mask =3D BLK_SEG_BOUNDARY_MASK;
> > if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
> >         return -EINVAL;
>
> Yes, it has been addressed in my local version, and we need to make it
> a hw/sw interface.
>
> >
> > >
> > > Also it is bad to associate device property with PAGE_SIZE which is
> > > a variable actually. The latest kernel has replaced PAGE_SIZE with 40=
96
> > > for segment limits.
> > >
> > > I think we can take 4096 for validation here.
> > >
> > > > and max_segment_size has to be at least PAGE_SIZE
> > > > if virt_boundary_mask is set?
> > >
> > > If virt_boundary_mask is set, max_segment_size will be ignored usuall=
y
> > > except for some stacking devices.
> >
> > Sorry, I had it backwards. The requirement is if virt_boundary_mask is
> > *not* set:
> > /*
> >  * Stacking device may have both virtual boundary and max segment
> >  * size limit, so allow this setting now, and long-term the two
> >  * might need to move out of stacking limits since we have immutable
> >  * bvec and lower layer bio splitting is supposed to handle the two
> >  * correctly.
> >  */
> > if (lim->virt_boundary_mask) {
> >         if (!lim->max_segment_size)
> >                 lim->max_segment_size =3D UINT_MAX;
> > } else {
> >         /*
> >          * The maximum segment size has an odd historic 64k default tha=
t
> >          * drivers probably should override.  Just like the I/O size we
> >          * require drivers to at least handle a full page per segment.
> >          */
> >         if (!lim->max_segment_size)
> >                 lim->max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
> >         if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
> >                 return -EINVAL;
> > }
>
> Right.
>
> Please feel free to see if the revised patch is good:
>
>
> From 0718b9f130b3bc9b9b06907c687fb5b9eea172f7 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Mon, 24 Mar 2025 12:33:59 +0000
> Subject: [PATCH V2 3/8] ublk: add segment parameter
>
> IO split is usually bad in io_uring world, since -EAGAIN is caused and
> IO handling may have to fallback to io-wq, this way does hurt performance=
.
>
> ublk starts to support zero copy recently, for avoiding unnecessary IO
> split, ublk driver's segment limit should be aligned with backend
> device's segment limit.
>
> Another reason is that io_buffer_register_bvec() needs to allocate bvecs,
> which number is aligned with ublk request segment number, so that big
> memory allocation can be avoided by setting reasonable max_segments limit=
.
>
> So add segment parameter for providing ublk server chance to align
> segment limit with backend, and keep it reasonable from implementation
> viewpoint.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 20 +++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h | 21 +++++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6fa1384c6436..6367476cef2b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -74,7 +74,7 @@
>  #define UBLK_PARAM_TYPE_ALL                                \
>         (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
>          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> -        UBLK_PARAM_TYPE_DMA_ALIGN)
> +        UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
>
>  struct ublk_rq_data {
>         struct kref ref;
> @@ -580,6 +580,18 @@ static int ublk_validate_params(const struct ublk_de=
vice *ub)
>                         return -EINVAL;
>         }
>
> +       if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
> +               const struct ublk_param_segment *p =3D &ub->params.seg;
> +
> +               if (!is_power_of_2(p->seg_boundary_mask + 1))
> +                       return -EINVAL;
> +
> +               if (p->seg_boundary_mask + 1 < UBLK_MIN_SEGMENT_SIZE)
> +                       return -EINVAL;
> +               if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
> +                       return -EINVAL;

These checks look good, except they don't allow omitting
seg_boundary_mask or max_segment_size. I can imagine a ublk server
might want to set only some of the segment limits and leave the others
as 0?

Best,
Caleb

> +       }
> +
>         return 0;
>  }
>
> @@ -2346,6 +2358,12 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub, struct io_uring_cmd *cmd)
>         if (ub->params.types & UBLK_PARAM_TYPE_DMA_ALIGN)
>                 lim.dma_alignment =3D ub->params.dma.alignment;
>
> +       if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
> +               lim.seg_boundary_mask =3D ub->params.seg.seg_boundary_mas=
k;
> +               lim.max_segment_size =3D ub->params.seg.max_segment_size;
> +               lim.max_segments =3D ub->params.seg.max_segments;
> +       }
> +
>         if (wait_for_completion_interruptible(&ub->completion) !=3D 0)
>                 return -EINTR;
>
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 7255b36b5cf6..ffa805b05141 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -410,6 +410,25 @@ struct ublk_param_dma_align {
>         __u8    pad[4];
>  };
>
> +#define UBLK_MIN_SEGMENT_SIZE   4096
> +struct ublk_param_segment {
> +       /*
> +        * seg_boundary_mask + 1 needs to be power_of_2(), and the sum ha=
s
> +        * to be >=3D UBLK_MIN_SEGMENT_SIZE(4096)
> +        */
> +       __u64   seg_boundary_mask;
> +
> +       /*
> +        * max_segment_size could be override by virt_boundary_mask, so b=
e
> +        * careful when setting both.
> +        *
> +        * max_segment_size has to be >=3D UBLK_MIN_SEGMENT_SIZE(4096)
> +        */
> +       __u32   max_segment_size;
> +       __u16   max_segments;
> +       __u8    pad[2];
> +};
> +
>  struct ublk_params {
>         /*
>          * Total length of parameters, userspace has to set 'len' for bot=
h
> @@ -423,6 +442,7 @@ struct ublk_params {
>  #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
>  #define UBLK_PARAM_TYPE_ZONED           (1 << 3)
>  #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
> +#define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
>         __u32   types;                  /* types of parameter included */
>
>         struct ublk_param_basic         basic;
> @@ -430,6 +450,7 @@ struct ublk_params {
>         struct ublk_param_devt          devt;
>         struct ublk_param_zoned zoned;
>         struct ublk_param_dma_align     dma;
> +       struct ublk_param_segment       seg;
>  };
>
>  #endif
> --
> 2.47.0
>
>
>
> Thanks,
> Ming
>
