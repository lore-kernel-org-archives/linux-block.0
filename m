Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EFE1C3308
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745887003; cv=none; b=LBCeMKvpSq04Lrl/Pk+ppUjtUMzeMabSQX182VXUnJAdVvL7GkPaQLtw6PiET7Qf1W3Ke6RODudMkHed2Z6mybmQ2IrTzZcqta5mvV9zgPUg1cVnKF57oUYP9Bqb6e4x4HR4HNBIuJZ6+jBad6sDvkPJu82Nz4OKQ2Uys7+RwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745887003; c=relaxed/simple;
	bh=YV128YWuem3NUBiyOuUSgc+P69KzpuVfFAcg7eo8iL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfy0OjN4rVPzH2C5KyDyUn8b40fJamj+QeTQH0MkvopUDVWAtx+ZV7INOSQehaJqYloo7srVuti+cqmPlyyNqh1r6lvNYHsKMMdK6UTxjH2EKJamLYDA5I45woBx8O7pgr8jn3UK/fu8eVM1mpnh2xQ26I8rEZNOtZP+PLt4aCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Za0IEsi3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Za0IEsi3"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so434919a91.0
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 17:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745886999; x=1746491799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUY2HZtfj4SceC9gAAHYPYBj8Sh0u+yOl+JrQ3WQwfE=;
        b=Za0IEsi3Xv9j7/5wn2rwW1fI4TY8myno3ufzLSYv2KKCBKZ8AXJAgijWJg9fRbhhVd
         GePSp0MlfRNPnWI+nKRg3Bx94YYHvi+xiF3a9YR3ALaCYJXlFxzrQ/f3sRwnvXswnhzO
         PciOMIxEFJcgTgLSkXid3Cgm2tOWkaN0a45x/lkQDX0aCwrMUYsF5KqPtvzIl/DiMskE
         HNBN2t1Qrq1v6aTPaQNOLIq7kC+HB5OFjVX/MREJNBX4Uf6+UgTpTnWHL5ZRH9XDbxB7
         n+NEpGlM56yWmScYwY5EqFP8MZm0SLzixxIsDDBPdRb//ZShp3z7CDqjbLNsLezDG8DY
         cXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745886999; x=1746491799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUY2HZtfj4SceC9gAAHYPYBj8Sh0u+yOl+JrQ3WQwfE=;
        b=kNwBCBGajP0fUekN9mSnKooeVQvGpHW94nCZpTfokCMH5QJs4Lh8LvSOfdt1ICu8+/
         ++5x+4HGO0alziWlXTj+SexvJUd4WKO4ojUEJ+xk2iKYKHVdy51kZdF7JAU312sBN1U9
         UQxZFW+F4+58zWUEVOwK516rLzSZ45KP+GntNYKDBoKlbPkgEehFEzMfVAuiDQWZPtLt
         cRq2lY6gIfT+Dv9amitbuLS0uIaATYT1SeRcGDUEU22AQZSevSFAeAHDjKRkdEW6B/bI
         r9NAL+7RvrpcNX9UYBOhb1htiYgFl9xZOK4AHAAbSaqinn/VqsngfTgXtD8w/s1ZEYgu
         fbPg==
X-Forwarded-Encrypted: i=1; AJvYcCUa9Wsb856lGdOVFi0Q8Rng3XN2sovEAVQr6gtK2WpInoT6uKDmGnQqavQWP+jRT8a+33NFMdkd8SUyUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyptvV2QhTeb/u0L5TyQlqa6x2y1oXQLJbwfVt4/rETTrfQcSaw
	JbAME24KSwJKao1acoURIIGDqQBtKnO+ocpLZ5nHj+VqXQYVhqjqAjs25QboW10JGXvOtSWozJP
	pVJjuS+SuwH2wa1OONvS2szHTWtqHm+tynoyjQQ==
X-Gm-Gg: ASbGncsyfU1FLUj6rDsY0/1WTc0pHQ9NUxtySsLoeJFAsHLXao6fqLRVb6yJxYDp67p
	2JynIZnSsTp4aVtm1Sh+N9H+h77v0eBjuj/DH151umo1P7GtQRW6variWR/nbTqpTydv+Mo0aex
	vjrPRnWcBtehn0nqXaI1WrfJ5PcD2aIH8=
X-Google-Smtp-Source: AGHT+IEsKM/XARtoR/+hM6PD6zfgoAlXEa7lYxhw1x4kmw477DQoL9u7PQhhlNlrQseVJUQinHSYKHOY2vhDF7FEslw=
X-Received: by 2002:a17:90b:4d0c:b0:306:e75e:dbc7 with SMTP id
 98e67ed59e1d1-30a21f8bdc0mr700135a91.0.1745886999196; Mon, 28 Apr 2025
 17:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428094420.1584420-1-ming.lei@redhat.com> <20250428094420.1584420-3-ming.lei@redhat.com>
