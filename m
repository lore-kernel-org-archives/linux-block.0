Return-Path: <gedwards@ddn.com>
From: Greg Edwards <gedwards@ddn.com>
To: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Greg Edwards <gedwards@ddn.com>
Subject: [PATCH 2/2] scsi: virtio_scsi: fix pi_bytes{out,in} on 4 KiB block size devices
Date: Wed, 25 Jul 2018 10:22:59 -0400
Message-ID: <20180725142259.20562-3-gedwards@ddn.com>
In-Reply-To: <20180725142259.20562-1-gedwards@ddn.com>
References: <20180725142259.20562-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: gedwards@ddn.com
List-ID: <linux-block@vger.kernel.org>

The current calculation for pi_bytes{out,in} assumes a 512 byte logical
block size and a protection interval exponent of 0, i.e. 512 bytes data
+ 8 bytes PI.  When run on a 4 KiB logical block size device with a
protection interval exponent of 0, i.e. 4096 bytes data + 8 bytes PI,
the driver miscalculates the pi_bytes{out,in} by a factor of 8x (64
bytes).

This leads to errors on all reads and writes on 4 KiB logical block size
devices when CONFIG_BLK_DEV_INTEGRITY is enabled and the
VIRTIO_SCSI_F_T10_PI feature bit has been negotiated.

Fixes: e6dc783a38ec0 ("virtio-scsi: Enable DIF/DIX modes in SCSI host LLD")
Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 drivers/scsi/virtio_scsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 6dc8891ccb74..a1e85ab76f74 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -513,12 +513,12 @@ static void virtio_scsi_init_hdr_pi(struct virtio_device *vdev,
 
 	if (sc->sc_data_direction == DMA_TO_DEVICE)
 		cmd_pi->pi_bytesout = cpu_to_virtio32(vdev,
-							blk_rq_sectors(rq) *
-							bi->tuple_size);
+							bio_integrity_bytes(bi,
+							blk_rq_sectors(rq)));
 	else if (sc->sc_data_direction == DMA_FROM_DEVICE)
 		cmd_pi->pi_bytesin = cpu_to_virtio32(vdev,
-						       blk_rq_sectors(rq) *
-						       bi->tuple_size);
+							bio_integrity_bytes(bi,
+							blk_rq_sectors(rq)));
 }
 #endif
 
-- 
2.17.1
