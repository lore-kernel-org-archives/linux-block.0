Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] cfq: priority boost on meta/prio marked IO
References: <20160608204347.GA30146@kernel.dk>
	<x49k2hyz78z.fsf@segfault.boston.devel.redhat.com>
	<57599734.40607@kernel.dk>
Date: Thu, 09 Jun 2016 14:31:39 -0400
In-Reply-To: <57599734.40607@kernel.dk> (Jens Axboe's message of "Thu, 9 Jun
	2016 10:20:04 -0600")
Message-ID: <x49y46exlh0.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

> On 06/09/2016 09:55 AM, Jeff Moyer wrote:
>> Hi, Jens,
>>
>> Jens Axboe <axboe@fb.com> writes:
>>
>>> At Facebook, we have a number of cases where people use ionice to set a
>>> lower priority, then end up having tasks stuck for a long time because
>>> eg meta data updates from an idle priority tasks is blocking out higher
>>> priority processes. It's bad enough that it will trigger the softlockup
>>> warning.
>>
>> I expect a higher prio process could be blocked on a lower prio process
>> reading the same metadata, too.  I had a hard time tracking down where
>> REQ_META WRITE I/O was issued outside of the journal or writeback paths
>> (and I hope you're not ionice-ing those!).  Eventually, with the help of
>> sandeen, I found some oddball cases that I doubt you're running into.
>> Can you enlighten me as to where this (REQ_META write I/O) is happening?
>> I don't disagree that it's a problem, I just would like to understand
>> your problem case better.
>>
>> Anyway, it seems to me you could just set REQ_PRIO in the code paths you
>> care about instead of modifying CFQ to treat REQ_META and REQ_PRIO as
>> the same thing, which essentially undoes commit 65299a3b788bd ("block:
>> separate priority boosting from REQ_META") from Christoph.
>
> I personally don't care too much about boosting for just PRIO, or for
> both PRIO and META. For the important paths, we basically have both set
> anyway.

Yeah, I had considered that.  I like that REQ_META is separated out for
logging purposes.  I'm not too concerned about whether we imply boosted
priority from that or not.

> These are reads.

I was curious about writes.  ;-)  Anyway, it's good to validate that the
read case is also relevant.

> It's a classic case of starting some operation that ends up holding a
> file system resource, then making very slow progress (due to task
> being scheduled as idle IO), and hence blocking out potentially much
> important tasks.
>
> The IO is marked META|PRIO, so if folks don't [care] for boosting on meta,
> we can just kill that. "Normal" meta data could be scheduled as idle,
> but anything scheduled under a fs lock or similar should be marked PRIO
> and get boosted.

Interesting.  I would have thought that the cfqd->active_queue would
have been preempted by a request marked with REQ_PRIO.  But you're
suggesting that did not happen?

Specifically, cfq_insert_request would call cfq_rq_enqueued, and that
would call cfq_preempt_queue if cfq_should_preempt (and I think it
should, since the new request has REQ_PRIO set).

Cheers,
Jeff