In-Reply-To: <20250428094420.1584420-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Apr 2025 17:36:28 -0700
X-Gm-Features: ATxdqUHn3FL8XO3lr-nEJNDqefT73CwxW5EvfTWIeGxsnLoK9USitZDbXJmlOuk
Message-ID: <CADUfDZpTnntS0r40rBV4aeBx6Sf=X8jQiZDiB+C8Vch7CdaPtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] io_uring: add helper __io_buffer_[un]register_bvec
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 2:44=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add helper __io_buffer_[un]register_bvec and prepare for supporting to
> register bvec buffer into specified io_uring and buffer index.
>
> No functional change.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  io_uring/rsrc.c | 88 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 42 deletions(-)
>
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 66d2c11e2f46..5f8ab130a573 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -918,11 +918,9 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx,=
 void __user *arg,
>         return ret;
>  }
>
> -int io_buffer_register_bvec(struct io_uring_cmd *cmd,
> -                           struct io_buf_data *buf,
> -                           unsigned int issue_flags)
> +static int __io_buffer_register_bvec(struct io_ring_ctx *ctx,
> +                                    struct io_buf_data *buf)

__must_hold(&ctx->uring_lock) ? Same comment about
__io_buffer_unregister_bvec().

Best,
Caleb

>  {
> -       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
>         struct io_rsrc_data *data =3D &ctx->buf_table;
>         unsigned int index =3D buf->index;
>         struct request *rq =3D buf->rq;
> @@ -931,32 +929,23 @@ int io_buffer_register_bvec(struct io_uring_cmd *cm=
d,
>         struct io_rsrc_node *node;
>         struct bio_vec bv, *bvec;
>         u16 nr_bvecs;
> -       int ret =3D 0;
>
> -       io_ring_submit_lock(ctx, issue_flags);
> -       if (index >=3D data->nr) {
> -               ret =3D -EINVAL;
> -               goto unlock;
> -       }
> -       index =3D array_index_nospec(index, data->nr);
> +       if (index >=3D data->nr)
> +               return -EINVAL;
>
> -       if (data->nodes[index]) {
> -               ret =3D -EBUSY;
> -               goto unlock;
> -       }
> +       index =3D array_index_nospec(index, data->nr);
> +       if (data->nodes[index])
> +               return -EBUSY;
>
>         node =3D io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
> -       if (!node) {
> -               ret =3D -ENOMEM;
> -               goto unlock;
> -       }
> +       if (!node)
> +               return -ENOMEM;
>
>         nr_bvecs =3D blk_rq_nr_phys_segments(rq);
>         imu =3D io_alloc_imu(ctx, nr_bvecs);
>         if (!imu) {
>                 kfree(node);
> -               ret =3D -ENOMEM;
> -               goto unlock;
> +               return -ENOMEM;
>         }
>
>         imu->ubuf =3D 0;
> @@ -976,43 +965,58 @@ int io_buffer_register_bvec(struct io_uring_cmd *cm=
d,
>
>         node->buf =3D imu;
>         data->nodes[index] =3D node;
> -unlock:
> +
> +       return 0;
> +}
> +
> +int io_buffer_register_bvec(struct io_uring_cmd *cmd,
> +                           struct io_buf_data *buf,
> +                           unsigned int issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> +       int ret;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +       ret =3D __io_buffer_register_bvec(ctx, buf);
>         io_ring_submit_unlock(ctx, issue_flags);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
>
> -int io_buffer_unregister_bvec(struct io_uring_cmd *cmd,
> -                             struct io_buf_data *buf,
> -                             unsigned int issue_flags)
> +static int __io_buffer_unregister_bvec(struct io_ring_ctx *ctx,
> +                                      struct io_buf_data *buf)
>  {
> -       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
>         struct io_rsrc_data *data =3D &ctx->buf_table;
>         unsigned index =3D buf->index;
>         struct io_rsrc_node *node;
> -       int ret =3D 0;
>
> -       io_ring_submit_lock(ctx, issue_flags);
> -       if (index >=3D data->nr) {
> -               ret =3D -EINVAL;
> -               goto unlock;
> -       }
> -       index =3D array_index_nospec(index, data->nr);
> +       if (index >=3D data->nr)
> +               return -EINVAL;
>
> +       index =3D array_index_nospec(index, data->nr);
>         node =3D data->nodes[index];
> -       if (!node) {
> -               ret =3D -EINVAL;
> -               goto unlock;
> -       }
> -       if (!node->buf->is_kbuf) {
> -               ret =3D -EBUSY;
> -               goto unlock;
> -       }
> +       if (!node)
> +               return -EINVAL;
> +       if (!node->buf->is_kbuf)
> +               return -EBUSY;
>
>         io_put_rsrc_node(ctx, node);
>         data->nodes[index] =3D NULL;
> -unlock:
> +       return 0;
> +}
> +
> +int io_buffer_unregister_bvec(struct io_uring_cmd *cmd,
> +                             struct io_buf_data *buf,
> +                             unsigned int issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> +       int ret;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +       ret =3D __io_buffer_unregister_bvec(ctx, buf);
>         io_ring_submit_unlock(ctx, issue_flags);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(io_buffer_unregister_bvec);
> --
> 2.47.0
>
