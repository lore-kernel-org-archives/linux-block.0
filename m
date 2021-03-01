Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294CFC433E6
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC99564E38
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 07:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhCAHya (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Mar 2021 02:54:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13030 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhCAHy2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Mar 2021 02:54:28 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DpsQg5fKyzMgP8;
        Mon,  1 Mar 2021 15:31:55 +0800 (CST)
Received: from [10.174.179.174] (10.174.179.174) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 15:33:59 +0800
Subject: Re: [RFC PATCH 2/2] blk-mq: blk_mq_tag_to_rq() always return null for
 sched_tags
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <josef@toxicpanda.com>, <hch@lst.de>, <bvanassche@acm.org>
References: <20210301021444.4134047-1-yuyufen@huawei.com>
 <20210301021444.4134047-3-yuyufen@huawei.com> <YDyOq0eVr35h0GNK@T590>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <6e76e2b0-961e-a936-5009-73141ef8e08e@huawei.com>
Date:   Mon, 1 Mar 2021 15:33:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <YDyOq0eVr35h0GNK@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/3/1 14:50, Ming Lei wrote:
> On Sun, Feb 28, 2021 at 09:14:44PM -0500, Yufen Yu wrote:
>> We just set hctx->tags->rqs[tag] when get driver tag, but will
>> not set hctx->sched_tags->rqs[tag] when get sched tag.
>> So, blk_mq_tag_to_rq() always return NULL for sched_tags.
> 
> True, also blk_mq_tag_to_rq() seems an awkward API, and it needs
> 'struct blk_mq_tags *', but which is a block layer internal definition.
> 
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   block/blk-mq.c | 14 +++-----------
>>   1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 5362a7958b74..424afe112b58 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -846,6 +846,7 @@ static int blk_mq_test_tag_bit(struct blk_mq_tags *tags, unsigned int tag)
>>   
>>   struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
>>   {
>> +	/* if tags is hctx->sched_tags, it always return NULL */
>>   	if (tag < tags->nr_tags && blk_mq_test_tag_bit(tags, tag)) {
>>   		prefetch(tags->rqs[tag]);
>>   		return tags->rqs[tag];
>> @@ -3845,17 +3846,8 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
>>   
>>   	if (!blk_qc_t_is_internal(cookie))
>>   		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
>> -	else {
>> -		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
>> -		/*
>> -		 * With scheduling, if the request has completed, we'll
>> -		 * get a NULL return here, as we clear the sched tag when
>> -		 * that happens. The request still remains valid, like always,
>> -		 * so we should be safe with just the NULL check.
>> -		 */
>> -		if (!rq)
>> -			return false;
>> -	}
>> +	else
>> +		return false;
>>   
> 
> I think the correct fix is to retrieve the request via:
> 
> 	hctx->sched_tags->static_rqs[blk_qc_t_to_tag(cookie)]
> 
> since it is nice to run blk_mq_poll_hybrid_sleep() for one
> non-started request in case of real scheduler.
> 

Yes, do blk_mq_poll_hybrid_sleep() should be more reasonable here.
I will modify it in next version.

Thanks,
Yufen
