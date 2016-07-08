Return-Path: <swise@opengridcomputing.com>
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Christoph Hellwig'" <hch@lst.de>,
	<axboe@kernel.dk>,
	<keith.busch@intel.com>
Cc: <linux-block@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>,
	"'Armen Baloyan'" <armenx.baloyan@intel.com>,
	"'Jay Freyensee'" <james.p.freyensee@intel.com>,
	"'Ming Lin'" <ming.l@ssi.samsung.com>,
	"'Sagi Grimberg'" <sagi@grimberg.me>
References: <1467809752-31320-1-git-send-email-hch@lst.de> <1467809752-31320-5-git-send-email-hch@lst.de>
In-Reply-To: <1467809752-31320-5-git-send-email-hch@lst.de>
Subject: RE: [PATCH 4/5] nvmet-rdma: add a NVMe over Fabrics RDMA target driver
Date: Fri, 8 Jul 2016 08:51:48 -0500
Message-ID: <003a01d1d91f$df60ed60$9e22c820$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

> This patch implements the RDMA transport for the NVMe over Fabrics target,
> which allows exporting NVMe over Fabrics functionality over RDMA fabrics
> (Infiniband, RoCE, iWARP).
> 
> All NVMe logic is in the generic target and this module just provides a
> small glue between it and the generic code in the RDMA subsystem.
> 
> Signed-off-by: Armen Baloyan <armenx.baloyan@intel.com>,
> Signed-off-by: Jay Freyensee <james.p.freyensee@intel.com>
> Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Steve Wise <swise@opengridcomputing.com>
