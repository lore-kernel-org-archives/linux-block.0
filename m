Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696B218EB0
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938526; cv=none; b=LgeBWLct+ygPXVyEXBVOffcoO36tCoLAeQqJxyYoxDWgJ8+p8HTIFf4VFlXG5NpN/Nl9pR7SW1KssujGHJuwTWs/KLIqLFxxK+NvA6DbtPnv/hJTJzMzeXHOV8ZrU4wzdFg/soTMCOS1JIs0MzU83F2SuWsYn9N66nNH9ZrSNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938526; c=relaxed/simple;
	bh=6pjN8xbnxV9pDtEawDx5cmq+vBu7qG8f7meQFUIddqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/7a0XpBL+TLC25K7EK8mgREuJvwYP5rTYvBYkEObEMXxRAo2ca5Mae1mY6Lq8C/F0jLZ8CX1qVu1Een90g6xt/5yLbvnxgHsSZX157mjd6IpuI0U2ZV1O4BGxloc/bp4pR6Rug47Kk8uqR3RDxfWpaSbQx3uraY+AUzw14EMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Hl4XiLXn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Hl4XiLXn"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so561131a91.3
        for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745938523; x=1746543323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF2cytyryKmEKcUAK+pBobxZN4rDC3VGSqrUogsqSw0=;
        b=Hl4XiLXnT1BlgiDRyDEmLJAGKCZNjFzl4ExL78v+EgpFLoy/xapT0WmzQ+PdZOZE8N
         dP64A7fxULN1D4AyvpoAQS6ZRs0SbM1YzhIq9XgShABTD1NzqJ34qzJUC/SpU6xavAWF
         ZOafFcQZ2jmxxCPCQ6gLz4eEiYySs/Bo93ZIPPBgq/lT4R8ZMKnkhusFmOojTAJZI2dp
         +blU9l3O8mDEG0r4MBmN5f4faA91TrYDsKGGI/reVDJlz9a1TPJ3o0vvcw5Rhu+GnS2R
         b0fKMRBt7VAHTwdGWO7rJ0y9LfLbskbiD1Axgg9d3FV5d2ciX18wQWvivSr3pl2EhhXS
         ed7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938523; x=1746543323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF2cytyryKmEKcUAK+pBobxZN4rDC3VGSqrUogsqSw0=;
        b=uzDUuxhdrvvDqmpHwC0Y6XxSzmYl9vK/NdCENgTyTPN2sJ537yrA9iGmiQsu7YUgWa
         lS8qw06iZ07YCMkN5dwlydbbygkYM5nelc2PFzCe62A0CI4oPDORHoegVIyddvogxoc3
         LuSMLVKnTcfnr1pXnKoaLxgF6ok+6rTbO+QvR0+3bzo8RoagupIprFCmtwzlTIRPcm+D
         kdJQPBxa74+OKveQVS7kX+iPSFwwxeiujp5oOKWLut9S7UWuX7/c85w8oiST1S5bL+Bf
         xQ+jyQPO8Ov4qqUqed075fFWJmh1ZxqULZxm/iD3vt9LGG9msVA9lAiIUhaMOSfHSIob
         OKRg==
X-Forwarded-Encrypted: i=1; AJvYcCWU9ylaWHghC0QEmdn/3QPvoWi1xXgyhu7DivTzhyIxC1orZTXwVY/u2ABiDNlnJSsSjWtD9MiQIS6bSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5IqHUJzg2X8Xl6rfl1nQbB+uFhgM/A6+Esx19mYM/fcHQPvGi
	bGbB5LIdrqjGzGaN6L+ap8i9qOu2GwfzcerrsTExBXwmrqDQE2e53h5PJtNSFX3QndR/53WoQPV
	L3b1qZUILDcs70e7V0JKoiz8IrErHE6SgsWXFEw==
