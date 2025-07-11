Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFCE2D373C
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240341; cv=none; b=CWPpGLwvQSENqK1tGeKvt8hKclDj+TOhtEOEvo4ZgUU+zvTLJW6+EJP3UQQ39O0PV7L8NOJEahFqbeGnr0TG0rl2mlkz2QLxc5+N8QeC3rmL3uitoAXruG4wiHG2LEBWV+b+AhVVFQUEhBLt+FzljWMIX+yMNKSnfsZwvGDjB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240341; c=relaxed/simple;
	bh=0vHoidP92jL7BrM58iwObhPprdNkhxvr2+sxX2zFx48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RumDXrWVydIv5ndTTitQc2Q/Se6lFuXJCbf119mNJ+qvlQPG78uSbGbkXW+TVgP5Vx6AnbiHjNvB2j6NwrRUfpknM1W4/XHMvQwBbD9VqUwOl0cOwUVLVoFB4KdnsJqBOS7UQMiBI6L7a/34Dk07JJYcD4HL/fMoz34wLo5Nj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FONBug5m; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FONBug5m"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234eaea2e4eso3043055ad.0
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752240339; x=1752845139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCheGcXwukohqy406JfU/wy3lP0vI4+l/fi57yA0IK4=;
        b=FONBug5mzfAMfCGy/gL2eZRStur2g8Ma3EI8pHKkupsbVcUQRCkspZrARWKksRHt7T
         Wa7Jb56T+YhHr0m33+Rh7YxhMJU5c1G6y+AR4zHJEhgiWfFADYP/o3+KxfFPsYdJE+SH
         ig2r5SSVTa2QPGrYfaCi7Bb/cbis4mxe47d1rluhqGYLa4agM1BII0ha3J9vwwXIRI9K
         G82/vbAg6mYI2liEm3F4BxksFUofOI7dWT/0YClPSvRzxyCftDKnU96BAf8AATLhwX5e
         LFWjzTExtUlSpBBLts/gBP4jPP7VVnsKcavIpABtuf5k5mam9uWNgryV7t75ikfCLV2C
         R2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240339; x=1752845139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCheGcXwukohqy406JfU/wy3lP0vI4+l/fi57yA0IK4=;
        b=n4Ypol+edAagYn8CBAeYS2XQGURNuUGZXLRkvd0sd8pas60lYrOlfLBjarAY1f2I1f
         C2IwCt+c361vHRUA0bWjg1wqEpTZMzQQQZOb3G8ZTiPdLM9y2VHxhmp6W1jhOkKIritR
         G54W/41ywtCvpMJu3esXtP3IPWHUibELUTJnbKPCUl7q8gFC2J+npajXPEfJ73MXIhSG
         46QxkVE0yDJf6dUafloKQa/dJTgQI1nP8NUtp10X0u7SIRm7I5y/k2EoWjB5hIPzy7is
         i0EVWJCbIgBlg6DUV2JsykC7lP111ZloXzkRc0dr4QbjE8AKkdMcJsIAbeXr/cufmj1Z
         em0w==
X-Forwarded-Encrypted: i=1; AJvYcCVspGIoLnw6q9J84VHeRayguNVVSv0YgxFYqWTA4njaSu7pQc37Q8imSfCKYqOW5v9EQex75ocUPhStGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi8KlVe4UCgmWvaTr7am9bA000Ulo6JU5xCU6ZmppCTMM2RbYT
	QD1qVhOH8FehsIir2QTy6Ja7ufuv1d2Ca4hRFxSmIAaXN+7xDnlMuMYi1yyASr9iDpaKqKe+yxO
	ZtP3nkQOwoQMOfIvFIxbD40JSRPgJzjkIA2uiC+9kPh4h5cXAJPCcqayp7Q==
