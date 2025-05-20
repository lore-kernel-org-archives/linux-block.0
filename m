Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AEE1A83FB
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747762815; cv=none; b=Y69Vc5HUr7JNk5yNcLQKPGYOE2dRkk9ovcK+SrC+KRDMf9Gu66xttRWpKeDqc2WriiCFGSx7iQUaGqlfl6kllzKL+OTbR+8kLY7W93IUlFLFZb9lOdUxG6JkUmXDDu6HAR9FBjCC/fwFd/kEVFT73bNKf+dm0KZVCPKeWEV7QR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747762815; c=relaxed/simple;
	bh=1x6uCrSLRdGiOkXgASTnq0VTqysOHydI0vShS8av8kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7MjgKNW13b8t76W1OOGZn9RM50K/GJ2DM401LD8XRSuKw/XSo/gzZx6f3XOpk9Z2x0pU/6V+3iuty2BCH+eiB3kUri6ErLzkO+Zd7qo8oDQUwuqQeDi+oqy/45livHtK5H2KG7sr4rhY8PXXTbk1oIbl1iUwRLeBB/Wpgv/5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZRNmdjTO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZRNmdjTO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e1782cbb2so5137745ad.0
        for <linux-block@vger.kernel.org>; Tue, 20 May 2025 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747762812; x=1748367612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEURIW4Iy4eeFGIJczideFRYsv7NlN0VZZaGbj3S21U=;
        b=ZRNmdjTOjN3a0CugQkruq7LYiV3SnKiSKFjNYmP9SNwxONAfvl0w6kcfeHZ3GPAGei
         dXqAFINpN5RrKAav63kqKh4tm8QIWcy94UzI+9c1brw+5yXJIruy/P2v4j1NzxKxe2cK
         9o9kV4os87MJAt0VXuLxVqKdftK8J4L0/pD/NJsOnbh7+1vdAGZVLn5i4gU5bfBCndQY
         uD9NPm5fsOcvwsdxFOm7xw19yf3PiLKHQI+zX+BOalzuf1QB7wyt+1b37pKdvgv+Xtod
         Xqz2z7zFogJR1CFcSDr80VWJyS1N6w3uT0a16dVal7BjJFwVdrf9I3D4wKgX4Hh9qQmq
         G1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747762812; x=1748367612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEURIW4Iy4eeFGIJczideFRYsv7NlN0VZZaGbj3S21U=;
        b=lW6TsL0952uXygw6z8OvQt6KqwJm+dCO6dLyg+0KLCNkGGc1CgcvHCma65uzsSXYwq
         E3rFNE2qEd758GccmoYiqxGBBGIsgZgxaLLluZiX39QIEjYPRIq3/C1lDp3PRE1gXC5K
         MHaFchnxyBYMyHdBBr+8Ke2QlC9UEN6xJ0QDmHQx7CzkNWIE01ogaC7qy/v4ETlkjCcV
         egMw+HXTRdYGs3vWYfprza/AXV6XxlGqNwzEQP9Y5k071/7sWaHELTNmeKTWH4HKkBNL
         NpGRyoXtDV+gpFf6njRNRYmlXcPtPfMAelcpwZInATDD7ToOf+6ThYqP2V8IPib2akWd
         2Hrg==
X-Forwarded-Encrypted: i=1; AJvYcCXXu2UUtoyUqYfLdUcyZkIbgx3GQ41iw5T8Up+cBQ7WVMzIskbOYtNrBeNuLMcvm7+mqB3rTdL88oblVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSWiwA9s3bTni8JqpmUaAOhwC7obbW2fyLnHhl/9pviAWO7rU
	hyDyLWc6euguCGw1qTdCyblNxtQW//0ESPI0KNMJQjx2yp5F8S6JJoXClvFkxxo1KbUY/LhFuzt
	rUIzokJbsEbsVNB5YwjPs8uWiAerlWN9fa5OymTe1EQ==
