Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711DBC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4131520C01
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Chk+OxjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfB0RBc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:01:32 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46229 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0RBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 12:01:32 -0500
Received: by mail-ua1-f66.google.com with SMTP id j8so15970326uae.13
        for <linux-block@vger.kernel.org>; Wed, 27 Feb 2019 09:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTUlzMuBjBT8lRVwoivE4nWEcmiNkaSH47Eff9a6f6w=;
        b=Chk+OxjWamFTGPndvCCZdokchCJpYT9v2RMP0iimHDx5suqdxlA4gIikpXEHuFCwnA
         FYZ3HE1uv0g1vQYeHeJBX8iSxvLfRzcnVLyHDheZ01pSgCG/OnSOwm1RWkWzVtxrfHhA
         p6Nv7TG2Sb4dYH2YYuNnHnF8ZM9yM69lTml1OXzcTwuj5P1LPe8ufRvBmnw4NYyhwlOU
         YFAULQYQNtBe36KDCgc0wvE1d6bT5wwUKRODDpwo9xW+6rjPTTc+APe/88aix++GjxLn
         3d2nCROKFOy4fAiBbfgd/MEUToLFpviaCX/USvrhs/gC8eeadRMkP58BWc0yxholkOYY
         1h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTUlzMuBjBT8lRVwoivE4nWEcmiNkaSH47Eff9a6f6w=;
        b=oi7XHporsRHEVL+glvKmj+YIawTV5XlL1ZHhyBQOkTw1/4gsFsRoilb0xWzCF/K77B
         7E7EY/pWIw0u95EFsufeShkqMgWG3Gj0p+pSf+KD8jeFq74Z/1Y8inYeNpv9UB1hXGf6
         7ZH44C1aMXLzDU3MOUud5WUc6OCYykV8gwFbGRv6czoHncHGY5cXHRdChwVFj1ZIuglc
         BcNw4K4n8Awuu6JPzJ8dirMx7K+5I0UEW1IrH9CJFzc4RYfw5xgxBiZ/p0XqS6IVm/8r
         ajafyblmIgB+Ik1+Op7xiEgs19+xjDPMiEFBpe1OVIuZsoqRp23XrK8+Hs1IljK/m8Kg
         /a1g==
X-Gm-Message-State: AHQUAubYQMLA4duMVQFROL6wvvVdPaAhtHryHd4xL8WN+SwX0OYQW6DA
        ti/mfmh++LJ4E4T1hEG5AP2v3Wmhk8RrccFYmWSGMA==
X-Google-Smtp-Source: AHgI3IYYpygwi1Eli+vb2Ve2xUB/cPMJce6yDCzDCTn/Cp3MowtwOoKp0vM3tYW5I068cdEbKjrzcmNa4Dn6sG5XDCY=
X-Received: by 2002:a05:6102:157:: with SMTP id a23mr2367830vsr.34.1551286890874;
 Wed, 27 Feb 2019 09:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20190227160211.11967-1-ming.lei@redhat.com>
In-Reply-To: <20190227160211.11967-1-ming.lei@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Feb 2019 18:00:55 +0100
Message-ID: <CAPDyKFrQ8WMLbtSw7AmFHN4n07ZpBYOc1t5KOXYib1c8fSdzkw@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: align max segment size with logical block size
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 27 Feb 2019 at 17:02, Ming Lei <ming.lei@redhat.com> wrote:
>
> Logical block size is the lowest possible block size that the storage
> device can address. Max segment size is often related with controller's
> DMA capability. And it is reasonable to align max segment size with
> logical block size.
>
> SDHCI sets un-aligned max segment size, and causes ADMA error, so
> fix it by aligning max segment size with logical block size.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I have applied for fixes, to avoid any issues during the merge window, thanks!

Kind regards
Uffe

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
> index cc19e71c71d4..7c364a9c4eeb 100644
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
> +       blk_queue_max_segment_size(mq->queue,
> +                       round_down(host->max_seg_size, block_size));
>
>         INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
>         INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
> --
> 2.9.5
>
