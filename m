Return-Path: <hch@lst.de>
Date: Fri, 29 Jun 2018 10:34:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH V2 1/3] blk-mq: use list_splice_tail_init() to insert
	requests
Message-ID: <20180629083448.GC15870@lst.de>
References: <20180629081252.13836-1-ming.lei@redhat.com> <20180629081252.13836-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629081252.13836-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 29, 2018 at 04:12:50PM +0800, Ming Lei wrote:
> list_splice_tail_init() is much more faster than inserting each
> request one by one, given all requets in 'list' belong to
> same sw queue and ctx->lock is required to insert requests.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

We should still make the trace loop conditional, but than can be a
separate patch.
