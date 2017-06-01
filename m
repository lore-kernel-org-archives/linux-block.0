Return-Path: <hch@lst.de>
Date: Thu, 1 Jun 2017 08:11:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 09/12] blk-mq: Document locking assumptions
Message-ID: <20170601061100.GJ16248@lst.de>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com> <20170531225246.26261-10-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531225246.26261-10-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 03:52:43PM -0700, Bart Van Assche wrote:
> Document the locking assumptions in functions that modify
> blk_mq_ctx.rq_list to make it easier for humans to verify
> this code.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
