Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
To: Peter Zijlstra <peterz@infradead.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "oleg@redhat.com"
 <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "osandov@fb.com" <osandov@fb.com>,
        "tj@kernel.org" <tj@kernel.org>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-3-tj@kernel.org> <1513277469.2475.43.camel@wdc.com>
 <20171214202042.GG3326@worktop> <1513287766.2475.73.camel@wdc.com>
 <20171214215404.GK3326@worktop>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <007e5a56-83fb-23b0-64d9-4725f15c596d@oracle.com>
Date: Fri, 15 Dec 2017 10:12:50 +0800
MIME-Version: 1.0
In-Reply-To: <20171214215404.GK3326@worktop>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 12/15/2017 05:54 AM, Peter Zijlstra wrote:
> On Thu, Dec 14, 2017 at 09:42:48PM +0000, Bart Van Assche wrote:
>> On Thu, 2017-12-14 at 21:20 +0100, Peter Zijlstra wrote:
>>> On Thu, Dec 14, 2017 at 06:51:11PM +0000, Bart Van Assche wrote:
>>>> On Tue, 2017-12-12 at 11:01 -0800, Tejun Heo wrote:
>>>>> +	write_seqcount_begin(&rq->gstate_seq);
>>>>> +	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
>>>>> +	blk_add_timer(rq);
>>>>> +	write_seqcount_end(&rq->gstate_seq);
>>>>
>>>> My understanding is that both write_seqcount_begin() and write_seqcount_end()
>>>> trigger a write memory barrier. Is a seqcount really faster than a spinlock?
>>>
>>> Yes lots, no atomic operations and no waiting.
>>>
>>> The only constraint for write_seqlock is that there must not be any
>>> concurrency.
>>>
>>> But now that I look at this again, TJ, why can't the below happen?
>>>
>>> 	write_seqlock_begin();
>>> 	blk_mq_rq_update_state(rq, IN_FLIGHT);
>>> 	blk_add_timer(rq);
>>> 	<timer-irq>
>>> 		read_seqcount_begin()
>>> 			while (seq & 1)
>>> 				cpurelax();
>>> 		// life-lock
>>> 	</timer-irq>
>>> 	write_seqlock_end();
>>
>> Hello Peter,
>>
>> Some time ago the block layer was changed to handle timeouts in thread context
>> instead of interrupt context. See also commit 287922eb0b18 ("block: defer
>> timeouts to a workqueue").
> 
> That only makes it a little better:
> 
> 	Task-A					Worker
> 
> 	write_seqcount_begin()
> 	blk_mq_rw_update_state(rq, IN_FLIGHT)
> 	blk_add_timer(rq)
> 	<timer>
> 		schedule_work()
> 	</timer>
> 	<context-switch to worker>
> 						read_seqcount_begin()
> 							while(seq & 1)
> 								cpu_relax();
> 
Hi Peter

The current seqcount read side is as below:
	do {
		start = read_seqcount_begin(&rq->gstate_seq);
		gstate = READ_ONCE(rq->gstate);
		deadline = rq->deadline;
	} while (read_seqcount_retry(&rq->gstate_seq, start));
read_seqcount_retry() doesn't check the bit 0, but whether the saved value from 
read_seqcount_begin() is equal to the current value of seqcount.
pls refer:
static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
{
	return unlikely(s->sequence != start);
}

Thanks
Jianchao
> 
> Now normally this isn't fatal because Worker will simply spin its entire
> time slice away and we'll eventually schedule our Task-A back in, which
> will complete the seqcount and things will work.
> 
> But if, for some reason, our Worker was to have RT priority higher than
> our Task-A we'd be up some creek without no paddles.
> 
> We don't happen to have preemption of IRQs off here? That would fix
> things nicely.
> 
