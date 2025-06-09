Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF48633F
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489279; cv=none; b=kwSTtP5a0y78xCJFEIyYlvDmlO5MKaJru3oLOnGzLx1/5n7eLOLs3X34yLlB2Pm55jmZk/u6hG6XazDJ0Dx+9igJEF+0Yl3imJOJgK0rZHCHSaZ7gRyGE0Y9kMD6Ayukym/T8ZgW7MVtCU1PJWP0jUE2UCPGG4rjBKaO7+SdSXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489279; c=relaxed/simple;
	bh=lA8Y3GL4V6qoBGVJufQNgdtz/nXDfaIoAKbp9Rvl1us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fw69uCNRGGogowBPzEqzZf9JGxgdmLAofSris2d/QtA9ZMW+FfaPxe3A3bKJXD5giPeSm56tR3Omb2DOena8I0qP94i/eLTGVMK6DMrFMhv1nYRuvPqiT7xNPAzJsjUJFlq47xahxsXGMUV1b1Lj4bZItMo3zdc7wdRAaco/4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BnAkm/Qj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BnAkm/Qj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234d3103237so5485495ad.0
        for <linux-block@vger.kernel.org>; Mon, 09 Jun 2025 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749489273; x=1750094073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wx9TJYB4XnuxhcQwEDBtRixtE2pvevMbOjWFVy0hvks=;
        b=BnAkm/QjHgFb55OiDk9n+2thRqEgz0mtEZLmExpaxzpZqZ9CCNLZ9yBqdEiT3Ev7Px
         Yf01QQ9JhuZZ3nwh6P5k8PKkU43HKFcjrxXeRVNAy9PkaMYSy7VeSgLKDDHm7jqZNald
         A+HBk/cia/bGvpjgEeee7sf9yLN8exLsInXc2+EZ4Kj5/YPHVZFo3ribw5tooZVFolmj
         NoyaZ751AAPblef73eG2D0TS5zRWw3k4FFCuXlaPL677xmt4+NQ/B+PV0LLCscaO9oFT
         DNJUIE12gmhccmfQz2r30u566FzhCX6UvGkUKRWRz6SBwjZWUNOWOTAM54dOda6eFQ3Y
         qvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749489273; x=1750094073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wx9TJYB4XnuxhcQwEDBtRixtE2pvevMbOjWFVy0hvks=;
        b=Aqz/AeVRhDrkizAxmnSOgnguvnj7oabSAI285guZR/KZZe2B2uJVIlAs9vF0Lx078q
         09XhgGXWwitpr6O/O5E2H0cKG0LMijuDDcDQ+qOB19Uu3pDLOU/6eQs0ieM28Q6yehw3
         opbsa0/ECRKMPASwgQVIFzTgiiRtERawgRe7EkmmG+ySWCy7SCkzaAMIhqDRNsb+TylY
         54IccxwdYQnEB5hu6j1ZKfgHckiDcf2lp/DIvg469fIeVDJlYdQjytAEfO4tKna7WVMx
         QHtPpqFVSIdsJb9exXHxlrV4PpGvzWWm26HWb4jMqvb9FgGNoTm+epDTjyxjKgYHULJ5
         /Fiw==
X-Forwarded-Encrypted: i=1; AJvYcCXsbmwQYwN/jPtXMcRcdmtCAzL+fpXbBFFUnTY6MsmKjNWCb7GxEJUSo7e8m0zmFKkhU63hNH/rTwwT9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+66ErXNj3uzPlW1ZAviFgMpNzp/3TPPzujm1/yBdXRnzAkuB
	Np7UtFuIaXYCNS6+/L4tVWIOSSrG18aRNFH/YuKHT9sNTZ4VdSiG+SJyRcjr5yVkIE+pnctr6ma
	q88LHUe+pwbBQzwZU2g+Dop5OYw0A4zvHQzCqe4D+sairsi4m3wS5u9A=
X-Gm-Gg: ASbGncuHZ0vMTIrSwrZIHm/aEWGUeXNaearba1FVjaZ0Fui2sGELaMVHwy/+DhgrNgj
	F37FLj8jGQJwwPsc1gEB+hg7Xg/WXfY8JUtKMVpbbXCGIJo4O8QHKaIjCQ8w6L+Nj++8tRoMIeY
	uC/JfaQsudvfh+eptScthCuCM+M60gkFD86xoj4l5zYNY=
