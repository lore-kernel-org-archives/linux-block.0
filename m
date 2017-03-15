Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 10/14] block, bfq: add Early Queue Merge (EQM)
To: Paolo Valente <paolo.valente@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <20170304160131.57366-11-paolo.valente@linaro.org>
 <d37a7169-f279-8244-19f8-440dc1490893@kernel.dk>
 <1D2EDF98-59BA-4A98-8251-9BEC4AC752C4@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org,
 Mauro Andreolini <mauro.andreolini@unimore.it>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fe98e76a-c4c6-dcd6-93c6-55cbbbc1db76@kernel.dk>
Date: Wed, 15 Mar 2017 09:47:41 -0600
MIME-Version: 1.0
In-Reply-To: <1D2EDF98-59BA-4A98-8251-9BEC4AC752C4@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/15/2017 06:01 AM, Paolo Valente wrote:
> 
>> Il giorno 07 mar 2017, alle ore 18:44, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 03/04/2017 09:01 AM, Paolo Valente wrote:
>>> @@ -560,6 +600,15 @@ struct bfq_data {
>>> 	struct bfq_io_cq *bio_bic;
>>> 	/* bfqq associated with the task issuing current bio for merging */
>>> 	struct bfq_queue *bio_bfqq;
>>> +
>>> +	/*
>>> +	 * io context to put right after bfqd->lock is released. This
>>> +	 * filed is used to perform put_io_context, when needed, to
>>> +	 * after the scheduler lock has been released, and thus
>>> +	 * prevent an ioc->lock from being possibly taken while the
>>> +	 * scheduler lock is being held.
>>> +	 */
>>> +	struct io_context *ioc_to_put;
>>> };
>>
>> The logic around this is nasty, effectively you end up having locking
>> around sections of code instea of structures, which is never a good
>> idea.
>>
>> The helper functions for unlocking and dropping the ioc add to the mess
>> as well.
>>
> 
> Hi Jens,
> fortunately I seem to have found and fixed the bug causing the failure
> your reported in one of your previous emails, so I've started addressing
> the issue you raise here.  But your suggestion below raised doubts
> that I was not able to solve.  So I'm bailing out and asking for help.

Great (on fixing that other bug).

>> Can't we simply pass back a pointer to an ioc to free? That should be
>> possible, given that we must have grabbed the bfqd lock ourselves
>> further up in the call chain. So we _know_ that we'll drop it later on.
>> If that wasn't the case, the existing logic wouldn't work.
>>
> 
> One of the two functions that discover that an ioc has to bee freed,
> namely __bfq_bfqd_reset_in_service, is invoked at the end of several
> relatively long chains of function invocations.  The heads of these
> chains take and release the scheduler lock.  One example is:
> 
> bfq_dispatch_request -> __bfq_dispatch_request -> bfq_select_queue -> bfq_bfqq_expire  -> __bfq_bfqq_expire -> __bfq_bfqd_reset_in_service
> 
> To implement your proposal, all the functions involved in these chains
> should be extended to pass back the ioc to put.  The resulting, heavy
> version of the code seems really unadvisable, and prone to errors when
> one modifies or adds some chain.
> 
> So I have certainly misunderstood something.  As usual, to help you
> help me more quickly, here is a summary of what I have understood on
> this matter.
> 
> 1.  For similar, if not exactly the same, lock-nesting issue related
> to io-context putting, deferred work is used.  Probably deferred work
> is used also for other reasons, but for sure it does solve this issue too.
> 
> 2.  My solution (which I'm not defending; I'm just trying to
> understand) solves the same issue as above: put the io
> context after the other lock is released.  But it solves it with no
> work-queueing overhead.  Instead of queueing work, it 'queues' the ioc
> to put, and puts it right after releasing the scheduler lock.
> 
> Where is my mistake?  And what is the correct interpretation of your
> proposal to pass back the pointer (instead of storing it in a field of
> the device data structure)?

I think you understood me correctly. Currently I think the putting of
the io context is somewhat of a mess. You have seemingly random places
where you have to use special unlock functions, to ensure that you
notice that some caller deeper down has set ->ioc_to_put. I took a quick
look at it, and by far most of the cases can return an io_context to
free quite easily. You can mark these functions __must_check to ensure
that we don't drop an io_context, inadvertently. That's already a win
over the random ->ioc_to_put store. And you can then get rid of
bfq_unlock_put_ioc and it's irq variant as well.

The places where you are already returning a value, like off dispatch
for instance, you can just pass in a pointer to an io_context pointer.

If you get this right, it'll be a lot less fragile and hacky than your
current approach.

I'd avoid having to do deferred put from a workqueue at all costs. This
is an _expensive_ operation.

-- 
Jens Axboe
