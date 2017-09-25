Return-Path: <keith.busch@intel.com>
Date: Mon, 25 Sep 2017 10:11:55 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 7/9] nvme: track shared namespaces
Message-ID: <20170925161155.GC8463@localhost.localdomain>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925134031.10548-8-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 03:40:29PM +0200, Christoph Hellwig wrote:
> Introduce a new struct nvme_ns_head [1] that holds information about
> an actual namespace, unlike struct nvme_ns, which only holds the
> per-controller namespace information.  For private namespaces there
> is a 1:1 relation of the two, but for shared namespaces this lets us
> discover all the paths to it.  For now only the identifiers are moved
> to the new structure, but most of the information in struct nvme_ns
> should eventually move over.
> 
> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.
> 
> [1] comments welcome if you have a better name for it, the current one is
>     horrible.  One idea would be to rename the current struct nvme_ns
>     to struct nvme_ns_link or similar and use the nvme_ns name for the
>     new structure.  But that would involve a lot of churn.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good; I can live with 'nvme_ns_head'.

Reviewed-by: Keith Busch <keith.busch@intel.com>
