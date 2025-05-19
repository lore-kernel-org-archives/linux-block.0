Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38822857EA
	for <linux-block@vger.kernel.org>; Mon, 19 May 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668024; cv=none; b=LYiIl/1/Umxa1tHZDGwSGLrbyPGHfyHzUo/gFYS7Y5f+7DkgJ1MRB2wDMMvteJ3ASmT6hl1DRVuVMJ+E6DkKt235tFpI2fzNe/y8PRHFMOjG27Ew1DmjHmC2MPjNmYZiaGFQu4Acwk8WTyV5PZyGOlD4mIWerPEpZCfznO7h9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668024; c=relaxed/simple;
	bh=L5tV7/cE5pheIKnEyKyO4v9lUk3aSFOAH4gTMuSEAxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jh/hVdgeKr+dDE2iUKCOT8e0JjlW6Ztb9Nu3W6cgCFx/4CVyCObObEqVlpLMXogNecg653co+TUtBTT7yGW4/dOBlUdm9z7XfB8Zr1yYDK34c4/MVoskKX1y95qOwYuNpY4U9SENTphhCjHXGidNVu9036wzIFsGo+3FL+XVAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Zn8cIQUD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Zn8cIQUD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231ba912ba1so3905425ad.2
        for <linux-block@vger.kernel.org>; Mon, 19 May 2025 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747668021; x=1748272821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjbyD6NIaBUkGhkyrz6ToPyDBq7ZHpiL1ikTWfJsLy4=;
        b=Zn8cIQUDdE6Sc51IGJ66eRWX8LRrjOOwa+Zfw2kxfHQ0C6WBYraBSrDs2efaLjvRdX
         urFjkLv5S/ZWWWGBzulfUq/o9/kFA9QQLl6WqNnm1XtTPEzFfaAqQZWsX4rzgWspTXQO
         CjavM+bGK1Vt1CmCtwLwkmEr1R0SOhV/Yw2ShFjem3fQrjV7uacYuST8XtTVLsSv7G8i
         9DmHu+ZVtD5VmjNT1CF9l0JlpvHtF5WJS7ug4vgNmqGlVDp1l2YG0XCj1ZmgJE5LaIAH
         N4GmD1HvuT6Q4VvE3+/XRc1Gm8z3/Wwb6qdajIfrtkkScVofvgLwsiCx3kvRwoW9cm93
         AHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747668021; x=1748272821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjbyD6NIaBUkGhkyrz6ToPyDBq7ZHpiL1ikTWfJsLy4=;
        b=jPrtPdEyGE3rvjLdqHTLSsjyEoeDQWFjoYTUcelC/R0+obrFaJhOskmjKgMjoGrsHh
         pPcy9fBt43qGBBNoEV1OzmdaKdr/KW4BuBYYF2Kvh9IvIL2FInGTuUa9V/VJIRn8YRgL
         +5zt+UH5CfNnL9069ec3aXR/E2Ce5S1ub7+8uuHJ85cLK6qw6kw/OxdxquGqrfR1yGnL
         xDscmwn0R+xkf76fjs4r/xtXhBInPei2rsiVFhtPlw8oDF8ru7qY5DEuEVqn3/z6Ax3l
         6grs4lnk81RNRXlpAz2MKeplJsk9lPGWT1L9tYkrVqWcMwPiXG0wC5k70piKwcwyhn0t
         xaIA==
X-Forwarded-Encrypted: i=1; AJvYcCWCbB2WNpbMKk2L1Bw2BJfXrM7RFWX/9AXjlPQ87T6pSCAMIQLcaoACftnisC/Zdpgh8D4XEcejtnAEMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oeqAIx1e+KxNWRhK9ihqhye4Un0lQRiKSjzFg9M/zb+2u+ad
	VjV5l5/efwdUBUsRwPm1V/LnEyRxPRQ3WYwZasyxLr+lUHdSLSvr3Ly8pQZIkWIc80+82M6BZIC
	mvcXLpAHnuyt9v0eyOymnPaKeirFzkPReJXIoUjGcKg==
