Return-Path: <msnitzer@redhat.com>
Date: Mon, 6 Nov 2017 12:03:56 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 4/5] nvme: implement multipath access to nvme subsystems
Message-ID: <20171106170356.GD25073@redhat.com>
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171102183034.9320-5-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 02 2017 at  2:30pm -0400,
Christoph Hellwig <hch@lst.de> wrote:

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
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 46d6cb1e03bd..45886800a1df 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -13,6 +13,15 @@ config BLK_DEV_NVME
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nvme.
>  
> +config NVME_MULTIPATH
> +	bool "NVMe multipath support"
> +	depends on NVME_CORE
> +	---help---
> +	   This option enables support for multipath access to NVMe
> +	   subsystems.  If this option is enabled only a single
> +	   /dev/nvneXnY device will show up for each NVMe namespaces,
> +	   even if it is accessible through multiple controllers.
> +
>  config NVME_FABRICS
>  	tristate
>  

Thanks for adding this, appreciate it.
