Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72284C8C50
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559568; cv=pass; b=GWa+b01wZFLdTvgRTB1kK8pSG+vCu/NE71sq3O6ZiEZH2VWji5OVxH7fgWtmBHHUyAfPxmsV0ojAH+4lGPHXWnqKtdpjkURe+1C2Gr+C0ULgOAG7NAyp1tbSYylbGs45BXBBL8oVczWCqvIbk+sovEjrnZ3qLa+iuIq2Ad4Dt+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559568; c=relaxed/simple;
	bh=ewbTpagjgKK2y0HY2dKNvkT5DR7bYdLc8tvq4oQT+qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2jgl1/j9jzE4eYONWZ6ptkaQp7/Fmt1MZF1uDd+xBXxV2xVQgALEpEFyX0Qez5NIuB6J2inV/jjvd7FHCYquzlYWhyNrjL4uWNoPhJ2OOk1Fqh90zDLB45f2/axYrIU2zfRalrRNwCdgrTBTlwpojCBL9YYBuVZpCduHGip7vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WxDndKbZ; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WxDndKbZ"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-82362eea7daso379787a34.0
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 08:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791559565; cv=none;
        d=google.com; s=arc-20260327;
        b=Hhgzc5xrTsP2NT3bk/qtnJWiDzQ6BeGVm9LW7fmyUhsUHVgpKUNQFoe2cRA9i2O50D
         fXAHy6WMPNibGvUp3XuYak3lg/uHLFXBsiA63UzwLlUYVdfzlzl1a7WPwedUsx2oi0cn
         HWsYw+7HYQmWpwSNQmAVv5WwB8hNuKS5inJ8xRwEJlYFZSnve5UkBwB470unxiPZU5TY
         apwfAJa42V/xrKKhDWqzpb6Jqtg5TFGKMhAfWOmWQx87Q/PX8HL6OGDhTqwu0NYLPtIQ
         LTwF8t6H6vHY9IepJzjPKaKSbpjBVjB1yBeJ6w2sZPv3qTsR0yQFcYtYObrU4Vowb7+9
         MQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XtP8Z2xn/UaYhcehwEDXzz9Gb8Ee2/a9xVmwng5F4h8=;
        fh=ndNtr4/TUtxGugiGba3rfAabILkX3wZX14KOMi4wHs0=;
        b=WS3UWlrHNqOAMs0A+xOo3bX+tlSgXHXSL+lme5VJ2XvfXaY2djdTj1Bg9M4HSz2E/g
         hj+oR1RY0V3ylp31ScBcVjTCG2wxMr59Di1PBvyoFgSg05e/d/NR42377u79sjnPTVLN
         e4yPmByic0L/iOiCU3FLRsnEhX2Q6yU2PdA6eQmGOBTHJTCBOMHDe+N5YDAbhiTRcreq
         +H61mkiBJyU1IcPIY2fmYPjnX4H5+yP5sRx0Go9z264Gu09+H2nybS8Z4Kbpu8KVJu0T
         bxDuISqtL/t5Z3mP4wGRk2PPfrWWIcdDmiDFYH3O8d5Ol7TqBL6dbcdK8Csog/KLCh5O
         1N2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1791559565; x=1792164365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XtP8Z2xn/UaYhcehwEDXzz9Gb8Ee2/a9xVmwng5F4h8=;
        b=WxDndKbZtXo14uoLfiOvwKKWc7vCmEx8q7gPDxGLDjg1DJbkKahd05wE4eQAKlA8Pi
         0qAaZwu022Dl26kxulpg2uTr5tBxscv57qgzVefFoxDSUAnGLOIkhybyUSOqEwFsEBTJ
         fJBvh1FLtw6ZqfVNWDQfTSwsNpI0BR8a8Ztr0Ubm6yTsyOd+fZSl5Umd9uQRQ+GIwsUL
         ePAOVhoAU+9ej6pVK0zFZaUDu7rc5jwQA5+CSgrArthD/sm9rJNsbBJtHD1IkmUr/JUv
         eZdYYhfWn6jWQLx2SH3m0ec5Pp88S2h5JRrt7tGTzxGeI0zL2cbqDuOQlHrvXfIW/Ury
         fn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791559565; x=1792164365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XtP8Z2xn/UaYhcehwEDXzz9Gb8Ee2/a9xVmwng5F4h8=;
        b=Nunyn1/QQX7NZvLpPonGvOUQUe4Ad4E77k19b+CCfCKiyULzC/JIwoBkQhTG6FTcFr
         fQll0fRMy9dJwHK/HE90XxjFqMRg2KGIw64iEWe3OOd+jb06WyzSnF+/4EioAGPIf1Z/
         pIXG3MxIPM4SIvX+GvckFvczlqCx5Sg5W5TstHFLT7HTWFNTwmlBssiak6xN6CUFfASj
         CHWz/Cq5akTIiuvq/oxJ50SWpnrxTE4HHh8tjBbqCCV3U3gpjlXpW0KbGDAjur9pYms0
         FIkYxqViLdid3Mumx3xq3RMBPwM1u+6IFAe71plhVF+7l4Ydrpu/igptiSP2CzPxdUKY
         cPeg==
