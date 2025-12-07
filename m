Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF33FFD
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765095409; cv=none; b=nsdBlFIAnqbhBrvrqMSKE282AL+3BTjltacOMmKpOS9DvklkdIr9Sx9U5ks5f7yHK++Ynh9MHdpkpgMo5Yb/yMUK4o9tegdIv82lH5SV/KzhfWjqtQ3WTuaed6oJtEK1LeGBLWD9+4juvhXuvCEQnXTmBSPevRxdoxs+mx2QJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765095409; c=relaxed/simple;
	bh=B6u+BjB5dmB+fsqPy6mrYnYMOoGnZni7qRYHXTF4llA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0VCWfohH/QagFT4JHzgJUTjhN+mj9LO4xoOO6P5VuMHyxST9Wd38uLT/LoO/aYFIxGh5yEb3Rpq0llaAfDsJ8hMshHolED4iL65UMbSudzDWqTrA5kD8rR120GCIb7skc3E8gT+G6dFKH6WjBxItbOJa4k/Pfo+WJOj+Plnp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WO9nEMi2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WO9nEMi2"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b997ae045b7so237102a12.2
        for <linux-block@vger.kernel.org>; Sun, 07 Dec 2025 00:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765095407; x=1765700207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hwrke6JzMXtJ5GVvCGaMIbP8/r1ZFAhQpEV0JKnWnl4=;
        b=WO9nEMi23N4idII69r4vhhOLAJHHPstgx5O1sKY0F/Aus3MMzdu0FgR+lwCWfIi8wl
         jzz02I0GieQ51TqxrrNTUTHNt8Qu01RI+eQXqfJXAyOBFZZt6RqruG5NxQy45477RPKg
         dqzQVBm9UREMGVRYP9hmXuhSAOSlu5zqV4/U9UilLjELteLMaTJuiYAqt0BwwJe1Gywy
         NR/Q6bi7TomWVYRej5e5Y8pRyhVV/IVVB8W1ExTlS9tJ9e5MuMeHxuMJRvTAc8H9Q6Xy
         e4i3C4WHLP71j9DA4oShNlgOeiSN+CqSSkR2SShKPxsRqX6GYDe28i2rsXX6+4WbpSuN
         OOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765095407; x=1765700207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hwrke6JzMXtJ5GVvCGaMIbP8/r1ZFAhQpEV0JKnWnl4=;
        b=SZWW15qXAje91bHOMZ97sjksUkfoPulUHg9hQFQAeuImd4sF+RqHCBKpFHCNq1QgJK
         I+FO6S9ng1aSib93E/uOKrSk2RZ+hgNFTKffMPMJvaZv6dWWH0b8ZKuo9tRdr3tBJ/8O
         8/h4huVD9kr8ivHtSwSKpPQzlIFArwsOX/yYo7JUyqwjVgKp4jALrDJaJ+mhW+bEU4Yd
         K9IX8HOIL+7mV6+iFkus4U4qV/gwxp51DU6OmYUNGJx/Jg7gK+CaY0PMggGVCFGCvD+j
         J//vtrHaKBcJc0EfoFQ+sN3jUdmIXtPTr8RkO7N57A4UTfqU8FtJhX5tIIghJRZKkPsM
         N9aA==
X-Forwarded-Encrypted: i=1; AJvYcCUnD9F8+vlX8LRlOK5EmwBOQ1P1ZJ+rkehd1J6xIsoV/gddS89WL2auAbb/KgE5TX3Xev1I8W9qnFSyLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1V2i1A633aYNkyTXvWn+pFkq9GNFxH9HJg2qApYXWTbElLWPX
	lHCiuUSb/RIYfzCFTjulwDS3mV3xSwP6FOL89qjQRDIU3WNCALAlLcbEPaGDylkY1Rvfu11Fqnw
	11AWl/vMXudOqibR1Bido/F7nl57MskMHcJHs8BT+jA==
X-Gm-Gg: ASbGncsS5V+T9NHfu9iV5y+DulX+CGSzxHn0nqEqVwS8Hb0Fto+0HR26yxGrELOJN4l
	TvMIa49T3PDpNRJu0BT5UZnZSWhVa9eDyAjyyDOSs+CPszT7x/AckCcC32kuX15HmmcVcsTgghb
	0NxjQCbbUVTB5Hlm5JUviMaJ5ISbiXdopbXgBR/EWNhQyvw7HAOB3MQUg8Grn45DKjcDadJGb2Q
	2PqwgJDpCRXQjLU+Z0I+ZBa7jc1UhoaIN9M8I4bE+RUbYx6GOAWSA2rjvtQqytnfbeYsY404RbV
	yoQ0hGE=
