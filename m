Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7C1A5B9D
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872095; cv=none; b=muZb2O8VRFT0cPUToJaKiGOdig1eIz4j5OQHfS2JDfenPJvSQqbjFCHYTrxdnvSlzIantGEpxUasd7ALRbqsAi21MN8tR1mPvXncpUMhllcPO79Mr6r7Lm6ez/nVBwpGTdmQ7pGOCULtZfuwV0zI6ICjbMNF6Y8aW5TdFXZDTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872095; c=relaxed/simple;
	bh=+I8/6JVNi/DEl7zNSpHhFRnkY4k6uFRbe06HWiB7iBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4eN2eSbarirCLP65IwOf6RgOOegy5yJvkYNWSSTQkgD8vZVKWxNvABIJ7lrqEPsQZACNCfdFKGyswk8oY9Ghy2+63rScamZtMfvelLw4zUoO0p4gnPgWCEF1sqeShytcKp7VcPPFgq1wrCDJkQ7NvYQt+qi8yfSqY5Lt3qNB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CRUzXmlm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CRUzXmlm"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b046d1cd1fdso1700966b.2
        for <linux-block@vger.kernel.org>; Tue, 02 Sep 2025 21:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756872091; x=1757476891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UWFovfcm+sft7m7JVea8MjkKY8uC9aUGMaOca0lzKc=;
        b=CRUzXmlmpFuOd+whAh7+RbPkayCLdQzuWQLutYiGtWq+SUdJGVYZAp2Bfm+AhalQmF
         qCDQfBSnq3K46Zqx7EoaN3VE21a6MFD4JZZKBGvbtr7ultDFPqre6b7tLBus+Po7FP71
         uSeBSTQ0ZdOL6G7TCTmSOEQEmpH5quj37PZJ8KTXCjAmJjPsKuxMjKcwZrJe2lu05jcw
         u+qrnXNJrSN0aoEPWKeAe7eeT2o8iNZEGgq3XMcajtJiZuLM2gCSHeXYMpkoFrylpP4X
         9cBWoTqNXApIJf+0WjPtGx15VwaLkzjawo6y5Wr4ZLGviHREb13lU8j0m0eaHI2yQV8O
         rumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872091; x=1757476891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UWFovfcm+sft7m7JVea8MjkKY8uC9aUGMaOca0lzKc=;
        b=cJeacZrIVwOG/WPy6q/3QQex5WR2tMG1L74v5yhKegB5Spy/4URJ3TztR6I0uEtXae
         Ce2nrSNmS4hu3Yb57PBnGEnTl/73kZTaiT+7eX4Wab7SxM9S02JhMLIWFQpHf9UwKUTH
         XWwfeU7MgoMkoEXgeTfolHeo/Ys8mpHZvA4LDRCE1SyEq3MYmpn0uFIP5eZYk9m3o+jc
         Bxy19J59zjblN21oGnA0OS1gplHpNWGGzuaLJFGOwQlTZMNSexG0oycyAXMHUUOVRzDZ
         UfOzgfZB/fCxx73Ak8hZzWCDKL5eVmEBIObX+EXoflgJzLi3C2MUv5+dmqfD6O1HpZNG
         lKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Gz9o3ss6mA/VCEFy5M5jT4yXVuISa3P5icvxAQJ6X/B1qrg5nvgTn4vSP+BTM9U6Q6rTDBp0/e2MCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+E0myBhr15aR81bU+Cor8hY6G3Qlji6sdIDXyT87fEnnCMDAN
	DhM+EfUFHkS23/u1n1G+wK2sDyYo1nmSWReKZLS6S1oLEdyl6Dol2eEP3OtZz0dV8EoIqk2RAmr
	BkrZgSbaIbEg4OtL71eM25H0ewygXBUHp+hNX5Ed8gw==
