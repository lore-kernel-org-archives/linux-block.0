Return-Path: <BATV+a67a43e55467fd1c3dfd+4677+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com,
	ooo@electrozaur.com,
	bhalevy@primarydata.com,
	nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: [PATCH 5/7] target: stop using blk_make_request
Date: Mon, 13 Jun 2016 17:21:16 +0200
Message-Id: <1465831278-23653-6-git-send-email-hch@lst.de>
In-Reply-To: <1465831278-23653-1-git-send-email-hch@lst.de>
References: <1465831278-23653-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Using blk_rq_append_bio allows to append the bios to the request
directly instead of having to build up a list first, and also
allows to have a single code path for requests with or without
data attached to them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/target_core_pscsi.c | 87 +++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 53 deletions(-)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 1f30179..93da16d 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -876,19 +876,19 @@ static inline struct bio *pscsi_get_bio(int nr_vecs)
 
 static sense_reason_t
 pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
-		enum dma_data_direction data_direction, struct bio **hbio)
+		struct request *req)
 {
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(cmd->se_dev);
-	struct bio *bio = NULL, *tbio = NULL;
+	struct bio *bio = NULL;
 	struct page *page;
 	struct scatterlist *sg;
 	u32 data_len = cmd->data_length, i, len, bytes, off;
 	int nr_pages = (cmd->data_length + sgl[0].offset +
 			PAGE_SIZE - 1) >> PAGE_SHIFT;
 	int nr_vecs = 0, rc;
-	int rw = (data_direction == DMA_TO_DEVICE);
+	int rw = (cmd->data_direction == DMA_TO_DEVICE);
 
-	*hbio = NULL;
+	BUG_ON(!cmd->data_length);
 
 	pr_debug("PSCSI: nr_pages: %d\n", nr_pages);
 
@@ -927,16 +927,6 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 				pr_debug("PSCSI: Allocated bio: %p,"
 					" dir: %s nr_vecs: %d\n", bio,
 					(rw) ? "rw" : "r", nr_vecs);
-				/*
-				 * Set *hbio pointer to handle the case:
-				 * nr_pages > BIO_MAX_PAGES, where additional
-				 * bios need to be added to complete a given
-				 * command.
-				 */
-				if (!*hbio)
-					*hbio = tbio = bio;
-				else
-					tbio = tbio->bi_next = bio;
 			}
 
 			pr_debug("PSCSI: Calling bio_add_pc_page() i: %d"
@@ -955,11 +945,16 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 				pr_debug("PSCSI: Reached bio->bi_vcnt max:"
 					" %d i: %d bio: %p, allocating another"
 					" bio\n", bio->bi_vcnt, i, bio);
+
+				rc = blk_rq_append_bio(req, bio);
+				if (rc) {
+					pr_err("pSCSI: failed to append bio\n");
+					goto fail;
+				}
+
 				/*
 				 * Clear the pointer so that another bio will
-				 * be allocated with pscsi_get_bio() above, the
-				 * current bio has already been set *tbio and
-				 * bio->bi_next.
+				 * be allocated with pscsi_get_bio() above.
 				 */
 				bio = NULL;
 			}
@@ -968,13 +963,16 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		}
 	}
 
+	if (bio) {
+		rc = blk_rq_append_bio(req, bio);
+		if (rc) {
+			pr_err("pSCSI: failed to append bio\n");
+			goto fail;
+		}
+	}
+
 	return 0;
 fail:
-	while (*hbio) {
-		bio = *hbio;
-		*hbio = (*hbio)->bi_next;
-		bio_endio(bio);
-	}
 	return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 }
 
@@ -992,11 +990,9 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 {
 	struct scatterlist *sgl = cmd->t_data_sg;
 	u32 sgl_nents = cmd->t_data_nents;
-	enum dma_data_direction data_direction = cmd->data_direction;
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(cmd->se_dev);
 	struct pscsi_plugin_task *pt;
 	struct request *req;
-	struct bio *hbio;
 	sense_reason_t ret;
 
 	/*
@@ -1012,31 +1008,21 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 	memcpy(pt->pscsi_cdb, cmd->t_task_cdb,
 		scsi_command_size(cmd->t_task_cdb));
 
-	if (!sgl) {
-		req = blk_get_request(pdv->pdv_sd->request_queue,
-				(data_direction == DMA_TO_DEVICE),
-				GFP_KERNEL);
-		if (IS_ERR(req)) {
-			pr_err("PSCSI: blk_get_request() failed\n");
-			ret = TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
-			goto fail;
-		}
+	req = blk_get_request(pdv->pdv_sd->request_queue,
+			(cmd->data_direction == DMA_TO_DEVICE),
+			GFP_KERNEL);
+	if (IS_ERR(req)) {
+		pr_err("PSCSI: blk_get_request() failed\n");
+		ret = TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
+		goto fail;
+	}
 
-		req->cmd_type = REQ_TYPE_BLOCK_PC;
-	} else {
-		BUG_ON(!cmd->data_length);
+	req->cmd_type = REQ_TYPE_BLOCK_PC;
 
-		ret = pscsi_map_sg(cmd, sgl, sgl_nents, data_direction, &hbio);
+	if (sgl) {
+		ret = pscsi_map_sg(cmd, sgl, sgl_nents, req);
 		if (ret)
-			goto fail;
-
-		req = blk_make_request(pdv->pdv_sd->request_queue, hbio,
-				       GFP_KERNEL);
-		if (IS_ERR(req)) {
-			pr_err("pSCSI: blk_make_request() failed\n");
-			ret = TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
-			goto fail_free_bio;
-		}
+			goto fail_put_request;
 	}
 
 	req->end_io = pscsi_req_done;
@@ -1057,13 +1043,8 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 
 	return 0;
 
-fail_free_bio:
-	while (hbio) {
-		struct bio *bio = hbio;
-		hbio = hbio->bi_next;
-		bio_endio(bio);
-	}
-	ret = TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
+fail_put_request:
+	blk_put_request(req);
 fail:
 	kfree(pt);
 	return ret;
-- 
2.1.4