X-Gm-Gg: ASbGncvsWy7jnkpnLRXd7kW7+t0dJB5tiLcq3PPtHUzA6iPMJqnVO3ghAF/ODlrrM8z
	tZZT1UV3d3h2DNVQOOJ43Lla0ayZvAMyrHOyLdip4psjZ8pAs/orJGHCppnRkybJ69CmMkzz/9Z
	lpODZZXGcaZbI7/E+nnNo+czNMxIV2gtSe6TcF3wLr/u50o3WdckPysm8snNYSAZVGaFk28aawn
	qcorqXYWkgnH/nYjrY=
X-Google-Smtp-Source: AGHT+IHTPyKlYjdJ2bcOzW4Wc9NsB/OAy3vTKEz/XF/S7qmnwEYVwHBBNXHNedSPhOQG/xBK44EsPBbzFDap/LOmVMM=
X-Received: by 2002:a17:902:ebc6:b0:234:ed31:fc9f with SMTP id
 d9443c01a7336-23dede854e5mr17104655ad.11.1752240338592; Fri, 11 Jul 2025
 06:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708011746.2193389-1-ming.lei@redhat.com> <20250708011746.2193389-4-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 11 Jul 2025 09:25:27 -0400
X-Gm-Features: Ac12FXzVdZr5uROkcb3IsI76cOMBQzCzfVtYKlwZkTISfneunFbT5tmmUhjPZgc
Message-ID: <CADUfDZrW3NsusYmYo4gsRCDv8Yb3oWZYrVfhDUe219xqFTue=A@mail.gmail.com>
Subject: Re: [PATCH V2 03/16] ublk: let ublk_fill_io_cmd() cover more things
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:18=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Let ublk_fill_io_cmd() cover more things:
>
> - store io command result
>
> - clear UBLK_IO_FLAG_OWNED_BY_SRV
>
> It is fine to do above for ublk_fetch(), ublk_commit_and_fetch() and
> handling UBLK_IO_NEED_GET_DATA.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index d7b5ee96978a..1ab2dc74424f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2003,11 +2003,16 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
>  }
>
>  static inline void ublk_fill_io_cmd(struct ublk_io *io,
> -               struct io_uring_cmd *cmd, unsigned long buf_addr)
> +               struct io_uring_cmd *cmd, unsigned long buf_addr,
> +               int result)
>  {
>         io->cmd =3D cmd;
>         io->flags |=3D UBLK_IO_FLAG_ACTIVE;
>         io->addr =3D buf_addr;
> +       io->res =3D result;

Hmm, only a single caller (ublk_commit_and_fetch()) needs to set
io->res. It seems a bit weird to move it here.

> +
> +       /* now this cmd slot is owned by ublk driver */
> +       io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;

I would have a slight preference for keeping the two updates of
io->flags next to each other. The compiler may be able to optimize
that better.

Best,
Caleb

>  }
>
>  static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
> @@ -2165,7 +2170,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, str=
uct ublk_queue *ubq,
>                         goto out;
>         }
>
> -       ublk_fill_io_cmd(io, cmd, buf_addr);
> +       ublk_fill_io_cmd(io, cmd, buf_addr, 0);
>         WRITE_ONCE(io->task, get_task_struct(current));
>         ublk_mark_io_ready(ub, ubq);
>  out:
> @@ -2221,11 +2226,7 @@ static int ublk_commit_and_fetch(const struct ublk=
_queue *ubq,
>                         return ret;
>         }
>
> -       ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> -
> -       /* now this cmd slot is owned by ublk driver */
> -       io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
> -       io->res =3D ub_cmd->result;
> +       ublk_fill_io_cmd(io, cmd, ub_cmd->addr, ub_cmd->result);
>
>         if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
>                 req->__sector =3D ub_cmd->zone_append_lba;
> @@ -2345,8 +2346,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>                  * request
>                  */
>                 req =3D io->req;
> -               ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> -               io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
> +               ublk_fill_io_cmd(io, cmd, ub_cmd->addr, 0);
>                 if (likely(ublk_get_data(ubq, io, req))) {
>                         __ublk_prep_compl_io_cmd(io, req);
>                         return UBLK_IO_RES_OK;
> --
> 2.47.0
>
