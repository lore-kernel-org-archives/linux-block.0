Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4641DFE36
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038158; cv=none; b=OtcLxOKskiQGJvto/fb1hLJEF7foPKc9BtQkhLe3iTHdzYrRCabsLJvdRFL3KHG07ijz04/XIuIV4fwH7Shk5sQM1B8QMFq2XIgSGR/2V00XeMZZ8Y2MLi+tD7fIDB88kx9BN2jWeCQcPxDJhJhJwODa0P8he4xPyV6bpJM0IF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038158; c=relaxed/simple;
	bh=jmAjM2Sr1MQAhakzVw6IhsMobts5DD4Yty1A9Tgv1eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjxH7k3oDduHvPmGFOVA8jhDcdWXGd+xZEvJjc38n/SDvnlmapF/D3lzwO+MxeL46kxG4JcTNCp5Hp1xqjL/T5TLVzWxxO/axdxUlP8w2udx6a7MIXlntE/Ta1EeNHuFW5vHGlzWX3QHB1as2GoPJhzTXhTXK3bqn5Ew9RmcZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aojwfjB+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aojwfjB+"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af907e48e00so656189a12.1
        for <linux-block@vger.kernel.org>; Mon, 07 Apr 2025 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744038156; x=1744642956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrcPGt34Q0xZ+zElQmvsMhoyqwrHZz4ntydbwQSiOKw=;
        b=aojwfjB+4YTg7A2c6r9zXRY2a4ixPhh3fv+ajOtJ5eJBhuNTQoNheb96Ve6D1EL/xo
         MfF8TN5I7tUBN9syYJdf1p+i8arR5xpaBnrKkCR3AfngE4Yea1BG6wD4hzF/xl7MKn1+
         anyW6B1wahYETWDLz/8nz9J23PR+Q+s+Ste65FazqFan+ZuXEkmTwYqvT1rPwwfqVax7
         7uCgwEV1fwubiOFKi3jjWMjvXQh48epfjLcgkF2fajoBKZOqKBJPPMOOTouBUJRAmirh
         xFtWIeMloROQuFNKc6anVA92kCmZ1bRSy2dqf44qgesQo/MOALgKrUX/eFoiq32FZqWR
         axkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744038156; x=1744642956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrcPGt34Q0xZ+zElQmvsMhoyqwrHZz4ntydbwQSiOKw=;
        b=NTW5m4ppEP8mbv0E+eB8RCFkDLFUYYYTo+Y3V5gMlyl7lUYGmCDfZ4yTcNLFv0Rs6k
         w6Ycj3HDvsHSvpDjT/q3jVTy8ULFzlKLTGawnqKuFnSkB99M5y0sEcyDylFwAId37GEf
         CbEg5eSFr9bTGW6Mud5D8wII/gh3nGilPt5VIEHT9oAU1dXGq9sd+0hTnYwzAm1yhBTg
         y6GwUDf8jonwzS9qHbbIIDAGbcfCX5jzQOYksGjg5kLu8HkoB2jqWUFW3+uPx41quejg
         +bo3fRpIdEfS5mnfRLipox+OOcVYg0yZg81njShsBOMBa+nyO5YI0znYuxFUMYRPeH2n
         O1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvi8xkKWMjyKPJ3wBbCbnDhGfY6yQFlqWtRzvkCQWuCvWnK2ieVEv/I1zKACGRIrim/LbcTgV6OarJGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHtE5LACZ0vmzvkK4Iez2TPdl02inm/0lt1NBC+m9h9x8edy5A
	a3vW6Bj6exyeivAgP+yFnNV7dxTuAMB1nZFw9mHVjbEpzzitV/WPpD+Yk1SXJQmTm0KF+iLTcm8
	N2C1kZenrW8Tr8ySDCe1QfOlQLbxhUZO2Nwe7n9Zh9OFXSpUaKX4=
X-Gm-Gg: ASbGncvlXcs/AzjYXuMnw981cwjuO3gb8+f8QrlXADBnU4wEiVVlc9JCDzzuCAkwnXC
	sguAmsWGDnADj2CFnqr0iPSNtty7+7wzBk3fc/PNjFhmW+OgIORdGcGtTq2tPQhm3JN4vF0DknT
	1SX6kLlE0cWVY1qAqGRVPJsKvaIg==
X-Google-Smtp-Source: AGHT+IEDGPLuC3w4am5+phk7TLoFHy3bSCKog+FCZuZAfh0DGqYP0FgXqFRdAsbth/FwLYp9+NGbYKdufzwW/kiCUkM=
X-Received: by 2002:a17:90b:164b:b0:2ff:78dd:2875 with SMTP id
 98e67ed59e1d1-306a4920597mr6873243a91.5.1744038155912; Mon, 07 Apr 2025
 08:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407131526.1927073-1-ming.lei@redhat.com> <20250407131526.1927073-2-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 7 Apr 2025 08:02:24 -0700
