Return-Path: <keith.busch@intel.com>
Date: Fri, 27 Jul 2018 10:29:25 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/5] block: Split blk_add_timer()
Message-ID: <20180727162925.GA20829@localhost.localdomain>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
 <20180727162042.13425-4-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180727162042.13425-4-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 27, 2018 at 09:20:40AM -0700, Bart Van Assche wrote:
> +void blk_mq_add_timer(struct request *req)
> +{
> +	struct request_queue *q = req->q;
> +
> +	if (!q->mq_ops)
> +		lockdep_assert_held(q->queue_lock);
> +
> +	/* blk-mq has its own handler, so we don't need ->rq_timed_out_fn */
> +	if (!q->mq_ops && !q->rq_timed_out_fn)
> +		return;

<snip>

> +	if (!q->mq_ops)
> +		list_add_tail(&req->timeout_list, &req->q->timeout_list);

Do you really need these checks for !q->mq_ops?
