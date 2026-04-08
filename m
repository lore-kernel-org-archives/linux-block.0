Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8E3BE629
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662107; cv=pass; b=t9LONm8z6IvyKMn5ioZv5eUbMwFCwRjOPdzPmfQ4kXKyf727qAWQRzxKg+QWmWA1QmC8K5lTf2G/5Ls4lpC2YdmtsaBxtg1QnUtSrlleFjfuTn9VUAyzg8DNPTk8aQlTdPgZhwd8++OWs+9VbfeUaBZ4LdfZm6UMyPudY5wyqEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662107; c=relaxed/simple;
	bh=JfKq8pFrkDLU10ulSUTX/1zd993bPDWWA0e8puJFcSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxIdQ7S3AaXhYK4XMW9FJ91Azz00PX3RdYGMM+qUkYFGLi1+8FBUbl8rP1Z0zRTwnQeJFTF0TUPdF5iQZzo4jws3ut0GpIGmya7Zd2qpSRIzOLCLh2KpDSO8SWij9BvTx/jGn0Zv7k5FhGNBQ63XMKMEZmO43ugVI9MjOcrMmus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=R+K6UnE1; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="R+K6UnE1"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6828cffbcd4so193815eaf.0
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 08:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775662104; cv=none;
        d=google.com; s=arc-20240605;
        b=FK+0SyUg/9TOBrqpnBfZ5EpM5hBpiNhOw9H2EQSuDtjuy+zPt7a4Qzn1oFJf/pJLmt
         iHrvz6U2Y+zgUJTn/89+30Z4s3sig8UtpI85UgczcBIc929bmvRRC/sPvSIJJnLHQ/Kd
         OlfMDeWBQVaf/B9uj2I3diVKn3cK9Y7LkR2UyKcFXHs7yrnIUQof6Sr9Zkqx7PReulaI
         Imqq+fwHlD2Skj2Nd3iyzhV79I/qhQ3GlTHGQUX8Qzky4pNCGQk9Ydjv4f/euSVkRrQv
         nMyl21rycKMs3/Vnz8oviBdXe0ui8FRyzKJa/h7womWjKlHzNSLCyfWzCoKHpUm9lLiX
         XOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fd/kc21s263UzPxIP8Zt0WwTBMt6QOp+8AP1TicOdIo=;
        fh=n5YFbfHKp8RO/O61va/698la9zAQ1cE2iY4Opcky3wQ=;
        b=NNKiYAymTEDptOKnGRJs+3/Ghvw1Uu3RjHA5HqQj755bRHtFal3jruDdlIZmxXymxY
         k7yEYhjqgCpMdWJy2r0rcUIvZ7TttpU2bRx1UZQvWdxs0svosiiX85wMgUrM71hh0lZe
         ns6MajatL4NGWQL89MfhEFTTNhfcVgKeL7cGS2ZMWR5am932vMLlzydBuO5xJMQmSqJV
         ARzwnNPPoOuoxWc+8reAtqLi2sQDsiiz/zjKeb0y+wuIaSKvMsWVjEvXxJLX0wbghtQT
         IW188/iYtUU6Z4YgIBERnPCNq4izAvZ8GYZZEGZ6BaZMcI3dWoSMYP0bnwPhRn7ikO+R
         o0iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775662104; x=1776266904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd/kc21s263UzPxIP8Zt0WwTBMt6QOp+8AP1TicOdIo=;
        b=R+K6UnE1DsVz5KCOqDn5xPhxoBQAiWvEMMm42S/YIwFNxBhJGNiJwX+t86IXj2dDDI
         Xb+2TXZrUscT55zVD/8PF5l/vU7ES35nhpp616z+BynNEQgTMufloue9j4rgA+Xi9Dan
         O0qj3XX6gDrsWtwVBjfGZVVwRk5O1UatEpZSyK/OdPLCAF279rA+3h5ya4F5e2fg+Wvj
         kV724JG8VtItpEG6dWE1Hkntzddr0rB/DwCBidL2eOsUKuLAsKQzYcuI6o3HEzX0chAe
         syAz7bah6FStrsvxYKz8oBkG7JgjgmPscHKYMH93Gd3bFi4kr+1mRMFKZIxsAYJ7JCEM
         esXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775662104; x=1776266904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fd/kc21s263UzPxIP8Zt0WwTBMt6QOp+8AP1TicOdIo=;
        b=VvRo65sHzzXcbg0h8dzJQk5yXEBsLMlupI8VMayHr2P+ViuiSnRbEUPJQo+yq+Srul
         29o66BYKADkuGp2uJrvOHh21+v4lK0vZCyz+KFvJU5gpy3PFq2RXZn5vxibxshrDUHY5
         wK7AmAKe8u6zkBOPIiozM+dEi0vxaMw54xd9PAnnvEm1cpi+b/PG4ROfkCvvyDCjLnc1
         /S2akVPcrNnPhirCbHPkaOVhj3xpCtk8eNk5El73OasdUEQzeXv8oZl6ze1bN4HXnT7+
         lSQDPnoD1I9Ps6BQROD8aEM4wSX3x365Vd5k3DJxdt4HwoH2Q3C00AeKsPfWJ90Tg4VA
         x8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVkOvl8LRMV+pG/ccMp81v1u1Z57z1rZOmJIV/85miNpWyegI6NU9ui6JuRVttS5EV6tLkELtpZZy9B9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyav6pK3H1cxUxCxN8U0FLDM7/nv0h4Xy6ZPG4LxdfhGtxbp2ra
	IcaNiGcVJPewEalHlWvE0qoI9RLc5e1E4amxLZWgcmq/d0ql2GkatqCxzPfbrxdzvw7XvPMHUKN
	S3Gd2kRwn43ny6vSmagTcPknoQAP2lIN80k5WgnRELg==
