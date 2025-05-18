Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF92AE7C
	for <linux-block@vger.kernel.org>; Sun, 18 May 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747588273; cv=none; b=CHowZRctNsdvC+i4kfGXyjdE+cRSNEnbeqUSDZ9j5oTJ3qP6sdYoODS8xnPqBZmSyRtfvWnpHzC1MTU7iRTpJkuS0OW5M/uoSMzor/iyDk/KrrLkojec0rUzq0SHEZay3gM3Fy96wm8aVVJfXcqlykj7gjBEbZxo0p5vo9IL4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747588273; c=relaxed/simple;
	bh=3kgkBKl+cPjPmmDqvBIwzioRE5IfL51r0LC51juY6lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+Tru2ouzEMfZq8iuxe//l4x32OidlcBY0LI2O4oCnLzC3cJj4hVs2n2zzyNACTOiDsf5Lh4JSKdD8lOEryL/i9qwvz0Is1miIvudsRHVTvRkogIU2/t7gJ1vFb2MTWCTOT4jSw15SZaCwSYQRqptwrbg3bQzargD/TKVcMBvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=N6UDEzcC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="N6UDEzcC"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30c5a5839e3so992469a91.1
        for <linux-block@vger.kernel.org>; Sun, 18 May 2025 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747588270; x=1748193070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94AKp4nB2MTAWu1GkIovnhiRXPhG8Q77ibo9rxUna8k=;
        b=N6UDEzcC5xP54EB2WS0wlGAq/HblDdj7+o7HCSHEywXR8jhjlSB4WDYLXeL5IgPEOa
         PUD7xyhlXGCxQbv0TKlNDLR/YufgKVJ1Acj4mPkErXZ284SUHTgCA3DbatDZF/VTir1l
         MhTl5Qdft4OQctn0u9q4PWfcEj4BmOqPbF0+EkE0m4Onfx1WJYUvnSC3Bl0oLfSWZaj5
         zaOD9MM4c/ANct5GNPiSRNUxnQ8/NkN/6q8KDrWbaT9QMOs0Y4uB/Obd+cdyhkf1KSTx
         4T0/7wBqxVOdNW62n5EO1JrqqJit2icDz9rzeRKPeqKOkVC3njNEHYoutt4Q7nWD6+Ya
         69Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747588270; x=1748193070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94AKp4nB2MTAWu1GkIovnhiRXPhG8Q77ibo9rxUna8k=;
        b=RaqVjIv4pMQwIaP8as0AuFVTX34dZGz3rlG/DCw6zGOAMAUk8zoUi/lPU26NDn0AOg
         24rcyFzrIV0QC336nTgRlI7oVhF74bjHJuigCJi5ncyS1KwXkRaKaTg7tI06CssS3yh2
         t+0tLaH7lGiunOUluA15i36QcUhlr+F47i+AFl0+OCE/pki3oTS0SRbJrFhk0Lm3ZdxU
         ruvV+PsEqoSIxksaozNJBFe36pVFdhnoo3hlSHTfhFg3iv3lQofweOUnCeIWp8pqTQHY
         eWN0JU58Vhv9Bfk6F6n8KxwCSylQeSyPInbEsxJEtnYYkUZ+O4Vvoo0wrf8ypQjf0qOa
         tDiw==
X-Forwarded-Encrypted: i=1; AJvYcCW1yewGcbQVY/PCbG/PfIzpBLJqb4pUlSpuDjPyHE/cv8NmgR73zzUA9wD1Kr+Y8roPqW+UiVIhvFjVoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8LUBeczhBlzVBU+LlAQCzEncb4SaCTI9VhlezCWo8nGTXTzE
	RQa4EfUJbtglKN4bGWyW7wYqtVkhKfIbWfLHsM9fKkuZRAzHsSsRbqReUomTEkE3XbcX/z0JoJ4
	WOKDWFBESjjFPuKk/ZRsHIl5V6TnBBIssxLox6UMA1g==
X-Gm-Gg: ASbGncuLuZAZmewnZVZwqc2v+XRJd3SN1SXQ5/iQ9KTlBcx9gQQoDOLMv6EPUbiFcIO
	K1HgTHbfzIVx+N8AuIG9Gw4MG0qUm56Vs5eBTzBIkvQCrkZNYvxVzjuLQ97YfoZi6kObZpfwodS
	YM6EG2vQ+HuVyRaQLYOyqq2htpPTOmu7br+Nh99U1ssw==
