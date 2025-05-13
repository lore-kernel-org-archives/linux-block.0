Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787DB1E51F5
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747166110; cv=none; b=PUY6YLwvS/JozmHsVeRGO2LSadidUOs3XTIq1/8skuizVNa5Jxky7EchNbez3whN303B9yLr23lb45YFtr1qkVsoroNtwJ2wGts/96stcwAQdOTWtJykq//dkZNxU/CKDvV0NWG5s3xEXt5+pYUs75Uy/F2rvcY6c2VbaghZt2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747166110; c=relaxed/simple;
	bh=vRNsSI5K3ncaEN7G8l9ac6eD1MNt+/Agn0gMrWMYAiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4xvzHmWzYnPHP9BN9a2FE1ttuLw1HDgi53lCPKHiP9t6bj/r1/h71HRzTXgWfXKPQqAFkTB8PDFG3kBnMccQR25jy+M2ChCnGLMCmd5f8nISXZ4cKvdW1xRPUeHfFVzg90EHL5wv/L8WNOkkTJBYsG73OpthNXltj+CBPjvXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IgJs/4O7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IgJs/4O7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22e1782cbb2so6952745ad.0
        for <linux-block@vger.kernel.org>; Tue, 13 May 2025 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747166107; x=1747770907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg17gub/dNiSEVxjEQDiEZkA8370s/TDeU04HZJYO4w=;
        b=IgJs/4O7e6fRz8nrw60xVabo4T0kZ0Nf5KVidH3XOOKVxN+NH5MaWGJGsn+JpWZK8R
         nOm+Aavvy5A9RjAiHhRJmlIUPK8ScA9SLYq4k3eIUTJMqp01ZO5SkXHyg/gOiPljQ9tA
         cjjQeqSBxr45Oexo+AcgyPBy/o8i1zKjk9O/ebyP9PklHoz9taIZ2lkv1X50QzJq3Q6o
         O+g4qpcidk+gqv5A6I6fA87+8bYuVt1wkgK7GSEogSAON7pg7UcDMWoG6bz6MomHn8Fp
         FQzltjMJyJLGflPi1YUmnNleaYsL7jcif/CzSegNPkcKvVr/6YuWT2810BV+Wf56CYN6
         gp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747166107; x=1747770907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rg17gub/dNiSEVxjEQDiEZkA8370s/TDeU04HZJYO4w=;
        b=FVM6VHgeTVAcPY7GcTlOtOldRUn3gyrEtigvKQ6F9c5bU9sMNj2c7bkMVMdC+V+chG
         BwVS8Cl+OfQAQVlnp1WjuLqpQPTuIl+4NLkh3BQ933wryXGNY9uOU7Z42sgvahdmeUuo
         AZ8d3uuSCmGx9Zt6V0pi27yt+8eWgu/nY/FKTaHwSC8rlcA2dHHMYU68w5pnuLRa79z9
         XOwERb2HtYO5aMDzr4hc4QD8qlhI4rjj39DskipTVwnGNd4hfSLhVzsii4f+ARpTRmVp
         58XqhyN7t5DOBhdj1vBTtzAIR9sDIgNvSqjoXDnpMBR3E2z8DA4ub7aeiA4Vm3iD4HIx
         NPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Lal0rlAk0qSxjM0/SbX/RaEBe+17DqImYq9nOvRtZzFNqfqRX2gEIbB2X0YiKpn861kdOvUyoHaVSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLytkZTN3GhiJ9z0VVhvFwuOANCF9wlUkbc1dz7gjaRl0x4V8d
	XytwxR6kB4Gt8oSN+gyIhSj7EFjuZVD40bsuYN7+WfZOjOK6gnGDoNS6t3TCrTwuqFqLQ3Z29ZP
	SzBecBW+K6euLK/T/C0nal1fmzFu74RG0Zm4dJw==
X-Gm-Gg: ASbGncsfPt9y1nX3Jddht0YIb5CUTEZUgXp9KAUgkE41jkP3X6x5mcYVZLhB7katjQi
	UKIrPnVy3WgVR46nA4wza7aD1/8Mox1YgJ6PvHA0DB0r8v+Fsu5rUzgjrWZ6upQNJDVZTKjb5cd
	2UNJfFyixU9mtCvAuXkt5jniHU7ZBth44=
X-Google-Smtp-Source: AGHT+IGjTldGLJbT/+DUcxb6Ef7HbIM/0gQw4SAUfrSRs8Ky6CdGXNefAdvPrTjLLTxW5Aq5jcRjtlMGOQt9x0Tw/gg=
X-Received: by 2002:a17:903:41d0:b0:224:1936:698a with SMTP id
 d9443c01a7336-2319812a845mr4262315ad.5.1747166107519; Tue, 13 May 2025
 12:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509150611.3395206-1-ming.lei@redhat.com> <20250509150611.3395206-5-ming.lei@redhat.com>
In-Reply-To: <20250509150611.3395206-5-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 13 May 2025 12:54:55 -0700
X-Gm-Features: AX0GCFtSqueHua7jpc5APLpeQsmgV29mhMnWG1HqqaO_xV79AEt2_TZdpDKAAHo
Message-ID: <CADUfDZqmGPUm6brjD54x9j7M6ngRZoJh44R68610o_H-K7zsiQ@mail.gmail.com>
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
> +       struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
> +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> +
> +       iod->op_flags |=3D UBLK_IO_F_NEED_REG_BUF;
> +       refcount_set(&data->ref, 1);
> +       ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
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
> +{
> +       __u64 addr =3D buf->index | buf->flags << 16 | buf->reserved0 << =
24 |

buf->reserved0 should be cast to a u64 (or u32) here. Otherwise,
buf->reserved0 << 24 gets promoted to an int and sign-extended to 64
bits. It would probably be good to cast the other fields too to avoid
assuming a 32-bit int.

Best,
Caleb

> +               (__u64)buf->reserved1 << 32;
> +
> +       return addr;
> +}
> +
>  /* issued to ublk driver via /dev/ublkcN */
>  struct ublksrv_io_cmd {
>         __u16   q_id;
> --
> 2.47.0
>
