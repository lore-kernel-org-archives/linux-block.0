Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62BDC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 07:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABCF64E3F
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 07:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhCAHza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Mar 2021 02:55:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:42016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232519AbhCAHz1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Mar 2021 02:55:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33EA1AA4F;
        Mon,  1 Mar 2021 07:54:46 +0000 (UTC)
Subject: Re: [RFC PATCH 1/2] blk-mq: test tags bitmap before get request
To:     Bart Van Assche <bvanassche@acm.org>,
        Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, ming.lei@redhat.com, hch@lst.de
References: <20210301021444.4134047-1-yuyufen@huawei.com>
 <20210301021444.4134047-2-yuyufen@huawei.com>
 <e364502d-a00a-d079-edc2-c99a1ae6936e@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <52f56e63-659f-fc7c-0b16-0fa9dfd0007d@suse.de>
Date:   Mon, 1 Mar 2021 08:54:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <e364502d-a00a-d079-edc2-c99a1ae6936e@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/1/21 4:49 AM, Bart Van Assche wrote:
> On 2/28/21 6:14 PM, Yufen Yu wrote:
>> For now, we set hctx->tags->rqs[i] when get driver tag successfully.
>> The request either comes from sched_tags->static_rqs[] with scheduler,
>> or comes from tags->static_rqs[] with no scheduler. But, the value won't
>> be clear when put driver tag. Thus, tags->rqs[i] still remain old request.
>>
>> We can free these sched_tags->static_rqs[] requests when switch elevator,
>> update nr_requests or update nr_hw_queues. After that, unexpected access
>> of tags->rqs[i] may cause use-after-free crash.
>>
>> For example, we reported use-after-free of request in nbd device
>> by syzkaller:
>>
>> BUG: KASAN: use-after-free in blk_mq_request_started+0x24/0x40 block/blk-mq.c:644
>> Read of size 4 at addr ffff80036b77f9d4 by task kworker/u9:0/10086
>> Call trace:
>>   dump_backtrace+0x0/0x310 arch/arm64/kernel/time.c:78
>>   show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x144/0x1b4 lib/dump_stack.c:118
>>   print_address_description+0x68/0x2d0 mm/kasan/report.c:253
>>   kasan_report_error mm/kasan/report.c:351 [inline]
>>   kasan_report+0x134/0x2f0 mm/kasan/report.c:409
>>   check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>>   __asan_load4+0x88/0xb0 mm/kasan/kasan.c:699
>>   __read_once_size include/linux/compiler.h:193 [inline]
>>   blk_mq_rq_state block/blk-mq.h:106 [inline]
>>   blk_mq_request_started+0x24/0x40 block/blk-mq.c:644
>>   nbd_read_stat drivers/block/nbd.c:670 [inline]
>>   recv_work+0x1bc/0x890 drivers/block/nbd.c:749
>>   process_one_work+0x3ec/0x9e0 kernel/workqueue.c:2156
>>   worker_thread+0x80/0x9d0 kernel/workqueue.c:2311
>>   kthread+0x1d8/0x1e0 kernel/kthread.c:255
>>   ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1174
>>
>> The syzkaller test program sended a reply package to client
>> without client sending request. After receiving the package,
>> recv_work() try to get the remained request in tags->rqs[]
>> by tag, which have been free.
>>
>> To avoid this type of problem, we may need to ensure the request
>> valid when get it by tag.
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   block/blk-mq.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index d4d7c1caa439..5362a7958b74 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -836,9 +836,17 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q,
>>   }
>>   EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
>>   
>> +static int blk_mq_test_tag_bit(struct blk_mq_tags *tags, unsigned int tag)
>> +{
>> +	if (!blk_mq_tag_is_reserved(tags, tag))
>> +		return sbitmap_test_bit(&tags->bitmap_tags->sb, tag);
>> +	else
>> +		return sbitmap_test_bit(&tags->breserved_tags->sb, tag);
>> +}
>> +
>>   struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
>>   {
>> -	if (tag < tags->nr_tags) {
>> +	if (tag < tags->nr_tags && blk_mq_test_tag_bit(tags, tag)) {
>>   		prefetch(tags->rqs[tag]);
>>   		return tags->rqs[tag];
>>   	}
> 
> Please do not slow down the hot path by inserting additional code in the
> hot path. I am convinced that the race described in the patch
> description can be fixed without changing the hot path. See also the
> conversation I had recently with John Garry on linux-block.
> 
Seems to be cropping up everywhere now; anyway, I do agree with Bart here.
For the hot path (typically when looking up the associated command from 
within the interrupt routine) we really should not add any further code 
to not slow down processing.
Additionally, this is typically a firmware response so we can be 
reasonably certain that this is a response to valid command, so in 
nearly all cases the bit will be set.
(Pathological cases like spoofed response frames aside).

However, there another use case where blk_mq_tag_to_rq() is used, and 
that is for traversing outstanding commands eg during a device reset.
There we _have_ to ensure that the request is valid lest we run into
uninitialized values.

So I would advocate to have a slow path variant here which would 
validate the bitmap before trying to access the request.

Or, really, converting those drivers to use blk_mq_tagset_busy_iter().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