X-Gm-Gg: AeBDiesQ+N3nuHbsv3iWRiKIFDIeYpmrz7+pJu4/erS32Eb9AD99PX58B+ejd6+0qx9
	9pj3Hj7G82sx+yUGjcUnUiciuW9DVRKaJIuTPNShOh9oBOASGhvFbPcDvreukSd+RcG9LcN2iCA
	PXWBkuOjsonUTks06A5mdN5rwLpn3VT5iCkXkwyx8+DRcWs+Zt3EspXOupSe1L3u/6ePzbCLdEN
	+Ry4UHswnRQt4IyYqMGtylha+i5p3okk7zt/sZpu3T5KSKGiB0n6AmyLajqDPYoFnfBqiNHqgFu
	DcDqJ+Rp8H0Qv8xWRQ==
X-Received: by 2002:a05:6870:20ab:b0:423:92b9:5ce8 with SMTP id
 586e51a60fabf-42392ba122bmr1370971fac.5.1775662104084; Wed, 08 Apr 2026
 08:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153207.3635125-1-ming.lei@redhat.com> <20260331153207.3635125-3-ming.lei@redhat.com>
 <CADUfDZq3rTwcnxAekdan3-fi3qdLwFp-T5LsJJ1viqoUv8RqOw@mail.gmail.com> <adW_EQW1AAJdaWqN@fedora>
