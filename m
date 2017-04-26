Return-Path: <BATV+8090579d37507300b01f+4994+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/3] scsi_transport_sas: always pass 0 error to blk_end_request_all
Date: Wed, 26 Apr 2017 09:34:20 +0200
Message-Id: <20170426073422.14511-2-hch@lst.de>
In-Reply-To: <20170426073422.14511-1-hch@lst.de>
References: <20170426073422.14511-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The SAS transport queues are only used by bsg, and bsg always looks at
the scsi_request results and never add the error passed in the end_io
callback.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_transport_sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index a2b279737a4b..9fdbd50c31b4 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -186,7 +186,7 @@ static void sas_smp_request(struct request_queue *q, struct Scsi_Host *shost,
 		ret = handler(shost, rphy, req);
 		scsi_req(req)->result = ret;
 
-		blk_end_request_all(req, ret);
+		blk_end_request_all(req, 0);
 
 		spin_lock_irq(q->queue_lock);
 	}
-- 
2.11.0
