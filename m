Return-Path: <keith.busch@linux.intel.com>
Date: Wed, 20 Jun 2018 08:49:11 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <tom.leiming@gmail.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [RFC PATCH] blk-mq: User defined HCTX CPU mapping
Message-ID: <20180620144911.GA24104@localhost.localdomain>
References: <20180618173206.19506-1-keith.busch@intel.com>
 <20180620090805.GA4205@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620090805.GA4205@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 20, 2018 at 11:08:05AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 18, 2018 at 11:32:06AM -0600, Keith Busch wrote:
> > The default mapping of a cpu to a hardware context is often generally
> > applicable, however a user may know of a more appropriate mapping for
> > their specific access usage.
> > 
> > This patch allows a user to define their own policy by making the mq hctx
> > cpu_list writable. The usage allows a user to append a comma separated
> > and/or range list of CPUs to a given hctx's tag set mapping to reassign
> > what hctx a cpu may map.
> > 
> > While the writable attribute exists under a specific request_queue, the
> > settings will affect all request queues sharing the same tagset.
> > 
> > The user defined setting is lost if the block device is removed and
> > re-added, or if the driver re-runs the queue mapping.
> 
> We can't do this without driver opt-in.  Managed interrupt rely on
> the fact that we can't generate more interrupts once all cpus mapped
> to the interrupt line have been offlined.
>
> So what exactly is the use case?  What drivers do you care about?

This patch came at a customer request for NVMe. The controllers have 1:1
queues to CPUs, so currently a submission on CPU A will interrupt CPU A.

The user really wants their application to run in CPU A and have the
interrupt run in CPU B. We can't change the IRQ affinity, so I thought
changing the submission affinity would be less intrusive.

I think you're saying this will break if CPU B is offlined. I hadn't
considered that, so it doesn't sound like this will work.