X-Gm-Gg: ASbGnctRoUsetXCuPwMM5AK8wC5ovUu19JirFv810ibn67upn/TDiTU9GO9qrFCfTZQ
	jEDPAKbzT6sfdG6oODBl8P39pk1PGASxlH4jHkIgcb+0FrAMlBiYh+IJnGmaNZrFsFwoYxTv6di
	S0RbZHuLcSDuyvTekXRQsRc4MCGl5bm9o=
X-Google-Smtp-Source: AGHT+IGSHZ7eGDNlRcwLbWFlRWIJWCKyxqSBNIhlJ8Y8a+HjTToGHDx8Oj+RMugqCDvh62yeUpQoYKV7v/9YwCFQG9I=
X-Received: by 2002:a17:902:eccd:b0:22e:50d1:b8d1 with SMTP id
 d9443c01a7336-231d437f0e7mr81127835ad.3.1747668020955; Mon, 19 May 2025
 08:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509150611.3395206-1-ming.lei@redhat.com> <20250509150611.3395206-5-ming.lei@redhat.com>
 <CADUfDZqbwsXCqiR0gxPEpcdt+QeBiybmk4HU_Yv=_VFr_ohKFg@mail.gmail.com>
 <aChs2ayEiGa43W_3@172-126-48-156.lightspeed.nsvltn.sbcglobal.net>
 <CADUfDZp41_C9ugm=fa-KOFV-uaM4kZkN_DftkOwkUp1KEVUnhg@mail.gmail.com> <aCq4Q65BrsnwmAZ8@172-126-48-156.lightspeed.nsvltn.sbcglobal.net>
In-Reply-To: <aCq4Q65BrsnwmAZ8@172-126-48-156.lightspeed.nsvltn.sbcglobal.net>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 19 May 2025 08:20:09 -0700
X-Gm-Features: AX0GCFuh6MQg1TqlrTcsAv547Oocd95Kmu6tf6Xxdy6B5jbzTh_5-5PN617Pjb0
Message-ID: <CADUfDZo8LES7Azo4cwVgFMjC4=gJUprqYSnWyLd4f=p8pBP=8A@mail.gmail.com>
Subject: Re: [PATCH V3 4/6] ublk: register buffer to local io_uring with
 provided buf index via UBLK_F_AUTO_BUF_REG
