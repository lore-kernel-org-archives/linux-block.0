Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DD2DFF18
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 01:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777365; cv=none; b=dq7ZdcNDb8JJ7CGT5toV+T/XyP6VRFzMI65URz4DS4lAp3+TvKIAkE8Ls7uYGW4LKFyOJNVouXR0oY3j5Jhk79obFoPBNNS452HQi6HWPm4KsmSy0nFhkQegY4slgi3F+b/IxVapTIMSIbEgHGUZJAaAkFOx+fUCJUiZdLduJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777365; c=relaxed/simple;
	bh=4/Uhd8Znb9sZjcGcDPqLOzxQbIb6ppksBxHE4QsnWQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0US8S6H4kgOZH7V+mVGpMBOmsuVdXfnMAsmOEu3K5rMHJdXOX/hKooNo9GAO+VKKEt1JNpxPOererfakGYfE24quiKS8tCd1SVPUfEpPoMDz/TvTVPBdL/HPvkUji0QLhblUP8PxigFtoiO0HY9Hk01nasd8JVlB+KH0IPbBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ecTAvNWK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ecTAvNWK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24602f6d8b6so11490725ad.1
        for <linux-block@vger.kernel.org>; Mon, 01 Sep 2025 18:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756777363; x=1757382163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfCifJrB2SLyWnEpCswsFOTC1RVMEBJVNSJK/ERFiaY=;
        b=ecTAvNWKmsApE0GWkKM15tnLYJntjGFFrAfb5pdXfTbsxF4BVsGI5ttDmdFWxUFReK
         Ojzn1DToUtGqv2x6Ey1J0DOcdtzdmuo8YZQwn2syTDWT8PxotoKE0KNCH/8X92S53ytR
         goq3VTIih6c1kK5wTijdhUjJafwCDX4qkrhHSTBtlEe2j4WMOM64khlRsRuaM2PwMiwl
         26pRR/qOyVpHcoWCzdv1Da7kIjyzd9q9PNLNM4qz+JWBBoaVbCjCg6rn1HQCaNpf/5JL
         zQZnbqeSmYHLqLvuCFi4vjyR56Q1CElcLufkO5fRhu033jJqZnBqHWFJFmE/kQzXgvZ/
         SEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756777363; x=1757382163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfCifJrB2SLyWnEpCswsFOTC1RVMEBJVNSJK/ERFiaY=;
        b=NQ8k8bUVOq4VPm3ga+EyqCQ4BUQePmJ+nBl/KfodLJ5H4Sl+McZ2fiyE6Cy8dvqDbE
         CmjGVB+aolsFsqEMUjqPEBT75wdu/lVaWwlk8QKfpKgIh+eH97IsIl3RbzZkwtAmh5ey
         CE6sY+Hn1fg0CbHzzv07Ghs+sUtOApMT8OjzXQDyDHiiRDpV+Fo7SISgf86E6gYdFy2W
         e5h1dveMbfwSnMxIxUtJTKomXa1Lbz8Wsf4FrXGb1NJCSseLLDS7NiFUriQyw+5qlIEE
         sIQdkaZ4g/e9PKrcwdc1pZYk31rTklKK8CRvjnN75jTjgDt6HLerGl8YVmeTjA6Ynqlg
         WfqQ==
X-Gm-Message-State: AOJu0YydQPYf6NUV4/4j5NXG5mUyzIZQXI721NpyDN5yrKCwCfKlMKkw
	UHx9qeoJAPQnzhh+pS1TgAnnjMgcP17dguUpK95R+OJ84pIjJVnZhOctRdJ8F1xD7jG54a3OSya
	SjekLj0BH4MruypOcvL+0b55L83WY+7W7MdXawtgvHg==
X-Gm-Gg: ASbGncurc3noVyr9GMeH022G7x7ti6QML914sKfk8rqzwQrPj6giWnkmKEt+WzGWjEI
	iW0MqBdYXkz5vdPUdAW5OgderJI9dLgAYpqRc5EMOYWeqMRdi7av/2aoQM7YI6NcHnUzfLIE1HB
	Rt19l0ft4BDSpMcrPpHpiWgOLFy1xbPtoF8RBBBM9lw+jQFLypfd09X1zeuCHEq27IsmmRMrtcT
	H62aXXikcHd
X-Google-Smtp-Source: AGHT+IFNrCMV5JbVD/Utd+eFEPbj80kRL6MOqB3HvdE5Vm/AOFRuQOyvBR7oXZH7xIIJH4zyY7d9O43cXofgbAhdYXs=
X-Received: by 2002:a17:903:186:b0:248:9afa:7bc3 with SMTP id
 d9443c01a7336-2491f246dc8mr81314945ad.8.1756777362921; Mon, 01 Sep 2025
 18:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808153251.282107-1-csander@purestorage.com>
