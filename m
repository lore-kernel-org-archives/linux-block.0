Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: ->retries fixups
Date: Wed,  5 Apr 2017 16:18:51 +0200
Message-Id: <20170405141856.1862-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This series fixes a few lose bits in terms of how nvme uses ->retries,
including fixing it for non-PCIe transports.  While at it I noticed that
nvme and scsi use the field in entirely different ways, and no other
driver uses it at all.  So I decided to move it into the nvme_request and
scsi_request structures instead.
