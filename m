Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2577C2BA19
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 03:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6488221EA
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 03:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDRDZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:25:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgDRDZQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 23:25:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B2E1FCF64FC93CB46B2A;
        Sat, 18 Apr 2020 11:25:01 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.204) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 11:24:54 +0800
Subject: Re: [RFC] block: fix access of uninitialized pointer address in
 bt_for_each()
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <yi.zhang@huawei.com>, <yuyufen@huawei.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200417125134.45117-1-yukuai3@huawei.com>
 <340bed9b-e14d-5a22-1601-8fb7aad4ce7f@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f74ca075-7d29-a944-b49b-7b432f2a60c9@huawei.com>
Date:   Sat, 18 Apr 2020 11:24:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <340bed9b-e14d-5a22-1601-8fb7aad4ce7f@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.204]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

on 2020/4/17 22:26, Bart Van Assche wrote:

> The alloc/free info refers to a data structure owned by the pipe
> implementation. The use-after-free report refers to a data structure
> owned by the block layer. How can that report make sense?

Indeed, I'm comfused here, too.

>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 7ed16ed13976..48b74d0085c7 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -485,6 +485,7 @@ static void __blk_mq_free_request(struct request *rq)
>>   	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
>>   	const int sched_tag = rq->internal_tag;
>>   
>> +	hctx->tags->rqs[rq->tag] = NULL;
>>   	if (rq->tag != -1)
>>   		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
>>   	if (sched_tag != -1)
> 
> Can the above change trigger the following assignment?
> 
> hctx->tags->rqs[-1] = NULL?

My bad, should be inside 'if'.

> static inline void *kcalloc_node(size_t n, size_t size, gfp_t flags,
>                                   int node)
> {
> 	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
> }
> 
> I think this means that kcalloc_node() already zeroes the allocated
> memory and hence that changing kcalloc() into kzalloc() is not necessary.

You are right.

>> @@ -196,6 +196,7 @@ static inline void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
>>   	if (rq->tag == -1 || rq->internal_tag == -1)
>>   		return;
>>   
>> +	hctx->tags->rqs[rq->tag] = NULL;
>>   	__blk_mq_put_driver_tag(hctx, rq);
>>   }
>>   
>> @@ -207,6 +208,7 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
>>   		return;
>>   
>>   	hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu);
>> +	hctx->tags->rqs[rq->tag] = NULL;
>>   	__blk_mq_put_driver_tag(hctx, rq);
>>   }
> 
> I don't think the above changes are sufficient to fix the
> use-after-free. Has it been considered to free the memory that backs
> tags->bitmap_tags only after an RCU grace period has expired? See also
> blk_mq_free_tags().

As you pointed out, kcalloc_node() already zeroes out the memory. What I 
don't understand is that how could 'slab-out-of-bounds in bt_for_each' 
triggered instead UAF.

Thanks!
Yu Kuai


