Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBF1FC8
	for <linux-block@vger.kernel.org>; Sat, 17 May 2025 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747479781; cv=none; b=nqRQNaahhLcorEGU9La4f1S/1ae18ZnsoG9w+3xbeO6+hezdM4Q6OjZv6HV7GFrszpb6yQfyXQ2jKVr0waMl1XHddLMITAbH/ce7C3dKYI0UE/gH6HNanSaxdYOhocZ/E1KU7d+gpqRrHrkUp7NTitTnJP2GZEO8DOroiB9F7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747479781; c=relaxed/simple;
	bh=lP6y9lVfsjsvMx67dPxP750dwHM6RQ2JOvVIcZAPZV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AygoiO0Xi46Gp2gurxUeHQZxWuESKphowl91YAnb929Knvr4GTlxmvdE+F5vikOt3+Ki7xbpCl81d9mL/80Hys6U39nohdhbvcgEfins71A3uQ50l8bIt45AdIgFuWBl64t1pR3hem/YKI0rKoz7xYbdyUrNsRSU3gOO5VgcpPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtqXEy0p; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtqXEy0p"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c035f2afso87351b3a.2
        for <linux-block@vger.kernel.org>; Sat, 17 May 2025 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747479778; x=1748084578; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MamJ1CmOEzpyvSbfJY3ZiKntD9lsPxLccbbNZ5AYylU=;
        b=jtqXEy0p1dFZAX+tTCrDZUrIeljC9S4/m9kYl/eaqRLs0cqdnuG5wx/3XghdqeEK4n
         vk4CZq5qxzd3Rg5inJxmzx6dW9X//KbiEcH1KkteMZmCzc1ogNzXwqNxlW7CckGv6nJu
         KvrQmL70MgiMeyfdZvu0nKMvItTqu44xaJfVdA0HiZLRy+T9M/dlF2pQq4WGFvIGBgPq
         vCpFEHOWrylaV4vkZWpbTyKAWIsuzHObNdQJYpA3EfE/SpD5LFoa4FEOL67w5kZmfZWu
         welS/tesweBXzs8xTtwIyXRT7HZAGg/xFb6Gru5954lGLClj8X9gW8/vSevEfgzd7or7
         HvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747479778; x=1748084578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MamJ1CmOEzpyvSbfJY3ZiKntD9lsPxLccbbNZ5AYylU=;
        b=FObF1f2qNhIc20NeULVDrKbEjXsZDmJY9mxcybMcnoS04pLUQDrpo7dx8knIt3i2xG
         GQMkH9gsYKx1kxjpIgYT+fQU0asE6Vm8k5zgOlvKr8BX9YYmjlddIkG3IG1FDIzdBVHI
         62DwAejglWsGBtyu7yflrv3TslRcpk2ApfasKx1OOKj+hpuLorS0j9418kAyDEeRmVMh
         FBMzz/Nyy2WVElCeuRCwgUydM4zl/1DVHvHeXh8PpqU7e2+nnQuCiL1oulJCTPez9zHZ
         WVmDN+qVd7+ZZy4qK+a412Uf8TxEorPKrulQPa0a5JiqDddow+F2Pi/vn6J3ou3EEu3v
         0tbw==
X-Forwarded-Encrypted: i=1; AJvYcCUz/n1plikCPS5R/NgHE8x4lQIrTXJxomA+5mkTVOVlgxJY4lJtltmaAGiC3gKmf6mmhwZi/EH8yh6hHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUvkoGuOqk/525QPeB/4Xa8cXdoCiB5pfNC9nnVIOjrLjw2dKP
	Cg1wDcVQ/b0hS8uiRNSr/7Ntt3TNhiYewxpzaeFKC+2C/A/yWvFMuKdo
