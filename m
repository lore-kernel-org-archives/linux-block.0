Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 2 Apr 2018 14:10:47 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Message-ID: <20180402211047.GF388343@devbig577.frc2.facebook.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
 <20180402190120.GD388343@devbig577.frc2.facebook.com>
 <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 02, 2018 at 02:08:37PM -0700, Bart Van Assche wrote:
> On 04/02/18 12:01, Tejun Heo wrote:
> >+	 * As nothing prevents from completion happening while
> >+	 * ->aborted_gstate is set, this may lead to ignored completions
> >+	 * and further spurious timeouts.
> >+	 */
> >+	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
> >+		blk_mq_rq_update_aborted_gstate(rq, 0);
> 
> Hello Tejun,
> 
> Since this patch fixes one race but introduces another race, is this
> patch really an improvement?

Oh, that's not a new race.  That's the same non-critical race which
always existed.  It's just being documented.

Thanks.

-- 
tejun
