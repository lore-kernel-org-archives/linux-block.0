Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: put the driver tag of nxt rq before first one is
 requeued
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1505236475-9209-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170912102302.GC15792@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <23b700aa-ed37-1081-d980-4073804f293b@oracle.com>
Date: Wed, 13 Sep 2017 09:01:25 +0800
MIME-Version: 1.0
In-Reply-To: <20170912102302.GC15792@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi ming

On 09/12/2017 06:23 PM, Ming Lei wrote:
>> @@ -1029,14 +1029,20 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
>>  		if (list_empty(list))
>>  			bd.last = true;
>>  		else {
>> -			struct request *nxt;
>> -
>>  			nxt = list_first_entry(list, struct request, queuelist);
>>  			bd.last = !blk_mq_get_driver_tag(nxt, NULL, false);
>>  		}
>>  
>>  		ret = q->mq_ops->queue_rq(hctx, &bd);
>>  		if (ret == BLK_STS_RESOURCE) {
>> +			/*
>> +			 * If an I/O scheduler has been configured and we got a
>> +			 * driver tag for the next request already, free it again.
>> +			 */
>> +			if (!list_empty(list)) {
>> +				nxt = list_first_entry(list, struct request, queuelist);
>> +				blk_mq_put_driver_tag(nxt);
>> +			}
> The following way might be more simple and clean:
> 
> 			if (nxt)
> 				blk_mq_put_driver_tag(nxt);
> 
> meantime 'nxt' need to be cleared inside the 'if (list_empty(list))'
> before .queue_rq().

I had ever thought about that, but to avoid add extra command in the 
fast path, I made the patch above.

Thanks
Jianchao