X-Gm-Gg: ASbGncvKuG9KcNyDqtonEJWKfVjLoaKRwWMqFOnYVnWFwk7bzEDceZkVLshCGD8QfVN
	ppIDRJOV+hUFC1CppgAnaHYpsy1W66s8kM/xRU0WKTrdS/2vzIStkRCtSAlS+RpeCpz+hfrw83K
	SYXyFGpfuOhSJlrY7n/LC09PWjlxcuF06t1jNc64l4SDaKIkwI9XzDSc15kJAu5bZ4VlNHNEJXf
	Wn1QEm1CtoHYT0ULPMTeIP85ynAXQgzbnw6qJz9Pzc1T586iI24ZeVF1Mk869e0d0Iko6NbGKA9
	wjleC95j0p9M9ku2uDrOJE3/fC/Qz81PMbqW9X2Pn7iqEg77D5c2muSk+XlKOCNgG5na005TUFb
	uovVhnJ6Fmxu057yUfz4eh/W756wuZlF7fzVunKVJ6iNrbpHo63mzt+zkmFi4
X-Google-Smtp-Source: AGHT+IFMAHTIo6gq2vgQOE2W9j3Vmy1Q1uVAVtWa0rCwQarY/N+RXzK+L9GEmfINLOLrpw1mwFf/4Q==
X-Received: by 2002:a05:6a00:3e16:b0:736:53ce:a32c with SMTP id d2e1a72fcca58-742a98a252cmr7960213b3a.17.1747479778348;
        Sat, 17 May 2025 04:02:58 -0700 (PDT)
Received: from 172-126-48-156.lightspeed.nsvltn.sbcglobal.net (103-209-254-246.mel.as140952.net. [103.209.254.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a242asm2942237b3a.164.2025.05.17.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 04:02:57 -0700 (PDT)
Date: Sat, 17 May 2025 19:02:49 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 4/6] ublk: register buffer to local io_uring with
 provided buf index via UBLK_F_AUTO_BUF_REG
Message-ID: <aChs2ayEiGa43W_3@172-126-48-156.lightspeed.nsvltn.sbcglobal.net>
References: <20250509150611.3395206-1-ming.lei@redhat.com>
 <20250509150611.3395206-5-ming.lei@redhat.com>
 <CADUfDZqbwsXCqiR0gxPEpcdt+QeBiybmk4HU_Yv=_VFr_ohKFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqbwsXCqiR0gxPEpcdt+QeBiybmk4HU_Yv=_VFr_ohKFg@mail.gmail.com>

On Tue, May 13, 2025 at 12:50:04PM -0700, Caleb Sander Mateos wrote:
> On Fri, May 9, 2025 at 8:06 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add UBLK_F_AUTO_BUF_REG for supporting to register buffer automatically
> > to local io_uring context with provided buffer index.
> >
> > Add UAPI structure `struct ublk_auto_buf_reg` for holding user parameter
> > to register request buffer automatically, one 'flags' field is defined, and
> > there is still 32bit available for future extension, such as, adding one
> > io_ring FD field for registering buffer to external io_uring.
> >
> > `struct ublk_auto_buf_reg` is populated from ublk uring_cmd's sqe->addr,
> > and all existing ublk commands are data-less, so it is just fine to reuse
> > sqe->addr for this purpose.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 71 +++++++++++++++++++++++----
> >  include/uapi/linux/ublk_cmd.h | 90 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 151 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 1f98e561dc38..17c41a7fa870 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -66,7 +66,8 @@
> >                 | UBLK_F_USER_COPY \
> >                 | UBLK_F_ZONED \
> >                 | UBLK_F_USER_RECOVERY_FAIL_IO \
> > -               | UBLK_F_UPDATE_SIZE)
> > +               | UBLK_F_UPDATE_SIZE \
> > +               | UBLK_F_AUTO_BUF_REG)
> >
> >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > @@ -80,6 +81,9 @@
> >
> >  struct ublk_rq_data {
> >         refcount_t ref;
> > +
> > +       /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
> > +       unsigned short buf_index;
> 
> Can you use a fixed-size integer, i.e. u16?

OK.

> 
> >  };
> >
> >  struct ublk_uring_cmd_pdu {
> > @@ -101,6 +105,9 @@ struct ublk_uring_cmd_pdu {
> >          * setup in ublk uring_cmd handler
> >          */
> >         struct ublk_queue *ubq;
> > +
> > +       struct ublk_auto_buf_reg buf;
> > +
> >         u16 tag;
> >  };
> >
> > @@ -630,7 +637,7 @@ static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
> >
> >  static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
> >  {
> > -       return false;
> > +       return ubq->flags & UBLK_F_AUTO_BUF_REG;
> >  }
> >
> >  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
> > @@ -1175,20 +1182,38 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
> >                 blk_mq_end_request(rq, BLK_STS_IOERR);
> >  }
> >
> > +static void ublk_auto_buf_reg_fallback(struct request *req, struct ublk_io *io,
> > +                                      unsigned int issue_flags)
> > +{
> > +       const struct ublk_queue *ubq = req->mq_hctx->driver_data;
> 
> It would be nice to pass ubq into ublk_auto_buf_reg() and
> ublk_auto_buf_reg_fallback() so it doesn't need to be looked up again.

ublk_auto_buf_reg_fallback() is called in case of auto-buff-reg failure,
also the only caller doesn't use 'ubq', so I think it is fine to retrieve
`ubq` from `req->mq_hctx`.

> 
> > +       struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
> > +       struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> > +
> > +       iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
> > +       refcount_set(&data->ref, 1);
> > +       ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
> 
> Can this just return true from ublk_auto_buf_reg() in this case? Then
> ublk_dispatch_req() will call ublk_complete_io_cmd(), as normal.

OK.

> 
> > +}
> > +
> >  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
> >                               unsigned int issue_flags)
> >  {
> > +       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
> >         struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> >         int ret;
> >
> > -       ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release, 0,
> > -                                     issue_flags);
> > +       ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release,
> > +                                     pdu->buf.index, issue_flags);
> 
> Hmm, I find it a bit awkward to add this code in one commit with the
> wrong arguments and fix it up in a separate commit. I think it would
> make more sense to combine the commits. If you feel the commit is too
> large, I think it would make more sense to split out
> UBLK_AUTO_BUF_REG_FALLBACK to a separate commit. But up to you.

