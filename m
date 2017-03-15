Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 10/14] block, bfq: add Early Queue Merge (EQM)
To: Paolo Valente <paolo.valente@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <20170304160131.57366-11-paolo.valente@linaro.org>
 <d37a7169-f279-8244-19f8-440dc1490893@kernel.dk>
 <1D2EDF98-59BA-4A98-8251-9BEC4AC752C4@linaro.org>
 <fe98e76a-c4c6-dcd6-93c6-55cbbbc1db76@kernel.dk>
 <7b7c0d4c-c10d-1e69-4ea0-1ad05a4100a2@kernel.dk>
 <2086B143-E8E3-43AD-B074-771378579081@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org,
 Mauro Andreolini <mauro.andreolini@unimore.it>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d41a304a-b863-5ea7-29ec-8c5a2ea5bbef@kernel.dk>
Date: Wed, 15 Mar 2017 15:00:42 -0600
MIME-Version: 1.0
In-Reply-To: <2086B143-E8E3-43AD-B074-771378579081@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/15/2017 10:59 AM, Paolo Valente wrote:
> 
>> Il giorno 15 mar 2017, alle ore 17:30, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 03/15/2017 09:47 AM, Jens Axboe wrote:
>>> I think you understood me correctly. Currently I think the putting of
>>> the io context is somewhat of a mess. You have seemingly random places
>>> where you have to use special unlock functions, to ensure that you
>>> notice that some caller deeper down has set ->ioc_to_put. I took a quick
>>> look at it, and by far most of the cases can return an io_context to
>>> free quite easily. You can mark these functions __must_check to ensure
>>> that we don't drop an io_context, inadvertently. That's already a win
>>> over the random ->ioc_to_put store. And you can then get rid of
>>> bfq_unlock_put_ioc and it's irq variant as well.
>>>
>>> The places where you are already returning a value, like off dispatch
>>> for instance, you can just pass in a pointer to an io_context pointer.
>>>
>>> If you get this right, it'll be a lot less fragile and hacky than your
>>> current approach.
>>
>> Even just looking a little closer, you also find cases where you
>> potentially twice store ->ioc_to_put. That kind of mixup can't happen if
>> you return it properly.
>>
>> In __bfq_dispatch_request(), for instance. You call bfq_select_queue(),
>> and that in turn calls bfq_bfqq_expire(), which calls
>> __bfq_bfqq_expire() which can set ->ioc_to_put. But later on,
>> __bfq_dispatch_request() calls bfq_dispatch_rq_from_bfqq(), which in
>> turn calls bfq_bfqq_expire() that can also set ->ioc_to_put. There's no
>> "magic" bfq_unlock_and_put_ioc() in-between those. Maybe the former call
>> never sets ->ioc_to_put if it returns with bfqq == NULL? Hard to tell.
>>
>> Or __bfq_insert_request(), it calls bfq_add_request(), which may set
>> ->ioc_to_put through bfq_bfqq_handle_idle_busy_switch() ->
>> bfq_bfqq_expire(). And then from calling bfq_rq_enqueued() ->
>> bfq_bfqq_expire().
>>
> 
> I have checked that.  Basically, since a queue can't be expired twice,
> then it should never happen that ioc_to_put is set twice before being
> used.  Yet, I do agree that using a shared field and exploiting
> collateral effects makes code very complex and fragile (maybe even
> buggy if my speculative check is wrong).  Just, it has been the best
> solution I found, to avoid deferred work as you asked.  In fact, I
> still find quite heavy the alternative of passing a pointer to an ioc
> forth and back across seven or eight nested functions.

It's not heavy at all, I went through all of it this morning. It's not
super pretty either, since you end up passing back an io_context which
is seemingly unrelated to what the functions otherwise do. But that's
mostly a reflection of the implementation, not that it's a bad way to go
about this in general. The worst bits are the places where you want to
add a

	WARN_ON(ret != NULL);

between two calls that potentially both drop the ioc. In terms of
overhead, it's not heavy. Punting to a workqueue would be orders of
magnitude more expensive.

>> There might be more, but I think the above is plenty of evidence that
>> the current ->ioc_to_put solution is a bad hack, fragile, and already
>> has bugs.
>>
>> How often do you expect this putting of the io_context to happen?
> 
> Unfortunately often, as it must be done also every time the in-service
> queue is reset.  But, in this respect, are we sure that we do need to
> grab a reference to the ioc when we set a queue in service (as done in
> cfq, and copied into bfq)?  I mean, we have the hook exit_ioc for
> controlling the disappearing of an ioc.  Am I missing something here
> too?

No, in fact that'd be perfectly fine. It's easier for CFQ to just retain
the reference so we know it's not going away, but for your case, it
might in fact make more sense to simply be able to de-service a queue if
the process exits. And if you do that, we can drop all this passing back
of ioc (or ->ioc_to_put) craziness, without having to punt to a
workqueue either.

This will be more efficient too, since it'll be a much more rare
occurence.

-- 
Jens Axboe
