Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49E28B516
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924863; cv=none; b=nscrExCTHnOTHlUHt++fpZdYFsOIWD8O6KdBp1U3a9kIkMtJWTAFaTb1hwWyKsPZ3hseMM0CTfsz9ETyMb21e0uHaPllNljbA05e89X4+Nq2BCFtsvVd5dOErslnkOPXLgrncuBR49WqaC2e4XZ1aLgrGPiiV6qwm+AeiMBnV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924863; c=relaxed/simple;
	bh=CvtkwnoCmGXSeC1cRLA8Mu3LLs/aDS0tUDFqfybmXSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqKRRjz1lbg0uvTSGZ9I0Zlk8qryDv5L5ckdnLKd6eNNMsYQcCzccVKiOdQppfsMLYDFT99i3zbFJVGz3pbzX2yWJTYrfAyXWyvIwGt/RCQjCV4zeDig7MuWyn+zA8+7PiuGY8l0M7KA4KI2Jh62OHG8QzuX/9Sp/iJcHO3CvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IHbxfOAU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IHbxfOAU"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b26ed911f4cso548483a12.3
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 07:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747924860; x=1748529660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGzgwdt7v+xbDfDMVOWUlCaj1DQJ7m2YSSk5mQ/UorA=;
        b=IHbxfOAU3kKWYxJ++WovTzFROwhwz0GSrlnYlZf5D3/rIOB+1mrjABoqaPYwTw5s7a
         yWWcVk4/DuasWtRFswfknuXuGHcQO2K9elHhLob+k15TYEZY+9BwyZespjski9uzw8xS
         VEQ03pwfhzqbkKpNrTiGRpq4YqAtphmoQTO4ooD+vhR/vcVbOmWJ8fmG4JfkrzsL+Nhv
         UVEHFA2o73zY/x+buxdbgpHArCW5xbf4uCs4t36TmVc1quGKJJf+t3PhbqfROckxmBDB
         QRmLCypCKYw5tBoDL0MIXkStr21mP1+pTJUxk4LHHxJyALRVEflerLe5BWu4CBXXg4oS
         vE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747924860; x=1748529660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGzgwdt7v+xbDfDMVOWUlCaj1DQJ7m2YSSk5mQ/UorA=;
        b=HskzPvjI9XZveIDTCQ312xxjHqRS1U5uQCa1ygbnROwLqYq1ofGbIgJ87c0S1Wej7j
         U22ZXt9nSMns9bvvwgB+kizw1MA5SmdfIZjwfXUPhRUcX7FVfq9FdOMbkdCag+cu3Iin
         rJVHHIVBmMItQGEwLE/YbBYum0h/n/7IC/8TWd+5ED26vPTEhzHfssAYECOVzP6qxbTf
         oXyjz6wtc40fI7LazN9ueo9s60dbWRInTMJ8tuy9qkLQjAz9SeQCQwuhxsyTK1GdrmJC
         Qra7O04tdr1Bqp1SnpPXHic+Ak8oXYIfvzdBGD0LXAPtgdnjstaUdN1PgtkRyVwRUUmy
         rxTg==
X-Forwarded-Encrypted: i=1; AJvYcCUThoVqlxl+bznZ7XdxK8KzmBp1W6rnOeqinfak+hT8Flv3YVzWqva/dEMkb7qQc17RLN+RV1KJEYT85Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRD6ZqOUBH+Xt8czX/h0RFYlGgyIZNL76Xf9ROoPFojDHFcHGo
	zq2bsAYthfCg3pyhZJk/EaSro/bZAY1hyq8azPFkzrlR0+p6K+OCQi7vSNBRSw4Z2uEx4jb2pZL
	e6BTouaT1WPUxje3v9a1BFxavHX6YzZupro42Guk35A==
X-Gm-Gg: ASbGncv2S9BI8xaquNV4qK2pYe8j4Sc4qLFcio5XeOgyKtyxrOCOdpLjizH0Bnpr8CT
	zwNgo6oxJyh7sNS9P/i2+2SwbDx9BqWTWyqJAvvLmbFtlMpqZJWYrF9banIlvjMrsCyThyWQAqe
	5moRwuUMUFUZd1D6vsAU7nhWbAehQHaSU=
