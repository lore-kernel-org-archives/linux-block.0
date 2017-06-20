Return-Path: <hch@lst.de>
Date: Tue, 20 Jun 2017 11:10:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/10] blk-mq-sched: unify request prepare methods
Message-ID: <20170620091006.GA10204@lst.de>
References: <20170616161527.17649-1-hch@lst.de> <20170616161527.17649-10-hch@lst.de> <462C0809-EDD7-4FBB-A6F9-B8C8155A4335@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <462C0809-EDD7-4FBB-A6F9-B8C8155A4335@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 19, 2017 at 03:32:09PM +0200, Paolo Valente wrote:
> > static void bfq_finish_request(struct request *rq)
> > {
> > -	struct bfq_queue *bfqq = RQ_BFQQ(rq);
> > -	struct bfq_data *bfqd = bfqq->bfqd;
> > +	struct bfq_queue *bfqq;
> > +	struct bfq_data *bfqd;
> > +
> > +	if (!rq->elv.icq)
> > +		return;
> > +
> 
> If this is a rq dispatched from a bfqq (or even a request still in the
> scheduler), then just exiting here will break bfq state seriously.
> However, I guess that this case can never occur.

It is a request for which we didn't manage to allocate the ioc.

Previously those wouldn't have REQ_ELVPRIV set and thus we wouldn't
call into the finish method.  Now they do and the finish method needs
to handle those just like the init method.
