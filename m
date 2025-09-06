Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C02222AF
	for <linux-block@vger.kernel.org>; Sat,  6 Sep 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757184670; cv=none; b=t2idS2Ux9UmdfZpapHUZ51UuTjWQc76K3uh4Z8n3dfODrSp7b1NlY8h14JOBGxmIYdZaBUFGztOB/76ACILrEKsCiKV8oGGZRVdQE6rFaSOKu4UxjC2SzHgaHO/x0w9c9cvZ8JamE3DHtq8AEBtz2/FqFC23qaAQspS8/ikg3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757184670; c=relaxed/simple;
	bh=QcfxW1B4yT/4AgdmsWe8dOBU86I+RpaD1LQBjh27EyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pB/n0ntj8y4Jdf/bMiZnz5A8bcwqP14iMhvytG+aOmuz+mKjsygHf/VGSvNkQjqH41yX8A+PE+UlKGvVyuxnPsOoUgI+MQw56iEhmA5Ng6MvPUFkz33OoMi2H3w/mpnvpawgfFjrzo4PT8QfAZhIicag+hr7yHFrC/EXWHukm+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Vgr+b6eS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Vgr+b6eS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24cda620e37so6346375ad.3
        for <linux-block@vger.kernel.org>; Sat, 06 Sep 2025 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757184667; x=1757789467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9abr+ic0LrqzOtXzY/JegErbQYUQxI3SOWCsB9vFGXI=;
        b=Vgr+b6eSqx7J2NUFOgyHFhj0Ii8p68uecweR24QDMgzfGULlUJZVgDECedg4jCGg1E
         gPjGu7hbuEyCQYrTfjXv+MhYPtUas7S9yFSx6siZiMnnxUOz0lnWYwRDfE5XnZod9j5G
         lOegRk1pXXyDPFYmfSjqQfFj5eZIUKSFEwE8aceNtPTwxJO+ViF7y4sv9JsFR9AyQ6yr
         6r501vWKzpdyb4wBTfIjzSfoGKjVhy3OFS7B2YXlzSbdxDYzWEVztWMxLTN/EkGQOB2R
         gYYcpcR+GEkl/Q7wTHdcsBzzSuRjFfK5xjzsHiIN4y+gNAgX6t6IEZiR3Lo4bxU2bCMS
         96/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757184667; x=1757789467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9abr+ic0LrqzOtXzY/JegErbQYUQxI3SOWCsB9vFGXI=;
        b=NMXJ02VA7Evg3Oqh2BxHh5rg2zMTRrXn0Ev2KKkRtsAC6E3fpHyw95cOCK0cgdEyMA
         kmFlLToVbkwZQcVp4sDr0Yeppso0KZMM/DNgcmWhGsoRb/m8SZpfbkKEwiQXoOlDyD8/
         3Ze9RvM1qHcAF5B1PgX8qORIuhT8DNYgFt8PsoozHKD/57dEtZz3pYuPMS50IzvJPbkH
         43EUitxYmgul6mXFqd6nBH8H+c1Zvjk9otiLX3k3iDNkT98GSsuRvCDVmCOPAJiaI4ar
         4ReuGCSzxOpwl5Hfw2n6DpAsP/HP60A+xWT67jQ6gJxzWt+FyuH5/7rnuHTfYyL1TOC+
         IP1w==
X-Forwarded-Encrypted: i=1; AJvYcCVnUhqClHDMKLqseYlxPabktKv6fJ05sOtEzxSUWKkCwWnX1SnFMW3Y7jSWw9SsXDhUwwWv3OTEcwPFDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysWASTwjs/wQF3TaG3rMjKTM7Qn+gkZzMl4mKz0+jAOWFM4J3B
	16Jjp+huCekmuWTcNaJG/q1tNboflT5r5UjVbuTzvkFap+aa/R43QmQMXsEVhzWf8YqfN98gmS1
	4gMQubAyVZ5ZoW2xIXSxOuQuCkOo8cOFoDNgvwNbZow==
X-Gm-Gg: ASbGncvAUkOmRVU9TQoe/ICBw6RE+NGeDsGHOi2/pVvykunLaEw58n5FaxV4fte1xzl
	YOf3S5bixZFQIj9vOMC/9/Uc8BrlKBtL7H44jL2bzs+G7bJEOCXiDrQk/NNVRPAPx4deFHWqicR
	PTujkcPCFh4fkGqPdAcOezleKsz79vj7mKHX1EI+cpSaWzKLJ5wNEyzxGIZehsoG4Bp8fNGcoXI
	ft0M56UOoX9
X-Google-Smtp-Source: AGHT+IFPDbNmwhx6uMz3QdmVxGm9gnz6XtlCuvalSCRCTB04TkDnIOXrawbzAglsVOy7ASqMmpCtEX1Av6qC7BQEnmA=
X-Received: by 2002:a17:903:41c7:b0:24c:cbcc:b7ae with SMTP id
 d9443c01a7336-2517493a0cbmr23898765ad.6.1757184667318; Sat, 06 Sep 2025
 11:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-8-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-8-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 6 Sep 2025 11:50:55 -0700
