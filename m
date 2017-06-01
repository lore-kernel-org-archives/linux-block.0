Return-Path: <hch@lst.de>
Date: Thu, 1 Jun 2017 08:10:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 08/12] block: Document what queue type each function
	is intended for
Message-ID: <20170601061012.GI16248@lst.de>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com> <20170531225246.26261-9-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531225246.26261-9-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 03:52:42PM -0700, Bart Van Assche wrote:
> Some functions in block/blk-core.c must only be used on blk-sq queues
> while others are safe to use against any queue type. Document which
> functions are intended for blk-sq queues and issue a warning if the
> blk-sq API is misused.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
