Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FCC2D3EC2
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756874532; cv=none; b=LYU1FUOg5ccboPq9QmWnM1psokoqKjvA504D6Iy6CANVNcD/mErJOHS5Ia4mNnY21AZtZvvRdLCIcdsXUQGc2jJ3WNNBfrENa0h6BN7mrMFg5NmVvBCXki/K9juqZ2Zyp7dGezXhxhOkxuXwzR2424uTgjbtaRUOXv0sMwFUY4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756874532; c=relaxed/simple;
	bh=Gr+68Ct1MLDNrF/iFdR1CrnEIszYsuJ3Ef/aDpmFy8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cywb352YFkoAEZisQowf0za6f708jaPAH2vVuQZnxvY258p+WTaiPCc3QuxeOd6We5rmFFeA9HpCAjeYKXWMJp54UloRYR0Zt1+ZHBgYbBQgwlG4+XTdDfRFNnvHqs+nzAR3qvzKuq4jIbR3pyMd07D/pDiOZ0xVF0yptYiBSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TUcZn1lm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TUcZn1lm"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61ea08e565bso360402a12.0
        for <linux-block@vger.kernel.org>; Tue, 02 Sep 2025 21:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756874528; x=1757479328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO5+Tzhv9e6qgsf9jqp9nRMuyVQngskjNeglgB1amyw=;
        b=TUcZn1lmmYuJIFLCP6F7hVZxdxf9j5NIJzIHb4yRFfWlW5uVbYxfpVRf4Zu04nNWw3
         HF7+rj4pbN6rvW3S8zl+UJrBWJl4w6inLO9XkcN5xlBkP/pQnog8FAwqtgPm/SWuxQkU
         q89rzFkvwoOnynaQcBUFnYZHKDvipD8h26lWI4bDlY7tZyFzyKnX5xu+blfl1D+GJOl+
         u0BUwx5U65VZYorL2DpbfdYyCxf6lNb/FIeeixLsXg4GtieXh9fKXD8Nwyk/XXA37wbR
         QKZ9Zbztp0qEpMsCO8pIbNFaD6P44WWPpJ/Nmt31Fg7gkfq/WZpTuL1IQXXe8NkA3iT1
         PDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756874528; x=1757479328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO5+Tzhv9e6qgsf9jqp9nRMuyVQngskjNeglgB1amyw=;
        b=HzSMImPXa6EJh1Sy6FDPgldAdTteTZaaHFV3koCw6zygi2FosJnv8+rdjHOUiG4cca
         2eg7JJZH2X0LzuoaPaZw3NRY4Tl2+Qfujc4zvVdkiBAtQVuUdLgxv/ZJH9wfBT+cfjUr
         tbwyuCsQQapTvpZhc7+rjX7DQ3Zpo1ar3C36kSCc34ZTwiNA4l8yNSRE0+LKSssd0GfM
         7qsgky5EGnSlQkOGzeN3wyOY9OrYKxLmeSxJ92/qGp3smiFGoCmIjDHnCQNuJnldAdss
         sUtbdI+N34hTWsr3zDPkGVAWWrHhzDzFqxwQLSxLk4Vm/OV5RHOiNsgh9C/kqfQ8hiKq
         E/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMGwXFjCxt9QbRKIUKUS3ags7vuTI1Bogiz5oKiWDW7MWt1n56theMurI7NW1wOlotbN7xSbyG5Dq8Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMB9zIJAOud2kQil+VdqhrK9QxHJZZS0rfhUf01rIkLaM7qWz6
	Kzf7hnBLflVaBkVLCD3dffYapFlQI14vK8TmVyUCN76cGUgkxJOtEfJVY8XCKvbPHruEzf0zeNc
	kV/r991GzrJtVoBcwFnOFM4jjTiXB3TfeyExTvGZsWw==
