Return-Path: <ming.lei@redhat.com>
Date: Tue, 29 May 2018 08:50:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/14] nvme: return BLK_EH_DONE from ->timeout
Message-ID: <20180529005023.GA8818@ming.t460p>
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-4-hch@lst.de>
 <20180524044510.GA22751@ming.t460p>
 <20180528114425.GA12779@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180528114425.GA12779@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 28, 2018 at 01:44:25PM +0200, Christoph Hellwig wrote:
> On Thu, May 24, 2018 at 12:45:15PM +0800, Ming Lei wrote:
> > This change should have been done after '[PATCH 13/14] blk-mq: Remove
> > generation seqeunce', otherwise the timed-out request won't be completed
> > by nvme_cancel_request() at all because we always marked this request as
> > 'COMPLETE' before calling .timeout().
> 
> Yes.  Or we should start out with reverting the whole series introducing
> the gstate.  I think it has shown to create much more problems than it
> solved, and starting from a clean state without it will allow us to
> iterate much saner.

It may not help for this case by reverting the series introducing the gstate.

This behaviour has been used from the beginning, such as, the code
becomes the following after the revert:

                if (!blk_mark_rq_complete(rq))
                        blk_mq_rq_timed_out(rq, reserved);

Given the patch 13("blk-mq: Remove generation seqeunce") is the 1st one
to change the behaviour, we should put this patch and other related ones
after patch 13 for avoiding to break 'git bisect'.

Thanks,
Ming
