Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288B33E378
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174059; cv=none; b=TLBPinDmaw/DS1MEtBORreNLSoBB1N5qiAcpbTnJ2zj2HLWT2vJ75XtrUBrqtVlDe012eEZ2JtOLgona/9N4Ygs4lIy0KcJ11t/SZIjKuVRvbD9eSmjveWpzNFkTzcDc9FGpmPYL45OApVDzqz/lOGOS6Lw5L7VrZwyBmLrW00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174059; c=relaxed/simple;
	bh=9/fzzR0ccxAYPHIaEFQW/obSMmtYUaiy1gon5tDa1vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9l/Ihksx0VREaq9B9+zilCrtNs42TEh1g9Gh/7A7QPlfX3k2eEnyGZdLt1sAH/51xD2GKdv6eJnV92xRs0/6aEieKpA0ToWxHvhsgl4iNAzC9B/ERHns1tC0ICByOJKNpBK4gJO8PYaBcYbkY5DCNH/lFnbJbe5Ua2ukoguGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EI+oA3vx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EI+oA3vx"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bb2fa942daso818406b3a.1
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764174057; x=1764778857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4be/ZUWvLP5yKyHdTZEenu+CsKk3oo4+92NC6C4XhD4=;
        b=EI+oA3vxSrtKPobRUOfMf7FSzWgJ4TXIMC5ZYSHU5KXx9Kyb+xUplUjhvbn8DGWWLp
         h+hAFGzF5rTHyLC8UMFZcrYz51QDCD4wpbHYvJr22Y03LZjShMQGsvL4iTjoeB4HNyOr
         XnMZxvHcfASKs/knOkyxgzl2JjrXRP97ddDehFIDK05d1LbwI3e4RpXEtOcpOrUfjc8l
         e5/feFwA60Jw7nFY+0z164fkjn9GGYwSXORuBxWJ6DIY1ZVQ7Mu86gqCMNiTLUqzRmgd
         P/4i1ye0MxSfFvDfMPrO5AuIsrM5zDOhVU3819YtNMCJtw3w9GQrpAlsj7gg3VaQbfEl
         s7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764174057; x=1764778857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4be/ZUWvLP5yKyHdTZEenu+CsKk3oo4+92NC6C4XhD4=;
        b=v1maOWh4tM+UGdPZfrUZo0vDrUJTQKVcweYWIj5hqm4AwP5J5Zresed4z45jOQkxsW
         ZId0hAgMdr7B/9V2XDG2RwdTALwFaRNhccsBLPFYr0bPek9W2ZfrYZFAjlPDrZAu5AkV
         P6+LyqsB0zLmQ1KVo0w2vXqzshAFKC4Qo5RoQPUjveZJO4o4Esu2il718Ia8mJ3YfNT/
         FReZf6DFhbPiRi5C4kpdtQCsnAqs5e1uP6BVShcjVyG7ODI0FDymK4R+EYnnuJhqwGmI
         j/9mAsefwa6JO+ZiPe274aw5PB+zAoj5FGSLQCZjfIM36qCfhb1gZwqAF2RtNOCw7Rzj
         QCUw==
X-Gm-Message-State: AOJu0Yx4UIDemxWEub2Nwm1dEo274/Tg7b3CSseoJe+ayeONfjmA3F3D
	SoAxkpx/36QdQqItmIURBj22sB7yK2+59jIhzqDqouZl9D1NqfCGH+uUNxvdmj3KOWtwgbFfk0k
	iy73zPBhAiq4tN0RqvnTKl8n2564Wy3jZaSrYrFZoBw==
X-Gm-Gg: ASbGncv8o/NbIb+nSPrlBXAPZtuuErZJ4ByyCjfVBpNESKJsMoW51sWxvn1MZPbts6i
	+ERs2alNSJOocIelvfRftfdR1RoTdxA7lkc6vcTHjx0wzemcQr6VmskdOtJlIuMSC7RAHngkJap
	jw4VAHw3tbiNe5Fxd9e8+tH/1C0aeq/cFDZLinqla/LqSJ0+iQv14BGgz8z9lz49/nUtveYPsU6
	q+U9mfUthelb7PKi2on6LFcpefWTmhTjMG5waXty/KnqiktGMrwqLsnGLSRadAdruSwhxxR
X-Google-Smtp-Source: AGHT+IFZ7FBb8upfv2PMo8Ylc2BDObXteu7uneiDIhnyYuTEbEMDCsl08kUKj0MCgU/61TTZ4AhiHwFhxMfgAIPUDrE=
X-Received: by 2002:a05:7023:c007:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-11c9f3a16demr7691230c88.5.1764174056662; Wed, 26 Nov 2025
 08:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126124835.1132852-1-kevin.brodsky@arm.com>
In-Reply-To: <20251126124835.1132852-1-kevin.brodsky@arm.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 26 Nov 2025 08:20:45 -0800
X-Gm-Features: AWmQ_bkkPww6M3lStNIvMTw9pHmAW8EdDzOFfoo5kOGXg6nZDDHEzcaESjvPAbk
Message-ID: <CADUfDZqsFSsA4UNxmB=LQwqor+enD35bNVFgT2_gMt1_2uwOqA@mail.gmail.com>
Subject: Re: [PATCH] ublk: prevent invalid access with DEBUG
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ali Utku Selen <ali.utku.selen@arm.com>, Ming Lei <ming.lei@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 4:48=E2=80=AFAM Kevin Brodsky <kevin.brodsky@arm.co=
m> wrote:
>
> ublk_ch_uring_cmd_local() may jump to the out label before
> initialising the io pointer. This will cause trouble if DEBUG is
> defined, because the pr_devel() call dereferences io. Clang reports:
>
> drivers/block/ublk_drv.c:2403:6: error: variable 'io' is used uninitializ=
ed whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>  2403 |         if (tag >=3D ub->dev_info.queue_depth)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/ublk_drv.c:2492:32: note: uninitialized use occurs here
>  2492 |                         __func__, cmd_op, tag, ret, io->flags);
>       |
>
> Fix this by initialising io to NULL and checking it before
> dereferencing it.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Looks like this could use a Fixes tag:
Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
> Cc: Ali Utku Selen <ali.utku.selen@arm.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/ublk_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 0c74a41a6753..359564c40cb5 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2367,7 +2367,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_=
cmd *cmd,
>         u16 buf_idx =3D UBLK_INVALID_BUF_IDX;
>         struct ublk_device *ub =3D cmd->file->private_data;
>         struct ublk_queue *ubq;
> -       struct ublk_io *io;
> +       struct ublk_io *io =3D NULL;
>         u32 cmd_op =3D cmd->cmd_op;
>         u16 q_id =3D READ_ONCE(ub_src->q_id);
>         u16 tag =3D READ_ONCE(ub_src->tag);
> @@ -2488,7 +2488,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_=
cmd *cmd,
>
>   out:
>         pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
> -                       __func__, cmd_op, tag, ret, io->flags);
> +                       __func__, cmd_op, tag, ret, io ? io->flags : 0);
>         return ret;
>  }
>
>
> base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
> --
> 2.51.2
>
>
