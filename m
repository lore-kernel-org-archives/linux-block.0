Return-Path: <hch@lst.de>
Date: Fri, 10 Nov 2017 05:54:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
Message-ID: <20171110045418.GB32408@lst.de>
References: <20171109174450.17142-1-hch@lst.de> <20171109174450.17142-5-hch@lst.de> <20171109212217.GA16454@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171109212217.GA16454@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 09, 2017 at 04:22:17PM -0500, Mike Snitzer wrote:
> Your 0th header speaks to the NVMe multipath IO path leveraging NVMe's
> lack of partial completion but I think it'd be useful to have this
> header (that actually gets committed) speak to it.

There is a comment above blk_steal_bios to this respect, which is in
the tree.

> Also, the block core patch to introduce blk_steal_bios() already went in
> but should there be a QUEUE_FLAG that gets set by drivers like NVMe that
> don't support partial completion?
> 
> This would make it easier for other future drivers to know whether they
> can use a more optimized IO path.

As-is there is not real need for this.  But if you want to use a similar
path in dm-multipath feel free to add the flag when needed.
