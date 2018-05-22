Return-Path: <keith.busch@intel.com>
Date: Tue, 22 May 2018 14:33:49 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180522203349.GB8961@localhost.localdomain>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522162515.20650-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 09:25:15AM -0700, Bart Van Assche wrote:
> @@ -848,13 +843,22 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  	case BLK_EH_RESET_TIMER:
> +		blk_mq_add_timer(req);
>  		/*
> +		 * The loop is for the unlikely case of a race with the
> +		 * completion code. There is no need to reset the deadline
> +		 * if the transition to the in-flight state fails because
> +		 * the deadline only matters in the in-flight state.
>  		 */
> -		blk_mq_rq_update_aborted_gstate(req, 0);
> -		blk_add_timer(req);
> +		while (true) {
> +			if (blk_mq_change_rq_state(req, MQ_RQ_TIMED_OUT,
> +						   MQ_RQ_IN_FLIGHT))
> +				break;
> +			if (blk_mq_rq_state(req) == MQ_RQ_COMPLETE) {
> +				__blk_mq_complete_request(req);
> +				break;
> +			}
> +		}

I'm having some trouble triggering this case where the state is already
MQ_RQ_COMPLETE, so I'm just trying to figure this out through inspection.

It looks like the new blk_mq_complete_request() already called
__blk_mq_complete_request() when it gets the state to MQ_RQ_COMPLETE,
so doing that again completes it a second time.
