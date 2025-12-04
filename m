Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894183148A8
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764817922; cv=none; b=sWeFC42DYHBMsn6wPaNX/8FwDOr9WxDlSZcrtYO4u5uV+vAO0iYghp9uxommQVPrQ8uM6U4DQqVidIa8KU8jsWk1uBPkCfJ3Bm9TObmh+nSY/nohHQnYm9L2lI0bGkfTobU51ThOtkyRRDyXpZBkQ0GGte+pcKr/UL4p1r+RMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764817922; c=relaxed/simple;
	bh=f0Oq3PGKk2mPGjPKREeyXV87NUVBIXHz7ZTSfizPfwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dvjj2suPjp3b1I368+uChizyyIlNjeIcRBR0uKv4YolCr5ZYQKQWaTN/QZo/UEiDDOCv2ealVPvt3zz//21O1B8gOCfa2cK2wxSA+o+AfjL2cnl1vivqxcqybz44+bDU06Dix1ajnrB22vK3uv8B6KZGIvP5kqLYvvcy5c9yaZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=flv+cpqp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="flv+cpqp"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b9da0ae5763so15918a12.0
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 19:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764817917; x=1765422717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUc1Bp8d0WHYMovXDR/7gJjEBOkG2gXSQN5TMf8QUos=;
        b=flv+cpqp2/0iCLjrMB1H8L3LoWgXWplGojlkDjxmp+xSKcQfW232NpoLj4PiS994da
         W6t9eA0JBJmYZmS5qivdQ+aQqGPepqmRGAFgbAqDpzaEhAp2NN72uVDLHe0/8bR4dLUt
         VchI8376xRTS3WesNSMQveC+rWYhZcLvI5N8UZQL1o0JrFZYNUccx2zXM2kD5BuigVFU
         RAqspBl4gy7x2t8TJpPrmgoW0Uv2ZJ3rRSq+W+49tHummRL4pEWJfRtcwgIUq5Yp/bni
         5Oiw8NhdfM9X1sBW8ByE3K90rqWVopySSvQIwIyjwNsYmfzvk0AXS/JhnJWXUh2fN6ZP
         +7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764817917; x=1765422717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yUc1Bp8d0WHYMovXDR/7gJjEBOkG2gXSQN5TMf8QUos=;
        b=BxyLgpUBjKIQuv77l0BxhRwF52mAjJNFbSjNUwCQYQ6O9VfCos/19ZxZfJpNpvJDJM
         RJOtEeGEYGYka4DREp6FipB8ZqSlUzlseIBWZvqjxQBu7w3M97sK6XZ5AqhFqQUQdk3h
         Fkja86KORqmYbrwanLpZunVv7LF8nlOu2gddkECXa72QYGsH9ViipQ6OlIDX0/5XLZZt
         hfdVKl2IYUjTmmjo0ne9ZCTa4idKTXsTZur+Vil31RSK59EPwJT+WfiNh/vRoMqhFP8e
         WQzcATo7OYBmfVr6ztUNwpZh7XzEpJqMKYtVNa2bfUFkusLmIpBHMYrFfDyI3nl+0HXn
         50Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVRDGiEoXcTnQiS6868ZpKaXHe3ZGZCr45FZyD3hfQh5TQX6s9lkBZ0/8qGYKK/JWnzNe1IXpxtv3dVGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGA+gWI/6rYCJlBGzPsnkJjupSIntywPFvNNPNDEocp6A97Boc
	UIl2yeVXqIjMJeI8x5N5CGzYbrb5LK/EjL6mZaS1eWWdiUFExl3gtQi0LcpLwaNOm7Z3WaIsVMV
	Pn0T0AEqSrH8vOCDspuK2kV6EXsO44gjr82u1urdQJQ==
X-Gm-Gg: ASbGnctMGvYuQ3MgAgLhg4tI8zUnBbm8cYAxLmwflRM1B+TpS7h1Dqql4fRdP4n4kfz
	aLp82VoCEGTFiHcf5+8QdMIZ4voIrkoOYVWAoE40wuVbr/oM5hAlBnYC2SX59y+HJy0GjDy9UM5
	9U6QJI0r0en3BtaY9uO5OD27v+701dYFyV7iCQxLwxayQ+omm9MEYNVQslXIeJSAv6SSx6w7Tza
	G+LcVHtKzYWwpD3WsI01p34ZokMUwIUJMPSs12vEwNKNTr78wtnFCAbA2aRjVfMPAM1a0grecex
	caaYfO8=