X-Google-Smtp-Source: AGHT+IHyc6ZajftYNrRmC31x3UoL/O7e6pFxtT4GKEvPG9NorMWDWEZZdaaWu33UBijhWDPvOs4aBTG6QdbCLJVorAk=
X-Received: by 2002:a17:903:41c7:b0:234:8a16:d80c with SMTP id
 d9443c01a7336-2360411f883mr72933145ad.14.1749489273269; Mon, 09 Jun 2025
 10:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-8-csander@purestorage.com> <aEajMYnOJ2h82A1-@fedora>
In-Reply-To: <aEajMYnOJ2h82A1-@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 9 Jun 2025 10:14:21 -0700
X-Gm-Features: AX0GCFt4Jkg-IUZyi2TJ6H9qjFlKEo-_hyhCUffUroOvwjzupgJ-K1cGyH01r4o
Message-ID: <CADUfDZpUwCDXGOfo4RGzqre4AC_nR2jkYwQETbD7jLPwP5cVow@mail.gmail.com>
Subject: Re: [PATCH 7/8] ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 2:02=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Fri, Jun 06, 2025 at 03:40:10PM -0600, Caleb Sander Mateos wrote:
> > ublk_register_io_buf() performs an expensive atomic refcount increment,
> > as well as a lot of pointer chasing to look up the struct request.
> >
> > Create a separate ublk_daemon_register_io_buf() for the daemon task to
> > call. Initialize ublk_rq_data's reference count to a large number, coun=
t
> > the number of buffers registered on the daemon task nonatomically, and
> > atomically subtract the large number minus the number of registered
> > buffers in ublk_commit_and_fetch().
> >
> > Also obtain the struct request directly from ublk_io's req field instea=
d
> > of looking it up on the tagset.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 59 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 50 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 2084bbdd2cbb..ec9e0fd21b0e 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -81,12 +81,20 @@
> >  #define UBLK_PARAM_TYPE_ALL                                \
> >       (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> >        UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> >        UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> >
> > +/*
> > + * Initialize refcount to a large number to include any registered buf=
fers.
> > + * UBLK_IO_COMMIT_AND_FETCH_REQ will release these references minus th=
ose for
> > + * any buffers registered on the io daemon task.
> > + */
> > +#define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
> > +
> >  struct ublk_rq_data {
> >       refcount_t ref;
> > +     unsigned buffers_registered;
> >
> >       /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
> >       u16 buf_index;
> >       void *buf_ctx_handle;
> >  };
> > @@ -677,11 +685,12 @@ static inline void ublk_init_req_ref(const struct=
 ublk_queue *ubq,
> >               struct request *req)
> >  {
> >       if (ublk_need_req_ref(ubq)) {
> >               struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> >
> > -             refcount_set(&data->ref, 1);
> > +             refcount_set(&data->ref, UBLK_REFCOUNT_INIT);
> > +             data->buffers_registered =3D 0;
> >       }
> >  }
> >
> >  static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
> >               struct request *req)
> > @@ -706,10 +715,19 @@ static inline void ublk_put_req_ref(const struct =
ublk_queue *ubq,
> >       } else {
> >               __ublk_complete_rq(req);
> >       }
> >  }
> >
> > +static inline void ublk_sub_req_ref(struct request *req)
> > +{
> > +     struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > +     unsigned sub_refs =3D UBLK_REFCOUNT_INIT - data->buffers_register=
ed;
> > +
> > +     if (refcount_sub_and_test(sub_refs, &data->ref))
> > +             __ublk_complete_rq(req);
> > +}
> > +
> >  static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
> >  {
> >       return ubq->flags & UBLK_F_NEED_GET_DATA;
> >  }
> >
> > @@ -1184,14 +1202,12 @@ static inline void __ublk_abort_rq(struct ublk_=
queue *ubq,
> >
> >  static void ublk_auto_buf_reg_fallback(struct request *req)
> >  {
> >       const struct ublk_queue *ubq =3D req->mq_hctx->driver_data;
> >       struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
> > -     struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> >
> >       iod->op_flags |=3D UBLK_IO_F_NEED_REG_BUF;
> > -     refcount_set(&data->ref, 1);
> >  }
> >
> >  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
> >                             unsigned int issue_flags)
> >  {
> > @@ -1207,13 +1223,12 @@ static bool ublk_auto_buf_reg(struct request *r=
eq, struct ublk_io *io,
> >                       return true;
> >               }
> >               blk_mq_end_request(req, BLK_STS_IOERR);
> >               return false;
> >       }
> > -     /* one extra reference is dropped by ublk_io_release */
> > -     refcount_set(&data->ref, 2);
> >
> > +     data->buffers_registered =3D 1;
> >       data->buf_ctx_handle =3D io_uring_cmd_ctx_handle(io->cmd);
> >       /* store buffer index in request payload */
> >       data->buf_index =3D pdu->buf.index;
> >       io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> >       return true;
> > @@ -1221,14 +1236,14 @@ static bool ublk_auto_buf_reg(struct request *r=
eq, struct ublk_io *io,
> >
> >  static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
> >                                  struct request *req, struct ublk_io *i=
o,
> >                                  unsigned int issue_flags)
> >  {
> > +     ublk_init_req_ref(ubq, req);
> >       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> >               return ublk_auto_buf_reg(req, io, issue_flags);
> >
> > -     ublk_init_req_ref(ubq, req);
> >       return true;
> >  }
> >
> >  static bool ublk_start_io(const struct ublk_queue *ubq, struct request=
 *req,
> >                         struct ublk_io *io)
> > @@ -2019,10 +2034,31 @@ static int ublk_register_io_buf(struct io_uring=
_cmd *cmd,
> >       }
> >
> >       return 0;
> >  }
> >
> > +static int ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
> > +                                    const struct ublk_queue *ubq,
> > +                                    const struct ublk_io *io,
> > +                                    unsigned index, unsigned issue_fla=
gs)
> > +{
> > +     struct request *req =3D io->req;
> > +     struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > +     int ret;
> > +
> > +     if (!ublk_support_zero_copy(ubq) || !ublk_rq_has_data(req))
> > +             return -EINVAL;
> > +
> > +     ret =3D io_buffer_register_bvec(cmd, req, ublk_io_release, index,
> > +                                   issue_flags);
> > +     if (ret)
> > +             return ret;
> > +
> > +     data->buffers_registered++;
>
> This optimization replaces one ublk_get_req_ref()/refcount_inc_not_zero()
> with data->buffers_registered++ in case of registering io buffer from
> daemon context.
>
> And in typical implementation, the unregistering io buffer should be done
> in daemon context too, then I am wondering if any user-visible improvemen=
t
> can be observed in this more complicated & fragile way:

Yes, generally I would expect the unregister to happen on the daemon
task too. But it's possible (with patch "ublk: allow
UBLK_IO_(UN)REGISTER_IO_BUF on any task") for the
UBLK_IO_UNREGISTER_IO_BUF to be issued on another task. And even if
the unregister happens on the daemon task, it's up to the io_uring
layer to actually call ublk_io_release() once all requests using the
registered buffer have completed. Assuming only the daemon task issues
io_uring requests using the buffer, I believe ublk_io_release() will
always currently be called on that task. But I'd rather not make
assumptions about the io_uring layer. It's also possible in principle
for ublk_io_release() whether it's called on the daemon task and have
a fast path in that case (similar to UBLK_IO_REGISTER_IO_BUF). But I'm
not sure it's worth the cost of an additional ubq/io lookup.

>
> - __ublk_check_and_get_req() is bypassed.
>
> - buggy application may overflow ->buffers_registered

Isn't it already possible in principle for a ublk server to overflow
ublk_rq_data's refcount_t by registering the same ublk request with
lots of buffers? But sure, if you're concerned about this overflow, I
can easily add a check for it.

>
> So can you share any data about this optimization on workload with local
> registering & remote un-registering io buffer? Also is this usage
> really one common case?

Sure, I can provide some performance measurements for this
optimization. From looking at CPU profiles in the past, the reference
counting and request lookup accounted for around 2% of the ublk server
CPU time. To be clear, in our use case, both the register and
unregister happen on the daemon task. I just haven't bothered
optimizing the reference-counting for the unregister yet because it
doesn't appear nearly as expensive.

Best,
Caleb
