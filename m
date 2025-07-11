Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848231FBEA6
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241692; cv=none; b=os8bOBjl90tMOgB0SWgYFwRwVrgBt4fSZqKXk5iCMf+n9PieVjcoV8emQn8wsa4xYPiYs6ZiH9675gXV9Obm0wgpo0hL2VLVAqgKrfYw5t7EgUcyc1ghYHrFIbYL8hVpw9jEBvYfK8QPnEevYW0WpIn3E4aqnSKc829DyEghc1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241692; c=relaxed/simple;
	bh=qMWWsEWR89+uhbzmWqmsGi2FwEDGKC2SsyL7wOg8080=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/MGSHGDyu/n0iGhjBXLj4UlMCkhdAbrp06C8L8V7Pynh7xG+jUAmvNWYOQ0LtL4VSEsMKmtnUbT+p6UnMJcjlGNlYvByYWQSK3Q1Ee7iSlwdhK9m8ehgDNAxjM9RLoBVzT8Wq3I1DXxQEMHfV774xDg7V/jj/P66jwFQfbPAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZFOZXk5V; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZFOZXk5V"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-312efc384fcso344100a91.3
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752241690; x=1752846490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qyEXmBGGxkxmXiiock3IaLQjTrH8oXt6jPtau7L8B4=;
        b=ZFOZXk5V6qbJveUVm/JjhJsF2oXPXrbfKIkcsF6kMamjd2fUN6A5HRjc3Ex+xDkuO9
         6n0C2emNsjZ4bbtKesOr6OGZAMjJcVA5VtamuTSJQarFE0L1EUK7QeTnp1GavoD5K6u/
         B+0dZ7rNBkXSZWiX9SfGzRTYyLKnU7FKMUe4Qtzog/MQptTODlX3QfJKGUAGhWF8Qzo5
         iRQ4oO8ofP8u5mf6rZJahJhCNT7sTEeLkf3hR4dneQufCP7wxymplMtgmC/egbF6bhKA
         bl857kjen4n7JhBOBxD59US6yhcPjemenyDa17iaVfUuc2d/J8Y47kPjX/LAUivjLoqm
         fCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241690; x=1752846490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qyEXmBGGxkxmXiiock3IaLQjTrH8oXt6jPtau7L8B4=;
        b=XUWCtPJudySapImFgDt6KQfM+5nZlBlXa4mJ/el973n+P05ABM9F3HfOSD/LWdW0C2
         fqo+ed+7zQoNjuXN345u1Ri+AGaWJYuWTSDl+JBpA3JCW6mf8VkXb4Bwodg3jlJYMNQD
         iDBgBem8YnK14x4ZdzX0n+lTVLwP0ama/tOdOsJS1jiKt35rF7RFnTWgbfkHTd7TPWKM
         8IZRzGxm6LuOCiSUuXrtlb9nsuLrk+z4BYW2L0dCls+Ytu5kmmnZ0/+ZmojMc3mBKEZC
         p/Th8MpNWQdRfIsQx38Vij4pibILWJxKVCKmJA7gYSHv1iiWLVA8IILS5E1MTP3sw3/B
         q+9w==
X-Forwarded-Encrypted: i=1; AJvYcCVlAI6kiMVBzVJ67f78BDtOPuHhY6OxxHrOUgvW0axtJuixxOFifFTokyDSqLaVGeSInuc8n/dlGYHNng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhkmZgDNbHI+if3qgH4bT+XrQH2xDkkvxl48Wt/NrVFUM9X9F
	T0abiVMwxZKN4lJ4AMxxIV05svW3WADq8nDXvnzz1ryM9ngpmI1SUfrZzB308lQtNqCr73NofXP
	Mp7TXYxEsunQuWjxUkV/OEZQnPjy7SkNg8ERNJlJHUkWUM/UDeFGuu34FVQ==
X-Gm-Gg: ASbGncvToc2nxtiqwT2R5/GWqWANVHTZMHprBnhqIQICMGe6q2eNKPdRJ20Jp57krjP
	tVcfTVV50r/B3DcHF1kNONfy6f+cG50LMU5oh+5m9DKY68ITl6fKYbzdQTWjGyQf0H5wqeu3LNA
	Kv5ArwtFe5vcw8m5rjhYhiYUJRcGYBc8dBl3amYfDRv4PqABKij2Ja4ANncmnUx/e2Qco71Zacg
	p+QML1k
X-Google-Smtp-Source: AGHT+IEiJU24Ww0J+ZJPXcta9v1K7QaFRMVzib74fyQjtlQ9tHa+7x7ikgbhfWuECcukn3zjOHAtJ5DYmJJRS8/FdYE=
X-Received: by 2002:a17:90b:568f:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-31c4f510b7emr1406652a91.3.1752241689565; Fri, 11 Jul 2025
 06:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708011746.2193389-1-ming.lei@redhat.com> <20250708011746.2193389-6-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-6-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 11 Jul 2025 09:47:56 -0400
X-Gm-Features: Ac12FXyJtTPtU1pqlpIrYzslVlwbQnSISaE3lKUnbJxtxyo0ISimZAdshiLODWY
Message-ID: <CADUfDZqZTJmz4bN99P6tRTL__8Uu6Lt=qLwwOFB2yTMb=XiBfg@mail.gmail.com>
Subject: Re: [PATCH V2 05/16] ublk: move auto buffer register handling into
 one dedicated helper
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:18=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
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
>  drivers/block/ublk_drv.c | 131 ++++++++++++++++++++++-----------------
>  1 file changed, 75 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 41248b0d1182..dab02a8be41a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -48,6 +48,8 @@
>
>  #define UBLK_MINORS            (1U << MINORBITS)
>
> +#define UBLK_INVALID_BUF_IDX   ((u16)-1)
> +
>  /* private ioctl command mirror */
>  #define UBLK_CMD_DEL_DEV_ASYNC _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
>  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> @@ -2002,16 +2004,52 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
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
))
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
> @@ -2020,6 +2058,22 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uri=
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

I mentioned this before, but just return ublk_handle_auto_buf_reg(io,
cmd, buf_idx) to avoid the intermediate variable?

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
> @@ -2035,20 +2089,6 @@ static inline void ublk_prep_cancel(struct io_urin=
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
> @@ -2169,13 +2209,11 @@ static int ublk_fetch(struct io_uring_cmd *cmd, s=
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
> @@ -2207,35 +2245,13 @@ static int ublk_check_commit_and_fetch(const stru=
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
> @@ -2244,7 +2260,6 @@ static int ublk_commit_and_fetch(const struct ublk_=
queue *ubq,
>                 ublk_sub_req_ref(io, req);
>         else
>                 __ublk_complete_rq(req);
> -       return 0;
>  }
>
>  static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *=
io,
> @@ -2269,6 +2284,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>                                unsigned int issue_flags,
>                                const struct ublksrv_io_cmd *ub_cmd)
>  {
> +       u16 buf_idx =3D UBLK_INVALID_BUF_IDX;
>         struct ublk_device *ub =3D cmd->file->private_data;
>         struct ublk_queue *ubq;
>         struct ublk_io *io;
> @@ -2347,9 +2363,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
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
> @@ -2359,7 +2376,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
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