X-Google-Smtp-Source: AGHT+IE8pWgHZiziUNc8GOC9mqhvx5OIF3LZ7YqFD5rQcLGoqryjlQ7X3Jig+n0wegvYheRCKf2n8FU04yTJdiY5oi4=
X-Received: by 2002:a05:7022:f410:b0:11a:5cb2:24a0 with SMTP id
 a92af1059eb24-11df252cba1mr2562291c88.1.1764817916303; Wed, 03 Dec 2025
 19:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202121917.1412280-1-ming.lei@redhat.com> <20251202121917.1412280-6-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-6-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 3 Dec 2025 19:11:45 -0800
X-Gm-Features: AWmQ_bkigaJ53DKn6jy05pUXX7yddnR-o-0O465Z9vlhQA7DHDgbdSJVXenksUE
Message-ID: <CADUfDZofqWppGZzBqOaAuddRTQ0FZqvFm567pbZWbwOKDhOLQg@mail.gmail.com>
Subject: Re: [PATCH V5 05/21] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:20=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Handle UBLK_U_IO_COMMIT_IO_CMDS by walking the uring_cmd fixed buffer:
>
> - read each element into one temp buffer in batch style
>
> - parse and apply each element for committing io result
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 103 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |   8 +++
>  2 files changed, 109 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 380553a6f299..5cc95e13295d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2098,7 +2098,7 @@ static inline int ublk_set_auto_buf_reg(struct ublk=
_io *io, struct io_uring_cmd
>         return 0;
>  }
>
> -static int ublk_handle_auto_buf_reg(struct ublk_io *io,
> +static void ublk_clear_auto_buf_reg(struct ublk_io *io,
>                                     struct io_uring_cmd *cmd,
>                                     u16 *buf_idx)
>  {
> @@ -2118,7 +2118,13 @@ static int ublk_handle_auto_buf_reg(struct ublk_io=
 *io,
>                 if (io->buf_ctx_handle =3D=3D io_uring_cmd_ctx_handle(cmd=
))
>                         *buf_idx =3D io->buf.auto_reg.index;
>         }
> +}
>
> +static int ublk_handle_auto_buf_reg(struct ublk_io *io,
> +                                   struct io_uring_cmd *cmd,
> +                                   u16 *buf_idx)
> +{
> +       ublk_clear_auto_buf_reg(io, cmd, buf_idx);
>         return ublk_set_auto_buf_reg(io, cmd);
>  }
>
> @@ -2553,6 +2559,17 @@ static inline __u64 ublk_batch_buf_addr(const stru=
ct ublk_batch_io *uc,
>         return 0;
>  }
>
> +static inline __u64 ublk_batch_zone_lba(const struct ublk_batch_io *uc,
> +                                       const struct ublk_elem_header *el=
em)
> +{
> +       const void *buf =3D elem;
> +
> +       if (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA)
> +               return *(const __u64 *)(buf + sizeof(*elem) +
> +                               8 * !!(uc->flags & UBLK_BATCH_F_HAS_BUF_A=
DDR));
> +       return -1;
> +}
> +
>  static struct ublk_auto_buf_reg
>  ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
>                         const struct ublk_elem_header *elem)
> @@ -2708,6 +2725,84 @@ static int ublk_handle_batch_prep_cmd(const struct=
 ublk_batch_io_data *data)
