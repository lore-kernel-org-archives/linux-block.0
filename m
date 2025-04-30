Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB91DFDB9
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053094; cv=none; b=bhrewdDupeLNeTTn7HnsKOFfTX0E2wrL4hKsc31hcO2MMIuMI2vcGkFy32TDxi3e8h37fTrRAMTl/D9nN9AM7oY8T879vXkUE7URsy+JJv/9ViKoKATfwmVSHnrXHpU5c+FMMT8aUa1FFHR4NkfjLorhk66cgHKpo3gVoPuu5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053094; c=relaxed/simple;
	bh=1+JIBphWHfDcWl02h0RjxDS4m+42dqs1JZljITnINdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFALULfgAhf+g1Zqdf/5oZbGa2mwUxJ8JZE//4ERkbDOIAvOkFqcDt65jE2j4HRwERM0T4mmJKF4yg38bqcMgqxMGNsx2Yr9EGG1dDraqbqvSnxwGW5LKVHxmqUB2dkRQDIUBSi3X9jHjnka/s4W0icaj+0kZn0oMhzA5Y2MK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aO2LlmMV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aO2LlmMV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240ff0bd6eso590175ad.0
        for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746053092; x=1746657892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceeMIRWgv4SCR5iGq8PYK6f2/FuZygILbwwdKDZzsv0=;
        b=aO2LlmMVh6h3Vb2ReQb0QOb7uAbO6mhl3cdWPqVs25ragANhjFssJlq/Mqgy1HeShp
         lBIPZD3+LzY43A6TTyoGjAcG8ZPH9dbzrMN/PbdT+YoHIqouCn/K05jV6qcJC9V29R/V
         D8iQhYDLgcViXmR2jzf5fOz1/ozUGKFYziC2ZtH4PLGlRirhzJdsuHD4DWIUPpiVBk2s
         k4euG46Zfikr7ibygJy+QZg7R4oVbdNY8Ym85NVuglc3nbi5IVENWx9if9TSM5gwot5b
         7s2oyWDn81q8BKifivOeQjD/dlYXpJhWVqOET1ZiwC2IoxPLKyCfveHXaGXLiiXoIAP6
         RpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746053092; x=1746657892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceeMIRWgv4SCR5iGq8PYK6f2/FuZygILbwwdKDZzsv0=;
        b=TeoQE1Nwx6IZUnGE4RLvu3GwscS+/2ogromcERFUjRPCKZxvTML3b9sjDSVA1tOUWV
         sJBbB5wUBRVxKrS7ap/9AKipquz7j8K8xjiCXJPcy3FBUt4cISeZKfcd2qGiL2jiNLMq
         qrG8GjaywY7fm3+J6Lcn4ibSSqMOm0EyqozJvX44Q7a1MYqcCxfu9oahnTnc9BVnxo+4
         SfucZwUnz6RRRpvcEOFljQdSa3I5MTy/abAG7I67ollGFoIUPaTCGJqFarz4+njQ8xdL
         yh6/sR8LkKhGs7mqwDOoUWN4tblSYv7AkKUtwlkV9cNSSBvi7ApYLTiu8rIL+Z3msz1d
         b/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWFIlJTvaSAJ2SPeM479X2hh33uFUxRj9RQsT/TyluUmg1yIQR1ltGTRAgEdU2+dpweW4LTui7LbfiTsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTa5RJMk4cTmGUUgPu7ax1Vuie8U5xJWJBgVXCaIGVFvshQoG
	B2rxXNoaM+A6aKkDxzP3/U/ZxyLmI54ZSoOs3m1dOJk5taEs/TpyZQKC8sIkpp7+DyePGmlqVVc
	PZH0JyMpkAOSJ4GYapeD7DCIgSX5V9w2J7Mbtvhz3gPklVSThA0jA5A==
X-Gm-Gg: ASbGncvdlMVKM/ksK+ZBrW0O24MRahDHFt7+MFCXbohyxhT8Il20QDo5CghbsjynCpn
	rSRUAb0wOL9Pv3wbfsgCbZNLYwC7WVU944mGn4cYZ0zUtBrLJDSJU1rTpc6FdOimudUjsUhax3V
	ktt31HB77MagknlKWsYpTq