X-Gm-Gg: ASbGncsOWbt1HtZ1QxKEyAXxjQ2JMsk03jvJfjfgKsWNnV/DXQtnDOv5jrPD4OZr9OY
	R05j09L1KG3qDIN8JTvN67d8Bypcu+i0F1vttZEqTK2uI5UUYrmC+9KYg0KcvoxIkmYn7jbfOma
	5Vy/mZqWwJgkTDgRTf1ZaI3Ju+n/cH6wc=
X-Google-Smtp-Source: AGHT+IFMpypvzpbMk//WFoWyvcSnLMfi/QSPnlFz6hHHSsVstJ2ucmwXdWaLU2Fi4aRDgDQdhia0gaC5VcpsCiSo6+Y=
X-Received: by 2002:a17:902:d54c:b0:224:10a2:cad1 with SMTP id
 d9443c01a7336-231d45168bcmr97746935ad.10.1747762812206; Tue, 20 May 2025
 10:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520045455.515691-1-ming.lei@redhat.com> <20250520045455.515691-3-ming.lei@redhat.com>
In-Reply-To: <20250520045455.515691-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 20 May 2025 10:40:01 -0700
X-Gm-Features: AX0GCFvVUqG46rIdAJ__emFNFS84rpewOmmvYlpXtltpYSyj2BjmBITxeujLRkA
Message-ID: <CADUfDZrLLGDf2yYSuuTnbK_WDNQCxUyCbC2bziUg7_BB3vWAtA@mail.gmail.com>
Subject: Re: [PATCH V5 2/6] ublk: prepare for supporting to register request
 buffer automatically
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 9:55=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> UBLK_F_SUPPORT_ZERO_COPY requires ublk server to issue explicit buffer
> register/unregister uring_cmd for each IO, this way is not only inefficie=
nt,
> but also introduce dependency between buffer consumer and buffer register=
/
> unregister uring_cmd, please see tools/testing/selftests/ublk/stripe.c
> in which backing file IO has to be issued one by one by IOSQE_IO_LINK.
>
> Prepare for adding feature UBLK_F_AUTO_BUF_REG for addressing the existin=
g
> zero copy limitation:
>
> - register request buffer automatically to ublk uring_cmd's io_uring
>   context before delivering io command to ublk server
>
> - unregister request buffer automatically from the ublk uring_cmd's
>   io_uring context when completing the request
>
> - io_uring will unregister the buffer automatically when uring is
>   exiting, so we needn't worry about accident exit
>
> For using this feature, ublk server has to create one sparse buffer table
>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 70 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index ae2f47dc8224..3e56a9d267fb 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -133,6 +133,14 @@ struct ublk_uring_cmd_pdu {
>   */
>  #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
>
> +/*
> + * request buffer is registered automatically, so we have to unregister =
it
> + * before completing this request.
> + *
> + * io_uring will unregister buffer automatically for us during exiting.
> + */
> +#define UBLK_IO_FLAG_AUTO_BUF_REG      0x10
> +
>  /* atomic RW with ubq->cancel_lock */
>  #define UBLK_IO_FLAG_CANCELED  0x80000000
>
> @@ -205,6 +213,7 @@ struct ublk_params_header {
>         __u32   types;
>  };
>
> +static void ublk_io_release(void *priv);
>  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
>  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *=
ubq);
>  static inline struct request *__ublk_check_and_get_req(struct ublk_devic=
e *ub,
> @@ -619,6 +628,11 @@ static inline bool ublk_support_zero_copy(const stru=
ct ublk_queue *ubq)
>         return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
>  }
>
> +static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ub=
q)
> +{
> +       return false;
> +}
> +
>  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
>  {
>         return ubq->flags & UBLK_F_USER_COPY;
> @@ -626,7 +640,8 @@ static inline bool ublk_support_user_copy(const struc=
t ublk_queue *ubq)
>
>  static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
>  {
> -       return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ub=
q);
> +       return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ub=
q) &&
> +               !ublk_support_auto_buf_reg(ubq);
>  }
>
>  static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> @@ -637,8 +652,13 @@ static inline bool ublk_need_req_ref(const struct ub=
lk_queue *ubq)
>          *
>          * for zero copy, request buffer need to be registered to io_urin=
g
>          * buffer table, so reference is needed
> +        *
> +        * For auto buffer register, ublk server still may issue
> +        * UBLK_IO_COMMIT_AND_FETCH_REQ before one registered buffer is u=
sed up,
> +        * so reference is required too.
>          */
> -       return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq)=
;
> +       return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq)=
 ||
