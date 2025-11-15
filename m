Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8E35CBC5
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763183431; cv=none; b=JvvMgsPaAaxDJ3VkCOi/ToDHIxGFhSqwSalKxan8r16IsgMme72HBkHHbnCGEuvUjMEvj1rTYbQBnkkEAjHy83FSQneLZ6WpNxpaZpH0Co6b+FeOa0KCFNj0MV2XS7QFSEZiQl+QqXhxvOLmyLvmv/Hd3KIYvmrRx+QtcbkKkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763183431; c=relaxed/simple;
	bh=BwMjVw/9MZJyTkHgT2+YoiY4GRUmpfJCGwu4pubon2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=re7393wfRsK8lb/6MhAph7d8FY1P1Lhrpn1jReo+rqjZv+JzECMcmicvVf0/56V6hc70tpC/nJMnmtMOYqqrrNLPXNLddq7dJSH7JbDc/4lKsWSNmBzWzxXVartZeMPAMR0AaiS/FUTK94bbapAkl9R39OnO0rfUIAmTTCxwiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QUDO2hy5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QUDO2hy5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343514c781fso314379a91.1
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 21:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763183429; x=1763788229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtA9JYoaa3vWr3rH9DK2nRp9N4kTo7XIdcKWScnKHOs=;
        b=QUDO2hy5Vkl6iI+Ad7WJYxc7uCegczSNcpoUjoQHDcST5D21gWUFzKWHWaL/A4vY/G
         s8T0Ksd6ZCSKojJh59zNLBJ4OTyUlMxZGeo+mKYxV3mYhEtx9W79hwC4E4V0e/L8+paG
         sOXUjLRwtSfJe3edBmQF386NaTs1bbOfp46pej/XhW2fsNL+GTvwHyiyIGy0ZKZx1hnh
         yubsmP9vLCX3xF2TAvVjU+AiTSt3XFnC4qcg9G+/m8XSrIDQ5gL8pS9HMNHTqkKDMuXV
         iGQj44D+wtpk7xqwVBXwJXo9gi/islIFvjPvscW7mlMXPmrNOhS8gu412jDbgjfe/aIe
         n2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763183429; x=1763788229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtA9JYoaa3vWr3rH9DK2nRp9N4kTo7XIdcKWScnKHOs=;
        b=by7etLHPNWZPeihOtA8cy6sDzNCbUPV/fQfYfxOMpXRcoDcMS0ONat96uF02nZ2GtU
         k/wVKB8SJ3I+hsBB0NTFF6TAOUn0k53PvGckiwNGgml5vGv+YPogIi7PKbH4Znzh7FaX
         xcXe+4gVtujWv60gxh7gBje5qozutCwNs8Q1oGYtrrJYhWUIwtrfMGn8p/mAgU+mig16
         TRDLu36uozMNefa7Va8nxo0f8qjHss/JHruxthDyGqCKAe2odurqTfV9iA3R5vWKL58L
         nNB6aLPvx25/e/atY1mE0i0W4A23f+VUDxepLnIfdkNbvxVs7QQORQdx/Ea5JtiALkKi
         bzcw==
X-Forwarded-Encrypted: i=1; AJvYcCVwJX2VHofLN/3nHxjfw/lHl2gTAOtFIzRHMi/j9Yag+SW9qMepwlRyCzTZhOKuQmEaGhysDClaF8G6Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYG2yDLR8WF2ZbL1wRqrPLr7dHRACFd6jkCx/RXTINXpiLkiyq
	mCoXydvEcso24KWLnr3uIoI+QuTh2lNXak1fU9qHPQtvFI+OcRU2hGj58agofzGdKxtp+g8mNjp
	el8K+Ixw7jQ1b7K8g+hNj58CMYXzym0ItYVM9WpwU/Q==
X-Gm-Gg: ASbGnctxt4y/JiVKo8/HF9kUKRNCqHO/urRusMytdikiGErv2lH2IQnS35kI6fko3Ng
	tPQog/PJqr4zlI1PsqH9gJFjO+4d/QG6EzF5NCGEjK/Pd5nYMH31Og1PmypX0qr7qrLIEpU3ABT
	F8gfB7goxRK+8drdAStYg37RyPxQ1SDXIGJHX4zbUzdnugFzoovVzGV2E8UEE3dT3lrr1WbA291
	vqfgRYgRefheeJmpJdxJQKVrvW4hYCQA4x5m3/MsBEw/uYCLBAxhgA3hCiQ7Q==
X-Google-Smtp-Source: AGHT+IG4QhlpbqonWT3NFS/TgmwvP46cTqNv/erADMyu6bnXe5SzkWfEFkgbgQliFWC4tytpxf/1xN4v68d781/Mi0Y=
X-Received: by 2002:a05:7022:69a1:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-11b491590a6mr1490987c88.1.1763183428856; Fri, 14 Nov 2025
 21:10:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-5-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-5-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 14 Nov 2025 21:10:17 -0800
