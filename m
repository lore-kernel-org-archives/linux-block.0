Return-Path: <hch@lst.de>
Date: Wed, 20 Jun 2018 11:08:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC PATCH] blk-mq: User defined HCTX CPU mapping
Message-ID: <20180620090805.GA4205@lst.de>
References: <20180618173206.19506-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180618173206.19506-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 18, 2018 at 11:32:06AM -0600, Keith Busch wrote:
> The default mapping of a cpu to a hardware context is often generally
> applicable, however a user may know of a more appropriate mapping for
> their specific access usage.
> 
> This patch allows a user to define their own policy by making the mq hctx
> cpu_list writable. The usage allows a user to append a comma separated
> and/or range list of CPUs to a given hctx's tag set mapping to reassign
> what hctx a cpu may map.
> 
> While the writable attribute exists under a specific request_queue, the
> settings will affect all request queues sharing the same tagset.
> 
> The user defined setting is lost if the block device is removed and
> re-added, or if the driver re-runs the queue mapping.

We can't do this without driver opt-in.  Managed interrupt rely on
the fact that we can't generate more interrupts once all cpus mapped
to the interrupt line have been offlined.

So what exactly is the use case?  What drivers do you care about?
