Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3C18DB0D
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764443961; cv=none; b=Q8VDIQa806GWJSGxoiLILjv5aWpeZDre9yuuy1OPQOyJJjD58WrZypZkUODnASesv6nMt7o15WBrdRzAsqYAGxJsa3M9zb7ms3XcB1rlZ8xp/7bnVXsgtIKZhbz+hgJc4zSQGLBULRUczB95Dz/yDpV1hRagZnC0lQA404YcSuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764443961; c=relaxed/simple;
	bh=0XIaWSSbg5QfLlpak7V4yFJmHNHjwqKjDM1XIzeoHXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvmrUNL4DWUuih31vC1JAb5OAjNNhofVaRsMZDpiK/9+KWT7WjwBj5pIq2xiX5TceMWfdQGtARzXFMlkHMtxP8OqXCe1Yv6aifixAS4K1sPE1ZW1h9cs2RHyZtrZB8jf00J5iiIK7RB8FjNr+baigAbO79Z4kfbKM3eWUc+Yq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Jdie+8JS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Jdie+8JS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-343641ceb62so353679a91.1
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 11:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764443958; x=1765048758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6lW1p3B3NleT/BDih956D9+j7/6y6NwWTW1MFy+IBk=;
        b=Jdie+8JSNJruH5npwChZM4LAKlDFU8kPTlThD7MZMKKyHizQnQhWV0bo8VsfONTXzV
         T8ar5dHHuTmjuvBuV6iC0qAVoHjZwfOm5HVWgQeh4ZlxRyZ1wnaLwSbcU5Ptp46ZZthD
         YsQYHfAuSBgli0MORO3f6cEazjkHv7kaWhh7btsYjG2bFE7FvfFzTIh8AuDKGirO7zxE
         QI6YB6ywVPpC7drLOONm7xlXzpNR0hxeniFIgT9YQwqalCtuIBlPXaqtP8/m3poBs4xM
         Z7p/K284dj+38NnvneSicJX/09+ffeRFdsb7xnLXovAMdgSbo3BPUuNvm6u8PA13auju
         2+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764443958; x=1765048758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6lW1p3B3NleT/BDih956D9+j7/6y6NwWTW1MFy+IBk=;
        b=vg8VtPYY+Uj7un29/ktf2iSx3YMeFVhOprRlbz5mQqHXWpEcOSvmBAumdIGX21IbEz
         bVCh2hP+9DKSoeUcnXK1Oj3bctTdso0S6Mw41x4WvE5A90shBgHmbRoSYOfIs+HWOSLg
         HOaC3Ax0IDJZKgAfAYJJKZOv5PlDJfpsn4GjA6IIU+IYX/xBMD+NDcsD/AiNw/KiHWQE
         h9Y6FiB3sDZOhuFhDudWLpZp3D6/NHfSXT2HyNc0C5Qhslyv0nKUDD/bXr7H1sRbcv8g
         qutd4rAm8ZDT7h4NIKqnTD1IAt2b+ErgHPSM/1EpWVwqOXFgzeR+Fhsww299uA4Z91nw
         Q+jg==
X-Forwarded-Encrypted: i=1; AJvYcCXER2/GwtkO9/z2B776nIeTK2JFat3bl/UiBYJ3ofDtYPpZW52B0+wVhsEOdZtg1zNGWNittLcBk9mWjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgk7ecvJL3qVeUZkR72hKtMHD7tu9ocxf9oKEZFozchTNyHklg
	+/iUXqtTXvkZ5DLcsvDNBhQ1hz1KzfjeuDWAoDEZTrVdeDrZaOD9CFAsni2jTV6Qv52oPqBPqiM
	a+KWHm7fwkwDRR4lwv0F31iXeAUleRjJvAmVdXEV1rrN9DGYcb05/xgM=
X-Gm-Gg: ASbGnctZvwl8uEiEzi7kGyX1tpPV6y/47U5KYO+J80Lk1ugPC7c71ZftNwcr55jFZ/y
	5UP483UnJLlA4ne13HC3jpaYi5eDGXxCmVnvHOaTIcLk35F5tX5lMCIO0qPPilLhzc/fFHqbF6W
	s+XPXnRHEg/FHzAvi34QmNc7b31e0k5dkfkfm+OkDzvITRODuWlArygIU5rh/t9+qI/4P82BVdB
	9wADHo3b6/yU/DPkP42CT2vV+5fajFiqtwyjzBdQdz39UmuUvp5HswrfcN4w9qo8Qhht4ml
