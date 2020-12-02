Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C632CC71155
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 11:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D409206E0
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 11:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgLBLTn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:19:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2191 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLBLTn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 06:19:43 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CmGd41wcKz67Cls;
        Wed,  2 Dec 2020 19:16:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 2 Dec 2020 12:19:01 +0100
Received: from [10.47.3.233] (10.47.3.233) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 2 Dec 2020
 11:19:00 +0000
Subject: Re: [RFC PATCH] blk-mq: Clean up references when freeing rqs
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>, <hare@suse.de>,
        <ppvk@codeaurora.org>, <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>
References: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
 <20201202033134.GD494805@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <aaf77015-3039-6b04-3417-d376e3467444@huawei.com>
Date:   Wed, 2 Dec 2020 11:18:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201202033134.GD494805@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.3.233]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/12/2020 03:31, Ming Lei wrote:
> On Tue, Dec 01, 2020 at 09:02:18PM +0800, John Garry wrote:
>> It has been reported many times that a use-after-free can be intermittently
>> found when iterating busy requests:
>>
>> - https://lore.kernel.org/linux-block/8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com/
>> - https://lore.kernel.org/linux-block/5c3ac5af-ed81-11e4-fee3-f92175f14daf@acm.org/T/#m6c1ac11540522716f645d004e2a5a13c9f218908
>> - https://lore.kernel.org/linux-block/04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk/
>>
>> The issue is that when we switch scheduler or change queue nr_requests,
>> the driver tagset may keep references to the stale requests.
>>
>> As a solution, clean up any references to those requests in the driver
>> tagset when freeing. This is done with a cmpxchg to make safe any race
>> with setting the driver tagset request from another queue.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> --
>> Set as RFC as I need to test more. And not sure on solution method, as
>> Bart had another idea.
>>
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index d1eafe2c045c..9b042c7036b3 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -621,7 +621,7 @@ void blk_mq_sched_free_requests(struct request_queue *q)
>>   
>>   	queue_for_each_hw_ctx(q, hctx, i) {
>>   		if (hctx->sched_tags)
>> -			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);
>> +			blk_mq_free_rqs_ext(q->tag_set, hctx->sched_tags, i, hctx->tags);
>>   	}
>>   }
>>   
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 9c92053e704d..562db72e7d79 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -576,7 +576,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>>   			return -ENOMEM;
>>   		}
>>   
>> -		blk_mq_free_rqs(set, *tagsptr, hctx->queue_num);
>> +		blk_mq_free_rqs_ext(set, *tagsptr, hctx->queue_num, hctx->tags);
>>   		blk_mq_free_rq_map(*tagsptr, flags);
>>   		*tagsptr = new;
>>   	} else {
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 55bcee5dc032..f3aad695cd25 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2271,8 +2271,8 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>>   	return BLK_QC_T_NONE;
>>   }
>>   
>> -void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>> -		     unsigned int hctx_idx)
>> +void blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>> +		     unsigned int hctx_idx, struct blk_mq_tags *references)
>>   {
>>   	struct page *page;
>>   
>> @@ -2281,10 +2281,13 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>   
>>   		for (i = 0; i < tags->nr_tags; i++) {
>>   			struct request *rq = tags->static_rqs[i];
>> +			int j;
>>   
>>   			if (!rq)
>>   				continue;
>>   			set->ops->exit_request(set, rq, hctx_idx);
>> +			for (j = 0; references && j < references->nr_tags; j++)
>> +				cmpxchg(&references->rqs[j], rq, 0);
> 
> Seems you didn't address the comment in the following link:
> 
> 	https://lore.kernel.org/linux-block/10331543-9e45-ae63-8cdb-17e5a2a3b7ef@huawei.com/
> 
> The request to be freed may still be refered in another path, such as blk_mq_queue_tag_busy_iter
> or blk_mq_tagset_busy_iter(), and cmpxchg() doesn't drain/wait for other refers.
> 

Hi Ming,

Yeah, so I said that was another problem which you mentioned there, 
which I'm not addressing, but I don't think that I'm making thing worse 
here.

So AFAICS, the blk-mq/sched code doesn't wait for any "readers" to be 
finished, such as those running blk_mq_queue_tag_busy_iter or 
blk_mq_tagset_busy_iter() in another context.

So how about the idea of introducing some synchronization primitive, 
such as semaphore, which those "readers" must grab and release at start 
and end (of iter), to ensure the requests are not freed during the 
iteration?

Thanks,
John



