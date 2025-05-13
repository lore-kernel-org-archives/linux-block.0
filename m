Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844A2BFC6B
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165820; cv=none; b=iJK6E3t7nKUeiycm5hBRUsQa0XljKmLWhRqH0KDDUOGxxwzGX18/gTNswvT24d0yjTeJAy9ne32fE1DrX69sKgGcmKKcs5Elo0FwgTr9M+gL+Bp5laM+i/NPSb/88NFvZ1IOgaDkw7QwfUiBsKbK5ead4Xn13hPQV7wt9MnhYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165820; c=relaxed/simple;
	bh=IK7IjRXTOeJfprvQgg3frSuQgjcPR7WvKAfe3HpajZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgGmXZ6ho7gdZV8fchdvm+cT9K06yhclY4PmKgVssu+zG7DDWtA31QUvSUR15HZVS1YgiM/V2nX6nUMGgdw+APYRk85t9TFTy+P5WuKmtd8CK8lzNbs4iLoURl7xXEBJojuv4FsAnuIfIpTCu0A0uF12yanryGqheQYPlU7hRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FQqtzyh7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FQqtzyh7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e53c8b816so6942765ad.3
        for <linux-block@vger.kernel.org>; Tue, 13 May 2025 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747165816; x=1747770616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44c+++aEp5c5uagRWSyuBY2gmLHzpbm5oJJV+RBGdDI=;
        b=FQqtzyh7AZS3byx70F4uzw9MWR1w3RfACFdYMtBUnRBs/WsLDUTYAb97+F2E+R7MCI
         450Mbj4P0az2wms9Z6pD3Og3AuCdLvXHu7Rh9qr9wVPhHO8u+gsqutCTq23FkIW0lMNe
         rT4L0yCV5gjdle8D7PKLvRIkA2w8G10I6MWhNJi+879z+K1TsTFyxatvtNDqW0MZh/z/
         dNe9KK6YpIRyOfWZnVCrNfmbVgFkt/gGB1rlVqOsJOFTbY1MM/V85hq7FAEV8FMwdpwT
         Wj1BylXrjKc+oMdK4aT8RvCIfYDb3N+dhIt8TqYgW5JHxIJAjDc+Q9rfZk9/4lL8aSwi
         jAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165816; x=1747770616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44c+++aEp5c5uagRWSyuBY2gmLHzpbm5oJJV+RBGdDI=;
        b=B0j0MrEiMvnUkmcdrkwcKTSkCoeXznlbo+fGq8Z2uJMeB/N6xqLlexOsuvzTHFwny3
         tTeP1dhf4FC+R2iRTnQXZ85gk5AwatEz+OFeUAytABjKZ9vhfQHMXYMliYU58LJ5M8LD
         IYwYkdAu1Lvdu6DKb2udy2jZNIFA/7EMFVU7SwgfV8VT6FcRTf9c+MrasjvSlF6HTu1y
         w1xhwTczAETumP5nCm2sSEy07rb+90xUDpgmVn1lYFkWv278w8kzFd6VTYpMuMuqRITW
         h3d2wR4TK3Ih+A0Z+obAwWilfcKDX67bTbmu/CRqDWw9LJQ3aQsj/wQVeyyv7l7nstNT
         fJcA==
X-Forwarded-Encrypted: i=1; AJvYcCUNUNYtO7EBDFx3qlVkJSeZF3ktb7iNwyaesqtormQzlONqoajn9S/gf9KBzbEbS61tEqR2VjAtG1XLkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ArXStUNXXMwHlYWtPbZGhwUEoPKaFSbhC0YCxOdLwMRImrPD
	MLapqyO91ukFsUJ30JitIQ9X+QIqHGx6JSbvfs5sZzjsdIXnBabUEE7iS5rRIlfGzMvoMXGwdcU
	gwvmAyCRx2uM5BFOyqPG1f+3QXzAm2hNMJik9GA==
X-Gm-Gg: ASbGnctduG9YYhMSMnkI1zalo4lOo3ctLAyuUZPC4xa0oTUnttWy0aJyAN2axTInOgs
	9ghZ9wRnkwnPDMjWr9jt/J/8RhFq4yCEHLSelKGH6OOmaPuVIg1/1WtT/5GEQS3OS1CB2qhbJTp
	XCHhEG1O20FOBftRkTiNw4QJikkpZZZaA=
