Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB061B423B
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623780; cv=none; b=u6qln2rda4U/XhuY7usWpnYxI1Zvzqr5R2v6h2mqwqasKXIDyKF08AWeNnNKTA5BTzf0wEKnAWeArw802YwH/FN1GJbin3JJmroxRhuGFCOvds/c4tZkK7d0PhtAs871cjDb0kwNOKFJkEj4pr8Q+zrhABL+RW2OMHuDaSQbcy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623780; c=relaxed/simple;
	bh=4BJsawf23WaYBPw+2quriHFleiT8UwKpJysJk2IsiY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEuWxmkTX2yVEu59yV4/EfL0B2OCpnO4fURirkNo5JALvMScF9l+Ciflqn8xerwcbAJGIBWtunbA+pVpdLeY9Mi1gr2FBiOscDkVMCJgJwxo4KBIBUwbFAO0/4WR+TOi3OYSsQ0+0VTn/xOKVSZKybIEu1K9BCLW9ZZhqaQ3uRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=evHdO1cn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="evHdO1cn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297d6c0fe27so5211505ad.2
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 13:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764623778; x=1765228578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inc9xEM0xtxWIiXbPVBas+bir2/LUZdUnnfmfmYr6D0=;
        b=evHdO1cn8xnj6BUYgjI5/cXX8ZtFdBJA2VheM2lugipt/ge8SpliM5xmphX+1O67jw
         gSIOAihzXxy3GLtyaNBycQvWiG5fO8gfXVqI87iGpJK0NmP1flLQFo2rqIPbBfhF/bvh
         xl3hun5wrHkLUK8YCyb1rVvEoAVJSIxSB2cGI+xI7PopZ2PYgJsaKDstWEVNSyE2QbLF
         E2u2rYxQGP4snECHbLLyGc3tL3uZ/FzS0LtJlqejweVRjQYYF+EJ+SxEAxb7E2UzIAA0
         THQCf2ON6972Ggai1Zv5YteNb5MilWKuLuuxoniVl0XBWz0cUuvn/oSQFOgMQQUeQ8t6
         0Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764623778; x=1765228578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=inc9xEM0xtxWIiXbPVBas+bir2/LUZdUnnfmfmYr6D0=;
        b=JE92K8+C2C0tFu7O9XfYWZ5sAxWUZ7THf08qkCFNRnBzRLhZAyXM7cIJ9oHez0c/+e
         SxAI05qZZBIDJUCvvxtd/auANMT/wfjdlUIAAv47nGKrUiGdDrsmvB1v+Hm4Gw8CKwNV
         eAuK1E8/nSpe/w5tTakfiNHGnP995VVq/hTG089dKO9bX/ScDDbhLYK0psUT8HpWtBTz
         xnAnCB+oWfvzOwBe1JeilEqPEXy8Zf8AJNENcwkYTIzmMbx4b6IxaBegBPJPyLBuVozK
         tVdsWHnerUmC1Av/6RwdMknfkTSF4g3QzGvnV2dt00jlKQy8q/5DFCXo69MuLPZnT/I3
         pRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVs9sRBU4P87YzpPHjoHeZS3HUP5IEgIYmKy9tY0+Bu+o2BJK0T2HFqGQs39OTDf2zRXcipAYMU9BdpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCk7Y7d1lfNv0EYmnLhnA7mCeku+CJXwfWgRAyp2Afp87j1+E
	RLeIL+YhtjTboYTY9y+pUoyjukv2o6FtrFdnS46nQoSYoqsk7IJAHROXRF/9k3ER9pNsVV+RCUO
	8ugykWV/AMeIVmQcRhWRhHMmY0a0XC+f7ST7hA30sP6v3iGNBg6vaiE37tw==
X-Gm-Gg: ASbGncuNjhqjz2wNyUVxLBL6UFnzBwLVuTzf/BafsE9WXjmSFovi9Ul7pap1JHIUJV2
	rOgD02q4y18qdwUXlDyEV9AwjaaITiJZNFd5FeX/qeTtiH4/DIaiP0e5E7O7/N7F/BTER9WpTYp
	0znNzVtdCLAgxnulmJxi1HDkMQKbi8OnFF7FgC7xcjdBMraB/jTOYtQTVEKCwdZXK3FT4yIli7v
	G5IznkFdOhzfvavuIt+fjNk/gATZuf51YqIQ2yz6zpyF+vh+FAWS8sQCfMwnc2tTfxHbD8w
X-Google-Smtp-Source: AGHT+IFGX0Fu3nQPXZJi5KYagCbiXTbkfWqIh81SR4ivLc0TmvSBwbp7Soi9KpEfqSWJmrLKWYiLbQ++24osQzV8EV8=
X-Received: by 2002:a05:7300:e80a:b0:2a4:3593:5fc6 with SMTP id
 5a478bee46e88-2a718b198bemr25442906eec.0.1764623777272; Mon, 01 Dec 2025
 13:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-17-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-17-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Dec 2025 13:16:04 -0800
