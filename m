Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 42/55] skd: Initialize skd_special_context.req.n_sg to one
Date: Thu, 17 Aug 2017 13:13:25 -0700
Message-Id: <20170817201338.16537-43-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The debug code in skd_send_special_fitmsg() assumes that req.n_sg
represents the number of S/G descriptors. However, skd_construct()
initializes that member variable to zero. Set req.n_sg to one such
that the debugging code in skd_send_special_fitmsg() works as
expected.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index c7f531e99ede..392c898d86e2 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -1050,6 +1050,7 @@ static int skd_format_internal_skspcl(struct skd_device *skdev)
 	memset(scsi, 0, sizeof(*scsi));
 	dma_address = skspcl->req.sksg_dma_address;
 	scsi->hdr.sg_list_dma_address = cpu_to_be64(dma_address);
+	skspcl->req.n_sg = 1;
 	sgd->control = FIT_SGD_CONTROL_LAST;
 	sgd->byte_count = 0;
 	sgd->host_side_addr = skspcl->db_dma_address;
-- 
2.14.0
