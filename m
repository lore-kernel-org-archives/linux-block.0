Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1A1E5714
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764520803; cv=none; b=Zg75Qkybze0AzyQc1Tc9o3aFm4R96SA7qdAbFftL2HbklUoiURFzleLugO27DiOnGmtpsEsgsNHJswXj8lbHy8m9oXBRB0Jt8MhoinlYNEuI4rCUg9Z4KypmRg94jR2afluMJccKBUpcEQHtn//T5V+wGqWR5DnzFjxZV7NfEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764520803; c=relaxed/simple;
	bh=vCIH79OP85DU3UV5SnR5UY7fn+7Q3PTy6HaFYYS0aSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrRZLFvA/GCOWlb7MI/b0PQAiFPp2EmZ35VePoOFWn/LXImYBXBlI3Bta9FZVNPub0xAr7QfsKHr/GhxmSjU82tymIeniMw2dbBtYRnzLVWNexZlgoVbO514voDZpk/OHWUx7mu5iccJNUzkSATe0VAwWgjhOpGN5ZQA5ndHbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bcsk+A45; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bcsk+A45"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297f6ccc890so5037005ad.2
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 08:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764520801; x=1765125601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OI6ttDUOs56mH4MnPD9D+L7Y65zkFOivoAkfHxCdgg=;
        b=bcsk+A45a10ZPkzCbTjplXFqnGNhpA4XFbhPVEhvczkIrFO2bTKJiZM5/I5f3t6Yi6
         BLCqUksoz2Km1YwbgKKgIIogsMzq5VcKeuBW79grFHgaqTHxFPEc3Hcy7TqhHs35Mk1K
         oTGSyYLt+Zi9fQxmBJEQ/JYtzHTdzLFlAyFVPipIJoIFwxX82zY5gD6rfqzj2/6MWjXy
         Tat4MCq1Y3bv/nUci+FNhMsmWt4J1aqCshtsFFVYr8LebxhpMsL4yMKc+55MiuExXtye
         R8XkcSIYpkVdY7oxGQhuWtrmJO1qbHhQULICkRA98YH2R5ehQ3T/UcAqUU87om1beSr6
         IbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764520801; x=1765125601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OI6ttDUOs56mH4MnPD9D+L7Y65zkFOivoAkfHxCdgg=;
        b=chrtiWZZnBpqjVvcOAZ06e8DXaBsMYrMPmcs5Zu4Iibr/1h70C2McKsVWC7DmKc8uJ
         BQ+pr+OPwsygU6+EpDPEz9ZWo6+TP2JWd8OLxF66uV9ndMCcnCGTGOtYb14rvoOue3Wy
         ndWZpIl/3HO74qKghffxB/7z2Lf6xRDBW+gmpci3V7NXxHNvFqJuD909H17Je07EQ4/f
         76r5Y1LoADAnA88V8omDeFrDnyAP62ZKHVyM0VfLbkfycHs8VW4OUTQ54Sm575b3B4L/
         fwPqBeFXCsR9Y5K7lanwZhWDqaZ1cMvRIRsy340O9tFwcN0mgBhy3vQiz/br/h8ZyATF
         /Exg==
X-Forwarded-Encrypted: i=1; AJvYcCVgHMB3URMfnzn6/Pv8Nmnp3wa3gZmX5+wBnawBc6Ulr6kwnMP0q1Hyz84wi7gUwuqj79q2QhdOTR5srg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PIaq1YK/x4XqFyJ2/LO3LJE5zJ7TIml2sOw/m8w8ePzEr6qj
	+SdAt4ukTV91Vi6g2PXS4bOkZQLWWuO/vxBB5U8ob7mSSue+kXc2EbD3j7mLbqnx02HlhYFWjAF
	Z+EyjWdHYa1l8HRkvfzOFzvorVBh/RwM06Hc+5L5/gg==
X-Gm-Gg: ASbGncs0QCGwlUJEcrFeNkX/yAeLxBMpKUKhqgEjlC2sxUWwDt+IOMP8iKRmKqGlw+O
	oa+ZqexsnKoDPJCOQ3iiZEwAJWaDSqEmczzgafIdaEVi+JIfc17P9o8Abf2gxT7OJ62YM9pqW9k
	cPSTkiOJrQECSUdv0tvGZyY9m4OFgMsm25GuhwGA6LVjLrjFhTwgyCJDwXDQ4s+6VmerKfQ1Bop
	QyO39YgUqMkX7n+o+uZEmE4ZRpcAGS/km8jvDnAnbOUaWxcQ2GQ1Y3X+IQb4sxhoQFEhmnm
