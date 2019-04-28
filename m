Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3D8C43218
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 07:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441DA21473
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 07:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfD1HkA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 03:40:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfD1HkA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 03:40:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 503F4356D3;
        Sun, 28 Apr 2019 07:40:00 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B395620D2;
        Sun, 28 Apr 2019 07:39:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH V4 3/3] scsi: core: avoid to pre-allocate big chunk for sg list
Date:   Sun, 28 Apr 2019 15:39:32 +0800
Message-Id: <20190428073932.9898-4-ming.lei@redhat.com>
In-Reply-To: <20190428073932.9898-1-ming.lei@redhat.com>
References: <20190428073932.9898-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 28 Apr 2019 07:40:00 +0000 (UTC)
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2eaba41655de..472d848f1778 100644
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
@@ -547,7 +549,8 @@ static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 {
 	if (cmd->sdb.table.nents)
-		sg_free_table_chained(&cmd->sdb.table, SG_CHUNK_SIZE);
+		sg_free_table_chained(&cmd->sdb.table,
+				SCSI_INLINE_SG_CNT);
 	if (scsi_prot_sg_count(cmd))
 		sg_free_table_chained(&cmd->prot_sdb->table,
 				SCSI_INLINE_PROT_SG_CNT);
@@ -984,7 +987,7 @@ static blk_status_t scsi_init_sgtable(struct request *req,
 	 */
 	if (unlikely(sg_alloc_table_chained(&sdb->table,
 			blk_rq_nr_phys_segments(req), sdb->table.sgl,
-			SG_CHUNK_SIZE)))
+			SCSI_INLINE_SG_CNT)))
 		return BLK_STS_RESOURCE;
 
 	/* 
@@ -1550,9 +1553,9 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 }
 
 /* Size in bytes of the sg-list stored in the scsi-mq command-private data. */
-static unsigned int scsi_mq_sgl_size(struct Scsi_Host *shost)
+static unsigned int scsi_mq_inline_sgl_size(struct Scsi_Host *shost)
 {
-	return min_t(unsigned int, shost->sg_tablesize, SG_CHUNK_SIZE) *
+	return min_t(unsigned int, shost->sg_tablesize, SCSI_INLINE_SG_CNT) *
 		sizeof(struct scatterlist);
 }
 
@@ -1730,7 +1733,7 @@ static int scsi_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	if (scsi_host_get_prot(shost)) {
 		sg = (void *)cmd + sizeof(struct scsi_cmnd) +
 			shost->hostt->cmd_size;
-		cmd->prot_sdb = (void *)sg + scsi_mq_sgl_size(shost);
+		cmd->prot_sdb = (void *)sg + scsi_mq_inline_sgl_size(shost);
 	}
 
 	return 0;
@@ -1824,7 +1827,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 {
 	unsigned int cmd_size, sgl_size;
 
-	sgl_size = scsi_mq_sgl_size(shost);
+	sgl_size = scsi_mq_inline_sgl_size(shost);
 	cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size + sgl_size;
 	if (scsi_host_get_prot(shost))
 		cmd_size += sizeof(struct scsi_data_buffer) +
-- 
2.9.5