>         return ret;
>  }
>
> +static int ublk_batch_commit_io_check(const struct ublk_queue *ubq,
> +                                     struct ublk_io *io,
> +                                     union ublk_io_buf *buf)
> +{
> +       if (io->flags & UBLK_IO_FLAG_ACTIVE)

I think this needs to check for UBLK_IO_FLAG_OWNED_BY_SRV instead.
Otherwise, it will allow committing ublk_io's that have never been
fetched.

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +               return -EBUSY;
> +
> +       /* BATCH_IO doesn't support UBLK_F_NEED_GET_DATA */
> +       if (ublk_need_map_io(ubq) && !buf->addr)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +static int ublk_batch_commit_io(struct ublk_queue *ubq,
> +                               const struct ublk_batch_io_data *data,
> +                               const struct ublk_elem_header *elem)
> +{
> +       struct ublk_io *io =3D &ubq->ios[elem->tag];
> +       const struct ublk_batch_io *uc =3D &data->header;
> +       u16 buf_idx =3D UBLK_INVALID_BUF_IDX;
> +       union ublk_io_buf buf =3D { 0 };
> +       struct request *req =3D NULL;
> +       bool auto_reg =3D false;
> +       bool compl =3D false;
> +       int ret;
> +
> +       if (ublk_dev_support_auto_buf_reg(data->ub)) {
> +               buf.auto_reg =3D ublk_batch_auto_buf_reg(uc, elem);
> +               auto_reg =3D true;
> +       } else if (ublk_dev_need_map_io(data->ub))
> +               buf.addr =3D ublk_batch_buf_addr(uc, elem);
> +
> +       ublk_io_lock(io);
> +       ret =3D ublk_batch_commit_io_check(ubq, io, &buf);
> +       if (!ret) {
> +               io->res =3D elem->result;
> +               io->buf =3D buf;
> +               req =3D ublk_fill_io_cmd(io, data->cmd);
> +
> +               if (auto_reg)
> +                       ublk_clear_auto_buf_reg(io, data->cmd, &buf_idx);
> +               compl =3D ublk_need_complete_req(data->ub, io);
> +       }
> +       ublk_io_unlock(io);
> +
> +       if (unlikely(ret)) {
> +               pr_warn_ratelimited("%s: dev %u queue %u io %u: commit fa=
ilure %d\n",
> +                       __func__, data->ub->dev_info.dev_id, ubq->q_id,
> +                       elem->tag, ret);
> +               return ret;
> +       }
> +
> +       /* can't touch 'ublk_io' any more */
> +       if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
> +               io_buffer_unregister_bvec(data->cmd, buf_idx, data->issue=
_flags);
> +       if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> +               req->__sector =3D ublk_batch_zone_lba(uc, elem);
> +       if (compl)
> +               __ublk_complete_rq(req, io, ublk_dev_need_map_io(data->ub=
));
> +       return 0;
> +}
> +
> +static int ublk_handle_batch_commit_cmd(const struct ublk_batch_io_data =
*data)
> +{
> +       const struct ublk_batch_io *uc =3D &data->header;
> +       struct io_uring_cmd *cmd =3D data->cmd;
> +       struct ublk_batch_io_iter iter =3D {
> +               .uaddr =3D u64_to_user_ptr(READ_ONCE(cmd->sqe->addr)),
> +               .total =3D uc->nr_elem * uc->elem_bytes,
> +               .elem_bytes =3D uc->elem_bytes,
> +       };
> +       int ret;
> +
> +       ret =3D ublk_walk_cmd_buf(&iter, data, ublk_batch_commit_io);
> +
> +       return iter.done =3D=3D 0 ? ret : iter.done;
> +}
> +
>  static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
>  {
>         unsigned elem_bytes =3D sizeof(struct ublk_elem_header);
> @@ -2783,7 +2878,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uri=
ng_cmd *cmd,
>                 ret =3D ublk_check_batch_cmd(&data);
>                 if (ret)
>                         goto out;
> -               ret =3D -EOPNOTSUPP;
> +               ret =3D ublk_handle_batch_commit_cmd(&data);
>                 break;
>         default:
>                 ret =3D -EOPNOTSUPP;
> @@ -3444,6 +3539,10 @@ static int ublk_ctrl_add_dev(const struct ublksrv_=
ctrl_cmd *header)
>                                 UBLK_F_AUTO_BUF_REG))
>                 ub->dev_info.flags &=3D ~UBLK_F_NEED_GET_DATA;
>
> +       /* UBLK_F_BATCH_IO doesn't support GET_DATA */
> +       if (ublk_dev_support_batch_io(ub))
> +               ub->dev_info.flags &=3D ~UBLK_F_NEED_GET_DATA;
> +
>         /*
>          * Zoned storage support requires reuse `ublksrv_io_cmd->addr` fo=
r
>          * returning write_append_lba, which is only allowed in case of
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index c96c299057c3..295ec8f34173 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -109,6 +109,14 @@
>   */
>  #define        UBLK_U_IO_PREP_IO_CMDS  \
>         _IOWR('u', 0x25, struct ublk_batch_io)
> +/*
> + * If failure code is returned, nothing in the command buffer is handled=
.
> + * Otherwise, the returned value means how many bytes in command buffer
> + * are handled actually, then number of handled IOs can be calculated wi=
th
> + * `elem_bytes` for each IO. IOs in the remained bytes are not committed=
,
> + * userspace has to check return value for dealing with partial committi=
ng
> + * correctly.
> + */
>  #define        UBLK_U_IO_COMMIT_IO_CMDS        \
>         _IOWR('u', 0x26, struct ublk_batch_io)
>
> --
> 2.47.0
>