X-Google-Smtp-Source: AGHT+IFSHLANYVzwaUA5rogxIJE9vbw9yuK/PQfmEoRvyTTPlRrw6ORjc8cc5hTTdNaMZagkzLfVaOvC8MlDH67RcJg=
X-Received: by 2002:a17:902:c951:b0:21f:356:758f with SMTP id
 d9443c01a7336-231d438823amr56453865ad.3.1747588269956; Sun, 18 May 2025
 10:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509150611.3395206-1-ming.lei@redhat.com> <20250509150611.3395206-5-ming.lei@redhat.com>
 <CADUfDZqbwsXCqiR0gxPEpcdt+QeBiybmk4HU_Yv=_VFr_ohKFg@mail.gmail.com> <aChs2ayEiGa43W_3@172-126-48-156.lightspeed.nsvltn.sbcglobal.net>
In-Reply-To: <aChs2ayEiGa43W_3@172-126-48-156.lightspeed.nsvltn.sbcglobal.net>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 18 May 2025 10:10:58 -0700
X-Gm-Features: AX0GCFugo-GSqzxBzF9NeUkDTXYESsuq0J5eXlhZwdvpvptGwWApmuWT2hq4ygk
Message-ID: <CADUfDZp41_C9ugm=fa-KOFV-uaM4kZkN_DftkOwkUp1KEVUnhg@mail.gmail.com>
Subject: Re: [PATCH V3 4/6] ublk: register buffer to local io_uring with
 provided buf index via UBLK_F_AUTO_BUF_REG
