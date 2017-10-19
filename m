Return-Path: <hch@lst.de>
Date: Thu, 19 Oct 2017 15:15:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
Message-ID: <20171019131535.GB20645@lst.de>
References: <20171018165258.23212-1-hch@lst.de> <20171018165258.23212-7-hch@lst.de> <1d2fe3fa-564f-c056-bbc5-b80282bee912@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1d2fe3fa-564f-c056-bbc5-b80282bee912@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 19, 2017 at 02:45:03PM +0200, Hannes Reinecke wrote:
> > No way in hell this would get through.  Preemptive NAK right here.
> >
> > That whole idea is just amazingly stupid, and no one has even
> > explained a reason for it.
> 
> I wonder what has changed ...

The nvme-controller devices aren't accessible to anyone outside the
nvme driver itself, so they aren't just hidden, as far as the rest
of the kernel is concerned they don't exist.  They just allow reusing
block layer code in the nvme driver instead of reimplementing it.
