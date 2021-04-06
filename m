Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B871C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 01:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF62613A0
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 01:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbhDFBqx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 21:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbhDFBqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 21:46:52 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05964C06174A
        for <linux-block@vger.kernel.org>; Mon,  5 Apr 2021 18:46:44 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i144so14457670ybg.1
        for <linux-block@vger.kernel.org>; Mon, 05 Apr 2021 18:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+T4nAgXw5wgtyHVPgaHBJz0vypq2X3oHo0o8UKghn/0=;
        b=SjfWmuopzYdjypnVduSN5edD6XDlvtowQrrBxBcSKqU1CfVoCIGwH4vJJ7XWVT31ay
         V+wp1WiuTaRmHTQTjuGf3cEUAocSkvNxg/LhePldo6GDqQWY14mx2K5MMVtwohmVYplp
         3KXHPxOOJWP4y+dLk/F33Rx03PREhae5ZL4qZ9YGfNkqcQSY71evTTJNHXNMXtEPmkMt
         2PzdfGJ+ZTbF9c1D+ol0a35rIxpSu3nHZ/3Ir3/822cfUFuGo/LB44mK5pjRH33saSZ2
         pee9FaUwkTkMwYavwcFomxo++UBxA1HSZ7Mba6kbxdc9dM53pGj2Ggpe7B5dDgubYal8
         q3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+T4nAgXw5wgtyHVPgaHBJz0vypq2X3oHo0o8UKghn/0=;
        b=Nk0TEYduSMOaY23OaRsnQG8NAh0xTX7rGfXg0MtZpOLlqn/YzaP2LXceMbW+frrzHC
         27jQjGdSZGvs0ykqQjL/PyeHmFDZ+ZPMFxh2ZmFYpjPgmQ4WnSDobq+Ot/lTLHm40r8l
         Wvwe85GoZZeKNbyfXqbLd884NiKpcqDSu4T3TmLcCKPE4SRLrbXSWRusulA0gPzsc0DT
         /qpskwGc+laxERfKPz/Y7fw1H7N3Go6RmcgNVVGHWmtt/S4mJWO0zWurJqD5/Y46Comm
         kRfbshIqwMZjYyk50a1o0XfhfdarpSqBgekY3GfeHdwxkXisZu7flAD1FQp+HeChBkBp
         l4Dw==
X-Gm-Message-State: AOAM530TkHQB68qwLbw1WcKMbS1oNCOm4Ym3bZ654rMubXSiKcgf57nX
        kUlb25YVriP9AJ1E0tViupIiW1F9pvJT+C6vVBk=
X-Google-Smtp-Source: ABdhPJwddIzgcXS6VYHbpidFvaQclv5/BLqG+umcdnX03BuIRTeJR3ZVhAaOw4iLwSx2cxcrdvDCvBpdJr7qsvckQIo=
X-Received: by 2002:a25:2393:: with SMTP id j141mr14545102ybj.337.1617673603422;
 Mon, 05 Apr 2021 18:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210405132012.12504-1-mgurtovoy@nvidia.com>
In-Reply-To: <20210405132012.12504-1-mgurtovoy@nvidia.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 6 Apr 2021 09:46:32 +0800
Message-ID: <CACVXFVOdJ2+iSP3=BhxLkDjURhUCyVyENfZWd9PsKiV+SwVmFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: add sysfs entry for virt boundary mask
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 6, 2021 at 4:43 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
> This entry will expose the bio vector alignment mask for a specific
> block device.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  block/blk-sysfs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 0f4f0c8a7825..86a545e6d82d 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -264,6 +264,11 @@ static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
>         return queue_var_show(max_hw_sectors_kb, (page));
>  }
>
> +static ssize_t queue_virt_boundary_mask_show(struct request_queue *q, char *page)
> +{
> +       return queue_var_show(q->limits.virt_boundary_mask, (page));
> +}
> +
>  #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)                           \
>  static ssize_t                                                         \
>  queue_##name##_show(struct request_queue *q, char *page)               \
> @@ -610,6 +615,7 @@ QUEUE_RO_ENTRY(queue_fua, "fua");
>  QUEUE_RO_ENTRY(queue_dax, "dax");
>  QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
>  QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
> +QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
>
>  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>  QUEUE_RW_ENTRY(blk_throtl_sample_time, "throttle_sample_time");
> @@ -670,6 +676,7 @@ static struct attribute *queue_attrs[] = {
>  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>         &blk_throtl_sample_time_entry.attr,
>  #endif
> +       &queue_virt_boundary_mask_entry.attr,
>         NULL,
>  };

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming Lei
