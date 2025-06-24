Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC04C274B3A
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778825; cv=none; b=dDafTdPqMeYV8GbvvlNMGu6OE24lB1EKo+EK70oip2OpBRlcKBA2cnR0mVPe14WMQx1H+c/R5BEIcVXMB2inzE7e+JQx+hnqmAGkLMQNOlLO7PAsEHKI+2uzxHdGIQl+KX9bYXImTF6PdtXqFtDVYqz34hhXOKcxx+46x/oRQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778825; c=relaxed/simple;
	bh=3v0uMXX/5Fk1XTSuvkwoIIv18ScRel2o5VrAQ6ty2Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpDf/EBaJvABn41+xguw0zb5eahHGyAWdsX/7uasMVUTxuuBOksBwTRahqHy9ZUQS0aGYSHRfD/s4v0YgcmtfRmrkqB0fUVUy5C66tpUPCIVl8I80Rz/oeH8fgcTIJyY9XUH8zYEaIW4rKKuaBSrwSxN24z+IDbVY0KIl8wokQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CY7GCQj7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CY7GCQj7"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234d3103237so8122145ad.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750778823; x=1751383623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ6dD/RgGYGJWAbPiN/pP/vlykkXTVIB5obcMeoGVPk=;
        b=CY7GCQj7D3oS27J98PDe0dSiEEsRDQBDgepuyEWEOXjK0H3NGhnPnfgZMTAMKsBX7D
         fi4fgrsMqZrMjM2N1lREB71YjUy614FDgIG0G3hyD/EVx1JgD9vWqlmY7nmTDTcKCxCp
         bQJ5UPvshheklLi0Q/9EEnODD15H1z+hBdGcBU3x+rOIO8wqQ3QGjjJYMTbP/FKSVd5Q
         SzUHq2Xn88WFlOvymd48P3HnGWCCgGoo7v0KMaCYAeLto4ZMWnzrIDkp9PnBjWu0JBps
         fwVcrNsFa8mmq4COP+IysCGICnI9DzOjmcLoGX98R4LpLgscYfQUSLq73BhvYB+WCdzK
         twFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750778823; x=1751383623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ6dD/RgGYGJWAbPiN/pP/vlykkXTVIB5obcMeoGVPk=;
        b=EImpeO0AsbbaZ/c/YoGTjF0Wib4BB1zj7XD+CXJRpxPN7Vusfy6nnOAwUnpgRDIsWI
         l1Krx/d3TkFVGV5ER6ajhaZ8GkgMxjjaGJzzZEeQnmbQR4CHK7yhCwl9RO8aO2iE1DJc
         nP6Ly/vh5DuCVzvjmMlq9p5peIKaxdZdtgDekmYk7AvCISWfjMYOhkDy2zPBtG/6fI+c
         +7Q95DytNOS26RgA1sWgjyWBDWok70moIfh2uZifeZSKrNi2GCu70sm1pfmRQ8M0d4x8
         xdjpNbCqLwwIQmFHgdpOEolprsO3Vw+7X1bJYZUYnn+osbzZqkUODBaWaDNF3rTlXPj9
         bvcg==
X-Forwarded-Encrypted: i=1; AJvYcCWkYcTOYEc165QJR5C7mU88iRShpQ2dqT+E7qMomjY7QzCHRmTW6wIkGwWNCfGlKszVD3aETVbGGqMHsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIy/j4OPhHU22eQwLRAqY8Ife5GSpHLkpQIqB5ALN2VxZgvG/G
	GW4KrPP3DIrrj55m7MZueqoNzkRYc4PP7WEJR4rq23MgdBuL5zDzBsl6i6g6PxkW6jf5h2FEszO
	71dEnVqS1UsztUgFUEgILjvceC1c6euKhWYv4oba4tGZJu54/S79ZUgk=
X-Gm-Gg: ASbGnctm3Klq7rctEdA4Ioby50LdlP92BzWUpulL7poYie0RzyrdvBuw0ypej6y/p/f
	6PMSqD+C98l/wMXg670Fr6VRwV7/QXOMNn3c3hf6+rrar9xF9emiZFiRd9Oz6FoRBgMrdL5FGet
	02sDB5uiyEERCX5+gcrGqPLvsmETHntS9QrlDRHiwqAw==
X-Google-Smtp-Source: AGHT+IEnFAUWL8OcwYdn2TKjFI5FNvpU7SZE+kVYGA4ybquTyIy/lWzVWkZjSLyLeFT55sHJcttbX58pproZEnPLPwc=
X-Received: by 2002:a17:90b:4b49:b0:313:151a:8653 with SMTP id
 98e67ed59e1d1-3159d9152abmr8959569a91.8.1750778823053; Tue, 24 Jun 2025
 08:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623011934.741788-1-ming.lei@redhat.com> <20250623011934.741788-2-ming.lei@redhat.com>
 <CADUfDZp=69+ZpJ5vc7c9qGmA3zLU+eYdYd2PfeiDwFvxYQ+0nQ@mail.gmail.com> <aFn-RNJxWFl5Vz-G@fedora>
