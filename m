Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3C8C4332F
	for <linux-block@archiver.kernel.org>; Fri, 14 Oct 2022 02:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJNCJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 22:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJNCJ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 22:09:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0D5233B2
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 19:09:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MpVBq06s3zDsWB;
        Fri, 14 Oct 2022 10:07:15 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:09:48 +0800
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
CC:     <hch@lst.de>, <kbusch@kernel.org>, <ming.lei@redhat.com>,
        <axboe@kernel.dk>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com>
 <99dac305-206c-4e1b-a1ec-50e107258b6b@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <1ffd3e10-eb5b-1edf-b2ab-16ca00643c81@huawei.com>
Date:   Fri, 14 Oct 2022 10:09:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <99dac305-206c-4e1b-a1ec-50e107258b6b@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/13 18:28, Sagi Grimberg wrote:
> 
> 
> On 10/13/22 12:44, Chao Leng wrote:
>> Drivers that have shared tagsets may need to quiesce potentially a lot
>> of request queues that all share a single tagset (e.g. nvme). Add an interface
>> to quiesce all the queues on a given tagset. This interface is useful because
>> it can speedup the quiesce by doing it in parallel.
>>
>> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
>> in parallel such that all of them wait for the same rcu elapsed period with
>> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
>> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
>> sufficient.
>>
>> Because some queues never need to be quiesced(e.g. nvme connect_q).
>> So introduce QUEUE_FLAG_NOQUIESCED to tagset quiesce interface to
>> skip the queue.
> 
> I wouldn't say it never nor will ever quiesce, we just don't happen to
> quiesce it today...
> 
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   block/blk-mq.c         | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/blk-mq.h |  2 ++
>>   include/linux/blkdev.h |  2 ++
>>   3 files changed, 79 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8070b6c10e8d..ebe25da08156 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/prefetch.h>
>>   #include <linux/blk-crypto.h>
>>   #include <linux/part_stat.h>
>> +#include <linux/rcupdate_wait.h>
>>   #include <trace/events/block.h>
>> @@ -311,6 +312,80 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>> +static void blk_mq_quiesce_blocking_tagset(struct blk_mq_tag_set *set)
>> +{
>> +    int i = 0;
>> +    int count = 0;
>> +    struct request_queue *q;
>> +    struct rcu_synchronize *rcu;
>> +
>> +    list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +        if (blk_queue_noquiesced(q))
>> +            continue;
>> +
>> +        blk_mq_quiesce_queue_nowait(q);
>> +        count++;
>> +    }
>> +
>> +    rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
>> +    if (rcu) {
>> +        list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +            if (blk_queue_noquiesced(q))
>> +                continue;
>> +
>> +            init_rcu_head(&rcu[i].head);
>> +            init_completion(&rcu[i].completion);
>> +            call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
>> +            i++;
>> +        }
>> +
>> +        for (i = 0; i < count; i++) {
>> +            wait_for_completion(&rcu[i].completion);
>> +            destroy_rcu_head(&rcu[i].head);
>> +        }
>> +        kvfree(rcu);
>> +    } else {
>> +        list_for_each_entry(q, &set->tag_list, tag_set_list)
>> +            synchronize_srcu(q->srcu);
>> +    }
>> +}
>> +
>> +static void blk_mq_quiesce_nonblocking_tagset(struct blk_mq_tag_set *set)
>> +{
>> +    struct request_queue *q;
>> +
>> +    list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +        if (blk_queue_noquiesced(q))
>> +            continue;
>> +
>> +        blk_mq_quiesce_queue_nowait(q);
>> +    }
>> +    synchronize_rcu();
>> +}
>> +
>> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>> +{
>> +    mutex_lock(&set->tag_list_lock);
>> +    if (set->flags & BLK_MQ_F_BLOCKING)
>> +        blk_mq_quiesce_blocking_tagset(set);
>> +    else
>> +        blk_mq_quiesce_nonblocking_tagset(set);
>> +
>> +    mutex_unlock(&set->tag_list_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
>> +
>> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>> +{
>> +    struct request_queue *q;
>> +
>> +    mutex_lock(&set->tag_list_lock);
>> +    list_for_each_entry(q, &set->tag_list, tag_set_list)
>> +        blk_mq_unquiesce_queue(q);
>> +    mutex_unlock(&set->tag_list_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
>> +
>>   void blk_mq_wake_waiters(struct request_queue *q)
>>   {
>>       struct blk_mq_hw_ctx *hctx;
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index ba18e9bdb799..1df47606d0a7 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -877,6 +877,8 @@ void blk_mq_start_hw_queues(struct request_queue *q);
>>   void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
>>   void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
>>   void blk_mq_quiesce_queue(struct request_queue *q);
>> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
>> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
>>   void blk_mq_wait_quiesce_done(struct request_queue *q);
>>   void blk_mq_unquiesce_queue(struct request_queue *q);
>>   void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 50e358a19d98..f15544299a67 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -579,6 +579,7 @@ struct request_queue {
>>   #define QUEUE_FLAG_HCTX_ACTIVE    28    /* at least one blk-mq hctx is active */
>>   #define QUEUE_FLAG_NOWAIT       29    /* device supports NOWAIT */
>>   #define QUEUE_FLAG_SQ_SCHED     30    /* single queue style io dispatch */
>> +#define QUEUE_FLAG_NOQUIESCED    31    /* queue is never quiesced */
> 
> the comment is misleading. If this is truely queue that is never
> quiescing then blk_mq_quiesce_queue() and friends need to skip it.
> 
> I'd call it self_quiesce or something that would reflect that it is
> black-listed from tagset-wide quiesce.
Yes, you are right. I will modify the comment in patch V3.
> .
