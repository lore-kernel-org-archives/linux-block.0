Return-Path: <hch@lst.de>
Date: Tue, 14 Mar 2017 00:17:35 +0100
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/4] blk-mq: merge mq and sq make_request instances
Message-ID: <20170313231735.GB12880@lst.de>
References: <20170313154833.14165-1-hch@lst.de> <20170313154833.14165-3-hch@lst.de> <1489438828.2658.23.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1489438828.2658.23.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 13, 2017 at 09:01:08PM +0000, Bart Van Assche wrote:
> > +		/*
> > +		 * @request_count may become stale because of schedule
> > +		 * out, so check the list again.
> > +		 */
> 
> The above comment was relevant as long as there was a request_count assignment
> above blk_mq_sched_get_request(). This patch moves that assignment inside if
> (plug && q->nr_hw_queues == 1). Does that mean that the above comment should be
> removed entirely?

I don't think so - for the !blk_queue_nomerges cases we still rely
on blk_attempt_plug_merge calculatіng request_count, so the comment
still applies.
