Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F9225F7BA
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853186; cv=none; b=e4QERCqygXpt/DqH4hwbxGRJotA0IpZ9i/gVGrqQJ1aEY+rN+7roTj/HyhQHg84/krQzj2LTfN45MIaJ4TJH62ddQO2BkA1FM3WE4I1AIa33hTs6/CDijpBPy4FGkvIHH5Nw22x16M/0XnKT7//J7fAdPKg99vChvwqe2Ems06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853186; c=relaxed/simple;
	bh=9t97CFKV4rACJktBVSdAAFmMi8vnZOYAszVcOFq/szA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtQ9Swb594G+qrd75QLJMlNlAjUiNqZQgQIySmKM7G5Pkyuz5qwLx+fm/xTSgI1xJI6V8tqYC1FCMG5ZfeIVMSSuzVgI6SodGIFCtAndttUW+LTYeEzBFePZ8Az0UwkFmGs6+NjEKI0EDksZQ3/kIQhmZiNQ11l6nvmsjz12AbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aBz1iSYm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aBz1iSYm"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af5499ca131so511613a12.3
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745853184; x=1746457984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6D5EgZHIMdc/gfZZ8/yCt5JK/51JYrU9cgDLfIs1bQ=;
        b=aBz1iSYm2nAinOTwvbJZNCVXpzqtyGplskWtSjvFAxRHZNVs+LySGYxcIH25zLghrI
         Vir+kD5r1MzZtTWFDI3aGFUt+nCcVFVhpAs8USme2PKZHPUy63WKUNVGY7KFQ2Dp2ZhV
         UA2y9HDR41Pv7EgjEn1WV8Pr9rQDhSUGkRKAWF3Fr49FMcpp61klDQkbOPW25RryBQw/
         0evuvuFdjG4h19lpiA+8VuJAK+2K+1GJLoVs8N9UiefYfnhRHaiULUhU90lNOubaCg/U
         aEQsOxQSJQNtLs/EChFPtdje9xnqHcUZ7XBvniT8RmWnRVpPBPt8qfmn0mSQqXcQIJ8h
         WmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745853184; x=1746457984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6D5EgZHIMdc/gfZZ8/yCt5JK/51JYrU9cgDLfIs1bQ=;
        b=WADJOnGWCE+Zpp/UQVwN8cuvHnQKamXb/vxVz58qBsQulm6/ESZ0O6ErnLzhgG0jNg
         Iu28uKeQAN7NETx4oS4VZsBTnr0sc6ErNHpzg1saUKkISSi847xFCb0q/splJ4ijkr2L
         B7x5U7D+6XnsahmCaJtArwWQkbEGT0x2qqbPDRP/SZb+QhUe3EVDhAnt2yqdEcxw8gJV
         TH9ce9xXSrbbhfTvyMmzNTicRK05T7fxEOEMxcp3HeBrnDzscVjDtRlaDdCMS+H4z1YE
         Siwtn+lfZOJu9LXLtWMy0KHFp3rikyKilkUCIaeSTKF8LyP9/pys3zT+mBJCU1NPiC9O
         hArg==
X-Forwarded-Encrypted: i=1; AJvYcCU3SMpi3JRsyHgaSzljle6r6alKO+AoVLGj/YEe0syuw3dUqEIctDxeSUlN44cA1NF87B+AzPmi9Zwfiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfXc3ADvtJX1wzLyuKR7YBvv9vhBIwBTmGVs2/sWrUpNB684J
	ZA0EzGTGITbxTT00GSevUnf5OAfbWnNkv0awf9lhBb3bowZCWgVCrcp9zFjRb5L6SUXziNG5EhX
	GplvEWXhAjcnBBwwn1ZrhJvwwBV6h/ZJY7H//SQ==
X-Gm-Gg: ASbGncsrMKr3j4ZYHSNcv7JHiwOKgIwY9zA8barbG3fkBfszQW7TLLIQi8Dii6QwDGb
	RdzAuNy8Hus/ZQhIJum09bwm7dKj2L0BXlH2bTCye6tuFfw25GspmVPPum1wnmi114jwtcJFc2Y
	rRasRqNpyXuA/cl7Y28jUIrQ==
X-Google-Smtp-Source: AGHT+IElsGgyK2Ufu+rFPEsxOiI15Po+x417riW1AfSQaCP4JKx/Jfxtjnmk66ODNW+a750tGEstk3DeBMFYUawtJ74=
X-Received: by 2002:a17:90b:1c90:b0:305:5f31:6c63 with SMTP id
 98e67ed59e1d1-309f7ec9d1fmr6407335a91.6.1745853184249; Mon, 28 Apr 2025
 08:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-6-csander@purestorage.com> <aA4rqcpC01SzUn_g@fedora> <CADUfDZpEGVLzEZJtPiScWgf6PVroQvKKhGed1cb8AJiyUr_RYg@mail.gmail.com>
