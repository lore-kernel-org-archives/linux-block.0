Return-Path: <hare@suse.de>
Subject: Re: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Thumshirn <jthumshirn@suse.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b82fcfa1-4c8c-e834-b929-12411dd6e6ac@suse.de>
Date: Fri, 10 Nov 2017 08:27:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171109174450.17142-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/09/2017 06:44 PM, Christoph Hellwig wrote:
> This patch adds native multipath support to the nvme driver.  For each
> namespace we create only single block device node, which can be used
> to access that namespace through any of the controllers that refer to it.
> The gendisk for each controllers path to the name space still exists
> inside the kernel, but is hidden from userspace.  The character device
> nodes are still available on a per-controller basis.  A new link from
> the sysfs directory for the subsystem allows to find all controllers
> for a given subsystem.
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
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/Kconfig     |   9 ++
>  drivers/nvme/host/Makefile    |   1 +
>  drivers/nvme/host/core.c      | 133 +++++++++++++++++++---
>  drivers/nvme/host/multipath.c | 255 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h      |  57 ++++++++++
>  5 files changed, 440 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/nvme/host/multipath.c
> 
After much discussion I'm finally fine with this.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
