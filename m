Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 4/7] scsi: clean up error handling in scsi_init_io
Date: Fri,  9 Nov 2018 14:42:38 +0100
Message-Id: <20181109134241.29346-5-hch@lst.de>
In-Reply-To: <20181109134241.29346-1-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

There is no need to call scsi_mq_free_sgtables until we have actually
allocated sgtables.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_lib.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e665c25da144..1f84e2cec57b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1044,31 +1044,30 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 	int error = BLKPREP_KILL;
 
 	if (WARN_ON_ONCE(!blk_rq_nr_phys_segments(rq)))
-		goto err_exit;
+		return BLKPREP_KILL;
 
 	error = scsi_init_sgtable(rq, &cmd->sdb);
 	if (error)
-		goto err_exit;
+		return error;
 
 	if (blk_bidi_rq(rq)) {
 		error = scsi_init_sgtable(rq->next_rq, rq->next_rq->special);
 		if (error)
-			goto err_exit;
+			goto out_free_sgtables;
 	}
 
 	if (blk_integrity_rq(rq)) {
 		struct scsi_data_buffer *prot_sdb = cmd->prot_sdb;
 		int ivecs, count;
 
-		if (prot_sdb == NULL) {
+		if (WARN_ON_ONCE(!prot_sdb)) {
 			/*
 			 * This can happen if someone (e.g. multipath)
 			 * queues a command to a device on an adapter
 			 * that does not support DIX.
 			 */
-			WARN_ON_ONCE(1);
 			error = BLKPREP_KILL;
-			goto err_exit;
+			goto out_free_sgtables;
 		}
 
 		ivecs = blk_rq_count_integrity_sg(rq->q, rq->bio);
@@ -1076,7 +1075,7 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
 				prot_sdb->table.sgl)) {
 			error = BLKPREP_DEFER;
-			goto err_exit;
+			goto out_free_sgtables;
 		}
 
 		count = blk_rq_map_integrity_sg(rq->q, rq->bio,
@@ -1089,7 +1088,7 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 	}
 
 	return BLKPREP_OK;
-err_exit:
+out_free_sgtables:
 	scsi_mq_free_sgtables(cmd);
 	return error;
 }
-- 
2.19.1