X-Gm-Gg: ASbGnctc7E3b5qolRgP2aWs1STPyUDw8+Zre/WZe5OYOxOxjtuh3y2cknLtSLAiTxkn
	N0BcOrJ41t84N3rYJz0j+gldIenhfD81eoFiZ1uwj2CYlot1JR+BoK1dT8QShMt7fX/jqtNmSnT
	aVMM5ZYdjHaxkPY0HamQSPZEIYXnmM7tb1HghjgaCZwiM4y03AYOXkYIEyr4m/cY3m/62YbJPDy
	VtSRHmkJh2u
X-Google-Smtp-Source: AGHT+IFHbJtDxG37cvxBKH8NGXhwk2XLYaYOecNKag503pQMv17w5iEIMEJ1A/G/EvNp4CUJLR2QdRz8SJa4aES8KT0=
X-Received: by 2002:a05:6402:35d4:b0:61c:6855:d917 with SMTP id
 4fb4d7f45d1cf-61cfe9dfb9bmr7801067a12.6.1756872091311; Tue, 02 Sep 2025
 21:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-3-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 2 Sep 2025 21:01:17 -0700
X-Gm-Features: Ac12FXxgG0JV6C-GfYSDGPZA6aaqDK827JumYhB5EndL2ZNI_1YKMYlSsBrjdOM
Message-ID: <CADUfDZoHFQrDUfRGcwR8SS9uihxs8yHw7f_VwXOhfpM-Kei3yg@mail.gmail.com>
Subject: Re: [PATCH 02/23] ublk: add `union ublk_io_buf` with improved naming
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add `union ublk_io_buf`, meantime apply it to `struct ublk_io` for
> storing either ublk auto buffer register data or ublk server io buffer
> address.