X-Google-Smtp-Source: AGHT+IGdQa9QIBK3xIwCln2tFRW1tsBXsI15focEbB8x2ukfjpaviuD09eefLp35+/eIa4BBQy9mfEYoTxi6pXu2eno=
X-Received: by 2002:a05:7022:c8c:b0:11a:5cb2:24a0 with SMTP id
 a92af1059eb24-11c9d709e67mr15200064c88.1.1764443957659; Sat, 29 Nov 2025
 11:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-10-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-10-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 29 Nov 2025 11:19:05 -0800
X-Gm-Features: AWmQ_bkcNQPpJYoq7z7jKlkrWh5Ltskwm8o59l4aVrIeOGW4czgai8JLra7Cl9E
Message-ID: <CADUfDZo2Wg8hTv7zkzywGHomycxx0mxwDtAr5zxradxqAoNRAw@mail.gmail.com>
Subject: Re: [PATCH V4 09/27] ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS
 & UBLK_U_IO_COMMIT_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 5:59=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add new command UBLK_U_IO_PREP_IO_CMDS, which is the batch version of
> UBLK_IO_FETCH_REQ.
>
> Add new command UBLK_U_IO_COMMIT_IO_CMDS, which is for committing io comm=
and
> result only, still the batch version.
>
> The new command header type is `struct ublk_batch_io`.
>
> This patch doesn't actually implement these commands yet, just validates =
the
> SQE fields.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c      | 85 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h | 49 ++++++++++++++++++++
>  2 files changed, 133 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c62b2f2057fe..21890947ceec 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -85,6 +85,11 @@
>          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
>          UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
>
> +#define UBLK_BATCH_F_ALL  \
> +       (UBLK_BATCH_F_HAS_ZONE_LBA | \
> +        UBLK_BATCH_F_HAS_BUF_ADDR | \
> +        UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
> +
>  struct ublk_uring_cmd_pdu {
>         /*
>          * Store requests in same batch temporarily for queuing them to
> @@ -108,6 +113,12 @@ struct ublk_uring_cmd_pdu {
>         u16 tag;
>  };
>
> +struct ublk_batch_io_data {
> +       struct ublk_device *ub;
> +       struct io_uring_cmd *cmd;
> +       struct ublk_batch_io header;
> +};
> +
>  /*
>   * io command is active: sqe cmd is received, and its cqe isn't done
>   *
> @@ -2520,10 +2531,82 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd, unsigned int issue_flags)
>         return ublk_ch_uring_cmd_local(cmd, issue_flags);
>  }
>
> +static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
> +{
> +       unsigned elem_bytes =3D sizeof(struct ublk_elem_header);
> +
> +       if (uc->flags & ~UBLK_BATCH_F_ALL)
> +               return -EINVAL;
> +
> +       /* UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK requires buffer index */
> +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> +                       (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR))
> +               return -EINVAL;
> +
> +       elem_bytes +=3D (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA ? sizeof(u=
64) : 0) +
> +               (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR ? sizeof(u64) : 0)=
;
> +       if (uc->elem_bytes !=3D elem_bytes)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
> +{
> +
> +       const struct ublk_batch_io *uc =3D &data->header;
> +
> +       if (uc->nr_elem > data->ub->dev_info.queue_depth)
> +               return -E2BIG;
> +
> +       if ((uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA) &&
> +                       !ublk_dev_is_zoned(data->ub))
> +               return -EINVAL;
> +
> +       if ((uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR) &&
> +                       !ublk_dev_need_map_io(data->ub))
> +               return -EINVAL;
> +
> +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> +                       !ublk_dev_support_auto_buf_reg(data->ub))
> +               return -EINVAL;
> +
> +       return ublk_check_batch_cmd_flags(uc);
> +}
> +
>  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
>                                        unsigned int issue_flags)
>  {
> -       return -EOPNOTSUPP;
> +       const struct ublk_batch_io *uc =3D io_uring_sqe_cmd(cmd->sqe);
> +       struct ublk_device *ub =3D cmd->file->private_data;
> +       struct ublk_batch_io_data data =3D {
> +               .ub  =3D ub,
> +               .cmd =3D cmd,
> +               .header =3D (struct ublk_batch_io) {
> +                       .q_id =3D READ_ONCE(uc->q_id),
> +                       .flags =3D READ_ONCE(uc->flags),
> +                       .nr_elem =3D READ_ONCE(uc->nr_elem),
> +                       .elem_bytes =3D READ_ONCE(uc->elem_bytes),
> +               },
> +       };
> +       u32 cmd_op =3D cmd->cmd_op;
> +       int ret =3D -EINVAL;
> +
> +       if (data.header.q_id >=3D ub->dev_info.nr_hw_queues)
> +               goto out;
> +
> +       switch (cmd_op) {
> +       case UBLK_U_IO_PREP_IO_CMDS:
> +       case UBLK_U_IO_COMMIT_IO_CMDS:
> +               ret =3D ublk_check_batch_cmd(&data);
> +               if (ret)
> +                       goto out;
> +               ret =3D -EOPNOTSUPP;
> +               break;
> +       default:
> +               ret =3D -EOPNOTSUPP;
> +       }
> +out:
> +       return ret;
>  }
>
>  static inline bool ublk_check_ubuf_dir(const struct request *req,
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index ec77dabba45b..2ce5a496b622 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -102,6 +102,10 @@
>         _IOWR('u', 0x23, struct ublksrv_io_cmd)
>  #define        UBLK_U_IO_UNREGISTER_IO_BUF     \
>         _IOWR('u', 0x24, struct ublksrv_io_cmd)
> +#define        UBLK_U_IO_PREP_IO_CMDS  \
> +       _IOWR('u', 0x25, struct ublk_batch_io)
> +#define        UBLK_U_IO_COMMIT_IO_CMDS        \
> +       _IOWR('u', 0x26, struct ublk_batch_io)
>
>  /* only ABORT means that no re-fetch */
>  #define UBLK_IO_RES_OK                 0
> @@ -525,6 +529,51 @@ struct ublksrv_io_cmd {
>         };
>  };
>
> +struct ublk_elem_header {
> +       __u16 tag;      /* IO tag */
> +
> +       /*
> +        * Buffer index for incoming io command, only valid iff
> +        * UBLK_F_AUTO_BUF_REG is set
> +        */
> +       __u16 buf_index;
> +       __s32 result;   /* I/O completion result (commit only) */
> +};
> +
> +/*
> + * uring_cmd buffer structure for batch commands
> + *
> + * buffer includes multiple elements, which number is specified by
> + * `nr_elem`. Each element buffer is organized in the following order:
> + *
> + * struct ublk_elem_buffer {
> + *     // Mandatory fields (8 bytes)
> + *     struct ublk_elem_header header;
> + *
> + *     // Optional fields (8 bytes each, included based on flags)
> + *
> + *     // Buffer address (if UBLK_BATCH_F_HAS_BUF_ADDR) for copying data
> + *     // between ublk request and ublk server buffer
> + *     __u64 buf_addr;
> + *
> + *     // returned Zone append LBA (if UBLK_BATCH_F_HAS_ZONE_LBA)
> + *     __u64 zone_lba;
> + * }
> + *
> + * Used for `UBLK_U_IO_PREP_IO_CMDS` and `UBLK_U_IO_COMMIT_IO_CMDS`
> + */
> +struct ublk_batch_io {
> +       __u16  q_id;
> +#define UBLK_BATCH_F_HAS_ZONE_LBA      (1 << 0)
> +#define UBLK_BATCH_F_HAS_BUF_ADDR      (1 << 1)
> +#define UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK     (1 << 2)
> +       __u16   flags;
> +       __u16   nr_elem;
> +       __u8    elem_bytes;
> +       __u8    reserved;
> +       __u64   reserved2;
> +};
> +
>  struct ublk_param_basic {
>  #define UBLK_ATTR_READ_ONLY            (1 << 0)
>  #define UBLK_ATTR_ROTATIONAL           (1 << 1)
> --
> 2.47.0
>
