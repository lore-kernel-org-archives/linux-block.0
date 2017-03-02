Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
To: Omar Sandoval <osandov@osandov.com>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
 <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org>
 <a3e62a57-d401-99e0-6487-fc8277204e71@fb.com>
 <9fe1b3a9-2a80-8891-1044-f83558e28d15@fb.com>
 <1720FEB5-FBBA-4EAA-8292-E820AA15389D@linaro.org>
 <dc4dc011-7038-2c05-b1c0-f6f7a07fa9ae@fb.com>
 <80de4554-a14b-4ce6-7c6e-ec66f70b14b1@fb.com>
 <6C03BF2A-0902-431A-A545-933F56D3E134@linaro.org>
 <75978d1d-8022-75c2-7799-aa65132fdcdd@fb.com> <20170302205322.GB7792@vader>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
 kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <22dcbba7-9895-dcf8-91e4-db261827857d@fb.com>
Date: Thu, 2 Mar 2017 13:59:40 -0700
MIME-Version: 1.0
In-Reply-To: <20170302205322.GB7792@vader>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/02/2017 01:53 PM, Omar Sandoval wrote:
> On Thu, Mar 02, 2017 at 09:13:30AM -0700, Jens Axboe wrote:
>> I was worried about that. How about the below? We need to grab the lock
>> at some point for legacy scheduling, but the ordering should be correct.
> 
> Makes sense, now the locking is consistent with the other place we call
> ioc_exit_icq(). One nit below, and you can add
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
>> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
>> index b12f9c87b4c3..6fd633b5d567 100644
>> --- a/block/blk-ioc.c
>> +++ b/block/blk-ioc.c
>> @@ -54,7 +54,7 @@ static void ioc_exit_icq(struct io_cq *icq)
>>  	icq->flags |= ICQ_EXITED;
>>  }
>>  
>> -/* Release an icq.  Called with both ioc and q locked. */
>> +/* Release an icq.  Called with ioc locked. */
> 
> For ioc_exit_icq(), we have the more explicit comment
> 
> /*
>  * Exit an icq. Called with both ioc and q locked for sq, only ioc locked for
>  * mq.
>  */
> 
> Could you document that here, too?

Done, I've synced the two comments now. Thanks for the review!

-- 
Jens Axboe
