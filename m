Return-Path: <hch@lst.de>
Date: Thu, 2 Mar 2017 01:14:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Marc MERLIN <marc@merlins.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] blk-mq: Provide freeze queue timeout
Message-ID: <20170302001459.GA23070@lst.de>
References: <1488396132-11369-1-git-send-email-keith.busch@intel.com> <1488396132-11369-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488396132-11369-3-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

> +int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
> +				     unsigned long timeout)
> +{
> +	return wait_event_timeout(q->mq_freeze_wq,
> +					percpu_ref_is_zero(&q->q_usage_counter),
> +					timeout);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);

Can you just add the timeout argument to blk_mq_freeze_queue_wait?
Existing callers can pass 0, which is interpreted as no timeout by
the low-level wait code.
