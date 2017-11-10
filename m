Return-Path: <hch@lst.de>
Date: Fri, 10 Nov 2017 05:52:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
Message-ID: <20171110045236.GA32408@lst.de>
References: <20171109174450.17142-1-hch@lst.de> <20171109174450.17142-5-hch@lst.de> <20171109212111.GA1718@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171109212111.GA1718@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

> If we've CMIC capabilities, we'll use the subsys->instance; if we don't
> have CMIC, we use the ctrl->instance. 
> 
> Since the two instances are independent of each other, they can create
> duplicate names.
> 
> To fix, I think we'll need to always use the subsys instance for
> consistency if CONFIG_NVME_MULTIPATH=y.

Yes, we should.  But once we do that we should just always use
subsys->instance, as it will always be the same as ctrl->instance
for CONFIG_NVME_MULTIPATH=n.
