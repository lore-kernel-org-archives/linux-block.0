Return-Path: <hch@lst.de>
Date: Sun, 28 May 2017 10:38:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 09/19] block: Make scsi_req_init() calls implicit
Message-ID: <20170528083844.GD13083@lst.de>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com> <20170525184327.23570-10-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525184327.23570-10-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 25, 2017 at 11:43:17AM -0700, Bart Van Assche wrote:
> Instead of explicitly calling scsi_req_init(), let
> blk_get_request() call that function from inside blk_rq_init().
> Add an .initialize_rq_fn() callback function to the block drivers
> that need it. Merge the IDE .init_rq_fn() function into
> .initialize_rq_fn() because it is too small to keep it as a
> separate function.

That won't work if we don't call initialize_rq_fn from the fast path.

Except for that the idea is great and I like it.