To: Ming Lei <tom.leiming@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 9:49=E2=80=AFPM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> On Sun, May 18, 2025 at 10:10:58AM -0700, Caleb Sander Mateos wrote:
> > On Sat, May 17, 2025 at 4:02=E2=80=AFAM Ming Lei <tom.leiming@gmail.com=
> wrote:
> > >
> > > On Tue, May 13, 2025 at 12:50:04PM -0700, Caleb Sander Mateos wrote:
> > > > On Fri, May 9, 2025 at 8:06=E2=80=AFAM Ming Lei <ming.lei@redhat.co=
m> wrote:
> > > > >
> > > > > Add UBLK_F_AUTO_BUF_REG for supporting to register buffer automat=
ically
> > > > > to local io_uring context with provided buffer index.
> > > > >
> > > > > Add UAPI structure `struct ublk_auto_buf_reg` for holding user pa=
rameter
> > > > > to register request buffer automatically, one 'flags' field is de=
fined, and
> > > > > there is still 32bit available for future extension, such as, add=
ing one
> > > > > io_ring FD field for registering buffer to external io_uring.
> > > > >
> > > > > `struct ublk_auto_buf_reg` is populated from ublk uring_cmd's sqe=
->addr,
> > > > > and all existing ublk commands are data-less, so it is just fine =
to reuse
> > > > > sqe->addr for this purpose.
> > > > >
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c      | 71 +++++++++++++++++++++++----
> > > > >  include/uapi/linux/ublk_cmd.h | 90 +++++++++++++++++++++++++++++=
++++++
> > > > >  2 files changed, 151 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index 1f98e561dc38..17c41a7fa870 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -66,7 +66,8 @@
> > > > >                 | UBLK_F_USER_COPY \
> > > > >                 | UBLK_F_ZONED \
> > > > >                 | UBLK_F_USER_RECOVERY_FAIL_IO \
> > > > > -               | UBLK_F_UPDATE_SIZE)
> > > > > +               | UBLK_F_UPDATE_SIZE \
> > > > > +               | UBLK_F_AUTO_BUF_REG)
> > > > >
> > > > >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > > > >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > > > > @@ -80,6 +81,9 @@
> > > > >
> > > > >  struct ublk_rq_data {
> > > > >         refcount_t ref;
> > > > > +
> > > > > +       /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_=
REG */
> > > > > +       unsigned short buf_index;
> > > >
> > > > Can you use a fixed-size integer, i.e. u16?
> > >
> > > OK.
> > >
> > > >
> > > > >  };
> > > > >
> > > > >  struct ublk_uring_cmd_pdu {
> > > > > @@ -101,6 +105,9 @@ struct ublk_uring_cmd_pdu {
> > > > >          * setup in ublk uring_cmd handler
> > > > >          */
> > > > >         struct ublk_queue *ubq;
> > > > > +
> > > > > +       struct ublk_auto_buf_reg buf;
> > > > > +
> > > > >         u16 tag;
> > > > >  };
> > > > >
> > > > > @@ -630,7 +637,7 @@ static inline bool ublk_support_zero_copy(con=
st struct ublk_queue *ubq)
> > > > >
> > > > >  static inline bool ublk_support_auto_buf_reg(const struct ublk_q=
ueue *ubq)
> > > > >  {
> > > > > -       return false;
> > > > > +       return ubq->flags & UBLK_F_AUTO_BUF_REG;
> > > > >  }
> > > > >
> > > > >  static inline bool ublk_support_user_copy(const struct ublk_queu=
e *ubq)
> > > > > @@ -1175,20 +1182,38 @@ static inline void __ublk_abort_rq(struct=
 ublk_queue *ubq,
> > > > >                 blk_mq_end_request(rq, BLK_STS_IOERR);
> > > > >  }
> > > > >
> > > > > +static void ublk_auto_buf_reg_fallback(struct request *req, stru=
ct ublk_io *io,
> > > > > +                                      unsigned int issue_flags)
> > > > > +{
> > > > > +       const struct ublk_queue *ubq =3D req->mq_hctx->driver_dat=
a;
> > > >
> > > > It would be nice to pass ubq into ublk_auto_buf_reg() and
> > > > ublk_auto_buf_reg_fallback() so it doesn't need to be looked up aga=
in.
> > >
> > > ublk_auto_buf_reg_fallback() is called in case of auto-buff-reg failu=
re,
> > > also the only caller doesn't use 'ubq', so I think it is fine to retr=
ieve
> > > `ubq` from `req->mq_hctx`.
> > >
> > > >
> > > > > +       struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->ta=
g);
> > > > > +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > > > +
> > > > > +       iod->op_flags |=3D UBLK_IO_F_NEED_REG_BUF;
> > > > > +       refcount_set(&data->ref, 1);
> > > > > +       ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags=
);
> > > >
> > > > Can this just return true from ublk_auto_buf_reg() in this case? Th=
en
> > > > ublk_dispatch_req() will call ublk_complete_io_cmd(), as normal.
> > >
> > > OK.
> > >
> > > >
> > > > > +}
> > > > > +
> > > > >  static bool ublk_auto_buf_reg(struct request *req, struct ublk_i=
o *io,
> > > > >                               unsigned int issue_flags)
> > > > >  {
> > > > > +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu=
(io->cmd);
> > > > >         struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > > >         int ret;
> > > > >
> > > > > -       ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io_rel=
ease, 0,
> > > > > -                                     issue_flags);
> > > > > +       ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io_rel=
ease,
> > > > > +                                     pdu->buf.index, issue_flags=
);
> > > >
> > > > Hmm, I find it a bit awkward to add this code in one commit with th=
e
> > > > wrong arguments and fix it up in a separate commit. I think it woul=
d
> > > > make more sense to combine the commits. If you feel the commit is t=
oo
> > > > large, I think it would make more sense to split out
> > > > UBLK_AUTO_BUF_REG_FALLBACK to a separate commit. But up to you.
> > >
> > > This way is used often for splitting big patches into small pieces:
> > >
> > > - patch 3 focuses on generic change
> > >
> > > - patch 4 focuses on uapi interface
> > >
> > > I'd suggest to keep this way for reviewing easily.
> > >
> > > >
> > > > >         if (ret) {
> > > > > -               blk_mq_end_request(req, BLK_STS_IOERR);
> > > > > +               if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK)
> > > > > +                       ublk_auto_buf_reg_fallback(req, io, issue=
_flags);
> > > > > +               else
> > > > > +                       blk_mq_end_request(req, BLK_STS_IOERR);
> > > > >                 return false;
> > > > >         }
> > > > >         /* one extra reference is dropped by ublk_io_release */
> > > > >         refcount_set(&data->ref, 2);
> > > > > +       /* store buffer index in request payload */
> > > > > +       data->buf_index =3D pdu->buf.index;
> > > > >         io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> > > > >         return true;
> > > > >  }
> > > > > @@ -1952,6 +1977,20 @@ static inline void ublk_prep_cancel(struct=
 io_uring_cmd *cmd,
> > > > >         io_uring_cmd_mark_cancelable(cmd, issue_flags);
> > > > >  }
> > > > >
> > > > > +static inline bool ublk_set_auto_buf_reg(struct io_uring_cmd *cm=
d)
> > > > > +{
> > > > > +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu=
(cmd);
> > > > > +
> > > > > +       pdu->buf =3D ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd-=
>sqe->addr));
> > > > > +
> > > > > +       if (pdu->buf.reserved0 || pdu->buf.reserved1)
> > > > > +               return false;
> > > > > +
> > > > > +       if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
> > > > > +               return false;
> > > > > +       return true;
> > > > > +}
> > > > > +
> > > > >  static void ublk_io_release(void *priv)
> > > > >  {
> > > > >         struct request *rq =3D priv;
> > > > > @@ -2041,9 +2080,13 @@ static int ublk_fetch(struct io_uring_cmd =
*cmd, struct ublk_queue *ubq,
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > -static void ublk_auto_buf_unreg(struct ublk_io *io, unsigned int=
 issue_flags)
> > > > > +static void ublk_auto_buf_unreg(struct ublk_io *io, struct reque=
st *req,
> > > > > +                               unsigned int issue_flags)
> > > > >  {
> > > > > -       WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, 0, issue_=
flags));
> > > > > +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > > > +
> > > > > +       WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, data->buf=
_index,
> > > > > +                               issue_flags));
> > > > >         io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
> > > > >  }
> > > > >
> > > > > @@ -2080,7 +2123,7 @@ static int ublk_commit_and_fetch(const stru=
ct ublk_queue *ubq,
> > > > >                 req->__sector =3D ub_cmd->zone_append_lba;
> > > > >
> > > > >         if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> > > > > -               ublk_auto_buf_unreg(io, issue_flags);
> > > > > +               ublk_auto_buf_unreg(io, req, issue_flags);
> > > > >
> > > > >         if (likely(!blk_should_fake_timeout(req->q)))
> > > > >                 ublk_put_req_ref(ubq, req);
> > > > > @@ -2196,6 +2239,10 @@ static int __ublk_ch_uring_cmd(struct io_u=
ring_cmd *cmd,
> > > > >         default:
> > > > >                 goto out;
> > > > >         }
> > > > > +
> > > > > +       if (ublk_support_auto_buf_reg(ubq) && !ublk_set_auto_buf_=
reg(cmd))
> > > > > +               return -EINVAL;
> > > >
> > > > Don't we want to check for this error condition first, before makin=
g
> > > > this ublk I/O available for incoming requests? Otherwise,
> > > > ublk_dispatch_req() may be called on this command with an invalid
> > > > pdu->buf.
> > >
> > > No, the provided uapi parameter is only used for fetching new IO requ=
est,
> > > so we have to use the saved parameter for registering buffer automati=
cally
> > > first, then store the new parameter for doing it when new io request =
comes.
> >
> > I see. Calling ublk_auto_buf_reg() with an invalid pdu->buf is a bit
> > surprising but I guess it can't cause any harm.
>
> It won't happen, ublk_set_auto_buf_reg() is called for UBLK_IO_FETCH_REQ
> too, so ublk_auto_buf_reg() always sees valid pdu->buf.

By "invalid", I don't mean uninitialized, I mean a struct
ublk_auto_buf_reg value that causes ublk_set_auto_buf_reg() to return
false. Even though the UBLK_IO_(COMMIT_AND_)FETCH_REQ returns -EINVAL,
the ublk I/O is still posted and the ublk_auto_buf_reg value stored in
pdu->buf. So incoming requests will pass that invalid
ublk_auto_buf_reg value to ublk_auto_buf_reg(). For UBLK_IO_FETCH_REQ,
I think it would make more sense to return early before
ublk_fill_io_cmd() and ublk_mark_io_ready() if ublk_set_auto_buf_reg()
returns false. For UBLK_IO_COMMIT_AND_FETCH_REQ, I guess there's no
way to prevent the ublk I/O being reused after completing the previous
request, but it could set a flag on the I/O to skip calling
io_buffer_register_bvec() with the invalid ublk_auto_buf_reg value. I
am okay with the current behavior, I just wanted to mention some
alternatives.

>
> >
> > >
> > > I will document this kind of usage.
> > >
> > > >
> > > > > +
> > > > >         ublk_prep_cancel(cmd, issue_flags, ubq, tag);
> > > > >         return -EIOCBQUEUED;
> > > > >
> > > > > @@ -2806,8 +2853,11 @@ static int ublk_ctrl_add_dev(const struct =
ublksrv_ctrl_cmd *header)
> > > > >                  * For USER_COPY, we depends on userspace to fill=
 request
> > > > >                  * buffer by pwrite() to ublk char device, which =
can't be
> > > > >                  * used for unprivileged device
> > > > > +                *
> > > > > +                * Same with zero copy or auto buffer register.
> > > > >                  */
> > > > > -               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPO=
RT_ZERO_COPY))
> > > > > +               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPO=
RT_ZERO_COPY |
> > > > > +                                       UBLK_F_AUTO_BUF_REG))
> > > > >                         return -EINVAL;
> > > > >         }
> > > > >
> > > > > @@ -2865,7 +2915,8 @@ static int ublk_ctrl_add_dev(const struct u=
blksrv_ctrl_cmd *header)
> > > > >                 UBLK_F_URING_CMD_COMP_IN_TASK;
> > > > >
> > > > >         /* GET_DATA isn't needed any more with USER_COPY or ZERO =
COPY */
> > > > > -       if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPO=
RT_ZERO_COPY))
> > > > > +       if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPO=
RT_ZERO_COPY |
> > > > > +                               UBLK_F_AUTO_BUF_REG))
> > > > >                 ub->dev_info.flags &=3D ~UBLK_F_NEED_GET_DATA;
> > > >
> > > > Does this logic also need to be updated to allow UBLK_F_AUTO_BUF_RE=
G
> > > > for zoned ublk devices?
> > >
> > > This patch switches to use sqe->addr for passing `ublk_auto_buf_reg`,=
 so
