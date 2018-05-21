Return-Path: <keith.busch@linux.intel.com>
Date: Mon, 21 May 2018 09:03:31 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] nvme: Move all IO out of controller reset
Message-ID: <20180521150331.GI5528@localhost.localdomain>
References: <20180518163823.27820-1-keith.busch@intel.com>
 <20180518163823.27820-3-keith.busch@intel.com>
 <20180518230357.GC18334@ming.t460p>
 <20180521142219.GC5528@localhost.localdomain>
 <20180521145850.GA19099@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521145850.GA19099@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 21, 2018 at 10:58:51PM +0800, Ming Lei wrote:
> On Mon, May 21, 2018 at 08:22:19AM -0600, Keith Busch wrote:
> > On Sat, May 19, 2018 at 07:03:58AM +0800, Ming Lei wrote:
> > > On Fri, May 18, 2018 at 10:38:20AM -0600, Keith Busch wrote:
> > > > +
> > > > +	if (unfreeze)
> > > > +		nvme_wait_freeze(&dev->ctrl);
> > > > +
> > > 
> > > timeout may comes just before&during blk_mq_update_nr_hw_queues() or
> > > the above nvme_wait_freeze(), then both two may hang forever.
> > 
> > Why would it hang forever? The scan_work doesn't stop a timeout from
> > triggering a reset to reclaim requests necessary to complete a freeze.
> 
> nvme_dev_disable() will quiesce queues, then nvme_wait_freeze() or
> blk_mq_update_nr_hw_queues() may hang forever.

nvme_dev_disable is just the first part of the timeout sequence. You
have to follow it through to the reset_work that either restarts or
kills the queues.