To: Ming Lei <tom.leiming@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025 at 4:02=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> On Tue, May 13, 2025 at 12:50:04PM -0700, Caleb Sander Mateos wrote:
> > On Fri, May 9, 2025 at 8:06=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > Add UBLK_F_AUTO_BUF_REG for supporting to register buffer automatical=
ly
> > > to local io_uring context with provided buffer index.
> > >
> > > Add UAPI structure `struct ublk_auto_buf_reg` for holding user parame=
ter
> > > to register request buffer automatically, one 'flags' field is define=
d, and
> > > there is still 32bit available for future extension, such as, adding =
one
> > > io_ring FD field for registering buffer to external io_uring.
> > >
> > > `struct ublk_auto_buf_reg` is populated from ublk uring_cmd's sqe->ad=
dr,
> > > and all existing ublk commands are data-less, so it is just fine to r=
euse
> > > sqe->addr for this purpose.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 71 +++++++++++++++++++++++----
> > >  include/uapi/linux/ublk_cmd.h | 90 +++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 151 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 1f98e561dc38..17c41a7fa870 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -66,7 +66,8 @@
> > >                 | UBLK_F_USER_COPY \
> > >                 | UBLK_F_ZONED \
> > >                 | UBLK_F_USER_RECOVERY_FAIL_IO \
> > > -               | UBLK_F_UPDATE_SIZE)
> > > +               | UBLK_F_UPDATE_SIZE \
> > > +               | UBLK_F_AUTO_BUF_REG)
> > >
> > >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > > @@ -80,6 +81,9 @@
> > >
> > >  struct ublk_rq_data {
> > >         refcount_t ref;
> > > +
> > > +       /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG =
*/
> > > +       unsigned short buf_index;
> >
> > Can you use a fixed-size integer, i.e. u16?
>
> OK.
>
> >
> > >  };
> > >
> > >  struct ublk_uring_cmd_pdu {
> > > @@ -101,6 +105,9 @@ struct ublk_uring_cmd_pdu {
> > >          * setup in ublk uring_cmd handler
> > >          */
> > >         struct ublk_queue *ubq;
> > > +
> > > +       struct ublk_auto_buf_reg buf;
> > > +
> > >         u16 tag;
> > >  };
> > >
> > > @@ -630,7 +637,7 @@ static inline bool ublk_support_zero_copy(const s=
truct ublk_queue *ubq)
> > >
> > >  static inline bool ublk_support_auto_buf_reg(const struct ublk_queue=
 *ubq)
> > >  {
> > > -       return false;
> > > +       return ubq->flags & UBLK_F_AUTO_BUF_REG;
> > >  }
> > >
> > >  static inline bool ublk_support_user_copy(const struct ublk_queue *u=
bq)
> > > @@ -1175,20 +1182,38 @@ static inline void __ublk_abort_rq(struct ubl=
k_queue *ubq,
> > >                 blk_mq_end_request(rq, BLK_STS_IOERR);
> > >  }
> > >
> > > +static void ublk_auto_buf_reg_fallback(struct request *req, struct u=
blk_io *io,
> > > +                                      unsigned int issue_flags)
> > > +{
> > > +       const struct ublk_queue *ubq =3D req->mq_hctx->driver_data;
> >
> > It would be nice to pass ubq into ublk_auto_buf_reg() and
> > ublk_auto_buf_reg_fallback() so it doesn't need to be looked up again.
>
> ublk_auto_buf_reg_fallback() is called in case of auto-buff-reg failure,
> also the only caller doesn't use 'ubq', so I think it is fine to retrieve
> `ubq` from `req->mq_hctx`.
>
> >
> > > +       struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
> > > +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > +
> > > +       iod->op_flags |=3D UBLK_IO_F_NEED_REG_BUF;
> > > +       refcount_set(&data->ref, 1);
> > > +       ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
> >
> > Can this just return true from ublk_auto_buf_reg() in this case? Then
> > ublk_dispatch_req() will call ublk_complete_io_cmd(), as normal.
>
> OK.
>
> >
> > > +}
> > > +
> > >  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *i=
o,
> > >                               unsigned int issue_flags)
> > >  {
> > > +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(io-=
>cmd);
> > >         struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > >         int ret;
> > >
> > > -       ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io_release=
, 0,
> > > -                                     issue_flags);
> > > +       ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io_release=
,
> > > +                                     pdu->buf.index, issue_flags);
> >
> > Hmm, I find it a bit awkward to add this code in one commit with the
> > wrong arguments and fix it up in a separate commit. I think it would
> > make more sense to combine the commits. If you feel the commit is too
> > large, I think it would make more sense to split out
> > UBLK_AUTO_BUF_REG_FALLBACK to a separate commit. But up to you.
>
> This way is used often for splitting big patches into small pieces:
>
> - patch 3 focuses on generic change
>
> - patch 4 focuses on uapi interface
>
> I'd suggest to keep this way for reviewing easily.
>
> >
> > >         if (ret) {
> > > -               blk_mq_end_request(req, BLK_STS_IOERR);
> > > +               if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK)
> > > +                       ublk_auto_buf_reg_fallback(req, io, issue_fla=
gs);
> > > +               else
> > > +                       blk_mq_end_request(req, BLK_STS_IOERR);
> > >                 return false;
> > >         }
> > >         /* one extra reference is dropped by ublk_io_release */
> > >         refcount_set(&data->ref, 2);
> > > +       /* store buffer index in request payload */
> > > +       data->buf_index =3D pdu->buf.index;
> > >         io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> > >         return true;
> > >  }
> > > @@ -1952,6 +1977,20 @@ static inline void ublk_prep_cancel(struct io_=
uring_cmd *cmd,
> > >         io_uring_cmd_mark_cancelable(cmd, issue_flags);
> > >  }
> > >
> > > +static inline bool ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
> > > +{
> > > +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd=
);
> > > +
> > > +       pdu->buf =3D ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe=
->addr));
> > > +
> > > +       if (pdu->buf.reserved0 || pdu->buf.reserved1)
> > > +               return false;
> > > +
> > > +       if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
> > > +               return false;
> > > +       return true;
> > > +}
> > > +
> > >  static void ublk_io_release(void *priv)
> > >  {
> > >         struct request *rq =3D priv;
> > > @@ -2041,9 +2080,13 @@ static int ublk_fetch(struct io_uring_cmd *cmd=
, struct ublk_queue *ubq,
> > >         return ret;
> > >  }
> > >
> > > -static void ublk_auto_buf_unreg(struct ublk_io *io, unsigned int iss=
ue_flags)
> > > +static void ublk_auto_buf_unreg(struct ublk_io *io, struct request *=
req,
> > > +                               unsigned int issue_flags)
> > >  {
> > > -       WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, 0, issue_flag=
s));
> > > +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > +
> > > +       WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, data->buf_ind=
ex,
> > > +                               issue_flags));
> > >         io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
> > >  }
> > >
> > > @@ -2080,7 +2123,7 @@ static int ublk_commit_and_fetch(const struct u=
blk_queue *ubq,
> > >                 req->__sector =3D ub_cmd->zone_append_lba;
> > >
> > >         if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> > > -               ublk_auto_buf_unreg(io, issue_flags);
> > > +               ublk_auto_buf_unreg(io, req, issue_flags);
> > >
> > >         if (likely(!blk_should_fake_timeout(req->q)))
> > >                 ublk_put_req_ref(ubq, req);
> > > @@ -2196,6 +2239,10 @@ static int __ublk_ch_uring_cmd(struct io_uring=
_cmd *cmd,
> > >         default:
> > >                 goto out;
> > >         }
> > > +
> > > +       if (ublk_support_auto_buf_reg(ubq) && !ublk_set_auto_buf_reg(=
cmd))
> > > +               return -EINVAL;
> >
> > Don't we want to check for this error condition first, before making
> > this ublk I/O available for incoming requests? Otherwise,
> > ublk_dispatch_req() may be called on this command with an invalid
> > pdu->buf.
>
> No, the provided uapi parameter is only used for fetching new IO request,
> so we have to use the saved parameter for registering buffer automaticall=
y
> first, then store the new parameter for doing it when new io request come=
s.

I see. Calling ublk_auto_buf_reg() with an invalid pdu->buf is a bit
surprising but I guess it can't cause any harm.

>
> I will document this kind of usage.
>
> >
> > > +
> > >         ublk_prep_cancel(cmd, issue_flags, ubq, tag);
> > >         return -EIOCBQUEUED;
> > >
> > > @@ -2806,8 +2853,11 @@ static int ublk_ctrl_add_dev(const struct ublk=
srv_ctrl_cmd *header)
> > >                  * For USER_COPY, we depends on userspace to fill req=
uest
> > >                  * buffer by pwrite() to ublk char device, which can'=
t be
> > >                  * used for unprivileged device
> > > +                *
> > > +                * Same with zero copy or auto buffer register.
> > >                  */
> > > -               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_Z=
ERO_COPY))
> > > +               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_Z=
ERO_COPY |
> > > +                                       UBLK_F_AUTO_BUF_REG))
> > >                         return -EINVAL;
> > >         }
> > >
> > > @@ -2865,7 +2915,8 @@ static int ublk_ctrl_add_dev(const struct ublks=
rv_ctrl_cmd *header)
> > >                 UBLK_F_URING_CMD_COMP_IN_TASK;
> > >
> > >         /* GET_DATA isn't needed any more with USER_COPY or ZERO COPY=
 */
