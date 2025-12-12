Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4635958
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558677; cv=none; b=SsCxZdzOuaxnEb+nVfkkP1HY1ormUcgzH94FYtgoSHU2HgKcqB9qVNB3AZkZ2odJCWxnTuNmNf/UB82K7mSSd84gAcREnk9LYKrZ43vGwE90Kn7UJ3zwmHavEd6T5YMXI9VN80wP4JkY+D4M8HUicnZ0oZwOwHrJ8t+/WKdXbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558677; c=relaxed/simple;
	bh=rm8eBWO3HQ1GbgWTuwxH95vgQ+0Jxe/bYzWzLHUXaXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVxDn2sqw1+zlJiHIDnTaQHLidGltj0AMz/5/jFrSc+y27qvA3cyQRPHo0OkMuonY2BwRqTAvls8ADRkvKrCuDpKZp0uv/e+9zQtBQuuEydfvfZHk03BKBNGQwLc8aREYlr60wajW25Z1u55p/6woun9AXTGBfQRX2mlzP1eLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z0Pu1GpZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z0Pu1GpZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34abca71f9cso187465a91.3
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 08:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765558675; x=1766163475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yUoX6IlmaVABsKZSs5vcTjT9zf/kVXn7uDf0h+MBAI=;
        b=Z0Pu1GpZ4bLT4ht919iJioOJ1Ktt1heA0xxdmo2EbBDuOPVN/zRxrlG7u0RZtTNUGe
         UStwU97dW9gM0HjRYcuNc7IwIkDfFA/M29msuryzAU4DXeC+lGB5OG0HmvQj4CwsoBp9
         umI8POhxuZmgrPRdKNQUHvZYnL9yfO28tFDV/4EwcksEmuxy49R0EGCokYhFhJo2lyKG
         NGDxyOhVvoC5Quztyfa4dG0s1Y3JxEVoMlnLUtmhq5tE4Bhayp4QmIRk1ycgIShC2PEa
         SmliPrrTvxSrnOeixGvf/abyrLc/jW7yTftqHEyk5qDz4RZjSB1/VXIvyNmu0JLEPXmI
         A/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765558675; x=1766163475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yUoX6IlmaVABsKZSs5vcTjT9zf/kVXn7uDf0h+MBAI=;
        b=EsmhLlBYfuvMDi5wyPqZDe4ghYNPnXxA5cYTV7LHbKGgWQuP4giwhEdnQkp/z+Pdos
         Ri4urRonqfRrjbcDM6tftSiK5HVq08LIa9j+3jR3+yaWv3QzINLu9xwP20qNXWFOo4WR
         u33dTdqqSCn1m/nxZdP2+jTPvymwhD8aepIqf6xZN7swfKb6P+eV2MUgVXY70v4UAwZv
         hsQu2sjZWW4IIIC4Z+9Eeit3Yc6JW6DZJIxPp1LLLqS2NYKpLBK1OvHUy2/5+p4o0x9j
         7/QHvpzn5jUw0q+a5eBiNkd1vUn41gkQ2FpA0PgC27xdjikL65sZEJWRAgaPQFq3OHf1
         YcyA==
X-Forwarded-Encrypted: i=1; AJvYcCXgzkrcJML3WlS+NUltVtpIohNFjx8YlLgUFC4ikCG2+ijEQgb9Mcs6uTvgRhb5KNjnavFEhfz/I9zbkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMpeyyMLan+3fDForjCdec+f4C+BTFAPfMNp7sMlJLAGxJcds
	eaVROLm0VNS8MGmmRfg9kD8OFYDcjuoB3SgaQUc2Il1xvi7IIvvjLg/RatFqvsBhJp6D5juVjGL
	H+BmCcv27bPrJqu21WLsFn0C5qxcxx9NqcE38BHKbEg==
X-Gm-Gg: AY/fxX4cAmYeXkvz02xnhXdv1gLLagikF5OhnGo0+N5/e/7lzw3BuicTr8aQE2t/SYy
	4uLekia79TFdaTLWdqTvo9DjRC5IipFBP0GG3Kl0LKwOOKW1sXR3ca8Tf4HjdrAmgraVq+maBW3
	oK8efZebiyNDcauZlvo5JSiTD1Ize3+w1kkHxWj+WsfLUGpUp7myLZ2EtFlVmqSaACcj24sZ+nT
	yukI/SIACcWrbxyjtbZzHIOuJ/A5n/QlePbBNlc3BVXuahPgS7v13HH8OIMIauGU1+ZwovG
X-Google-Smtp-Source: AGHT+IFo2oThuXlxpAMmG6maujA/xAWlvr6Av4IWgt3JGX+qtRy7yr9KZrCpmXciYBcF6U3PjgtLThSuGqLGtGppjYE=
X-Received: by 2002:a05:7022:b98:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-11f34c5d690mr1179144c88.7.1765558675148; Fri, 12 Dec 2025
 08:57:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212143415.485359-1-ming.lei@redhat.com>
