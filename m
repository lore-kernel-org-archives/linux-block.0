Subject: Re: [PATCH v2] blk-mq-sched: separate mark hctx and queue restart
 operations
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <0ec9b1167d22966cdf77a1d5140499493ea888a2.1486408944.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <182de41f-33d3-bbf8-c591-9e577b0f1762@fb.com>
Date: Mon, 6 Feb 2017 12:39:57 -0700
MIME-Version: 1.0
In-Reply-To: <0ec9b1167d22966cdf77a1d5140499493ea888a2.1486408944.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/06/2017 12:24 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In blk_mq_sched_dispatch_requests(), we call blk_mq_sched_mark_restart()
> after we dispatch requests left over on our hardware queue dispatch
> list. This is so we'll go back and dispatch requests from the scheduler.
> In this case, it's only necessary to restart the hardware queue that we
> are running; there's no reason to run other hardware queues just because
> we are using shared tags.
> 
> So, split out blk_mq_sched_mark_restart() into two operations, one for
> just the hardware queue and one for the whole request queue. The core
> code uses both, and I/O schedulers may also want to use them.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Patch based on block/for-next.
> 
>  block/blk-mq-sched.c |  2 +-
>  block/blk-mq-sched.h | 25 ++++++++++++++++++-------
>  block/blk-mq.c       |  5 ++++-
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index ee455e7cf9d8..7538565359ea 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -201,7 +201,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	 * needing a restart in that case.
>  	 */
>  	if (!list_empty(&rq_list)) {
> -		blk_mq_sched_mark_restart(hctx);
> +		blk_mq_sched_mark_restart_hctx(hctx);
>  		blk_mq_dispatch_rq_list(hctx, &rq_list);

What if we dispatched nothing on this hardware queue, and it currently
doesn't have any IO pending?

-- 
Jens Axboe
