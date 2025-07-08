Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B22DECCE
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981292; cv=none; b=Tf/1s1ec2COt9g0gPxpKwZZCu+CrcPGTfVrn6Na+6GBjTkePbqQYpM6tH9HQY231nTHJutCjOPiXHY1x4NNFnV/xGQp5czVhOqJY5TQwh7a6bRASyeb7Y6eDkL/leGZdNs9HnORawWiTgmrYUK8kl4mOON13sE5dtz4jk0zAduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981292; c=relaxed/simple;
	bh=RkXrETQP6dNXhhrmFN4ROJ3MegE8PjiV2JvnWrQErTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksmOYVUc4piNe1kPw/yuHwTdMVaTdKG0P/kif7SBj+E3IbjRbAPFreQQb0kV0I0x0QZBRXUBEEJ68frQfLwVxy2WR4Zc3IhNM3230IRwdjEMORxz56n8iB71biMwjXA6xqzXJci5AQZyaIosjMWh9/TZxGv8TZhsstLANcuEC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JAykvJXK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JAykvJXK"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234ae2bf851so5443105ad.1
        for <linux-block@vger.kernel.org>; Tue, 08 Jul 2025 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751981290; x=1752586090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov8VXRRuUXygVJkAV0gtPWitQwLVR2uUzxUpFYL7yXs=;
        b=JAykvJXKi96SqBmTUshrTaakvW42G6enVDXxdNkHgltTrfA1fho+COKaXv+jypv+OY
         oIp8lATRFhyDUs+zbdCNxrifP8vNjMsR7ygfGYozr6z5T7PzkN+cuAQ+xOhTJlDmpmno
         rh29ihStA/Q6eQqbjy9yqL4BbF5U9FcGljp5y2DANwHuXg66TaT3IC1QqaSIdSoJLyVo
         3QPPvN3rFL992qdqWU5ALBlpmBYmQcrgiZWZmy4jSIjDbW95mbr29SpaDZWr5aMqOnK4
         MxGL0Jl5V11Jj3VjYPEyeuWQ5+SiNHpelSSuLLIrkTfr6g8IjnB8j6LpWPkuRKzdqiMu
         RMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751981290; x=1752586090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov8VXRRuUXygVJkAV0gtPWitQwLVR2uUzxUpFYL7yXs=;
        b=KYFciiqYad1Ifj4IEIM/gxdTpZVV83KXtVpqloILgbYh0ZH8tGPz9KGns5dJOAkXUV
         WF0y0dgRQWY8+ZuMQYEqeRWgoDP+Tin1t+xBKAunVf77NGS/PcNJaN+p2GFOxoAej+3x
         rTl7ZY0reEglhmOCDKsOejy0snVAUfLroRV8r1/jDG/r0wIppgPqC+gURD1cpdF5jhqm
         gXGBRCPLThQ2Qhdh+na0XMioDY7jrAZ/fePiwsohp47RIiMPgCIWV6wAhGcgvEgODXJ+
         16RlCb3FXZp9ulyG5soB/OhhKoU+hY9zfjl29Zpjjo9h/QxMDUr1vqqTc8JQZH4UopAp
         JYNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBSM5BGrwFOmVez3P8tL4r3TbLi3L8H7qEyiHJo/OeJLA+cF2MYGafwf3bc/P+SwdZx0caSRIzu8Ci7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyev3rCf/Dv5ncG0PBRfpPrbcXyL1CqMcKKA3XVhnJvdm6PH7dF
	aqB7DmHOii1bVAhQWKl4QjwMZ61+Sz1J8Y6/DM5loCojXA/5B21rSmwX6diWsd8cuGH09zSqPxe
	0jXuCQzhIajMCI8t/LETvRskorCGSh5OgtEhnQDhvQg==
X-Gm-Gg: ASbGncvHfbnWgB3PqYCREhvS0/H8yM9td6DOqFoQFe05xF9PuUF5yJO0SKhsb5sfaYr
	o6+4VSF6Eb6flob+B18UHSQxJiGvOGTz0tCwDCP9TeWV6Gb0zfzUh7e1Nq19jKCGf/OELolqIRX
	mpZY4K3WO6QsS7SDroZ7nEMCFre+1ecRUb9ZBW9Isx5t7gYtsB6QW4E7M=
