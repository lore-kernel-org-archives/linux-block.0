Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9222A18D65C
	for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024670; cv=none; b=hxzfGEI15ZVnWgabbLBJGGlyRwmBfG7lbAgu73s+oJ8V2dn6GlRhDTZ3Zm1TyCjA+LrK1yY9Q1fJtwjkBXaSZCWEUj5w6EgLeCMKDZ3yjD6pexf3fRadEbkrJBy6fHBYhSlJUEPNKTWeBKlB5V9jJIAcIWCtckjh3ubcskoEYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024670; c=relaxed/simple;
	bh=NCcp8hCsmejCq+FSWXRD3v20a7U6ndkKV49r2cmDA2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvmF3LnMH8qP0LHMLbAg16+hyTNlFkPws5ZpGdxnXY5/AvvxKBSt06evWEc4fZyfwmyPQj8OzbrA2pSeTnrpEkuXqRFyPYrN8PmNZFBSL8eEKj1ehLTGjCv9UkTga9xvfkfF7Q7cD5bdMqfMjJ1jN60d3K3N6ZiSf9xAN3iAZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U2xsA7bz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U2xsA7bz"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so51521a91.3
        for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 14:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743024668; x=1743629468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RogaLn74MA/pLnVl1HWQrTj+WxNxYyzjrAJ+bwp6L3Y=;
        b=U2xsA7bzX7mCjT97tSJeys3yo7ZbSQr5K+HjJaON66BCmNzcgT8kwj4eCdpVzMRdC/
         vRyn81GBQ/02FYBUTFopeLZiCUHCMOmu2AFNrNBsmV1NIkPezdxxbMDhxtPCCinBDD74
         1DfG2FOQpS0itEKc4Ls+fEEgZ2tpoFexgSL8uY4JoEn0orfZYJUR0p6Bype7SzJ0oakl
         8k+aueQwUE50woB4prxCIJa3gVOFTqfbFWWcGfZn/zhxYUWET2LN6t3oYcmKLuouoYxG
         3WR9KNt05Vo6wMutfWes7FwInFG/guaXG3OW2ZwGQ0YdAw3LmMedg6bk38hP/r1QMrZ0
         asgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743024668; x=1743629468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RogaLn74MA/pLnVl1HWQrTj+WxNxYyzjrAJ+bwp6L3Y=;
        b=FByIAE9FhPRD0ZmhU39/iGHPcx18MujsLpy1NvR/tG10qOdRpNrt1iWcb5V+bX1Lyx
         cqWNmrSCrszx8D00hFLmvWNNrFKx0B4pUQxTKJKltthVrfyc88JoTeMT7G8XCeoQmj+a
         AOYuTJxlT7JaFYrEa0jGEr3iz+lfmLZtoM8w4oO3GHF5ZvddwI3PbfFHebo0ekLcK6nf
         AsKOL6C9Mq8v7Y1yjbjQ86HyS37wjHSrAw4FnH8KLcxL3Bl4pCTez2PdU/f3jVs/DZVQ
         NP0fchBX2Vq+nZQGqc+vInx98IZQ7odsMHOUi2lprIswwZqfPkF6JBz38hYg7TmW4ZZn
         GNwA==
X-Forwarded-Encrypted: i=1; AJvYcCWyjy/3k4r+Gr3F6gYzbk1f0NtooySVFWzvhASCfpTzYCMp9qVRCk3SMxQujw37mb/A82p5kw4OD8kwvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtEyaPR+Y7T1R+OJCLA74uFb7LoeByJ2AAZkmR3A633BrZm94Y
	BCO7mbzpv/wVxsINUQ48x7KjxNBj34kpdepFt2aSmyCxkTBL35D/qtQGYwfVHsktzAeuPqYwl4x
	xh6/jAy0XZYh16GFm9k2ejQ3FuZXT1MCUZrOhsg==