In-Reply-To: <20250808153251.282107-1-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Sep 2025 18:42:31 -0700
X-Gm-Features: Ac12FXw8NS4EHlKpbA5KOiJ_5HMYwxKG21MH7DTOolyIr0tWM_P3gM76r_c3I2U
Message-ID: <CADUfDZovEN1MouTGyWHC4ZuhuPPTZ6WCkrS=yqa18xuJifuvqw@mail.gmail.com>
Subject: Re: [PATCH] ublk: inline __ublk_ch_uring_cmd()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 8:32=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> ublk_ch_uring_cmd_local() is a thin wrapper around __ublk_ch_uring_cmd()
> that copies the ublksrv_io_cmd from user-mapped memory to the stack
> using READ_ONCE(). This ublksrv_io_cmd is passed by pointer to
> __ublk_ch_uring_cmd() and __ublk_ch_uring_cmd() is a large function
> unlikely to be inlined, so __ublk_ch_uring_cmd() will have to load the
> ublksrv_io_cmd fields back from the stack. Inline __ublk_ch_uring_cmd()
> into ublk_ch_uring_cmd_local() and load the ublksrv_io_cmd fields into
> local variables with READ_ONCE(). This allows the compiler to delay
> loading the fields until they are needed and choose whether to store
> them in registers or on the stack.

Ming, thoughts on this patch? Do you see any value I'm missing in
keeping ublk_ch_uring_cmd_local() and __ublk_ch_uring_cmd() as
separate functions?

Thanks,
Caleb

