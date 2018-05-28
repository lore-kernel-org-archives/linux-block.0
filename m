Return-Path: <hch@lst.de>
Date: Mon, 28 May 2018 13:44:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/14] nvme: return BLK_EH_DONE from ->timeout
Message-ID: <20180528114425.GA12779@lst.de>
References: <20180523121941.8632-1-hch@lst.de> <20180523121941.8632-4-hch@lst.de> <20180524044510.GA22751@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180524044510.GA22751@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 24, 2018 at 12:45:15PM +0800, Ming Lei wrote:
> This change should have been done after '[PATCH 13/14] blk-mq: Remove
> generation seqeunce', otherwise the timed-out request won't be completed
> by nvme_cancel_request() at all because we always marked this request as
> 'COMPLETE' before calling .timeout().

Yes.  Or we should start out with reverting the whole series introducing
the gstate.  I think it has shown to create much more problems than it
solved, and starting from a clean state without it will allow us to
iterate much saner.
