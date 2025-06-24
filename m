Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D342D8DC6
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778183; cv=none; b=GhYJgSvbCkXXQU4TE5o16M4EUo9/zp4iDQaMs/vvhdYlAa1TMaYgKfxFTJ9sNn6s2cddpZCiiUaPAqkTK+GYbI97diWjs+f482xXi4sRKTB31GKgwlakO1cGs3ET45RMSjFM2W9GoGN8e/zQpIXhjD9YVDnSm1THUT7bS2Tte5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778183; c=relaxed/simple;
	bh=ABLLb+PdCkDiltTGjIHZDtG5VzNZq8uFV9NMcmQKq0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEkE2OocnMW5NyxsftNke5zoABe3wU5Wa0ynZAczWbc8khynko7UbrhvBkoXaYTNGGBv7zsQ/CryHOLTRXhdi/gECzEC071Ah2VW8N/t2EHSvHM+1UsKG4oF8TAyC/cAANmNWuq3cG6V9Se+ydyeUf9hktaqh7QJTMLae8Vtis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W99UEzoL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W99UEzoL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235248ba788so4602445ad.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750778180; x=1751382980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aL5AYIz5y40klzf1LUvkSiLJNQCJ4UGDciaoMAIy44=;
        b=W99UEzoLgK3vSWpiGlCqDWUp3n4QCgu853Fw9enKd2zaJGlAy44ToJtwuizpOHGYvw
         WLtjtrd7quf6YffhMnM7uC38wMuuxPqhf7xEiAxg+4Wd9AsaBMkDSdZy6yLk+Tm/8vXx
         PtuiBK82XeDoHVCBxftciZ8wPqtWNS4RgjEl2xSAgs9fAp/wP9xkXRnyg/w/LNBIpBqt
         vAJ/Syhya+SY19Fe2nHPBaZaBYD5SO8LbiuJjPszVZiyDvOWPEtqeCZxD6dWZ+p0r56v
         D4axLoaYV5oVPYxffBiEZoEIGj4rDMgKmmjIsoYnVY02mZhTt7yUdZ6ye+fkkxdzlSQr
         oVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750778180; x=1751382980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aL5AYIz5y40klzf1LUvkSiLJNQCJ4UGDciaoMAIy44=;
        b=AVPWb1bZuUh4b77LsIfK3hNTbkTZXAXn7YMlxVyQtOv8b5kP2KOav9AMmCD+zr50/+
         NlbIzLrZkZuszHZ8GVxaAnEaOJMUrfnUCCZp6JzFPWEL1xEXq2snjglIVImuQuok2NhF
         TdxQhMQ/xFWmsQhKZtXBwQfS1Han5pDps+pHHp8Nnq1QfrttcWADVEMHTCs014ErStkJ
         qail4DVkN6jEeJq25rhpu21lFlamgCkjB48qCGGCwW4vPAd+vL9FAeJ2j+8Ap5g3u73J
         riRoBPe5UIvWV3wd3ZwKL2Owqu7beW5HK0Ke+qEjejHxP9cYJksSPsKqp7hrKa/E0+qA
         9b8A==
X-Forwarded-Encrypted: i=1; AJvYcCXg6XePiZ2L4a96VS5OU4yW0i23UiMHNyLdClJyMPyxnOYaxFo1JSwPifM5PAYlO0JbF2O4DxNa1XVUjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxajjNWbh4Hg+MYVyyQprjsZwRs/JaY7V4Y33Ci8YIzuAQt9MXL
	EWEa0QI0IaoQHJG202TKCJ4X2EDKg1fI6JdoxM31hzCp3XNyMBhSNZXNSl17HPawtMYjPNSw0h8
	MSLGXVnjj9Vy7rDaDyv6Q+93voo49d0VIiP/Cs5RPug==
X-Gm-Gg: ASbGncunJuqSoSK+XCgi9PeeZj5Cv1WpDuK+zrAII06z/qHFQl/8NTCbphDy/FqeoEv
	00e29Q2QYjmUoT4ZZtXIPauYoZVoZ/yePTmFWCEGkRuPHjQqUddhrI+31GMTjWGONxw54hMxZko
	P4opJDoVHVk+far04gmUZY2XjYW+69tnQa2Gwdve2zouesFi82ItbK
X-Google-Smtp-Source: AGHT+IGf+ihj8j8kan3wfdMh6oQPWYTe6eeE0qBJeCcFt4OptcPTLJC4fMZ67nPH9HCvoU7R+CWYmHzAu3rkR482h8M=
X-Received: by 2002:a17:902:e884:b0:236:7333:f1a0 with SMTP id
 d9443c01a7336-237d9a75160mr92497835ad.14.1750778180076; Tue, 24 Jun 2025
 08:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624104121.859519-1-ming.lei@redhat.com>