In-Reply-To: <aFn-RNJxWFl5Vz-G@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 24 Jun 2025 08:26:51 -0700
X-Gm-Features: AX0GCFtop0ncHZ0u_cR_VAcN6qP4h1dbnfaP3JlSpfPQ39YzhmK41L_PM46BsRo
Message-ID: <CADUfDZq3CN+i2d9sX+79n-Si4UWad-2n2_9E+-vkj0vfb7pVGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: build per-io-ring-ctx batch list
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:24=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Jun 23, 2025 at 10:51:00AM -0700, Caleb Sander Mateos wrote:
> > On Sun, Jun 22, 2025 at 6:19=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > ublk_queue_cmd_list() dispatches the whole batch list by scheduling t=
ask
> > > work via the tail request's io_uring_cmd, this way is fine even thoug=
h
> > > more than one io_ring_ctx are involved for this batch since it is jus=
t
> > > one running context.
> > >
> > > However, the task work handler ublk_cmd_list_tw_cb() takes `issue_fla=
gs`
> > > of tail uring_cmd's io_ring_ctx for completing all commands. This way=
 is
> > > wrong if any uring_cmd is issued from different io_ring_ctx.
> > >
> > > Fixes it by always building per-io-ring-ctx batch list.
> > >
> > > For typical per-queue or per-io daemon implementation, this way shoul=
dn't
> > > make difference from performance viewpoint, because single io_ring_ct=
x is
> > > often taken in each daemon.
> > >
> > > Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")
> > > Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-que=
ue daemon")
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 17 +++++++++--------
> > >  1 file changed, 9 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index c637ea010d34..e79b04e61047 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -1336,9 +1336,8 @@ static void ublk_cmd_list_tw_cb(struct io_uring=
_cmd *cmd,
> > >         } while (rq);
> > >  }
> > >
> > > -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *=
l)
> > > +static void ublk_queue_cmd_list(struct io_uring_cmd *cmd, struct rq_=
list *l)
> > >  {
> > > -       struct io_uring_cmd *cmd =3D io->cmd;
> > >         struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd=
);
> > >
> > >         pdu->req_list =3D rq_list_peek(l);
> > > @@ -1420,16 +1419,18 @@ static void ublk_queue_rqs(struct rq_list *rq=
list)
> > >  {
> > >         struct rq_list requeue_list =3D { };
> > >         struct rq_list submit_list =3D { };
> > > -       struct ublk_io *io =3D NULL;
> > > +       struct io_uring_cmd *cmd =3D NULL;
> > >         struct request *req;
> > >
> > >         while ((req =3D rq_list_pop(rqlist))) {
> > >                 struct ublk_queue *this_q =3D req->mq_hctx->driver_da=
ta;
> > > -               struct ublk_io *this_io =3D &this_q->ios[req->tag];
> > > +               struct io_uring_cmd *this_cmd =3D this_q->ios[req->ta=
g].cmd;
> > >
> > > -               if (io && io->task !=3D this_io->task && !rq_list_emp=
ty(&submit_list))
> > > -                       ublk_queue_cmd_list(io, &submit_list);
> > > -               io =3D this_io;
> > > +               if (cmd && io_uring_cmd_ctx_handle(cmd) !=3D
> > > +                               io_uring_cmd_ctx_handle(this_cmd) &&
> > > +                               !rq_list_empty(&submit_list))
> > > +                       ublk_queue_cmd_list(cmd, &submit_list);
> >
> > I don't think we can assume that ublk commands submitted to the same
> > io_uring have the same daemon task. It's possible for multiple tasks
> > to submit to the same io_uring, even though that's not a common or
> > performant way to use io_uring. Probably we need to check that both
> > the task and io_ring_ctx match.
>
> Here the problem is in 'issue_flags' passed from io_uring, especially for
> grabbing io_ring_ctx lock.
>
> If two uring_cmd are issued via same io_ring_ctx from two tasks, it is
> fine to share 'issue_flags' from one of tasks, what matters is that the
> io_ring_ctx lock is handled correctly when calling io_uring_cmd_done().

Right, I understand the issue you are trying to solve. I agree it's a
problem for submit_list to contain commands from multiple
io_ring_ctxs. But it's also a problem if it contains commands with
different daemon tasks, because ublk_queue_cmd_list() will schedule
ublk_cmd_list_tw_cb() to be called in the *last command's task*. But
ublk_cmd_list_tw_cb() will call ublk_dispatch_req() for all the
commands in the list. So if submit_list contains commands with
multiple daemon tasks, ublk_dispatch_req() will fail on the current !=3D
io->task check. So I still feel we need to call
ublk_queue_cmd_list(io, &submit_list) if io->task !=3D this_io->task (as
well as if the io_ring_ctxs differ).

Best,
Caleb
