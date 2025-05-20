Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADD1A83FB
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747762834; cv=none; b=Mw+eHQAUn2cc3EMgEpJFoIBKJ48rasK8kS8d2iD6uZgUjhFcyWEhkQwOLZmmDP9giKfwkmRjPlHs5WxSiFHPrPsK0oITKENufFKWTjhOgBegouVE3JWb9QSgLoKVCz2/yXGxwOwreMGLTfvAnOG3M8rg1DQ5K4WDUquPnQAtiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747762834; c=relaxed/simple;
	bh=k3H9AUJ72Lus8LCTYSIAUDR7YRQ1v0AaVAtRMb/Ls4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EowIiN6UyjDi6q2Su4eq+7u8jfzNbs36I8g8PQHPC7NLpxGr0hjCjRmSlOkdV5JQO5Gb6NVI7Jc9KGNrccCo+MVyKwwBruSXDUecSX1t6kmexBr9C22UGfQfmuGByDorkeQh60v+/+4RQnOp3wAil9yCyaDMDOZlPoFjz61yo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DcRUfu6m; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DcRUfu6m"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b26ed340399so507335a12.2
        for <linux-block@vger.kernel.org>; Tue, 20 May 2025 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747762831; x=1748367631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPYaR0maQHO3Pv2N4OM4a3GAcunsa5piS7JrcvXj6mA=;
        b=DcRUfu6mTUCtuywGtNvtIkqaf/gL/H/7v1qxbrL6oniovXy6nV8u9kf2/6+0/g6HR6
         mENFS5yunMTP7jgfiKn9xOxwcFBpH2aHedNwsn+NkK4PMqeMmQgyR/mG5FJhGUHPX2+t
         2+duueTTu+Q4Xs6J4jHonc4tizfy1/rBDBPJDXvy0mMXjtNiPLMBto6x5RLnqhhpEp3+
         6hS53h0DL8pT0ESOCU6NJP9uppts1LTYTaZ9mavpwVQz/2FirBjjBaGGq9wiJtfNQ992
         myIWwvEdRmP8dUWpr+wy3Cwm/AGxytm6v6dnCpSbAwyOc+dRqBChKBH/qmS8yigMpDVT
         6nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747762831; x=1748367631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPYaR0maQHO3Pv2N4OM4a3GAcunsa5piS7JrcvXj6mA=;
        b=SzqZS0HyqJ5Z57ZEKhnoiCDq9f0SjGHQPJIiB3AdcnAX7A/8qHcDYr7ak9e7Ef3DPi
         Nsrbd8rCszIOYEaHoRbUi+k9CSc1RrgB2MRwBCujx5jwQZOPdpZFwlt8mAMPtINMMquT
         +Onj+O4GhSlfwUO77E3Y+aDxMdBW13VQCR689L3V4MVYHyxX9SBwm/PpnbI2HQTKmEbp
         2b62eUAMpNe5qzraXCDKbUMXDepjhd0LQv7GQI4frTHVGZp0sO4VZlFnOqcd3tYgg2f7
         eKVpmxwjR5kw4DlZ74ohauyairvKq1krvNngTa/7Tc6wElcyrOmHyYXS/xGoipxGJjQU
         ablQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQCP90n+FCP+pizq5sJcxZ/RrEUc8vAq4Xa4j+rZKbea61uA/1QTZ2ccLhl2etngLS5SKja3T9zWEhrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsytj3t4M+m3Dii3TDD7bcC+AnK9r5FKxlq7G9S++QnsK6VFU
	/8SiVETnl+V6FQR3LHXIE02hA7FOGaH7knqnTvRQyIv7a3IXseSHxfanYd2RkbABJa0q5IndYPc
	gimTErtxXtGuct74txnmRT6Hcg8fCfhTUpWxtUxPx0Q==
X-Gm-Gg: ASbGncuEauhJBINj5+8g1y/6r1EYmsce39+GKDVDFIsn/LGYfFqEBu+ixe6Ko0xzt8+
	sZ+LtR9vAZ5UtuSzKYGSrLb9ib4fewE6YpG95dCXWtZCFUoNEnD3n5XoEI2DVyRt8l6CBSvUUkS
	gaNusQnX1hcyj/2eBbYZ2lNH/0ecSNz7wgmPlyI+rZbg==
X-Google-Smtp-Source: AGHT+IH3VR7DhHitPbJD7fWuQ2QlXGKzkDkAvLU+OHcgUNfCqym+ma7dT05SMN1cCv9J0i04NdU5BB1k26aGpzweXnw=
X-Received: by 2002:a17:902:eccd:b0:215:435d:b41a with SMTP id
 d9443c01a7336-231d438931fmr90034795ad.1.1747762830949; Tue, 20 May 2025
 10:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520045455.515691-1-ming.lei@redhat.com> <20250520045455.515691-4-ming.lei@redhat.com>