X-Forwarded-Encrypted: i=1; AKwUvBxbNm11aQWfpDXlr1ZLSwbUNd2Kbdh87lU6UpLm/P4KPGFLuph9HJbfiicgGl415JGcu64WwIWHPDdqdQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lBFwoQyncdT/RH6xN+18TKKNNGGGTl52WhFhdB1yCpSXzHRpI/
	B9dlDw30LyLowECceP0Z4NwSxsQIV3vgf3Gf7hsCCYjtV0WTq1rOB4KQ1mcOGHyXWe7uegLuRwS
	4QhDzo6bHoi1CDg/Iv2Z1yLmo+lOz00odn45QVkBCGA==
X-Gm-Gg: AYBFou3lXJdYx4Uh9yRnd4h73k+onpaIaW2LCOuYKNFRv1DF4PJ96nQglDr7twoXZDN
	DUB8FfjRIh9viDLiRVuRn8kGfsgQaFtUDP5kiBv7TPAB9ZonIHS77G2qOLP7e1OY190MrqZxhHa
	vZ/VFN1wgX2z0myttKSBy1HE2w7AossjhmJIS2eT2hPykYHlCm8b3V+PfO6List3GJtsi405j3v
	j78orAQ7nEWTv+O5WsaUvFZGErooAeiro87XYYaFvR4KawORABWUET8utOXGzuQR+PZF4cHatQ0
	afaP7CSVQy7BlA0ayi2B5RffbuwOQsem0d/dm6f2KpJhRjYsvqEF4DT9
X-Received: by 2002:a05:6830:6606:b0:811:7b6e:d533 with SMTP id
 46e09a7af769-83090e1be2bmr2354116a34.1.1791559563396; Fri, 09 Oct 2026
 08:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006190348.85094-1-yoav@nvidia.com> <20261006190348.85094-2-yoav@nvidia.com>
 <CADUfDZrX7v+0-Zxv7AwoJBH-e0ohLcAgm_dvPoDpGv2jZfN2XA@mail.gmail.com> <asjveZylpV0swnp8@fedora-laptop>
