Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43A1C6FF6
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656217; cv=none; b=FWUiqxE/MiAB9ZzeZjg0zaMl0dYPbmDvc+ZDPGR1IbpGx5CVvc4C7tvjhsagMrf2iZr7mPKNe/ltzTNahOJw+ZZa6psb3szOWGuPXjGspXnX+o8A0oNFCxfec4paqvataN1zFtKR0XNaZ1b8sMb4nXkWVYArc0rjuOzbtQ6wx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656217; c=relaxed/simple;
	bh=yTpQDMeHg+TDtngGFXOy1wXReOmMLyLEeOGANCnCQ6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8OnXui0e49oqIZxWUOSDykZ2ep5qc3IWh3jcWj7QhrAt7G0xEHag+e26HNRisTsmq8fRUg6hGaNcOt2zkCb0jy3qooNuZTC9sM9az5Xj0fzPSd8YhSDo8zrQqxl/sTjAM/7QV23B6vmh8TJtf7fdE3GzhTHmMU25NSK2SbxwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K36Vlj8c; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K36Vlj8c"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b26ed340399so36540a12.2
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749656215; x=1750261015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyOgDcPhp71EF9KWBdpqnwsh1LsGQiQo++evTy4ODw4=;
        b=K36Vlj8c7fku3OHw7OCl9E9PZtWxEVzitZ84P8DWRMgqfCu2MK1+DZt4QO+NDeWQ8G
         PPRDncTC2uzgucvsvPgygjTc7wQrkcA8f/z4vdfaOjXBrnHJ6eb2B3yg4DncY77urKa3
         9wOKuqA/x0qAAeKhIGqfBYdTbc1UFe/ofGrlm8qoZZF1dSxth1YvZTUFfr16Aff0ZG1f
         uRoPVocZskZj01K+60qzilxpoPOTcdGNbe92mO6GYTL8ABCr6CK05ZNX/2YhpAEpt43B
         mSqFP160rWKLJUnlJzShbkGvMjdX+6rU4xX+VWtA4cA2wDniKKcqTvAlx2gB/WknRVMx
         t6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749656215; x=1750261015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyOgDcPhp71EF9KWBdpqnwsh1LsGQiQo++evTy4ODw4=;
        b=X0GDqZX6Pks3r+m3YZoMOCE529iS1+UrWFbMbKnYQ2if2AKpXJtr0RcjfoKSe4Deww
         ScfBjTt7YtNV2hzjrEsuUGo3KOaM9GYsA/wHRYxDEqh/K8nbztO1huJ06zhoFtoU71tQ
         q0VIam0dTIx6teEpWGhui+Xy1qyPIaQe7NDlRnTuV6IBEL+CTW06sE7kKYoJnpLYb2jd
         TyoJ31vV+YMEGkDyeNnC3bpAZe4UgWm9f0QzHn5w3+8Upo4tctxawdhksldkxyrCode1
         nEYTRYJCzqoXcXXgtkBU4J8odbL4tVikf5B2xK3piFnx9T4GXXhNBpXUthdZMB+gAJs2
         GUwA==
X-Forwarded-Encrypted: i=1; AJvYcCUoY/3UscRvNHrkU+KA95iez7YJDnC3DuqA8nM42JL5c4C8/z4ZthZxMXCNbxzrCdUPu8EmY13jvrUC2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQqrUOIMwQnLKXdqL6g7Uivjad8JCguXGiWqkvPjXEA7y9nRk
	3RUkfj96ou9cpu/ULd7gtJM5j62uzqpEfUzlJosaHdB/gJlm3Y2F+wUnE4YuVzx3O4xUDKibfFa
	qG3BrrffqX2uqds8uFM3bEiVSvR0S16ROfHW1MfF/kQ==
X-Gm-Gg: ASbGnctAu3jf+opREgFdzNMAA3NeUI7nlRU4dcNwpzzilRWjlICTmzrWamG21zMbV1/
	XadoXpbaz4HnbDA2JmMB8IJHc/h45Sqqi9NndXNlNH+kluWA0UcOJM0txpLoJASmcjHPKnKYtx3
	JOwCajl9ctg2Qlytj3XcGKgBeJzAiHonhfTs0iFfIJ9+w=
X-Google-Smtp-Source: AGHT+IFNKDcn98W668OIW5/p3EDEQCgYjPbALUdRQLhIf0pLVclRb0FW8SW6xVvT/mjBMwRUTQhH/p2M7HQUr8yj2c0=
X-Received: by 2002:a17:90b:2f8b:b0:313:14b5:2521 with SMTP id
 98e67ed59e1d1-313af1e1bfdmr2266637a91.5.1749656214570; Wed, 11 Jun 2025
 08:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-8-csander@purestorage.com> <aEajMYnOJ2h82A1-@fedora>
 <CADUfDZpUwCDXGOfo4RGzqre4AC_nR2jkYwQETbD7jLPwP5cVow@mail.gmail.com> <aEeI1LoMQKgatFuk@fedora>
