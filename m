Return-Path: <hch@lst.de>
Date: Thu, 1 Jun 2017 08:06:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2 02/12] block: Introduce
	request_queue.initialize_rq_fn()
Message-ID: <20170601060645.GD16248@lst.de>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com> <20170531225246.26261-3-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531225246.26261-3-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 03:52:36PM -0700, Bart Van Assche wrote:
> Several block drivers need to initialize the driver-private data
> after having called blk_get_request() and before .prep_rq_fn() is
> called, e.g. when submitting a REQ_OP_SCSI_* request. Avoid that
> that initialization code has to be repeated after every
> blk_get_request() call by adding a new callback function to struct
> request_queue.

Can we please still have a initialize_rq mq_op for the blk-mq path
to avoid using the operation vectors directly in the requeuest_queue
for blk-mq?
