Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4BCC4361B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 10:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E3423A9B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 10:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbgLRKCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Dec 2020 05:02:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2268 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgLRKCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Dec 2020 05:02:50 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cy47J4pTjz67RPs;
        Fri, 18 Dec 2020 17:58:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 18 Dec 2020 11:02:07 +0100
Received: from [10.210.168.198] (10.210.168.198) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 18 Dec 2020 10:02:06 +0000
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>, <hare@suse.de>,
        <ppvk@codeaurora.org>, <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>, <linuxarm@huawei.com>
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <20201218033125.GA2322803@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <78ac690d-3c90-be90-1628-53422e1d928a@huawei.com>
Date:   Fri, 18 Dec 2020 10:01:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201218033125.GA2322803@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.198]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/12/2020 03:31, Ming Lei wrote:
>>   3 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index a6df2d5df88a..853ed5b889aa 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -358,10 +358,19 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>>   {
>>   	int i;
>>   
>>   	for (i = 0; i < tagset->nr_hw_queues; i++) {
>> -		if (tagset->tags && tagset->tags[i])
>> -			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>> +		if (tagset->tags && tagset->tags[i]) {
>> +			struct blk_mq_tags *tags = tagset->tags[i];
>> +
>> +			if (!atomic_inc_not_zero(&tags->iter_usage_counter))
>> +				continue;

Hi Ming,

> When 'continue' is run, blk_mq_tagset_busy_iter()'s semantic may be
> broken.

Yeah, I did consider this, and thought that we're ok since we iter only 
started tags here (and there would be none for the queue). But then that 
would not work for other queues with active tags associated.

> 
>> +
>> +			__blk_mq_all_tag_iter(tags, fn, priv,
>>   					      BT_TAG_ITER_STARTED);
>> +
>> +			atomic_dec(&tags->iter_usage_counter);
>> +		}
>>   	}
>>   }
>>   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
>> @@ -435,9 +444,14 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>>   		if (!blk_mq_hw_queue_mapped(hctx))
>>   			continue;
>>   
>> +		if (!atomic_inc_not_zero(&tags->iter_usage_counter))
>> +			continue;
> Same with above comment.

Right, similar to above.

> 
>> +
>>   		if (tags->nr_reserved_tags)
>>   			bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
>>   		bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
>> +
>> +		atomic_dec(&tags->iter_usage_counter);
>>   	}
>>   	blk_queue_exit(q);
>>   }
>> @@ -461,6 +475,8 @@ static int blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
>>   		     round_robin, node))
>>   		goto free_bitmap_tags;
>>   
>> +	atomic_set(&tags->iter_usage_counter, 1);
>> +
>>   	tags->bitmap_tags = &tags->__bitmap_tags;
>>   	tags->breserved_tags = &tags->__breserved_tags;
>>   
>> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
>> index 7d3e6b333a4a..563019d60f05 100644
>> --- a/block/blk-mq-tag.h
>> +++ b/block/blk-mq-tag.h
>> @@ -11,6 +11,9 @@ struct blk_mq_tags {
>>   
>>   	atomic_t active_queues;
>>   
>> +	/* Only interesting for driver tags */
>> +	atomic_t	iter_usage_counter;
>> +
>>   	struct sbitmap_queue *bitmap_tags;
>>   	struct sbitmap_queue *breserved_tags;
>>   
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8465d7c5ebf0..a61279be0120 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2315,7 +2315,9 @@ void __blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>   void blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>   		     unsigned int hctx_idx, struct blk_mq_tags *ref_tags)
>>   {
>> +	while (atomic_cmpxchg(&ref_tags->iter_usage_counter, 1, 0) != 1);
>>   	__blk_mq_free_rqs_ext(set, tags, hctx_idx, ref_tags);
>> +	atomic_set(&ref_tags->iter_usage_counter, 1);
>>   }
> I guess it is simpler to sync the two code paths by adding mutex to 'ref_tags' and
> holding it in both __blk_mq_free_rqs_ext() and the above two iterator helpers.

But are we allowed to always sleep in the iter calling context?

And that will also lockout parallel iterations, which is less than ideal.

So I could look to address the issues you mention above with atomics 
still, but maybe Bart has some better idea regarding RCU.

Thanks,
John
