Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91743595C
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777213; cv=none; b=Ob+Q6YDiA1ngnsyHUNkAET+UxI3EZ0QfopyqwyndtrkQJedeDEZ87h80jzSbu7aRz5Je7m83Dv9FlBh1PLCpkLL5lwVuLz7x5CMClI+zFBXT8vxvBONvLVaDx7Uiu/eQfxsYpcehU8dc0NGP+cBN9oSbUCqNe4VddP+mvVvYdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777213; c=relaxed/simple;
	bh=PSQIHHfbdNHhtk63JwOKL1gUf1g5S/T3HsgVmiv/1Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0/tj8uqEwyc9phi8Cv023LMySaa/28u6ebvzBr2YRVC25SBewJN5Znkohv+dALkPhU9/Op8rk7zDhznGRimiaXtDvdKskRjSZqeQAWpLhykKfhWzXn5ftqbE1011Fl7cmA/CdoCj795hd6QOzC+CS8l2pkLCmTPu0oyxM+ueMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=InQL85r0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InQL85r0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750777209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EG923SmdJru4hUkPhi2gt6rt+VnnwoJ6Jn2cxyr62/o=;
	b=InQL85r07MEO4gWld1NGHDOmlce77JtcmMZhmeALhEVSn3IXlLBPZTfar4gHnWmsEUBWAH
	4vjXltlSkzWbGuFs1A7vKVNHbcIVmO4NjJgdmR7yVvWBwRGON3EQPgZc0kvSpxpeBpBGae
	1OTdBnzWfeTBbmdO9QmaQXHlHRUbgSs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-Nqob2vPBNCSR_38xVWgTaw-1; Tue, 24 Jun 2025 11:00:08 -0400
X-MC-Unique: Nqob2vPBNCSR_38xVWgTaw-1
X-Mimecast-MFC-AGG-ID: Nqob2vPBNCSR_38xVWgTaw_1750777207
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so538882a91.3
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 08:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777207; x=1751382007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG923SmdJru4hUkPhi2gt6rt+VnnwoJ6Jn2cxyr62/o=;
        b=lqZvOZ3tSFnlFLK1dGHzaJmzCfqjKlgyNpuKhC2OXpZNUL09Oj3of541OSBjNxBla2
         Tk8Mt6oRd+NX25SLE4gDFgTZbImQuRTCcAI2FhwpFsiPIb9p/56af0RcYsmHezqYGxA0
         7KZ2JpLXmn+8aClUzXPkJDzwrChm9TLXgpcQeAPcK7/ww32kVdJWk07OMaoXKN9Roa47
         BObNEJQ/2LmC7iIwcIkjUwZbTtnM6hMuCoRJxa68cNF0aNfHXy1PRfDugvvG4+58MWsO
         lsVrMSyzWgUSd/RdPrYYCqRYQk12UyGEh6U9khnKDn8GzWDDxoSAQZGAM/C42iIDxlpg
         8xfw==
X-Forwarded-Encrypted: i=1; AJvYcCWCtiwB6Kh+NkyGhGHZSwDdqyVuIlwL2jNJeIVMtfaSZ8gIeRnN2NrePmKqPzoTLtTYj1/t26Kaz0Fidw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6sBnVegCjh3+AR+LY9DfR2HPjq7BbHajYE36/+QseF6ZMTSnz
	bZq4DLCFi8AuuGCpCxqDiKpsG3SsvPtxxQSZRZJ0f/tywKYGrYSYipSE1UbPhQtxzCVLPp0KWta
	PJ7OuwobiaDLSGxeIaIWlmgObRHIyUKu6as+dFCvMSLmh7nB1WFUd/gEIomrObNRXjiKXvRitQM
	nB0r8BxLDg+WJZsLAjmMxRh+wP5J1j/wKGUg3L3so=
X-Gm-Gg: ASbGncsk3rDj0KpvdjQ1RzIGqFKSc6L9qotPzzodHzTrvoy/bfauyFkFnuBufcPvGK8
	sUk3lhN6m6q2bLGhbnSYEJHCKmHJyo9F2WKDPMWLARXbsFT+YTj9i+5H9VBIp5QsFRfj2laBSPH
	PK2Xsn
X-Received: by 2002:a17:90b:2e87:b0:312:1ae9:1529 with SMTP id 98e67ed59e1d1-3159d8dfb8cmr24794020a91.27.1750777206315;
        Tue, 24 Jun 2025 08:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ/IvhBU8NlGxKySnC9PvdV8fstDg/R0rhycFgKg8SrOO4znwrlTRzmZiFKvCrlomjgIqgJY06drQiGjycVgE=
X-Received: by 2002:a17:90b:2e87:b0:312:1ae9:1529 with SMTP id
 98e67ed59e1d1-3159d8dfb8cmr24793955a91.27.1750777205835; Tue, 24 Jun 2025
 08:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624104121.859519-1-ming.lei@redhat.com>
In-Reply-To: <20250624104121.859519-1-ming.lei@redhat.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 24 Jun 2025 22:59:53 +0800
X-Gm-Features: Ac12FXyHVrASZbsaeSiUEWK-x6aeTFPT2qOfL1DYLMEqPnNnJTwZEif4UaKEFRE
Message-ID: <CAGVVp+VsMGy5bpC+2AxBimYaMFGLihOw04222D0ZdPfWcfswnQ@mail.gmail.com>
Subject: Re: [PATCH V2] ublk: setup ublk_io correctly in case of
 ublk_get_data() failure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Caleb Sander Mateos <csander@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 6:41=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
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
> +                       return UBLK_IO_RES_OK;
> +               }
> +               break;
>         default:
>                 goto out;
>         }
> --
> 2.49.0
>


Hello=EF=BC=8CMing

I ran the test 'make test T=3Dgeneric' 50 times and it didn't hit this
issue any more.
your patch V2 looks good.

Tested-by: Changhui Zhong <czhong@redhat.com>

