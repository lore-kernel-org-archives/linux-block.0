Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 Anchal Agarwal <anchalag@amzn.com>
Cc: fllinden@amazon.com,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
 <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
 <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
 <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
 <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
 <00445460-d826-4d85-c5f4-fa565892da01@oracle.com>
 <3876c36c-fec6-6586-435f-dc177dc38c76@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f88cd48d-e140-fa61-76f7-8985ca2c2e08@kernel.dk>
Date: Mon, 27 Aug 2018 08:51:44 -0600
MIME-Version: 1.0
In-Reply-To: <3876c36c-fec6-6586-435f-dc177dc38c76@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/27/18 12:15 AM, jianchao.wang wrote:
> 
> 
> On 08/27/2018 11:52 AM, jianchao.wang wrote:
>> Hi Jens
>>
>> On 08/25/2018 11:41 PM, Jens Axboe wrote:
>>>  	do {
>>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>>> +		if (test_bit(0, &data.flags))
>>> +			break;
>>>  
>>> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>>> +		WARN_ON_ONCE(list_empty(&data.wq.entry));
>>> +
>>> +		if (!has_sleeper &&
>>> +		    rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
>>> +			finish_wait(&rqw->wait, &data.wq);
>>> +
>>> +			/*
>>> +			 * We raced with wbt_wake_function() getting a token,
>>> +			 * which means we now have two. Put ours and wake
>>> +			 * anyone else potentially waiting for one.
>>> +			 */
>>> +			if (test_bit(0, &data.flags))
>>> +				wbt_rqw_done(rwb, rqw, wb_acct);
>>>  			break;
>>
>> Just use 'bool' variable should be OK 
>> After finish_wait, no one could race with us here.
>>
>>> +		}
>>>  
>>>  		if (lock) {
>>>  			spin_unlock_irq(lock);
>>> @@ -511,11 +569,11 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>>>  			spin_lock_irq(lock);
>>>  		} else
>>>  			io_schedule();
>>> +
>>>  		has_sleeper = false;
>>>  	} while (1);
>>
>> I cannot get the point of "since we can't rely on just being woken from the ->func handler
>> we set".
>> Do you mean there could be someone else could wake up this task ?

Yeah, you don't know for a fact that the wbt wait queue is the only
guy waking us up. Any sleep like this needs a loop. It was quite
easy to reproduce for me, and as expected, you'll get list corruption
on the wait queue since we leave it on the list and the stack goes
away.

> If we do need a recheck after the io_schedule, we could do as following:
> 
> static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
> 		       unsigned long rw, spinlock_t *lock)
> 	__releases(lock)
> 	__acquires(lock)
> {
> 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
> 	struct wbt_wait_data data = {
> 		.wq = {
> 			.func	= wbt_wake_function,
> 			.entry	= LIST_HEAD_INIT(data.wq.entry),
> 		},
> 		.curr = current,
> 		.rwb = rwb,
> 		.rqw = rqw,
> 		.rw = rw,
> 	};
> 	bool has_sleeper;
> 	bool got = false;
> 
> retry:
> 	has_sleeper = wq_has_sleeper(&rqw->wait);
> 	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> 		return;
> 
> 	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
> 
> 	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
> 		got = true;
> 		goto out;
> 	}
> 
> 	if (lock) {
> 		spin_unlock_irq(lock);
> 		io_schedule();
> 		spin_lock_irq(lock);
> 	} else
> 		io_schedule();
> 
> out:
> 	finish_wait(&rqw->wait, &data.wq);
> 
> 	/*
> 	 * We raced with wbt_wake_function() getting a token,
> 	 * which means we now have two. Put ours and wake
> 	 * anyone else potentially waiting for one.
> 	 */
> 	if (data.got && got)
> 		wbt_rqw_done(rwb, rqw, wb_acct);
> 	else if (!data.got && !got)
> 		goto retry;

I think the other variant is cleaner and easier to read. This is just
a natural loop, I don't think we need to use goto's here.

FWIW, I split it into two patches, current version is here:

http://git.kernel.dk/cgit/linux-block/log/?h=for-linus

-- 
Jens Axboe
