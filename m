Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7C2AF0E
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745723392; cv=none; b=jucg9EYsHFCk+MGTdG/xDRbBJIgMuWYmlenZ0Vt0xFzjaKPczxu4tuDtvfEpjFxnwii0neI7m7lqomICk4HTqKzxWAl6MHzwlHuYCBNwqM9NJ7NXgxD5nso0SnEVU/vsvmaGTAUkGkF2yDn5vNYJ757UtBYOzgQQrEccSMXpnuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745723392; c=relaxed/simple;
	bh=6C9Dtb5aIL9P0hlMccQ6+Q3pg08bys/SfqgSHo2oYiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIBO4pLT6TCGfOPPMuT3Je3kgfAemp0tsC/mnukoLUNZDuLe7fYz2FWQlN7vAEnSb1DhN4IaiAIBBL9jg8eHajxYZK586c9hIYTm7yQfObnxyISgDJUm2hB+R2nf5VJ4fIldNKKhrMaRUiFKVZcgJMSxzk3AI4pBNkwnwQ8AQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=H3V/wHnD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="H3V/wHnD"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736ac19918cso500382b3a.2
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 20:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745723390; x=1746328190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0L4Gr57KdGZAc3RgfivjNFnDW0aEgavLKuW888/AlI=;
        b=H3V/wHnDZhVXvJGA/bLRurQa0RzMnv/Cw3C+MssJVC4JD7pqGsPoqyqy1xYyJAv3zd
         RsuQyUepo9invg58ZAkkSPShlpyeIpk3C/yKPDkKkEm1AW18E5mfJeHjTRI4HVK+jLZd
         7IZtfCMgL+LH51x/moFm8VoFQovgXKp+b7C5DjBYQlIzkTNScirh15OApkbdBu0JP6pL
         sYYg/ALjb1Lq+imRnleBNuA5cP8ziXbngPwoelrWkgeuOJp7DnqbIr34YX75JvKJdqSf
         0eziUxz3+aCleJun+h2IUZND0tGjFWrZ77SKoDL+ILziSZhxk6Y30BKPvaSSwa0WV8cQ
         BANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745723390; x=1746328190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0L4Gr57KdGZAc3RgfivjNFnDW0aEgavLKuW888/AlI=;
        b=iuM5nTDbnh4XfAtkWKGDHTnMw+o0VPvaj31MJ4dek2IQ2r9A0hQaUEkydazCE+ZY/1
         JO+14RAhPLLxLJNy0fVtV2tnVB3qRx63/Mo0dRL6anwyUegb1ghCqtFYfvt03SGgO1xt
         ocNg0GCAVJjNswYPtTMaWhCc4VECJyC5O+Xnko0nRDUM6q0uaORg7u9xsEtQuSf/I5qC
         TvOKrN1RZv3hea7iiCnyih7Mt05fDxMZ8AjM4hxjE7LRpwzEmkMJDsfc15l9/4xJS3A9
         taCbIOagUcM2VljKrZ7/0E3za2JyYQWccr6JhfNJcTxeuUq9gpuJ//RK1KRhb80TOFdf
         2yfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj4FQBJj21mLfHObpe9eq4+CCJD5/GqUXLTwNVCtqENtJp5+nnHnOeOH+5ck8p2/u9gt1wOLpJBg/jiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydempAeI8jgxeValP5wYe9thL70QlpPtQ7p5lXBFuP7yQNt+JG
	MyY8Oic9dhYK4d40A42clv6iYx50mLVLTvPjCH55CWoVJh3cYOpiG5Zt9Xapj+do8Gwq7FXLg85
	vdkNnYNGoyo9GIznkGMuCweSJkjWet2qlkzfCig==
X-Gm-Gg: ASbGncse6CiESC5TU8qN7pIjk/2dDKFhI5ajyh0WSw9EeLE1nGcm/jONlI8Bb0pvlc6
	jRMLcs3202HyxvLiNGhD4rFIAmN2OGXt4CSK+YGjYmeRJQZBV0H+i56ZAK0fFf/oe/LJTDwKEZw
	AytCnU0o+eosp8k/Eq+Lh+
