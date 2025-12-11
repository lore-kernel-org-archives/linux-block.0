Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4525EFB6
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765485049; cv=none; b=M8S8tlYvNWL6DuFzHDqQLhHpNB7TzZ1h9FJJs47RAkLYh2Gn1zpFW9l4WFasPVT7C5W0dzOylHd6rZVzXj8QQphRSkaQpACHeTohAPkXpWPnDa849zq4SCtnuRAG1082DCPRVR0W1zKrVCmgYqiC/MasqqwySBOFKTDnslKkF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765485049; c=relaxed/simple;
	bh=juzCSdTwol/hdN8kZd87mypW6Rs0iJA7jx7Vd25JW0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uko+LOw9g3CQKz4pyGZ+ZJxcjfGgc6eH43z6EBeXj6vSWyBNhOGfp0mQ0l8h4nIUWzyDrf1lFlYXr7bslRCMaGRhNhYFMm2XP1m1f0fXp7plzNBBpI9/FNPXZIO/USvKGeGJhaMT1ODCdtBGnn+3jJE+4Sd/itD6eS4UoYGTqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dt2GFgQB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dt2GFgQB"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bda175a2013so57234a12.3
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 12:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765485047; x=1766089847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiQENslkJDv2E0emBctjUqqDQlAF9SnYJvx6Uv+5LGI=;
        b=dt2GFgQBKWn/o2sP3D9gU13G7jlAbOE6gljS3nOasn5/joQ/yNzn+c5rdzVWKk9aXL
         mytfGwcjnaRCJS+9i6BGA8nwXSZUdN/zoTYA67zknST/c2hLrz2Cfqpg1/F86yuUmEss
         Y5ZWudsBHe3ADP7I6XBePxsRtmLStZldzuZXOROAIvISVZKnRNz2RRqbIPjt+rz4fLvt
         CJc1W3iIjgZS6dPtB15/JOqsj3b/KmNPrlmoxOHDE/e79XX51awqFoL/031XdLZeZFSn
         /lSRTNQhpOSm1pDAwt1LWSgx6LdHZaQI2zWJoar6K9ql8i+JHxjYzN/WbpItB9qPgqPF
         Z3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765485047; x=1766089847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yiQENslkJDv2E0emBctjUqqDQlAF9SnYJvx6Uv+5LGI=;
        b=MILkdfOYEBrViuHMTkA4+il6ngRw/4rODsJe/DbG86YJLiGRGn7QRoEU9xBDoSEav1
         /Om29hQiG6pBJw4baeT8bL0UJeyzg3f9MsltLE6Go0e0RZhcb4FUr5FY57EUUcJZ8LqX
         Hl9L+jl6RMPx7WS1OrKy7/ZGXdveFSwG/C/gbhh+40aMltajoAoOpmP9W0dqM1J07bOZ
         gc54NFCgBV6sdusfvmXdjBKclnE+055hVqdbzd4S+v4sZ8fETfrCcdLE4bJRZICuNB8U
         yX64WPvXb6cZ25K+tKVtSuvjJ08RwrEKJpy6ZXA1TzjhHR7Z+fq0516V0pb04jCypIg1
         /hMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoWoBy0Xy3yT9vQF69N62OoAb0KRF9xDdzKnulKHSSoRR0AjEEM9902DKwlT4Dgxh3rMx9Ny74veGuYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwALaA8M95bPPIjDUwoeBE1Pxb+fJV4/sRK4fNk8/g30xawiLY/
	T1M4/XSoWm+itQ9YQs0CfCmcHrqml+SCbVfgRhtMnw4gqK7/ZdI1XOhPony+dfRneiNS9p8sEtQ
	3xw1jBoblBs2mYz7gIrcVk5OhPoD3y0y9+yR8+J4rRU1CBcG6H+tdd7M=
X-Gm-Gg: AY/fxX5Q/uyalqmsqjhgmzI4p2xHhi00k6Z9hQisCkZxz62ujAa8AnQRQ2lNUNdXgKC
	sUfpp6upIBHcOZhrCA09yDH0pvzZ39JRcpufIk7Oh6yoRHScQolZ5sw08e1WxaM9A8LLbDBHU77
	lptRRl853cbgUYDdaRXWzl7w1BKgM53waXGxR23zbnIC1fcPgj3ZihH4A7PpsorfVtoCzt2FJvV
	YAWlJjJ53PNS89UrcyHb6zqZfhjGhROeR/Rt1Kqz1OHkX6486X0knK7raoFMR1klAwr0WMP
X-Google-Smtp-Source: AGHT+IG4MOgZFrYyKwJ+FdGajeIPDea/yQ2WSBwv8Q8dOc1EvANBQTPGjrzdy5yEJck1QgABKVuZSuWTztTsxhiyX60=
X-Received: by 2002:a05:7022:3847:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-11f296c903fmr2886986c88.4.1765485046904; Thu, 11 Dec 2025
 12:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211083824.349210-1-ming.lei@redhat.com>
In-Reply-To: <20251211083824.349210-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Dec 2025 12:30:35 -0800
X-Gm-Features: AQt7F2pCz3LkLvUZ4-i6P7brxPUBj8dTetVC-tZ9yfzXMOwaRMHNEdo57s9lkN8
Message-ID: <CADUfDZrVk_juib6yw8vrrYP0rrhrt7BxQPn89GeDi5q-XHNHOw@mail.gmail.com>
Subject: Re: [PATCH] ublk: fix deadlock when reading partition table
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 12:38=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> When one process(such as udev) opens ublk block device (e.g., to read
> the partition table via bdev_open()), a deadlock[1] can occur:
>
> 1. bdev_open() grabs disk->open_mutex
> 2. The process issues read I/O to ublk backend to read partition table

I'm not sure I understand how a process could be issuing read I/O to
the block device before bdev_open() has returned? Or do you mean that
bdev_open() is issuing read I/O for the partition table via
blkdev_get_whole() -> bdev_disk_changed() -> blk_add_partitions() ->
check_partition()?

> 3. In __ublk_complete_rq(), blk_update_request() or blk_mq_end_request()
>    runs bio->bi_end_io() callbacks
> 4. If this triggers fput() on file descriptor of ublk block device, the
>    work may be deferred to current task's task work (see fput() implement=
ation)

What is the bi_end_io implementation that results in an fput() call?

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

The idea here seems reasonable, but I can't say I understand all the
pieces resulting in the deadlock.

Best,
Caleb

>
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver=
")
> Link: https://github.com/ublk-org/ublksrv/issues/170 [1]
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2c715df63f23..f69da449727f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1086,6 +1086,7 @@ static inline void __ublk_complete_rq(struct reques=
t *req, struct ublk_io *io,
>  {
>         unsigned int unmapped_bytes;
>         blk_status_t res =3D BLK_STS_OK;
> +       bool requeue;
>
>         /* failed read IO if nothing is read */
>         if (!io->res && req_op(req) =3D=3D REQ_OP_READ)
> @@ -1117,14 +1118,28 @@ static inline void __ublk_complete_rq(struct requ=
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
> +       local_bh_disable();
>         blk_mq_end_request(req, res);
> +       local_bh_enable();
>  }
>
>  static struct io_uring_cmd *__ublk_prep_compl_io_cmd(struct ublk_io *io,
> --
> 2.47.1
>
