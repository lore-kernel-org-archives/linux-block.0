Return-Path: <prvs=6236fbcb6=bart.vanassche@wdc.com>
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@fb.com
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
 <20180402190120.GD388343@devbig577.frc2.facebook.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
Date: Mon, 2 Apr 2018 14:08:37 -0700
MIME-Version: 1.0
In-Reply-To: <20180402190120.GD388343@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 04/02/18 12:01, Tejun Heo wrote:
> +	 * As nothing prevents from completion happening while
> +	 * ->aborted_gstate is set, this may lead to ignored completions
> +	 * and further spurious timeouts.
> +	 */
> +	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
> +		blk_mq_rq_update_aborted_gstate(rq, 0);

Hello Tejun,

Since this patch fixes one race but introduces another race, is this 
patch really an improvement?

Thanks,

Bart.