> > > -       if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_Z=
ERO_COPY))
> > > +       if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_Z=
ERO_COPY |
> > > +                               UBLK_F_AUTO_BUF_REG))
> > >                 ub->dev_info.flags &=3D ~UBLK_F_NEED_GET_DATA;
> >
> > Does this logic also need to be updated to allow UBLK_F_AUTO_BUF_REG
> > for zoned ublk devices?
>
> This patch switches to use sqe->addr for passing `ublk_auto_buf_reg`, so
> ublk zoned isn't affected.

Makes sense.

>
> >
> > /*
> >  * Zoned storage support requires reuse `ublksrv_io_cmd->addr` for
> >  * returning write_append_lba, which is only allowed in case of
> >  * user copy or zero copy
> >  */
> > if (ublk_dev_is_zoned(ub) &&
> >     (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !(ub->dev_info.flags &
> >      (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)))) {
> >         ret =3D -EINVAL;
> >         goto out_free_dev_number;
> > }
> >
> > >
> > >         /*
> > > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_=
cmd.h
> > > index be5c6c6b16e0..ecd7ab8c00ca 100644
> > > --- a/include/uapi/linux/ublk_cmd.h
> > > +++ b/include/uapi/linux/ublk_cmd.h
> > > @@ -219,6 +219,29 @@
> > >   */
> > >  #define UBLK_F_UPDATE_SIZE              (1ULL << 10)
> > >
> > > +/*
> > > + * request buffer is registered automatically to uring_cmd's io_urin=
g
> > > + * context before delivering this io command to ublk server, meantim=
e
> > > + * it is un-registered automatically when completing this io command=
.
> > > + *
> > > + * For using this feature:
> > > + *
> > > + * - ublk server has to create sparse buffer table
> > > + *
> > > + * - ublk server passes auto buf register data via uring_cmd's sqe->=
addr,
> > > + *   `struct ublk_auto_buf_reg` is populated from sqe->addr, please =
see
> > > + *   the definition of ublk_sqe_addr_to_auto_buf_reg()
> > > + *
> > > + * - pass buffer index from `ublk_auto_buf_reg.index`
> > > + *
> > > + * - pass flags from `ublk_auto_buf_reg.flags` if needed
> > > + *
> > > + * This way avoids extra cost from two uring_cmd, but also simplifie=
s backend
> > > + * implementation, such as, the dependency on IO_REGISTER_IO_BUF and
> > > + * IO_UNREGISTER_IO_BUF becomes not necessary.
> > > + */
> > > +#define UBLK_F_AUTO_BUF_REG    (1ULL << 11)
> > > +
> > >  /* device state */
> > >  #define UBLK_S_DEV_DEAD        0
> > >  #define UBLK_S_DEV_LIVE        1
> > > @@ -305,6 +328,17 @@ struct ublksrv_ctrl_dev_info {
> > >  #define                UBLK_IO_F_FUA                   (1U << 13)
> > >  #define                UBLK_IO_F_NOUNMAP               (1U << 15)
> > >  #define                UBLK_IO_F_SWAP                  (1U << 16)
> > > +/*
> > > + * For UBLK_F_AUTO_BUF_REG & UBLK_AUTO_BUF_REG_FALLBACK only.
> > > + *
> > > + * This flag is set if auto buffer register is failed & ublk server =
passes
> > > + * UBLK_AUTO_BUF_REG_FALLBACK, and ublk server need to register buff=
er
> > > + * manually for handling the delivered IO command if this flag is ob=
served
> > > + *
> > > + * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK =
is
> > > + * passed in.
> > > + */
> > > +#define                UBLK_IO_F_NEED_REG_BUF          (1U << 17)
> > >
> > >  /*
> > >   * io cmd is described by this structure, and stored in share memory=
, indexed
> > > @@ -339,6 +373,62 @@ static inline __u32 ublksrv_get_flags(const stru=
ct ublksrv_io_desc *iod)
> > >         return iod->op_flags >> 8;
> > >  }
> > >
> > > +/*
> > > + * If this flag is set, fallback by completing the uring_cmd and set=
ting
> > > + * `UBLK_IO_F_NEED_REG_BUF` in case of auto-buf-register failure;
> > > + * otherwise the client ublk request is failed silently
> > > + *
> > > + * If ublk server passes this flag, it has to check if UBLK_IO_F_NEE=
D_REG_BUF
> > > + * is set in `ublksrv_io_desc.op_flags`. If UBLK_IO_F_NEED_REG_BUF i=
s set,
> > > + * ublk server needs to register io buffer manually for handling IO =
command.
> > > + */
> > > +#define UBLK_AUTO_BUF_REG_FALLBACK     (1 << 0)
> > > +#define UBLK_AUTO_BUF_REG_F_MASK       UBLK_AUTO_BUF_REG_FALLBACK
> > > +
> > > +struct ublk_auto_buf_reg {
> > > +       /* index for registering the delivered request buffer */
> > > +       __u16  index;
> > > +       __u8   flags;
> > > +       __u8   reserved0;
> > > +
> > > +       /*
> > > +        * io_ring FD can be passed via the reserve field in future f=
or
> > > +        * supporting to register io buffer to external io_uring
> > > +        */
> > > +       __u32  reserved1;
> > > +};
> > > +
> > > +/*
> > > + * For UBLK_F_AUTO_BUF_REG, auto buffer register data is carried via
> > > + * uring_cmd's sqe->addr:
> > > + *
> > > + *     - bit0 ~ bit15: buffer index
> > > + *     - bit16 ~ bit23: flags
> > > + *     - bit24 ~ bit31: reserved0
> > > + *     - bit32 ~ bit63: reserved1
> > > + */
> > > +static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg=
(
> > > +               __u64 sqe_addr)
> > > +{
> > > +       struct ublk_auto_buf_reg reg =3D {
> > > +               .index =3D sqe_addr & 0xffff,
> > > +               .flags =3D (sqe_addr >> 16) & 0xff,
> > > +               .reserved0 =3D (sqe_addr >> 24) & 0xff,
> > > +               .reserved1 =3D sqe_addr >> 32,
> > > +       };
> > > +
> > > +       return reg;
> > > +}
> > > +
> > > +static inline __u64
> > > +ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)
> >
> > Pass by value since it's only 8 bytes?
>
> Yes, and we can add build check.
>
> >
> > > +{
> > > +       __u64 addr =3D buf->index | buf->flags << 16 | buf->reserved0=
 << 24 |
> > > +               (__u64)buf->reserved1 << 32;
> > > +
> > > +       return addr;
> > > +}
> >
> > How about just memcpy()ing between u64 and struct ublk_auto_buf_reg?
> > If you do want to keep these explicit conversions, you could at least
> > omit the unnecessary masking in ublk_sqe_addr_to_auto_buf_reg().
>
> memcpy is one global function, which is slower.

Modern compilers will optimize memcpy() with a small constant size to
a series of loads and stores, so there's not a performance penalty.
But being explicit is fine too.

Best,
Caleb

>
> > > +static inline __u64
> > > +ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)
> > > +{
> > > +       __u64 addr =3D buf->index | buf->flags << 16 | buf->reserved0=
 << 24 |
> >
> > buf->reserved0 should be cast to a u64 (or u32) here. Otherwise,
> > buf->reserved0 << 24 gets promoted to an int and sign-extended to 64
> > bits. It would probably be good to cast the other fields too to avoid
> > assuming a 32-bit int.
>
> OK.
>
> Thanks,
> Ming
