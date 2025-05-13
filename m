Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740EA1C68F
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165535; cv=none; b=jR5C8iNfdLDcnX1z4LRVUqewAN9+umil+YXlquvqBsNirsTZ1tRrFBWy0/0Ox+++POdQcsrG4jbPfzl1lbsfB7gZIHujsHUtVOAMtkO2n97ZvOwTCZ+lGfOGqG/doBc8BpKlIlunJWxGbm5POOSZ8ltFJYs6IBy8Tnxs84XvbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165535; c=relaxed/simple;
	bh=pK9QXctbgSMCkNcVbDZ7KXP/+NaTI1wSD54FaYJqF2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9bOmB7ZZDl6BkQ90O9vw3Es+P8JOnBT63lB0RmCOc08O63tNGBw4AOGXOMf+6B7bblepMANXtl4xf/dDNuHYwgr39oQ6/UocwfnwYkodsqlCcIv/HF89zFzgjdFrI9oVEkP6HmqYBCCM31C9GTaetY354BQZCtD8PSDN8Ftodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dl9yt09Z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dl9yt09Z"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22eed3b3cabso6978395ad.2
        for <linux-block@vger.kernel.org>; Tue, 13 May 2025 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747165532; x=1747770332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEUJz46JUE/wAtDmJTMuslGw7qi0DHM0vx8APKsxh2o=;
        b=dl9yt09ZQIv2iXTzxfAx1ctU5e7tII0n9wA8KeLYuEonPRti8a3y+hXAJNuVfQvaDH
         mbnu/zbn5ZelBTr6UgCiEWZBRVNx2tj3E//GQxfjo8dIz2+AePNAkAFpajba1Uui/E6H
         jLQKEM3nnoly9Ubq0Wiw3MxWz1mDmSmFvlHmV83fNiN3NdElpU5E78Y8IMSkDoM8xmSo
         Thiq3EiMYmN8RJtUUa+hwR/DdGh+mvMwqhpvzJMp0UTx8KoBJThaO96QzUga2cg0eLDs
         wPytiWpC4vMMcCKt9UZ/jge1nMzkAGZ9bNox0mNzBNtxRcKxSavMfqtgMvBZBml67wIQ
         QLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165532; x=1747770332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEUJz46JUE/wAtDmJTMuslGw7qi0DHM0vx8APKsxh2o=;
        b=R04wrR6sC+KyxA69DrvB2P2THKIp6tvl63eh4q2mojkgfgAeTYjntKTJNQlXrl8L33
         Ler5zkZ2xEcH/VbXn4eH7fEZMusyUJkQb+d7E5T25C0YJhaJYvI1m+7cQV38cwvu/OWc
         BTp9FGV8v1Q7ARYotVwRTT11/K/1uiLzFn/T6E3OY72z5D7odEDsBMzOoXFGd0654idv
         SJ3K7BBgZsTdHaCLGw/YOD8diQzUnOzoBBHvxUalV1mrk/c8KcHEzrWxJJOK8pjJ5tH/
         BEdhmY95x+qK90M9f3p53KggC3dsMpcSaV4DDIqBfFO4IKPgM9icjNjb2zpAtPyTT7hm
         qXwA==
X-Forwarded-Encrypted: i=1; AJvYcCXBET6y9ecG3MyTd0kFQIaJBZ+nln7JPZI4k++vw9rWlr+g+9xYXZ/Pr3dEhxkYMUEz3ukL+c5Q5WpQbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYaGN22T5onMT56HDGv4vNhIZ00dqpr3x+iePtqYYFm323cINx
	0WfVv15hlnhYswablxEvYLbxpbyv3seJI+YJCuHOxRCnoyDqPQSzyhs22DcxZkBO3fFBFI2sdtz
	s2CSnlXdRIHr8IYVOdaiv+KJBEqG5wEh3QjXvFQ==
X-Gm-Gg: ASbGncv4gM93/tkDuYzTDM73U/UuA1CULsu76FJEr+tO16UJ2ZgeseMHvJBKSuwHF3B
	Oz6OKdgYh56xJrfTygbGAc7xrWoitaOZDsTUIpeDni8sMYy2A657jiDVwvqq6R7ebpHZQ2LSzUo
	OhZoY3Xs41r3Jx7RLgmrs+aarcfdz1blM=
X-Google-Smtp-Source: AGHT+IH1WKhKMayZioA6dj2GnFgaBpo9WKmuIDZWhrCGt8Ex7HUNvB0GPl83kR5Egqr1vEjbCb4ZYuFO/LqsYLbQUGc=
X-Received: by 2002:a17:903:3ba5:b0:22e:61b1:fea1 with SMTP id
 d9443c01a7336-2319816d994mr3938595ad.14.1747165532509; Tue, 13 May 2025
 12:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509150611.3395206-1-ming.lei@redhat.com> <20250509150611.3395206-4-ming.lei@redhat.com>
In-Reply-To: <20250509150611.3395206-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 13 May 2025 12:45:21 -0700
X-Gm-Features: AX0GCFtzNSKiXcfl4KvLMZ89n7wm4wLd0oxrQ6IAzN-GoG0iGLOY9qnxFHgsrU0
Message-ID: <CADUfDZrdmxW=ppWBkJ1Xba8h+mHXWNxw7EVM6n-8R-5yDhuwMQ@mail.gmail.com>
Subject: Re: [PATCH V3 3/6] ublk: prepare for supporting to register request
 buffer automatically
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 8:06=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
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
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 72 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 66 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index ab5b0a5e98e9..1f98e561dc38 100644
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
> @@ -1992,9 +2041,16 @@ static int ublk_fetch(struct io_uring_cmd *cmd, st=
ruct ublk_queue *ubq,
>         return ret;
>  }
>
> +static void ublk_auto_buf_unreg(struct ublk_io *io, unsigned int issue_f=
lags)
> +{
> +       WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, 0, issue_flags));
> +       io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
> +}
> +
>  static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
>                                  struct ublk_io *io, struct io_uring_cmd =
*cmd,
> -                                const struct ublksrv_io_cmd *ub_cmd)
> +                                const struct ublksrv_io_cmd *ub_cmd,
> +                                unsigned int issue_flags)
>  {
>         struct request *req =3D io->req;
>
> @@ -2023,6 +2079,9 @@ static int ublk_commit_and_fetch(const struct ublk_=
queue *ubq,
>         if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
>                 req->__sector =3D ub_cmd->zone_append_lba;
>
> +       if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> +               ublk_auto_buf_unreg(io, issue_flags);
> +
>         if (likely(!blk_should_fake_timeout(req->q)))
>                 ublk_put_req_ref(ubq, req);
>
> @@ -2045,6 +2104,7 @@ static bool ublk_get_data(const struct ublk_queue *=
ubq, struct ublk_io *io)
>                         __func__, ubq->q_id, req->tag, io->flags,
>                         ublk_get_iod(ubq, req->tag)->addr);
>
> +       ublk_init_req_ref(ubq, req);

Is initializing the reference count even necessary for
UBLK_F_NEED_GET_DATA? UBLK_F_NEED_GET_DATA is mutually exclusive with
UBLK_F_USER_COPY and UBLK_F_SUPPORT_ZERO_COPY, so ublk_init_req_ref()
should be a no-op.

Other than that,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>         return ublk_start_io(ubq, req, io);
>  }
>
> @@ -2123,7 +2183,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
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
