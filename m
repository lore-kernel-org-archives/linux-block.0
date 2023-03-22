Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54228C6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 07:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCVHpA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVHo7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 03:44:59 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF13C79B
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 00:44:57 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id m35so10897471wms.4
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 00:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679471096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UXyATeKHlv1Op6ZKzcQ0JQ9/Q6dOVj9ORhczgbtwQc=;
        b=rcZDdddwFPMj7HRiWNQcD0kLI5qUA1M9M+n/D4edDXc/wO/5zH9/UTJmMLvcliacmG
         BUo5I7tkn+Mm3Zs3GbB8M5ZCuzf66nKJhHi99JwFmBLMC2gQ9Lj3NIfiY6OdnwhYiUb4
         WFF+ZSlRxUXuJfbUv4dzHZDqCmZKxgK6WL4y68adIurNpe+Gs9+ZwawA1KSywbktvUuP
         pj6B6jYiiIGwj4aUTSNrdzCkNwEG2kM5yLZsld0JV1BvHRQ+TvZwz65fC+kezUs4L7Bz
         /NTSSVvnu3+viTvn4MAZ3T3f5UKIXl+7tOprs9lsIhExZxBHKHwDNcSwku/iXHzmdVG5
         A43Q==
X-Gm-Message-State: AO0yUKWJ07jYRVV65RQYFh3a+CvNGDRqxxIyyVGLN35x/dGZdDbHR3w0
        yuiglZgXZzBxaBi+o7SFEFo=
X-Google-Smtp-Source: AK7set+NaVAzrB6RElN6Q2zygls9pNPDiQGzAKQLmX0v+8Xvml2M3E+0eisgfBmflQXHoVFvCtJ62g==
X-Received: by 2002:a05:600c:3110:b0:3ed:2702:fed8 with SMTP id g16-20020a05600c311000b003ed2702fed8mr4983293wmo.4.1679471096027;
        Wed, 22 Mar 2023 00:44:56 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c1c1600b003e9ded91c27sm22484092wms.4.2023.03.22.00.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:44:55 -0700 (PDT)
Message-ID: <6c5bddde-7a9e-c7be-4302-ce0334708914@grimberg.me>
Date:   Wed, 22 Mar 2023 09:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, hch@lst.de
Cc:     Keith Busch <kbusch@kernel.org>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-3-kbusch@meta.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322002350.4038048-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/22/23 02:23, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This is for mostly for testing purposes.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/loop.c | 63 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 58 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index f2d24b2d992f8..0587ead60b09e 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -22,6 +22,7 @@ struct nvme_loop_iod {
>   	struct nvmet_req	req;
>   	struct nvme_loop_queue	*queue;
>   	struct work_struct	work;
> +	struct work_struct	poll;
>   	struct sg_table		sg_table;
>   	struct scatterlist	first_sgl[];
>   };
> @@ -37,6 +38,7 @@ struct nvme_loop_ctrl {
>   	struct nvme_ctrl	ctrl;
>   
>   	struct nvmet_port	*port;
> +	u32			io_queues[HCTX_MAX_TYPES];
>   };
>   
>   static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl)
> @@ -76,7 +78,11 @@ static void nvme_loop_complete_rq(struct request *req)
>   	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
>   
>   	sg_free_table_chained(&iod->sg_table, NVME_INLINE_SG_CNT);
> -	nvme_complete_rq(req);
> +
> +	if (req->mq_hctx->type != HCTX_TYPE_POLL || !in_interrupt())
> +		nvme_complete_rq(req);
> +	else
> +		queue_work(nvmet_wq, &iod->poll);
>   }
>   
>   static struct blk_mq_tags *nvme_loop_tagset(struct nvme_loop_queue *queue)
> @@ -120,6 +126,15 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
>   	}
>   }
>   
> +static void nvme_loop_poll_work(struct work_struct *work)
> +{
> +	struct nvme_loop_iod *iod =
> +		container_of(work, struct nvme_loop_iod, poll);
> +	struct request *req = blk_mq_rq_from_pdu(iod);
> +
> +	nvme_complete_rq(req);
> +}
> +
>   static void nvme_loop_execute_work(struct work_struct *work)
>   {
>   	struct nvme_loop_iod *iod =
> @@ -170,6 +185,30 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	return BLK_STS_OK;
>   }
>   
> +static bool nvme_loop_poll_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> +{
> +	struct blk_mq_hw_ctx *hctx = data;
> +	struct nvme_loop_iod *iod;
> +	struct request *rq;
> +
> +	rq = blk_mq_tag_to_rq(hctx->tags, bitnr);
> +	if (!rq)
> +		return true;
> +
> +	iod = blk_mq_rq_to_pdu(rq);
> +	flush_work(&iod->poll);

If we want to go down this route, I would think that maybe
it'd be better to add .poll to nvmet_req like .execute, that can
actually be wired to bio_poll ? for file it can be wired to fop.iopoll