> +               ublk_support_auto_buf_reg(ubq);
>  }
>
>  static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
> @@ -1155,6 +1175,35 @@ static inline void __ublk_abort_rq(struct ublk_que=
ue *ubq,
>                 blk_mq_end_request(rq, BLK_STS_IOERR);
>  }
>
> +static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
> +                             unsigned int issue_flags)
> +{
> +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> +       int ret;
> +
> +       ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io_release, 0,
> +                                     issue_flags);
> +       if (ret) {
> +               blk_mq_end_request(req, BLK_STS_IOERR);
> +               return false;
> +       }
> +       /* one extra reference is dropped by ublk_io_release */
> +       refcount_set(&data->ref, 2);
> +       io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> +       return true;
> +}
> +
> +static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
> +                                  struct request *req, struct ublk_io *i=
o,
> +                                  unsigned int issue_flags)
> +{
> +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> +               return ublk_auto_buf_reg(req, io, issue_flags);
> +
> +       ublk_init_req_ref(ubq, req);
> +       return true;
> +}
> +
>  static bool ublk_start_io(const struct ublk_queue *ubq, struct request *=
req,
>                           struct ublk_io *io)
>  {
> @@ -1180,7 +1229,6 @@ static bool ublk_start_io(const struct ublk_queue *=
ubq, struct request *req,
>                         mapped_bytes >> 9;
>         }
>
> -       ublk_init_req_ref(ubq, req);
>         return true;
>  }
>
> @@ -1226,7 +1274,8 @@ static void ublk_dispatch_req(struct ublk_queue *ub=
q,
>         if (!ublk_start_io(ubq, req, io))
>                 return;
>
> -       ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
> +       if (ublk_prep_auto_buf_reg(ubq, req, io, issue_flags))
> +               ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags=
);
>  }
>
>  static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
> @@ -1994,7 +2043,8 @@ static int ublk_fetch(struct io_uring_cmd *cmd, str=
uct ublk_queue *ubq,
>
>  static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
>                                  struct ublk_io *io, struct io_uring_cmd =
*cmd,
> -                                const struct ublksrv_io_cmd *ub_cmd)
> +                                const struct ublksrv_io_cmd *ub_cmd,
> +                                unsigned int issue_flags)
>  {
>         struct request *req =3D io->req;
>
> @@ -2014,6 +2064,14 @@ static int ublk_commit_and_fetch(const struct ublk=
_queue *ubq,
>                 return -EINVAL;
>         }
>
> +       if (ublk_support_auto_buf_reg(ubq)) {
> +               if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> +                       WARN_ON_ONCE(io_buffer_unregister_bvec(cmd, 0,
> +                                               issue_flags));

Since the io_ring_ctx is determined from the io_uring_cmd, this only
works if the UBLK_IO_COMMIT_AND_FETCH_REQ is submitted to the same
io_uring as the previous UBLK_IO_(COMMIT_AND_)FETCH_REQ for the ublk
I/O. It would be good to document that. And I would probably drop the
WARN_ON_ONCE() here, since it can be triggered from userspace.

Otherwise,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +                       io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
> +               }
> +       }
> +
>         ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
>
>         /* now this cmd slot is owned by ublk driver */
> @@ -2110,7 +2168,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>                         goto out;
>                 break;
>         case UBLK_IO_COMMIT_AND_FETCH_REQ:
> -               ret =3D ublk_commit_and_fetch(ubq, io, cmd, ub_cmd);
> +               ret =3D ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue=
_flags);
>                 if (ret)
>                         goto out;
>                 break;
> --
> 2.47.0
>