X-Google-Smtp-Source: AGHT+IHL6lakA8kLkttuQPHS14y6+akqJq9rQqdKOELsRIErr8KMKP+tvhHxIYI5PIivNRNmbkQDSUXSnfDNaHvSKng=
X-Received: by 2002:a17:90b:1e4b:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-309f7c73b88mr4064019a91.0.1745723389439; Sat, 26 Apr 2025
 20:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426094111.1292637-1-ming.lei@redhat.com> <20250426094111.1292637-4-ming.lei@redhat.com>
 <CADUfDZqQ_xvFMP=yjUYvvnn6u36iNBmcgoONBoBVhDjyiZQfjA@mail.gmail.com> <aA2RNG3-WzuQqEN6@fedora>
In-Reply-To: <aA2RNG3-WzuQqEN6@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 26 Apr 2025 20:09:38 -0700
X-Gm-Features: ATxdqUH-rjQDIySt1uE14c86rPe2fW-JKkAhNS5WaHCYunT1VtyQdukf13FZU3o
Message-ID: <CADUfDZr6ezr=1_qTOm0xUJ1YfXVH_z57V4fNnQm6D-856T6A_g@mail.gmail.com>
Subject: Re: [PATCH 3/4] ublk: add feature UBLK_F_AUTO_ZERO_COPY
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 7:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Sat, Apr 26, 2025 at 03:42:59PM -0700, Caleb Sander Mateos wrote:
> > On Sat, Apr 26, 2025 at 2:41=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > UBLK_F_SUPPORT_ZERO_COPY requires ublk server to issue explicit buffe=
r
> > > register/unregister uring_cmd for each IO, this way is not only ineff=
icient,
> > > but also introduce dependency between buffer consumer and buffer regi=
ster/
> > > unregister uring_cmd, please see tools/testing/selftests/ublk/stripe.=
c
> > > in which backing file IO has to be issued one by one by IOSQE_IO_LINK=
.
> >
> > This is a great idea!
> >
> > >
> > > Add feature UBLK_F_AUTO_ZERO_COPY for addressing the existed zero cop=
y
> > > limit:
> >
> > nit: "existed" -> "existing", "limit" -> "limitation"
> >
> > >
> > > - register request buffer automatically before delivering io command =
to
> > > ublk server
> > >
> > > - unregister request buffer automatically when completing the request
> > >
> > > - io_uring will unregister the buffer automatically when uring is
> > >   exiting, so we needn't worry about accident exit
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 87 +++++++++++++++++++++++++++------=
--
> > >  include/uapi/linux/ublk_cmd.h | 20 ++++++++
> > >  2 files changed, 89 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 347790b3a633..453767f91431 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -64,7 +64,8 @@
> > >                 | UBLK_F_CMD_IOCTL_ENCODE \
> > >                 | UBLK_F_USER_COPY \
> > >                 | UBLK_F_ZONED \
> > > -               | UBLK_F_USER_RECOVERY_FAIL_IO)
> > > +               | UBLK_F_USER_RECOVERY_FAIL_IO \
> > > +               | UBLK_F_AUTO_ZERO_COPY)
> > >
> > >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > > @@ -131,6 +132,14 @@ struct ublk_uring_cmd_pdu {
> > >   */
> > >  #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
> > >
> > > +/*
> > > + * request buffer is registered automatically, so we have to unregis=
ter it
> > > + * before completing this request.
> > > + *
> > > + * io_uring will unregister buffer automatically for us during exiti=
ng.
> > > + */
> > > +#define UBLK_IO_FLAG_UNREG_BUF         0x10
> > > +
> > >  /* atomic RW with ubq->cancel_lock */
> > >  #define UBLK_IO_FLAG_CANCELED  0x80000000
> > >
> > > @@ -207,7 +216,8 @@ static inline struct ublksrv_io_desc *ublk_get_io=
d(struct ublk_queue *ubq,
> > >                                                    int tag);
> > >  static inline bool ublk_dev_is_user_copy(const struct ublk_device *u=
b)
> > >  {
> > > -       return ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPOR=
T_ZERO_COPY);
> > > +       return ub->dev_info.flags & (UBLK_F_USER_COPY |
> > > +                       UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_AUTO_ZERO_C=
OPY);
> > >  }
> > >
> > >  static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> > > @@ -614,6 +624,11 @@ static inline bool ublk_support_zero_copy(const =
struct ublk_queue *ubq)
> > >         return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> > >  }
> > >
> > > +static inline bool ublk_support_auto_zc(const struct ublk_queue *ubq=
)
> > > +{
> > > +       return ubq->flags & UBLK_F_AUTO_ZERO_COPY;
> > > +}
> > > +
> > >  static inline bool ublk_support_user_copy(const struct ublk_queue *u=
bq)
> > >  {
> > >         return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_C=
OPY);
> > > @@ -621,7 +636,7 @@ static inline bool ublk_support_user_copy(const s=
truct ublk_queue *ubq)
> > >
> > >  static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
> > >  {
> > > -       return !ublk_support_user_copy(ubq);
> > > +       return !ublk_support_user_copy(ubq) && !ublk_support_auto_zc(=
ubq);
> > >  }
> > >
> > >  static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> > > @@ -629,17 +644,21 @@ static inline bool ublk_need_req_ref(const stru=
ct ublk_queue *ubq)
> > >         /*
> > >          * read()/write() is involved in user copy, so request refere=
nce
> > >          * has to be grabbed
> > > +        *
> > > +        * For auto zc, ublk server still may issue UBLK_IO_COMMIT_AN=
D_FETCH_REQ
> > > +        * before one registered buffer is used up, so reference is
> > > +        * required too.
> > >          */
> > > -       return ublk_support_user_copy(ubq);
> > > +       return ublk_support_user_copy(ubq) || ublk_support_auto_zc(ub=
q);
> >
> > Since both places where ublk_support_user_copy() is used are being
> > adjusted to also check ublk_support_auto_zc(), maybe
> > ublk_support_user_copy() should just be changed to check
> > UBLK_F_AUTO_ZERO_COPY too?
>
> I think that isn't good, we should have let each flag to cover its featur=
e only.
>
> That said it was not good to add zero copy check in both ublk_support_use=
r_copy()
> and ublk_dev_is_user_copy().

