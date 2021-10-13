Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72138C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2DC6112D
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhJMPMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:12:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3977 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJMPMM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:12:12 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HTwpZ6ydFz67ZCR;
        Wed, 13 Oct 2021 23:06:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:10:06 +0200
Received: from [10.47.95.55] (10.47.95.55) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 16:10:06 +0100
Subject: Re: [PATCH] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
To:     Ming Lei <ming.lei@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        "hare@suse.de" <hare@suse.de>
References: <1634114459-143003-1-git-send-email-john.garry@huawei.com>
 <YWalYoOZmpkmAZNK@T590> <79266509-f327-9de3-d22e-0e9fe00387ee@huawei.com>
 <YWay/n+BJTLm1Alb@T590> <9f3c4d57-6b77-5345-0d4c-275962214b2a@huawei.com>
 <YWbtRm22vohvY0Ca@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7e142559-1c96-8d84-081a-378c1f6d1306@huawei.com>
Date:   Wed, 13 Oct 2021 16:13:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YWbtRm22vohvY0Ca@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.55]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13/10/2021 15:29, Ming Lei wrote:
>> As I understand, Kashyap mentioned no throughput regression with my series,
>> but just higher cpu usage in blk_mq_find_and_get_req().
>>
>> I'll see if I can see such a thing in my setup.
>>
>> But could it be that since we only have a single sets of requests per
>> tagset, and not a set of requests per HW queue, there is more contention on
>> the common set of requests in the refcount_inc_not_zero() call ***, below:
>>
>> static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
>> unsigned int bitnr)
>> {
>> 	...
>>
>> 	rq = tags->rqs[bitnr];
>> 	if (... || !refcount_inc_not_zero(&rq->ref)) ***
>> 	...
>> }
> Kashyap's log shows that contention on tags->lock is increased, that
> should be caused by nr_hw_queues iterating.

If the lock contention increases on tags->lock then I am not totally 
surprised. For shared sbitmap, each HW queue had its own tags (and tags 
lock). Now with shared tags, we have a single lock over the tagset, and 
so we would have more contention. That's on the basis that we have many 
parallel callers to blk_mq_queue_tag_busy_iter().

> blk_mq_find_and_get_req()
> will be run nr_hw_queue times compared with pre-shared-sbitmap, since it
> is done before checking rq->mq_hctx.

Isn't shared sitmap older than blk_mq_find_and_get_req()?

Anyway, for 5.14 shared sbitmap support, we iter nr_hw_queue times. And 
now, for shared tags, we still do that. I don't see what's changed in 
that regard.

> 
>> But I wonder why this function is even called often...
>>
>>>> There is also blk_mq_all_tag_iter():
>>>>
>>>> void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>>>> 		void *priv)
>>>> {
>>>> 	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
>>>> }
>>>>
>>>> But then the only user is blk_mq_hctx_has_requests():
>>>>
>>>> static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>>>> {
>>>> 	struct blk_mq_tags *tags = hctx->sched_tags ?
>>>> 			hctx->sched_tags : hctx->tags;
>>>> 	struct rq_iter_data data = {
>>>> 		.hctx	= hctx,
>>>> 	};
>>>>
>>>> 	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
>>>> 	return data.has_rq;
>>>> }
>>> This above one only iterates over the specified hctx/tags, it won't be
>>> affected.
>>>
>>>> But, again like bt_iter(), blk_mq_has_request() will check the hctx matches:
>>> Not see what matters wrt. checking hctx.
>> I'm just saying that something like the following would be broken for shared
>> tags:
>>
>> static bool blk_mq_has_request(struct request *rq, void *data, bool
>> reserved)
>> {
>> 	struct rq_iter_data *iter_data = data;
>>
>> 	iter_data->has_rq = true;
>> 	return true;
>> }
>>
>> static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>> {
>> 	struct rq_iter_data data = {
>> 	};
>>
>> 	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
>> 	return data.has_rq;
>> }
>>
>> As it ignores that we want to check for a specific hctx.
> No, that isn't what I meant, follows the change I suggested:

I didn't mean that this was your suggestion. I am just saying that we 
need to be careful iter'ing tags for shared tags now, as in that example.

> 
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 72a2724a4eee..2a2ad6dfcc33 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -232,8 +232,9 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	if (!rq)
>   		return true;
>   
> -	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
> -		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
> +	if (rq->q == hctx->queue && (rq->mq_hctx == hctx ||
> +				blk_mq_is_shared_tags(hctx->flags)))
> +		ret = iter_data->fn(rq->mq_hctx, rq, iter_data->data, reserved);
>   	blk_mq_put_rq_ref(rq);
>   	return ret;
>   }
> @@ -460,6 +461,9 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>   		if (tags->nr_reserved_tags)
>   			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
>   		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
> +
> +		if (blk_mq_is_shared_tags(hctx->flags))
> +			break;
>   	}
>   	blk_queue_exit(q);
>   }
> 

I suppose that is ok, and means that we iter once.

However, I have to ask, where is the big user of 
blk_mq_queue_tag_busy_iter() coming from? I saw this from Kashyap's mail:

 > 1.31%     1.31%  kworker/57:1H-k  [kernel.vmlinux]
 >       native_queued_spin_lock_slowpath
 >       ret_from_fork
 >       kthread
 >       worker_thread
 >       process_one_work
 >       blk_mq_timeout_work
 >       blk_mq_queue_tag_busy_iter
 >       bt_iter
 >       blk_mq_find_and_get_req
 >       _raw_spin_lock_irqsave
 >       native_queued_spin_lock_slowpath

How or why blk_mq_timeout_work()?

Thanks,
john
