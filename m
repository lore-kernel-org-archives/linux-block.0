Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3873CC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 09:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1436A20878
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 09:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfDXJfy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:35:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfDXJfy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 05:35:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB7207EBAE;
        Wed, 24 Apr 2019 09:35:53 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC74860851;
        Wed, 24 Apr 2019 09:35:50 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH V2 1/2] scsi: core: avoid to pre-allocate big chunk for protection meta data
Date:   Wed, 24 Apr 2019 17:35:39 +0800
Message-Id: <20190424093540.15526-2-ming.lei@redhat.com>
In-Reply-To: <20190424093540.15526-1-ming.lei@redhat.com>
References: <20190424093540.15526-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 24 Apr 2019 09:35:53 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now scsi_mq_setup_tags() pre-allocates a big buffer for protection
sg entries, and the buffer size is scsi_mq_sgl_size().

This way isn't correct, scsi_mq_sgl_size() is used to pre-allocate
sg entries for IO data. And the protection data buffer is much less,
for example, one 512byte sector needs 8byte protection data, and
the max sector number for one request is 2560(BLK_DEF_MAX_SECTORS),
so the max protection data size is just 20k.

The usual case is that one bio builds one single bip segment. Attribute
to bio split, bio merge is seldom done for big IO, and it is only done
in case of small bios. And protection data segment number is usually
same with bio count in the request, so the number won't be very big,
and allocating from slab is fast enough.

Reduce to pre-allocate one sg entry for protection data, and switch
to runtime allocation in case that the protection data segment number
is bigger than 1. Then we can save huge pre-alocation, for example,
500+MB is saved on single lpfc HBA.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 07dfc17d4824..9814eee8014c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -39,6 +39,12 @@
 #include "scsi_priv.h"
 #include "scsi_logging.h"
 
+/*
+ * Size of integrity metadata is usually small, 1 inline sg should
+ * cover normal cases.
+ */
+#define  SCSI_INLINE_PROT_SG_CNT  1
+
 static struct kmem_cache *scsi_sdb_cache;
 static struct kmem_cache *scsi_sense_cache;
 static struct kmem_cache *scsi_sense_isadma_cache;
@@ -553,12 +559,27 @@ static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 	}
 }
 
+static void scsi_init_inline_sg_table(struct sg_table *table,
+				      struct scatterlist *sgl,
+				      unsigned nents)
+{
+	table->nents = table->orig_nents = nents;
+	table->sgl = sgl;
+	sg_init_table(sgl, nents);
+}
+
+static inline struct scatterlist *scsi_prot_inline_sg(struct scsi_cmnd *cmd)
+{
+	return (struct scatterlist *)(cmd->prot_sdb + 1);
+}
+
 static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 {
 	if (cmd->sdb.table.nents)
 		sg_free_table_chained(&cmd->sdb.table, true);
-	if (scsi_prot_sg_count(cmd))
-		sg_free_table_chained(&cmd->prot_sdb->table, true);
+	if (scsi_prot_sg_count(cmd) && cmd->prot_sdb->table.sgl !=
+			scsi_prot_inline_sg(cmd))
+		sg_free_table_chained(&cmd->prot_sdb->table, false);
 }
 
 static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
@@ -1044,9 +1065,12 @@ blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
 		}
 
 		ivecs = blk_rq_count_integrity_sg(rq->q, rq->bio);
-
-		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
-				prot_sdb->table.sgl)) {
+		if (ivecs <= SCSI_INLINE_PROT_SG_CNT) {
+			scsi_init_inline_sg_table(&prot_sdb->table,
+						  scsi_prot_inline_sg(cmd),
+						  SCSI_INLINE_PROT_SG_CNT);
+		} else if (sg_alloc_table_chained(&prot_sdb->table,
+						  ivecs, NULL)) {
 			ret = BLK_STS_RESOURCE;
 			goto out_free_sgtables;
 		}
@@ -1579,13 +1603,9 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
 	sg = (void *)cmd + sizeof(struct scsi_cmnd) + shost->hostt->cmd_size;
 	cmd->sdb.table.sgl = sg;
 
-	if (scsi_host_get_prot(shost)) {
+	if (scsi_host_get_prot(shost))
 		memset(cmd->prot_sdb, 0, sizeof(struct scsi_data_buffer));
 
-		cmd->prot_sdb->table.sgl =
-			(struct scatterlist *)(cmd->prot_sdb + 1);
-	}
-
 	blk_mq_start_request(req);
 
 	return scsi_setup_cmnd(sdev, req);
@@ -1846,7 +1866,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	sgl_size = scsi_mq_sgl_size(shost);
 	cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size + sgl_size;
 	if (scsi_host_get_prot(shost))
-		cmd_size += sizeof(struct scsi_data_buffer) + sgl_size;
+		cmd_size += sizeof(struct scsi_data_buffer) +
+			sizeof(struct scatterlist) * SCSI_INLINE_PROT_SG_CNT;
 
 	memset(&shost->tag_set, 0, sizeof(shost->tag_set));
 	shost->tag_set.ops = &scsi_mq_ops;
-- 
2.9.5

