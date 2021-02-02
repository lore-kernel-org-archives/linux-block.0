Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA0DC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 12:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D650264E58
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 12:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhBBM0K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 07:26:10 -0500
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:42352 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBBM0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 07:26:09 -0500
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 07:26:08 EST
Received: from [127.0.0.1] (unknown [157.0.31.124])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 39B14AC027A;
        Tue,  2 Feb 2021 20:18:38 +0800 (CST)
Subject: Re: [PATCH] kyber: introduce kyber_depth_updated()
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     onlyfever@icloud.com
References: <20210122090636.55428-1-yang.yang@vivo.com>
From:   Yang Yang <yang.yang@vivo.com>
Message-ID: <e209404b-9c7f-3dfa-3e80-1c1f8123ee4d@vivo.com>
Date:   Tue, 2 Feb 2021 20:18:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210122090636.55428-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk1JTUtJHRpITU9KVkpNSklJTUNISkNISk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6LBw5AT8IDzYxFDhNKkIz
        TQIwCjNVSlVKTUpJSU1DSEpDTUhKVTMWGhIXVQIaFRxVAhoVHDsNEg0UVRgUFkVZV1kSC1lBWUpO
        TFVLVUhKVUpJT1lXWQgBWUFPS01CNwY+
X-HM-Tid: 0a7762ae2e4fb039kuuu39b14ac027a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/1/22 17:06, Yang Yang wrote:
> Hang occurs when user changes the scheduler queue depth, by writing to
> the 'nr_requests' sysfs file of that device.
> This patch introduces kyber_depth_updated(), so that kyber can update its
> internal state when queue depth changes.
> 
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>   block/kyber-iosched.c | 28 ++++++++++++----------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index dc89199bc8c6..b64f80d3eaf3 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -353,19 +353,9 @@ static void kyber_timer_fn(struct timer_list *t)
>   	}
>   }
>   
> -static unsigned int kyber_sched_tags_shift(struct request_queue *q)
> -{
> -	/*
> -	 * All of the hardware queues have the same depth, so we can just grab
> -	 * the shift of the first one.
> -	 */
> -	return q->queue_hw_ctx[0]->sched_tags->bitmap_tags->sb.shift;
> -}
> -
>   static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>   {
>   	struct kyber_queue_data *kqd;
> -	unsigned int shift;
>   	int ret = -ENOMEM;
>   	int i;
>   
> @@ -400,9 +390,6 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>   		kqd->latency_targets[i] = kyber_latency_targets[i];
>   	}
>   
> -	shift = kyber_sched_tags_shift(q);
> -	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
> -
>   	return kqd;
>   
>   err_buckets:
> @@ -458,9 +445,18 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
>   		INIT_LIST_HEAD(&kcq->rq_list[i]);
>   }
>   
> -static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> +static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
>   {
>   	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
> +	struct blk_mq_tags *tags = hctx->sched_tags;
> +
> +	kqd->async_depth = tags->bitmap_tags->sb.depth * KYBER_ASYNC_PERCENT / 100U;
> +
> +	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, kqd->async_depth);
> +}
> +
> +static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> +{
>   	struct kyber_hctx_data *khd;
>   	int i;
>   
> @@ -502,8 +498,7 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>   	khd->batching = 0;
>   
>   	hctx->sched_data = khd;
> -	sbitmap_queue_min_shallow_depth(hctx->sched_tags->bitmap_tags,
> -					kqd->async_depth);
> +	kyber_depth_updated(hctx);
>   
>   	return 0;
>   
> @@ -1022,6 +1017,7 @@ static struct elevator_type kyber_sched = {
>   		.completed_request = kyber_completed_request,
>   		.dispatch_request = kyber_dispatch_request,
>   		.has_work = kyber_has_work,
> +		.depth_updated = kyber_depth_updated,
>   	},
>   #ifdef CONFIG_BLK_DEBUG_FS
>   	.queue_debugfs_attrs = kyber_queue_debugfs_attrs,
> 

Hello,

Ping...

Thanks!
