Return-Path: <BATV+80a1e3aa0109c64edabc+4700+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: NVMe over Fabrics RDMA transport drivers V2
Date: Wed,  6 Jul 2016 21:55:47 +0900
Message-Id: <1467809752-31320-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This patch set implements the NVMe over Fabrics RDMA host and the target
drivers.

The host driver is tied into the NVMe host stack and implements the RDMA
transport under the NVMe core and Fabrics modules. The NVMe over Fabrics
RDMA host module is responsible for establishing a connection against a
given target/controller, RDMA event handling and data-plane command
processing.

The target driver hooks into the NVMe target core stack and implements
the RDMA transport. The module is responsible for RDMA connection
establishment, RDMA event handling and data-plane RDMA commands
processing.

RDMA connection establishment is done using RDMA/CM and IP resolution.
The data-plane command sequence follows the classic storage model where
the target pushes/pulls the data.

Changes since V1:
 - updates for req_op changes in for-next (me)
 - validate adrfam in nvmet-rdma (Ming)
 - don't leak rsp structures on connect failure in nvmet-rdma (Steve)
 - don't use RDMA/CM errors codes in reject path in nvmet-rdma (Steve)
 - fix nvmet_rdma_delete_ctrl (me)
 - invoke fatal error on error completion in nvmet-rdma (Sagi)
 - don't leak rsp structure on disconnected queue in nvmet-rdma (Ming)
 - properly set the SGL flag on AERs in nvme-rdma (me)
 - correctly stop the keep alive timer on reconnect in nvme-rdma (Ming)
 - stop and drain queues before freeing the tagset in nvet-rdma (Steve)
