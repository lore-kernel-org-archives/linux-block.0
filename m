Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: ensure hctx to be ran on mapped cpu when issue
 directly
To: Jens Axboe <axboe@kernel.dk>
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540394407-20769-1-git-send-email-jianchao.w.wang@oracle.com>
 <a25dbb6a-2ffe-a843-abc4-1a6608c17a49@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ab0ee728-ed8f-7f9e-4318-e07200d936ac@oracle.com>
Date: Fri, 26 Oct 2018 09:38:26 +0800
MIME-Version: 1.0
In-Reply-To: <a25dbb6a-2ffe-a843-abc4-1a6608c17a49@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens

On 10/26/18 12:25 AM, Jens Axboe wrote:
> On 10/24/18 9:20 AM, Jianchao Wang wrote:
>> When issue request directly and the task is migrated out of the
>> original cpu where it allocates request, hctx could be ran on
>> the cpu where it is not mapped. To fix this, insert the request
>> if BLK_MQ_F_BLOCKING is set, check whether the current is mapped
>> to the hctx and invoke __blk_mq_issue_directly under preemption
>> disabled.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  block/blk-mq.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index e3c39ea..0cdc306 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1717,6 +1717,12 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>>  {
>>  	struct request_queue *q = rq->q;
>>  	bool run_queue = true;
>> +	blk_status_t ret;
>> +
>> +	if (hctx->flags & BLK_MQ_F_BLOCKING) {
>> +		bypass_insert = false;
>> +		goto insert;
>> +	}
> 
> I'd do a prep patch that moves the insert logic out of this function,
> and just have the caller do it by return BLK_STS_RESOURCE, for instance.
> It's silly that we have that in both the caller and inside this function.

Yes.

> 
>> @@ -1734,6 +1740,11 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>>  	if (q->elevator && !bypass_insert)
>>  		goto insert;
>>  
>> +	if (!cpumask_test_cpu(get_cpu(), hctx->cpumask)) {
>> +		bypass_insert = false;
>> +		goto insert;
>> +	}
> 
> Should be fine to just do smp_processor_id() here, as we're inside
> hctx_lock() here.
> 

If the rcu is preemptible, smp_processor_id will not enough here.

Thanks
Jianchao
