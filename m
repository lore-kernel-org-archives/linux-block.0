Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206125291B
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413753; cv=none; b=EkYduROACwZlFwIgPKaw4hxZb+xTCksu4sd+ijQNXBGaf719oW1YwjbwW4JyghxLECNfJFI3Y+ghEl4CTATzLxP12+gLy4pAQPhdp9rSCJw08GDOzdCh7ZubS6koCJ4ntJze39IFXe3CGUsYeaCbe5kubEW5SQ+nL37MjAJXej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413753; c=relaxed/simple;
	bh=Cfq9PsnIWeOxXJjUFsvUzi9xWCxO1CE6SymCMgHSVKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwkOJ3ypRDF1VEukhm85hd8mAH7nepnaHC9TOaVowk/0qvO+IU0nhP+VJ4IHjPcDjsJMCmmTZMEnvKBwK5viI7pxR6D4njJc4ZQMEKJIXmZSw9bi4tMhHtIAktg/V/kIlwm/wU/vWaLgiKUBQvKOiH7huN6e8gtpjKJ9vOtrKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lmyruhxz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lmyruhxz"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b9a2e3c4afcso406616a12.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 13:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763413749; x=1764018549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Exgt2lHI77g+GW4KjbyvmOloVr4tDf9uU3IVvEwny9Q=;
        b=LmyruhxzVq6FFSsMKXz5Ig5NAmNvwUmO3K1n7pPU50KQRL4UJ+l/TWYVtIpbnVvXzq
         UxkE5XPvYk2vVfCrRbwxF3fHJuwhtcUyH8JqtYw791fBGrW/Wt9CRLv8U5NOaffTfT4j
         TuymqDhLHXd5LpNvuD/doYATv2J5yrCAE2brqgFktTGi9JF++Pi2RopoVZxD9aJUwf6d
         /0SDNQ0N9juDXEiP4RNybg5eNqRQcfP5e2ww3A2VDnwzWoAMTF1uDQsTGPpktq6vJYxX
         qdb+l5Pe6jGj13r+Pfw6CukjBualnhD2h8qw4VbA6jMYzRj/ZQyZFbCbA15G4He1MbXR
         Pycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763413749; x=1764018549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Exgt2lHI77g+GW4KjbyvmOloVr4tDf9uU3IVvEwny9Q=;
        b=u0q+peVf8H6R7DP/t+gXNYIY2Mp+7kCyX6Hx7/ilgxBrq+NUpZCfGCYWPxA8EhEm9D
         cNyrNazNJjdrxj5CwUk6WaMwtEAiyc51i+fUSexaSRdgaL3ARuBvRIXIBUWeDBhGabJr
         KywDxESALbwxlmP2Ivg+d/WUOyPYWEXth53KX5J8cyMDGiu88b8SFAih1LIsyEWb8kaM
         wUuHoRfxIp1TlfR8JihJoY2RIKTLIEKNG/2Fp8BjlQJdQYRZqNCBWjtr+87XTAwu+u5r
         8v5dESrLfpgyfLdOBUQZ7MbTYu2XBLmYbda/4mzMVl+vlbRq4NcMIUocN0OLKd5mnbwJ
         Kr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLASY6Z2xLA5z8lSIttCTJyZEPq0BZIvhg1abKESDxsw610p/VUWJvSz6SR2z/mCVyXhBjngkry8Hzcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIfQmbjkGV4/5CYADsmv8+dWqi4uXkig5gcZ5d9L7sgFBfPHnR
	qDrEqg2XgS7buYb87D2c/zHKN9RR1KbXUl04ony4rRQdHeVvRkyjva9kyFkrZaYigdUPuWfJ9tz
	sUEdLhK/nGssHEsqvzhsekr8SbJzausHTPyXdaZ0weQ==
X-Gm-Gg: ASbGnctEJR+V6+EtjKlfBztaA2BSUevKjXPj14/cjT37UUrGED1GGGUO34AjPWfSg+7
	gJd1Y6lvfhmb9kRgQycd2ve4rqHHfXmVPGQfLwW1buQYOJcK9RJkXXZJkwSI/0ISHkRPxA2mSsD
	0zg++Ywvc6DXefFxTVmdl7ANp7MWVOSCDNttww5LK6rphMKeqdfNbL1n+oBTWTRgKaGsx3EyuMI
	y7GHuqjfakdJs0NbPoLMaNOUmc9XldwzJHcIhtWPV6RHFaSDwgncQaujzpr63vR/FantWXf
X-Google-Smtp-Source: AGHT+IF6FXn+nSaJMQYodi1STQN+itY8xOlOm7FwPVoGHCh69U2bpkRTDkC4MF+nuM7ePJlh5ZMBpcBEkHW4WQio0W8=
X-Received: by 2002:a05:7022:61a9:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11b40b36d09mr5812194c88.0.1763413748442; Mon, 17 Nov 2025
 13:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-10-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-10-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 17 Nov 2025 13:08:56 -0800
X-Gm-Features: AWmQ_bkBj0oi-LrsdxQBFK3ozzENfhHO25zd9oIVDDDufzWbiCp_s7wqSQJuhPI
Message-ID: <CADUfDZp3RVr-n4UbiRa=+hDnZh2r-G-fFL0o8PtVD2ERMSfpPw@mail.gmail.com>
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

Is it possible for this to be a const pointer?

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

This could probably be implemented in a less branchy way using
conditional moves:
unsigned elem_bytes =3D sizeof(struct ublk_elem_header) +
        (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA ? sizeof(u64) : 0) +
        (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR ? sizeof(u64) : 0);
if (uc->elem_bytes !=3D elem_bytes)
        return -EINVAL;

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

These fields aren't actually copied from the uring_cmd, so this check
is a no-op.

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

Is the out label really necessary if there's no cleanup involved? Can
we just return the result directly?

Best,
Caleb

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
