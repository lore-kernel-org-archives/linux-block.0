Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E91C433FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C7161053
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 11:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhJMLKO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 07:10:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3976 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhJMLKN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 07:10:13 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HTqRn5DJVz67PrR;
        Wed, 13 Oct 2021 19:04:37 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 13:08:07 +0200
Received: from [10.47.95.55] (10.47.95.55) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 12:08:07 +0100
Subject: Re: [PATCH] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>
References: <1634114459-143003-1-git-send-email-john.garry@huawei.com>
 <YWalYoOZmpkmAZNK@T590> <79266509-f327-9de3-d22e-0e9fe00387ee@huawei.com>
 <YWay/n+BJTLm1Alb@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9f3c4d57-6b77-5345-0d4c-275962214b2a@huawei.com>
Date:   Wed, 13 Oct 2021 12:11:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YWay/n+BJTLm1Alb@T590>
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

>>> blk_mq_queue_tag_busy_iter() needn't such change? >> I didn't think so.>>>> blk_mq_queue_tag_busy_iter() will indeed 
re-iter the tags per hctx. However
>> in bt_iter(), we check rq->mq_hctx == hctx for calling the iter callback:
>>
>> static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>> {
>> 	...
>>
>> 	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
>> 		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
>>
>> And this would only pass for the correct hctx which we're iter'ing for.
> It is true for both shared and non-shared sbitmap since we don't share
> hctx, so what does matter?

It matters that we are doing the right thing for shared tags. My point 
is we iter but don't call the callback unless the correct hctx.

As I see, this has not changed in transitioning from shared sbitmap to 
shared tags.

> With single shared tags, you can iterate over
> all requests originated from all hw queues, right?
> 
Right, for the same request queue, we should do that.

>> Indeed, it would be nice not to iter excessive times, but I didn't see a
>> straightforward way to change that.


> In Kashyap's report, the lock contention is actually from
> blk_mq_queue_tag_busy_iter(), see:
> 
> https://lore.kernel.org/linux-block/8867352d-2107-1f8a-0f1c-ef73450bf256@huawei.com/
> 

As I understand, Kashyap mentioned no throughput regression with my 
series, but just higher cpu usage in blk_mq_find_and_get_req().

I'll see if I can see such a thing in my setup.

But could it be that since we only have a single sets of requests per 
tagset, and not a set of requests per HW queue, there is more contention 
on the common set of requests in the refcount_inc_not_zero() call ***, 
below:

static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
unsigned int bitnr)
{
	...

	rq = tags->rqs[bitnr];
	if (... || !refcount_inc_not_zero(&rq->ref)) ***
	...
}

But I wonder why this function is even called often...

>> There is also blk_mq_all_tag_iter():
>>
>> void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>> 		void *priv)
>> {
>> 	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
>> }
>>
>> But then the only user is blk_mq_hctx_has_requests():
>>
>> static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>> {
>> 	struct blk_mq_tags *tags = hctx->sched_tags ?
>> 			hctx->sched_tags : hctx->tags;
>> 	struct rq_iter_data data = {
>> 		.hctx	= hctx,
>> 	};
>>
>> 	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
>> 	return data.has_rq;
>> }
> This above one only iterates over the specified hctx/tags, it won't be
> affected.
> 
>> But, again like bt_iter(), blk_mq_has_request() will check the hctx matches:
> Not see what matters wrt. checking hctx.

I'm just saying that something like the following would be broken for 
shared tags:

static bool blk_mq_has_request(struct request *rq, void *data, bool 
reserved)
{
	struct rq_iter_data *iter_data = data;

	iter_data->has_rq = true;
	return true;
}

static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
{
	struct rq_iter_data data = {
	};

	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
	return data.has_rq;
}

As it ignores that we want to check for a specific hctx.

Thanks,
John