X-Gm-Gg: ASbGnct0z3sqjlBeLl4qM49PDx0cfETKxVNxOLvGRN1a6OtLeYwBlG/G/f7xGkjxqeQ
	QpC2DhYBQnH77YOosnfWpxbVavcbr3p8qwlg5X7wilGt6FRsGENkKITMl1zc65GsbboChBOdOxi
	XkBJRK75XygJ9gEqDi6Qz4
X-Google-Smtp-Source: AGHT+IEZdJ+noq7oxgaFMD1JayQtdWBsSaMvnm7kH5BOp2vha1U9lmP2efZQGH+3bkKDZG9FbSMQqHluyZa5+swZHyI=
X-Received: by 2002:a17:90b:4a05:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-309f7e9e312mr8896247a91.5.1745938523216; Tue, 29 Apr 2025
 07:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-6-csander@purestorage.com> <aA4rqcpC01SzUn_g@fedora>
 <CADUfDZpEGVLzEZJtPiScWgf6PVroQvKKhGed1cb8AJiyUr_RYg@mail.gmail.com>
 <CADUfDZqqeeBTbgvCfHa8sr7Y7BetGbPzHYA1hMoN83kz+Bi54A@mail.gmail.com> <aBBQDjLDkGWE63vT@fedora>
In-Reply-To: <aBBQDjLDkGWE63vT@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 29 Apr 2025 07:55:10 -0700
X-Gm-Features: ATxdqUH5bTmTqX44Hzi533MxE4zSI0TaCZXtg4vOlrldrq4Do_Wue3jkeG-JLN4
Message-ID: <CADUfDZroQ4zHanPjytcEUhn4tQc3BYMPZD2uLOik7jAXvOCjGg@mail.gmail.com>
Subject: Re: [PATCH 5/8] ublk: factor out ublk_start_io() helper
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 9:05=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Apr 28, 2025 at 08:12:52AM -0700, Caleb Sander Mateos wrote:
> > On Mon, Apr 28, 2025 at 7:28=E2=80=AFAM Caleb Sander Mateos
> > <csander@purestorage.com> wrote:
> > >
> > > On Sun, Apr 27, 2025 at 6:05=E2=80=AFAM Ming Lei <ming.lei@redhat.com=
> wrote:
> > > >
> > > > On Sat, Apr 26, 2025 at 10:58:00PM -0600, Caleb Sander Mateos wrote=
:
> > > > > In preparation for calling it from outside ublk_dispatch_req(), f=
actor
> > > > > out the code responsible for setting up an incoming ublk I/O requ=
est.
> > > > >
> > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c | 53 ++++++++++++++++++++++------------=
------
> > > > >  1 file changed, 29 insertions(+), 24 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index 01fc92051754..90a38a82f8cc 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -1151,17 +1151,44 @@ static inline void __ublk_abort_rq(struct=
 ublk_queue *ubq,
> > > > >               blk_mq_requeue_request(rq, false);
> > > > >       else
> > > > >               blk_mq_end_request(rq, BLK_STS_IOERR);
> > > > >  }
> > > > >
> > > > > +static void ublk_start_io(struct ublk_queue *ubq, struct request=
 *req,
> > > > > +                       struct ublk_io *io)
> > > > > +{
> > > > > +     unsigned mapped_bytes =3D ublk_map_io(ubq, req, io);
> > > > > +
> > > > > +     /* partially mapped, update io descriptor */
> > > > > +     if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > > > > +             /*
> > > > > +              * Nothing mapped, retry until we succeed.
> > > > > +              *
> > > > > +              * We may never succeed in mapping any bytes here b=
ecause
> > > > > +              * of OOM. TODO: reserve one buffer with single pag=
e pinned
> > > > > +              * for providing forward progress guarantee.
> > > > > +              */
> > > > > +             if (unlikely(!mapped_bytes)) {
> > > > > +                     blk_mq_requeue_request(req, false);
> > > > > +                     blk_mq_delay_kick_requeue_list(req->q,
> > > > > +                                     UBLK_REQUEUE_DELAY_MS);
> > > > > +                     return;
> > > > > +             }
> > > > > +
> > > > > +             ublk_get_iod(ubq, req->tag)->nr_sectors =3D
> > > > > +                     mapped_bytes >> 9;
> > > > > +     }
> > > > > +
> > > > > +     ublk_init_req_ref(ubq, req);
> > > > > +}
> > > > > +
> > > > >  static void ublk_dispatch_req(struct ublk_queue *ubq,
> > > > >                             struct request *req,
> > > > >                             unsigned int issue_flags)
> > > > >  {
> > > > >       int tag =3D req->tag;
> > > > >       struct ublk_io *io =3D &ubq->ios[tag];
> > > > > -     unsigned int mapped_bytes;
> > > > >
> > > > >       pr_devel("%s: complete: qid %d tag %d io_flags %x addr %llx=
\n",
> > > > >                       __func__, ubq->q_id, req->tag, io->flags,
> > > > >                       ublk_get_iod(ubq, req->tag)->addr);
> > > > >
> > > > > @@ -1204,33 +1231,11 @@ static void ublk_dispatch_req(struct ublk=
_queue *ubq,
> > > > >               pr_devel("%s: update iod->addr: qid %d tag %d io_fl=
ags %x addr %llx\n",
> > > > >                               __func__, ubq->q_id, req->tag, io->=
flags,
> > > > >                               ublk_get_iod(ubq, req->tag)->addr);
> > > > >       }
> > > > >
> > > > > -     mapped_bytes =3D ublk_map_io(ubq, req, io);
> > > > > -
> > > > > -     /* partially mapped, update io descriptor */
> > > > > -     if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > > > > -             /*
> > > > > -              * Nothing mapped, retry until we succeed.
> > > > > -              *
> > > > > -              * We may never succeed in mapping any bytes here b=
ecause
> > > > > -              * of OOM. TODO: reserve one buffer with single pag=
e pinned
> > > > > -              * for providing forward progress guarantee.
> > > > > -              */
> > > > > -             if (unlikely(!mapped_bytes)) {
> > > > > -                     blk_mq_requeue_request(req, false);
> > > > > -                     blk_mq_delay_kick_requeue_list(req->q,
> > > > > -                                     UBLK_REQUEUE_DELAY_MS);
> > > > > -                     return;
> > > > > -             }
> > > >
> > > > Here it needs to break ublk_dispatch_req() for not completing the
> > > > uring_cmd, however ublk_start_io() can't support it.
> > >
> > > Good catch. How about I change ublk_start_io() to return a bool
> > > indicating whether the I/O was successfully started?
>
> That is doable.
>
> >
> > Thinking a bit more about this, is the existing behavior of returning
> > early from ublk_dispatch_req() correct for UBLK_IO_NEED_GET_DATA? It
>
> The requeue isn't related with UBLK_IO_NEED_GET_DATA actually, when
> UBLK_IO_FLAG_NEED_GET_DATA is cleared.
>
> It is usually caused by running out of pages, so we have to requeue until
> ublk_map_io() can make progress.
>
> > makes sense for the initial ublk_dispatch_req() because the req will
> > be requeued without consuming the ublk fetch request, allowing it to
> > be reused for a subsequent I/O. But for UBLK_IO_NEED_GET_DATA, doesn't
> > it mean the io_uring_cmd will never complete? I would think it would
> > be better to return an error code in this case.
>
> The same request will be requeued and re-dispatched to ublk driver after
> a short delay, so the uring_cmd won't be never complete.

I am referring to the UBLK_IO_NEED_GET_DATA uring_cmd, not the FETCH
one. Doesn't the early return in ublk_dispatch_req() mean
ublk_complete_io_cmd() won't be called? How else can the
UBLK_IO_NEED_GET_DATA complete?

>
> Anyway, it isn't another story, which shouldn't be added into this
> cleanup patch.

I agree it belongs in a separate patch.

Best,
Caleb