In-Reply-To: <asjveZylpV0swnp8@fedora-laptop>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 9 Oct 2026 08:25:50 -0700
X-Gm-Features: AclHuK-ptyoOsQHQVr1IOUdvYf8CJUq35JMWMyFogkkHTkfL8u3eQfTtddyT8jk
Message-ID: <CADUfDZrM5VvEGtYqKdvYXtfPEw+WW93E41gZit636qS6QxFWjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ublk: honor rq_affinity on request completion
To: Ming Lei <tom.leiming@gmail.com>
Cc: Yoav Cohen <yoav@nvidia.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	jholzman@nvidia.com, omril@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 6:43=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wro=
te:
>
> On Tue, Oct 06, 2026 at 02:53:47PM -0700, Caleb Sander Mateos wrote:
> > On Tue, Oct 6, 2026 at 12:04=E2=80=AFPM Yoav Cohen <yoav@nvidia.com> wr=
ote:
> > >
> > > ublk ends successfully completed requests inline on the server thread
> > > that issued UBLK_IO_COMMIT_AND_FETCH_REQ, so rq_affinity never
> > > redirects completion back to the submitting CPU, unlike NVMe, SCSI,
> > > virtio-blk, loop, nbd and rnbd.
> > >
> > > Route completion through blk_mq_complete_request_remote(), with a new
> > > ->complete() callback, ublk_end_rq(). This covers every completion
> > > outcome -- reads, writes, flush/discard, errors, and the zero-copy/
> > > user-copy/auto-buf-reg/shmem-zc paths that skip the copy-back step --
> > > not just the classic-copy-mode successful-read case, since
> > > ublk_end_rq() re-derives which of those __ublk_complete_rq() took fro=
m
> > > @req and @io state rather than assuming one.
> > >
> > > Gate it behind a new UBLK_F_SUPPORT_RQ_AFFINITY flag that a server
> > > must request at ADD_DEV time; servers that don't ask for it keep
> > > today's always-local completion unchanged. Add ublk_support_rq_affini=
ty()
> > > alongside the existing ublk_support_*() helpers, and check it before
> > > calling blk_mq_complete_request_remote() at both call sites.
> > >
> > > Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 98 +++++++++++++++++++++++++++------=
--
> > >  include/uapi/linux/ublk_cmd.h |  8 +++
> > >  2 files changed, 84 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 66eb55e7162e..b94293296b73 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -90,7 +90,8 @@
> > >                 | UBLK_F_BATCH_IO \
> > >                 | UBLK_F_NO_AUTO_PART_SCAN \
> > >                 | UBLK_F_SHMEM_ZC \
> > > -               | UBLK_F_IO_DESC_SIZE)
> > > +               | UBLK_F_IO_DESC_SIZE \
> > > +               | UBLK_F_SUPPORT_RQ_AFFINITY)
> > >
> > >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > > @@ -452,6 +453,11 @@ static inline bool ublk_support_user_copy(const =
struct ublk_queue *ubq)
> > >         return ubq->flags & UBLK_F_USER_COPY;
> > >  }
> > >
> > > +static inline bool ublk_support_rq_affinity(const struct ublk_queue =
*ubq)
> > > +{
> > > +       return ubq->flags & UBLK_F_SUPPORT_RQ_AFFINITY;
> > > +}
> > > +
> > >  static inline bool ublk_dev_support_user_copy(const struct ublk_devi=
ce *ub)
> > >  {
> > >         return ub->dev_info.flags & UBLK_F_USER_COPY;
> > > @@ -1468,6 +1474,14 @@ static inline bool ublk_need_unmap_req(const s=
truct request *req)
> > >                (req_op(req) =3D=3D REQ_OP_READ || req_op(req) =3D=3D =
REQ_OP_DRV_IN);
> > >  }
> > >
> > > +/* Whether __ublk_complete_rq() takes the copy-back/partial-completi=
on path */
> > > +static inline bool ublk_rq_need_unmap(const struct ublk_queue *ubq,
> > > +                                     struct request *req)
> > > +{
> > > +       return ublk_need_map_io(ubq) && ublk_need_unmap_req(req) &&
> > > +              !ublk_iod_is_shmem_zc(ubq, req->tag);
> > > +}
> > > +
> > >  static unsigned int ublk_map_io(const struct request *req,
> > >                                 const struct ublk_io *io)
> > >  {
> > > @@ -1549,13 +1563,62 @@ static void ublk_end_request(struct request *=
req, blk_status_t error)
> > >         local_bh_enable();
> > >  }
> > >
> > > +/*
> > > + * Update @req with its result and requeue it if it was only partial=
ly
> > > + * completed. Returns true if @req was requeued, in which case the c=
aller
> > > + * must not touch it any further.
> > > + *
> > > + * Run bio->bi_end_io() with softirqs disabled. If the final fput ha=
ppens
> > > + * off this path, then that will prevent ublk's blkdev_release() fro=
m
> > > + * being called on current's task work, see fput() implementation.
> > > + *
> > > + * This matters for the caller completing @req locally on the ublk
> > > + * server's own thread: it may already be holding disk->open_mutex, =
e.g.
> > > + * reading the partition table from bdev_open(), and an fput() runni=
ng
> > > + * inline there could deadlock on it. Preferably we would not be doi=
ng
> > > + * IO with a mutex held that is also used for release, but this
> > > + * work-around will suffice for now. A caller reached instead via
> > > + * blk_mq_complete_request_remote()'s softirq/IPI redirect never run=
s on
> > > + * that thread, so it isn't exposed to this hazard, but disabling
> > > + * softirqs here is harmless for it too.
> > > + */
> > > +static inline bool ublk_update_and_requeue(struct request *req,
> > > +                                          struct ublk_io *io)
> > > +{
> > > +       bool requeue;
> > > +
> > > +       local_bh_disable();
> > > +       requeue =3D blk_update_request(req, BLK_STS_OK, io->res);
> > > +       local_bh_enable();
> > > +       if (requeue)
> > > +               blk_mq_requeue_request(req, true);
> > > +       return requeue;
> > > +}
> > > +
> > > +static void ublk_end_rq(struct request *req)
> > > +{
> > > +       struct ublk_queue *ubq =3D req->mq_hctx->driver_data;
> > > +       struct ublk_io *io =3D &ubq->ios[req->tag];
> > > +
> > > +       /* matches the two outcomes __ublk_complete_rq() may have red=
irected */
> > > +       if (io->res >=3D 0 && ublk_rq_need_unmap(ubq, req)) {
> > > +               if (!ublk_update_and_requeue(req, io) &&
> > > +                   likely(!blk_should_fake_timeout(req->q)))
> > > +                       __blk_mq_end_request(req, BLK_STS_OK);
> > > +               return;
> > > +       }
> > > +
> > > +       ublk_end_request(req, io->res < 0 ? errno_to_blk_status(io->r=
es) :
> > > +                                           BLK_STS_OK);
> > > +}
> > > +
> > >  /* todo: handle partial completion */
> > >  static inline void __ublk_complete_rq(struct request *req, struct ub=
lk_io *io,
> > >                                       bool need_map, struct io_comp_b=
atch *iob)
> > >  {
> > > +       struct ublk_queue *ubq =3D req->mq_hctx->driver_data;
> >
> > mq_hctx->driver_data and ubq->flags are likely to both be cache misses
> > on a ublk server thread servicing many queues. req->mq_hctx is
> > probably a hit as it's in the same cache line as req->cmd_flags
> > accessed just before in ublk_ch_uring_cmd_local() for the req_op(req)
> > =3D=3D REQ_OP_ZONE_APPEND check. It would be nice to avoid these
> > additional dereferences, can we prevent queue_rq_affinity_store() from
> > setting rq_affinity to a value other than 0 if
> > UBLK_F_SUPPORT_RQ_AFFINITY isn't enabled? Perhaps indicated via a new
> > BLK_FEAT_SUPPORTS_RQ_AFFINITY flag in struct queue_limits's features
> > field?
>
> ubq is only for ublk_support_rq_affinity(ubq), `maybe rq_affinity` can be
> passed by __ublk_complete_rq() parameter via
> ublk_dev_support_rq_affinity(ub).
>
> BTW, the one for ublk_iod_is_shmem_zc() can't be avoided.

Yes, but ublk_iod_is_shmem_zc() is only called in the need_map case. I
would expect most modern ublk servers to enable user copy and/or zero
copy, so they wouldn't take that path.

Best,
Caleb