X-Google-Smtp-Source: AGHT+IETwTA9nbm4c3g6qBBfqyT4pi5g4lScVm76VMAhuhcEA3CDecEQhLL8bMyVHlJUx0swl7fduZY+HnWdAXjFjXM=
X-Received: by 2002:a17:903:1984:b0:231:7fbc:19c9 with SMTP id
 d9443c01a7336-2319810ea4cmr4049795ad.1.1747165815760; Tue, 13 May 2025
 12:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509150611.3395206-1-ming.lei@redhat.com> <20250509150611.3395206-5-ming.lei@redhat.com>
In-Reply-To: <20250509150611.3395206-5-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 13 May 2025 12:50:04 -0700
X-Gm-Features: AX0GCFs7xUiX2PKmVLjUHo_KZr-olNsCDYayjpzN4BRt2movUsa_OqnUROsoVXI
Message-ID: <CADUfDZqbwsXCqiR0gxPEpcdt+QeBiybmk4HU_Yv=_VFr_ohKFg@mail.gmail.com>
Subject: Re: [PATCH V3 4/6] ublk: register buffer to local io_uring with
 provided buf index via UBLK_F_AUTO_BUF_REG
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 8:06=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add UBLK_F_AUTO_BUF_REG for supporting to register buffer automatically
> to local io_uring context with provided buffer index.
>
> Add UAPI structure `struct ublk_auto_buf_reg` for holding user parameter
> to register request buffer automatically, one 'flags' field is defined, a=
nd
> there is still 32bit available for future extension, such as, adding one
> io_ring FD field for registering buffer to external io_uring.
>
> `struct ublk_auto_buf_reg` is populated from ublk uring_cmd's sqe->addr,
> and all existing ublk commands are data-less, so it is just fine to reuse
> sqe->addr for this purpose.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 71 +++++++++++++++++++++++----
>  include/uapi/linux/ublk_cmd.h | 90 +++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1f98e561dc38..17c41a7fa870 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -66,7 +66,8 @@
>                 | UBLK_F_USER_COPY \
>                 | UBLK_F_ZONED \
>                 | UBLK_F_USER_RECOVERY_FAIL_IO \
> -               | UBLK_F_UPDATE_SIZE)
> +               | UBLK_F_UPDATE_SIZE \
> +               | UBLK_F_AUTO_BUF_REG)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -80,6 +81,9 @@
>
>  struct ublk_rq_data {
>         refcount_t ref;
> +
> +       /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
> +       unsigned short buf_index;

Can you use a fixed-size integer, i.e. u16?

>  };
>
>  struct ublk_uring_cmd_pdu {
> @@ -101,6 +105,9 @@ struct ublk_uring_cmd_pdu {
>          * setup in ublk uring_cmd handler
>          */
>         struct ublk_queue *ubq;
> +
> +       struct ublk_auto_buf_reg buf;
> +
>         u16 tag;
>  };
>
> @@ -630,7 +637,7 @@ static inline bool ublk_support_zero_copy(const struc=
t ublk_queue *ubq)
>
>  static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ub=
q)
>  {
> -       return false;
> +       return ubq->flags & UBLK_F_AUTO_BUF_REG;
>  }
>
>  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
> @@ -1175,20 +1182,38 @@ static inline void __ublk_abort_rq(struct ublk_qu=
eue *ubq,
>                 blk_mq_end_request(rq, BLK_STS_IOERR);
>  }
>
> +static void ublk_auto_buf_reg_fallback(struct request *req, struct ublk_=
io *io,
> +                                      unsigned int issue_flags)
> +{
> +       const struct ublk_queue *ubq =3D req->mq_hctx->driver_data;

It would be nice to pass ubq into ublk_auto_buf_reg() and
ublk_auto_buf_reg_fallback() so it doesn't need to be looked up again.

> +       struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
> +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> +
> +       iod->op_flags |=3D UBLK_IO_F_NEED_REG_BUF;
> +       refcount_set(&data->ref, 1);
> +       ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);

Can this just return true from ublk_auto_buf_reg() in this case? Then
ublk_dispatch_req() will call ublk_complete_io_cmd(), as normal.

> +}
> +
>  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
>                               unsigned int issue_flags)
>  {
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(io->cmd=
);
>         struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
>         int ret;
>
> -       ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io_release, 0,
> -                                     issue_flags);
> +       ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io_release,
> +                                     pdu->buf.index, issue_flags);

Hmm, I find it a bit awkward to add this code in one commit with the
wrong arguments and fix it up in a separate commit. I think it would
make more sense to combine the commits. If you feel the commit is too
large, I think it would make more sense to split out
UBLK_AUTO_BUF_REG_FALLBACK to a separate commit. But up to you.