X-Gm-Gg: ASbGncsR5Q27BBeEbUGNmrYWM6VQPcPl23WpOMuU7Wmm3a8iJrmVULNFcbG5rC8Z4PX
	uRC2spzro04Ry5zdhBDh5MjYjjQlbKxd47t3RNuG6yHxRv2gUhd0PI/L6N0JI1aiVOfQGAD3mQR
	tIQu9xoWcYWptEI8sGKYNPXVzk
X-Google-Smtp-Source: AGHT+IFIn+mj3pJmvAx20lMZCVFRo89DdYtIqq4Wk4vtIpBCugWFXsUjKNZMMtzu1q6T1kWEO1/nUsKjWnqgpB6kUJc=
X-Received: by 2002:a17:90b:1b48:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-303a91a3395mr573090a91.7.1743024667626; Wed, 26 Mar 2025
 14:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324134905.766777-1-ming.lei@redhat.com> <20250324134905.766777-7-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-7-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 26 Mar 2025 14:30:56 -0700
X-Gm-Features: AQ5f1JqsuImub5rcHuLpx3VP3pbztzABrAo9eCyASLqKRNHDWC6uqkhlOBwlBxg
Message-ID: <CADUfDZoBTkNypLXsVFMsZLSJGw3i7VxnQ=POodmYm=E4HPU=SA@mail.gmail.com>
Subject: Re: [PATCH 6/8] ublk: implement ->queue_rqs()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Implement ->queue_rqs() for improving perf in case of MQ.
>
> In this way, we just need to call io_uring_cmd_complete_in_task() once fo=
r
> one batch, then both io_uring and ublk server can get exact batch from
> client side.
>
> Follows IOPS improvement:
>
> - tests
>
>         tools/testing/selftests/ublk/kublk add -t null -q 2 [-z]
>
>         fio/t/io_uring -p0 /dev/ublkb0
>
> - results:
>
>         more than 10% IOPS boost observed
>
> Pass all ublk selftests, especially the io dispatch order test.
>
> Cc: Uday Shankar <ushankar@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 85 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 77 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 53a463681a41..86621fde7fde 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -83,6 +83,7 @@ struct ublk_rq_data {
>  struct ublk_uring_cmd_pdu {
>         struct ublk_queue *ubq;
>         u16 tag;
> +       struct rq_list list;
>  };
>
>  /*
> @@ -1258,6 +1259,32 @@ static void ublk_queue_cmd(struct ublk_queue *ubq,=
 struct request *rq)
>         io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
>  }
>
> +static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> +               unsigned int issue_flags)
> +{
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> +       struct ublk_queue *ubq =3D pdu->ubq;
> +       struct request *rq;
> +
> +       while ((rq =3D rq_list_pop(&pdu->list))) {
> +               struct ublk_io *io =3D &ubq->ios[rq->tag];
> +
> +               ublk_rq_task_work_cb(io->cmd, issue_flags);

ublk_rq_task_work_cb() is duplicating the lookup of ubq, rq, and io.
Could you factor out a helper that takes those values instead of cmd?

> +       }
> +}
> +
> +static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *=
l)
> +{
> +       struct request *rq =3D l->head;
> +       struct ublk_io *io =3D &ubq->ios[rq->tag];
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(io->cmd=
);
> +
> +       pdu->ubq =3D ubq;

Why does pdu->ubq need to be set here but not in ublk_queue_cmd()? I
would have thought it would already be set to ubq because pdu comes
from a rq belonging to this ubq.

> +       pdu->list =3D *l;
> +       rq_list_init(l);
> +       io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb);

Could store io->cmd in a variable to avoid looking it up twice.

> +}
> +
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>         struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> @@ -1296,16 +1323,13 @@ static enum blk_eh_timer_return ublk_timeout(stru=
ct request *rq)
>         return BLK_EH_RESET_TIMER;
>  }
>
> -static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> -               const struct blk_mq_queue_data *bd)
> +static blk_status_t ublk_prep_rq_batch(struct request *rq)

naming nit: why "batch"?

>  {
> -       struct ublk_queue *ubq =3D hctx->driver_data;
> -       struct request *rq =3D bd->rq;
> +       struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
>         blk_status_t res;
>
> -       if (unlikely(ubq->fail_io)) {
> +       if (unlikely(ubq->fail_io))
>                 return BLK_STS_TARGET;
> -       }
>
>         /* fill iod to slot in io cmd buffer */
>         res =3D ublk_setup_iod(ubq, rq);
> @@ -1324,17 +1348,58 @@ static blk_status_t ublk_queue_rq(struct blk_mq_h=
w_ctx *hctx,
>         if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort)=
)
>                 return BLK_STS_IOERR;
>
> +       if (unlikely(ubq->canceling))
> +               return BLK_STS_IOERR;

