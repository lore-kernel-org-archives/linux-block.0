Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] cfq: priority boost on meta/prio marked IO
References: <20160608204347.GA30146@kernel.dk>
	<x49k2hyz78z.fsf@segfault.boston.devel.redhat.com>
	<57599734.40607@kernel.dk>
	<x49y46exlh0.fsf@segfault.boston.devel.redhat.com>
	<5759CE16.905@kernel.dk>
Date: Thu, 09 Jun 2016 17:08:02 -0400
In-Reply-To: <5759CE16.905@kernel.dk> (Jens Axboe's message of "Thu, 9 Jun
	2016 14:14:14 -0600")
Message-ID: <x497fdyxe8d.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

>> I was curious about writes.  ;-)  Anyway, it's good to validate that the
>> read case is also relevant.
>
> You mean O_DIRECT writes? Most of the buffered writes will come out of
> the associated threads, so I don't think it's a big of an issue
> there. We've only seen it for reads.

Well, you had me confused with your initial report:

"... because eg meta data updates..."

So I assumed that meant REQ_META WRITES.  My bad.

[snip]

>> Interesting.  I would have thought that the cfqd->active_queue would
>> have been preempted by a request marked with REQ_PRIO.  But you're
>> suggesting that did not happen?

[snip]

> We seem to handily mostly ignore prio_pending for the idle class. If

Right, I forgot we were talking about idle class.  Sorry.

> the new queue is idle, then we don't look at prio pending. I'd rather
> make this more explicit, the patch is pretty similar to what we had in
> the past. It's somewhat of a regression caused by commit 4aede84b33d,
> except I like using the request flags for this a lot more than the old
> current->fs_excl. REQ_PRIO should always be set for cases where we
> hold fs (or even directory) specific resources.

Ah, thanks for the reference!  Now I'll go back and finish reviewing the
actual patch.

-Jeff