X-Gm-Gg: ASbGncvOShS82d4SvIbg+eiR6kIrBf6zpRtfl/U8/qZ3X1NhP1yZmFHAS+IRd3v4NHo
	8+2Bg7E6pptpuIGel+J9YT1CABf3U2NWOLxpwbGIgvojHvIgFMHsqezK9KLz9H+1SIqdZSr3raf
	nQEb+KHXx1LucNO3scjIMgf2oZsKqznThYZKwJI/m4lKVuXh97w9S2Y6NI2kzV7eeQdlqY47Ezq
	vVILCiEiSOLBbROvJyft4g=
X-Google-Smtp-Source: AGHT+IGKYn7zgfdWypYOdqj6yY78rX9OTzZWRAmyyr3+zXvjhDt24DZiPbs4y/rGy72NRpi6El/u0Dhrrls/nO7Sn8A=
X-Received: by 2002:a05:6402:524f:b0:615:aec5:b595 with SMTP id
 4fb4d7f45d1cf-61d0d2a58f9mr7967343a12.1.1756874528475; Tue, 02 Sep 2025
 21:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-4-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 2 Sep 2025 21:41:55 -0700
X-Gm-Features: Ac12FXypbhq4QoEOCuxluAhd-2AgcWEwNlaeboebnZeb2qTeD515cJgoFjQjibc
Message-ID: <CADUfDZqfFC__Y7uqE4LDUsKmWwM=Fyiyh4KMNL-OE+iw059g7Q@mail.gmail.com>
Subject: Re: [PATCH 03/23] ublk: refactor auto buffer register in ublk_dispatch_req()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Refactor auto buffer register code and prepare for supporting batch IO
> feature, and the main motivation is to put 'ublk_io' operation code
> together, so that per-io lock can be applied for the code block.
>
> The key changes are:
> - Rename ublk_auto_buf_reg() as ublk_do_auto_buf_reg()

Thanks, the type and the function having the same name was a minor annoyanc=
e.

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
> ---
>  drivers/block/ublk_drv.c | 65 +++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 9185978abeb7..e53f623b0efe 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1205,17 +1205,36 @@ static inline void __ublk_abort_rq(struct ublk_qu=
eue *ubq,
>  }
>
>  static void
> -ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io =
*io)
> +ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, unsigned tag)
>  {
> -       unsigned tag =3D io - ubq->ios;

The reason to calculate the tag like this was to avoid the pointer
dereference in req->tag. But req->tag is already accessed just prior
in ublk_dispatch_req(), so it should be cached and not too expensive
to load again.

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

nit: move this enum definition next to the function that returns it?

> +
> +static void ublk_prep_auto_buf_reg_io(const struct ublk_queue *ubq,
> +                                  struct request *req, struct ublk_io *i=
o,
> +                                  struct io_uring_cmd *cmd, bool registe=
red)

How about passing enum auto_buf_reg_res instead of bool registered to
avoid the duplicated =3D=3D AUTO_BUF_REG_OK in the callers?

> +{
> +       if (registered) {
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
> @@ -1223,29 +1242,27 @@ static bool ublk_auto_buf_reg(const struct ublk_q=
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
> +               ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res =3D=3D A=
UTO_BUF_REG_OK);
> +               io_uring_cmd_done(cmd, UBLK_IO_RES_OK, 0, issue_flags);
> +       }
>  }
>
>  static bool ublk_start_io(const struct ublk_queue *ubq, struct request *=
req,
> @@ -1318,8 +1335,14 @@ static void ublk_dispatch_req(struct ublk_queue *u=
bq,
>         if (!ublk_start_io(ubq, req, io))
>                 return;
>
> -       if (ublk_prep_auto_buf_reg(ubq, req, io, io->cmd, issue_flags))
> +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
> +               struct io_uring_cmd *cmd =3D io->cmd;

Don't really see the need for this intermediate variable

Best,
Caleb

> +
> +               ublk_do_auto_buf_reg(ubq, req, io, cmd, issue_flags);
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
