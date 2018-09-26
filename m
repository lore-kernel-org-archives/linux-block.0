Return-Path: <hch@lst.de>
Date: Wed, 26 Sep 2018 16:28:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 8/8] blk-mq: Enable support for runtime power
 management
Message-ID: <20180926142847.GF8604@lst.de>
References: <20180921203122.49743-1-bvanassche@acm.org> <20180921203122.49743-9-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180921203122.49743-9-bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 21, 2018 at 01:31:22PM -0700, Bart Van Assche wrote:
> Now that the blk-mq core processes power management requests
> (marked with RQF_PREEMPT) in other states than RPM_ACTIVE, enable
> runtime power management for blk-mq.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

We also need to remember to rever the !blk_mq flag in the ufs driver
after this, but I guess the commit enabling this isn't even in Jens'
tree, so it will have to be done after the merge.
