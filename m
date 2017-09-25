Return-Path: <hare@suse.de>
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1fb2f077-151a-b02f-2bf5-329ef5951a68@suse.de>
Date: Mon, 25 Sep 2017 15:47:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170925134031.10548-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/25/2017 03:40 PM, Christoph Hellwig wrote:
> This patch adds initial multipath support to the nvme driver.  For each
> namespace we create a new block device node, which can be used to access
> that namespace through any of the controllers that refer to it.
> 
> Currently we will always send I/O to the first available path, this will
> be changed once the NVMe Asynchronous Namespace Access (ANA) TP is
> ratified and implemented, at which point we will look at the ANA state
> for each namespace.  Another possibility that was prototyped is to
> use the path that is closes to the submitting NUMA code, which will be
> mostly interesting for PCI, but might also be useful for RDMA or FC
> transports in the future.  There is not plan to implement round robin
> or I/O service time path selectors, as those are not scalable with
> the performance rates provided by NVMe.
> 
> The multipath device will go away once all paths to it disappear,
> any delay to keep it alive needs to be implemented at the controller
> level.
> 
> The new block devices nodes for multipath access will show up as
> 
> 	/dev/nvm-subXnZ
> 
> where X is the local instance number of the subsystems, and Z is the index
> for the namespace.
> 
Can't we make the multipath support invisible to the host?
IE check the shared namespaces before creating the device node, and just
move them under the existing namespaces if one exists?

Thing is, this device multiplication was (and is) the #1 objection to
dm-multipath, and we should be looking to avoid that if we do a new
implementation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
