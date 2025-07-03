Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0027876A
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751574004; cv=none; b=agaVClGOMxmeoN+1qDFU16NE9xhXgJZq86ifXnL02PwPAfmRKbleTxwajrI+14OZAGCHzMs6Cqfj2Y49DnfwQTUONrBJdoibpS6FT7CldGSq7K8tbiyWKsYnsUO7nvZC3gWL95QL8fS5Fy96cGjBW7oDQnL8T5pP9y8YF5YzK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751574004; c=relaxed/simple;
	bh=ZL3LSoWex+N1sha1HHZurFmS7U8ra6AwBkqYvZSeRLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onQ1arPq7sg1SZT7FHhb/bbC9VXqj6UzlNNyv/hiMmVrLoYFgB0BTiXObFJxjMT+HF9zWzMXD49DKZ7NqiLGp7pnzqJpOQAtiq3LA9pE/EBbUSxoN9xIC95el39eE53IQagMB/I9Vbq35UP83/kZZphAehEd6ozfElImAGwMzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DKdVpz7d; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DKdVpz7d"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-312efc384fcso53723a91.3
        for <linux-block@vger.kernel.org>; Thu, 03 Jul 2025 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751574002; x=1752178802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+sz/GvnopVAnCpdS9DfAZX6gS6QkI2dpT4hh/H/foc=;
        b=DKdVpz7dzbXIPgqPKhrdDI0tg209L6x7lUZRMNwreE3iS9nTsPEsdCj9p2UABOPJod
         wrWDzeFu0OhsCuYXNJ0QpheYjc7OyfnErBM0/gqNHbVeUDnnk42OKwiWg4RAcQ7F8YqF
         L5ncP55B/Ns++14f53b/KxXgJaoAymlpdHUjXAdNaGx68qRDnlzUUwuZPJuS2LSvoSca
         BbssjNNXw+MkOKROYFnXuBYVRq3+lYl7rCV7yANNAomX83kwK0G0CDBmml0lVbnBuhFx
         /zSQWdR5X1voiQqjGiKVvZc6UcOzil3D3iPJQTHj2yZ7SpxavsK/PbojfMEqz57cc4gB
         +AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751574002; x=1752178802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+sz/GvnopVAnCpdS9DfAZX6gS6QkI2dpT4hh/H/foc=;
        b=k3HeUTtU2KcPAukgE937vTFl0Zt4ycI0738npg422dymcBKPS1EzLsYeLcTb6DbXwd
         WydbcqmjpXwMId0gjrzED/S5Xyvagi1TDSZPbD4tsU/WSCK+H/pozOu40zBrH8qD80en
         H/TObMBfcKYYbZgLilAeohbL06UCjuI5I0rzG/JkC0Oxjf53L4WiHqhBAouBjn6oP8VD
         IP2MJJy1/sVdfxyjcyAZy+7R6geUEJDxp7uW0BiN8hAqIEEAr/ti5msfUmOUaTrG3cyH
         TNq2vVmwJa6satflgCzb6uswmHGIsa1kOhFHjEmidvUHO3gRXCXjA1ViLtck5aPUE2wF
         gWtw==
X-Forwarded-Encrypted: i=1; AJvYcCUxVmRBfGtPwSndSDSTFk50BwJ7TODGFgqK687SJkgvQqDp7yh5GkAOZxaQ3glMDtKkT89X+gi4+0/HqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkZHwGOnDrHOzcUvtXt0m+1Nplg5hFqYfo1Q54QF70dk+ZZaX
	+PlCXjhFoYzOf519VFbJ18XQnKQPzlz099Xnm9jh+0MuAciuisPehXRbweckqD/E6Ry0Ip/6O1y
	9ruo09ZNhhJ2+Qa7jZvpi8y92uAKki7VgasA3RuJDzw==
X-Gm-Gg: ASbGncuHmZ5sI+Dy2m4a033TZLTzPLtoU5PyBka8iqz/4TbHuFRFRJ/+LRKRhTDX4TT
	5D69WfhypVF0zXXtiSzieelicz+RV1dFaHVqdIWYXOa8+7p73geC3TLmpc7CyBdMW6P7jhwj4Q6
	WYucMlDBIFZ7noOotmZcrsCevs60PONFOwi/z8FRgDHw==
X-Google-Smtp-Source: AGHT+IEvLhfBLH7mNQ/MDcDv4nv6XZ+MLwUU1g48DUjWOBBZzh7jLmEsA7joR7pyXqrdYoD3p6FRVfkeLSrr0xvxBq8=
X-Received: by 2002:a17:90b:1b42:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-31a90bdc205mr3976961a91.4.1751574002077; Thu, 03 Jul 2025
 13:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702040344.1544077-1-ming.lei@redhat.com> <20250702040344.1544077-6-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-6-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 3 Jul 2025 16:19:50 -0400
