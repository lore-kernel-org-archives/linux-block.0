Return-Path: <keith.busch@intel.com>
Date: Mon, 25 Sep 2017 10:19:09 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] nvme: also expose the namespace identification sysfs
 files for mpath nodes
Message-ID: <20170925161908.GE8463@localhost.localdomain>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925134031.10548-10-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 03:40:31PM +0200, Christoph Hellwig wrote:
> We do this by adding a helper that returns the ns_head for a device that
> can belong to either the per-controller or per-subsystem block device
> nodes, and otherwise reuse all the existing code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