This way is used often for splitting big patches into small pieces:

- patch 3 focuses on generic change

- patch 4 focuses on uapi interface

I'd suggest to keep this way for reviewing easily.

> 
> >         if (ret) {
> > -               blk_mq_end_request(req, BLK_STS_IOERR);
> > +               if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK)
> > +                       ublk_auto_buf_reg_fallback(req, io, issue_flags);
> > +               else
> > +                       blk_mq_end_request(req, BLK_STS_IOERR);
> >                 return false;
> >         }
> >         /* one extra reference is dropped by ublk_io_release */
> >         refcount_set(&data->ref, 2);
> > +       /* store buffer index in request payload */
> > +       data->buf_index = pdu->buf.index;
> >         io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
> >         return true;
> >  }
> > @@ -1952,6 +1977,20 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
> >         io_uring_cmd_mark_cancelable(cmd, issue_flags);
> >  }
> >
> > +static inline bool ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
> > +{
> > +       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > +
> > +       pdu->buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
> > +
> > +       if (pdu->buf.reserved0 || pdu->buf.reserved1)
> > +               return false;
> > +
> > +       if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
> > +               return false;
> > +       return true;
> > +}
> > +
> >  static void ublk_io_release(void *priv)
> >  {
> >         struct request *rq = priv;
> > @@ -2041,9 +2080,13 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> >         return ret;
> >  }
> >
> > -static void ublk_auto_buf_unreg(struct ublk_io *io, unsigned int issue_flags)
> > +static void ublk_auto_buf_unreg(struct ublk_io *io, struct request *req,
> > +                               unsigned int issue_flags)
> >  {
> > -       WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, 0, issue_flags));
> > +       struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> > +
> > +       WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, data->buf_index,
> > +                               issue_flags));
> >         io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
> >  }
> >
> > @@ -2080,7 +2123,7 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
> >                 req->__sector = ub_cmd->zone_append_lba;
> >
> >         if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> > -               ublk_auto_buf_unreg(io, issue_flags);
> > +               ublk_auto_buf_unreg(io, req, issue_flags);
> >
> >         if (likely(!blk_should_fake_timeout(req->q)))
> >                 ublk_put_req_ref(ubq, req);
> > @@ -2196,6 +2239,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> >         default:
> >                 goto out;
> >         }
> > +
> > +       if (ublk_support_auto_buf_reg(ubq) && !ublk_set_auto_buf_reg(cmd))
> > +               return -EINVAL;
> 
> Don't we want to check for this error condition first, before making
> this ublk I/O available for incoming requests? Otherwise,
> ublk_dispatch_req() may be called on this command with an invalid
> pdu->buf.