X-Google-Smtp-Source: AGHT+IGqndmFKkTJz+a/plR6yamwBitiOkjcw5JEBZ23JUYq5k4+HDzZtCnp4BJu2AMJWBJXVCKkyuP5pMEazJRTS4Y=
X-Received: by 2002:a17:902:f689:b0:234:d7b2:2abe with SMTP id
 d9443c01a7336-23c873b7648mr89500045ad.7.1751981289651; Tue, 08 Jul 2025
 06:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702040344.1544077-1-ming.lei@redhat.com> <20250702040344.1544077-9-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-9-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 8 Jul 2025 09:27:57 -0400
X-Gm-Features: Ac12FXxchdMtRvIh9kudWN_2Glp_2h1lJNFAGBHKLq5Rrb624DzdWTkVfcdtWHs
Message-ID: <CADUfDZo9SADywa6a_D5ZjwoU+3Y14CTg7Y1Ywhf-5Hsnu=fCyQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] ublk: remove ublk_commit_and_fetch()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:04=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Remove ublk_commit_and_fetch() and open code request completion.
>
> Now request reference is stored in 'ublk_io', which becomes one global
> variable, the motivation is to centralize access 'struct ublk_io' referen=
ce,
> then we can introduce lock to protect `ublk_io` in future for supporting
> io batch.

I didn't follow this. What do you mean by "global variable"?

>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 7fd2fa493d6a..13c6b1e0e1ef 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -711,13 +711,12 @@ static inline void ublk_put_req_ref(struct ublk_io =
*io, struct request *req)
>                 __ublk_complete_rq(req);
>  }
>
> -static inline void ublk_sub_req_ref(struct ublk_io *io, struct request *=
req)
> +static inline bool ublk_sub_req_ref(struct ublk_io *io, struct request *=
req)
>  {
>         unsigned sub_refs =3D UBLK_REFCOUNT_INIT - io->task_registered_bu=
ffers;
>
>         io->task_registered_buffers =3D 0;
> -       if (refcount_sub_and_test(sub_refs, &io->ref))
> -               __ublk_complete_rq(req);
> +       return refcount_sub_and_test(sub_refs, &io->ref);

The struct request *req parameter can be removed now. Looks like it
can be removed from ublk_need_complete_req() too.

>  }
>
>  static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
> @@ -2224,21 +2223,13 @@ static int ublk_check_commit_and_fetch(const stru=
ct ublk_queue *ubq,
>         return 0;
>  }
>
> -static void ublk_commit_and_fetch(const struct ublk_queue *ubq,
> -                                 struct ublk_io *io, struct io_uring_cmd=
 *cmd,
> -                                 struct request *req, unsigned int issue=
_flags,
> -                                 __u64 zone_append_lba, u16 buf_idx)
> +static bool ublk_need_complete_req(const struct ublk_queue *ubq,
> +                                  struct ublk_io *io,
> +                                  struct request *req)
>  {
> -       if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
> -               io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
> -
> -       if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> -               req->__sector =3D zone_append_lba;
> -
>         if (ublk_need_req_ref(ubq))
> -               ublk_sub_req_ref(io, req);
> -       else
> -               __ublk_complete_rq(req);
> +               return ublk_sub_req_ref(io, req);
> +       return true;
>  }
>
>  static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *=
io,
> @@ -2271,6 +2262,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>         unsigned tag =3D ub_cmd->tag;
>         struct request *req;
>         int ret;
> +       bool compl;
>
>         pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
>                         __func__, cmd->cmd_op, ub_cmd->q_id, tag,
> @@ -2347,8 +2339,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
>                         goto out;
>                 req =3D ublk_fill_io_cmd(io, cmd, ub_cmd->result);
>                 ret =3D ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &b=
uf_idx);
> -               ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
> -                                     ub_cmd->zone_append_lba, buf_idx);
> +               compl =3D ublk_need_complete_req(ubq, io, req);
> +
> +               /* can't touch 'ublk_io' any more */
> +               if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
> +                       io_buffer_unregister_bvec(cmd, buf_idx, issue_fla=
gs);
> +               if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> +                       req->__sector =3D ub_cmd->zone_append_lba;
> +               if (compl)
> +                       __ublk_complete_rq(req);

What is the benefit of separating the reference count decrement from
the call to __ublk_complete_rq()? I can understand if you want to keep
the code manipulating ublk_io separate from the code dispatching the
completed request. But it seems like this could be written more simply
as

if (ublk_need_complete_req(ubq, io, req))
        __ublk_complete_rq(req);

Best,
Caleb

> +
>                 if (ret)
>                         goto out;
>                 break;
> --
> 2.47.0
>