X-Google-Smtp-Source: AGHT+IERLgDtN74rAEnE22DHeD0Z+GCxu9hFyAo8It691pNy17Y9eWyBuh8/aB4cCm5TLXuStkx4prxpgnoPpk6JccY=
X-Received: by 2002:a17:902:ce01:b0:215:b75f:a1d8 with SMTP id
 d9443c01a7336-231d43881e2mr140341885ad.2.1747924860282; Thu, 22 May 2025
 07:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522135045.389102-1-ming.lei@redhat.com> <20250522135045.389102-3-ming.lei@redhat.com>
In-Reply-To: <20250522135045.389102-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 22 May 2025 07:40:48 -0700
X-Gm-Features: AX0GCFu1Jy5ltAjAEdEqwq6DBJ2dC3uKEtU34kB20PxLBUY0ZSrL0tMmPNtwBto
Message-ID: <CADUfDZr3W8dVwgBzHaFxv=vr52mGcimtc_urnTvCNoZ4Q9Ouaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ublk: run auto buf unregister on same io_ring_ctx
 with register
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 6:51=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> UBLK_F_AUTO_BUF_REG requires that the buffer registered automatically
> is unregistered in same `io_ring_ctx`, so check it explicitly.
>
> Document this requirement for UBLK_F_AUTO_BUF_REG.
>
> Drop WARN_ON_ONCE() which is triggered from userspace code path.
>
> Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with provid=
ed buf index via UBLK_F_AUTO_BUF_REG")
> Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 19 ++++++++++++++++---
>  include/uapi/linux/ublk_cmd.h |  6 +++++-
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 180386c750f7..a56e07ee9d4b 100644
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
> @@ -1211,6 +1212,8 @@ static bool ublk_auto_buf_reg(struct request *req, =
struct ublk_io *io,
>         }
>         /* one extra reference is dropped by ublk_io_release */
>         refcount_set(&data->ref, 2);
> +
> +       data->buf_ctx_id =3D io_uring_cmd_ctx_handle(io->cmd);
>         /* store buffer index in request payload */
>         data->buf_index =3D pdu->buf.index;
>         io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> @@ -2111,12 +2114,22 @@ static int ublk_commit_and_fetch(const struct ubl=
k_queue *ubq,
>         if (ublk_support_auto_buf_reg(ubq)) {
>                 int ret;
>
> +               /*
> +                * `UBLK_F_AUTO_BUF_REG` only works iff `UBLK_IO_FETCH_RE=
Q`
> +                * and `UBLK_IO_COMMIT_AND_FETCH_REQ` are issued from sam=
e
> +                * `io_ring_ctx`.
> +                *
> +                * If this uring_cmd's io_uring_ctx isn't same with the

nit: "io_ring_ctx"

> +                * one for registering the buffer, it is ublk server's
> +                * responsibility for unregistering the buffer, otherwise
> +                * this ublk request gets stuck.
> +                */
>                 if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
>                         struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(re=
q);
>
> -                       WARN_ON_ONCE(io_buffer_unregister_bvec(cmd,
> -                                               data->buf_index,
> -                                               issue_flags));
> +                       if (data->buf_ctx_id =3D=3D io_uring_cmd_ctx_hand=
le(cmd))
> +                               io_buffer_unregister_bvec(cmd, data->buf_=
index,
> +                                               issue_flags);
>                         io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
>                 }
>
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index c4b9942697fc..5203963cd08a 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -226,7 +226,11 @@
>   *
>   * For using this feature:
>   *
> - * - ublk server has to create sparse buffer table
> + * - ublk server has to create sparse buffer table on the same `io_ring_=
ctx`
> + *   for issuing `UBLK_IO_FETCH_REQ` and `UBLK_IO_COMMIT_AND_FETCH_REQ`.
> + *   If uring_cmd isn't issued on same `io_uring_ctx`, it is ublk server=
's

nit: "io_ring_ctx" here too

> + *   responsibility to unregister the buffer by issuing `IO_UNREGISTER_I=
O_BUF`
> + *   manually, otherwise this ublk request get stuck.

"get stuck" is a little vague. How about "won't complete"?

Other than that,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>   *
>   * - ublk server passes auto buf register data via uring_cmd's sqe->addr=
,
>   *   `struct ublk_auto_buf_reg` is populated from sqe->addr, please see
> --
> 2.47.0
>
