Return-Path: <keith.busch@intel.com>
Date: Thu, 9 Nov 2017 11:17:47 -0700
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
Message-ID: <20171109181747.GA8365@localhost.localdomain>
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171109174450.17142-5-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 09, 2017 at 06:44:47PM +0100, Christoph Hellwig wrote:
> +config NVME_MULTIPATH
> +	bool "NVMe multipath support"
> +	depends on NVME_CORE
> +	---help---
> +	   This option enables support for multipath access to NVMe
> +	   subsystems.  If this option is enabled only a single
> +	   /dev/nvneXnY device will show up for each NVMe namespaces,

Minor typo: should be /dev/nvmeXnY.

Otherwise, everything in the series looks good to me and testing on my
dual port devices hasn't found any problems.

For the whole series:

Reviewed-by: Keith Busch <keith.busch@intel.com>
