Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462A18DB24
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745850502; cv=none; b=oVCd73grA6/ZP6bHdoQaGBYnYxi22ZJmlZGAYHlj42GOkSaWM/Ou21qgc46N9v7cF3Z+ZxKQkfeh2yd/phEiwiaBd4hwRzQJcmrqxhgxOod8lTNQANalsWOrokcHA0bHPadbO/erOZr43WIBcn4ZwC34VTXvmJNfEGkmpLTF+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745850502; c=relaxed/simple;
	bh=Q1rwHvBu4qxAJ3au0VkVzcq1N7TF2axF0QJN7r0M3bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jI2HYciWNtZEJq2U8zE4q3xOJAmbbBiqKRLRI1M6LKWEifvk5oqjkeRRDRQajTNXm2o8mJoGdokrrKMAkpqkrs8+8r8fut/xFKIiaXcDRQ7hBu33h/VhhpKg00SdFdOfA76S760fBSAtPLWvvEmpQ4gBLPNqSz+N0P9snN5LEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=b8sJHIWt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="b8sJHIWt"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so393651a91.0
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745850499; x=1746455299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDr5IGzdbQjvzsBJWEvUjA0SpBUuryn1nv5p9QOyO0I=;
        b=b8sJHIWtQc5JoraZk97g4oZzB3Qmye0+Curyoo/K6BY0yrlkgzNhxTToPRaKN7whzK
         ej9RhS36t2ouBDXGn4LjxbqxZKLyLY0lPVSPLtUDWLGt+snkMKiYkL3oAUdlncqMbZIK
         X+xRioJGAK/Vz/oTKPOaUG2/qsKtca4XDjMEf/AszscVmT18wHBU4KlRIneVlXhM98Hw
         4gpFOmxzMkWLk2KPSIdbZYDsF9xlwAhpp2asRYoX9x+jCaHYtTv7T2fNEm6tPZRwBUvz
         rmqA9U9PjtC0XP2Q/U0WeB9lAQWPeuIHmDBz8mOFbQEy3kL9qas09vnvdGsdeAlkJx/c
         zHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745850499; x=1746455299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDr5IGzdbQjvzsBJWEvUjA0SpBUuryn1nv5p9QOyO0I=;
        b=tJHUbIO8i3Z7bU4VyZBfo8tUxDnO9Yn3oopASSJm5gyYrOvE7M43hjbSKH2nvd/F1x
         PZ5k/pOQklSvLaW+P1NCZAv4ERaebucfQNRyvvmge0UqL+ueZrFAvqfp+K1G9sHDXZic
         xa24NrAwBp2FtKmTuvEb9CTVPNvdGRxtzMwYE+KeOUXa/L5Nx1zOdXE235pqYLOonASX
         kHoE3CvKP3IgaMHgbHmGrV4ag8uCBkDaqzLRFUXB/ZqI5CVwfPlxQxg7dZNGLvgHlGcR
         emaDLrRmpClJtSnj7/8utJbrv2JQNUkpb6ICmyNLslrjuHlyLdg14sLPUPuJx8QYSnxQ
         y9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWGW78BvPEYG06IQqnPIkzQQwNwBqp8IgIvSA+kAdygR3fvk/GGmadYVKOz43EoZTNNv50WI4dDCksMKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnlvVYRMW+6kqr/fKqZJ9OBicfxmbzwmYmdI02ZQOoSFKr00G5
	4Q9ESDlN7w4IqTXBj1WCzf11MYfevRvotol0xPEkinYLugugj7Uv47d7pVYefz9QqQ9DyvlOoyU
	uPPJbVrqsquw0GKasiytWIYffTbgzafTNU05aWw==
X-Gm-Gg: ASbGncvV2vPofRd0y3DImIczft8/mwJRz2hnpSmZITv4UUXn0VYTxs5tmQL6IcwlqqZ
	7d0i8qWXgdVfzyGkFBB4LhNm2SrLw5yWBSvmVMCs0g1SMJnzccL0LKYwARWbfmua1dke3LseUcs
	VXXi+vD5qHljV9LTP5FRXw7g==
X-Google-Smtp-Source: AGHT+IFK0QLC6BCqnPQEezaBSjWk6KdQCSE5+Gfet1RkZ2FmHbJ+YhxaEeLLuvKg+wmx+n353gipyz4JSkMSRj0+L4M=
X-Received: by 2002:a17:90b:1c91:b0:306:b593:4551 with SMTP id
 98e67ed59e1d1-309f7ebaff5mr6351648a91.6.1745850498795; Mon, 28 Apr 2025
 07:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-6-csander@purestorage.com> <aA4rqcpC01SzUn_g@fedora>
