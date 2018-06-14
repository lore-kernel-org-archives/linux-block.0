Return-Path: <hch@lst.de>
Date: Thu, 14 Jun 2018 16:54:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: remove nvme_reinit_tagset and blk_mq_tagset_iter
Message-ID: <20180614145422.GA4856@lst.de>
References: <20180614123015.5989-1-hch@lst.de> <248094d8-afe6-b6b7-8c8b-b8db452ec030@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <248094d8-afe6-b6b7-8c8b-b8db452ec030@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 14, 2018 at 08:45:07AM -0600, Jens Axboe wrote:
> On 6/14/18 6:30 AM, Christoph Hellwig wrote:
> > Now that nvme-fc moved off the reinit request concept both the core nvme
> > and blk-mq code for it becomes unused.
> > 
> > Jens, are you ok with queuing up the blk-mq side with the pending nvme
> > changes?
> 
> Are you asking if you can queue it up, presumable because the nvme-fc
> change isn't upstream yet? That's fine with me, you can add my
> reviewed-by to the patches.

Yes, that is the plan.  The nvme changes are fixes I'm going to send
you ASAP, and I think we can just send the dead code removal along.
