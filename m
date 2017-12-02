Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block, bfq: remove batches of confusing ifdefs
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, broonie@kernel.org,
 linus.walleij@linaro.org, lucmiccio@gmail.com, bfq-iosched@googlegroups.com
References: <20171128093734.1918-1-paolo.valente@linaro.org>
 <5892a41d-4677-937a-a56e-5d4554724dd6@kernel.dk>
 <5B4C446D-99EB-4698-B86A-5629AADA3D7B@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a64f4962-8736-75df-71ae-509342b0be8a@kernel.dk>
Date: Sat, 2 Dec 2017 09:06:18 -0700
MIME-Version: 1.0
In-Reply-To: <5B4C446D-99EB-4698-B86A-5629AADA3D7B@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/02/2017 03:04 AM, Paolo Valente wrote:
> 
>> Il giorno 30 nov 2017, alle ore 22:21, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 11/28/2017 02:37 AM, Paolo Valente wrote:
>>> Commit a33801e8b473 ("block, bfq: move debug blkio stats behind
>>> CONFIG_DEBUG_BLK_CGROUP") introduced two batches of confusing ifdefs:
>>> one reported in [1], plus a similar one in another function. This
>>> commit removes both batches, in the way suggested in [1].
>>
>> Some comments below.
>>
>>> +static inline void bfq_update_dispatch_stats(struct request *rq,
>>> +					     spinlock_t *queue_lock,
>>> +					     struct bfq_queue *in_serv_queue,
>>> +					     bool idle_timer_disabled)
>>> +{
>>
>> Don't pass in the queue lock. The normal convention is to pass in the
>> queue, thus making this:
>>
>> static void bfq_update_dispatch_stats(struct request_queue *q,
>> 				      struct request *rq,
>> 				      struct bfq_queue *in_serv_queue,
>> 				      bool idle_timer_disabled)
>>
> 
> Ok, thanks.  One question, just to try to learn, if you have time and
> patience for a brief explanation.  Was this convention originated by
> some rationale?  My concern is that bfq_update_dispatch_stats works on
> no field of q but the lock, and this fact would have been made
> explicit by passing only that exact field.

When you just pass in a lock, nobody knows what that lock is without
looking at the caller. If you pass in the queue, it's apparent
what is being locked.

>> which also gets rid of the inline. In general, never inline anything.
>> The compiler should figure it out for you. This function is way too big
>> to inline, plus the cost of what it's doing completely dwarfes function
>> call overhead.
>>
> 
> Actually, I did so because of Linus' suggestion in [1]: "So for
> example, the functions that can go away should obviously be inline
> functions so that you don't end up having the compiler generate the
> arguments and the call to an empty function body ..."
> 
> Maybe I misinterpreted his suggestion, and he meant that the function
> should be designed in such a way to be (almost) certainly considered
> inline by the compiler?

You can do that for the empty version, don't do it for the non-empty
version. That will go away, the other one will not.

-- 
Jens Axboe
