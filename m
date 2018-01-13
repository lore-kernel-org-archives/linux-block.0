Return-Path: <bsingharora@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1513613712-571-1-git-send-email-joshs@netflix.com>
References: <20171218113426.vndsy2m5qhxrkesg@hirez.programming.kicks-ass.net> <1513613712-571-1-git-send-email-joshs@netflix.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sat, 13 Jan 2018 13:56:44 +0530
Message-ID: <CAKTCnzkojkc6g575EQ0FXaNsgRTeNWKHq__QNp6MUVBOuQw=hw@mail.gmail.com>
Subject: Re: [PATCH v2] delayacct: Account blkio completion on the correct task
To: Josh Snyder <joshs@netflix.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Brendan Gregg <bgregg@netflix.com>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@redhat.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Dec 18, 2017 at 9:45 PM, Josh Snyder <joshs@netflix.com> wrote:
> Before commit e33a9bba85a8 ("sched/core: move IO scheduling accounting from
> io_schedule_timeout() into scheduler"), delayacct_blkio_end was called after
> context-switching into the task which completed I/O. This resulted in double
> counting: the task would account a delay both waiting for I/O and for time
> spent in the runqueue.
>

Yes, we included the time spent in the runqueue to delays on account of I/O.

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
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
