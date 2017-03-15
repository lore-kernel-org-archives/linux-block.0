Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 10/14] block, bfq: add Early Queue Merge (EQM)
To: Paolo Valente <paolo.valente@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <20170304160131.57366-11-paolo.valente@linaro.org>
 <d37a7169-f279-8244-19f8-440dc1490893@kernel.dk>
 <1D2EDF98-59BA-4A98-8251-9BEC4AC752C4@linaro.org>
 <fe98e76a-c4c6-dcd6-93c6-55cbbbc1db76@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org,
 Mauro Andreolini <mauro.andreolini@unimore.it>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7b7c0d4c-c10d-1e69-4ea0-1ad05a4100a2@kernel.dk>
Date: Wed, 15 Mar 2017 10:30:33 -0600
MIME-Version: 1.0
In-Reply-To: <fe98e76a-c4c6-dcd6-93c6-55cbbbc1db76@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/15/2017 09:47 AM, Jens Axboe wrote:
> I think you understood me correctly. Currently I think the putting of
> the io context is somewhat of a mess. You have seemingly random places
> where you have to use special unlock functions, to ensure that you
> notice that some caller deeper down has set ->ioc_to_put. I took a quick
> look at it, and by far most of the cases can return an io_context to
> free quite easily. You can mark these functions __must_check to ensure
> that we don't drop an io_context, inadvertently. That's already a win
> over the random ->ioc_to_put store. And you can then get rid of
> bfq_unlock_put_ioc and it's irq variant as well.
> 
> The places where you are already returning a value, like off dispatch
> for instance, you can just pass in a pointer to an io_context pointer.
> 
> If you get this right, it'll be a lot less fragile and hacky than your
> current approach.

Even just looking a little closer, you also find cases where you
potentially twice store ->ioc_to_put. That kind of mixup can't happen if
you return it properly.

In __bfq_dispatch_request(), for instance. You call bfq_select_queue(),
and that in turn calls bfq_bfqq_expire(), which calls
__bfq_bfqq_expire() which can set ->ioc_to_put. But later on,
__bfq_dispatch_request() calls bfq_dispatch_rq_from_bfqq(), which in
turn calls bfq_bfqq_expire() that can also set ->ioc_to_put. There's no
"magic" bfq_unlock_and_put_ioc() in-between those. Maybe the former call
never sets ->ioc_to_put if it returns with bfqq == NULL? Hard to tell.

Or __bfq_insert_request(), it calls bfq_add_request(), which may set
->ioc_to_put through bfq_bfqq_handle_idle_busy_switch() ->
bfq_bfqq_expire(). And then from calling bfq_rq_enqueued() ->
bfq_bfqq_expire().

There might be more, but I think the above is plenty of evidence that
the current ->ioc_to_put solution is a bad hack, fragile, and already
has bugs.

How often do you expect this putting of the io_context to happen? If
it's not a very frequent occurence, maybe using a deferred workqueue to
put it IS the right solution. As it currently stands, the code doesn't
really work, and it's fragile. It can't be cleaned up without
refactoring, since the call paths are all extremely intermingled.

-- 
Jens Axboe
