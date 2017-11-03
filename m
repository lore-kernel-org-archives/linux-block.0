Return-Path: <prvs=473169c3e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Ard
 Biesheuvel" <ard.biesheuvel@linaro.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Bart Van Assche <bart.vanassche@wdc.com>,
	<linux-scsi@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Anil Ravindranath
	<anil_ravindranath@pmc-sierra.com>
Subject: [PATCH v3 7/8] scsi/pmcraid: Remove an unused structure member
Date: Fri, 3 Nov 2017 15:23:38 -0700
Message-ID: <20171103222339.26540-8-bart.vanassche@wdc.com>
In-Reply-To: <20171103222339.26540-1-bart.vanassche@wdc.com>
References: <20171103222339.26540-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: linux-scsi@vger.kernel.org
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Anil Ravindranath <anil_ravindranath@pmc-sierra.com>
---
 drivers/scsi/pmcraid.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/pmcraid.h b/drivers/scsi/pmcraid.h
index 8bfac72a242b..44da91712115 100644
--- a/drivers/scsi/pmcraid.h
+++ b/drivers/scsi/pmcraid.h
@@ -542,7 +542,6 @@ struct pmcraid_sglist {
 	u32 order;
 	u32 num_sg;
 	u32 num_dma_sg;
-	u32 buffer_len;
 	struct scatterlist scatterlist[1];
 };
 
-- 
2.14.3
