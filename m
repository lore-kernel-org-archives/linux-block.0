Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC19C432C1
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 07:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3959217F4
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 07:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390567AbfIYHfd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:35:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390395AbfIYHfd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 03:35:33 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 61160FF13A4FB3B0D17E;
        Wed, 25 Sep 2019 15:35:31 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 15:35:26 +0800
Subject: Re: [PATCH v3] block: fix null pointer dereference in
 blk_mq_rq_timed_out()
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>,
        <hch@infradead.org>, <keith.busch@intel.com>
References: <20190920113404.48567-1-yuyufen@huawei.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <02e02607-7497-d6f8-38d8-fae0f5574958@huawei.com>
Date:   Wed, 25 Sep 2019 15:35:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190920113404.48567-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index aedd9320e605..f3ef6ce05c78 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -212,6 +212,14 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>   	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
>   	struct blk_mq_hw_ctx *hctx;
>   
> +	if (!refcount_dec_and_test(&flush_rq->ref)) {
> +		fq->rq_status = error;
> +		return;
> +	}
> +
> +	if (fq->rq_status != BLK_STS_OK)
> +		error = fq->rq_status;
> +
>   	/* release the tag's ownership to the req cloned from */
>   	spin_lock_irqsave(&fq->mq_flush_lock, flags);
>   	hctx = flush_rq->mq_hctx;

spin_lock_irqsave(&fq->mq_flush_lock, flags) may need to move up to
refcount_dec_and_test(). Otherwise,  the race between timeout handle
and completion can lead to getting wrong 'rq_status' value. I will resend a
fixed version.

Thanks,
Yufen


> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0835f4d8d42e..eec2ec4c79bd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -905,7 +905,10 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
>   	 */
>   	if (blk_mq_req_expired(rq, next))
>   		blk_mq_rq_timed_out(rq, reserved);
> -	if (refcount_dec_and_test(&rq->ref))
> +
> +	if (is_flush_rq(rq, hctx))
> +		rq->end_io(rq, 0);
> +	else if (refcount_dec_and_test(&rq->ref))
>   		__blk_mq_free_request(rq);
>   
>   	return true;
> diff --git a/block/blk.h b/block/blk.h
> index de6b2e146d6e..d3ed80f144c6 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -30,6 +30,7 @@ struct blk_flush_queue {
>   	 */
>   	struct request		*orig_rq;
>   	spinlock_t		mq_flush_lock;
> +	blk_status_t 		rq_status;
>   };
>   
>   extern struct kmem_cache *blk_requestq_cachep;
> @@ -47,6 +48,12 @@ static inline void __blk_get_queue(struct request_queue *q)
>   	kobject_get(&q->kobj);
>   }
>   
> +static inline bool
> +is_flush_rq(struct request *req, struct blk_mq_hw_ctx *hctx)
> +{
> +	return hctx->fq->flush_rq == req;
> +}
> +
>   struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
>   		int node, int cmd_size, gfp_t flags);
>   void blk_free_flush_queue(struct blk_flush_queue *q);


