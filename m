Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD6C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DFA20661
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 13:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9zFyTDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfB0N5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:57:43 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46507 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbfB0N5m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 08:57:42 -0500
Received: by mail-ua1-f67.google.com with SMTP id j8so15335096uae.13
        for <linux-block@vger.kernel.org>; Wed, 27 Feb 2019 05:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmnm2sTMMV4d6GqQo5/URt4/36qDlB5XGizo0sKThng=;
        b=g9zFyTDbtK2hfdroDsh88PCfE46Qdp5FAA4gAjxLeYsl6s3WqTUdk0rO8ukcdkJvXw
         rsJKMsQgm5gXc8gCzs4hj8CUpB+2wxcDxFcsPTfRyLpT9U/U71Ol1DTMDEYGRib+A0GE
         y9c5f6i/fJK/XTJGAiQs93NxjzXaEFc8pj5yErs1FFYls6qUy6R32vZgJxSmwZCrhX96
         aSCBvkYHiiiAXWWUofB8U95PcKfYLHnDt+BgB7DksGCKwwA+zdrUPHXyRv1oMaHWImnw
         ACZ9jWAHhYiAYqOsFcTRRJFUAC86ZZmdapq5WClc9FOLFXHXFHa8ILhZ9K7SZVRq6jO7
         ftig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmnm2sTMMV4d6GqQo5/URt4/36qDlB5XGizo0sKThng=;
        b=S+8N5sYQGExfw03wYSIbXLRQGTzxO5rt8P0ue2maV8BDvFBil4MEt7lqa1+iq1z3yZ
         wtsKIZA2lUvFXtWGMvDDNym5K8ySrIQo6dY+rPl7TvY8UPmsd+aHiTmOywrN7eux8c6V
         C1ProAPUhDDJDyYUGGHSxe1mx8xZVnpXn4HaYveUaPqzOUuL679COhtQwsyWSlzfewKZ
         tyVNbh57PG12g0se2a9xFy7mi+DMB3/7XgpfcAHBCyZRMQxqqwfSyEEyD7LnZt0Z48bY
         9CObtWh1WOmOJfG1Dk1VzHSDG1/gKd2X57ZjzcQYrhh4SCGvzIrem4IulEQt3mmPn8Sb
         CEvA==
X-Gm-Message-State: AHQUAuZm3Z2PDFtq1WO66eRkQO/SMh1mhsrMUy5U9Uq6l16wuisVPU2S
        uYs674xKdf96hNcgI7RXjxapj6kzNYb5rpG2TY3iDw==
X-Google-Smtp-Source: AHgI3IbToXLgiB4Du8EzWH6qE0/aUN5TcAOqNZ6PkSxOw5NPNgkFgGhNbc8VG078+q51X8q51737uX+KZPq1nuikpAU=
X-Received: by 2002:a67:c902:: with SMTP id w2mr1781901vsk.191.1551275861028;
 Wed, 27 Feb 2019 05:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20190227130237.7725-1-ming.lei@redhat.com>
In-Reply-To: <20190227130237.7725-1-ming.lei@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Feb 2019 14:57:04 +0100
Message-ID: <CAPDyKFqMz3M8SzupEHP_k=r=r8wJ_dKYQRP=LMoRFUbq60E3Sg@mail.gmail.com>
Subject: Re: [PATCH] mmc: align max segment size with logical block size
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+ Christoph

On Wed, 27 Feb 2019 at 14:02, Ming Lei <ming.lei@redhat.com> wrote:
>
> Logical block size is the lowest possible block size that the storage
> device can address. Max segment size is often related with controller's
> DMA capability. And it is reasonable to align max segment size with
> logical block size.
>
> SDHCI sets un-aligned max segment size, and causes ADMA error, so
> fix it by aligning max segment size with logical block size.

Seems reasonable. However, is this specific to MMC or should it be
managed in block layer?

>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/mmc/core/block.c | 6 ------
>  drivers/mmc/core/queue.c | 9 ++++++++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 14f3fdb8c6bb..9ce8eb51a60f 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2380,12 +2380,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
>                  "mmcblk%u%s", card->host->index, subname ? subname : "");
>
> -       if (mmc_card_mmc(card))
> -               blk_queue_logical_block_size(md->queue.queue,
> -                                            card->ext_csd.data_sector_size);
> -       else
> -               blk_queue_logical_block_size(md->queue.queue, 512);
> -
>         set_capacity(md->disk, size);
>
>         if (mmc_host_cmd23(card->host)) {
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index cc19e71c71d4..891bdbe14192 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -355,6 +355,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
>         u64 limit = BLK_BOUNCE_HIGH;
> +       unsigned block_size = 512;
>
>         if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
>                 limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
> @@ -368,7 +369,13 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
>         blk_queue_max_segments(mq->queue, host->max_segs);
> -       blk_queue_max_segment_size(mq->queue, host->max_seg_size);
> +
> +       if (mmc_card_mmc(card))
> +               block_size = card->ext_csd.data_sector_size;
> +
> +       blk_queue_logical_block_size(mq->queue, block_size);
> +       blk_queue_max_segment_size(mq->queue, host->max_seg_size &
> +                       ~(block_size - 1));

Can't we use round_down() instead? No?

>
>         INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
>         INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
> --
> 2.9.5
>

Kind regards
Uffe
