Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE54C433F5
	for <linux-block@archiver.kernel.org>; Thu, 12 May 2022 01:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiELBaa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 May 2022 21:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiELBa2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 May 2022 21:30:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125B1154F90;
        Wed, 11 May 2022 18:30:19 -0700 (PDT)
Received: from kwepemi100017.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KzDc95286zCsWd;
        Thu, 12 May 2022 09:25:29 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100017.china.huawei.com (7.221.188.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 09:30:17 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 09:30:17 +0800
Subject: Re: [PATCH -next 2/2] block, bfq: make bfq_has_work() more accurate
To:     Jan Kara <jack@suse.cz>
CC:     <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220510131629.1964415-1-yukuai3@huawei.com>
 <20220510131629.1964415-3-yukuai3@huawei.com>
 <20220511140832.w6eqphw5uepre5ws@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <67425a7b-f9e1-d7a9-9ec8-158f9f8ce13e@huawei.com>
Date:   Thu, 12 May 2022 09:30:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220511140832.w6eqphw5uepre5ws@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/11 22:08, Jan Kara wrote:
> On Tue 10-05-22 21:16:29, Yu Kuai wrote:
>> bfq_has_work() is using busy_queues currently, which is not accurate
>> because bfq_queue is busy doesn't represent that it has requests. Since
>> bfqd aready has a counter 'queued' to record how many requests are in
>> bfq, use it instead of busy_queues.
>>
>> Noted that bfq_has_work() can be called with 'bfqd->lock' held, thus the
>> lock can't be held in bfq_has_work() to protect 'bfqd->queued'.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> So did you find this causing any real problem? Because bfq queue is
> accounted among busy queues once bfq_add_bfqq_busy() is called. And that
> happens once a new request is inserted into the queue so it should be very
> similar to bfqd->queued.
> 
> 								Honza

Hi,

The related problem is described here:

https://lore.kernel.org/all/20220510112302.1215092-1-yukuai3@huawei.com/

The root cause of the panic is a linux-block problem, however, it can
be bypassed if bfq_has_work() is accurate. On the other hand,
unnecessary run_work will be triggered if bfqq stays busy:

__blk_mq_run_hw_queue
  __blk_mq_sched_dispatch_requests
   __blk_mq_do_dispatch_sched
    if (!bfq_has_work())
     break;
    blk_mq_delay_run_hw_queues -> run again after 3ms

Thanks,
Kuai
> 
>> ---
>>   block/bfq-iosched.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 61750696e87f..1d2f8110c26b 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -5063,11 +5063,11 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
>>   	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
>>   
>>   	/*
>> -	 * Avoiding lock: a race on bfqd->busy_queues should cause at
>> +	 * Avoiding lock: a race on bfqd->queued should cause at
>>   	 * most a call to dispatch for nothing
>>   	 */
>>   	return !list_empty_careful(&bfqd->dispatch) ||
>> -		bfq_tot_busy_queues(bfqd) > 0;
>> +		READ_ONCE(bfqd->queued);
>>   }
>>   
>>   static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>> -- 
>> 2.31.1
>>
