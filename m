Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9901C61CE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 11:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A66C2086A
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw1IJxGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfASLNT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 06:13:19 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36702 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfASLNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 06:13:19 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so9252499itj.1
        for <linux-block@vger.kernel.org>; Sat, 19 Jan 2019 03:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jglviIrhfmmHqizswGTrUNWSvm1G/5c9as2xsqFLmv0=;
        b=Mw1IJxGQvY6ihhJXxpW94IVA2IghqQTkdKkr4Fna4WUOMSgy9gDhmyYoXT11JNJ7VC
         n0rHLOYClpVszu0UXq6QcLVEkviGt4L85T/T8kRciyecZ1Fr2qfj6ERyEpHbfyzr/Pn0
         qGfy+BdycU/DvbWIo1UjDbVSsM96Sy3doHDzzTQJJlzjQ/Nt7q60xTNgYIvEIV5/BSiJ
         sSJS4KE+3Szcz1hq1Ws8xLPFeBdm0N8zfNz6yWtoWpGt1NmDdOGO3rK+MEgxCltBXyHy
         YbvOIPYJJOet+6HVGyOVOuV1681WesOTGGidgw8qC9/r11oTepnJz6sRmn+5u5nwePWz
         MXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jglviIrhfmmHqizswGTrUNWSvm1G/5c9as2xsqFLmv0=;
        b=bLhUDJED3dNl05zLUV0vfzCsTY/umnZAwGqfBAwV3X4i3LQLoQ9Ufpk6WX0X6+Wxn7
         O6OvGyX7lotBmEPtUeniappmj69KmIlFbXhCe3bcgI3P6AcIpU6S0iFl36duOqZG3SLV
         t+KB2VTHG04ycb3kriKbYiPNz2wS2kDcq6n+7K6kf63IC4d9aqZsYTDNUeoexaD8rwkM
         6f4eLYKXbZLQSbqZdlk7QTaMEvt03+7C1s7Q2N+1S6e9rxmO86crke+LaJxLgZ/8oeMu
         eM9Qp3iCo/1u7RBlUOYauGz8tY182eChJzKOFS32fCgWRnAjrUraI5TJoUAS1P5/SQ7b
         dJNA==
X-Gm-Message-State: AJcUukfXsPXPULULdLUSOk4RLtU988X20UEQI3Z5Nxi3DYjFzxGpWWQI
        c53WhvhGcoV64CCu23BEJmSTtXeaUW1DUoGP468=
X-Google-Smtp-Source: ALg8bN5thX35mu8dVcVYJ4LIY9aFp1ZQUHmfOqVfxekssff8zyvZF+6xjRNHUIOldUyjagd8JZ2gE8sgpR1MOjUtehY=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr4084231itk.114.1547896398210;
 Sat, 19 Jan 2019 03:13:18 -0800 (PST)
MIME-Version: 1.0
References: <013ca038-559d-0a56-4d49-366c7ec79ac3@kernel.dk>
In-Reply-To: <013ca038-559d-0a56-4d49-366c7ec79ac3@kernel.dk>
From:   Kai Krakow <hurikhan77@gmail.com>
Date:   Sat, 19 Jan 2019 12:13:07 +0100
Message-ID: <CAMthOuPohGUM8gqxE8xoLdSnVaU2iEgOT60fqddWbsoDZSy0CA@mail.gmail.com>
Subject: Re: bfq: update internal depth state when queue depth changes
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        hurikhan77+bko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Resent due to Gmail tricking me into using HTML format. :-(

Am Fr., 18. Jan. 2019 um 18:34 Uhr schrieb Jens Axboe <axboe@kernel.dk>:
>
> A previous commit moved the shallow depth and BFQ depth map calculations
> to be done at init time, moving it outside of the hotter IO path. This
> potentially causes hangs if the users changes the depth of the scheduler
> map, by writing to the 'nr_requests' sysfs file for that device.
>
> Add a blk-mq-sched hook that allows blk-mq to inform the scheduler if
> the depth changes, so that the scheduler can update its internal state.
>
> Reported-by: Paolo Valente <paolo.valente@linaro.org>
> Fixes: f0635b8a416e ("bfq: calculate shallow depths at init time")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Works fine here in 4.18 as far as I could test (running a full backup,
some compilations and Gentoo package upgrades, filling memory with web
browsers to force swapping).

$ grep ^ /sys/block/*/queue/nr_requests
/sys/block/bcache0/queue/nr_requests:128
/sys/block/bcache1/queue/nr_requests:128
/sys/block/bcache2/queue/nr_requests:128
/sys/block/bcache3/queue/nr_requests:128
/sys/block/bcache4/queue/nr_requests:128
/sys/block/sda/queue/nr_requests:256
/sys/block/sdb/queue/nr_requests:256
/sys/block/sdc/queue/nr_requests:256
/sys/block/sdd/queue/nr_requests:256
/sys/block/sde/queue/nr_requests:256
/sys/block/sdf/queue/nr_requests:256

Tested-by: Kai Krakow <kai@kaishome.de>

> ---
>
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index cd307767a134..b09589915667 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5342,7 +5342,7 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
>         return min_shallow;
>  }
>
> -static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
> +static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
>  {
>         struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
>         struct blk_mq_tags *tags = hctx->sched_tags;
> @@ -5350,6 +5350,11 @@ static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
>
>         min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
>         sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, min_shallow);
> +}
> +
> +static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
> +{
> +       bfq_depth_updated(hctx);
>         return 0;
>  }
>
> @@ -5772,6 +5777,7 @@ static struct elevator_type iosched_bfq_mq = {
>                 .requests_merged        = bfq_requests_merged,
>                 .request_merged         = bfq_request_merged,
>                 .has_work               = bfq_has_work,
> +               .depth_updated          = bfq_depth_updated,
>                 .init_hctx              = bfq_init_hctx,
>                 .init_sched             = bfq_init_queue,
>                 .exit_sched             = bfq_exit_queue,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ba37b9e15e9..a047b297ade5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3101,6 +3101,8 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>                 }
>                 if (ret)
>                         break;
> +               if (q->elevator && q->elevator->type->ops.depth_updated)
> +                       q->elevator->type->ops.depth_updated(hctx);
>         }
>
>         if (!ret)
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index 2e9e2763bf47..6e8bc53740f0 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -31,6 +31,7 @@ struct elevator_mq_ops {
>         void (*exit_sched)(struct elevator_queue *);
>         int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
>         void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
> +       void (*depth_updated)(struct blk_mq_hw_ctx *);
>
>         bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
>         bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *);
>
> --
> Jens Axboe
>