>         if (ret) {
> -               blk_mq_end_request(req, BLK_STS_IOERR);
> +               if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK)
> +                       ublk_auto_buf_reg_fallback(req, io, issue_flags);
> +               else
> +                       blk_mq_end_request(req, BLK_STS_IOERR);
>                 return false;
>         }
>         /* one extra reference is dropped by ublk_io_release */
>         refcount_set(&data->ref, 2);
> +       /* store buffer index in request payload */
> +       data->buf_index =3D pdu->buf.index;
>         io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
>         return true;
>  }
> @@ -1952,6 +1977,20 @@ static inline void ublk_prep_cancel(struct io_urin=
g_cmd *cmd,
>         io_uring_cmd_mark_cancelable(cmd, issue_flags);
>  }
>
> +static inline bool ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
> +{
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> +
> +       pdu->buf =3D ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->ad=
dr));
> +
> +       if (pdu->buf.reserved0 || pdu->buf.reserved1)
> +               return false;
> +
> +       if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
> +               return false;
> +       return true;
> +}
> +
>  static void ublk_io_release(void *priv)
>  {
>         struct request *rq =3D priv;
> @@ -2041,9 +2080,13 @@ static int ublk_fetch(struct io_uring_cmd *cmd, st=
ruct ublk_queue *ubq,
>         return ret;
>  }
>
> -static void ublk_auto_buf_unreg(struct ublk_io *io, unsigned int issue_f=
lags)
> +static void ublk_auto_buf_unreg(struct ublk_io *io, struct request *req,
> +                               unsigned int issue_flags)
>  {
> -       WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, 0, issue_flags));
> +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> +
> +       WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, data->buf_index,
> +                               issue_flags));
>         io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
>  }
>
> @@ -2080,7 +2123,7 @@ static int ublk_commit_and_fetch(const struct ublk_=
queue *ubq,
>                 req->__sector =3D ub_cmd->zone_append_lba;
>
>         if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> -               ublk_auto_buf_unreg(io, issue_flags);
> +               ublk_auto_buf_unreg(io, req, issue_flags);
>
>         if (likely(!blk_should_fake_timeout(req->q)))
>                 ublk_put_req_ref(ubq, req);
> @@ -2196,6 +2239,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
>         default:
>                 goto out;
>         }
> +
> +       if (ublk_support_auto_buf_reg(ubq) && !ublk_set_auto_buf_reg(cmd)=
)
> +               return -EINVAL;

Don't we want to check for this error condition first, before making
this ublk I/O available for incoming requests? Otherwise,
ublk_dispatch_req() may be called on this command with an invalid
pdu->buf.

> +
>         ublk_prep_cancel(cmd, issue_flags, ubq, tag);
>         return -EIOCBQUEUED;
>
> @@ -2806,8 +2853,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_=
ctrl_cmd *header)
>                  * For USER_COPY, we depends on userspace to fill request
>                  * buffer by pwrite() to ublk char device, which can't be
>                  * used for unprivileged device
> +                *
> +                * Same with zero copy or auto buffer register.
>                  */
> -               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY))
> +               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY |
> +                                       UBLK_F_AUTO_BUF_REG))
>                         return -EINVAL;
>         }
>
> @@ -2865,7 +2915,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_c=
trl_cmd *header)
>                 UBLK_F_URING_CMD_COMP_IN_TASK;
>
>         /* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
> -       if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY))
> +       if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY |
> +                               UBLK_F_AUTO_BUF_REG))
>                 ub->dev_info.flags &=3D ~UBLK_F_NEED_GET_DATA;

Does this logic also need to be updated to allow UBLK_F_AUTO_BUF_REG
for zoned ublk devices?

/*
 * Zoned storage support requires reuse `ublksrv_io_cmd->addr` for
 * returning write_append_lba, which is only allowed in case of
 * user copy or zero copy
 */
if (ublk_dev_is_zoned(ub) &&
    (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !(ub->dev_info.flags &
     (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)))) {
        ret =3D -EINVAL;
        goto out_free_dev_number;
}

