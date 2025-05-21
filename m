Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49C280018
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843117; cv=none; b=kZJJ+OlWln+Zp4X2Oi0Dg5z7rKb3rUzY1xFYU8Vm6CsUx+jEuMVfPAizbITRlr6N+6w9Q12fxHuAJFi5W9KbEz25JlokiUUhIpi8jSj1Z0sVhRjwupfCPdujL58ITtrwaFFsWD7EUzuaJrqSj1xhFZPxTeBhdk3hTc9llLGvT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843117; c=relaxed/simple;
	bh=evH3qbtubKK/WHmx+nU8Ox31B7dqHij2PMXJl8wv5z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WA8NUKRGCmODLgXzMc1ctTFUoo1xBbBEQSG25cq5JnOmIouDGtzZjei+Pn8vKtheWA95wlUvPZDKDVId8k6yExi64+Lgf6WK+ioB4e/STsbvC4M9SWPdkHmfGQzznScc01PHEoBZFYNxAAMzljhvXgmFS5phoo/WdNAyghHT5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LdIomJXA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LdIomJXA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e1782cbb2so5798615ad.0
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747843113; x=1748447913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4CwPPeQFxqFK8hUoR6O0Vkyz/nXNROVXyPlrqIkCbo=;
        b=LdIomJXArbZ0buv4QoNqQ3A+rYKUqGFdJ5OUbr3jtvS6RxTgRNV+KBjpinQ4DU8OzS
         XovLwgWWYg5jQsFsqvd5ulBA/UoNgzwyAQj4Llnt2hGlNzRj4QGEoqi/7BHmOM2JPkK6
         Diw2vTV47u7G3pDckryVOP1jb7xxMBEUcnmHCGuaFu3odp3PQEvUiifmwdcVckj8VTko
         X//lTNhx6UFldoJOypWwpz8w3Wa4WN9gRi94P4QzHTqabW/hw1vB77vwuefVXwOidRur
         +w5MzU800rN9quuenkU10vAeyJIxAo08piXHbyuYC7S+py/uuKpMuRISaVgD6y14rwgw
         dTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747843113; x=1748447913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4CwPPeQFxqFK8hUoR6O0Vkyz/nXNROVXyPlrqIkCbo=;
        b=ab1l73T8k5r9UxX4m9PwchdWzbec9zZwNGEMWBxPAnDj5dJRB2AqvX/Xca7Lz42IJS
         vV/cO9fnrW/8RyQnQjz8Bp2sy7R7KeS/2nfIaNkIdfMaA0AvbVkuCxqPN1hJf5nhM5R+
         WCGzNASi1s784CLRdbJpniUa/nNrz6KMChCg9Il02HKZEn7FlbValGRKgd/jCKaJODi8
         rzW0pVYtClFzl+RekCz+Yt9RQe8EH9j+XnjM4CqmP5omI07DmuWLn/jj7UwFplCLngA3
         ph5R5nZQGec4VjWmjWEdRhAz8bqK7Lxefm8rh/KjY/ZSFoO1qnqQusUaJUeYrc6g+sJY
         RZbw==
X-Forwarded-Encrypted: i=1; AJvYcCVtq5eSHZSArJjL+jyX2ND3vT1DRzL9ZHMYOGrM1YcLT+Q1P4SptgntP4HfKfH+8jxWSNV9oCzV7UjdBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuqKMq0bh30fCB7R4VDq52xdLLgETE7NsllNPV3ZgnOSlfNYnE
	twiPF2Mi/cZlj41BsQwyUvtoUGnV8nKpbBJ6c1xTChV+MvFndlKTlUZO7tpn4VQM1fEbVO9iL3k
	vGjZE9MFlB2TWhJWgh2JQJLW/fA2ARWEXdEyGof6dtQ==
X-Gm-Gg: ASbGncvYLbjvPylUwpgMmGwHypwsLkBPfcCDb0mISa4/f3C8gBg83kvW5ApfRvPlWQm
	WMyAjo42c0KFDqhfot84uXrqeZYNajJYyzINFhVUtVKI0Jh4hiupQbR1VHsnphJLlq6XU0eVW7b
	y/jlPIQStlRGTWr8ibTJBIaXhhSQGfvZ0=
X-Google-Smtp-Source: AGHT+IHmd1tYFwDwKmtLE6uumFg31Qpp8BaIlwSa17Ye1X4jZWkMwG1q0+u3CpbkqHfUVLy9Mn8i/tn2lfLYgT99rF4=
X-Received: by 2002:a17:903:1103:b0:232:202e:ab35 with SMTP id
 d9443c01a7336-232202ead15mr73290805ad.1.1747843113399; Wed, 21 May 2025
 08:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521025502.71041-1-ming.lei@redhat.com> <20250521025502.71041-3-ming.lei@redhat.com>
