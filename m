Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E433F7
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747875928; cv=none; b=YDWWy8R5yhxz+YVsi96MTz/u0xeknX+wpGwxmaoPU+AtWKAtK2dEZVtqcicZUaNN1/v2dc7hP63MeAphn4UPq0teVrYkqH6AkmrLT0+TSYamnoNnRtuAGBdAlrUrCuSEhDFKEPOF6LwcRwMUWHRnszT8eLp4ht1mQNNzlUi8rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747875928; c=relaxed/simple;
	bh=2Ff3nAL9DoSMAL8H2ily7EecJVTKHprgvkyuL/gdWdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VghRmsCEDXxYYquwior2E01yectE0GGWuM6V8Yzr4+nouXxLE9M5TCS6igXI6Bl/RxN3/QuPglDFDmY8M4Wo7zRh/Mg4ttU2IxRbCTtNQkFozmxwRJIuAqDlncZYxEJS2KVPmB/EbX9cmaLhSigdPHZ0cts7bX2H/UFRGaVw0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A4w+BsJ+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A4w+BsJ+"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30e930e00a0so1084490a91.3
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 18:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747875926; x=1748480726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSxtKoBF2qqdFHqoPmlSCeV/xxMCB8HTlPU2ie0TvVg=;
        b=A4w+BsJ+xECqsCc/SPD+x6b/ihe3NnJWK+ZC5HpqWP3s87bRPbmj4v1huOHu+UGBfw
         /HuB5YwfqXTlSBLVhk6WRxU78ILQdhwkc9iAhGV8MlqyZkzwoND/4eeItkjrer1B6Fbx
         gHphr+WoUm/TdEB6k0yQFHTwQC7l9+Vgh2J2lFghB33QgGZcYboFfu0QrG1K8RST+RJM
         HVaYr+f5rFRdK3yGwyNkVjhvBqwMkzk812lMAzA7Bqtl8Bmdw5KnENavRr+Se/LEyyY4
         FAOLAW3LFlb/SWOGv24VyWmTaPBeSl4K7B/Ap2lqR/TQCXKjOkRONPuKpRpPXeVFYJPH
         sKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747875926; x=1748480726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSxtKoBF2qqdFHqoPmlSCeV/xxMCB8HTlPU2ie0TvVg=;
        b=mmY8te1h/HW++vLn9m5Tm/MqssiM9KRBB42RM93lG04pSaKy0yjJ94UioZITorzpMP
         W5UxhGzp0ZH67NLOyoelWcAh53RtrwddeJUYSp9mM2GqpAfsVzBf7cpI0TuUVn17vPrI
         mok7X/5Q8eX+fRaELG2j1git9kFHE9Q9jt9vIaqfLbGqESonxm5BEYrlEgJATONfcMYk
         Nx3ItvGrnd6CFB3wasZHJdayCJFuQMxqdFV0J5ELFBFJUmrWMZmD9kOd+IcHtpJYODSa
         gXvOlAd0R0lFPOJERcks9+NxbZ/bSR8P+XpyD+v9591vzhEIdqtxmtGhlJcSktXO0RhR
         Aw2w==
X-Forwarded-Encrypted: i=1; AJvYcCUXHqaFnyBB4urfK8tc417GgEsAeCzkxITxCoFc4obdT5G3Wum42zldRlgjJoYldTLzIC0vGkm6qNQGwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzP8U61h5On/pSzBS30hKBDqhRofMPqecvekGDHSd8x3V7YFnS
	DK5zv8+9Nwxt39nzix1+sANbrNz3sXc4E4eJLM0UfgMvnmC1Tw3QGKCB/Jis67sdunb1UQyz0i7
	GvI6Vx1dIUG2GuiGTwmx7MoKhzqNmxcAFMGUG1OqIQw==
X-Gm-Gg: ASbGncvQr366iXQLCC9C912PmJfzmgm6D4hHxlt2ThOFSWbj/I7VAfXL8Y1Rzl0R8lb
	2oJ2fvAUm7tYUXP0s3ayZKImqO7wNPkGX6CTi1VLqdtAZkaV+CQlkHsiya7LT6wH7tjyPNux+fd
	ST57ZS3uAyGn33O4kMLbL0TImQG6QnXzs=
X-Google-Smtp-Source: AGHT+IFt7+rJy+qO1n2Mkvy4/A/BimS8SyiPx280p1sOdqw19xd/RaVkgdf9eTls9oQ1ze6NjNqE8idqFrxTuxIJXCI=
X-Received: by 2002:a17:902:f791:b0:216:3dd1:5460 with SMTP id
 d9443c01a7336-231d437f031mr112974455ad.2.1747875925723; Wed, 21 May 2025
 18:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521025502.71041-1-ming.lei@redhat.com> <20250521025502.71041-3-ming.lei@redhat.com>
 <CADUfDZrh+FYHgPjmF1=RRQiZFx=uYZEBJ+mJGsX-C9jM5dVi9g@mail.gmail.com> <aC5y_FVe4KQoIsJo@fedora>
