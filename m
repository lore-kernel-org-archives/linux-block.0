Return-Path: <hch@lst.de>
Date: Tue, 14 Mar 2017 00:16:08 +0100
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/4] blk-mq: remove BLK_MQ_F_DEFER_ISSUE
Message-ID: <20170313231608.GA12880@lst.de>
References: <20170313154833.14165-1-hch@lst.de> <20170313154833.14165-2-hch@lst.de> <1489438361.2658.21.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489438361.2658.21.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 13, 2017 at 08:52:54PM +0000, Bart Van Assche wrote:
> > -	if (((plug && !blk_queue_nomerges(q)) || is_sync) &&
> > -	    !(data.hctx->flags & BLK_MQ_F_DEFER_ISSUE)) {
> > +	if (((plug && !blk_queue_nomerges(q)) || is_sync)) {
> 
> A minor comment: due to this change the outer pair of parentheses
> became superfluous. Please consider removing these.

The last patch in the series removes the statement in this form. But
if I have to respin the series for some reason I'll make sure it
gets removed here already.