X-Google-Smtp-Source: AGHT+IG71r1tbqkUOyv85T8MuZocWL2L7PVjKWERYAnslxiRj8CGf+3oa7eaRDkhqHF/tgg50rT+Zm1Qu0T8petfhug=
X-Received: by 2002:a05:7300:641c:b0:2a6:cb65:1974 with SMTP id
 5a478bee46e88-2abc710e51amr1788661eec.1.1765095406474; Sun, 07 Dec 2025
 00:16:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202121917.1412280-1-ming.lei@redhat.com> <20251202121917.1412280-11-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-11-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 7 Dec 2025 00:16:35 -0800
X-Gm-Features: AQt7F2rV6Dwkwvus8vcQB4_pMvC4eDVigEomoiIAbTaUQIJDJJARUi3WnIVUw04
Message-ID: <CADUfDZpN+QWKzhRnS9y1Hvn-jgQ2kd+6GxX5YyNU8gi4sCmpaA@mail.gmail.com>
Subject: Re: [PATCH V5 10/21] ublk: add new feature UBLK_F_BATCH_IO
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:21=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add new feature UBLK_F_BATCH_IO which replaces the following two
> per-io commands:
>
>         - UBLK_U_IO_FETCH_REQ
>
>         - UBLK_U_IO_COMMIT_AND_FETCH_REQ
>
> with three per-queue batch io uring_cmd:
>
>         - UBLK_U_IO_PREP_IO_CMDS
>
>         - UBLK_U_IO_COMMIT_IO_CMDS
>
>         - UBLK_U_IO_FETCH_IO_CMDS
>
> Then ublk can deliver batch io commands to ublk server in single
> multishort uring_cmd, also allows to prepare & commit multiple
> commands in batch style via single uring_cmd, communication cost is
> reduced a lot.
>
> This feature also doesn't limit task context any more for all supported
> commands, so any allowed uring_cmd can be issued in any task context.
> ublk server implementation becomes much easier.
>
> Meantime load balance becomes much easier to support with this feature.
> The command `UBLK_U_IO_FETCH_IO_CMDS` can be issued from multiple task
> contexts, so each task can adjust this command's buffer length or number
> of inflight commands for controlling how much load is handled by current
> task.
>
> Later, priority parameter will be added to command `UBLK_U_IO_FETCH_IO_CM=
DS`
> for improving load balance support.
>
> UBLK_U_IO_NEED_GET_DATA isn't supported in batch io yet, but it may be
> enabled in future via its batch pair.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 53 +++++++++++++++++++++++++++++------
>  include/uapi/linux/ublk_cmd.h | 16 +++++++++++
>  2 files changed, 61 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3865edabe1e6..034420e8df55 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -74,7 +74,8 @@
>                 | UBLK_F_AUTO_BUF_REG \
>                 | UBLK_F_QUIESCE \
>                 | UBLK_F_PER_IO_DAEMON \
> -               | UBLK_F_BUF_REG_OFF_DAEMON)
> +               | UBLK_F_BUF_REG_OFF_DAEMON \
> +               | UBLK_F_BATCH_IO)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -331,12 +332,12 @@ static void ublk_batch_dispatch(struct ublk_queue *=
ubq,
>
>  static inline bool ublk_dev_support_batch_io(const struct ublk_device *u=
b)
>  {
> -       return false;
> +       return ub->dev_info.flags & UBLK_F_BATCH_IO;
>  }
>
>  static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
>  {
> -       return false;
> +       return ubq->flags & UBLK_F_BATCH_IO;
>  }
>
>  static inline void ublk_io_lock(struct ublk_io *io)
> @@ -3462,6 +3463,35 @@ static int ublk_validate_batch_fetch_cmd(struct ub=
lk_batch_io_data *data,
>         return 0;
>  }
>
> +static int ublk_handle_non_batch_cmd(struct io_uring_cmd *cmd,
> +                                    unsigned int issue_flags)
> +{
> +       const struct ublksrv_io_cmd *ub_cmd =3D io_uring_sqe_cmd(cmd->sqe=
);
> +       struct ublk_device *ub =3D cmd->file->private_data;
> +       unsigned tag =3D READ_ONCE(ub_cmd->tag);
> +       unsigned q_id =3D READ_ONCE(ub_cmd->q_id);
> +       unsigned index =3D READ_ONCE(ub_cmd->addr);
> +       struct ublk_queue *ubq;
> +       struct ublk_io *io;
> +
> +       if (cmd->cmd_op =3D=3D UBLK_U_IO_UNREGISTER_IO_BUF)
> +               return ublk_unregister_io_buf(cmd, ub, index, issue_flags=
);
> +
> +       if (q_id >=3D ub->dev_info.nr_hw_queues)
> +               return -EINVAL;
> +
> +       if (tag >=3D ub->dev_info.queue_depth)
> +               return -EINVAL;
> +
> +       if (cmd->cmd_op !=3D UBLK_U_IO_REGISTER_IO_BUF)
> +               return -EOPNOTSUPP;
> +
> +       ubq =3D ublk_get_queue(ub, q_id);
> +       io =3D &ubq->ios[tag];
> +       return ublk_register_io_buf(cmd, ub, q_id, tag, io, index,
> +                       issue_flags);
> +}
> +
>  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
>                                        unsigned int issue_flags)
>  {
> @@ -3509,7 +3539,8 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uri=
ng_cmd *cmd,
>                 ret =3D ublk_handle_batch_fetch_cmd(&data);
>                 break;
>         default:
> -               ret =3D -EOPNOTSUPP;
> +               ret =3D ublk_handle_non_batch_cmd(cmd, issue_flags);

It looks like the non-batch commands still perform the if
(data.header.q_id >=3D ub->dev_info.nr_hw_queues) check in
ublk_ch_batch_io_uring_cmd() even though they use struct
ublksrv_io_cmd instead of struct ublk_batch_io. I think it would be
preferable to move that check to ublk_check_batch_cmd() and
ublk_handle_batch_fetch_cmd().

> +               break;
>         }
>  out:
>         return ret;
> @@ -4179,10 +4210,9 @@ static int ublk_ctrl_add_dev(const struct ublksrv_=
ctrl_cmd *header)
>          */
>         ub->dev_info.flags &=3D UBLK_F_ALL;
>
> -       ub->dev_info.flags |=3D UBLK_F_CMD_IOCTL_ENCODE |
> -               UBLK_F_URING_CMD_COMP_IN_TASK |
> -               UBLK_F_PER_IO_DAEMON |
> -               UBLK_F_BUF_REG_OFF_DAEMON;