> > > ublk zoned isn't affected.
> >
> > Makes sense.
> >
> > >
> > > >
> > > > /*
> > > >  * Zoned storage support requires reuse `ublksrv_io_cmd->addr` for
> > > >  * returning write_append_lba, which is only allowed in case of
> > > >  * user copy or zero copy
> > > >  */
> > > > if (ublk_dev_is_zoned(ub) &&
> > > >     (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !(ub->dev_info.flags &
> > > >      (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)))) {
> > > >         ret =3D -EINVAL;
> > > >         goto out_free_dev_number;
> > > > }
> > > >
> > > > >
> > > > >         /*
> > > > > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/u=
blk_cmd.h
> > > > > index be5c6c6b16e0..ecd7ab8c00ca 100644
> > > > > --- a/include/uapi/linux/ublk_cmd.h
> > > > > +++ b/include/uapi/linux/ublk_cmd.h
> > > > > @@ -219,6 +219,29 @@
> > > > >   */
> > > > >  #define UBLK_F_UPDATE_SIZE              (1ULL << 10)
> > > > >
> > > > > +/*
> > > > > + * request buffer is registered automatically to uring_cmd's io_=
uring
> > > > > + * context before delivering this io command to ublk server, mea=
ntime
> > > > > + * it is un-registered automatically when completing this io com=
mand.
> > > > > + *
> > > > > + * For using this feature:
> > > > > + *
> > > > > + * - ublk server has to create sparse buffer table
> > > > > + *
> > > > > + * - ublk server passes auto buf register data via uring_cmd's s=
qe->addr,
> > > > > + *   `struct ublk_auto_buf_reg` is populated from sqe->addr, ple=
ase see
> > > > > + *   the definition of ublk_sqe_addr_to_auto_buf_reg()
> > > > > + *
> > > > > + * - pass buffer index from `ublk_auto_buf_reg.index`
> > > > > + *
> > > > > + * - pass flags from `ublk_auto_buf_reg.flags` if needed
> > > > > + *
> > > > > + * This way avoids extra cost from two uring_cmd, but also simpl=
ifies backend
> > > > > + * implementation, such as, the dependency on IO_REGISTER_IO_BUF=
 and
> > > > > + * IO_UNREGISTER_IO_BUF becomes not necessary.
> > > > > + */
> > > > > +#define UBLK_F_AUTO_BUF_REG    (1ULL << 11)
> > > > > +
> > > > >  /* device state */
> > > > >  #define UBLK_S_DEV_DEAD        0
> > > > >  #define UBLK_S_DEV_LIVE        1
> > > > > @@ -305,6 +328,17 @@ struct ublksrv_ctrl_dev_info {
> > > > >  #define                UBLK_IO_F_FUA                   (1U << 13=
)
> > > > >  #define                UBLK_IO_F_NOUNMAP               (1U << 15=
)
> > > > >  #define                UBLK_IO_F_SWAP                  (1U << 16=
)
> > > > > +/*
> > > > > + * For UBLK_F_AUTO_BUF_REG & UBLK_AUTO_BUF_REG_FALLBACK only.
> > > > > + *
> > > > > + * This flag is set if auto buffer register is failed & ublk ser=
ver passes
> > > > > + * UBLK_AUTO_BUF_REG_FALLBACK, and ublk server need to register =
buffer
> > > > > + * manually for handling the delivered IO command if this flag i=
s observed
> > > > > + *
> > > > > + * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLB=
ACK is
> > > > > + * passed in.
> > > > > + */
> > > > > +#define                UBLK_IO_F_NEED_REG_BUF          (1U << 17=
)
> > > > >
> > > > >  /*
> > > > >   * io cmd is described by this structure, and stored in share me=
mory, indexed
> > > > > @@ -339,6 +373,62 @@ static inline __u32 ublksrv_get_flags(const =
struct ublksrv_io_desc *iod)
> > > > >         return iod->op_flags >> 8;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * If this flag is set, fallback by completing the uring_cmd and=
 setting
> > > > > + * `UBLK_IO_F_NEED_REG_BUF` in case of auto-buf-register failure=
;
> > > > > + * otherwise the client ublk request is failed silently
> > > > > + *
> > > > > + * If ublk server passes this flag, it has to check if UBLK_IO_F=
_NEED_REG_BUF
> > > > > + * is set in `ublksrv_io_desc.op_flags`. If UBLK_IO_F_NEED_REG_B=
UF is set,
> > > > > + * ublk server needs to register io buffer manually for handling=
 IO command.
> > > > > + */
> > > > > +#define UBLK_AUTO_BUF_REG_FALLBACK     (1 << 0)
> > > > > +#define UBLK_AUTO_BUF_REG_F_MASK       UBLK_AUTO_BUF_REG_FALLBAC=
K
> > > > > +
> > > > > +struct ublk_auto_buf_reg {
> > > > > +       /* index for registering the delivered request buffer */
> > > > > +       __u16  index;
> > > > > +       __u8   flags;
> > > > > +       __u8   reserved0;
> > > > > +
> > > > > +       /*
> > > > > +        * io_ring FD can be passed via the reserve field in futu=
re for
> > > > > +        * supporting to register io buffer to external io_uring
> > > > > +        */
> > > > > +       __u32  reserved1;
> > > > > +};
> > > > > +
> > > > > +/*
> > > > > + * For UBLK_F_AUTO_BUF_REG, auto buffer register data is carried=
 via
> > > > > + * uring_cmd's sqe->addr:
> > > > > + *
> > > > > + *     - bit0 ~ bit15: buffer index
> > > > > + *     - bit16 ~ bit23: flags
> > > > > + *     - bit24 ~ bit31: reserved0
> > > > > + *     - bit32 ~ bit63: reserved1
> > > > > + */
> > > > > +static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf=
_reg(
> > > > > +               __u64 sqe_addr)
> > > > > +{
> > > > > +       struct ublk_auto_buf_reg reg =3D {
> > > > > +               .index =3D sqe_addr & 0xffff,
> > > > > +               .flags =3D (sqe_addr >> 16) & 0xff,
> > > > > +               .reserved0 =3D (sqe_addr >> 24) & 0xff,
> > > > > +               .reserved1 =3D sqe_addr >> 32,
> > > > > +       };
> > > > > +
> > > > > +       return reg;
> > > > > +}
> > > > > +
> > > > > +static inline __u64
> > > > > +ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *bu=
f)
> > > >
> > > > Pass by value since it's only 8 bytes?
> > >
> > > Yes, and we can add build check.
> > >
> > > >
> > > > > +{
> > > > > +       __u64 addr =3D buf->index | buf->flags << 16 | buf->reser=
ved0 << 24 |
> > > > > +               (__u64)buf->reserved1 << 32;
> > > > > +
> > > > > +       return addr;
> > > > > +}
> > > >
> > > > How about just memcpy()ing between u64 and struct ublk_auto_buf_reg=
?
> > > > If you do want to keep these explicit conversions, you could at lea=
st
> > > > omit the unnecessary masking in ublk_sqe_addr_to_auto_buf_reg().
> > >
> > > memcpy is one global function, which is slower.
> >
> > Modern compilers will optimize memcpy() with a small constant size to
> > a series of loads and stores, so there's not a performance penalty.
> > But being explicit is fine too.
>
> OK, but memcpy() can't be inlined, there is always extra function calling
> cost.

This is not true; the compiler knows the behavior of memcpy() and can
absolutely avoid the function call. For example:

u64 memcpy_test(struct ublk_auto_buf_reg buf)
{
        u64 result;
        memcpy(&result, &buf, sizeof(buf));
        return result;
}

Compiles into a simple move between registers:
(gdb) disas memcpy_test
Dump of assembler code for function memcpy_test:
   0x00000000000031a0 <+0>:     call   0x31a5 <memcpy_test+5>
   0x00000000000031a5 <+5>:     mov    %rdi,%rax
   0x00000000000031a8 <+8>:     ret

>
> Can you review V4 so that we can move on? Then the next thing is to suppo=
rt
> per-io task and io migration for balancing load among io tasks.

Yes, I will try to get to it in the next day or 2.

Best,
Caleb
