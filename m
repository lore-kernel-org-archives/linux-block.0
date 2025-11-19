Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE22882B7
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519851; cv=none; b=OSe17LcAfJ3dhW4pAW+MT4B7xHUgPxVQ1Gz81SXRWd5/H6PVP/pE9mHeHvvzUJrEJViw6DCCBXSA8S+wzWKYrVe/kUTXP+UsMfTtLWXzuDLDo8irY/M9xhUHLBwAeYn3uWtUuvYc/4IMvor5xzXJd6r+0HEvn/RdaR3xLYSSULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519851; c=relaxed/simple;
	bh=jLA0oS70U6WFwOAOgyGdmGf6Q1SXV0r4dYhOs21QcaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiR1lmPICd1xKY/aLummvnAUYIpw7f+qxYe6li7hHbz9gbx9iBEh8kWQkAeA47EK3fZ6x1ISKUMO1MPTp1fDSXgAUpY/CJz3BS2LnMaVy7lCaW5fc1jVHD6hlo8RSO+gbBBOrlUPKD1bArBioTgIZPwc+dCMQZUL3xjEAHa8zyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GMb63uDx; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GMb63uDx"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b983fbc731bso446324a12.2
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 18:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763519849; x=1764124649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPSStqyxtxRHfFDVIG7+UAyDlwAk26RCYvcKQTsYows=;
        b=GMb63uDxkZ1tainaxc0eJbfsAqt87KqX4vUYlCQQePx99RgEZVmrJmsLxW3syrsFsl
         sf85CuGxHwzqSdLdAMkKnMvnUIkiOevo1HxutOwbDVDMg6NbOiXu8qVHoDPMbnqOzrbi
         Xo2Og5UNPtrzuzCmS6yXraTe/7d04K25zItCkGSz6EtJGMhrQGz+g343iphZv2FpbtlQ
         cNe9BEdvEksZ5FnRKv9XN3yx0S3SsBEA3PoaLE+jhpRjmtGNB4smtGdcpmPfeg/U4ClX
         zm1h5lhv+0dVBzWZt699gdqgwuQauZoGBvRKCRP+C2IqyuIviFOTpBBWpKnigZOscQo2
         Itkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763519849; x=1764124649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPSStqyxtxRHfFDVIG7+UAyDlwAk26RCYvcKQTsYows=;
        b=NmmvMJSoaaFKMsfKrdjAIH58QT1hOE507DkfxxWMasoeCjFlxlj8RxdQmiiRJbiJqI
         hn+HBmr0hvUAWS3PBnSJHIAbGhqVzYLwlF2fofMh4Qs2v8CK+VOlXLHm2sQKp879msNu
         accNd0WAtEKClWZEoADYt25+AYuLP6SxtnxN58bGnCebkqp/UyiP8ZOIsLWBviygVc4I
         C16taD9dIW3thb6eUYN+UOY8EykuSTUJdckx46YHlx/MRNWTCUC6jJJpQcSkKZY87cdQ
         E/C+lpkKnmy14DFVBdm/V0T8OzIDYtVzYdVcV7eTaV/VnqE7iBmcL9CquKI6BU5H6zb3
         VsKg==
X-Forwarded-Encrypted: i=1; AJvYcCVm9hA5O6kbHGpi9POya83yfOg6r3rkGpIhsO+BP4AD60M9u2GxmffGZ5gj0QWCoG0xubQqiiiT+Ryrlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8uerUSrMQLZROg1s7eIsZ2MSfnIUhS4QjXjN/wMIhOcwQo0Pv
	B/mPqeoPsEgo5xd5OpzgBgZyD45CGKhNBpzxLM1/fhVzAcxwdQqneSOPEtvCtv159PyPLkFxazL
	xEoMvy4kpj3RUrDe2XD+BFmhCA2UiiaMZT60ch9FP3A==
X-Gm-Gg: ASbGncuAhFL9a037wAG+zB8D5yRCFq5JgdMZCpUYy81fGoIRDF0yRNjuGq/+TIvKrr2
	5Mo/QjVw2ck7qJNU1xyS+jXORceU9w5APf/l5I42qt4I3o4fjmq1l75UseRDEcxUkpzB2QM8/Gw
	a3oUm8nKI0hNmxl3108Nr4pHgJZdXiJFXkKFMM/f72bb4T0/knAsRmHtV3IZgrUejpbIx1JaPFc
	37lWfZFy8nHhG8Qw3vzCPSrIvUQYfOTN85mtAhyC8Cgj20EtujPTRnFjTTbKqUQRttsTEDQR7tL
	a4nh3tg=
X-Google-Smtp-Source: AGHT+IFJbgiDdokeJVn7Ca0hYaCr4pYTTAgFMYW16RXAUMP6qdt/ET7w/cVZVhhKBCTP8TVGjTNWf7ZNmOWhIQRrrQA=
X-Received: by 2002:a05:7022:61a9:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11b40b36d09mr7576320c88.0.1763519848412; Tue, 18 Nov 2025
 18:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-10-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-10-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 18 Nov 2025 18:37:17 -0800
X-Gm-Features: AWmQ_bmUzT5gDAjXTPsskXs1gSmJDb7fOU9DeEsXH9a4wOMhW1w-Zeat2nwN00o
Message-ID: <CADUfDZpoeUF+dAm4AtjzC-+BOwwZr2CnTgcZoPAE_4KNNsmoXw@mail.gmail.com>
Subject: Re: [PATCH V3 09/27] ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS
 & UBLK_U_IO_COMMIT_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
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
>
> This patch doesn't actually implement these commands yet, just validates =
the
> SQE fields.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 107 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  49 ++++++++++++++++
>  2 files changed, 155 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c62b2f2057fe..5f9d7ec9daa4 100644
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
> @@ -2520,10 +2531,104 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd, unsigned int issue_flags)
>         return ublk_ch_uring_cmd_local(cmd, issue_flags);
>  }
>
> +static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
> +{
> +       const u16 mask =3D UBLK_BATCH_F_HAS_BUF_ADDR | UBLK_BATCH_F_HAS_Z=
ONE_LBA;
> +       const unsigned header_len =3D sizeof(struct ublk_elem_header);
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
> +               if (uc->elem_bytes !=3D header_len)
> +                       return -EINVAL;
> +               break;
> +       case UBLK_BATCH_F_HAS_ZONE_LBA:
> +       case UBLK_BATCH_F_HAS_BUF_ADDR:
> +               if (uc->elem_bytes !=3D header_len + sizeof(u64))
> +                       return -EINVAL;
> +               break;
> +       case UBLK_BATCH_F_HAS_ZONE_LBA | UBLK_BATCH_F_HAS_BUF_ADDR:
> +               if (uc->elem_bytes !=3D header_len + sizeof(u64) + sizeof=
(u64))
> +                       return -EINVAL;
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
> +{
> +
> +       const struct ublk_batch_io *uc =3D &data->header;
> +
> +       if (!(data->cmd->flags & IORING_URING_CMD_FIXED))
> +               return -EINVAL;
> +
> +       if (uc->nr_elem * uc->elem_bytes > data->cmd->sqe->len)

sqe->len should be accessed with READ_ONCE() since it may point to
user-mapped memory.

Best,
Caleb

> +               return -E2BIG;
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
