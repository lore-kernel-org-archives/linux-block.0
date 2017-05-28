Return-Path: <hch@lst.de>
Date: Sun, 28 May 2017 10:37:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 08/19] block: Introduce request_queue.initialize_rq_fn()
Message-ID: <20170528083758.GC13083@lst.de>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com> <20170525184327.23570-9-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525184327.23570-9-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

Oh, and btw - for the mq case we don't want to use the function
pointer directly in the queue, but in blk_mq_ops, so that we have
all the mq methods in one place.
