Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67388C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 08:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1781964F97
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 08:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBEIF0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 03:05:26 -0500
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:43842 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhBEIFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 03:05:25 -0500
Received: from [127.0.0.1] (unknown [157.0.31.124])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id ECF38AC0371;
        Fri,  5 Feb 2021 16:04:34 +0800 (CST)
Subject: Re: [PATCH] kyber: introduce kyber_depth_updated()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        onlyfever@icloud.com
References: <20210122090636.55428-1-yang.yang@vivo.com>
 <YBxPaEVcYuVC+FKD@relinquished.localdomain>
From:   Yang Yang <yang.yang@vivo.com>
Message-ID: <7c3a3318-80ba-4b8b-6ace-68f1619e9d7a@vivo.com>
Date:   Fri, 5 Feb 2021 16:04:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YBxPaEVcYuVC+FKD@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQh5DS0hPGRhLSRkdVkpNSklOSklJTE5LQk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nzo6Ghw4ST8VTCoYOhgvHQwc
        Lx8KFAxVSlVKTUpJTkpJSUxOT0xNVTMWGhIXVQIaFRxVAhoVHDsNEg0UVRgUFkVZV1kSC1lBWUpO
        TFVLVUhKVUpJT1lXWQgBWUFPTUxCNwY+
X-HM-Tid: 0a777138aa67b039kuuuecf38ac0371
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/2/5 3:47, Omar Sandoval wrote:
> On Fri, Jan 22, 2021 at 01:06:36AM -0800, Yang Yang wrote:
>> Hang occurs when user changes the scheduler queue depth, by writing to
>> the 'nr_requests' sysfs file of that device.
>> This patch introduces kyber_depth_updated(), so that kyber can update its
>> internal state when queue depth changes.
> 
> Do you have a reproducer for this? It'd be useful to turn that into a
> blktest.
> 
> I _think_ this fix is correct other than the comment below, but it'd be
> helpful to have an explanation in the commit message of how exactly it
> gets stuck without the fix.
> 

The details of the environment that we found the problem are as follows:
  an eMMC block device
  total driver tags: 16
  default queue_depth: 32
  kqd->async_depth initialized in kyber_init_sched() with queue_depth=32

Then we change queue_depth to 256, by writing to the 'nr_requests' sysfs 
file.
kqd->async_depth don't be updated after queue_depth changes.
Now the value of async depth is too small for queue_depth=256, this may 
cause hang.

>> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>> ---
>>   block/kyber-iosched.c | 28 ++++++++++++----------------
>>   1 file changed, 12 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
>> index dc89199bc8c6..b64f80d3eaf3 100644
>> --- a/block/kyber-iosched.c
>> +++ b/block/kyber-iosched.c
>> @@ -353,19 +353,9 @@ static void kyber_timer_fn(struct timer_list *t)
>>   	}
>>   }
>>   
>> -static unsigned int kyber_sched_tags_shift(struct request_queue *q)
>> -{
>> -	/*
>> -	 * All of the hardware queues have the same depth, so we can just grab
>> -	 * the shift of the first one.
>> -	 */
>> -	return q->queue_hw_ctx[0]->sched_tags->bitmap_tags->sb.shift;
>> -}
>> -
>>   static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>>   {
>>   	struct kyber_queue_data *kqd;
>> -	unsigned int shift;
>>   	int ret = -ENOMEM;
>>   	int i;
>>   
>> @@ -400,9 +390,6 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>>   		kqd->latency_targets[i] = kyber_latency_targets[i];
>>   	}
>>   
>> -	shift = kyber_sched_tags_shift(q);
>> -	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
>> -
>>   	return kqd;
>>   
>>   err_buckets:
>> @@ -458,9 +445,18 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
>>   		INIT_LIST_HEAD(&kcq->rq_list[i]);
>>   }
>>   
>> -static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>> +static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
>>   {
>>   	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
>> +	struct blk_mq_tags *tags = hctx->sched_tags;
>> +
>> +	kqd->async_depth = tags->bitmap_tags->sb.depth * KYBER_ASYNC_PERCENT / 100U;
> 
> This isn't equivalent to the old code. sbitmap::depth is the number of
> bits in the whole sbitmap. 2^sbitmap::shift is the number of bits used
> in a single word of the sbitmap. async_depth is the number of bits to
> use from each word (via sbitmap_get_shallow()).
> 
> This is setting async_depth to a fraction of the entire size of the
> sbitmap, which is probably greater than the size of a single word,
> effectively disabling the async depth limiting.
> 

I'll send a v2 with this fixed.

Thank you!