In-Reply-To: <20250521025502.71041-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 21 May 2025 08:58:20 -0700
X-Gm-Features: AX0GCFvWmaVVTmR62HiT1YBC4l4UDCgbn9dEs_ILvSKC6gGuL6JE2uENll-FiDA
Message-ID: <CADUfDZrh+FYHgPjmF1=RRQiZFx=uYZEBJ+mJGsX-C9jM5dVi9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ublk: run auto buf unregisgering in same io_ring_ctx
 with register
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:55=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> UBLK_F_AUTO_BUF_REG requires that the buffer registered automatically
> is unregistered in same `io_ring_ctx`, so check it explicitly.
>
> Meantime return the failure code if io_buffer_unregister_bvec() fails,
> then ublk server can handle the failure in consistent way.
>
> Also force to clear UBLK_IO_FLAG_AUTO_BUF_REG in ublk_io_release()
> because ublk_io_release() may be triggered not from handling
> UBLK_IO_COMMIT_AND_FETCH_REQ, and from releasing the `io_ring_ctx`
> for registering the buffer.
>
> Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with provid=
ed buf index via UBLK_F_AUTO_BUF_REG")
> Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 35 +++++++++++++++++++++++++++++++----
>  include/uapi/linux/ublk_cmd.h |  3 ++-
>  2 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index fcf568b89370..2af6422d6a89 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -84,6 +84,7 @@ struct ublk_rq_data {
>
>         /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
>         u16 buf_index;
> +       unsigned long buf_ctx_id;
>  };
>
>  struct ublk_uring_cmd_pdu {
> @@ -1192,6 +1193,11 @@ static void ublk_auto_buf_reg_fallback(struct requ=
est *req, struct ublk_io *io)
>         refcount_set(&data->ref, 1);
>  }
>
> +static unsigned long ublk_uring_cmd_ctx_id(struct io_uring_cmd *cmd)
> +{
> +       return (unsigned long)(cmd_to_io_kiocb(cmd)->ctx);

Is the fact that a struct io_uring_cmd * can be passed to
cmd_to_io_kiocb() an io_uring internal implementation detail? Maybe it
would be good to add a helper in include/linux/io_uring/cmd.h so ublk
isn't depending on io_uring internals.

Also, storing buf_ctx_id as a void * instead would allow this cast to
be avoided, but not a big deal.

> +}
> +
>  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
>                               unsigned int issue_flags)
>  {
> @@ -1211,6 +1217,8 @@ static bool ublk_auto_buf_reg(struct request *req, =
struct ublk_io *io,
>         }
>         /* one extra reference is dropped by ublk_io_release */
>         refcount_set(&data->ref, 2);
> +
> +       data->buf_ctx_id =3D ublk_uring_cmd_ctx_id(io->cmd);
>         /* store buffer index in request payload */
>         data->buf_index =3D pdu->buf.index;
>         io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> @@ -1994,6 +2002,21 @@ static void ublk_io_release(void *priv)
>  {
>         struct request *rq =3D priv;
>         struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> +       struct ublk_io *io =3D &ubq->ios[rq->tag];
> +
> +       /*
> +        * In case of UBLK_F_AUTO_BUF_REG, the `io_uring_ctx` for registe=
ring
> +        * this buffer may be released, so we reach here not from handlin=
g
> +        * `UBLK_IO_COMMIT_AND_FETCH_REQ`.

What do you mean by this? That the io_uring was closed while a ublk
I/O owned by the server still had a registered buffer?

> +        *
> +        * Force to clear UBLK_IO_FLAG_AUTO_BUF_REG, so that ublk server
> +        * still may complete this IO request by issuing uring_cmd from
> +        * another `io_uring_ctx` in case that the `io_ring_ctx` for
> +        * registering the buffer is gone
> +        */
> +       if (ublk_support_auto_buf_reg(ubq) &&
> +                       (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG))
> +               io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;

This is racy, since ublk_io_release() can be called on a thread other
than the ubq_daemon. Could we avoid touching io->flags here and
instead have ublk_commit_and_fetch() check whether the reference count
is already 1?

Also, the ublk_support_auto_buf_reg(ubq) check seems redundant, since
UBLK_IO_FLAG_AUTO_BUF_REG is set in ublk_auto_buf_reg(), which is only
called if ublk_support_auto_buf_reg(ubq).

>
>         ublk_put_req_ref(ubq, rq);
>  }
> @@ -2109,14 +2132,18 @@ static int ublk_commit_and_fetch(const struct ubl=
k_queue *ubq,
>         }
>
>         if (ublk_support_auto_buf_reg(ubq)) {
> +               struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
>                 int ret;
>
>                 if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> -                       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(re=
q);

Why does this variable need to move to the outer scope?

Best,
Caleb

>
> -                       WARN_ON_ONCE(io_buffer_unregister_bvec(cmd,
> -                                               data->buf_index,
> -                                               issue_flags));
> +                       if (data->buf_ctx_id !=3D ublk_uring_cmd_ctx_id(c=
md))
> +                               return -EBADF;
> +
> +                       ret =3D io_buffer_unregister_bvec(cmd, data->buf_=
index,
> +                                                       issue_flags);
> +                       if (ret)
> +                               return ret;
>                         io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
>                 }
>
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index c4b9942697fc..3db604a3045e 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -226,7 +226,8 @@
>   *
>   * For using this feature:
>   *
> - * - ublk server has to create sparse buffer table
> + * - ublk server has to create sparse buffer table on the same `io_ring_=
ctx`
> + *   for issuing `UBLK_IO_FETCH_REQ` and `UBLK_IO_COMMIT_AND_FETCH_REQ`
>   *
>   * - ublk server passes auto buf register data via uring_cmd's sqe->addr=
,
>   *   `struct ublk_auto_buf_reg` is populated from sqe->addr, please see
> --
> 2.47.0
>
