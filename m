Return-Path: <hch@lst.de>
Date: Wed, 7 Jun 2017 21:06:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] blk-mq: create hctx for each present CPU
Message-ID: <20170607190659.GA32550@lst.de>
References: <20170603140403.27379-1-hch@lst.de> <20170603140403.27379-8-hch@lst.de> <20170607091038.GA25572@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170607091038.GA25572@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 07, 2017 at 05:10:46PM +0800, Ming Lei wrote:
> One thing not sure is that we may need to handle new CPU hotplug
> after initialization. Without the CPU hotplug handler, system may
> not scale well when more CPUs are added to sockets.

Adding physical CPUs to sockets is a very rare activity, and we
should not optimize for it.  Taking CPUs that are physically present
offline and online is the case that is interesting, and that's what
this patchset changes.

> Another thing is that I don't see how NVMe handles this situation,
> blk_mq_update_nr_hw_queues() is called in nvme_reset_work(), so
> that means RESET need to be triggered after new CPUs are added to
> system?

Yes.

> I have tried to add new CPUs runtime on Qemu, and not see
> new hw queues are added no matter this patchset is applied or not.

Do you even see the CPUs in your VM?  For physical hotplug you'll
need to reserve spots in the cpumap beforehand.
