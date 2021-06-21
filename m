Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE11DC49EA3
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 08:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0113611C1
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 08:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFUIjW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 04:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUIjW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 04:39:22 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC8DC061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 01:37:07 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id o7so1539431vss.5
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzTVwqyj6nr6/LZrUm/pAB2Cc31yG9N6wdia2r1bfvg=;
        b=cz4ywv1UMpD6shFY/vKpjD1Co8Lh1O4DYRNq/FNXBWDetUZqmJw3ZQEpiX3O8xYdCr
         LXTxFijFLnOLA5Lx7ZvvWKsQHULNMyG95VVX3EYvxk5pF3PAegD4CMaWE4/sB6e3NVDk
         SZuxJBGtj7scHbC9841FStBVVMXNgsowqYW1r77oNdg8EiD/MGW3+UEEoNtZhIXgTtmx
         5eOsdFxqBVQS2r9YY4DX2mTk99kvNsVSf/PztBQ/rnoUd1H10hkBw492oEGWmSgKSRRl
         8WXTs+mKHu1I2t30KUnIF4ptSrEgm1/6p8SLbTxiXtudY0kV1nIpqDXdL/uTheC49rUk
         jVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzTVwqyj6nr6/LZrUm/pAB2Cc31yG9N6wdia2r1bfvg=;
        b=ji1ke+6CbCd2tE1QylZfdmVJiJeyspNc025sgWX+MX3VFubkT5USXCDHVTPi0cVafI
         rNFkO2SLysfOZj0Vl5c38i1uLOtEUCG2ohPocP0ayjFshu8XDusOMWNsJvLwZOFztJwd
         6mwudBeDtwXQQQaKa9oBtQoV4ptHnFeStxe3lruwpiGkeaEUZ2yCHS3XNbanqQVIBl01
         6tDgbux9tQNy7fVS7dZvWCjlhda8079XL0K1DvMzeIh99BYl235Xe7Kdual+t+q4PV/6
         gGC+SBrtOMQ1lYsdU5jWnJDVKGjh+7j+XTZ0y+U4cuP8WEL37EKH3YltgdKwg/6qyq8T
         KZpw==
X-Gm-Message-State: AOAM533pNGWxco8jN4yQltKp0OZjYaM6Y5lvonkwBURVLPklRcvKGHef
        x1HZsrogFEdI1FVjwNWpFK3zoo+j3hgw1x/vrdqZBg==
X-Google-Smtp-Source: ABdhPJxCVASk9Qh94HPF5HKlvNiiIQ7X4GBG9yb3ZPJsXzlOHqQ5qE+ohFND9eQOQC1WGeNZvaWbLazxD/+TfaMk9JQ=
X-Received: by 2002:a67:1087:: with SMTP id 129mr15835523vsq.42.1624264626455;
 Mon, 21 Jun 2021 01:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210621080144.3655131-1-hch@lst.de>
In-Reply-To: <20210621080144.3655131-1-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Jun 2021 10:36:30 +0200
Message-ID: <CAPDyKFpsdejocAGbUNWtkWnpf08tR5srOu_014NOaT+v22GVSg@mail.gmail.com>
Subject: Re: [PATCH] mmc: initialized disk->minors
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 21 Jun 2021 at 10:02, Christoph Hellwig <hch@lst.de> wrote:
>
> Fix a let hunk from the blk_mq_alloc_disk conversion.
>
> Fixes: 281ea6a5bfdc ("mmc: switch to blk_mq_alloc_disk")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index e7f89cbf9232..9890a1532cb0 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2331,6 +2331,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         md->queue.blkdata = md;
>
>         md->disk->major = MMC_BLOCK_MAJOR;
> +       md->disk->minors = perdev_minors;
>         md->disk->first_minor = devidx * perdev_minors;
>         md->disk->fops = &mmc_bdops;
>         md->disk->private_data = md;
> --
> 2.30.2
>
