Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74DEC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 09:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2C820878
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 09:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfDXJf6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:35:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbfDXJf6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 05:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7726F2C9C9F;
        Wed, 24 Apr 2019 09:35:57 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89EDB5C220;
        Wed, 24 Apr 2019 09:35:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH V2 2/2] scsi: core: avoid to pre-allocate big chunk for sg list
Date:   Wed, 24 Apr 2019 17:35:40 +0800
Message-Id: <20190424093540.15526-3-ming.lei@redhat.com>
In-Reply-To: <20190424093540.15526-1-ming.lei@redhat.com>
References: <20190424093540.15526-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 24 Apr 2019 09:35:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now scsi_mq_setup_tags() pre-allocates a big buffer for IO sg list,
and the buffer size is scsi_mq_sgl_size() which depends on smaller
value between shost->sg_tablesize and SG_CHUNK_SIZE.

Modern HBA's DMA is often capable of deadling with very big segment
number, so scsi_mq_sgl_size() is often big. Suppose the max sg number
of SG_CHUNK_SIZE is taken, scsi_mq_sgl_size() will be 4KB.

Then if one HBA has lots of queues, and each hw queue's depth is
high, pre-allocation for sg list can consume huge memory.
For example of lpfc, nr_hw_queues can be 70, each queue's depth
can be 3781, so the pre-allocation for data sg list is 70*3781*2k
=517MB for single HBA.

There is Red Hat internal report that scsi_debug based tests can't
be run any more since legacy io path is killed because too big
pre-allocation.

So switch to runtime allocation for sg list, meantime pre-allocate 2
inline sg entries. This way has been applied to NVMe PCI for a while,
so it should be fine for SCSI too. Also runtime sg entries allocation
has verified and run always in the original legacy io path.

Not see performance effect in my big BS test on scsi_debug.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9814eee8014c..a53d31f4f24c 100644
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
@@ -573,10 +575,18 @@ static inline struct scatterlist *scsi_prot_inline_sg(struct scsi_cmnd *cmd)
 	return (struct scatterlist *)(cmd->prot_sdb + 1);
 }
 
+static inline struct scatterlist *scsi_inline_sg(struct scsi_cmnd *cmd)
+{
+	return (struct scatterlist *)((void *)cmd +
+				      sizeof(struct scsi_cmnd) +
+				      cmd->device->host->hostt->cmd_size);
+}
+
 static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 {
-	if (cmd->sdb.table.nents)
-		sg_free_table_chained(&cmd->sdb.table, true);
+	if (cmd->sdb.table.nents && cmd->sdb.table.sgl !=
+			scsi_inline_sg(cmd))
+		sg_free_table_chained(&cmd->sdb.table, false);
 	if (scsi_prot_sg_count(cmd) && cmd->prot_sdb->table.sgl !=
 			scsi_prot_inline_sg(cmd))
 		sg_free_table_chained(&cmd->prot_sdb->table, false);
@@ -1008,12 +1018,17 @@ static blk_status_t scsi_init_sgtable(struct request *req,
 		struct scsi_data_buffer *sdb)
 {
 	int count;
+	unsigned nr_segs = blk_rq_nr_phys_segments(req);
 
 	/*
 	 * If sg table allocation fails, requeue request later.
 	 */
-	if (unlikely(sg_alloc_table_chained(&sdb->table,
-			blk_rq_nr_phys_segments(req), sdb->table.sgl)))
+	if (nr_segs <= SCSI_INLINE_SG_CNT) {
+		scsi_init_inline_sg_table(&sdb->table, scsi_inline_sg(
+					  blk_mq_rq_to_pdu(req)),
+					  SCSI_INLINE_SG_CNT);
+	} else if (unlikely(sg_alloc_table_chained(&sdb->table, nr_segs,
+						   NULL)))
 		return BLK_STS_RESOURCE;
 
 	/* 
@@ -1581,9 +1596,9 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 }
 
 /* Size in bytes of the sg-list stored in the scsi-mq command-private data. */
-static unsigned int scsi_mq_sgl_size(struct Scsi_Host *shost)
+static unsigned int scsi_mq_inline_sgl_size(struct Scsi_Host *shost)
 {
-	return min_t(unsigned int, shost->sg_tablesize, SG_CHUNK_SIZE) *
+	return min_t(unsigned int, shost->sg_tablesize, SCSI_INLINE_SG_CNT) *
 		sizeof(struct scatterlist);
 }
 
@@ -1592,7 +1607,6 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 	struct scsi_device *sdev = req->q->queuedata;
 	struct Scsi_Host *shost = sdev->host;
-	struct scatterlist *sg;
 
 	scsi_init_command(sdev, cmd);
 
@@ -1600,9 +1614,6 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
 	cmd->tag = req->tag;
 	cmd->prot_op = SCSI_PROT_NORMAL;
 
-	sg = (void *)cmd + sizeof(struct scsi_cmnd) + shost->hostt->cmd_size;
-	cmd->sdb.table.sgl = sg;
-
 	if (scsi_host_get_prot(shost))
 		memset(cmd->prot_sdb, 0, sizeof(struct scsi_data_buffer));
 
@@ -1769,7 +1780,7 @@ static int scsi_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	if (scsi_host_get_prot(shost)) {
 		sg = (void *)cmd + sizeof(struct scsi_cmnd) +
 			shost->hostt->cmd_size;
-		cmd->prot_sdb = (void *)sg + scsi_mq_sgl_size(shost);
+		cmd->prot_sdb = (void *)sg + scsi_mq_inline_sgl_size(shost);
 	}
 
 	return 0;
@@ -1863,7 +1874,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 {
 	unsigned int cmd_size, sgl_size;
 
-	sgl_size = scsi_mq_sgl_size(shost);
+	sgl_size = scsi_mq_inline_sgl_size(shost);
 	cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size + sgl_size;
 	if (scsi_host_get_prot(shost))
 		cmd_size += sizeof(struct scsi_data_buffer) +
-- 
2.9.5