In-Reply-To: <20250520045455.515691-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 20 May 2025 10:40:19 -0700
X-Gm-Features: AX0GCFtT8LLDWIl6mRWzcr1VSlbLM7yKswbmA4NfJmgCoX-Vh5PruvhwGFB2hxo
Message-ID: <CADUfDZrGh7696U3DME3SujvHUR9dy+pQ-csRWNBqNMP+hS_BNg@mail.gmail.com>
Subject: Re: [PATCH V5 3/6] ublk: register buffer to local io_uring with
 provided buf index via UBLK_F_AUTO_BUF_REG
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 9:55=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
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
>  drivers/block/ublk_drv.c      | 56 ++++++++++++++++++++++++++----
>  include/uapi/linux/ublk_cmd.h | 64 +++++++++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3e56a9d267fb..1aabc655652b 100644
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
> +       u16 buf_index;
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
> @@ -1178,17 +1185,20 @@ static inline void __ublk_abort_rq(struct ublk_qu=
eue *ubq,
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
>                 blk_mq_end_request(req, BLK_STS_IOERR);
>                 return false;
>         }
>         /* one extra reference is dropped by ublk_io_release */
>         refcount_set(&data->ref, 2);
> +       /* store buffer index in request payload */
> +       data->buf_index =3D pdu->buf.index;
>         io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
>         return true;
>  }
> @@ -1952,6 +1962,18 @@ static inline void ublk_prep_cancel(struct io_urin=
g_cmd *cmd,
>         io_uring_cmd_mark_cancelable(cmd, issue_flags);
>  }
>
> +static inline int ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
> +{
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> +
> +       pdu->buf =3D ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->ad=
dr));
> +
> +       if (pdu->buf.reserved0 || pdu->buf.reserved1)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  static void ublk_io_release(void *priv)
>  {
>         struct request *rq =3D priv;
> @@ -2034,6 +2056,12 @@ static int ublk_fetch(struct io_uring_cmd *cmd, st=
ruct ublk_queue *ubq,
>                 goto out;
>         }
>
> +       if (ublk_support_auto_buf_reg(ubq)) {
> +               ret =3D ublk_set_auto_buf_reg(cmd);
> +               if (ret)
> +                       return ret;

This should be goto out; to ensure the ub->mutex is released.
Otherwise, this looks good to me.

> +       }
> +
>         ublk_fill_io_cmd(io, cmd, buf_addr);
>         ublk_mark_io_ready(ub, ubq);
>  out:
> @@ -2065,11 +2093,20 @@ static int ublk_commit_and_fetch(const struct ubl=
k_queue *ubq,
>         }
>
>         if (ublk_support_auto_buf_reg(ubq)) {
> +               int ret;
> +
>                 if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> -                       WARN_ON_ONCE(io_buffer_unregister_bvec(cmd, 0,
> +                       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(re=
q);
> +
> +                       WARN_ON_ONCE(io_buffer_unregister_bvec(cmd,
> +                                               data->buf_index,
>                                                 issue_flags));
>                         io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
>                 }
> +
> +               ret =3D ublk_set_auto_buf_reg(cmd);
> +               if (ret)
> +                       return ret;
>         }
>
>         ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> @@ -2791,8 +2828,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_=
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
> @@ -2850,7 +2890,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_c=
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
> @@ -3377,6 +3418,7 @@ static int __init ublk_init(void)
>
>         BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
>                         UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET=
);
> +       BUILD_BUG_ON(sizeof(struct ublk_auto_buf_reg) !=3D 8);
>
>         init_waitqueue_head(&ublk_idr_wq);
>
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index be5c6c6b16e0..f6f516b1223b 100644
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
> + * - all reserved fields in `ublk_auto_buf_reg` need to be zeroed
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
> @@ -339,6 +362,47 @@ static inline __u32 ublksrv_get_flags(const struct u=
blksrv_io_desc *iod)
>         return iod->op_flags >> 8;
>  }
>
> +struct ublk_auto_buf_reg {
> +       /* index for registering the delivered request buffer */
> +       __u16  index;
> +       __u16   reserved0;

nit: alignment

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
> + *     - bit24 ~ bit31: reserved0

"bit24" should be "bit16" here. It would change to "bit24" in the next
patch adding UBLK_AUTO_BUF_REG_FALLBACK.

> + *     - bit32 ~ bit63: reserved1
> + */
> +static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg(
> +               __u64 sqe_addr)
> +{
> +       struct ublk_auto_buf_reg reg =3D {
> +               .index =3D sqe_addr & 0xffff,
> +               .reserved0 =3D (sqe_addr >> 16) & 0xffff,

I think I suggested this before, but the masking with 0xffff is unnecessary=
.

Best,
Caleb

> +               .reserved1 =3D sqe_addr >> 32,
> +       };
> +
> +       return reg;
> +}
> +
> +static inline __u64
> +ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)
> +{
> +       __u64 addr =3D buf->index | (__u64)buf->reserved0 << 16 |
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