The commit message could be a bit clearer that this is naming the
previously anonymous union of struct ublk_io's addr and buf fields. My
initial impression was that it was introducing a new union type.

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>
> The union uses clear field names:
> - `addr`: for regular ublk server io buffer addresses
> - `auto_reg`: for ublk auto buffer registration data
>
> This eliminates confusing access patterns and improves code readability.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 040528ad5d30..9185978abeb7 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -155,12 +155,13 @@ struct ublk_uring_cmd_pdu {
>   */
>  #define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
>
> +union ublk_io_buf {
> +       __u64   addr;
> +       struct ublk_auto_buf_reg auto_reg;
> +};
> +
>  struct ublk_io {
> -       /* userspace buffer address from io cmd */
> -       union {
> -               __u64   addr;
> -               struct ublk_auto_buf_reg buf;
> -       };
> +       union ublk_io_buf buf;
>         unsigned int flags;
>         int res;
>
> @@ -500,7 +501,7 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_=
queue *ubq,
>         iod->op_flags =3D ublk_op | ublk_req_build_flags(req);
>         iod->nr_sectors =3D blk_rq_sectors(req);
>         iod->start_sector =3D blk_rq_pos(req);
> -       iod->addr =3D io->addr;
> +       iod->addr =3D io->buf.addr;
>
>         return BLK_STS_OK;
>  }
> @@ -1012,7 +1013,7 @@ static int ublk_map_io(const struct ublk_queue *ubq=
, const struct request *req,
>                 struct iov_iter iter;
>                 const int dir =3D ITER_DEST;
>
> -               import_ubuf(dir, u64_to_user_ptr(io->addr), rq_bytes, &it=
er);
> +               import_ubuf(dir, u64_to_user_ptr(io->buf.addr), rq_bytes,=
 &iter);
>                 return ublk_copy_user_pages(req, 0, &iter, dir);
>         }
>         return rq_bytes;
> @@ -1033,7 +1034,7 @@ static int ublk_unmap_io(const struct ublk_queue *u=
bq,
>
>                 WARN_ON_ONCE(io->res > rq_bytes);
>
> -               import_ubuf(dir, u64_to_user_ptr(io->addr), io->res, &ite=
r);
> +               import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res, =
&iter);
>                 return ublk_copy_user_pages(req, 0, &iter, dir);
>         }
>         return rq_bytes;
> @@ -1104,7 +1105,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queu=
e *ubq, struct request *req)
>         iod->op_flags =3D ublk_op | ublk_req_build_flags(req);
>         iod->nr_sectors =3D blk_rq_sectors(req);
>         iod->start_sector =3D blk_rq_pos(req);
> -       iod->addr =3D io->addr;
> +       iod->addr =3D io->buf.addr;
>
>         return BLK_STS_OK;
>  }
> @@ -1219,9 +1220,9 @@ static bool ublk_auto_buf_reg(const struct ublk_que=
ue *ubq, struct request *req,
>         int ret;
>
>         ret =3D io_buffer_register_bvec(cmd, req, ublk_io_release,
> -                                     io->buf.index, issue_flags);
> +                                     io->buf.auto_reg.index, issue_flags=
);
>         if (ret) {
> -               if (io->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
> +               if (io->buf.auto_reg.flags & UBLK_AUTO_BUF_REG_FALLBACK) =
{
>                         ublk_auto_buf_reg_fallback(ubq, io);
>                         return true;
>                 }
> @@ -1513,7 +1514,7 @@ static void ublk_queue_reinit(struct ublk_device *u=
b, struct ublk_queue *ubq)
>                  */
>                 io->flags &=3D UBLK_IO_FLAG_CANCELED;
>                 io->cmd =3D NULL;
> -               io->addr =3D 0;
> +               io->buf.addr =3D 0;
>
>                 /*
>                  * old task is PF_EXITING, put it now
> @@ -2007,13 +2008,16 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
>
>  static inline int ublk_set_auto_buf_reg(struct ublk_io *io, struct io_ur=
ing_cmd *cmd)
>  {
> -       io->buf =3D ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->add=
r));
> +       struct ublk_auto_buf_reg buf;
> +
> +       buf =3D ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
>
> -       if (io->buf.reserved0 || io->buf.reserved1)
> +       if (buf.reserved0 || buf.reserved1)
>                 return -EINVAL;
>
> -       if (io->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
> +       if (buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
>                 return -EINVAL;
> +       io->buf.auto_reg =3D buf;
>         return 0;
>  }
>
> @@ -2035,7 +2039,7 @@ static int ublk_handle_auto_buf_reg(struct ublk_io =
*io,
>                  * this ublk request gets stuck.
>                  */
>                 if (io->buf_ctx_handle =3D=3D io_uring_cmd_ctx_handle(cmd=
))
> -                       *buf_idx =3D io->buf.index;
> +                       *buf_idx =3D io->buf.auto_reg.index;
>         }
>
>         return ublk_set_auto_buf_reg(io, cmd);
> @@ -2063,7 +2067,7 @@ ublk_config_io_buf(const struct ublk_queue *ubq, st=
ruct ublk_io *io,
>         if (ublk_support_auto_buf_reg(ubq))
>                 return ublk_handle_auto_buf_reg(io, cmd, buf_idx);
>
> -       io->addr =3D buf_addr;
> +       io->buf.addr =3D buf_addr;
>         return 0;
>  }
>
> @@ -2259,7 +2263,7 @@ static bool ublk_get_data(const struct ublk_queue *=
ubq, struct ublk_io *io,
>          */
>         io->flags &=3D ~UBLK_IO_FLAG_NEED_GET_DATA;
>         /* update iod->addr because ublksrv may have passed a new io buff=
er */
> -       ublk_get_iod(ubq, req->tag)->addr =3D io->addr;
> +       ublk_get_iod(ubq, req->tag)->addr =3D io->buf.addr;
>         pr_devel("%s: update iod->addr: qid %d tag %d io_flags %x addr %l=
lx\n",
>                         __func__, ubq->q_id, req->tag, io->flags,
>                         ublk_get_iod(ubq, req->tag)->addr);
> --
> 2.47.0
>