X-Gm-Features: Ac12FXzlvdq2FDnSi2bV4_srroDyne697bQxKn6QMI8zmkuTzdpoTHTI2vJ68jE
Message-ID: <CADUfDZq8hWU1z7_-s3We7pMSxW6uAmX=yp7RXOYwkrWxcvPXDA@mail.gmail.com>
Subject: Re: [PATCH 07/23] ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS
 & UBLK_U_IO_COMMIT_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add new command UBLK_U_IO_PREP_IO_CMDS, which is the batch version of
> UBLK_IO_FETCH_REQ.
>
> Add new command UBLK_U_IO_COMMIT_IO_CMDS, which is for committing io comm=
and
> result only, still the batch version.
>
> The new command header type is `struct ublk_batch_io`, and fixed buffer i=
s
> required for these two uring_cmd.

The commit message could be clearer that it doesn't actually implement
these commands yet, just validates the SQE fields.

>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 102 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  49 ++++++++++++++++
>  2 files changed, 149 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 46be5b656f22..4da0dbbd7e16 100644
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
> @@ -108,6 +113,11 @@ struct ublk_uring_cmd_pdu {
>         u16 tag;
>  };
>
> +struct ublk_batch_io_data {
> +       struct ublk_queue *ubq;
> +       struct io_uring_cmd *cmd;
> +};
> +
>  /*
>   * io command is active: sqe cmd is received, and its cqe isn't done
>   *
> @@ -277,7 +287,7 @@ static inline bool ublk_dev_is_zoned(const struct ubl=
k_device *ub)
>         return ub->dev_info.flags & UBLK_F_ZONED;
>  }
>
> -static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
> +static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)

This change could go in a separate commit.

>  {
>         return ubq->flags & UBLK_F_ZONED;
>  }
> @@ -2528,10 +2538,98 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd, unsigned int issue_flags)
>         return ublk_ch_uring_cmd_local(cmd, issue_flags);
>  }
>
> +static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
> +{
> +       const unsigned short mask =3D UBLK_BATCH_F_HAS_BUF_ADDR |
> +               UBLK_BATCH_F_HAS_ZONE_LBA;

Can we use a fixed-size integer type, i.e. u16?

> +
> +       if (uc->flags & ~UBLK_BATCH_F_ALL)
> +               return -EINVAL;
> +
> +       /* UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK requires buffer index */
> +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> +                       (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR))
> +               return -EINVAL;
> +
> +       switch (uc->flags & mask) {
> +       case 0:
> +               if (uc->elem_bytes !=3D 8)

sizeof(struct ublk_elem_header)?

> +                       return -EINVAL;
> +               break;
> +       case UBLK_BATCH_F_HAS_ZONE_LBA:
> +       case UBLK_BATCH_F_HAS_BUF_ADDR:
> +               if (uc->elem_bytes !=3D 8 + 8)

sizeof(u64)?

> +                       return -EINVAL;
> +               break;
> +       case UBLK_BATCH_F_HAS_ZONE_LBA | UBLK_BATCH_F_HAS_BUF_ADDR:
> +               if (uc->elem_bytes !=3D 8 + 8 + 8)
> +                       return -EINVAL;

So elem_bytes is redundant with flags? Do we really need a separate a
separate field then?

> +               break;
> +       default:
> +               return -EINVAL;

default case is unreachable?

> +       }
> +
> +       return 0;
> +}
> +
> +static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data,
> +                               const struct ublk_batch_io *uc)
> +{
> +       if (!(data->cmd->flags & IORING_URING_CMD_FIXED))
> +               return -EINVAL;
> +
> +       if (uc->nr_elem * uc->elem_bytes > data->cmd->sqe->len)

Cast nr_elem and/or elem_bytes to u32 to avoid overflow concerns?

Should also use READ_ONCE() to read the userspace-mapped sqe->len.

> +               return -E2BIG;
> +
> +       if (uc->nr_elem > data->ubq->q_depth)
> +               return -E2BIG;
> +
> +       if ((uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA) &&
> +                       !ublk_queue_is_zoned(data->ubq))
> +               return -EINVAL;
> +
> +       if ((uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR) &&
> +                       !ublk_need_map_io(data->ubq))
> +               return -EINVAL;
> +
> +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> +                       !ublk_support_auto_buf_reg(data->ubq))
> +               return -EINVAL;
> +
> +       if (uc->reserved || uc->reserved2)
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
> +               .cmd =3D cmd,
> +       };
> +       u32 cmd_op =3D cmd->cmd_op;
> +       int ret =3D -EINVAL;
> +
> +       if (uc->q_id >=3D ub->dev_info.nr_hw_queues)
> +               goto out;
> +       data.ubq =3D ublk_get_queue(ub, uc->q_id);

Should be using READ_ONCE() to read from userspace-mapped memory.



> +
> +       switch (cmd_op) {
> +       case UBLK_U_IO_PREP_IO_CMDS:
> +       case UBLK_U_IO_COMMIT_IO_CMDS:
> +               ret =3D ublk_check_batch_cmd(&data, uc);
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
> index ec77dabba45b..01d3af52cfb4 100644
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
> +       __u32 result;   /* I/O completion result (commit only) */

The result is unsigned? So there's no way to specify a request failure?

> +};
> +
> +/*
> + * uring_cmd buffer structure

Add "for batch commands"?

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

So this doesn't allow batching completions across ublk queues? That
seems like it significantly limits the usefulness of this feature. A
ublk server thread may be handling ublk requests from a number of
client threads which are submitting to different ublk queues.

Best,
Caleb

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