X-Google-Smtp-Source: AGHT+IGySlw9Txe/oF4uSdUz2G9AxrH7Db7sl6zbeYBJd9AQHZjDUkh9D4SOjRajPJy9BpV9dnOPGoc3QUbWQt7S5u0=
X-Received: by 2002:a05:7022:42aa:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-11c9f2d50a6mr19678545c88.1.1764520800952; Sun, 30 Nov 2025
 08:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-12-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-12-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 30 Nov 2025 08:39:49 -0800
X-Gm-Features: AWmQ_bmISrvxFZzr6T0tSLM3nKENacydwkSMdTgjaVqRy7dpmUBWdZ-AL7FXZzY
Message-ID: <CADUfDZqtoN=Xv17txG5cZ9foD3ToxgiiW_DSgnABG2ocK7p-UQ@mail.gmail.com>
Subject: Re: [PATCH V4 11/27] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 5:59=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Handle UBLK_U_IO_COMMIT_IO_CMDS by walking the uring_cmd fixed buffer:
>
> - read each element into one temp buffer in batch style
>
> - parse and apply each element for committing io result
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 117 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/ublk_cmd.h |   8 +++
>  2 files changed, 121 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66c77daae955..ea992366af5b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2098,9 +2098,9 @@ static inline int ublk_set_auto_buf_reg(struct ublk=
_io *io, struct io_uring_cmd
>         return 0;
>  }
>
> -static int ublk_handle_auto_buf_reg(struct ublk_io *io,
> -                                   struct io_uring_cmd *cmd,
> -                                   u16 *buf_idx)
> +static void __ublk_handle_auto_buf_reg(struct ublk_io *io,
> +                                      struct io_uring_cmd *cmd,
> +                                      u16 *buf_idx)

The name could be a bit more descriptive. How about "ublk_clear_auto_buf_re=
g()"?

>  {
>         if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
>                 io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
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
> +       __ublk_handle_auto_buf_reg(io, cmd, buf_idx);
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
> +       const void *buf =3D (const void *)elem;

Unnecessary cast

> +
> +       if (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA)
> +               return *(__u64 *)(buf + sizeof(*elem) +
> +                               8 * !!(uc->flags & UBLK_BATCH_F_HAS_BUF_A=
DDR));

Cast to a const pointer?


> +       return -1;
> +}
> +
>  static struct ublk_auto_buf_reg
>  ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
>                         const struct ublk_elem_header *elem)
> @@ -2708,6 +2725,98 @@ static int ublk_handle_batch_prep_cmd(const struct=
 ublk_batch_io_data *data)
>         return ret;
>  }
>
> +static int ublk_batch_commit_io_check(const struct ublk_queue *ubq,
> +                                     struct ublk_io *io,
> +                                     union ublk_io_buf *buf)
> +{
> +       struct request *req =3D io->req;
> +
> +       if (!req)
> +               return -EINVAL;

This check seems redundant with the UBLK_IO_FLAG_OWNED_BY_SRV check?

> +
> +       if (io->flags & UBLK_IO_FLAG_ACTIVE)
> +               return -EBUSY;

Aren't UBLK_IO_FLAG_ACTIVE and UBLK_IO_FLAG_OWNED_BY_SRV mutually
exclusive? Then this check is also redundant with the
UBLK_IO_FLAG_OWNED_BY_SRV check.

> +
> +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> +               return -EINVAL;
> +
> +       if (ublk_need_map_io(ubq)) {
> +               /*
> +                * COMMIT_AND_FETCH_REQ has to provide IO buffer if
> +                * NEED GET DATA is not enabled or it is Read IO.
> +                */
> +               if (!buf->addr && (!ublk_need_get_data(ubq) ||
> +                                       req_op(req) =3D=3D REQ_OP_READ))
> +                       return -EINVAL;
> +       }
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
> +                       __ublk_handle_auto_buf_reg(io, data->cmd, &buf_id=
x);
> +               compl =3D ublk_need_complete_req(data->ub, io);
> +       }
> +       ublk_io_unlock(io);
> +
> +       if (unlikely(ret)) {
> +               pr_warn("%s: dev %u queue %u io %u: commit failure %d\n",
> +                       __func__, data->ub->dev_info.dev_id, ubq->q_id,
> +                       elem->tag, ret);

This warning can be triggered by userspace. It should probably be
rate-limited or changed to pr_devel().

Best,
Caleb

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
> @@ -2783,7 +2892,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uri=
ng_cmd *cmd,
>                 ret =3D ublk_check_batch_cmd(&data);
>                 if (ret)
>                         goto out;
> -               ret =3D -EOPNOTSUPP;
> +               ret =3D ublk_handle_batch_commit_cmd(&data);
>                 break;
>         default:
>                 ret =3D -EOPNOTSUPP;
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