In-Reply-To: <aC5y_FVe4KQoIsJo@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 21 May 2025 18:05:14 -0700
X-Gm-Features: AX0GCFswBZeT-jlYnpyBS4Xj0PF-QTuTUEVYlSHNWJz3gR5zpcST3SOYltjnFAY
Message-ID: <CADUfDZoY7rC=SxpFnN6bqBg1SiBccSyYTsKAVe2Rx0wAxBdD6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ublk: run auto buf unregisgering in same io_ring_ctx
 with register
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:42=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, May 21, 2025 at 08:58:20AM -0700, Caleb Sander Mateos wrote:
> > On Tue, May 20, 2025 at 7:55=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > UBLK_F_AUTO_BUF_REG requires that the buffer registered automatically
> > > is unregistered in same `io_ring_ctx`, so check it explicitly.
> > >
> > > Meantime return the failure code if io_buffer_unregister_bvec() fails=
,
> > > then ublk server can handle the failure in consistent way.
> > >
> > > Also force to clear UBLK_IO_FLAG_AUTO_BUF_REG in ublk_io_release()
> > > because ublk_io_release() may be triggered not from handling
> > > UBLK_IO_COMMIT_AND_FETCH_REQ, and from releasing the `io_ring_ctx`
> > > for registering the buffer.
> > >
> > > Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with pr=
ovided buf index via UBLK_F_AUTO_BUF_REG")
> > > Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 35 +++++++++++++++++++++++++++++++--=
--
> > >  include/uapi/linux/ublk_cmd.h |  3 ++-
> > >  2 files changed, 33 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index fcf568b89370..2af6422d6a89 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -84,6 +84,7 @@ struct ublk_rq_data {
> > >
> > >         /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG =
*/
> > >         u16 buf_index;
> > > +       unsigned long buf_ctx_id;
> > >  };
> > >
> > >  struct ublk_uring_cmd_pdu {
> > > @@ -1192,6 +1193,11 @@ static void ublk_auto_buf_reg_fallback(struct =
request *req, struct ublk_io *io)
> > >         refcount_set(&data->ref, 1);
> > >  }
> > >
> > > +static unsigned long ublk_uring_cmd_ctx_id(struct io_uring_cmd *cmd)
> > > +{
> > > +       return (unsigned long)(cmd_to_io_kiocb(cmd)->ctx);
> >
> > Is the fact that a struct io_uring_cmd * can be passed to
> > cmd_to_io_kiocb() an io_uring internal implementation detail? Maybe it
> > would be good to add a helper in include/linux/io_uring/cmd.h so ublk
> > isn't depending on io_uring internals.
>
> All this definition is defined in kernel public header, not sure if it is
> big deal to add the helper, especially there is just single user.
>
> But I will do it.
>
> >
> > Also, storing buf_ctx_id as a void * instead would allow this cast to
> > be avoided, but not a big deal.
> >
> > > +}
> > > +
> > >  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *i=
o,
> > >                               unsigned int issue_flags)
> > >  {
> > > @@ -1211,6 +1217,8 @@ static bool ublk_auto_buf_reg(struct request *r=
eq, struct ublk_io *io,
> > >         }
> > >         /* one extra reference is dropped by ublk_io_release */
> > >         refcount_set(&data->ref, 2);
> > > +
> > > +       data->buf_ctx_id =3D ublk_uring_cmd_ctx_id(io->cmd);
> > >         /* store buffer index in request payload */
> > >         data->buf_index =3D pdu->buf.index;
> > >         io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> > > @@ -1994,6 +2002,21 @@ static void ublk_io_release(void *priv)
> > >  {
> > >         struct request *rq =3D priv;
> > >         struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> > > +       struct ublk_io *io =3D &ubq->ios[rq->tag];
> > > +
> > > +       /*
> > > +        * In case of UBLK_F_AUTO_BUF_REG, the `io_uring_ctx` for reg=
istering
> > > +        * this buffer may be released, so we reach here not from han=
dling
> > > +        * `UBLK_IO_COMMIT_AND_FETCH_REQ`.
> >
> > What do you mean by this? That the io_uring was closed while a ublk
> > I/O owned by the server still had a registered buffer?
>
> The buffer is registered to `io_ring_ctx A`, which is closed and the buff=
er
> is used up and un-registered on `io_ring_ctx A`, so this callback is
> triggered, but the io command isn't completed yet, which can be run from
> `io_ring_ctx B`
>
> >
> > > +        *
> > > +        * Force to clear UBLK_IO_FLAG_AUTO_BUF_REG, so that ublk ser=
ver
> > > +        * still may complete this IO request by issuing uring_cmd fr=
om
> > > +        * another `io_uring_ctx` in case that the `io_ring_ctx` for
> > > +        * registering the buffer is gone
> > > +        */
> > > +       if (ublk_support_auto_buf_reg(ubq) &&
> > > +                       (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG))
> > > +               io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
> >
> > This is racy, since ublk_io_release() can be called on a thread other
> > than the ubq_daemon.
>
> Yeah, it can be true.
>
> > Could we avoid touching io->flags here and
> > instead have ublk_commit_and_fetch() check whether the reference count
> > is already 1?
>
> It is still a little racy because the buffer unregister from another thre=
ad
> can happen just after the check immediately.

True. I think it might be better to just skip the unregister if the
contexts don't match rather than returning -EINVAL. Then there is no
race. If userspace has already closed the old io_uring context,
skipping the unregister is the desired behavior. If userspace hasn't
closed the old io_uring, then that's a userspace bug and they get what
they deserve (a buffer stuck registered). If userspace wants to submit
the UBLK_IO_COMMIT_AND_FETCH_REQ on a different io_uring for some
reason, they can always issue an explicit UBLK_IO_UNREGISTER_IO_BUF on
the old io_uring to unregister the buffer.

>
> Adding one spinlock should cover it.

I would really prefer not to add a spinlock in the I/O path.

>
> And it shouldn't be one big thing, because anyway the buffer can only be
> released once.
>
> >
> > Also, the ublk_support_auto_buf_reg(ubq) check seems redundant, since
> > UBLK_IO_FLAG_AUTO_BUF_REG is set in ublk_auto_buf_reg(), which is only
> > called if ublk_support_auto_buf_reg(ubq).
>
> It has document benefit at least, so I'd suggest to keep it.

Doesn't checking for UBLK_IO_FLAG_AUTO_BUF_REG already document that
this only applies to auto buffer registration?

Best,
Caleb