X-Gm-Features: ATxdqUH9oHTayGEP4zgpM199tVK6fnWg0bUf4G4N_OHvWIAVfxmc7kOXCTvvxyg
Message-ID: <CADUfDZodKfOGUeWrnAxcZiLT+puaZX8jDHoj_sfHZCOZwhzz6A@mail.gmail.com>
Subject: Re: [PATCH 01/13] ublk: delay aborting zc request until io_uring
 returns the buffer
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 6:15=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> When one request buffer is leased to io_uring via
> io_buffer_register_bvec(), io_uring guarantees that the buffer will
> be returned. However ublk aborts request in case that io_uring context
> is exiting, then ublk_io_release() may observe freed request, and
> kernel panic is triggered.

Not sure I follow how the request can be freed while its buffer is
still registered with io_uring. It looks like __ublk_fail_req()
decrements the ublk request's reference count (ublk_put_req_ref()) and
the reference count shouldn't hit 0 if the io_uring registered buffer
is still holding a reference. Is the problem the if
(ublk_nosrv_should_reissue_outstanding()) case, which calls
blk_mq_requeue_request() without checking the reference count?
Maybe a better place to put the requeue logic would be in
__ublk_complete_rq(). Then both the abort and io_uring buffer
unregister paths can just call ublk_put_req_ref(). And there would be
no need for UBLK_IO_FLAG_BUF_LEASED.

>
> Fix the issue by delaying to abort zc request until io_uring returns
> the buffer back.
>
> Cc: Keith Busch <kbusch@kernel.org>
> Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2fd05c1bd30b..76caec28e5ac 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -140,6 +140,17 @@ struct ublk_uring_cmd_pdu {
>   */
>  #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
>
> +
> +/*
> + * Set when this request buffer is leased to ublk server, and cleared wh=
en
> + * the buffer is returned back.
> + *
> + * If this flag is set, this request can't be aborted until buffer is
> + * returned back from io_uring since io_uring is guaranteed to release t=
he
> + * buffer.
> + */
> +#define UBLK_IO_FLAG_BUF_LEASED   0x10
> +
>  /* atomic RW with ubq->cancel_lock */
>  #define UBLK_IO_FLAG_CANCELED  0x80000000
>
> @@ -1550,7 +1561,8 @@ static void ublk_abort_queue(struct ublk_device *ub=
, struct ublk_queue *ubq)
>                         rq =3D blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_i=
d], i);
>                         if (rq && blk_mq_request_started(rq)) {
>                                 io->flags |=3D UBLK_IO_FLAG_ABORTED;
> -                               __ublk_fail_req(ubq, io, rq);
> +                               if (!(io->flags & UBLK_IO_FLAG_BUF_LEASED=
))
> +                                       __ublk_fail_req(ubq, io, rq);
>                         }
>                 }
>         }
> @@ -1874,8 +1886,18 @@ static void ublk_io_release(void *priv)
>  {
>         struct request *rq =3D priv;
>         struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> +       struct ublk_io *io =3D &ubq->ios[rq->tag];
>
> -       ublk_put_req_ref(ubq, rq);
> +       io->flags &=3D ~UBLK_IO_FLAG_BUF_LEASED;
> +       /*
> +        * request has been aborted, and the queue context is exiting,
> +        * and ublk server can't be relied for completing this IO cmd,
> +        * so force to complete it
> +        */
> +       if (unlikely(io->flags & UBLK_IO_FLAG_ABORTED))
> +               __ublk_complete_rq(rq);

This unconditionally ends the ublk request without checking the
reference count. Wouldn't that cause use-after-free/double-free issues
if the ublk request's buffer was registered in multiple io_uring
buffer slots?

Best,
Caleb

> +       else
> +               ublk_put_req_ref(ubq, rq);
>  }
>
>  static int ublk_register_io_buf(struct io_uring_cmd *cmd,
> @@ -1958,7 +1980,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
>         ret =3D -EINVAL;
>         switch (_IOC_NR(cmd_op)) {
>         case UBLK_IO_REGISTER_IO_BUF:
> -               return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, =
issue_flags);
> +               ret =3D ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr,=
 issue_flags);
> +               if (!ret)
> +                       io->flags |=3D UBLK_IO_FLAG_BUF_LEASED;
> +               return ret;
>         case UBLK_IO_UNREGISTER_IO_BUF:
>                 return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_fl=
ags);
>         case UBLK_IO_FETCH_REQ:
> --
> 2.47.0
>