X-Gm-Features: AWmQ_bklgvKWRISSzDpMkiJLXtlOWAoBRWvtbmT9Y7vpxiCGijErGtQR3BeR-Gg
Message-ID: <CADUfDZoXKATH_nQ0TEqj6BrN+e-Shkd11CUJaJJ_FKbrTrv=GQ@mail.gmail.com>
Subject: Re: [PATCH V4 16/27] ublk: add new feature UBLK_F_BATCH_IO
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
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
> UBLK_U_IO_GET_DATA isn't supported in batch io yet, but it may be

UBLK_U_IO_NEED_GET_DATA?

> enabled in future via its batch pair.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 58 ++++++++++++++++++++++++++++++++---
>  include/uapi/linux/ublk_cmd.h | 16 ++++++++++
>  2 files changed, 69 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 849199771f86..90cd1863bc83 100644
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
> @@ -320,12 +321,12 @@ static void ublk_batch_dispatch(struct ublk_queue *=
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
> @@ -3450,6 +3451,41 @@ static int ublk_validate_batch_fetch_cmd(struct ub=
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
> +       int ret =3D -EINVAL;

I think it would be clearer to just return -EINVAL instead of adding
this variable, but up to you

> +
> +       if (!ub)
> +               return ret;

How is this case possible?

> +
> +       if (q_id >=3D ub->dev_info.nr_hw_queues)
> +               return ret;
> +
> +       ubq =3D ublk_get_queue(ub, q_id);
> +       if (tag >=3D ubq->q_depth)

Can avoid the likely cache miss here by using ub->dev_info.queue_depth
instead, analogous to ublk_ch_uring_cmd_local()

> +               return ret;
> +
> +       io =3D &ubq->ios[tag];
> +
> +       switch (cmd->cmd_op) {
> +       case UBLK_U_IO_REGISTER_IO_BUF:
> +               return ublk_register_io_buf(cmd, ub, q_id, tag, io, index=
,
> +                               issue_flags);
> +       case UBLK_U_IO_UNREGISTER_IO_BUF:
> +               return ublk_unregister_io_buf(cmd, ub, index, issue_flags=
);
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +}
> +
>  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
>                                        unsigned int issue_flags)
>  {
> @@ -3497,7 +3533,8 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uri=
ng_cmd *cmd,
>                 ret =3D ublk_handle_batch_fetch_cmd(&data);
>                 break;
>         default:
> -               ret =3D -EOPNOTSUPP;
> +               ret =3D ublk_handle_non_batch_cmd(cmd, issue_flags);

We should probably skip the if (data.header.q_id >=3D
ub->dev_info.nr_hw_queues) check for a non-batch command?

> +               break;
>         }
>  out:
>         return ret;
> @@ -4163,9 +4200,13 @@ static int ublk_ctrl_add_dev(const struct ublksrv_=
ctrl_cmd *header)
>
>         ub->dev_info.flags |=3D UBLK_F_CMD_IOCTL_ENCODE |
>                 UBLK_F_URING_CMD_COMP_IN_TASK |
> -               UBLK_F_PER_IO_DAEMON |
> +               (ublk_dev_support_batch_io(ub) ? 0 : UBLK_F_PER_IO_DAEMON=
) |

Seems redundant with the logic below to clear UBLK_F_PER_IO_DAEMON if
(ublk_dev_support_batch_io(ub))?

>                 UBLK_F_BUF_REG_OFF_DAEMON;
>
> +       /* So far, UBLK_F_PER_IO_DAEMON won't be exposed for BATCH_IO */
> +       if (ublk_dev_support_batch_io(ub))
> +               ub->dev_info.flags &=3D ~UBLK_F_PER_IO_DAEMON;
> +
>         /* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
>         if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY |
>                                 UBLK_F_AUTO_BUF_REG))
> @@ -4518,6 +4559,13 @@ static int ublk_wait_for_idle_io(struct ublk_devic=
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
> index cd894c1d188e..5e8b1211b7f4 100644
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

Seems like it might make sense to provided batched versions of
UBLK_U_IO_REGISTER_IO_BUF and UBLK_U_IO_UNREGISTER_IO_BUF. That could
be done in the future, I guess, but it might simplify
ublk_ch_batch_io_uring_cmd() to only have to handle struct
ublk_batch_io.

> + *
> + * The existing UBLK_U_IO_FETCH_REQ, UBLK_U_IO_COMMIT_AND_FETCH_REQ and
> + * UBLK_U_IO_GET_DATA uring_cmd are not supported for this feature.

UBLK_U_IO_NEED_GET_DATA?

Best,
Caleb

> + */
> +#define UBLK_F_BATCH_IO                (1ULL << 15)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> --
> 2.47.0
>
