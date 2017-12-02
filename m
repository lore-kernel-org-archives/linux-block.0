Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] block, bfq: remove batches of confusing ifdefs
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <a64f4962-8736-75df-71ae-509342b0be8a@kernel.dk>
Date: Sat, 2 Dec 2017 18:22:33 +0100
Cc: linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 broonie@kernel.org,
 linus.walleij@linaro.org,
 lucmiccio@gmail.com,
 bfq-iosched@googlegroups.com
Message-Id: <8B7D21FA-155B-4311-8C12-7C520BE78EFE@linaro.org>
References: <20171128093734.1918-1-paolo.valente@linaro.org> <5892a41d-4677-937a-a56e-5d4554724dd6@kernel.dk> <5B4C446D-99EB-4698-B86A-5629AADA3D7B@linaro.org> <a64f4962-8736-75df-71ae-509342b0be8a@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 02 dic 2017, alle ore 17:06, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 12/02/2017 03:04 AM, Paolo Valente wrote:
>>=20
>>> Il giorno 30 nov 2017, alle ore 22:21, Jens Axboe <axboe@kernel.dk> =
ha scritto:
>>>=20
>>> On 11/28/2017 02:37 AM, Paolo Valente wrote:
>>>> Commit a33801e8b473 ("block, bfq: move debug blkio stats behind
>>>> CONFIG_DEBUG_BLK_CGROUP") introduced two batches of confusing =
ifdefs:
>>>> one reported in [1], plus a similar one in another function. This
>>>> commit removes both batches, in the way suggested in [1].
>>>=20
>>> Some comments below.
>>>=20
>>>> +static inline void bfq_update_dispatch_stats(struct request *rq,
>>>> +					     spinlock_t *queue_lock,
>>>> +					     struct bfq_queue =
*in_serv_queue,
>>>> +					     bool idle_timer_disabled)
>>>> +{
>>>=20
>>> Don't pass in the queue lock. The normal convention is to pass in =
the
>>> queue, thus making this:
>>>=20
>>> static void bfq_update_dispatch_stats(struct request_queue *q,
>>> 				      struct request *rq,
>>> 				      struct bfq_queue *in_serv_queue,
>>> 				      bool idle_timer_disabled)
>>>=20
>>=20
>> Ok, thanks.  One question, just to try to learn, if you have time and
>> patience for a brief explanation.  Was this convention originated by
>> some rationale?  My concern is that bfq_update_dispatch_stats works =
on
>> no field of q but the lock, and this fact would have been made
>> explicit by passing only that exact field.
>=20
> When you just pass in a lock, nobody knows what that lock is without
> looking at the caller. If you pass in the queue, it's apparent
> what is being locked.
>=20

Got it, thanks a lot.

>>> which also gets rid of the inline. In general, never inline =
anything.
>>> The compiler should figure it out for you. This function is way too =
big
>>> to inline, plus the cost of what it's doing completely dwarfes =
function
>>> call overhead.
>>>=20
>>=20
>> Actually, I did so because of Linus' suggestion in [1]: "So for
>> example, the functions that can go away should obviously be inline
>> functions so that you don't end up having the compiler generate the
>> arguments and the call to an empty function body ..."
>>=20
>> Maybe I misinterpreted his suggestion, and he meant that the function
>> should be designed in such a way to be (almost) certainly considered
>> inline by the compiler?
>=20
> You can do that for the empty version, don't do it for the non-empty
> version. That will go away, the other one will not.
>=20

Of course, thanks, and sorry for the silly question.

I'll make and submit a new patch according to your comments.

Paolo

> --=20
> Jens Axboe
