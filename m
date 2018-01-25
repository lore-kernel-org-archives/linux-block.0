Return-Path: <viro@ftp.linux.org.uk>
Date: Thu, 25 Jan 2018 04:16:05 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: blk-mq-sched: Replace GFP_ATOMIC with GFP_KERNEL
 in blk_mq_sched_assign_ioc
Message-ID: <20180125041605.GV13338@ZenIV.linux.org.uk>
References: <1516848386-5720-1-git-send-email-baijiaju1990@gmail.com>
 <20180125025811.GT13338@ZenIV.linux.org.uk>
 <70efc238-9517-7cfa-03ce-ba9c3ba0ebd4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <70efc238-9517-7cfa-03ce-ba9c3ba0ebd4@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 25, 2018 at 11:13:56AM +0800, Jia-Ju Bai wrote:

> I have checked the given call chain, and find that nvme_dev_disable in
> nvme_timeout calls mutex_lock that can sleep.
> Thus, I suppose this call chain is not in atomic context.

... or it is broken.

> Besides, how do you find that "function (nvme_timeout()) strongly suggests
> that it *is* meant to be called from bloody atomic context"?
> I check the comments in nvme_timeout, and do not find related description...

Anything that reads registers for controller state presumably won't be
happy if it can happen in parallel with other threads poking the same
hardware.  Not 100% guaranteed, but it's a fairly strong sign that there's
some kind of exclusion between whatever's submitting requests / handling
interrupts and the caller of that thing.  And such exclusion is likely
to be spin_lock_irqsave()-based.

Again, that does not _prove_ it's called from atomic contexts, but does
suggest such possibility.

Looking through the callers of that method, blk_abort_request() certainly
*is* called from under queue lock.  Different drivers, though.  No idea
if nvme_timeout() blocking case is broken - I'm not familiar with that
code.  Question should go to nvme maintainers...

However, digging through other call chains, there's this:
drivers/md/dm-mpath.c:530:      clone = blk_get_request(q, rq->cmd_flags | REQ_NOMERGE, GFP_ATOMIC);
in multipath_clone_and_map(), aka. ->clone_and_map_rq(), called at
drivers/md/dm-rq.c:480: r = ti->type->clone_and_map_rq(ti, rq, &tio->info, &clone);
in map_request(), which is called from dm_mq_queue_rq(), aka ->queue_rq(),
which is called from blk_mq_dispatch_rq_list(), called from
blk_mq_do_dispatch_sched(), called from blk_mq_sched_dispatch_requests(),
called under rcu_read_lock().  Not a context where you want GFP_KERNEL
allocations...

> By the way, do you mean that I should add "My tool has proved that this
> function is never called in atomic context" in the description?

I mean that proof itself should be at least outlined.  Crediting the tool
for finding the proof is fine *IF* it's done along wiht the proof itself.

You want to convince the people applying the patch that it is correct.
Leaving out something trivial to verify is fine - "foo_bar_baz() has
no callers" doesn't require grep output + quoting the area around each
instance to prove that all of them are in the comments, etc.; readers
can bloody well check the accuracy of that claim themselves.  This
kind of analysis, however, is decidedly *NOT* trivial to verify from
scratch.

Moreover, if what you've proven is that for each call chain leading
to that place there's a blocking operation nearby, there is still
a possibility that some of those *are* called while in non-blocking
context.  In that case you've found real bugs, and strictly speaking
your change doesn't break correct code.  However, it does not make
the change itself correct - if you have something like
	enter non-blocking section
	.....
	in very unusual cases grab a mutex (or panic, or...)
	.....
	do GFP_ATOMIC allocation
	.....
	leave non-blocking section
changing that to GFP_KERNEL will turn "we deadlock in very hard to
hit case" into "we deadlock easily"...

At the very least, I'd like to see those cutoffs - i.e. the places
that already could block on the callchains.  You might very well
have found actual bugs there.