Why is ubq->cancelling treated differently for ->queue_rq() vs. ->queue_rqs=
()?

> +
> +       blk_mq_start_request(rq);
> +       return BLK_STS_OK;
> +}
> +
> +static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> +               const struct blk_mq_queue_data *bd)
> +{
> +       struct ublk_queue *ubq =3D hctx->driver_data;
> +       struct request *rq =3D bd->rq;
> +       blk_status_t res;
> +
>         if (unlikely(ubq->canceling)) {
>                 __ublk_abort_rq(ubq, rq);
>                 return BLK_STS_OK;
>         }
>
> -       blk_mq_start_request(bd->rq);
> -       ublk_queue_cmd(ubq, rq);
> +       res =3D ublk_prep_rq_batch(rq);
> +       if (res !=3D BLK_STS_OK)
> +               return res;
>
> +       ublk_queue_cmd(ubq, rq);
>         return BLK_STS_OK;
>  }
>
> +static void ublk_queue_rqs(struct rq_list *rqlist)
> +{
> +       struct rq_list requeue_list =3D { };
> +       struct rq_list submit_list =3D { };
> +       struct ublk_queue *ubq =3D NULL;
> +       struct request *req;
> +
> +       while ((req =3D rq_list_pop(rqlist))) {
> +               struct ublk_queue *this_q =3D req->mq_hctx->driver_data;
> +
> +               if (ubq && ubq !=3D this_q && !rq_list_empty(&submit_list=
))
> +                       ublk_queue_cmd_list(ubq, &submit_list);
> +               ubq =3D this_q;

Probably could avoid the extra ->driver_data dereference on every rq
by comparing the mq_hctx pointers instead. The ->driver_data
dereference could be moved to the ublk_queue_cmd_list() calls.

> +
> +               if (ublk_prep_rq_batch(req) =3D=3D BLK_STS_OK)
> +                       rq_list_add_tail(&submit_list, req);
> +               else
> +                       rq_list_add_tail(&requeue_list, req);
> +       }
> +
> +       if (ubq && !rq_list_empty(&submit_list))
> +               ublk_queue_cmd_list(ubq, &submit_list);
> +       *rqlist =3D requeue_list;
> +}
> +
>  static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
>                 unsigned int hctx_idx)
>  {
> @@ -1347,6 +1412,7 @@ static int ublk_init_hctx(struct blk_mq_hw_ctx *hct=
x, void *driver_data,
>
>  static const struct blk_mq_ops ublk_mq_ops =3D {
>         .queue_rq       =3D ublk_queue_rq,
> +       .queue_rqs      =3D ublk_queue_rqs,
>         .init_hctx      =3D ublk_init_hctx,
>         .timeout        =3D ublk_timeout,
>  };
> @@ -3147,6 +3213,9 @@ static int __init ublk_init(void)
>         BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
>                         UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET=
);
>
> +       BUILD_BUG_ON(sizeof(struct ublk_uring_cmd_pdu) >
> +                       sizeof_field(struct io_uring_cmd, pdu));

Looks like Uday also suggested this, but if you change
ublk_get_uring_cmd_pdu() to use io_uring_cmd_to_pdu(), you get this
check for free.

Best,
Caleb


> +
>         init_waitqueue_head(&ublk_idr_wq);
>
>         ret =3D misc_register(&ublk_misc);
> --
> 2.47.0
>
