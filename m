Return-Path: <keith.busch@intel.com>
Date: Fri, 27 Jul 2018 10:46:28 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 5/5] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180727164627.GB20829@localhost.localdomain>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
 <20180727162042.13425-6-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180727162042.13425-6-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 27, 2018 at 09:20:42AM -0700, Bart Van Assche wrote:
> +	ret = req->q->mq_ops->timeout(req, reserved);
> +	/*
> +	 * BLK_EH_DONT_RESET_TIMER means that the block driver either
> +	 * completed the request or still owns the request and will
> +	 * continue processing the timeout asynchronously. In the
> +	 * latter case, if blk_mq_complete_request() was called while
> +	 * the timeout handler was in progress, ignore that call.
> +	 */
> +	if (ret == BLK_EH_DONT_RESET_TIMER)
> +		return;

This is how completions get lost.
