Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171109174450.17142-1-hch@lst.de>
	<20171109174450.17142-5-hch@lst.de>
Date: Thu, 09 Nov 2017 15:32:04 -0500
In-Reply-To: <20171109174450.17142-5-hch@lst.de> (Christoph Hellwig's message
	of "Thu, 9 Nov 2017 18:44:47 +0100")
Message-ID: <yq14lq3w5vf.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

> This patch adds native multipath support to the nvme driver.  For each
> namespace we create only single block device node, which can be used
> to access that namespace through any of the controllers that refer to
> it.  The gendisk for each controllers path to the name space still
> exists inside the kernel, but is hidden from userspace.  The character
> device nodes are still available on a per-controller basis.  A new
> link from the sysfs directory for the subsystem allows to find all
> controllers for a given subsystem.
>
> Currently we will always send I/O to the first available path, this
> will be changed once the NVMe Asynchronous Namespace Access (ANA) TP
> is ratified and implemented, at which point we will look at the ANA
> state for each namespace.  Another possibility that was prototyped is
> to use the path that is closes to the submitting NUMA code, which will
> be mostly interesting for PCI, but might also be useful for RDMA or FC
> transports in the future.  There is not plan to implement round robin
> or I/O service time path selectors, as those are not scalable with the
> performance rates provided by NVMe.
>
> The multipath device will go away once all paths to it disappear, any
> delay to keep it alive needs to be implemented at the controller
> level.

Beautiful!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