>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 62 +++++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6561d2a561fa..a0ac944ec965 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2267,56 +2267,60 @@ static bool ublk_get_data(const struct ublk_queue=
 *ubq, struct ublk_io *io,
>                         ublk_get_iod(ubq, req->tag)->addr);
>
>         return ublk_start_io(ubq, req, io);
>  }
>
> -static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> -                              unsigned int issue_flags,
> -                              const struct ublksrv_io_cmd *ub_cmd)
> +static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
> +               unsigned int issue_flags)
>  {
> +       /* May point to userspace-mapped memory */
> +       const struct ublksrv_io_cmd *ub_src =3D io_uring_sqe_cmd(cmd->sqe=
);
>         u16 buf_idx =3D UBLK_INVALID_BUF_IDX;
>         struct ublk_device *ub =3D cmd->file->private_data;
>         struct ublk_queue *ubq;
>         struct ublk_io *io;
>         u32 cmd_op =3D cmd->cmd_op;
> -       unsigned tag =3D ub_cmd->tag;
> +       u16 q_id =3D READ_ONCE(ub_src->q_id);
> +       u16 tag =3D READ_ONCE(ub_src->tag);
> +       s32 result =3D READ_ONCE(ub_src->result);
> +       u64 addr =3D READ_ONCE(ub_src->addr); /* unioned with zone_append=
_lba */
>         struct request *req;
>         int ret;
>         bool compl;
>
> +       WARN_ON_ONCE(issue_flags & IO_URING_F_UNLOCKED);
> +
>         pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
> -                       __func__, cmd->cmd_op, ub_cmd->q_id, tag,
> -                       ub_cmd->result);
> +                       __func__, cmd->cmd_op, q_id, tag, result);
>
>         ret =3D ublk_check_cmd_op(cmd_op);
>         if (ret)
>                 goto out;
>
>         /*
>          * io_buffer_unregister_bvec() doesn't access the ubq or io,
>          * so no need to validate the q_id, tag, or task
>          */
>         if (_IOC_NR(cmd_op) =3D=3D UBLK_IO_UNREGISTER_IO_BUF)
> -               return ublk_unregister_io_buf(cmd, ub, ub_cmd->addr,
> -                                             issue_flags);
> +               return ublk_unregister_io_buf(cmd, ub, addr, issue_flags)=
;
>
>         ret =3D -EINVAL;
> -       if (ub_cmd->q_id >=3D ub->dev_info.nr_hw_queues)
> +       if (q_id >=3D ub->dev_info.nr_hw_queues)
>                 goto out;
>
> -       ubq =3D ublk_get_queue(ub, ub_cmd->q_id);
> +       ubq =3D ublk_get_queue(ub, q_id);
>
>         if (tag >=3D ubq->q_depth)
>                 goto out;
>
>         io =3D &ubq->ios[tag];
>         /* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->t=
ask */
>         if (unlikely(_IOC_NR(cmd_op) =3D=3D UBLK_IO_FETCH_REQ)) {
> -               ret =3D ublk_check_fetch_buf(ubq, ub_cmd->addr);
> +               ret =3D ublk_check_fetch_buf(ubq, addr);
>                 if (ret)
>                         goto out;
> -               ret =3D ublk_fetch(cmd, ubq, io, ub_cmd->addr);
> +               ret =3D ublk_fetch(cmd, ubq, io, addr);
>                 if (ret)
>                         goto out;
>
>                 ublk_prep_cancel(cmd, issue_flags, ubq, tag);
>                 return -EIOCBQUEUED;
> @@ -2326,11 +2330,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>                 /*
>                  * ublk_register_io_buf() accesses only the io's refcount=
,
>                  * so can be handled on any task
>                  */
>                 if (_IOC_NR(cmd_op) =3D=3D UBLK_IO_REGISTER_IO_BUF)
> -                       return ublk_register_io_buf(cmd, ubq, io, ub_cmd-=
>addr,
> +                       return ublk_register_io_buf(cmd, ubq, io, addr,
>                                                     issue_flags);
>
>                 goto out;
>         }
>
> @@ -2348,26 +2352,26 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>                         ^ (_IOC_NR(cmd_op) =3D=3D UBLK_IO_NEED_GET_DATA))
>                 goto out;
>
>         switch (_IOC_NR(cmd_op)) {
>         case UBLK_IO_REGISTER_IO_BUF:
> -               return ublk_daemon_register_io_buf(cmd, ubq, io, ub_cmd->=
addr,
> +               return ublk_daemon_register_io_buf(cmd, ubq, io, addr,
>                                                    issue_flags);
>         case UBLK_IO_COMMIT_AND_FETCH_REQ:
> -               ret =3D ublk_check_commit_and_fetch(ubq, io, ub_cmd->addr=
);
> +               ret =3D ublk_check_commit_and_fetch(ubq, io, addr);
>                 if (ret)
>                         goto out;
> -               io->res =3D ub_cmd->result;
> +               io->res =3D result;
>                 req =3D ublk_fill_io_cmd(io, cmd);
> -               ret =3D ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &b=
uf_idx);
> +               ret =3D ublk_config_io_buf(ubq, io, cmd, addr, &buf_idx);
>                 compl =3D ublk_need_complete_req(ubq, io);
>
>                 /* can't touch 'ublk_io' any more */
>                 if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
>                         io_buffer_unregister_bvec(cmd, buf_idx, issue_fla=
gs);
>                 if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> -                       req->__sector =3D ub_cmd->zone_append_lba;
> +                       req->__sector =3D addr;
>                 if (compl)
>                         __ublk_complete_rq(req);
>
>                 if (ret)
>                         goto out;
> @@ -2377,11 +2381,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>                  * ublk_get_data() may fail and fallback to requeue, so k=
eep
>                  * uring_cmd active first and prepare for handling new re=
queued
>                  * request
>                  */
>                 req =3D ublk_fill_io_cmd(io, cmd);
> -               ret =3D ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, NU=
LL);
> +               ret =3D ublk_config_io_buf(ubq, io, cmd, addr, NULL);
>                 WARN_ON_ONCE(ret);
>                 if (likely(ublk_get_data(ubq, io, req))) {
>                         __ublk_prep_compl_io_cmd(io, req);
>                         return UBLK_IO_RES_OK;
>                 }
> @@ -2428,30 +2432,10 @@ static inline struct request *__ublk_check_and_ge=
t_req(struct ublk_device *ub,
>  fail_put:
>         ublk_put_req_ref(io, req);
>         return NULL;
>  }
>
> -static inline int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
> -               unsigned int issue_flags)
> -{
> -       /*
> -        * Not necessary for async retry, but let's keep it simple and al=
ways
> -        * copy the values to avoid any potential reuse.
> -        */
> -       const struct ublksrv_io_cmd *ub_src =3D io_uring_sqe_cmd(cmd->sqe=
);
> -       const struct ublksrv_io_cmd ub_cmd =3D {
> -               .q_id =3D READ_ONCE(ub_src->q_id),
> -               .tag =3D READ_ONCE(ub_src->tag),
> -               .result =3D READ_ONCE(ub_src->result),
> -               .addr =3D READ_ONCE(ub_src->addr)
> -       };
> -
> -       WARN_ON_ONCE(issue_flags & IO_URING_F_UNLOCKED);
> -
> -       return __ublk_ch_uring_cmd(cmd, issue_flags, &ub_cmd);
> -}
> -
>  static void ublk_ch_uring_cmd_cb(struct io_uring_cmd *cmd,
>                 unsigned int issue_flags)
>  {
>         int ret =3D ublk_ch_uring_cmd_local(cmd, issue_flags);
>
> --
> 2.45.2
>
