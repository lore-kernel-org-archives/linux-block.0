Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08FBC43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61E4206BA
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfDZAyJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:54:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbfDZAyJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 20:54:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 864927DCD7;
        Fri, 26 Apr 2019 00:54:08 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A1B760C8E;
        Fri, 26 Apr 2019 00:54:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH V3 3/3] scsi: core: avoid to pre-allocate big chunk for sg list
Date:   Fri, 26 Apr 2019 08:53:46 +0800
Message-Id: <20190426005346.27962-4-ming.lei@redhat.com>
In-Reply-To: <20190426005346.27962-1-ming.lei@redhat.com>
References: <20190426005346.27962-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 26 Apr 2019 00:54:08 +0000 (UTC)
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
 drivers/scsi/scsi_lib.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 989539de78c6..b701fc65da76 100644
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
@@ -562,7 +564,8 @@ static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 {
 	if (cmd->sdb.table.nents)
-		sg_free_table_chained(&cmd->sdb.table, true);
+		__sg_free_table_chained(&cmd->sdb.table,
+				SCSI_INLINE_SG_CNT);
 	if (scsi_prot_sg_count(cmd))
 		__sg_free_table_chained(&cmd->prot_sdb->table,
 				SCSI_INLINE_PROT_SG_CNT);
@@ -998,8 +1001,10 @@ static blk_status_t scsi_init_sgtable(struct request *req,
 	/*
 	 * If sg table allocation fails, requeue request later.
 	 */
-	if (unlikely(sg_alloc_table_chained(&sdb->table,
-			blk_rq_nr_phys_segments(req), sdb->table.sgl)))
+	if (unlikely(__sg_alloc_table_chained(&sdb->table,
+					blk_rq_nr_phys_segments(req),
+					sdb->table.sgl,
+					SCSI_INLINE_SG_CNT)))
 		return BLK_STS_RESOURCE;
 
 	/* 
@@ -1565,9 +1570,9 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 }
 
 /* Size in bytes of the sg-list stored in the scsi-mq command-private data. */
-static unsigned int scsi_mq_sgl_size(struct Scsi_Host *shost)
+static unsigned int scsi_mq_inline_sgl_size(struct Scsi_Host *shost)
 {
-	return min_t(unsigned int, shost->sg_tablesize, SG_CHUNK_SIZE) *
+	return min_t(unsigned int, shost->sg_tablesize, SCSI_INLINE_SG_CNT) *
 		sizeof(struct scatterlist);
 }
 
@@ -1757,7 +1762,7 @@ static int scsi_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	if (scsi_host_get_prot(shost)) {
 		sg = (void *)cmd + sizeof(struct scsi_cmnd) +
 			shost->hostt->cmd_size;
-		cmd->prot_sdb = (void *)sg + scsi_mq_sgl_size(shost);
+		cmd->prot_sdb = (void *)sg + scsi_mq_inline_sgl_size(shost);
 	}
 
 	return 0;
@@ -1851,7 +1856,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 {
 	unsigned int cmd_size, sgl_size;
 
-	sgl_size = scsi_mq_sgl_size(shost);
+	sgl_size = scsi_mq_inline_sgl_size(shost);
 	cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size + sgl_size;
 	if (scsi_host_get_prot(shost))
 		cmd_size += sizeof(struct scsi_data_buffer) +
-- 
2.9.5

