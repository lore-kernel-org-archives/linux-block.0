Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF9BC4361B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D9F23A7B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 09:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgLRJcX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Dec 2020 04:32:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2267 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgLRJcW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Dec 2020 04:32:22 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cy3T76ds8z67RKR;
        Fri, 18 Dec 2020 17:28:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 18 Dec 2020 10:31:39 +0100
Received: from [10.210.168.198] (10.210.168.198) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 18 Dec 2020 09:31:38 +0000
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <hare@suse.de>, <ppvk@codeaurora.org>,
        <kashyap.desai@broadcom.com>, <linuxarm@huawei.com>
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <30c16455-6d7d-39ac-b3fc-4ee38199e683@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c1e9c7d8-e9ce-b3c5-19f5-22eb3a808c29@huawei.com>
Date:   Fri, 18 Dec 2020 09:30:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <30c16455-6d7d-39ac-b3fc-4ee38199e683@acm.org>
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

On 18/12/2020 01:55, Bart Van Assche wrote:
> On 12/17/20 3:07 AM, John Garry wrote:
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
>> +
>> +			__blk_mq_all_tag_iter(tags, fn, priv,
>>   					      BT_TAG_ITER_STARTED);
>> +
>> +			atomic_dec(&tags->iter_usage_counter);
>> +		}
>>   	}
>>   }
> 
> Atomic operations are (a) more expensive than rcu_read_lock() /
> rcu_read_lock() and (b) do not provide the same guarantees.
> rcu_read_lock() has acquire semantics and rcu_read_unlock() has
> release semantics. Regular atomic operations do not have these
> semantics which means that the CPU is allowed to reorder certain
> regular loads and stores against atomic operations. Additionally,
> atomic operations are more expensive than the corresponding RCU
> primitives. In other words, I would be much happier if this patch
> series would use RCU instead of atomics.
> 

Hi Bart,

In terms of solving the problem with RCU, can you provide more details 
on how it would actually work?

I saw that you mentioned kfree_rcu() at the following, so guess it's 
related:
https://lore.kernel.org/linux-block/5c3ac5af-ed81-11e4-fee3-f92175f14daf@acm.org/T/#m830071bca03af31516800c14f8cccbe63661c5db

In terms of expense of atomic operations, we're just adding these 
operations around the iter function, so I can't see much impact really 
on fastpath.

Thanks,
John