X-Google-Smtp-Source: AGHT+IE0Zg5f6VjXaW0QKlFCFCGm617lQSPwzy4fZyxl9+kVfeVCVFmkB1vj9aliLt42Hgd8VxhRNooSsSHBoe+H+Sg=
X-Received: by 2002:a17:90b:3e8b:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-30a348d7896mr2483484a91.0.1746053091617; Wed, 30 Apr 2025
 15:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-6-csander@purestorage.com> <aA4rqcpC01SzUn_g@fedora>
 <CADUfDZpEGVLzEZJtPiScWgf6PVroQvKKhGed1cb8AJiyUr_RYg@mail.gmail.com>
 <CADUfDZqqeeBTbgvCfHa8sr7Y7BetGbPzHYA1hMoN83kz+Bi54A@mail.gmail.com>
 <aBBQDjLDkGWE63vT@fedora> <CADUfDZroQ4zHanPjytcEUhn4tQc3BYMPZD2uLOik7jAXvOCjGg@mail.gmail.com>
In-Reply-To: <CADUfDZroQ4zHanPjytcEUhn4tQc3BYMPZD2uLOik7jAXvOCjGg@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 30 Apr 2025 15:44:40 -0700
X-Gm-Features: ATxdqUGgthu2otFRLelqvowO_XHdUR9JnnnpNESPicNrS9lWbym4m_M-Fg4SsdE
Message-ID: <CADUfDZqtoiK0vX-sfN5OiEQo4j=j3wtYdRJy5LGMqASPp+2BKQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] ublk: factor out ublk_start_io() helper
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:55=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Apr 28, 2025 at 9:05=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wr=
ote:
> >
> > On Mon, Apr 28, 2025 at 08:12:52AM -0700, Caleb Sander Mateos wrote:
> > > On Mon, Apr 28, 2025 at 7:28=E2=80=AFAM Caleb Sander Mateos
> > > <csander@purestorage.com> wrote:
> > > >
> > > > On Sun, Apr 27, 2025 at 6:05=E2=80=AFAM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > On Sat, Apr 26, 2025 at 10:58:00PM -0600, Caleb Sander Mateos wro=
te:
> > > > > > In preparation for calling it from outside ublk_dispatch_req(),=
 factor
