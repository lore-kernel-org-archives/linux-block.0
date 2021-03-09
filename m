Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D6C433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 05:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EEA65248
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 05:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhCIFuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 00:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhCIFtu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 00:49:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91629C06174A
        for <linux-block@vger.kernel.org>; Mon,  8 Mar 2021 21:49:49 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id u187so815973wmg.4
        for <linux-block@vger.kernel.org>; Mon, 08 Mar 2021 21:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2FU/cnJRLBoD/j95yixkZH/U3z5x1E6sEqWxaPsyvE=;
        b=nohKN+llmrH/pi99v2jKfSWNjTnFr97PccFVAxI6QgQFK76fzTjkViWX3sqmGDjbHe
         usvBYI07tJ1NwvJhk9XNfKREdmwOOZz9LNfeDFoTqpwzi/IIuggKxMaLMKr+LSc3mgwY
         XI593n986IUlpedL1yC4KZR0fnvsdB26lAkvXwhiWjhEA6fL8IlXSLCD9ToHNOKdE+km
         9BYjsEZLiMA0wWUhbALrjaOza/IfrbHtT8Mbwvgoqang0IedBmp1qta0exxynnd29mb9
         OinYpBkNR0+O0Ed8ADdm7N3psga16gpBSDXhuR393ukUEykHBQu0L6B9p94OfVXxKa6G
         rDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2FU/cnJRLBoD/j95yixkZH/U3z5x1E6sEqWxaPsyvE=;
        b=LZsAKwYwevwo7YCpPUT4hznUjaPXTKHOnO6wEIjjQbaXSHLSd19OgPAqZYd0WMar21
         0ggds4nsBZbA3+3P3x+m8qW9UpAxPTAiwyNenJHw1QlmQhdJRU2KCovi2Ylk/41QCtSh
         H4LWMKIJr3LIpf3q5agr0M2Be6ysjerDAQH/AXDtseQUMe45L81hhAHxxuaVTLYem4zw
         v2Qms/QmDr3WifiBVfdpeScW1z9bsfUqX1X6VMTEhL2zWSLgtAGCM4gFKpbGU4s/YbiQ
         cDECHFRI+tS6jor+Yf1f29Tw+a82CATyvv1WJ8VEX6lRkuY4LtRFGoGfB+D8XLhuOuCU
         yVXQ==
X-Gm-Message-State: AOAM530cu6AsAPjAbOTJ1Z1n6TsQZPWigLSJQKadUT162oOcau2Au6FB
        hWHimnusOJaRk3Vc4hYiBZNqaDbgQc5abhGzFfg=
X-Google-Smtp-Source: ABdhPJyvO6EhUX1PdbiKq2GzORH84nQ2p6OreBhoF2QWu6j77xZ5flxMN94tb0g0O9NBhqCFyXh4ZAm99VdTu2MKPqQ=
X-Received: by 2002:a1c:a958:: with SMTP id s85mr2035742wme.138.1615268988046;
 Mon, 08 Mar 2021 21:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20210308033232.448200-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20210308033232.448200-1-shinichiro.kawasaki@wdc.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Tue, 9 Mar 2021 11:19:20 +0530
Message-ID: <CA+1E3rJjpeX6UVk5HZhGPzeaTo0-VNsmEaPAWkH4-EmSGD9BGg@mail.gmail.com>
Subject: Re: [PATCH] block: Discard page cache of zone reset target range
To:     "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 8, 2021 at 2:11 PM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> When zone reset ioctl and data read race for a same zone on zoned block
> devices, the data read leaves stale page cache even though the zone
> reset ioctl zero clears all the zone data on the device. To avoid
> non-zero data read from the stale page cache after zone reset, discard
> page cache of reset target zones. In same manner as fallocate, call the
> function truncate_bdev_range() in blkdev_zone_mgmt_ioctl() before and
> after zone reset to ensure the page cache discarded.
>
> This patch can be applied back to the stable kernel version v5.10.y.
> Rework is needed for older stable kernels.
>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")
> Cc: <stable@vger.kernel.org> # 5.10+
> ---
>  block/blk-zoned.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 833978c02e60..990a36be2927 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -329,6 +329,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>         struct request_queue *q;
>         struct blk_zone_range zrange;
>         enum req_opf op;
> +       sector_t capacity;
> +       loff_t start, end;
> +       int ret;
>
>         if (!argp)
>                 return -EINVAL;
> @@ -349,9 +352,22 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>         if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))
>                 return -EFAULT;
>
> +       capacity = get_capacity(bdev->bd_disk);
> +       if (zrange.sector + zrange.nr_sectors <= zrange.sector ||
> +           zrange.sector + zrange.nr_sectors > capacity)
> +               /* Out of range */
> +               return -EINVAL;
> +
> +       start = zrange.sector << SECTOR_SHIFT;
> +       end = ((zrange.sector + zrange.nr_sectors) << SECTOR_SHIFT) - 1;

How about doing all this calculation only when it is applicable i.e.
only for reset-zone case, and not for other cases (open/close/finish
zone).

Also apart from "out of range" (which is covered here), there are few
more cases when blkdev_zone_mgmt() may fail it (not covered here).
Perhaps the whole pre and post truncate part can fit better inside
blkdev_zone_mgmt itself.

-- 
Kanchan