>
>         /*
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index be5c6c6b16e0..ecd7ab8c00ca 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -219,6 +219,29 @@
>   */
>  #define UBLK_F_UPDATE_SIZE              (1ULL << 10)
>
> +/*
> + * request buffer is registered automatically to uring_cmd's io_uring
> + * context before delivering this io command to ublk server, meantime
> + * it is un-registered automatically when completing this io command.
> + *
> + * For using this feature:
> + *
> + * - ublk server has to create sparse buffer table
> + *
> + * - ublk server passes auto buf register data via uring_cmd's sqe->addr=
,
> + *   `struct ublk_auto_buf_reg` is populated from sqe->addr, please see
> + *   the definition of ublk_sqe_addr_to_auto_buf_reg()
> + *
> + * - pass buffer index from `ublk_auto_buf_reg.index`
> + *
> + * - pass flags from `ublk_auto_buf_reg.flags` if needed
> + *
> + * This way avoids extra cost from two uring_cmd, but also simplifies ba=
ckend
> + * implementation, such as, the dependency on IO_REGISTER_IO_BUF and
> + * IO_UNREGISTER_IO_BUF becomes not necessary.
> + */
> +#define UBLK_F_AUTO_BUF_REG    (1ULL << 11)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> @@ -305,6 +328,17 @@ struct ublksrv_ctrl_dev_info {
>  #define                UBLK_IO_F_FUA                   (1U << 13)
>  #define                UBLK_IO_F_NOUNMAP               (1U << 15)
>  #define                UBLK_IO_F_SWAP                  (1U << 16)
> +/*
> + * For UBLK_F_AUTO_BUF_REG & UBLK_AUTO_BUF_REG_FALLBACK only.
> + *
> + * This flag is set if auto buffer register is failed & ublk server pass=
es
> + * UBLK_AUTO_BUF_REG_FALLBACK, and ublk server need to register buffer
> + * manually for handling the delivered IO command if this flag is observ=
ed
> + *
> + * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
> + * passed in.
> + */
> +#define                UBLK_IO_F_NEED_REG_BUF          (1U << 17)
>
>  /*
>   * io cmd is described by this structure, and stored in share memory, in=
dexed
> @@ -339,6 +373,62 @@ static inline __u32 ublksrv_get_flags(const struct u=
blksrv_io_desc *iod)
>         return iod->op_flags >> 8;
>  }
>
> +/*
> + * If this flag is set, fallback by completing the uring_cmd and setting
> + * `UBLK_IO_F_NEED_REG_BUF` in case of auto-buf-register failure;
> + * otherwise the client ublk request is failed silently
> + *
> + * If ublk server passes this flag, it has to check if UBLK_IO_F_NEED_RE=
G_BUF
> + * is set in `ublksrv_io_desc.op_flags`. If UBLK_IO_F_NEED_REG_BUF is se=
t,
> + * ublk server needs to register io buffer manually for handling IO comm=
and.
> + */
> +#define UBLK_AUTO_BUF_REG_FALLBACK     (1 << 0)
> +#define UBLK_AUTO_BUF_REG_F_MASK       UBLK_AUTO_BUF_REG_FALLBACK
> +
> +struct ublk_auto_buf_reg {
> +       /* index for registering the delivered request buffer */
> +       __u16  index;
> +       __u8   flags;
> +       __u8   reserved0;
> +
> +       /*
> +        * io_ring FD can be passed via the reserve field in future for
> +        * supporting to register io buffer to external io_uring
> +        */
> +       __u32  reserved1;
> +};
> +
> +/*
> + * For UBLK_F_AUTO_BUF_REG, auto buffer register data is carried via
> + * uring_cmd's sqe->addr:
> + *
> + *     - bit0 ~ bit15: buffer index
> + *     - bit16 ~ bit23: flags
> + *     - bit24 ~ bit31: reserved0
> + *     - bit32 ~ bit63: reserved1
> + */
> +static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg(
> +               __u64 sqe_addr)
> +{
> +       struct ublk_auto_buf_reg reg =3D {
> +               .index =3D sqe_addr & 0xffff,
> +               .flags =3D (sqe_addr >> 16) & 0xff,
> +               .reserved0 =3D (sqe_addr >> 24) & 0xff,
> +               .reserved1 =3D sqe_addr >> 32,
> +       };
> +
> +       return reg;
> +}
> +
> +static inline __u64
> +ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)

Pass by value since it's only 8 bytes?

> +{
> +       __u64 addr =3D buf->index | buf->flags << 16 | buf->reserved0 << =
24 |
> +               (__u64)buf->reserved1 << 32;
> +
> +       return addr;
> +}

How about just memcpy()ing between u64 and struct ublk_auto_buf_reg?
If you do want to keep these explicit conversions, you could at least
omit the unnecessary masking in ublk_sqe_addr_to_auto_buf_reg().

Best,
Caleb


> +
>  /* issued to ublk driver via /dev/ublkcN */
>  struct ublksrv_io_cmd {
>         __u16   q_id;
> --
> 2.47.0
>