In-Reply-To: <aA4rqcpC01SzUn_g@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Apr 2025 07:28:07 -0700
X-Gm-Features: ATxdqUHtsQExf7Ca3a6na1mNH0B2aXQMhUfJn0rd5iFTOraQL3F8E_fyTkhvdRo
Message-ID: <CADUfDZpEGVLzEZJtPiScWgf6PVroQvKKhGed1cb8AJiyUr_RYg@mail.gmail.com>
Subject: Re: [PATCH 5/8] ublk: factor out ublk_start_io() helper
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 6:05=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Sat, Apr 26, 2025 at 10:58:00PM -0600, Caleb Sander Mateos wrote:
> > In preparation for calling it from outside ublk_dispatch_req(), factor
> > out the code responsible for setting up an incoming ublk I/O request.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 53 ++++++++++++++++++++++------------------
> >  1 file changed, 29 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 01fc92051754..90a38a82f8cc 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1151,17 +1151,44 @@ static inline void __ublk_abort_rq(struct ublk_=
queue *ubq,
> >               blk_mq_requeue_request(rq, false);
> >       else
> >               blk_mq_end_request(rq, BLK_STS_IOERR);
> >  }
> >
> > +static void ublk_start_io(struct ublk_queue *ubq, struct request *req,
> > +                       struct ublk_io *io)
> > +{
> > +     unsigned mapped_bytes =3D ublk_map_io(ubq, req, io);
> > +
> > +     /* partially mapped, update io descriptor */
> > +     if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > +             /*
> > +              * Nothing mapped, retry until we succeed.
> > +              *
> > +              * We may never succeed in mapping any bytes here because
> > +              * of OOM. TODO: reserve one buffer with single page pinn=
ed
> > +              * for providing forward progress guarantee.
> > +              */
> > +             if (unlikely(!mapped_bytes)) {
> > +                     blk_mq_requeue_request(req, false);
> > +                     blk_mq_delay_kick_requeue_list(req->q,
> > +                                     UBLK_REQUEUE_DELAY_MS);
> > +                     return;
> > +             }
> > +
> > +             ublk_get_iod(ubq, req->tag)->nr_sectors =3D
> > +                     mapped_bytes >> 9;
> > +     }
> > +
> > +     ublk_init_req_ref(ubq, req);
> > +}
> > +
> >  static void ublk_dispatch_req(struct ublk_queue *ubq,
> >                             struct request *req,
> >                             unsigned int issue_flags)
> >  {
> >       int tag =3D req->tag;
> >       struct ublk_io *io =3D &ubq->ios[tag];
> > -     unsigned int mapped_bytes;
> >
> >       pr_devel("%s: complete: qid %d tag %d io_flags %x addr %llx\n",
> >                       __func__, ubq->q_id, req->tag, io->flags,
> >                       ublk_get_iod(ubq, req->tag)->addr);
> >
> > @@ -1204,33 +1231,11 @@ static void ublk_dispatch_req(struct ublk_queue=
 *ubq,
> >               pr_devel("%s: update iod->addr: qid %d tag %d io_flags %x=
 addr %llx\n",
> >                               __func__, ubq->q_id, req->tag, io->flags,
> >                               ublk_get_iod(ubq, req->tag)->addr);
> >       }
> >
> > -     mapped_bytes =3D ublk_map_io(ubq, req, io);
> > -
> > -     /* partially mapped, update io descriptor */
> > -     if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > -             /*
> > -              * Nothing mapped, retry until we succeed.
> > -              *
> > -              * We may never succeed in mapping any bytes here because
> > -              * of OOM. TODO: reserve one buffer with single page pinn=
ed
> > -              * for providing forward progress guarantee.
> > -              */
> > -             if (unlikely(!mapped_bytes)) {
> > -                     blk_mq_requeue_request(req, false);
> > -                     blk_mq_delay_kick_requeue_list(req->q,
> > -                                     UBLK_REQUEUE_DELAY_MS);
> > -                     return;
> > -             }
>
> Here it needs to break ublk_dispatch_req() for not completing the
> uring_cmd, however ublk_start_io() can't support it.

Good catch. How about I change ublk_start_io() to return a bool
indicating whether the I/O was successfully started?

Thanks,
Caleb
