Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Israel Rukshin <israelr@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
 <20180410095537.GA19266@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a34de069-2df9-177b-918c-cdbf747ebd79@kernel.dk>
Date: Tue, 10 Apr 2018 08:41:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180410095537.GA19266@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/10/18 3:55 AM, Christoph Hellwig wrote:
> On Mon, Apr 09, 2018 at 06:34:55PM -0700, Bart Van Assche wrote:
>> If a completion occurs after blk_mq_rq_timed_out() has reset
>> rq->aborted_gstate and the request is again in flight when the timeout
>> expires then a request will be completed twice: a first time by the
>> timeout handler and a second time when the regular completion occurs.
>>
>> Additionally, the blk-mq timeout handling code ignores completions that
>> occur after blk_mq_check_expired() has been called and before
>> blk_mq_rq_timed_out() has reset rq->aborted_gstate. If a block driver
>> timeout handler always returns BLK_EH_RESET_TIMER then the result will
>> be that the request never terminates.
>>
>> Since the request state can be updated from two different contexts,
>> namely regular completion and request timeout, this race cannot be
>> fixed with RCU synchronization only. Fix this race as follows:
>> - Split __deadline in two variables, namely lq_deadline for legacy
>>   request queues and mq_deadline for blk-mq request queues. Use atomic
>>   operations to update mq_deadline.
> 
> I don't think we need the atomic_long_cmpxchg, and can do with a plain
> cmpxhg.  Also unterminated cmpxchg loops are a bad idea, but I think
> both callers are protected from other changes so we can turn that
> into a WARN_ON().  That plus some minor cleanups in the version below,
> only boot tested:

This version looks reasonable, let me throw it through the testing
machinery.

-- 
Jens Axboe
