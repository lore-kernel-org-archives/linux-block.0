Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC17C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 17:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1476822419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 17:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtpKCoW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1476822419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbeKODgd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:36:33 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38442 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeKODgc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 22:36:32 -0500
Received: by mail-it1-f196.google.com with SMTP id k141-v6so25110018itk.3
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 09:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NeqpVvE0knC+rJH9DgkTL8EQ+LjLYNeBiIN4rmUBQI4=;
        b=OtpKCoW/lmS4/FYwfODZBuyCevSP2NQfJ9NjudA6PTLLuPrMbZnXo3mRNoGLK03CQx
         gMib6+gvi35Ssegc1cbrv+FTsh54P6OgUVa5Gcv/pQkqsLI0NJ8kD5ri4VjUKcUAr0Vb
         +QXx37GF+bHtM8mM/tp5Y2qX/NATD52pEuYvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NeqpVvE0knC+rJH9DgkTL8EQ+LjLYNeBiIN4rmUBQI4=;
        b=ikPFTjJd8nOAIGTmC8f7EXcfIWVLgVMhdPB8QAfD7can7fJpnLqT5T9lUHz6cepzfe
         i/62KgMK1Uxp54L6pTJiA4idgYDZmAjMOD9a27pqhNrjX3Eljbbgkd1brNi/61wvxOsf
         yXhB/Ty5/5ZGaSJgM9SYuSGXhIfL1A7/jDnuUmRHeo5xKhH1/TJw64aYLeZfjaeQL8Sw
         8GB8F531ADUElpeGfifq2n+TvHtD/AvEYcktm5Hi3IkoSOhzwPWbn40HYUiR/TXQL3yh
         WJ5mSQnBY7TPtZaQYJHj5nD6vSvYT0pFVyzu9OAaemginX3illqaTM6eFkL5hesD9bwA
         5xlw==
X-Gm-Message-State: AGRZ1gLUJ88B3Kwnc9QjvoLOq2PWBXNR64Yo/Kq8e3ZVsq9R/An3/0az
        TfX35ADdxs6lznM5ed4QScE341VV+/rkgQwOgKfxTA==
X-Google-Smtp-Source: AJdET5cn9gZW95z6QNQHdHYzncuQoQHPco4XKyQNj1u4fNRu+vpVC+kzG9tYPrzG7h7C7j5Zt4SozygE1QQ7P21fIKc=
X-Received: by 2002:a02:2b29:: with SMTP id h41-v6mr2390709jaa.12.1542216746002;
 Wed, 14 Nov 2018 09:32:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 09:31:45
 -0800 (PST)
In-Reply-To: <20181114160219.28328-14-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de> <20181114160219.28328-14-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Nov 2018 18:31:45 +0100
Message-ID: <CAPDyKFqq=MiiM7h_GGb3S=+TSD=LayLTefigovuPJAsqMJgOEg@mail.gmail.com>
Subject: Re: [PATCH 13/16] mmc: simplify queue initialization
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14 November 2018 at 17:02, Christoph Hellwig <hch@lst.de> wrote:
> Merge three functions initializing the queue into a single one, and drop
> an unused argument for it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mmc/core/block.c |  2 +-
>  drivers/mmc/core/queue.c | 86 ++++++++++++++--------------------------
>  drivers/mmc/core/queue.h |  3 +-
>  3 files changed, 32 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index c35b5b08bb33..27606e1382e5 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2334,7 +2334,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         INIT_LIST_HEAD(&md->rpmbs);
>         md->usage = 1;
>
> -       ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
> +       ret = mmc_init_queue(&md->queue, card, &md->lock);
>         if (ret)
>                 goto err_putdisk;
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 6edffeed9953..37617fb1f9de 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -378,14 +378,38 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>         init_waitqueue_head(&mq->wait);
>  }
>
> -static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
> -                            const struct blk_mq_ops *mq_ops, spinlock_t *lock)
> +/* Set queue depth to get a reasonable value for q->nr_requests */
> +#define MMC_QUEUE_DEPTH 64
> +
> +/**
> + * mmc_init_queue - initialise a queue structure.
> + * @mq: mmc queue
> + * @card: mmc card to attach this queue
> + * @lock: queue lock
> + * @subname: partition subname

Drop subname :-)

> + *
> + * Initialise a MMC card request queue.
> + */
> +int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
> +                  spinlock_t *lock)
>  {

[...]

A very nice cleanup, thanks!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
