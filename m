Return-Path: <hch@lst.de>
Date: Mon, 23 Jul 2018 10:09:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH 1/2] blk-mq: export setting request completion state
Message-ID: <20180723080941.GA19247@lst.de>
References: <20180719212618.2406-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719212618.2406-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

> +/*
> + * Returns true if request was not in flight.
> + */
> +static inline bool blk_mq_mark_complete(struct request *rq)
> +{
> +	return (cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) !=
> +			MQ_RQ_IN_FLIGHT);
> +}

This needs a much better comment describing when and how to use it.

Also the outer braces in the return statement are not required.