In-Reply-To: <aEeI1LoMQKgatFuk@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 11 Jun 2025 08:36:43 -0700
X-Gm-Features: AX0GCFt7MsL0yRoJLJZ-KFjHhQDNPjKacDlXq7HGE-wXNXnol6IaXIi9QaA7JmY
Message-ID: <CADUfDZp20khCoF7r8BFO4RC66cSz4jUcL9LbVjf1wpYj8scLTQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 6:22=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jun 09, 2025 at 10:14:21AM -0700, Caleb Sander Mateos wrote:
> > On Mon, Jun 9, 2025 at 2:02=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Fri, Jun 06, 2025 at 03:40:10PM -0600, Caleb Sander Mateos wrote:
> > > > ublk_register_io_buf() performs an expensive atomic refcount increm=
ent,
> > > > as well as a lot of pointer chasing to look up the struct request.
> > > >
> > > > Create a separate ublk_daemon_register_io_buf() for the daemon task=
 to
> > > > call. Initialize ublk_rq_data's reference count to a large number, =
count
> > > > the number of buffers registered on the daemon task nonatomically, =
and
> > > > atomically subtract the large number minus the number of registered
> > > > buffers in ublk_commit_and_fetch().
> > > >
> > > > Also obtain the struct request directly from ublk_io's req field in=
stead
> > > > of looking it up on the tagset.
> > > >
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c | 59 ++++++++++++++++++++++++++++++++++--=
----
> > > >  1 file changed, 50 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index 2084bbdd2cbb..ec9e0fd21b0e 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -81,12 +81,20 @@
> > > >  #define UBLK_PARAM_TYPE_ALL                                \
> > > >       (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> > > >        UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > > >        UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > > >
> > > > +/*
> > > > + * Initialize refcount to a large number to include any registered=
 buffers.
> > > > + * UBLK_IO_COMMIT_AND_FETCH_REQ will release these references minu=
s those for
> > > > + * any buffers registered on the io daemon task.
> > > > + */
> > > > +#define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
> > > > +
> > > >  struct ublk_rq_data {
> > > >       refcount_t ref;
> > > > +     unsigned buffers_registered;
> > > >
> > > >       /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG =
*/
> > > >       u16 buf_index;
> > > >       void *buf_ctx_handle;
> > > >  };
> > > > @@ -677,11 +685,12 @@ static inline void ublk_init_req_ref(const st=
ruct ublk_queue *ubq,
> > > >               struct request *req)
> > > >  {
> > > >       if (ublk_need_req_ref(ubq)) {
> > > >               struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > >
> > > > -             refcount_set(&data->ref, 1);
> > > > +             refcount_set(&data->ref, UBLK_REFCOUNT_INIT);
> > > > +             data->buffers_registered =3D 0;
> > > >       }
> > > >  }
> > > >
> > > >  static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
> > > >               struct request *req)
> > > > @@ -706,10 +715,19 @@ static inline void ublk_put_req_ref(const str=
uct ublk_queue *ubq,
> > > >       } else {
> > > >               __ublk_complete_rq(req);
> > > >       }
> > > >  }
> > > >
> > > > +static inline void ublk_sub_req_ref(struct request *req)
> > > > +{
> > > > +     struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > > +     unsigned sub_refs =3D UBLK_REFCOUNT_INIT - data->buffers_regi=
stered;
> > > > +
> > > > +     if (refcount_sub_and_test(sub_refs, &data->ref))
> > > > +             __ublk_complete_rq(req);
> > > > +}
> > > > +
> > > >  static inline bool ublk_need_get_data(const struct ublk_queue *ubq=
)
> > > >  {
> > > >       return ubq->flags & UBLK_F_NEED_GET_DATA;
> > > >  }
> > > >
> > > > @@ -1184,14 +1202,12 @@ static inline void __ublk_abort_rq(struct u=
blk_queue *ubq,
> > > >
> > > >  static void ublk_auto_buf_reg_fallback(struct request *req)
> > > >  {
> > > >       const struct ublk_queue *ubq =3D req->mq_hctx->driver_data;
> > > >       struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
> > > > -     struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > >
> > > >       iod->op_flags |=3D UBLK_IO_F_NEED_REG_BUF;
> > > > -     refcount_set(&data->ref, 1);
> > > >  }
> > > >
> > > >  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io =
*io,
> > > >                             unsigned int issue_flags)
> > > >  {
> > > > @@ -1207,13 +1223,12 @@ static bool ublk_auto_buf_reg(struct reques=
t *req, struct ublk_io *io,
> > > >                       return true;
> > > >               }
> > > >               blk_mq_end_request(req, BLK_STS_IOERR);
> > > >               return false;
> > > >       }
> > > > -     /* one extra reference is dropped by ublk_io_release */
> > > > -     refcount_set(&data->ref, 2);
> > > >
> > > > +     data->buffers_registered =3D 1;
> > > >       data->buf_ctx_handle =3D io_uring_cmd_ctx_handle(io->cmd);
> > > >       /* store buffer index in request payload */
> > > >       data->buf_index =3D pdu->buf.index;
> > > >       io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> > > >       return true;
> > > > @@ -1221,14 +1236,14 @@ static bool ublk_auto_buf_reg(struct reques=
t *req, struct ublk_io *io,
> > > >
> > > >  static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
> > > >                                  struct request *req, struct ublk_i=
o *io,
> > > >                                  unsigned int issue_flags)
> > > >  {
> > > > +     ublk_init_req_ref(ubq, req);
> > > >       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> > > >               return ublk_auto_buf_reg(req, io, issue_flags);
> > > >
> > > > -     ublk_init_req_ref(ubq, req);
> > > >       return true;
> > > >  }
> > > >
> > > >  static bool ublk_start_io(const struct ublk_queue *ubq, struct req=
uest *req,
> > > >                         struct ublk_io *io)
> > > > @@ -2019,10 +2034,31 @@ static int ublk_register_io_buf(struct io_u=
ring_cmd *cmd,
> > > >       }
> > > >
> > > >       return 0;
> > > >  }
> > > >
> > > > +static int ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
> > > > +                                    const struct ublk_queue *ubq,
> > > > +                                    const struct ublk_io *io,
> > > > +                                    unsigned index, unsigned issue=
_flags)
> > > > +{
> > > > +     struct request *req =3D io->req;
> > > > +     struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > > +     int ret;
> > > > +
> > > > +     if (!ublk_support_zero_copy(ubq) || !ublk_rq_has_data(req))
> > > > +             return -EINVAL;
> > > > +
> > > > +     ret =3D io_buffer_register_bvec(cmd, req, ublk_io_release, in=
dex,
> > > > +                                   issue_flags);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     data->buffers_registered++;
> > >
> > > This optimization replaces one ublk_get_req_ref()/refcount_inc_not_ze=
ro()
> > > with data->buffers_registered++ in case of registering io buffer from
> > > daemon context.
> > >
> > > And in typical implementation, the unregistering io buffer should be =
done
> > > in daemon context too, then I am wondering if any user-visible improv=
ement
> > > can be observed in this more complicated & fragile way:
> >
> > Yes, generally I would expect the unregister to happen on the daemon
> > task too. But it's possible (with patch "ublk: allow
> > UBLK_IO_(UN)REGISTER_IO_BUF on any task") for the
> > UBLK_IO_UNREGISTER_IO_BUF to be issued on another task. And even if
> > the unregister happens on the daemon task, it's up to the io_uring
> > layer to actually call ublk_io_release() once all requests using the
> > registered buffer have completed. Assuming only the daemon task issues
> > io_uring requests using the buffer, I believe ublk_io_release() will
> > always currently be called on that task. But I'd rather not make
> > assumptions about the io_uring layer. It's also possible in principle
> > for ublk_io_release() whether it's called on the daemon task and have
> > a fast path in that case (similar to UBLK_IO_REGISTER_IO_BUF).
>
> Yes, my point is that optimization should focus on common case.

Of course, I agree. I think the common case is for both register and
unregister to be issued on the daemon task. I only optimized the
register so far because it appears significantly more expensive (due
to the request lookup on the tagset and the CAS loop to increment the
refcount). I can test optimizing the unregister as well and see if
it's a net win.

>
> > But I'm not sure it's worth the cost of an additional ubq/io lookup.
> >
> > >
> > > - __ublk_check_and_get_req() is bypassed.
> > >
> > > - buggy application may overflow ->buffers_registered
> >
> > Isn't it already possible in principle for a ublk server to overflow
> > ublk_rq_data's refcount_t by registering the same ublk request with
> > lots of buffers? But sure, if you're concerned about this overflow, I
> > can easily add a check for it.
>
> At least refcount_inc_not_zero() will warn if it happens.
>
> >
> > >
> > > So can you share any data about this optimization on workload with lo=
cal
> > > registering & remote un-registering io buffer? Also is this usage
> > > really one common case?
> >
> > Sure, I can provide some performance measurements for this
> > optimization. From looking at CPU profiles in the past, the reference
> > counting and request lookup accounted for around 2% of the ublk server
> > CPU time. To be clear, in our use case, both the register and
> > unregister happen on the daemon task. I just haven't bothered
> > optimizing the reference-counting for the unregister yet because it
> > doesn't appear nearly as expensive.
>
> If you are talking about per-io-task, I guess it may not make a differenc=
e
> from user viewpoint from both iops and cpu utilization since the counter =
is
> basically per-task variable, and atomic cost shouldn't mean something for=
 us.

Atomic RMW operations are more expensive than non-atomic ones even
when the cache line isn't contended (at least in my experience on
x86). The effect is greater in systems with large numbers of CPUs (and
especially with multiple NUMA nodes). Let me collect some precise
performance numbers, but I recall it being a significant hotspot.

Best,
Caleb
