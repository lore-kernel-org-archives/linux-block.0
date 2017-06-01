Return-Path: <hch@lst.de>
Date: Thu, 1 Jun 2017 08:08:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Subject: Re: [PATCH v2 03/12] block: Make most scsi_req_init() calls
	implicit
Message-ID: <20170601060840.GF16248@lst.de>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com> <20170531225246.26261-4-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531225246.26261-4-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 03:52:37PM -0700, Bart Van Assche wrote:
> Instead of explicitly calling scsi_req_init() after blk_get_request(),
> call that function from inside blk_get_request(). Add an
> .initialize_rq_fn() callback function to the block drivers that need
> it. Merge the IDE .init_rq_fn() function into .initialize_rq_fn()
> because it is too small to keep it as a separate function. Keep the
> scsi_req_init() call in ide_prep_sense() because it follows a
> blk_rq_init() call.

Looks fine except for the method placement in the mq case mentioned
in the previous patch:

Reviewed-by: Christoph Hellwig <hch@lst.de>
