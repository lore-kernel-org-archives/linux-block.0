Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B361F4289
	for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745707393; cv=none; b=ffSlYAzNVBO0wUaJpID4F4/vEkw99c63BdsJ3u+cQ/RUmAejJKfGYnFcKRwrS6gG0V5u/QUJlyNNGfEbN1vWLeJs0V6kY3MqpHurceTI5VQujrmvjAXlY3QivzjuQM8V2zskh9pvG9gKocCG74JJWD7o4PbLWLf6BnTCY6dMMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745707393; c=relaxed/simple;
	bh=4J9/ltwAAAv4ov7uCB4itZnKVt6VqD0UVKgadJ/LOnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWUIjown1UI6gnilfzr0hsnwZRE0yUwo+rrrwc9oLUFvgGbp4lJnGWqarIlclXwYr1lZaq/PrJVXvOtE7f7v84/AG1tmBIjFwVCTLF5FmBOe58OIputLAbLVX2kW+q4IGPByzj0Pobfri6+UK2NMxJxsn/FgEYEvePHQmzY3kKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ozxaeatx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ozxaeatx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c50beb0d5so6236575ad.3
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 15:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745707391; x=1746312191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Xx0fX1F1D5aCAMXDHK4G2uxKYTtL5XMjop/qLfFCDw=;
        b=Ozxaeatx8cMhE85O+yCCWJDO8mZbg5VOrTsujA078L7LUpl3/WwHBoiSjwFQOiF9RU
         qf6Si1NgYK7Q+bhoQFBYpf7BVawYazIhaUvMlknwRga+kI8XG9Qu452Zg20kxtOpFDS/
         WeSiQcCA//q3oh//iHUpxuAiJsVmi92ruS9yKr3mnBrI4zXwx5VXP7KOru1KUeR7c9do
         dp3yiMf9Af8nY9FO2oxtFhpRHW26Q5fvFPf6F6vwJn8c9HG4UCiWIMUK/coB2Iq0yt/5
         cI7tN3kHQ9C4I26Z+UWiXjvWuWliBgSrc+H5q/IhZVbVI2HUPa3+fBCYb5hWgDbHQzAb
         Lx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745707391; x=1746312191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Xx0fX1F1D5aCAMXDHK4G2uxKYTtL5XMjop/qLfFCDw=;
        b=ZqmRRvodcNrOcjBB+PhAYianWvoNxrJXMcGcDB0hXwPQe/qyJKMobkanWLrbQm24Eh
         ATWus2cOEzEYFx0ge5xurbRwzxbff17tUTQPs+LhH+X/XqeYN0JALGR88K9mZQbu7lPn
         si/CgjkuOIi0SzhFxwM3WTicZKB+uh6UEopuKTnDtaJLWNLF33zvFaFPX+fQ9Ye70LPF
         nkIW/NKZyWpt09VXe3j1YXlWP44HOOMGxuwF0vTkrd2JHy36HQmJWT48CjTribZzRAQf
         dfFNBmYx5q4onrlewaRiNH2QF8B/4DzVR+R1MHIt6+4zssSwreKsCdtEoig3JfJhkjKM
         Gq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+vivvvW/TTjJnKTaCfzmdUYe2EGJHYuCvvaIQATJV9Z+rkvA0fviLUSwBktVzp/YKRXXrBzmYrxXEuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/deiTCerLEPJlA2Wr18toulmVIUv4gsN8sJJZoQXMofSHTJ+z
	hmpBo6gN5wUZJjUCLIjm8DWjJvsQNFf6RXV1gduov3SDm0Yc6heFCPCv6/y3oaZKjpWDqNif6xK
	FNj4UtgGe+M/haDZB1ZoCil3lX4t4LB/5DJAGBQ==
X-Gm-Gg: ASbGncuIUKyD7KvRB4dgnwFlpDZNrT1dexqSL+BJROBD5ok+mMVutv4288iSArWiGnL
	j8N4Vx3/3RkTZ5NlKEpugwkPUhXwMUCgQlNDjQUQe69oWDn2xI83d0w7MXH/BfWAezKbMzqwKnp
	PL/omHTYAtSvEnG0bRhi/pTQE940LK1rs=
