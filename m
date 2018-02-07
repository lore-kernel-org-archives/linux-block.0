Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2018 09:06:12 -0800
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180207170612.GB695913@devbig577.frc2.facebook.com>
References: <20180207011133.25957-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180207011133.25957-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Tue, Feb 06, 2018 at 05:11:33PM -0800, Bart Van Assche wrote:
> The following race can occur between the code that resets the timer
> and completion handling:
> - The code that handles BLK_EH_RESET_TIMER resets aborted_gstate.
> - A completion occurs and blk_mq_complete_request() calls
>   __blk_mq_complete_request().
> - The timeout code calls blk_add_timer() and that function sets the
>   request deadline and adjusts the timer.
> - __blk_mq_complete_request() frees the request tag.
> - The timer fires and the timeout handler gets called for a freed
>   request.

Can you see whether by any chance the following patch fixes the issue?
If not, can you share the repro case?

Thanks.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102..651d18c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -836,8 +836,8 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		 * ->aborted_gstate is set, this may lead to ignored
 		 * completions and further spurious timeouts.
 		 */
-		blk_mq_rq_update_aborted_gstate(req, 0);
 		blk_add_timer(req);
+		blk_mq_rq_update_aborted_gstate(req, 0);
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