In-Reply-To: <CADUfDZpEGVLzEZJtPiScWgf6PVroQvKKhGed1cb8AJiyUr_RYg@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Apr 2025 08:12:52 -0700
X-Gm-Features: ATxdqUHWv7K013iZ72EzRXMzcUVb0J6A1Zk3mvLKz4fmZFJAp6l9ML8z8-isNS4
Message-ID: <CADUfDZqqeeBTbgvCfHa8sr7Y7BetGbPzHYA1hMoN83kz+Bi54A@mail.gmail.com>
Subject: Re: [PATCH 5/8] ublk: factor out ublk_start_io() helper
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 7:28=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Sun, Apr 27, 2025 at 6:05=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wr=
ote:
> >
> > On Sat, Apr 26, 2025 at 10:58:00PM -0600, Caleb Sander Mateos wrote:
> > > In preparation for calling it from outside ublk_dispatch_req(), facto=
r
> > > out the code responsible for setting up an incoming ublk I/O request.
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 53 ++++++++++++++++++++++----------------=
--
> > >  1 file changed, 29 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 01fc92051754..90a38a82f8cc 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -1151,17 +1151,44 @@ static inline void __ublk_abort_rq(struct ubl=
k_queue *ubq,
> > >               blk_mq_requeue_request(rq, false);
> > >       else
> > >               blk_mq_end_request(rq, BLK_STS_IOERR);
> > >  }
> > >
> > > +static void ublk_start_io(struct ublk_queue *ubq, struct request *re=
q,
> > > +                       struct ublk_io *io)
> > > +{
> > > +     unsigned mapped_bytes =3D ublk_map_io(ubq, req, io);
> > > +
> > > +     /* partially mapped, update io descriptor */
> > > +     if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > > +             /*
> > > +              * Nothing mapped, retry until we succeed.
> > > +              *
> > > +              * We may never succeed in mapping any bytes here becau=
se
> > > +              * of OOM. TODO: reserve one buffer with single page pi=
nned
> > > +              * for providing forward progress guarantee.
> > > +              */
> > > +             if (unlikely(!mapped_bytes)) {
> > > +                     blk_mq_requeue_request(req, false);
> > > +                     blk_mq_delay_kick_requeue_list(req->q,
> > > +                                     UBLK_REQUEUE_DELAY_MS);
> > > +                     return;
> > > +             }
> > > +
> > > +             ublk_get_iod(ubq, req->tag)->nr_sectors =3D
> > > +                     mapped_bytes >> 9;
> > > +     }
> > > +
> > > +     ublk_init_req_ref(ubq, req);
> > > +}
> > > +
> > >  static void ublk_dispatch_req(struct ublk_queue *ubq,
> > >                             struct request *req,
> > >                             unsigned int issue_flags)
> > >  {
> > >       int tag =3D req->tag;
> > >       struct ublk_io *io =3D &ubq->ios[tag];
> > > -     unsigned int mapped_bytes;
> > >
> > >       pr_devel("%s: complete: qid %d tag %d io_flags %x addr %llx\n",
> > >                       __func__, ubq->q_id, req->tag, io->flags,
> > >                       ublk_get_iod(ubq, req->tag)->addr);
> > >
> > > @@ -1204,33 +1231,11 @@ static void ublk_dispatch_req(struct ublk_que=
ue *ubq,
> > >               pr_devel("%s: update iod->addr: qid %d tag %d io_flags =
%x addr %llx\n",
> > >                               __func__, ubq->q_id, req->tag, io->flag=
s,
> > >                               ublk_get_iod(ubq, req->tag)->addr);
> > >       }
> > >
> > > -     mapped_bytes =3D ublk_map_io(ubq, req, io);
> > > -
> > > -     /* partially mapped, update io descriptor */
> > > -     if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > > -             /*
> > > -              * Nothing mapped, retry until we succeed.
> > > -              *
> > > -              * We may never succeed in mapping any bytes here becau=
se
> > > -              * of OOM. TODO: reserve one buffer with single page pi=
nned
> > > -              * for providing forward progress guarantee.
> > > -              */
> > > -             if (unlikely(!mapped_bytes)) {
> > > -                     blk_mq_requeue_request(req, false);
> > > -                     blk_mq_delay_kick_requeue_list(req->q,
> > > -                                     UBLK_REQUEUE_DELAY_MS);
> > > -                     return;
> > > -             }
> >
> > Here it needs to break ublk_dispatch_req() for not completing the
> > uring_cmd, however ublk_start_io() can't support it.
>
> Good catch. How about I change ublk_start_io() to return a bool
> indicating whether the I/O was successfully started?

Thinking a bit more about this, is the existing behavior of returning
early from ublk_dispatch_req() correct for UBLK_IO_NEED_GET_DATA? It
makes sense for the initial ublk_dispatch_req() because the req will
be requeued without consuming the ublk fetch request, allowing it to
be reused for a subsequent I/O. But for UBLK_IO_NEED_GET_DATA, doesn't
it mean the io_uring_cmd will never complete? I would think it would
be better to return an error code in this case.

Best,
Caleb
