Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D7299AB3
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701074; cv=none; b=HhUAxHeeuZW+5q3PJJPtsZ9Jcs+r39qJHxXvq02+93UpoMtst0FRObKojAzk/wcZua0ehUYrrBEuFSdjzCeWzxxAZ+9zVFfawcwTYdI09pIkn9QyBUGrY179tyrC8qBRabWZI/qFzoWq5Db1s66afi7sSADEK1HcYxH+7vbdnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701074; c=relaxed/simple;
	bh=vDSfcGgDSNhGw35osaiLcYhlBHkO+SgsmakU9ub3PhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWvetkd8LI5Am6pDouMUPfaqEFMZuz5d5iJNUGRCy3IXnSh9rPYDq0mLz1obwHf6cJx17RsTLvZTlIHw0I92MWxUc/E3CrVrtT5u1lZ6aFmYDKqFWCrgau3Ok0jztwVl592rIHWzwez7UG7xYnsiFj8EI7GvYwtQLiuLgNWSWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XCWXzsZN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XCWXzsZN"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313336f8438so560165a91.0
        for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750701072; x=1751305872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSGTbaSUTphTlNgLaG+uQKsE9OQD6r3l23T4XwIYFSA=;
        b=XCWXzsZNoiy01FMdTO1JQH8qBqsnrgJzdKgboQ22LCrzX91w4DOTuHDGmtZbfxbIsV
         koWQGBttN7psW2PQFDXDR+7jH7o7ac+oFEuHf4qyaOFOhNZFH4e0AZwKI66Cs7sI1msV
         h/B4+XDbjF01aRu7iANhEn0ozevFsihhr7OJFzk5B1KIG4QFeR4dlOqflwZbin0744CF
         cMzt4YpjIPhKmjPDx1LaJPdhoonRht43TBchCLTKKE+mVNufR7HmzulEcfVDQE7x6MHW
         wcXXVpPMYFibn4Oky+77sgzUM78jZ7UzoyYybZm1w8vXI2LN3owcS/ZKlsP/+Xw7qCzK
         98kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701072; x=1751305872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSGTbaSUTphTlNgLaG+uQKsE9OQD6r3l23T4XwIYFSA=;
        b=iC+DV9MgZxws4nuOoYApUHEobLjqM7WTrdwArRo82nuplkjDcIF/vB2+pu7+qnUvFG
         vdCUMrqPGmH8QiYBlp+k0Y0lt/BDlXcvKYvTsuMPD8eWYv6rrATeqmdxfV339kPDkjmX
         5GApHx1mf7xuyR+POl7QRq69heeM4aAQYb41KcdsO/zuNaRlykxwdSrne58zuEQPYiZA
         qUgwIUAt7ZRNtEVo3yo+DaHW0zmXSavQnLYhCcB34kxDsTT/eRKvEPv1dh7aRugIEyhW
         9rnmkJyKb+Si9VdMIVE5LJR+Z4M97T4KyqjufPEvpivCDzFAqePQbzEjbg6mNsPVzQOB
         Hh4g==
X-Forwarded-Encrypted: i=1; AJvYcCV2pPrSpBqplsY7PEcjNXe0I4UDXVXeBwLGXIF+Lg/93x8DmnTuaMQBf5dQ3/yxdG86HKSXjEb2megyvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6AWSn3L5uGeTKji3NyvAUeVQAX859lERkX7BkECDXtSB04uqz
	SFxJ6GSTR4oGDADKydZ68059uXDNkjE1PCWgPO7k74kvZj48IgsmspqO4WvFnnGcTDvq8HR6M5p
	WI9Ob4+a44Dzc6Btuo5RoQHRwgMqFd/2v/rYAKGC2BmJMvNIcdxMH
X-Gm-Gg: ASbGncurpKcFphPk0C2u/dgTkSK7CZ8gae2X3C2wrBo7tLy0T8Xfh8+iAAqR8AczDhI
	jZxD6vWO1Eh1ox3JOQPYxryVGz5QQ0FPBYdtFlnDycE0htQPOOzoT5Gn9diYZ322ELCuEJnDJ8I
	dOWGhnluust4pJpGcb2ikm1MntxnIHA+uL9nB60dqVmQ==