> > > > > > out the code responsible for setting up an incoming ublk I/O re=
quest.
> > > > > >
> > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > > ---
> > > > > >  drivers/block/ublk_drv.c | 53 ++++++++++++++++++++++----------=
--------
> > > > > >  1 file changed, 29 insertions(+), 24 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.=
c
> > > > > > index 01fc92051754..90a38a82f8cc 100644
> > > > > > --- a/drivers/block/ublk_drv.c
> > > > > > +++ b/drivers/block/ublk_drv.c
> > > > > > @@ -1151,17 +1151,44 @@ static inline void __ublk_abort_rq(stru=
ct ublk_queue *ubq,
> > > > > >               blk_mq_requeue_request(rq, false);
> > > > > >       else
> > > > > >               blk_mq_end_request(rq, BLK_STS_IOERR);
> > > > > >  }
> > > > > >
> > > > > > +static void ublk_start_io(struct ublk_queue *ubq, struct reque=
st *req,
> > > > > > +                       struct ublk_io *io)
> > > > > > +{
> > > > > > +     unsigned mapped_bytes =3D ublk_map_io(ubq, req, io);
> > > > > > +
> > > > > > +     /* partially mapped, update io descriptor */
> > > > > > +     if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > > > > > +             /*
> > > > > > +              * Nothing mapped, retry until we succeed.
> > > > > > +              *
> > > > > > +              * We may never succeed in mapping any bytes here=
 because
> > > > > > +              * of OOM. TODO: reserve one buffer with single p=
age pinned
> > > > > > +              * for providing forward progress guarantee.
> > > > > > +              */
> > > > > > +             if (unlikely(!mapped_bytes)) {
> > > > > > +                     blk_mq_requeue_request(req, false);
> > > > > > +                     blk_mq_delay_kick_requeue_list(req->q,
> > > > > > +                                     UBLK_REQUEUE_DELAY_MS);
> > > > > > +                     return;
> > > > > > +             }
> > > > > > +
> > > > > > +             ublk_get_iod(ubq, req->tag)->nr_sectors =3D
> > > > > > +                     mapped_bytes >> 9;
> > > > > > +     }
> > > > > > +
> > > > > > +     ublk_init_req_ref(ubq, req);
> > > > > > +}
> > > > > > +
> > > > > >  static void ublk_dispatch_req(struct ublk_queue *ubq,
> > > > > >                             struct request *req,
> > > > > >                             unsigned int issue_flags)
> > > > > >  {
> > > > > >       int tag =3D req->tag;
> > > > > >       struct ublk_io *io =3D &ubq->ios[tag];
> > > > > > -     unsigned int mapped_bytes;
> > > > > >
> > > > > >       pr_devel("%s: complete: qid %d tag %d io_flags %x addr %l=
lx\n",
> > > > > >                       __func__, ubq->q_id, req->tag, io->flags,
> > > > > >                       ublk_get_iod(ubq, req->tag)->addr);
> > > > > >
> > > > > > @@ -1204,33 +1231,11 @@ static void ublk_dispatch_req(struct ub=
lk_queue *ubq,
> > > > > >               pr_devel("%s: update iod->addr: qid %d tag %d io_=
flags %x addr %llx\n",
> > > > > >                               __func__, ubq->q_id, req->tag, io=
->flags,
> > > > > >                               ublk_get_iod(ubq, req->tag)->addr=
);
> > > > > >       }
> > > > > >
> > > > > > -     mapped_bytes =3D ublk_map_io(ubq, req, io);
> > > > > > -
> > > > > > -     /* partially mapped, update io descriptor */
> > > > > > -     if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > > > > > -             /*
> > > > > > -              * Nothing mapped, retry until we succeed.
> > > > > > -              *
> > > > > > -              * We may never succeed in mapping any bytes here=
 because
> > > > > > -              * of OOM. TODO: reserve one buffer with single p=
age pinned
> > > > > > -              * for providing forward progress guarantee.
> > > > > > -              */
> > > > > > -             if (unlikely(!mapped_bytes)) {
> > > > > > -                     blk_mq_requeue_request(req, false);
> > > > > > -                     blk_mq_delay_kick_requeue_list(req->q,
> > > > > > -                                     UBLK_REQUEUE_DELAY_MS);
> > > > > > -                     return;
> > > > > > -             }
> > > > >
> > > > > Here it needs to break ublk_dispatch_req() for not completing the
> > > > > uring_cmd, however ublk_start_io() can't support it.
> > > >
> > > > Good catch. How about I change ublk_start_io() to return a bool
> > > > indicating whether the I/O was successfully started?
> >
> > That is doable.
> >
> > >
> > > Thinking a bit more about this, is the existing behavior of returning
> > > early from ublk_dispatch_req() correct for UBLK_IO_NEED_GET_DATA? It
> >
> > The requeue isn't related with UBLK_IO_NEED_GET_DATA actually, when
> > UBLK_IO_FLAG_NEED_GET_DATA is cleared.
> >
> > It is usually caused by running out of pages, so we have to requeue unt=
il
> > ublk_map_io() can make progress.
> >
> > > makes sense for the initial ublk_dispatch_req() because the req will
> > > be requeued without consuming the ublk fetch request, allowing it to
> > > be reused for a subsequent I/O. But for UBLK_IO_NEED_GET_DATA, doesn'=
t
> > > it mean the io_uring_cmd will never complete? I would think it would
> > > be better to return an error code in this case.
> >
> > The same request will be requeued and re-dispatched to ublk driver afte=
r
> > a short delay, so the uring_cmd won't be never complete.
>
> I am referring to the UBLK_IO_NEED_GET_DATA uring_cmd, not the FETCH
> one. Doesn't the early return in ublk_dispatch_req() mean
> ublk_complete_io_cmd() won't be called? How else can the
> UBLK_IO_NEED_GET_DATA complete?
>
> >
> > Anyway, it isn't another story, which shouldn't be added into this
> > cleanup patch.
>
> I agree it belongs in a separate patch.

I am not going to fix it in this patch set. I am not sure what the
result value for UBLK_IO_NEED_GET_DATA should be if
ublk_copy_user_pages() returns 0. I also noticed that the return value
of import_ubuf() is ignored, which means that a bad userspace address
will result in an uninitialized struct iov_iter. I think ublk_map_io()
and ublk_unmap_io() may need to have more failure modes.

Best,
Caleb
