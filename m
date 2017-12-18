Return-Path: <peterz@infradead.org>
Date: Mon, 18 Dec 2017 12:34:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Snyder <joshs@netflix.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Brendan Gregg <bgregg@netflix.com>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Balbir Singh <bsingharora@gmail.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] Pass the task_struct explicitly to delayacct_blkio_end
Message-ID: <20171218113426.vndsy2m5qhxrkesg@hirez.programming.kicks-ass.net>
References: <1513361505-275-1-git-send-email-joshs@netflix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513361505-275-1-git-send-email-joshs@netflix.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 15, 2017 at 06:11:43PM +0000, Josh Snyder wrote:

> Subject: [PATCH] Pass the task_struct explicitly to delayacct_blkio_end

That subject is crap; it needs a subsystem prefix and it needs to
describe what is done, not how its done.

Something like:

  delayacct: Fix double accounting for blk-io

> Before e33a9bba85a8, delayacct_blkio_end was called after
> context-switching into the task which completed I/O. This resulted in
> double counting: the task would account a delay both waiting for I/O and
> for time spent in the runqueue.
> 
> With e33a9bba85a8, delayacct_blkio_end is called by try_to_wake_up. In
> ttwu, we have not yet context-switched. This is more correct, in that the
> delay accounting ends when the I/O is complete. But delayacct_blkio_end
> relies upon `get_current()`, and we have not yet context-switched into the
> task whose I/O completed. This results in the wrong task having its delay
> accounting statistics updated.

The correct way to quote a commit is like:

  e33a9bba85a8 ("sched/core: move IO scheduling accounting from io_schedule_timeout() into scheduler")

> Instead of doing that, pass the task_struct being woken to
> delayacct_blkio_end, so that it can update the statistics of the correct
> task_struct.
