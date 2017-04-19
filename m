Return-Path: <hch@lst.de>
Date: Wed, 19 Apr 2017 08:20:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Subject: Re: [PATCH 4/5] block: Inline blk_rq_set_prio()
Message-ID: <20170419062051.GD6412@lst.de>
References: <20170418231037.3968-1-bart.vanassche@sandisk.com> <20170418231037.3968-5-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170418231037.3968-5-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

> +	req->ioprio = ioprio_valid(bio_prio(bio)) ? bio_prio(bio) : ioc ?
> +		ioc->ioprio : IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);

I think this would be a tad cleaner with a traditional if / else if / else
chain, e.g.

	if (ioprio_valid(bio_prio(bio)))
		req->ioprio = bio_prio(bio);
	else if (ioc)
		req->ioprio = ioc->ioprio;
	else
		req->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);

But otherwise the patch looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
