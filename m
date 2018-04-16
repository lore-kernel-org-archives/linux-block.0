Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] storsvc: don't set a bounce limit
Date: Mon, 16 Apr 2018 10:50:22 +0200
Message-Id: <20180416085032.7367-3-hch@lst.de>
In-Reply-To: <20180416085032.7367-1-hch@lst.de>
References: <20180416085032.7367-1-hch@lst.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

The default already is to never bounce, so the call is a no-op.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/storvsc_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 8c51d628b52e..5f2d177c3bd9 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1382,9 +1382,6 @@ static int storvsc_device_alloc(struct scsi_device *sdevice)
 
 static int storvsc_device_configure(struct scsi_device *sdevice)
 {
-
-	blk_queue_bounce_limit(sdevice->request_queue, BLK_BOUNCE_ANY);
-
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
 
 	/* Ensure there are no gaps in presented sgls */
-- 
2.17.0