In-Reply-To: <20251212143415.485359-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 12 Dec 2025 08:57:42 -0800
X-Gm-Features: AQt7F2pp0AEolB2bsyVVMfU-91rnyoxHQVFKWMhiUTtEzX0NLQnhPLswj1CN6-0
Message-ID: <CADUfDZq5pXN4qAnoM4nrM6Pisfi-B2B4LzQ1OO6jmofxZqEA8g@mail.gmail.com>
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 6:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> When one process(such as udev) opens ublk block device (e.g., to read
> the partition table via bdev_open()), a deadlock[1] can occur:
>
> 1. bdev_open() grabs disk->open_mutex
> 2. The process issues read I/O to ublk backend to read partition table
> 3. In __ublk_complete_rq(), blk_update_request() or blk_mq_end_request()
>    runs bio->bi_end_io() callbacks
> 4. If this triggers fput() on file descriptor of ublk block device, the
>    work may be deferred to current task's task work (see fput() implement=
ation)
> 5. This eventually calls blkdev_release() from the same context
> 6. blkdev_release() tries to grab disk->open_mutex again
> 7. Deadlock: same task waiting for a mutex it already holds
>
> The fix is to run blk_update_request() and blk_mq_end_request() with bott=
om
> halves disabled. This forces blkdev_release() to run in kernel work-queue
> context instead of current task work context, and allows ublk server to m=
ake
> forward progress, and avoids the deadlock.
>
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver=
")
> Link: https://github.com/ublk-org/ublksrv/issues/170 [1]
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
> V2:
>         - cover another two cases of ending request(Caleb Sander Mateos)
>
>  drivers/block/ublk_drv.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index df9831783a13..38f138f248e6 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1080,12 +1080,20 @@ static inline struct ublk_uring_cmd_pdu *ublk_get=
_uring_cmd_pdu(
>         return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
>  }
>
> +static void ublk_end_request(struct request *req, blk_status_t error)
> +{
> +       local_bh_disable();
> +       blk_mq_end_request(req, error);
> +       local_bh_enable();
> +}
> +
>  /* todo: handle partial completion */
>  static inline void __ublk_complete_rq(struct request *req, struct ublk_i=
o *io,
>                                       bool need_map)
>  {
>         unsigned int unmapped_bytes;
>         blk_status_t res =3D BLK_STS_OK;
> +       bool requeue;
>
>         /* failed read IO if nothing is read */
>         if (!io->res && req_op(req) =3D=3D REQ_OP_READ)
> @@ -1117,14 +1125,26 @@ static inline void __ublk_complete_rq(struct requ=
est *req, struct ublk_io *io,
>         if (unlikely(unmapped_bytes < io->res))
>                 io->res =3D unmapped_bytes;
>
> -       if (blk_update_request(req, BLK_STS_OK, io->res))
> +       /*
> +        * Run bio->bi_end_io() from softirq context for preventing this
> +        * ublk's blkdev_release() from being called on current's task
> +        * work, see fput() implementation.
> +        *
> +        * Otherwise, ublk server may not provide forward progress in
> +        * case of reading partition table from bdev_open() with
> +        * disk->open_mutex grabbed, and causes dead lock.
> +        */
> +       local_bh_disable();
> +       requeue =3D blk_update_request(req, BLK_STS_OK, io->res);
> +       local_bh_enable();
> +       if (requeue)
>                 blk_mq_requeue_request(req, true);
>         else if (likely(!blk_should_fake_timeout(req->q)))
>                 __blk_mq_end_request(req, BLK_STS_OK);
>
>         return;
>  exit:
> -       blk_mq_end_request(req, res);
> +       ublk_end_request(req, res);
>  }
>
>  static struct io_uring_cmd *__ublk_prep_compl_io_cmd(struct ublk_io *io,
> @@ -1164,7 +1184,7 @@ static inline void __ublk_abort_rq(struct ublk_queu=
e *ubq,
>         if (ublk_nosrv_dev_should_queue_io(ubq->dev))
>                 blk_mq_requeue_request(rq, false);
>         else
> -               blk_mq_end_request(rq, BLK_STS_IOERR);
> +               ublk_end_request(rq, BLK_STS_IOERR);
>  }
>
>  static void
> @@ -1209,7 +1229,7 @@ __ublk_do_auto_buf_reg(const struct ublk_queue *ubq=
, struct request *req,
>                         ublk_auto_buf_reg_fallback(ubq, req->tag);
>                         return AUTO_BUF_REG_FALLBACK;
>                 }
> -               blk_mq_end_request(req, BLK_STS_IOERR);
> +               ublk_end_request(req, BLK_STS_IOERR);
>                 return AUTO_BUF_REG_FAIL;
>         }
>
> --
> 2.47.1
>
