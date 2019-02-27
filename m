Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33279C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 10:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F9920830
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 10:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfB0KiK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:38:10 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfB0KiK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 05:38:10 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 140C9E2B11D97E30E1DF;
        Wed, 27 Feb 2019 18:38:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 18:38:05 +0800
Subject: Re: [PATCH] block: add a new flag BLK_MQ_POLL_HYBRID_INVALID for
 hybrid poll
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <20190227062155.19732-1-yuyufen@huawei.com>
 <0a46f96d-1707-9e1d-cd44-4eb7dce60533@gmail.com>
From:   yuyufen <yuyufen@huawei.com>
Message-ID: <ac9ee8b8-6eab-4cb4-f8fb-cf92341a45f5@huawei.com>
Date:   Wed, 27 Feb 2019 18:38:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <0a46f96d-1707-9e1d-cd44-4eb7dce60533@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2019/2/27 18:27, Marcos Paulo de Souza wrote:
> Hello Yufen,
>
> On 2/27/19 3:21 AM, Yufen Yu wrote:
>> For q->poll_nsec == -1, means using classic poll, not hybrid poll.
>> We introduce a new flag BLK_POLL_DELAY_INVALID to replace -1, which
>> may make code much easier to read.
>
> In the commit message you say BLK_POLL_DELAY_INVALID, but the code and 
> the commit title use BLK_MQ_POLL_HYBRID_INVALID. Is this a typo?
>

Thanks a lot for pointing out this fault. What I want to
say is BLK_MQ_POLL_HYBRID_INVALID, not BLK_POLL_DELAY_INVALID.

Yufen
Thanks

> Thanks.
>
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   block/blk-mq.c         | 4 ++--
>>   block/blk-sysfs.c      | 4 ++--
>>   include/linux/blkdev.h | 3 +++
>>   3 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 9437a5eb07cf..8df9f6e97d2e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2857,7 +2857,7 @@ struct request_queue 
>> *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>>       /*
>>        * Default to classic polling
>>        */
>> -    q->poll_nsec = -1;
>> +    q->poll_nsec = BLK_MQ_POLL_HYBRID_INVALID;
>>         blk_mq_init_cpu_queues(q, set->nr_hw_queues);
>>       blk_mq_add_queue_tag_set(set, q);
>> @@ -3389,7 +3389,7 @@ static bool blk_mq_poll_hybrid(struct 
>> request_queue *q,
>>   {
>>       struct request *rq;
>>   -    if (q->poll_nsec == -1)
>> +    if (q->poll_nsec == BLK_MQ_POLL_HYBRID_INVALID)
>>           return false;
>>         if (!blk_qc_t_is_internal(cookie))
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 590d1ef2f961..8775b898f96d 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -360,7 +360,7 @@ static ssize_t queue_poll_delay_show(struct 
>> request_queue *q, char *page)
>>   {
>>       int val;
>>   -    if (q->poll_nsec == -1)
>> +    if (q->poll_nsec == BLK_MQ_POLL_HYBRID_INVALID)
>>           val = -1;
>>       else
>>           val = q->poll_nsec / 1000;
>> @@ -381,7 +381,7 @@ static ssize_t queue_poll_delay_store(struct 
>> request_queue *q, const char *page,
>>           return err;
>>         if (val == -1)
>> -        q->poll_nsec = -1;
>> +        q->poll_nsec = BLK_MQ_POLL_HYBRID_INVALID;
>>       else
>>           q->poll_nsec = val * 1000;
>>   diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 338604dff7d0..2102447b67d9 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -50,6 +50,9 @@ struct blk_stat_callback;
>>   /* Must be consistent with blk_mq_poll_stats_bkt() */
>>   #define BLK_MQ_POLL_STATS_BKTS 16
>>   +/* Using default classic polling */
>> +#define BLK_MQ_POLL_HYBRID_INVALID -1
>> +
>>   /*
>>    * Maximum number of blkcg policies allowed to be registered 
>> concurrently.
>>    * Defined here to simplify include dependency.
>>
>
> .
>


