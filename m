Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F121639B
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976961; cv=none; b=L1ziLE8iH52r/lYFMYpeA8QFSWK+jysAWI6Dd/fBu5U+Q+Zas7Or1vVT71r+VsZLZ1xHI2p4jVv4fYwsbY8zYUEJLaDbgnQeZdH9EBcBQRI4oI9Fwihd/+GKBCEoJyRobCBHz4k1qaw+yS6e3ObX9r/B1AzKXXrEFKMLnbhZT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976961; c=relaxed/simple;
	bh=3J+MmZdw0HkZKLQsjT+H1e6xIbHMuu8sUK7T0dDI/S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHJKUvLfYyQrMGAkwT5zkKswpE3yo4awXvKiVHTrzrpxlXTPdRPeJPK7mwlDQvMdW3ZL7OZ8TPIfgm7xXg21M+eQjm3JYI+sKR49+s0WPT/aRz15lnqn9HSLq75CD5xSqMr5+hEezre6yMwL7Iup6lyB5FSkFBz3MvQ1ejsWTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Hn3ISK87; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Hn3ISK87"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-237f5c7f4d7so6020045ad.2
        for <linux-block@vger.kernel.org>; Tue, 08 Jul 2025 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751976959; x=1752581759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE/pbRx6vBVkO5oBngenKxQB+t7YnnoeDrcLO9gUdQk=;
        b=Hn3ISK87EDA48wfImp/Zj/CFYseDTvn42xe7XEHiQjWWxKSAwhx+4036a2LVJfeeIU
         cMILI6z6LxrSFKC/P7mYSwPcF2c/J5byazfbX8Cso69Pzh+T6YbhFm5dS4ZdaW1cQB8c
         SyRNilKx5Cwuo4x70/Xu1qJRzjwWR7iFGO+WB8DNHFSdlGFKwTydUSUw7TPcEvN7CYpT
         fsBPk4wpiAotxJ3vmPCjWESStYL8gwxvlFHRIi7cn1d5HGR15uDu10ORDpljCtho0cwz
         gG2VGBKBM2jjQGNTEgPetuRsgKyr8EurufRQYOq5noErgXloTwcG7U0aqvC8ARXGWGP/
         sPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751976959; x=1752581759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE/pbRx6vBVkO5oBngenKxQB+t7YnnoeDrcLO9gUdQk=;
        b=rf1sdC9I6eyXEGVmeSAwGls2WA+CMolzhUAIaFTGVutgbqRkpf6iwzCbb7oZC320zE
         utXSKgVM9KXHmti0XUg4v6g5vRRCOJ4FHBrsb+kpOk2INKWn8CMvSDZ+GnpfK6BzpqCZ
         YP+CqXoBYjSQXW/A0I1MUMnIvZStSAMNeGkzDFDRMlyZE8bzWkCgAn8mOjO0g5aJVjRu
         RHnN4Lt0ickVTrsxS2tOBa2WxTnVPnhalndjHjAF6UY2s0ujDA/ny8JX6xLcPbjvXBIb
         j7uJ9RNsMVCbbjFA7fTf0KeHDaDSyp2UdxSh3fXYzjsQI6BtZntEmsccj2ay1vpTOfYp
         ML4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9NgKw0gUjBexUT71zNSgDoD1pdBhjAIqZw/O2m9IJKewZLeCehhdgvfFU1ChuVXByAPROGfTpS4GrBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweVSVpfjqdbBmNDaK6TQv4fzcPjvGSjHB4K21wTwab9qysILDK
	FTLwRBA7xuJVfvKUA/kCzfDKoYvdoLqszsCRvyRB30YR1Tc6N5uwIfIXoHp7qSEPTYjCRPpoXZr
	O3HqvxDMdpVIqHSgjrSTQyBzJdEgd23WvFuqlNsd+ww==
X-Gm-Gg: ASbGncsIobYMlYPgyWLbNODEOU5b4O7HL3Z4aMpCsg70RM3ib39YA5lZWoCvQVW/dyX
	fhrt1OHwG4XYlVpjYUhNfUKLXj22NkJgxk2/rK0dJGTvsyeqmu1G436OEXpsaCiymhweXj19vTm
	15vmGbXqIlk5MjwiClSgY4FJFSzLP9JvgyDaiVxV4zj7AE
