Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: NVMe over Fabrics RDMA transport drivers
Date: Mon,  6 Jun 2016 23:23:30 +0200
Message-Id: <1465248215-18186-1-git-send-email-hch@lst.de>
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
