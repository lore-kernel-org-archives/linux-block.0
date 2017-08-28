Return-Path: <hch@lst.de>
Date: Mon, 28 Aug 2017 10:10:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] block: Call .initialize_rq_fn() also for filesystem
	requests
Message-ID: <20170828081017.GC2851@lst.de>
References: <20170825190057.15592-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170825190057.15592-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

I still disagree that we should have an indirect function call like this
in the fast path.

All that can be done by clearing or setting a flag on the first call to
->queue_rq or ->queuecommand instead.  In NVMe we use RQF_DONTPREP for
that, but for SCSI we probablt can't use that given that it has more
meaning for the old request path.  But how about just adding a new
RQD_DRV_INITIALIZED or similar flag?
