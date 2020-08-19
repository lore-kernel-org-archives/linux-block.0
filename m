Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBAAC433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 10:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2ADA206FA
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 10:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgHSKQ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:16:59 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbgHSKQ7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 06:16:59 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 88208E92690120026BBC;
        Wed, 19 Aug 2020 11:16:55 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.203) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 19 Aug
 2020 11:16:55 +0100
Subject: Re: [REPORT] BUG: KASAN: use-after-free in bt_iter+0x80/0xf8
To:     Ming Lei <ming.lei@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com>
 <a68379af-48e7-da2b-812c-ff0fa24a41bb@huawei.com>
 <20200819000009.GB2712797@T590>
 <585bb054-2009-4abc-f1e8-802e494ba49b@huawei.com>
 <20200819085843.GA2730150@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <83de2368-a122-3b9c-db15-63ea442eecd9@huawei.com>
Date:   Wed, 19 Aug 2020 11:14:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200819085843.GA2730150@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.203]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/08/2020 09:58, Ming Lei wrote:
>> ah, right. I vaguely remember this. Well, if we didn't have a reliable
>> reproducer before, we do now.
> OK, that is great, please try the following patch:
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 32d82e23b095..f18632c524e9 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -185,19 +185,19 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   {
>   	struct bt_iter_data *iter_data = data;
>   	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
> -	struct blk_mq_tags *tags = hctx->tags;
> +	struct blk_mq_tags *tags = hctx->sched_tags ?: hctx->tags;
>   	bool reserved = iter_data->reserved;
>   	struct request *rq;
>   
>   	if (!reserved)
>   		bitnr += tags->nr_reserved_tags;
> -	rq = tags->rqs[bitnr];
> +	rq = tags->static_rqs[bitnr];
>   
>   	/*
>   	 * We can hit rq == NULL here, because the tagging functions
>   	 * test and set the bit before assigning ->rqs[].
>   	 */
> -	if (rq && rq->q == hctx->queue)
> +	if (rq && rq->tag >= 0 && rq->q == hctx->queue)
>   		return iter_data->fn(hctx, rq, iter_data->data, reserved);
>   	return true;
>   }
> @@ -406,7 +406,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>   		return;
>   
>   	queue_for_each_hw_ctx(q, hctx, i) {
> -		struct blk_mq_tags *tags = hctx->tags;
> +		struct blk_mq_tags *tags = hctx->sched_tags ?: hctx->tags;
>   
>   		/*
>   		 * If no software queues are currently mapped to this

I gave it a quick try and it looks to silence KASAN. I'll try to test 
more over the next day or so.

BTW, I doubt KASAN is even right to complain about this. I'll check that 
thread you pointed me at to learn more about what was discussed on that.

Thanks,
John