X-Google-Smtp-Source: AGHT+IHO53+13Pi4tNyTeqWW1Y33995GG2Fh6cMBgXwGsD1OrK80I2TwNnu0UiSh5ZTMOYQvYc8lX1r7wUIvBRlyMnM=
X-Received: by 2002:a17:903:1c4:b0:234:a734:4abe with SMTP id
 d9443c01a7336-23c8722f4fbmr91540725ad.1.1751976958577; Tue, 08 Jul 2025
 05:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702040344.1544077-1-ming.lei@redhat.com> <20250702040344.1544077-7-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-7-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 8 Jul 2025 08:15:46 -0400
X-Gm-Features: Ac12FXzaZotC9JqJVkKBGL3_OSy4eMnB-DcqQeUlzC6SeWzhNS0yk0vubdDJuW0
Message-ID: <CADUfDZp7GVQ=vMxHqSu8hONNA103G-NTZWGY4B5ueRJuVU7+Gg@mail.gmail.com>
Subject: Re: [PATCH 06/16] ublk: store auto buffer register data into `struct ublk_io`
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:04=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> We can share space of `io->addr` for storing auto buffer register data
> and user space buffer address.
>
> So store auto buffer register data into `struct ublk_io`.
>
> Prepare for supporting batch IO in which many ublk IOs share single
> uring_cmd, so we can't store auto buffer register data into uring_cmd
> pdu.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index ba1b2672e7a8..6d3aa08eef22 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -105,8 +105,6 @@ struct ublk_uring_cmd_pdu {
>          */
>         struct ublk_queue *ubq;
>
> -       struct ublk_auto_buf_reg buf;
> -
>         u16 tag;
>  };
>
> @@ -159,7 +157,10 @@ struct ublk_uring_cmd_pdu {
>
>  struct ublk_io {
>         /* userspace buffer address from io cmd */
> -       __u64   addr;
> +       union {
> +               __u64   addr;
> +               struct ublk_auto_buf_reg buf;
> +       };
>         unsigned int flags;
>         int res;
>
> @@ -187,8 +188,6 @@ struct ublk_io {
>         /* Count of buffers registered on task and not yet unregistered *=
/
>         unsigned task_registered_buffers;
>
> -       /* auto-registered buffer, valid if UBLK_IO_FLAG_AUTO_BUF_REG is =
set */
> -       u16 buf_index;
>         void *buf_ctx_handle;
>  } ____cacheline_aligned_in_smp;
>
> @@ -1214,13 +1213,12 @@ ublk_auto_buf_reg_fallback(const struct ublk_queu=
e *ubq, struct ublk_io *io)
>  static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct reque=
st *req,
>                               struct ublk_io *io, unsigned int issue_flag=
s)
>  {
> -       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(io->cmd=
);
>         int ret;
>
>         ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io_release,
> -                                     pdu->buf.index, issue_flags);
> +                                     io->buf.index, issue_flags);
>         if (ret) {
> -               if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
> +               if (io->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
>                         ublk_auto_buf_reg_fallback(ubq, io);
>                         return true;
>                 }
> @@ -1230,8 +1228,6 @@ static bool ublk_auto_buf_reg(const struct ublk_que=
ue *ubq, struct request *req,
>
>         io->task_registered_buffers =3D 1;
>         io->buf_ctx_handle =3D io_uring_cmd_ctx_handle(io->cmd);
> -       /* store buffer index in request payload */
> -       io->buf_index =3D pdu->buf.index;
>         io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
>         return true;
>  }
> @@ -1985,16 +1981,14 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
>         return 0;
>  }
>
> -static inline int ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
> +static inline int ublk_set_auto_buf_reg(struct ublk_io *io, struct io_ur=
ing_cmd *cmd)
>  {
> -       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> -
> -       pdu->buf =3D ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->ad=
dr));
> +       io->buf =3D ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->add=
r));
>
> -       if (pdu->buf.reserved0 || pdu->buf.reserved1)
> +       if (io->buf.reserved0 || io->buf.reserved1)
>                 return -EINVAL;
>
> -       if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
> +       if (io->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
>                 return -EINVAL;
>         return 0;
>  }
> @@ -2018,10 +2012,10 @@ static int ublk_handle_auto_buf_reg(struct ublk_i=
o *io,
>                  */
>                 if (io->buf_ctx_handle =3D=3D io_uring_cmd_ctx_handle(cmd=
) &&
>                                 buf_idx)
> -                       *buf_idx =3D io->buf_index;
> +                       *buf_idx =3D io->buf.index;
>         }
>
> -       return ublk_set_auto_buf_reg(cmd);
> +       return ublk_set_auto_buf_reg(io, cmd);
>  }
>
>  /* Once we return, `io->req` can't be used any more */
> --
> 2.47.0
>