X-Google-Smtp-Source: AGHT+IH+bBf+f4OgOVThZUT6wMQx0WscJhBgfAKKUZGefIEpQqzTZdGLcpaihVOP33/0NO8ANR/zi43jS6aiVuqRt4I=
X-Received: by 2002:a17:90b:3812:b0:306:e6ec:dc82 with SMTP id
 98e67ed59e1d1-309f7ea2a93mr3803693a91.6.1745707390706; Sat, 26 Apr 2025
 15:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426094111.1292637-1-ming.lei@redhat.com> <20250426094111.1292637-4-ming.lei@redhat.com>
In-Reply-To: <20250426094111.1292637-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 26 Apr 2025 15:42:59 -0700
X-Gm-Features: ATxdqUFPhM7oeO7gGPgaJswYw52Xt_clh89TKwaghwSOl8KyUGGHO4erdYLcBNg
Message-ID: <CADUfDZqQ_xvFMP=yjUYvvnn6u36iNBmcgoONBoBVhDjyiZQfjA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ublk: add feature UBLK_F_AUTO_ZERO_COPY
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 2:41=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> UBLK_F_SUPPORT_ZERO_COPY requires ublk server to issue explicit buffer
> register/unregister uring_cmd for each IO, this way is not only inefficie=
nt,
> but also introduce dependency between buffer consumer and buffer register=
/
> unregister uring_cmd, please see tools/testing/selftests/ublk/stripe.c
> in which backing file IO has to be issued one by one by IOSQE_IO_LINK.

This is a great idea!

>
> Add feature UBLK_F_AUTO_ZERO_COPY for addressing the existed zero copy
> limit:

nit: "existed" -> "existing", "limit" -> "limitation"

>
> - register request buffer automatically before delivering io command to
> ublk server
>
> - unregister request buffer automatically when completing the request
>
> - io_uring will unregister the buffer automatically when uring is
>   exiting, so we needn't worry about accident exit
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 87 +++++++++++++++++++++++++++--------
>  include/uapi/linux/ublk_cmd.h | 20 ++++++++
>  2 files changed, 89 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 347790b3a633..453767f91431 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -64,7 +64,8 @@
>                 | UBLK_F_CMD_IOCTL_ENCODE \
>                 | UBLK_F_USER_COPY \
>                 | UBLK_F_ZONED \
> -               | UBLK_F_USER_RECOVERY_FAIL_IO)
> +               | UBLK_F_USER_RECOVERY_FAIL_IO \
> +               | UBLK_F_AUTO_ZERO_COPY)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -131,6 +132,14 @@ struct ublk_uring_cmd_pdu {
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
> +#define UBLK_IO_FLAG_UNREG_BUF         0x10
> +
>  /* atomic RW with ubq->cancel_lock */
>  #define UBLK_IO_FLAG_CANCELED  0x80000000
>
> @@ -207,7 +216,8 @@ static inline struct ublksrv_io_desc *ublk_get_iod(st=
ruct ublk_queue *ubq,
>                                                    int tag);
>  static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
>  {
> -       return ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZE=
RO_COPY);
> +       return ub->dev_info.flags & (UBLK_F_USER_COPY |
> +                       UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_AUTO_ZERO_COPY)=
;
>  }
>
>  static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> @@ -614,6 +624,11 @@ static inline bool ublk_support_zero_copy(const stru=
ct ublk_queue *ubq)
>         return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
>  }
>
> +static inline bool ublk_support_auto_zc(const struct ublk_queue *ubq)
> +{
> +       return ubq->flags & UBLK_F_AUTO_ZERO_COPY;
> +}
> +
>  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
>  {
>         return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)=
;
> @@ -621,7 +636,7 @@ static inline bool ublk_support_user_copy(const struc=
t ublk_queue *ubq)
>
>  static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
>  {
> -       return !ublk_support_user_copy(ubq);
> +       return !ublk_support_user_copy(ubq) && !ublk_support_auto_zc(ubq)=
;
>  }
>
>  static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> @@ -629,17 +644,21 @@ static inline bool ublk_need_req_ref(const struct u=
blk_queue *ubq)
>         /*
>          * read()/write() is involved in user copy, so request reference
>          * has to be grabbed
> +        *
> +        * For auto zc, ublk server still may issue UBLK_IO_COMMIT_AND_FE=
TCH_REQ
> +        * before one registered buffer is used up, so reference is
> +        * required too.
>          */
> -       return ublk_support_user_copy(ubq);
> +       return ublk_support_user_copy(ubq) || ublk_support_auto_zc(ubq);

