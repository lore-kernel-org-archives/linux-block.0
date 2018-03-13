Return-Path: <BATV+1231baeb55c0b05cfb44+5315+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: bsg-lib interface cleanup V2
Date: Tue, 13 Mar 2018 17:28:38 +0100
Message-Id: <20180313162841.9030-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series cleans up various abuses of the bsg interfaces, and then
splits bsg for SCSI passthrough from bsg for arbitrary transport
passthrough.  This removes the scsi_request abuse in bsg-lib that is
very confusing, and also makes sure we can sanity check the requests
we get.  The current code will happily execute scsi commands against
bsg-lib queues, and transport pass through against scsi nodes, without
any indication to the driver that we are doing the wrong thing.

Changes since V1:
 - dropped various patches merged already
 - use job to get the payload length in bsg_transport_complete_rq
 - renamed the ptr64 macro to uptr64
 - make bsg_scsi_complete_rq and bsg_transport_complete_rq look more
   similar
 - trivial cleanup in bsg_map_hdr
