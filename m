Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E01C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E782175B
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 10:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfDWKdH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:33:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDWKdH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 06:33:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3279181E0D;
        Tue, 23 Apr 2019 10:33:07 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 960864D723;
        Tue, 23 Apr 2019 10:33:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 2/2] scsi: core: avoid to pre-allocate big chunk for sg list
Date:   Tue, 23 Apr 2019 18:32:40 +0800
Message-Id: <20190423103240.29864-3-ming.lei@redhat.com>
In-Reply-To: <20190423103240.29864-1-ming.lei@redhat.com>
References: <20190423103240.29864-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 23 Apr 2019 10:33:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now scsi_mq_setup_tags() pre-allocates a big buffer for IO sg list,
and the buffer size is scsi_mq_sgl_size() which depends on smaller
value between shost->sg_tablesize and SG_CHUNK_SIZE.

Modern HBA's DMA capabilty is often capable of deadling with very
big segment number, so scsi_mq_sgl_size() is often big. Suppose the
max sg number of SG_CHUNK_SIZE is taken, scsi_mq_sgl_size() will be
4KB.

Then if one HBA has lots of queues, and each hw queue's depth is
big, the whole pre-allocation for sg list can consume huge memory.
For example of lpfc, nr_hw_queues can be 70, each queue's depth
can be 3781, so the pre-allocation for data sg list can be 70*3781*2k
=517MB for single HBA.

Also there is Red Hat internal reprot that scsi_debug based tests can't
be run any more since legacy io path is killed because too big
pre-allocation.

This patch switchs to runtime allocation for sg list, meantime
pre-allocate 2 inline sg entries. This way has been applied to
NVMe for a while, so it should be fine for SCSI too.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index bdcf40851356..4fff95b14c91 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -45,6 +45,8 @@
  */
 #define  SCSI_INLINE_PROT_SG_CNT  1
 
+#define  SCSI_INLINE_SG_CNT  2
+
 static struct kmem_cache *scsi_sdb_cache;
 static struct kmem_cache *scsi_sense_cache;
 static struct kmem_cache *scsi_sense_isadma_cache;
@@ -568,10 +570,18 @@ static inline bool scsi_prot_use_inline_sg(struct scsi_cmnd *cmd)
 		(struct scatterlist *)(cmd->prot_sdb + 1);
 }
 
+static bool scsi_use_inline_sg(struct scsi_cmnd *cmd)
+{
+	struct scatterlist *sg = (void *)cmd + sizeof(struct scsi_cmnd) +
+		cmd->device->host->hostt->cmd_size;
+
+	return cmd->sdb.table.sgl == sg;
+}
+
 static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 {
-	if (cmd->sdb.table.nents)
-		sg_free_table_chained(&cmd->sdb.table, true);
+	if (cmd->sdb.table.nents && !scsi_use_inline_sg(cmd))
+		sg_free_table_chained(&cmd->sdb.table, false);
 	if (scsi_prot_sg_count(cmd) && !scsi_prot_use_inline_sg(cmd))
 		sg_free_table_chained(&cmd->prot_sdb->table, false);
 }
@@ -1002,12 +1012,16 @@ static blk_status_t scsi_init_sgtable(struct request *req,
 		struct scsi_data_buffer *sdb)
 {
 	int count;
+	unsigned nr_segs = blk_rq_nr_phys_segments(req);
 
 	/*
 	 * If sg table allocation fails, requeue request later.
 	 */
-	if (unlikely(sg_alloc_table_chained(&sdb->table,
-			blk_rq_nr_phys_segments(req), sdb->table.sgl)))
+	if (nr_segs <= SCSI_INLINE_SG_CNT)
+		sdb->table.nents = sdb->table.orig_nents =
+			SCSI_INLINE_SG_CNT;
+	else if (unlikely(sg_alloc_table_chained(&sdb->table, nr_segs,
+					NULL)))
 		return BLK_STS_RESOURCE;
 
 	/* 
@@ -1574,9 +1588,9 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 }
 
 /* Size in bytes of the sg-list stored in the scsi-mq command-private data. */
-static unsigned int scsi_mq_sgl_size(struct Scsi_Host *shost)
+static unsigned int scsi_mq_inline_sgl_size(struct Scsi_Host *shost)
 {
-	return min_t(unsigned int, shost->sg_tablesize, SG_CHUNK_SIZE) *
+	return min_t(unsigned int, shost->sg_tablesize, SCSI_INLINE_SG_CNT) *
 		sizeof(struct scatterlist);
 }
 
@@ -1766,7 +1780,7 @@ static int scsi_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	if (scsi_host_get_prot(shost)) {
 		sg = (void *)cmd + sizeof(struct scsi_cmnd) +
 			shost->hostt->cmd_size;
-		cmd->prot_sdb = (void *)sg + scsi_mq_sgl_size(shost);
+		cmd->prot_sdb = (void *)sg + scsi_mq_inline_sgl_size(shost);
 	}
 
 	return 0;
@@ -1860,7 +1874,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 {
 	unsigned int cmd_size, sgl_size;
 
-	sgl_size = scsi_mq_sgl_size(shost);
+	sgl_size = scsi_mq_inline_sgl_size(shost);
 	cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size + sgl_size;
 	if (scsi_host_get_prot(shost))
 		cmd_size += sizeof(struct scsi_data_buffer) +
-- 
2.9.5