Since both places where ublk_support_user_copy() is used are being
adjusted to also check ublk_support_auto_zc(), maybe
ublk_support_user_copy() should just be changed to check
UBLK_F_AUTO_ZERO_COPY too?

>  }
>
>  static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
> -               struct request *req)
> +               struct request *req, int init_ref)
>  {
>         if (ublk_need_req_ref(ubq)) {
>                 struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
>
> -               kref_init(&data->ref);
> +               refcount_set(&data->ref.refcount, init_ref);

It might be nicer not to mix kref and raw reference count operations.
Maybe you could add a prep patch that switches from struct kref to
refcount_t?

>         }
>  }
>
> @@ -667,6 +686,15 @@ static inline void ublk_put_req_ref(const struct ubl=
k_queue *ubq,
>         }
>  }
>
> +/* for ublk zero copy */
> +static void ublk_io_release(void *priv)
> +{
> +       struct request *rq =3D priv;
> +       struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> +
> +       ublk_put_req_ref(ubq, rq);
> +}
> +
>  static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
>  {
>         return ubq->flags & UBLK_F_NEED_GET_DATA;
> @@ -1231,7 +1259,22 @@ static void ublk_dispatch_req(struct ublk_queue *u=
bq,
>                         mapped_bytes >> 9;
>         }
>
> -       ublk_init_req_ref(ubq, req);
> +       if (ublk_support_auto_zc(ubq) && ublk_rq_has_data(req)) {
> +               int ret;
> +
> +               /* one extra reference is dropped by ublk_io_release */
> +               ublk_init_req_ref(ubq, req, 2);
> +               ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io_rel=
ease,
> +                                             tag, issue_flags);

Using the ublk request tag as the registered buffer index may be too
limiting. It would cause collisions if there are multiple ublk devices
or queues handled on a single io_uring. It also requires offsetting
any registered user buffers so their indices come after all the ublk
ones, which may be difficult if ublk devices are added dynamically.
Perhaps the UBLK_IO_FETCH_REQ operation could specify the registered
buffer index to use for the request?

This also requires the io_uring issuing the zero-copy I/Os to be the
same as the one submitting the ublk fetch requests. That would also
make it difficult for us to adopt for our ublk server, which uses
separate io_urings. Not sure if there is a simple way the ublk server
could specify what io_uring to register the ublk zero-copy buffers
with.

> +               if (ret) {
> +                       blk_mq_end_request(req, BLK_STS_IOERR);
> +                       return;

Does this leak the ublk fetch request? Seems like it should be
completed to the ublk server with an error code.

> +               }
> +               io->flags |=3D UBLK_IO_FLAG_UNREG_BUF;
> +       } else {
> +               ublk_init_req_ref(ubq, req, 1);
> +       }
> +
>         ubq_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
>  }
>
> @@ -1593,7 +1636,8 @@ static int ublk_ch_mmap(struct file *filp, struct v=
m_area_struct *vma)
>  }
>
>  static void ublk_commit_completion(struct ublk_device *ub,
> -               const struct ublksrv_io_cmd *ub_cmd)
> +               const struct ublksrv_io_cmd *ub_cmd,
> +               unsigned int issue_flags)
>  {
>         u32 qid =3D ub_cmd->q_id, tag =3D ub_cmd->tag;
>         struct ublk_queue *ubq =3D ublk_get_queue(ub, qid);
> @@ -1604,6 +1648,15 @@ static void ublk_commit_completion(struct ublk_dev=
ice *ub,
>         io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
>         io->res =3D ub_cmd->result;
>
> +       if (io->flags & UBLK_IO_FLAG_UNREG_BUF) {
> +               int ret;
> +
> +               ret =3D io_buffer_unregister_bvec(io->cmd, tag, issue_fla=
gs);
> +               if (ret)
> +                       io->res =3D ret;

I think it would be confusing to report an error to the application
submitting the I/O if unregistration fails. The only scenario where it
seems possible for this to fail is if userspace issues an
IORING_REGISTER_BUFFERS_UPDATE that overwrites the registered buffer
slot while the ublk request is being handled by the ublk server. I
would either ignore any error from io_buffer_unregister_bvec() or
return it to the ublk server.

> +               io->flags &=3D ~UBLK_IO_FLAG_UNREG_BUF;
> +       }
> +
>         /* find the io request and complete */
>         req =3D blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
>         if (WARN_ON_ONCE(unlikely(!req)))
> @@ -1942,14 +1995,6 @@ static inline void ublk_prep_cancel(struct io_urin=
g_cmd *cmd,
>         io_uring_cmd_mark_cancelable(cmd, issue_flags);
>  }
>
> -static void ublk_io_release(void *priv)
> -{
> -       struct request *rq =3D priv;
> -       struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> -
> -       ublk_put_req_ref(ubq, rq);
> -}
> -
>  static int ublk_register_io_buf(struct io_uring_cmd *cmd,
>                                 struct ublk_queue *ubq, unsigned int tag,
>                                 unsigned int index, unsigned int issue_fl=
ags)
> @@ -2124,7 +2169,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>                 }
>
>                 ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> -               ublk_commit_completion(ub, ub_cmd);
> +               ublk_commit_completion(ub, ub_cmd, issue_flags);
>                 break;
>         case UBLK_IO_NEED_GET_DATA:
>                 if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> @@ -2730,6 +2775,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_=
ctrl_cmd *header)
>                 return -EINVAL;
>         }
>
> +       /* F_AUTO_ZERO_COPY and F_SUPPORT_ZERO_COPY can't co-exist */
> +       if ((info.flags & UBLK_F_AUTO_ZERO_COPY) &&
> +                       (info.flags & UBLK_F_SUPPORT_ZERO_COPY))
> +               return -EINVAL;
> +
>         /*
>          * unprivileged device can't be trusted, but RECOVERY and
>          * RECOVERY_REISSUE still may hang error handling, so can't
> @@ -2747,7 +2797,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_c=
trl_cmd *header)
>                  * buffer by pwrite() to ublk char device, which can't be
>                  * used for unprivileged device
>                  */
> -               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY))
> +               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY |
> +                                       UBLK_F_AUTO_ZERO_COPY))
>                         return -EINVAL;
>         }
>
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 583b86681c93..d8bb5e55cce7 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -211,6 +211,26 @@
>   */
>  #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
>
> +/*
> + * request buffer is registered automatically before delivering this io
> + * command to ublk server, meantime it is un-registered automatically
> + * when completing this io command.
> + *
> + * request tag has to be used as the buffer index, and ublk server has t=
o
> + * pass this IO's tag as buffer index for using the registered zero copy
> + * buffer
> + *
> + * This way avoids extra uring_cmd cost, but also simplifies backend
> + * implementation, such as, the dependency on IO_REGISTER_IO_BUF and
> + * IO_UNREGISTER_IO_BUF becomes not necessary.
> + *
> + * For using this feature, ublk server has to register buffer table
> + * in sparse way, and buffer number has to be >=3D ublk queue depth.
> + *
> + * This feature is preferred to UBLK_F_SUPPORT_ZERO_COPY.
> + */
> +#define UBLK_F_AUTO_ZERO_COPY  (1ULL << 10)

This flag is already taken by UBLK_F_UPDATE_SIZE in commit "ublk: Add
UBLK_U_CMD_UPDATE_SIZE". You may need to rebase on for-6.16/block.

Best,
Caleb

> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> --
> 2.47.0
>
