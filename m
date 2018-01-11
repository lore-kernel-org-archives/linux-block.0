Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jan 2018 10:04:05 -0800
From: Tejun Heo <tj@kernel.org>
To: Josh Snyder <joshs@netflix.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Brendan Gregg <bgregg@netflix.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Balbir Singh <bsingharora@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] delayacct: Account blkio completion on the correct
 task
Message-ID: <20180111180405.GJ3460072@devbig577.frc2.facebook.com>
References: <20171218113426.vndsy2m5qhxrkesg@hirez.programming.kicks-ass.net>
 <1513613712-571-1-git-send-email-joshs@netflix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513613712-571-1-git-send-email-joshs@netflix.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Dec 18, 2017 at 04:15:10PM +0000, Josh Snyder wrote:
> Before commit e33a9bba85a8 ("sched/core: move IO scheduling accounting from
> io_schedule_timeout() into scheduler"), delayacct_blkio_end was called after
> context-switching into the task which completed I/O. This resulted in double
> counting: the task would account a delay both waiting for I/O and for time
> spent in the runqueue.
> 
> With e33a9bba85a8, delayacct_blkio_end is called by try_to_wake_up. In
> ttwu, we have not yet context-switched. This is more correct, in that the
> delay accounting ends when the I/O is complete. But delayacct_blkio_end
> relies upon `get_current()`, and we have not yet context-switched into the
> task whose I/O completed. This results in the wrong task having its delay
> accounting statistics updated.
> 
> Instead of doing that, pass the task_struct being woken to
> delayacct_blkio_end, so that it can update the statistics of the correct
> task.
> 
> Fixes: e33a9bba85a8 ("sched/core: move IO scheduling accounting from io_schedule_timeout() into scheduler")
> Signed-off-by: Josh Snyder <joshs@netflix.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
