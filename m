Return-Path: <hch@lst.de>
Date: Sun, 28 May 2017 10:39:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 10/19] blk-mq: Change blk_mq_hw_ctx.queue_rq_srcu into
	an array
Message-ID: <20170528083946.GE13083@lst.de>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com> <20170525184327.23570-11-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525184327.23570-11-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

I think starting from here thing should be in a different series..

On Thu, May 25, 2017 at 11:43:18AM -0700, Bart Van Assche wrote:
> This patch does not change any functionality but makes the next
> patch easier to read.

I think merging the two would be better.  But except for that this
looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