No, the provided uapi parameter is only used for fetching new IO request,
so we have to use the saved parameter for registering buffer automatically
first, then store the new parameter for doing it when new io request comes.

I will document this kind of usage.

> 
> > +
> >         ublk_prep_cancel(cmd, issue_flags, ubq, tag);
> >         return -EIOCBQUEUED;
> >
> > @@ -2806,8 +2853,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
> >                  * For USER_COPY, we depends on userspace to fill request
> >                  * buffer by pwrite() to ublk char device, which can't be
> >                  * used for unprivileged device
> > +                *
> > +                * Same with zero copy or auto buffer register.
> >                  */
> > -               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY))
> > +               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
> > +                                       UBLK_F_AUTO_BUF_REG))
> >                         return -EINVAL;
> >         }
> >
> > @@ -2865,7 +2915,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
> >                 UBLK_F_URING_CMD_COMP_IN_TASK;
> >
> >         /* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
> > -       if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY))
> > +       if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
> > +                               UBLK_F_AUTO_BUF_REG))
> >                 ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
> 
> Does this logic also need to be updated to allow UBLK_F_AUTO_BUF_REG
> for zoned ublk devices?

This patch switches to use sqe->addr for passing `ublk_auto_buf_reg`, so
ublk zoned isn't affected.

> 
> /*
>  * Zoned storage support requires reuse `ublksrv_io_cmd->addr` for
>  * returning write_append_lba, which is only allowed in case of
>  * user copy or zero copy
>  */
> if (ublk_dev_is_zoned(ub) &&
>     (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !(ub->dev_info.flags &
>      (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)))) {
>         ret = -EINVAL;
>         goto out_free_dev_number;
> }
> 
> >
> >         /*
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> > index be5c6c6b16e0..ecd7ab8c00ca 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -219,6 +219,29 @@
> >   */
> >  #define UBLK_F_UPDATE_SIZE              (1ULL << 10)
> >
> > +/*
> > + * request buffer is registered automatically to uring_cmd's io_uring
> > + * context before delivering this io command to ublk server, meantime
> > + * it is un-registered automatically when completing this io command.
> > + *
> > + * For using this feature:
> > + *
> > + * - ublk server has to create sparse buffer table
> > + *
> > + * - ublk server passes auto buf register data via uring_cmd's sqe->addr,
> > + *   `struct ublk_auto_buf_reg` is populated from sqe->addr, please see
> > + *   the definition of ublk_sqe_addr_to_auto_buf_reg()
> > + *
> > + * - pass buffer index from `ublk_auto_buf_reg.index`
> > + *
> > + * - pass flags from `ublk_auto_buf_reg.flags` if needed
> > + *
> > + * This way avoids extra cost from two uring_cmd, but also simplifies backend
> > + * implementation, such as, the dependency on IO_REGISTER_IO_BUF and
> > + * IO_UNREGISTER_IO_BUF becomes not necessary.
> > + */
> > +#define UBLK_F_AUTO_BUF_REG    (1ULL << 11)
> > +
> >  /* device state */
> >  #define UBLK_S_DEV_DEAD        0
> >  #define UBLK_S_DEV_LIVE        1
> > @@ -305,6 +328,17 @@ struct ublksrv_ctrl_dev_info {
> >  #define                UBLK_IO_F_FUA                   (1U << 13)
> >  #define                UBLK_IO_F_NOUNMAP               (1U << 15)
> >  #define                UBLK_IO_F_SWAP                  (1U << 16)
> > +/*
> > + * For UBLK_F_AUTO_BUF_REG & UBLK_AUTO_BUF_REG_FALLBACK only.
> > + *
> > + * This flag is set if auto buffer register is failed & ublk server passes
> > + * UBLK_AUTO_BUF_REG_FALLBACK, and ublk server need to register buffer
> > + * manually for handling the delivered IO command if this flag is observed
> > + *
> > + * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
> > + * passed in.
> > + */
> > +#define                UBLK_IO_F_NEED_REG_BUF          (1U << 17)
> >
> >  /*
> >   * io cmd is described by this structure, and stored in share memory, indexed
> > @@ -339,6 +373,62 @@ static inline __u32 ublksrv_get_flags(const struct ublksrv_io_desc *iod)
> >         return iod->op_flags >> 8;
> >  }
> >
> > +/*
> > + * If this flag is set, fallback by completing the uring_cmd and setting
> > + * `UBLK_IO_F_NEED_REG_BUF` in case of auto-buf-register failure;
> > + * otherwise the client ublk request is failed silently
> > + *
> > + * If ublk server passes this flag, it has to check if UBLK_IO_F_NEED_REG_BUF
> > + * is set in `ublksrv_io_desc.op_flags`. If UBLK_IO_F_NEED_REG_BUF is set,
> > + * ublk server needs to register io buffer manually for handling IO command.
> > + */
> > +#define UBLK_AUTO_BUF_REG_FALLBACK     (1 << 0)
> > +#define UBLK_AUTO_BUF_REG_F_MASK       UBLK_AUTO_BUF_REG_FALLBACK
> > +
> > +struct ublk_auto_buf_reg {
> > +       /* index for registering the delivered request buffer */
> > +       __u16  index;
> > +       __u8   flags;
> > +       __u8   reserved0;
> > +
> > +       /*
> > +        * io_ring FD can be passed via the reserve field in future for
> > +        * supporting to register io buffer to external io_uring
> > +        */
> > +       __u32  reserved1;
> > +};
> > +
> > +/*
> > + * For UBLK_F_AUTO_BUF_REG, auto buffer register data is carried via
> > + * uring_cmd's sqe->addr:
> > + *
> > + *     - bit0 ~ bit15: buffer index
> > + *     - bit16 ~ bit23: flags
> > + *     - bit24 ~ bit31: reserved0
> > + *     - bit32 ~ bit63: reserved1
> > + */
> > +static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg(
> > +               __u64 sqe_addr)
> > +{
> > +       struct ublk_auto_buf_reg reg = {
> > +               .index = sqe_addr & 0xffff,
> > +               .flags = (sqe_addr >> 16) & 0xff,
> > +               .reserved0 = (sqe_addr >> 24) & 0xff,
> > +               .reserved1 = sqe_addr >> 32,
> > +       };
> > +
> > +       return reg;
> > +}
> > +
> > +static inline __u64
> > +ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)
> 
> Pass by value since it's only 8 bytes?

Yes, and we can add build check.

> 
> > +{
> > +       __u64 addr = buf->index | buf->flags << 16 | buf->reserved0 << 24 |
> > +               (__u64)buf->reserved1 << 32;
> > +
> > +       return addr;
> > +}
> 
> How about just memcpy()ing between u64 and struct ublk_auto_buf_reg?
> If you do want to keep these explicit conversions, you could at least
> omit the unnecessary masking in ublk_sqe_addr_to_auto_buf_reg().

memcpy is one global function, which is slower.

> > +static inline __u64
> > +ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)
> > +{
> > +       __u64 addr = buf->index | buf->flags << 16 | buf->reserved0 << 24 |
>
> buf->reserved0 should be cast to a u64 (or u32) here. Otherwise,
> buf->reserved0 << 24 gets promoted to an int and sign-extended to 64
> bits. It would probably be good to cast the other fields too to avoid
> assuming a 32-bit int.

OK.

Thanks,
Ming