X-Gm-Features: AWmQ_bkadGdgCBEd6_29jp8a1tgqh8k9SGhk2u2G4pEsSZ7Hj8xWA1PVT5bvUaw
Message-ID: <CADUfDZoqUn+tFfYYjc76Y2+0OuSzTq6tumcU3Pu8LXBEEUmy+w@mail.gmail.com>
Subject: Re: [PATCH V3 04/27] ublk: refactor auto buffer register in ublk_dispatch_req()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:38=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Refactor auto buffer register code and prepare for supporting batch IO
> feature, and the main motivation is to put 'ublk_io' operation code
> together, so that per-io lock can be applied for the code block.
>
> The key changes are:
> - Rename ublk_auto_buf_reg() as ublk_do_auto_buf_reg()
> - Introduce an enum `auto_buf_reg_res` to represent the result of
>   the buffer registration attempt (FAIL, FALLBACK, OK).
> - Split the existing `ublk_do_auto_buf_reg` function into two:
>   - `__ublk_do_auto_buf_reg`: Performs the actual buffer registration
>     and returns the `auto_buf_reg_res` status.
>   - `ublk_do_auto_buf_reg`: A wrapper that calls the internal function
>     and handles the I/O preparation based on the result.
> - Introduce `ublk_prep_auto_buf_reg_io` to encapsulate the logic for
>   preparing the I/O for completion after buffer registration.
> - Pass the `tag` directly to `ublk_auto_buf_reg_fallback` to avoid
>   recalculating it.
>
> This refactoring makes the control flow clearer and isolates the differen=
t
> stages of the auto buffer registration process.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 64 +++++++++++++++++++++++++++-------------
>  1 file changed, 43 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f1fa5ceacdf6..b36cd55eceb0 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1168,17 +1168,37 @@ static inline void __ublk_abort_rq(struct ublk_qu=
eue *ubq,
>  }
>
>  static void
> -ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io =
*io)
> +ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, unsigned tag)
>  {
> -       unsigned tag =3D io - ubq->ios;
>         struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, tag);
>
>         iod->op_flags |=3D UBLK_IO_F_NEED_REG_BUF;
>  }
>
> -static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct reque=
st *req,
> -                             struct ublk_io *io, struct io_uring_cmd *cm=
d,
> -                             unsigned int issue_flags)
> +enum auto_buf_reg_res {
> +       AUTO_BUF_REG_FAIL,
> +       AUTO_BUF_REG_FALLBACK,
> +       AUTO_BUF_REG_OK,
> +};
> +
> +static void ublk_prep_auto_buf_reg_io(const struct ublk_queue *ubq,
> +                                     struct request *req, struct ublk_io=
 *io,
> +                                     struct io_uring_cmd *cmd,
> +                                     enum auto_buf_reg_res res)
> +{
> +       if (res =3D=3D AUTO_BUF_REG_OK) {
> +               io->task_registered_buffers =3D 1;
> +               io->buf_ctx_handle =3D io_uring_cmd_ctx_handle(cmd);
> +               io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> +       }
> +       ublk_init_req_ref(ubq, io);
> +       __ublk_prep_compl_io_cmd(io, req);
> +}
> +
> +static enum auto_buf_reg_res
> +__ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req=
,
> +                      struct ublk_io *io, struct io_uring_cmd *cmd,
> +                      unsigned int issue_flags)
>  {
>         int ret;
>
> @@ -1186,29 +1206,27 @@ static bool ublk_auto_buf_reg(const struct ublk_q=
ueue *ubq, struct request *req,
>                                       io->buf.auto_reg.index, issue_flags=
);
>         if (ret) {
>                 if (io->buf.auto_reg.flags & UBLK_AUTO_BUF_REG_FALLBACK) =
{
> -                       ublk_auto_buf_reg_fallback(ubq, io);
> -                       return true;
> +                       ublk_auto_buf_reg_fallback(ubq, req->tag);
> +                       return AUTO_BUF_REG_FALLBACK;
>                 }
>                 blk_mq_end_request(req, BLK_STS_IOERR);
> -               return false;
> +               return AUTO_BUF_REG_FAIL;
>         }
>
> -       io->task_registered_buffers =3D 1;
> -       io->buf_ctx_handle =3D io_uring_cmd_ctx_handle(cmd);
> -       io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> -       return true;
> +       return AUTO_BUF_REG_OK;
>  }
>
> -static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
> -                                  struct request *req, struct ublk_io *i=
o,
> -                                  struct io_uring_cmd *cmd,
> -                                  unsigned int issue_flags)
> +static void ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct re=
quest *req,
> +                                struct ublk_io *io, struct io_uring_cmd =
*cmd,
> +                                unsigned int issue_flags)
>  {
> -       ublk_init_req_ref(ubq, io);
> -       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> -               return ublk_auto_buf_reg(ubq, req, io, cmd, issue_flags);
> +       enum auto_buf_reg_res res =3D __ublk_do_auto_buf_reg(ubq, req, io=
, cmd,
> +                       issue_flags);
>
> -       return true;
> +       if (res !=3D AUTO_BUF_REG_FAIL) {
> +               ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
> +               io_uring_cmd_done(cmd, UBLK_IO_RES_OK, issue_flags);
> +       }
>  }
>
>  static bool ublk_start_io(const struct ublk_queue *ubq, struct request *=
req,
> @@ -1281,8 +1299,12 @@ static void ublk_dispatch_req(struct ublk_queue *u=
bq,
>         if (!ublk_start_io(ubq, req, io))
>                 return;
>
> -       if (ublk_prep_auto_buf_reg(ubq, req, io, io->cmd, issue_flags))
> +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
> +               ublk_do_auto_buf_reg(ubq, req, io, io->cmd, issue_flags);
> +       } else {
> +               ublk_init_req_ref(ubq, io);
>                 ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags=
);
> +       }
>  }
>
>  static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
> --
> 2.47.0
>