In-Reply-To: <20250624104121.859519-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 24 Jun 2025 08:16:08 -0700
X-Gm-Features: AX0GCFsULQKcyjHmbCcqpdfUnVk35_8gpWNuWvDuZsyL2HgjPupKS0dQD4y25RY
Message-ID: <CADUfDZo4+roZtoMJWBDemrJi7fzkzYEPWMN4zD=kC0ainvALPQ@mail.gmail.com>
Subject: Re: [PATCH V2] ublk: setup ublk_io correctly in case of
 ublk_get_data() failure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Changhui Zhong <czhong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:41=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> If ublk_get_data() fails, -EIOCBQUEUED is returned and the current comman=
d
> becomes ASYNC. And the only reason is that mapping data can't move on,
> because of no enough pages or pending signal, then the current ublk reque=
st
> has to be requeued.
>
> Once the request need to be requeued, we have to setup `ublk_io` correctl=
y,
> including io->cmd and flags, otherwise the request may not be forwarded t=
o
> ublk server successfully.
>
> Fixes: 9810362a57cb ("ublk: don't call ublk_dispatch_req() for NEED_GET_D=
ATA")

Don't think this is the right Fixes tag; the issue predates this
refactoring. I pointed out this existing issue when we discussed that
patch: https://lore.kernel.org/linux-block/CADUfDZroQ4zHanPjytcEUhn4tQc3BYM=
PZD2uLOik7jAXvOCjGg@mail.gmail.com/

Looks like the correct commit would be c86019ff75c1 ("ublk_drv: add
support for UBLK_IO_NEED_GET_DATA").

> Reported-by: Changhui Zhong <czhong@redhat.com>
> Closes: https://lore.kernel.org/linux-block/CAGVVp+VN9QcpHUz_0nasFf5q9i1g=
i8H8j-G-6mkBoqa3TyjRHA@mail.gmail.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
>         - move io->addr assignment into ublk_fill_io_cmd()
>
>  drivers/block/ublk_drv.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index d36f44f5ee80..3566d7c36b8d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1148,8 +1148,8 @@ static inline void __ublk_complete_rq(struct reques=
t *req)
>         blk_mq_end_request(req, res);
>  }
>
> -static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req=
,
> -                                int res, unsigned issue_flags)
> +static struct io_uring_cmd *__ublk_prep_compl_io_cmd(struct ublk_io *io,
> +                                                    struct request *req)

nit: don't think the underscores are necessary

>  {
>         /* read cmd first because req will overwrite it */
>         struct io_uring_cmd *cmd =3D io->cmd;
> @@ -1164,6 +1164,13 @@ static void ublk_complete_io_cmd(struct ublk_io *i=
o, struct request *req,
>         io->flags &=3D ~UBLK_IO_FLAG_ACTIVE;
>
>         io->req =3D req;
> +       return cmd;
> +}
> +
> +static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req=
,
> +                                int res, unsigned issue_flags)
> +{
> +       struct io_uring_cmd *cmd =3D __ublk_prep_compl_io_cmd(io, req);
>
>         /* tell ublksrv one io request is coming */
>         io_uring_cmd_done(cmd, res, 0, issue_flags);
> @@ -2148,10 +2155,9 @@ static int ublk_commit_and_fetch(const struct ublk=
_queue *ubq,
>         return 0;
>  }
>
> -static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *=
io)
> +static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *=
io,
> +                         struct request *req)
>  {
> -       struct request *req =3D io->req;
> -
>         /*
>          * We have handled UBLK_IO_NEED_GET_DATA command,
>          * so clear UBLK_IO_FLAG_NEED_GET_DATA now and just
> @@ -2178,6 +2184,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>         u32 cmd_op =3D cmd->cmd_op;
>         unsigned tag =3D ub_cmd->tag;
>         int ret =3D -EINVAL;
> +       struct request *req;
>
>         pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
>                         __func__, cmd->cmd_op, ub_cmd->q_id, tag,
> @@ -2236,11 +2243,19 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>                         goto out;
>                 break;
>         case UBLK_IO_NEED_GET_DATA:
> -               io->addr =3D ub_cmd->addr;
> -               if (!ublk_get_data(ubq, io))
> -                       return -EIOCBQUEUED;
> -
> -               return UBLK_IO_RES_OK;
> +               /*
> +                * ublk_get_data() may fail and fallback to requeue, so k=
eep
> +                * uring_cmd active first and prepare for handling new re=
queued
> +                * request
> +                */
> +               req =3D io->req;
> +               ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> +               io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
> +               if (likely(ublk_get_data(ubq, io, req))) {
> +                       __ublk_prep_compl_io_cmd(io, req);

Isn't __ublk_prep_compl_io_cmd() basically undoing the
ublk_fill_io_cmd() and io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV? How
about something like this instead?

io->addr =3D ub_cmd->addr;
if (likely(ublk_get_data(ubq, io)))
        return UBLK_IO_RES_OK;

ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
break;

Best,
Caleb

> +                       return UBLK_IO_RES_OK;
> +               }
> +               break;
>         default:
>                 goto out;
>         }
> --
> 2.49.0
>