Why are these reported features removed? This will break ublk servers
that check for these features in the ublk device flags.

Best,
Caleb

> +       /* So far, UBLK_F_PER_IO_DAEMON won't be exposed for BATCH_IO */
> +       if (ublk_dev_support_batch_io(ub))
> +               ub->dev_info.flags &=3D ~UBLK_F_PER_IO_DAEMON;
>
>         /* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
>         if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY |
> @@ -4540,6 +4570,13 @@ static int ublk_wait_for_idle_io(struct ublk_devic=
e *ub,
>         unsigned int elapsed =3D 0;
>         int ret;
>
> +       /*
> +        * For UBLK_F_BATCH_IO ublk server can get notified with existing
> +        * or new fetch command, so needn't wait any more
> +        */
> +       if (ublk_dev_support_batch_io(ub))
> +               return 0;
> +
>         while (elapsed < timeout_ms && !signal_pending(current)) {
>                 unsigned int queues_cancelable =3D 0;
>                 int i;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index cd894c1d188e..a64b7ee578fb 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -335,6 +335,22 @@
>   */
>  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
>
> +
> +/*
> + * Support the following commands for delivering & committing io command
> + * in batch.
> + *
> + *     - UBLK_U_IO_PREP_IO_CMDS
> + *     - UBLK_U_IO_COMMIT_IO_CMDS
> + *     - UBLK_U_IO_FETCH_IO_CMDS
> + *     - UBLK_U_IO_REGISTER_IO_BUF
> + *     - UBLK_U_IO_UNREGISTER_IO_BUF
> + *
> + * The existing UBLK_U_IO_FETCH_REQ, UBLK_U_IO_COMMIT_AND_FETCH_REQ and
> + * UBLK_U_IO_NEED_GET_DATA uring_cmd are not supported for this feature.
> + */
> +#define UBLK_F_BATCH_IO                (1ULL << 15)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> --
> 2.47.0
>