Fair point.

>
> If ublk server needs user copy, it should have enabled it explicitly.
>
> >
> > >  }
> > >
> > >  static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
> > > -               struct request *req)
> > > +               struct request *req, int init_ref)
> > >  {
> > >         if (ublk_need_req_ref(ubq)) {
> > >                 struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > >
> > > -               kref_init(&data->ref);
> > > +               refcount_set(&data->ref.refcount, init_ref);
> >
> > It might be nicer not to mix kref and raw reference count operations.
> > Maybe you could add a prep patch that switches from struct kref to
> > refcount_t?
>
> That is fine, or probably kref need to provide one variant of __kref_init=
(nr).
>
> >
> > >         }
> > >  }
> > >
> > > @@ -667,6 +686,15 @@ static inline void ublk_put_req_ref(const struct=
 ublk_queue *ubq,
> > >         }
> > >  }
> > >
> > > +/* for ublk zero copy */
> > > +static void ublk_io_release(void *priv)
> > > +{
> > > +       struct request *rq =3D priv;
> > > +       struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> > > +
> > > +       ublk_put_req_ref(ubq, rq);
> > > +}
> > > +
> > >  static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
> > >  {
> > >         return ubq->flags & UBLK_F_NEED_GET_DATA;
> > > @@ -1231,7 +1259,22 @@ static void ublk_dispatch_req(struct ublk_queu=
e *ubq,
> > >                         mapped_bytes >> 9;
> > >         }
> > >
> > > -       ublk_init_req_ref(ubq, req);
> > > +       if (ublk_support_auto_zc(ubq) && ublk_rq_has_data(req)) {
> > > +               int ret;
> > > +
> > > +               /* one extra reference is dropped by ublk_io_release =
*/
> > > +               ublk_init_req_ref(ubq, req, 2);
> > > +               ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io=
_release,
> > > +                                             tag, issue_flags);
> >
> > Using the ublk request tag as the registered buffer index may be too
> > limiting. It would cause collisions if there are multiple ublk devices
> > or queues handled on a single io_uring. It also requires offsetting
> > any registered user buffers so their indices come after all the ublk
> > ones, which may be difficult if ublk devices are added dynamically.
> > Perhaps the UBLK_IO_FETCH_REQ operation could specify the registered
> > buffer index to use for the request?
> >
> > This also requires the io_uring issuing the zero-copy I/Os to be the
> > same as the one submitting the ublk fetch requests. That would also
> > make it difficult for us to adopt for our ublk server, which uses
> > separate io_urings. Not sure if there is a simple way the ublk server
> > could specify what io_uring to register the ublk zero-copy buffers
> > with.
>
> I think it can be done by passing `io_uring fd` and buffer 'index' via
> uring_cmd_header, there is still one u64 (->addr) left for zero copy,
> then the buffer's `io_uring fd/fixed_fd` and 'index' can be provided
> to io_uring core for registering buffer, this way should be flexible
> enough for covering any case.
>
> >
> > > +               if (ret) {
> > > +                       blk_mq_end_request(req, BLK_STS_IOERR);
> > > +                       return;
> >
> > Does this leak the ublk fetch request? Seems like it should be
>
> It won't leak ublk uring_cmd which is just for delivering ublk
> io command to ublk server.

But where does the uring_cmd complete? The early return means this
will skip the call to ubq_complete_io_cmd(). Won't that leave the
uring_cmd stuck until the io_uring exits?

>
> > completed to the ublk server with an error code.
>
> It could be hard for ublk server to deal with, I'd suggest to
> start with one simple implementation first.
>
> It is usually one bug, and user will get notified from client's
> failure, then complain and ublk server gets fixed.
>
> >
> > > +               }
> > > +               io->flags |=3D UBLK_IO_FLAG_UNREG_BUF;
> > > +       } else {
> > > +               ublk_init_req_ref(ubq, req, 1);
> > > +       }
> > > +
> > >         ubq_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
> > >  }
> > >
> > > @@ -1593,7 +1636,8 @@ static int ublk_ch_mmap(struct file *filp, stru=
ct vm_area_struct *vma)
> > >  }
> > >
> > >  static void ublk_commit_completion(struct ublk_device *ub,
> > > -               const struct ublksrv_io_cmd *ub_cmd)
> > > +               const struct ublksrv_io_cmd *ub_cmd,
> > > +               unsigned int issue_flags)
> > >  {
> > >         u32 qid =3D ub_cmd->q_id, tag =3D ub_cmd->tag;
> > >         struct ublk_queue *ubq =3D ublk_get_queue(ub, qid);
> > > @@ -1604,6 +1648,15 @@ static void ublk_commit_completion(struct ublk=
_device *ub,
> > >         io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
> > >         io->res =3D ub_cmd->result;
> > >
> > > +       if (io->flags & UBLK_IO_FLAG_UNREG_BUF) {
> > > +               int ret;
> > > +
> > > +               ret =3D io_buffer_unregister_bvec(io->cmd, tag, issue=
_flags);
> > > +               if (ret)
> > > +                       io->res =3D ret;
> >
> > I think it would be confusing to report an error to the application
> > submitting the I/O if unregistration fails. The only scenario where it
> > seems possible for this to fail is if userspace issues an
> > IORING_REGISTER_BUFFERS_UPDATE that overwrites the registered buffer
> > slot while the ublk request is being handled by the ublk server. I
> > would either ignore any error from io_buffer_unregister_bvec() or
> > return it to the ublk server.
>
> Fair enough, maybe WARN_ON_ONCE() is enough.

I think it's technically triggerable from userspace, but certainly
very unexpected.

Best,
Caleb

>
> >
> > > +               io->flags &=3D ~UBLK_IO_FLAG_UNREG_BUF;
> > > +       }
> > > +
> > >         /* find the io request and complete */
> > >         req =3D blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
> > >         if (WARN_ON_ONCE(unlikely(!req)))
> > > @@ -1942,14 +1995,6 @@ static inline void ublk_prep_cancel(struct io_=
uring_cmd *cmd,
> > >         io_uring_cmd_mark_cancelable(cmd, issue_flags);
> > >  }
> > >
> > > -static void ublk_io_release(void *priv)
> > > -{
> > > -       struct request *rq =3D priv;
> > > -       struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> > > -
> > > -       ublk_put_req_ref(ubq, rq);
> > > -}
> > > -
> > >  static int ublk_register_io_buf(struct io_uring_cmd *cmd,
> > >                                 struct ublk_queue *ubq, unsigned int =
tag,
> > >                                 unsigned int index, unsigned int issu=
e_flags)
> > > @@ -2124,7 +2169,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_=
cmd *cmd,
> > >                 }
> > >
> > >                 ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> > > -               ublk_commit_completion(ub, ub_cmd);
> > > +               ublk_commit_completion(ub, ub_cmd, issue_flags);
> > >                 break;
> > >         case UBLK_IO_NEED_GET_DATA:
> > >                 if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> > > @@ -2730,6 +2775,11 @@ static int ublk_ctrl_add_dev(const struct ublk=
srv_ctrl_cmd *header)
> > >                 return -EINVAL;
> > >         }
> > >
> > > +       /* F_AUTO_ZERO_COPY and F_SUPPORT_ZERO_COPY can't co-exist */
> > > +       if ((info.flags & UBLK_F_AUTO_ZERO_COPY) &&
> > > +                       (info.flags & UBLK_F_SUPPORT_ZERO_COPY))
> > > +               return -EINVAL;
> > > +
> > >         /*
> > >          * unprivileged device can't be trusted, but RECOVERY and
> > >          * RECOVERY_REISSUE still may hang error handling, so can't
> > > @@ -2747,7 +2797,8 @@ static int ublk_ctrl_add_dev(const struct ublks=
rv_ctrl_cmd *header)
> > >                  * buffer by pwrite() to ublk char device, which can'=
t be
> > >                  * used for unprivileged device
> > >                  */
> > > -               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_Z=
ERO_COPY))
> > > +               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_Z=
ERO_COPY |
> > > +                                       UBLK_F_AUTO_ZERO_COPY))
> > >                         return -EINVAL;
> > >         }
> > >
> > > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_=
cmd.h
> > > index 583b86681c93..d8bb5e55cce7 100644
> > > --- a/include/uapi/linux/ublk_cmd.h
> > > +++ b/include/uapi/linux/ublk_cmd.h
> > > @@ -211,6 +211,26 @@
> > >   */
> > >  #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
> > >
> > > +/*
> > > + * request buffer is registered automatically before delivering this=
 io
> > > + * command to ublk server, meantime it is un-registered automaticall=
y
> > > + * when completing this io command.
> > > + *
> > > + * request tag has to be used as the buffer index, and ublk server h=
as to
> > > + * pass this IO's tag as buffer index for using the registered zero =
copy
> > > + * buffer
> > > + *
> > > + * This way avoids extra uring_cmd cost, but also simplifies backend
> > > + * implementation, such as, the dependency on IO_REGISTER_IO_BUF and
> > > + * IO_UNREGISTER_IO_BUF becomes not necessary.
> > > + *
> > > + * For using this feature, ublk server has to register buffer table
> > > + * in sparse way, and buffer number has to be >=3D ublk queue depth.
> > > + *
> > > + * This feature is preferred to UBLK_F_SUPPORT_ZERO_COPY.
> > > + */
> > > +#define UBLK_F_AUTO_ZERO_COPY  (1ULL << 10)
> >
> > This flag is already taken by UBLK_F_UPDATE_SIZE in commit "ublk: Add
> > UBLK_U_CMD_UPDATE_SIZE". You may need to rebase on for-6.16/block.
>
> Good catch, will fix it in V2.
>
>
> Thanks,
> Ming
>
