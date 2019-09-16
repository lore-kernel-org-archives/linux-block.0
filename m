Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79881C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 09:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554EF20890
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 09:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfIPJ1u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:27:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbfIPJ1u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 05:27:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4CE31A0667E9ECA45EEC;
        Mon, 16 Sep 2019 17:27:48 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Sep 2019
 17:27:41 +0800
Subject: Re: [PATCH] block: fix null pointer dereference in
 blk_mq_rq_timed_out()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <hch@infradead.org>, <keith.busch@intel.com>, <tj@kernel.org>,
        <zhangxiaoxu5@huawei.com>
References: <20190907102450.40291-1-yuyufen@huawei.com>
 <20190912024618.GE2731@ming.t460p>
 <b3d7b459-5f31-d473-2508-20048119c1b2@huawei.com>
 <20190912041658.GA5020@ming.t460p>
 <d3549c6d-ca07-efa9-af15-7cee61ce5ff2@huawei.com>
 <20190912100755.GB9897@ming.t460p>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <04b485ad-90e6-7752-b74f-9694de9c22a6@huawei.com>
Date:   Mon, 16 Sep 2019 17:27:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190912100755.GB9897@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/9/12 18:07, Ming Lei wrote:
> On Thu, Sep 12, 2019 at 04:49:15PM +0800, Yufen Yu wrote:
>>
>> On 2019/9/12 12:16, Ming Lei wrote:
>>> On Thu, Sep 12, 2019 at 11:29:18AM +0800, Yufen Yu wrote:
>>>> On 2019/9/12 10:46, Ming Lei wrote:
>>>>> On Sat, Sep 07, 2019 at 06:24:50PM +0800, Yufen Yu wrote:
>>>>>> There is a race condition between timeout check and completion for
>>>>>> flush request as follow:
>>>>>>
>>>>>> timeout_work    issue flush      issue flush
>>>>>>                    blk_insert_flush
>>>>>>                                     blk_insert_flush
>>>>>> blk_mq_timeout_work
>>>>>>                    blk_kick_flush
>>>>>>
>>>>>> blk_mq_queue_tag_busy_iter
>>>>>> blk_mq_check_expired(flush_rq)
>>>>>>
>>>>>>                    __blk_mq_end_request
>>>>>>                   flush_end_io
>>>>>>                   blk_kick_flush
>>>>>>                   blk_rq_init(flush_rq)
>>>>>>                   memset(flush_rq, 0)
>>>>> Not see there is memset(flush_rq, 0) in block/blk-flush.c
>>>> Call path as follow:
>>>>
>>>> blk_kick_flush
>>>>       blk_rq_init
>>>>           memset(rq, 0, sizeof(*rq));
>>> Looks I miss this one in blk_rq_init(), sorry for that.
>>>
>>> Given there are only two users of blk_rq_init(), one simple fix could be
>>> not clearing queue in blk_rq_init(), something like below?
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 77807a5d7f9e..25e6a045c821 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -107,7 +107,9 @@ EXPORT_SYMBOL_GPL(blk_queue_flag_test_and_set);
>>>    void blk_rq_init(struct request_queue *q, struct request *rq)
>>>    {
>>> -	memset(rq, 0, sizeof(*rq));
>>> +	const int offset = offsetof(struct request, q);
>>> +
>>> +	memset((void *)rq + offset, 0, sizeof(*rq) - offset);
>>>    	INIT_LIST_HEAD(&rq->queuelist);
>>>    	rq->q = q;
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 1ac790178787..382e71b8787d 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -130,7 +130,7 @@ enum mq_rq_state {
>>>     * especially blk_mq_rq_ctx_init() to take care of the added fields.
>>>     */
>>>    struct request {
>>> -	struct request_queue *q;
>>> +	struct request_queue *q;	/* Must be the 1st field */
>>>    	struct blk_mq_ctx *mq_ctx;
>>>    	struct blk_mq_hw_ctx *mq_hctx;
>> Not set req->q as '0' can just avoid BUG_ON for NULL pointer deference.
>>
>> However, the root problem is that 'flush_rq' have been reused while
>> timeout function handle it currently. That means mq_ops->timeout() may
>> access old values remained by the last flush request and make the wrong
>> decision.
>>
>> Take the race condition in the patch as an example.
>>
>> blk_mq_check_expired
>>      blk_mq_rq_timed_out
>>          req->q->mq_ops->timeout  // Driver timeout handle may read old data
>>      refcount_dec_and_test(&rq)
>>      __blk_mq_free_request   // If rq have been reset has '1' in
>> blk_rq_init(), it will be free here.
>>
>> So, I think we should solve this problem completely. Just like normal
>> request,
>> we can prevent flush request to call end_io when timeout handle the request.
> Seems it isn't specific for 'flush_rq', and it should be one generic issue
> for any request which implements .end_io.
>
> For requests without defining .end_io, rq->ref is applied for protecting
> its lifetime. However, rq->end_io() is still called even if rq->ref doesn't
> drop to zero.
>
> If the above is correct, we need to let rq->ref to cover rq->end_io().

We ignore the fact that we may also need to free 'rq' after calling 
rq->end_io(),
such as end_clone_request(), mq_flush_data_end_io().

If  we let 'rq->ref' to cover rq->end_io(), 'rq->ref' have been 
decreased to '0'
before calling __blk_mq_free_request(). Then, the function will never be 
called.

So, I think flush request may need to be fixed individually.

Thanks,
Yufen