X-Gm-Features: Ac12FXxrQUSRMgsDt9oGExRYs96kmed-BBPQpeW-06ousvQ-K9B4jltkK03mdbc
Message-ID: <CADUfDZpaNOqvqwMNUi_YavV9nHc8tkmPhZHKkx7UVk3W=Pbn6w@mail.gmail.com>
Subject: Re: [PATCH 05/16] ublk: move auto buffer register handling into one
 dedicated helper
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:04=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Move check & clearing UBLK_IO_FLAG_AUTO_BUF_REG to
> ublk_handle_auto_buf_reg(), also return buffer index from this helper.
>
> Also move ublk_set_auto_buf_reg() to this single helper too.
>
> Add ublk_config_io_buf() for setting up ublk io buffer, covers both
> ublk buffer copy or auto buffer register.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 132 ++++++++++++++++++++++-----------------
>  1 file changed, 76 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1780f9ce3a24..ba1b2672e7a8 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -48,6 +48,8 @@
>
>  #define UBLK_MINORS            (1U << MINORBITS)
>
> +#define UBLK_INVALID_BUF_IDX   ((unsigned short)-1)

u16?

> +
>  /* private ioctl command mirror */
>  #define UBLK_CMD_DEL_DEV_ASYNC _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
>  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> @@ -1983,16 +1985,53 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
>         return 0;
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
> +       if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +static int ublk_handle_auto_buf_reg(struct ublk_io *io,
> +                                   struct io_uring_cmd *cmd,
> +                                   u16 *buf_idx)
> +{
> +       if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> +               io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
> +
> +               /*
> +                * `UBLK_F_AUTO_BUF_REG` only works iff `UBLK_IO_FETCH_RE=
Q`
> +                * and `UBLK_IO_COMMIT_AND_FETCH_REQ` are issued from sam=
e
> +                * `io_ring_ctx`.
> +                *
> +                * If this uring_cmd's io_ring_ctx isn't same with the
> +                * one for registering the buffer, it is ublk server's
> +                * responsibility for unregistering the buffer, otherwise
> +                * this ublk request gets stuck.
> +                */
> +               if (io->buf_ctx_handle =3D=3D io_uring_cmd_ctx_handle(cmd=
) &&
> +                               buf_idx)

Not sure the buf_idx check here is necessary. This io->flags &
UBLK_IO_FLAG_AUTO_BUF_REG path should only be reachable from
ublk_commit_and_fetch(), not ublk_fetch() or UBLK_IO_NEED_GET_DATA.

> +                       *buf_idx =3D io->buf_index;
> +       }
> +
> +       return ublk_set_auto_buf_reg(cmd);
> +}
> +
>  /* Once we return, `io->req` can't be used any more */
>  static inline struct request *
> -ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd,
> -                unsigned long buf_addr, int result)
> +ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd, int resul=
t)
>  {
>         struct request *req =3D io->req;
>
>         io->cmd =3D cmd;
>         io->flags |=3D UBLK_IO_FLAG_ACTIVE;
> -       io->addr =3D buf_addr;
>         io->res =3D result;
>
>         /* now this cmd slot is owned by ublk driver */
> @@ -2001,6 +2040,22 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uri=
ng_cmd *cmd,
>         return req;
>  }
>
> +static inline int
> +ublk_config_io_buf(const struct ublk_queue *ubq, struct ublk_io *io,
> +                  struct io_uring_cmd *cmd, unsigned long buf_addr,
> +                  u16 *buf_idx)
> +{
> +       if (ublk_support_auto_buf_reg(ubq)) {
> +               int ret =3D ublk_handle_auto_buf_reg(io, cmd, buf_idx);
> +
> +               if (ret)
> +                       return ret;

Just return ublk_handle_auto_buf_reg(io, cmd, buf_idx)?

Other than that,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +       } else {
> +               io->addr =3D buf_addr;
> +       }
> +       return 0;
> +}
> +
>  static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
>                                     unsigned int issue_flags,
>                                     struct ublk_queue *ubq, unsigned int =
tag)
> @@ -2016,20 +2071,6 @@ static inline void ublk_prep_cancel(struct io_urin=
g_cmd *cmd,
>         io_uring_cmd_mark_cancelable(cmd, issue_flags);
>  }
>
> -static inline int ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
> -{
> -       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> -
> -       pdu->buf =3D ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->ad=
dr));
> -
> -       if (pdu->buf.reserved0 || pdu->buf.reserved1)
> -               return -EINVAL;
> -
> -       if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
> -               return -EINVAL;
> -       return 0;
> -}
> -
>  static void ublk_io_release(void *priv)
>  {
>         struct request *rq =3D priv;
> @@ -2150,13 +2191,11 @@ static int ublk_fetch(struct io_uring_cmd *cmd, s=
truct ublk_queue *ubq,
>                 goto out;
>         }
>
> -       if (ublk_support_auto_buf_reg(ubq)) {
> -               ret =3D ublk_set_auto_buf_reg(cmd);
> -               if (ret)
> -                       goto out;
> -       }
> +       ublk_fill_io_cmd(io, cmd, 0);
> +       ret =3D ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
> +       if (ret)
> +               goto out;
>
> -       ublk_fill_io_cmd(io, cmd, buf_addr, 0);
>         WRITE_ONCE(io->task, get_task_struct(current));
>         ublk_mark_io_ready(ub, ubq);
>  out:
> @@ -2188,35 +2227,13 @@ static int ublk_check_commit_and_fetch(const stru=
ct ublk_queue *ubq,
>         return 0;
>  }
>
> -static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
> -                                struct ublk_io *io, struct io_uring_cmd =
*cmd,
> -                                struct request *req, unsigned int issue_=
flags,
> -                                __u64 zone_append_lba)
> +static void ublk_commit_and_fetch(const struct ublk_queue *ubq,
> +                                 struct ublk_io *io, struct io_uring_cmd=
 *cmd,
> +                                 struct request *req, unsigned int issue=
_flags,
> +                                 __u64 zone_append_lba, u16 buf_idx)
>  {
> -       if (ublk_support_auto_buf_reg(ubq)) {
> -               int ret;
> -
> -               /*
> -                * `UBLK_F_AUTO_BUF_REG` only works iff `UBLK_IO_FETCH_RE=
Q`
> -                * and `UBLK_IO_COMMIT_AND_FETCH_REQ` are issued from sam=
e
> -                * `io_ring_ctx`.
> -                *
> -                * If this uring_cmd's io_ring_ctx isn't same with the
> -                * one for registering the buffer, it is ublk server's
> -                * responsibility for unregistering the buffer, otherwise
> -                * this ublk request gets stuck.
> -                */
> -               if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> -                       if (io->buf_ctx_handle =3D=3D io_uring_cmd_ctx_ha=
ndle(cmd))
> -                               io_buffer_unregister_bvec(cmd, io->buf_in=
dex,
> -                                               issue_flags);
> -                       io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
> -               }
> -
> -               ret =3D ublk_set_auto_buf_reg(cmd);
> -               if (ret)
> -                       return ret;
> -       }
> +       if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
> +               io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
>
>         if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
>                 req->__sector =3D zone_append_lba;
> @@ -2225,7 +2242,6 @@ static int ublk_commit_and_fetch(const struct ublk_=
queue *ubq,
>                 ublk_sub_req_ref(io, req);
>         else
>                 __ublk_complete_rq(req);
> -       return 0;
>  }
>
>  static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *=
io,
> @@ -2250,6 +2266,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>                                unsigned int issue_flags,
>                                const struct ublksrv_io_cmd *ub_cmd)
>  {
> +       u16 buf_idx =3D UBLK_INVALID_BUF_IDX;
>         struct ublk_device *ub =3D cmd->file->private_data;
>         struct ublk_queue *ubq;
>         struct ublk_io *io;
> @@ -2328,9 +2345,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
>                 ret =3D ublk_check_commit_and_fetch(ubq, io, ub_cmd->addr=
);
>                 if (ret)
>                         goto out;
> -               req =3D ublk_fill_io_cmd(io, cmd, ub_cmd->addr, ub_cmd->r=
esult);
> -               ret =3D ublk_commit_and_fetch(ubq, io, cmd, req, issue_fl=
ags,
> -                                           ub_cmd->zone_append_lba);
> +               req =3D ublk_fill_io_cmd(io, cmd, ub_cmd->result);
> +               ret =3D ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &b=
uf_idx);
> +               ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
> +                                     ub_cmd->zone_append_lba, buf_idx);
>                 if (ret)
>                         goto out;
>                 break;
> @@ -2340,7 +2358,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>                  * uring_cmd active first and prepare for handling new re=
queued
>                  * request
>                  */
> -               req =3D ublk_fill_io_cmd(io, cmd, ub_cmd->addr, 0);
> +               req =3D ublk_fill_io_cmd(io, cmd, 0);
> +               ret =3D ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, NU=
LL);
> +               WARN_ON_ONCE(ret);
>                 if (likely(ublk_get_data(ubq, io, req))) {
>                         __ublk_prep_compl_io_cmd(io, req);
>                         return UBLK_IO_RES_OK;
> --
> 2.47.0
>
