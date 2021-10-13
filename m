Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC2DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 09:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ECC60F94
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 09:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbhJMKAO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 06:00:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3975 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhJMKAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 06:00:13 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HTntc1Hhrz67wWV;
        Wed, 13 Oct 2021 17:54:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 11:58:07 +0200
Received: from [10.47.95.55] (10.47.95.55) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 10:58:06 +0100
Subject: Re: [PATCH] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>
References: <1634114459-143003-1-git-send-email-john.garry@huawei.com>
 <YWalYoOZmpkmAZNK@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <79266509-f327-9de3-d22e-0e9fe00387ee@huawei.com>
Date:   Wed, 13 Oct 2021 11:01:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YWalYoOZmpkmAZNK@T590>
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

On 13/10/2021 10:22, Ming Lei wrote:
> On Wed, Oct 13, 2021 at 04:40:59PM +0800, John Garry wrote:
>> Since it is now possible for a tagset to share a single set of tags, the
>> iter function should not re-iter the tags for the count of #hw queues in
>> that case. Rather it should just iter once.
>>
>> Fixes: e0fdf846c7bb ("blk-mq: Use shared tags for shared sbitmap support")
>> Reported-by: Kashyap Desai<kashyap.desai@broadcom.com>
>> Signed-off-by: John Garry<john.garry@huawei.com>
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 72a2724a4eee..c943b6529619 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -378,9 +378,12 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>>   void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>>   		busy_tag_iter_fn *fn, void *priv)
>>   {
>> -	int i;
>> +	unsigned int flags = tagset->flags;
>> +	int i, nr_tags;
>> +
>> +	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
>>   
>> -	for (i = 0; i < tagset->nr_hw_queues; i++) {
>> +	for (i = 0; i < nr_tags; i++) {
>>   		if (tagset->tags && tagset->tags[i])
>>   			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>>   					      BT_TAG_ITER_STARTED);
> blk_mq_queue_tag_busy_iter() needn't such change?

I didn't think so.

blk_mq_queue_tag_busy_iter() will indeed re-iter the tags per hctx. 
However in bt_iter(), we check rq->mq_hctx == hctx for calling the iter 
callback:

static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
{
	...

	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);

And this would only pass for the correct hctx which we're iter'ing for. 
Indeed, it would be nice not to iter excessive times, but I didn't see a 
straightforward way to change that.

There is also blk_mq_all_tag_iter():

void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
		void *priv)
{
	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
}

But then the only user is blk_mq_hctx_has_requests():

static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
{
	struct blk_mq_tags *tags = hctx->sched_tags ?
			hctx->sched_tags : hctx->tags;
	struct rq_iter_data data = {
		.hctx	= hctx,
	};

	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
	return data.has_rq;
}

But, again like bt_iter(), blk_mq_has_request() will check the hctx matches:

static bool blk_mq_has_request(struct request *rq, void *data, bool 
reserved)
{
	struct rq_iter_data *iter_data = data;

	if (rq->mq_hctx != iter_data->hctx)
		return true;
	iter_data->has_rq = true;
	return false;
}

Thanks,
John
