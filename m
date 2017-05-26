Return-Path: <hch@lst.de>
Date: Fri, 26 May 2017 08:34:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 08/19] block: Introduce request_queue.initialize_rq_fn()
Message-ID: <20170526063430.GA19034@lst.de>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com> <20170525184327.23570-9-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525184327.23570-9-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 25, 2017 at 11:43:16AM -0700, Bart Van Assche wrote:
> Several block drivers need to initialize the driver-private data
> after having called blk_get_request() and before .prep_rq_fn() is
> called, e.g. when submitting a REQ_OP_SCSI_* request. Avoid that
> that initialization code has to be repeated after every
> blk_get_request() call by adding a new callback function to struct
> request_queue.

I still think we should do this at the end of blk_mq_alloc_request /
blk_old_get_request to exactly keep the old semantics and keep the
calls out of the hot path.