In-Reply-To: <adW_EQW1AAJdaWqN@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 8 Apr 2026 08:28:11 -0700
X-Gm-Features: AQROBzBz3-jSA5n4sZZ3YnQ6ZklYCouy9C-UR99zXmpy7yuRVApzm2kvdmVkPgY
Message-ID: <CADUfDZoFT=0z4L1D+fcgaWAOhF5Qb-+yR1v-x37PBnZOo5pW5A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] ublk: add PFN-based buffer matching in I/O path
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 7:36=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Tue, Apr 07, 2026 at 12:47:29PM -0700, Caleb Sander Mateos wrote:
> > On Tue, Mar 31, 2026 at 8:32=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add ublk_try_buf_match() which walks a request's bio_vecs, looks up
> > > each page's PFN in the per-device maple tree, and verifies all pages
> > > belong to the same registered buffer at contiguous offsets.
> > >
> > > Add ublk_iod_is_shmem_zc() inline helper for checking whether a
> > > request uses the shmem zero-copy path.
> > >
> > > Integrate into the I/O path:
> > > - ublk_setup_iod(): if pages match a registered buffer, set
> > >   UBLK_IO_F_SHMEM_ZC and encode buffer index + offset in addr
> > > - ublk_start_io(): skip ublk_map_io() for zero-copy requests
> > > - __ublk_complete_rq(): skip ublk_unmap_io() for zero-copy requests
> > >
> > > The feature remains disabled (ublk_support_shmem_zc() returns false)
> > > until the UBLK_F_SHMEM_ZC flag is enabled in the next patch.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 77 ++++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 76 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index ac6ccc174d44..d53865437600 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -356,6 +356,8 @@ struct ublk_params_header {
> > >
> > >  static void ublk_io_release(void *priv);
> > >  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> > > +static bool ublk_try_buf_match(struct ublk_device *ub, struct reques=
t *rq,
> > > +                                 u32 *buf_idx, u32 *buf_off);
> >
> > buf_idx could be a u16 * for consistency?
>
> Yeah.
>
> >
> > >  static void ublk_buf_cleanup(struct ublk_device *ub);
> > >  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_que=
ue *ubq);
> > >  static inline struct request *__ublk_check_and_get_req(struct ublk_d=
evice *ub,
> > > @@ -426,6 +428,12 @@ static inline bool ublk_support_shmem_zc(const s=
truct ublk_queue *ubq)
> > >         return false;
> > >  }
> > >
> > > +static inline bool ublk_iod_is_shmem_zc(const struct ublk_queue *ubq=
,
> > > +                                       unsigned int tag)
> > > +{
> > > +       return ublk_get_iod(ubq, tag)->op_flags & UBLK_IO_F_SHMEM_ZC;
> > > +}
> > > +
> > >  static inline bool ublk_dev_support_shmem_zc(const struct ublk_devic=
e *ub)
> > >  {
> > >         return false;
> > > @@ -1494,6 +1502,18 @@ static blk_status_t ublk_setup_iod(struct ublk=
_queue *ubq, struct request *req)
> > >         iod->nr_sectors =3D blk_rq_sectors(req);
> > >         iod->start_sector =3D blk_rq_pos(req);
> > >
> > > +       /* Try shmem zero-copy match before setting addr */
> > > +       if (ublk_support_shmem_zc(ubq) && ublk_rq_has_data(req)) {
> > > +               u32 buf_idx, buf_off;
> > > +
> > > +               if (ublk_try_buf_match(ubq->dev, req,
> > > +                                         &buf_idx, &buf_off)) {
> > > +                       iod->op_flags |=3D UBLK_IO_F_SHMEM_ZC;
> > > +                       iod->addr =3D ublk_shmem_zc_addr(buf_idx, buf=
_off);
> > > +                       return BLK_STS_OK;
> > > +               }
> > > +       }
> > > +
> > >         iod->addr =3D io->buf.addr;
> > >
> > >         return BLK_STS_OK;
> > > @@ -1539,6 +1559,10 @@ static inline void __ublk_complete_rq(struct r=
equest *req, struct ublk_io *io,
> > >             req_op(req) !=3D REQ_OP_DRV_IN)
> > >                 goto exit;
> > >
> > > +       /* shmem zero copy: no data to unmap, pages already shared */
> > > +       if (ublk_iod_is_shmem_zc(req->mq_hctx->driver_data, req->tag)=
)
> >
> > This is a lot of pointer chasing. Could we track this with a flag on
> > struct ublk_io instead?
>
> Yeah, it can be done by adding and setting the new flag in ublk_start_io(=
), or
> we can just pass `ubq` to __ublk_complete_rq() from its call sites.
>
> I prefer to the latter.

Accessing the struct ublksrv_io_desc on completion of the I/O is a
likely cache miss, whereas struct ublk_io has just been accessed.
Additionally, struct ublk_queue isn't easily accessible in
ublk_put_req_ref() without going through req->mq_hctx->driver_data.
That's why I'd prefer to use a flag in struct ublk_io.

>
> >
> > > +               goto exit;
> > > +
> > >         /* for READ request, writing data in iod->addr to rq buffers =
*/
> > >         unmapped_bytes =3D ublk_unmap_io(need_map, req, io);
> > >
> > > @@ -1697,8 +1721,13 @@ static void ublk_auto_buf_dispatch(const struc=
t ublk_queue *ubq,
> > >  static bool ublk_start_io(const struct ublk_queue *ubq, struct reque=
st *req,
> > >                           struct ublk_io *io)
> > >  {
> > > -       unsigned mapped_bytes =3D ublk_map_io(ubq, req, io);
> > > +       unsigned mapped_bytes;
> > >
> > > +       /* shmem zero copy: skip data copy, pages already shared */
> > > +       if (ublk_iod_is_shmem_zc(ubq, req->tag))
> > > +               return true;
> > > +
> > > +       mapped_bytes =3D ublk_map_io(ubq, req, io);
> > >
> > >         /* partially mapped, update io descriptor */
> > >         if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > > @@ -5458,7 +5487,53 @@ static void ublk_buf_cleanup(struct ublk_devic=
e *ub)
> > >         mtree_destroy(&ub->buf_tree);
> > >  }
> > >
> > > +/* Check if request pages match a registered shared memory buffer */
> > > +static bool ublk_try_buf_match(struct ublk_device *ub,
> > > +                                  struct request *rq,
> > > +                                  u32 *buf_idx, u32 *buf_off)
> > > +{
> > > +       struct req_iterator iter;
> > > +       struct bio_vec bv;
> > > +       int index =3D -1;
> > > +       unsigned long expected_offset =3D 0;
> > > +       bool first =3D true;
> >
> > Could check index < 0 in place of first?
> >
> > > +
> > > +       rq_for_each_bvec(bv, rq, iter) {
> > > +               unsigned long pfn =3D page_to_pfn(bv.bv_page);
> > > +               struct ublk_buf_range *range;
> > > +               unsigned long off;
> > >
> > > +               range =3D mtree_load(&ub->buf_tree, pfn);
> > > +               if (!range)
> > > +                       return false;
> > > +
> > > +               off =3D range->base_offset +
> > > +                       (pfn - range->base_pfn) * PAGE_SIZE + bv.bv_o=
ffset;
> >
> > Doesn't this need to check that the end of the bvec is less than the
> > end of the range? Otherwise, the bvec could extend into physically
> > contiguous pages that aren't part of the registered range.
>
> It is actually fixed in my local tree:
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2e475bdc54dd..69db3b3b9071 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -5524,13 +5524,20 @@ static bool ublk_try_buf_match(struct ublk_device=
 *ub,
>
>         rq_for_each_bvec(bv, rq, iter) {
>                 unsigned long pfn =3D page_to_pfn(bv.bv_page);
> +               unsigned long end_pfn =3D pfn +
> +                       ((bv.bv_offset + bv.bv_len - 1) >> PAGE_SHIFT);
>                 struct ublk_buf_range *range;
>                 unsigned long off;
> +               MA_STATE(mas, &ub->buf_tree, pfn, pfn);
>
> -               range =3D mtree_load(&ub->buf_tree, pfn);
> +               range =3D mas_walk(&mas);
>                 if (!range)
>                         return false;
>
> +               /* verify all pages in this bvec fall within the range */
> +               if (end_pfn > mas.last)
> +                       return false;

Yeah, that looks good. I guess you could also remove base_pfn from
struct ublk_range, and just use mas.index here?

Best,
Caleb

> +
>                 off =3D range->base_offset +
>                         (pfn - range->base_pfn) * PAGE_SIZE + bv.bv_offse=
t;
>
> >
> > Also, the range could precompute base_pfn - base_offset / PAGE_SIZE
> > instead of base_offset to make this a bit cheaper.
> >
> > > +
> > > +               if (first) {
> > > +                       /* Read-only buffer can't serve READ (kernel =
writes) */
> > > +                       if ((range->flags & UBLK_SHMEM_BUF_READ_ONLY)=
 &&
> > > +                           req_op(rq) !=3D REQ_OP_WRITE)
> > > +                               return false;
> > > +                       index =3D range->buf_index;
> > > +                       expected_offset =3D off;
> > > +                       *buf_off =3D off;
> > > +                       first =3D false;
> > > +               } else {
> > > +                       if (range->buf_index !=3D index)
> > > +                               return false;
> > > +                       if (off !=3D expected_offset)
> > > +                               return false;
> > > +               }
> > > +               expected_offset +=3D bv.bv_len;
> > > +       }
> > > +
> > > +       if (first)
> > > +               return false;
> >
> > How is this case possible? That would mean the request has no bvecs,
> > but ublk_try_buf_match() is only called for requests with data, right?
>
> Your are right, will clean it in next version.
>
> Thanks,
> Ming
>
