Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EE1EB64D9
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 03:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjF1D2a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 23:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjF1D23 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 23:28:29 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [IPv6:2001:41d0:203:375::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1992D59
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 20:28:27 -0700 (PDT)
Message-ID: <9c038fe8-0361-c6fb-9b4e-7b74e0591ae9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687922905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CvyHRxWT3NfNdVro9WC1jCUTzuWhGmVGCy9untK/qc8=;
        b=kGIJ0QSU3psDqR3qm91xwn7RZ1cDqy6la2SKW6fxxfHOtrqE6uxD4m952Voj680gZH7sFX
        ktYug9A/Ai06sYCYGYiEzirZ5U9LxDlWZlCoz6cXu46fpPENFEnnBV7LGBApL0g0bfho6E
        295RHpYaNghvPzw2IGnrIfDzw9B1fNU=
Date:   Wed, 28 Jun 2023 11:28:20 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] blk-mq: use percpu csd to remote complete instead of
 per-rq csd
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230627120854.971475-1-chengming.zhou@linux.dev>
 <20230627120854.971475-2-chengming.zhou@linux.dev>
 <ZJuY0OZu42H0oBa7@ovpn-8-21.pek2.redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZJuY0OZu42H0oBa7@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/6/28 10:20, Ming Lei wrote:
> On Tue, Jun 27, 2023 at 08:08:51PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> If request need to be completed remotely, we insert it into percpu llist,
>> and smp_call_function_single_async() if llist is empty previously.
>>
>> We don't need to use per-rq csd, percpu csd is enough. And the size of
>> struct request is decreased by 24 bytes.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  block/blk-mq.c         | 12 ++++++++----
>>  include/linux/blk-mq.h |  5 +----
>>  2 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index decb6ab2d508..a36822479b94 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -43,6 +43,7 @@
>>  #include "blk-ioprio.h"
>>  
>>  static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
>> +static DEFINE_PER_CPU(struct __call_single_data, blk_cpu_csd);
> 
> It might be better to use call_single_data, given:
> 
> /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
>   typedef struct __call_single_data call_single_data_t
>   	__aligned(sizeof(struct __call_single_data));
> 

Good, I will change to use this.

>>  
>>  static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
>>  static void blk_mq_request_bypass_insert(struct request *rq,
>> @@ -1156,13 +1157,13 @@ static void blk_mq_complete_send_ipi(struct request *rq)
>>  {
>>  	struct llist_head *list;
>>  	unsigned int cpu;
>> +	struct __call_single_data *csd;
>>  
>>  	cpu = rq->mq_ctx->cpu;
>>  	list = &per_cpu(blk_cpu_done, cpu);
>> -	if (llist_add(&rq->ipi_list, list)) {
>> -		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
>> -		smp_call_function_single_async(cpu, &rq->csd);
>> -	}
>> +	csd = &per_cpu(blk_cpu_csd, cpu);
>> +	if (llist_add(&rq->ipi_list, list))
>> +		smp_call_function_single_async(cpu, csd);
>>  }
> 
> This way is cleaner, and looks correct, given block softirq is guaranteed to be
> scheduled to consume the list if one new request is added to this percpu list,
> either smp_call_function_single_async() returns -EBUSY or 0.
> 

If this llist_add() see the llist is empty, the consumer function in the softirq
on the remote CPU must have consumed the llist, so smp_call_function_single_async()
won't return -EBUSY ?

Thanks.

