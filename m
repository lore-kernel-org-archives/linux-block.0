Return-Path: <swise@opengridcomputing.com>
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Christoph Hellwig'" <hch@lst.de>,
	<axboe@kernel.dk>,
	<keith.busch@intel.com>
Cc: <linux-block@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>,
	"'Jay Freyensee'" <james.p.freyensee@intel.com>,
	"'Ming Lin'" <ming.l@ssi.samsung.com>,
	"'Sagi Grimberg'" <sagi@grimberg.me>
References: <1467809752-31320-1-git-send-email-hch@lst.de> <1467809752-31320-6-git-send-email-hch@lst.de>
In-Reply-To: <1467809752-31320-6-git-send-email-hch@lst.de>
Subject: RE: [PATCH 5/5] nvme-rdma: add a NVMe over Fabrics RDMA host driver
Date: Fri, 8 Jul 2016 08:53:59 -0500
Message-ID: <003c01d1d920$2d5c0040$881400c0$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

> This patch implements the RDMA host (initiator in SCSI speak) driver.  It
> can be used to connect to remote NVMe over Fabrics controllers over
> Infiniband, RoCE or iWarp, and uses the existing NVMe core driver as well
> a the new fabrics library.
> 
> To connect to all NVMe over Fabrics controller reachable on a given taget
> port using RDMA/CM use the following command:
> 
> 	nvme connect-all -t rdma -a $IPADDR
> 
> This requires the latest version of nvme-cli with Fabrics support.
> 
> Signed-off-by: Jay Freyensee <james.p.freyensee@intel.com>
> Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine.

Reviewed by: Steve Wise <swise@opengridcomputing.com>
