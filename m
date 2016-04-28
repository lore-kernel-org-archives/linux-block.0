Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v5] Make background writeback great again for the first
 time
To: xiakaixu <xiakaixu@huawei.com>
References: <1461686131-22999-1-git-send-email-axboe@fb.com>
 <20160427180105.GA17362@quack2.suse.cz> <5721021E.8060006@fb.com>
 <20160427203708.GA25397@kernel.dk> <20160427205915.GC25397@kernel.dk>
 <57218C5B.2070308@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 dchinner@redhat.com, sedat.dilek@gmail.com, Huxinwei <huxinwei@huawei.com>,
 "miaoxie (A)" <miaoxie@huawei.com>, Bintian <bintian.wang@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5722583D.6080300@kernel.dk>
Date: Thu, 28 Apr 2016 12:36:45 -0600
MIME-Version: 1.0
In-Reply-To: <57218C5B.2070308@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 04/27/2016 10:06 PM, xiakaixu wrote:
>> diff --git a/lib/wbt.c b/lib/wbt.c
>> index 650da911f24f..322f5e04e994 100644
>> --- a/lib/wbt.c
>> +++ b/lib/wbt.c
>> @@ -98,18 +98,23 @@ void __wbt_done(struct rq_wb *rwb)
>>   	else
>>   		limit = rwb->wb_normal;
> Hi Jens,
>
> This statement 'limit = rwb->wb_normal' is executed twice, maybe once is
> enough. It is not a big deal anyway :)

I'll clean that up, thanks for noticing. No functional difference.

> Another question about this if branch:
>
>     if (rwb->wc && !atomic_read(&rwb->bdi->wb.dirty_sleeping))
> 	limit = 0;
>
> I can't follow the logic of this if branch. why set limit equal to 0
> when the device supports write back caches and there are tasks being
> limited in balance_dirty_pages(). Could you pelase give more info
> about this ?  Thanks!

Sure. So for write back caching, we have to try a bit harder to ensure 
that the device doesn't build up long internal queues with a lot of 
dirty data in the cache. So for the case where we have write back 
caching AND we don't have anyone waiting for the IO, allow the queue 
depth to drain to zero before building it back up again.

Does that make sense?

>>
>> +	inflight = atomic_dec_return(&rwb->inflight);
>> +
>>   	/*
>> -	 * Don't wake anyone up if we are above the normal limit. If
>> -	 * throttling got disabled (limit == 0) with waiters, ensure
>> -	 * that we wake them up.
>> +	 * wbt got disabled with IO in flight. Wake up any potential
>> +	 * waiters, we don't have to do more than that.
>>   	 */
>> -	inflight = atomic_dec_return(&rwb->inflight);
>> -	if (limit && inflight >= limit) {
>> -		if (!rwb->wb_max)
>> -			wake_up_all(&rwb->wait);
>> +	if (!rwb_enabled(rwb)) {
>> +		wake_up_all(&rwb->wait);
>>   		return;
>>   	}
>
> Maybe it is better that executing this if branch earlier. So we can wake up
> potential waiters in time when wbt got disabled.

The !rwb_enabled() case will only happen if someone disabled wbt while 
we had tracked IO in flight. We have to it below the 
atomic_dec_return(), so we could reorder that to be at the front. 
Ideally we just want it out-of-line instead, as it's the unexpected 
slower path.

-- 
Jens Axboe