X-Google-Smtp-Source: AGHT+IFGZpuTgz+fHD99KSnnuWfYYiIKvRkQPXvrFMJNbyd+pOyw5zE7yNo7NPCxl9uMQ8nakl9GJwDmgxERP0nDILE=
X-Received: by 2002:a17:90b:3a43:b0:311:fde5:c4ae with SMTP id
 98e67ed59e1d1-3159d8e2be9mr7295280a91.6.1750701072235; Mon, 23 Jun 2025
 10:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623011934.741788-1-ming.lei@redhat.com> <20250623011934.741788-2-ming.lei@redhat.com>
In-Reply-To: <20250623011934.741788-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 23 Jun 2025 10:51:00 -0700
X-Gm-Features: AX0GCFuJ0BB6stWu_FTER7aw6CA6cQRcC7fbnE3xKjxOHefyya0Yz0PCKrq2vX4
Message-ID: <CADUfDZp=69+ZpJ5vc7c9qGmA3zLU+eYdYd2PfeiDwFvxYQ+0nQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: build per-io-ring-ctx batch list
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 6:19=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> ublk_queue_cmd_list() dispatches the whole batch list by scheduling task
> work via the tail request's io_uring_cmd, this way is fine even though
> more than one io_ring_ctx are involved for this batch since it is just
> one running context.
>
> However, the task work handler ublk_cmd_list_tw_cb() takes `issue_flags`
> of tail uring_cmd's io_ring_ctx for completing all commands. This way is
> wrong if any uring_cmd is issued from different io_ring_ctx.
>
> Fixes it by always building per-io-ring-ctx batch list.
>
> For typical per-queue or per-io daemon implementation, this way shouldn't
> make difference from performance viewpoint, because single io_ring_ctx is
> often taken in each daemon.
>
> Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")
> Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue d=
aemon")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c637ea010d34..e79b04e61047 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1336,9 +1336,8 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd=
 *cmd,
>         } while (rq);
>  }
>
> -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
> +static void ublk_queue_cmd_list(struct io_uring_cmd *cmd, struct rq_list=
 *l)
>  {
> -       struct io_uring_cmd *cmd =3D io->cmd;
>         struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
>
>         pdu->req_list =3D rq_list_peek(l);
> @@ -1420,16 +1419,18 @@ static void ublk_queue_rqs(struct rq_list *rqlist=
)
>  {
>         struct rq_list requeue_list =3D { };
>         struct rq_list submit_list =3D { };
> -       struct ublk_io *io =3D NULL;
> +       struct io_uring_cmd *cmd =3D NULL;
>         struct request *req;
>
>         while ((req =3D rq_list_pop(rqlist))) {
>                 struct ublk_queue *this_q =3D req->mq_hctx->driver_data;
> -               struct ublk_io *this_io =3D &this_q->ios[req->tag];
> +               struct io_uring_cmd *this_cmd =3D this_q->ios[req->tag].c=
md;
>
> -               if (io && io->task !=3D this_io->task && !rq_list_empty(&=
submit_list))
> -                       ublk_queue_cmd_list(io, &submit_list);
> -               io =3D this_io;
> +               if (cmd && io_uring_cmd_ctx_handle(cmd) !=3D
> +                               io_uring_cmd_ctx_handle(this_cmd) &&
> +                               !rq_list_empty(&submit_list))
> +                       ublk_queue_cmd_list(cmd, &submit_list);

I don't think we can assume that ublk commands submitted to the same
io_uring have the same daemon task. It's possible for multiple tasks
to submit to the same io_uring, even though that's not a common or
performant way to use io_uring. Probably we need to check that both
the task and io_ring_ctx match.

Best,
Caleb

> +               cmd =3D this_cmd;
>
>                 if (ublk_prep_req(this_q, req, true) =3D=3D BLK_STS_OK)
>                         rq_list_add_tail(&submit_list, req);
> @@ -1438,7 +1439,7 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
>         }
>
>         if (!rq_list_empty(&submit_list))
> -               ublk_queue_cmd_list(io, &submit_list);
> +               ublk_queue_cmd_list(cmd, &submit_list);
>         *rqlist =3D requeue_list;
>  }
>
> --
> 2.47.0
>
