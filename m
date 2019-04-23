Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31580C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 10:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05244214AE
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 10:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfDWKc6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:32:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDWKc6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 06:32:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6B3E3087932;
        Tue, 23 Apr 2019 10:32:57 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97983646A6;
        Tue, 23 Apr 2019 10:32:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/2] scsi: core: avoid to pre-allocate big chunk for protection meta data
Date:   Tue, 23 Apr 2019 18:32:39 +0800
Message-Id: <20190423103240.29864-2-ming.lei@redhat.com>
In-Reply-To: <20190423103240.29864-1-ming.lei@redhat.com>
References: <20190423103240.29864-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 23 Apr 2019 10:32:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now scsi_mq_setup_tags() pre-allocates a big buffer for protection
sg list, and the buffer size is scsi_mq_sgl_size().

This way isn't correct, scsi_mq_sgl_size() is used to pre-allocate
sg list for IO data. And the protection data buffer is much less,
for example, one 512byte sector needs 8byte protection data, and
the max sector number for one request is 2560(BLK_DEF_MAX_SECTORS),
so the max protection data size is just 20k.

The usual case is that one bio builds one single bip segment. Attribute
to bio split, bio merge is seldom done for big IO, and it is only done
in case of small bios. And the bip segment number is usually same with
bio count in the request, so the number won't be very big, and
allocating from slab should be fast enough.

Reduce to pre-alocate one sg entry for protection data, and switches
to runtime allocation from slab in case that the protection data
segment number is bigger than 1. So we can save huge pre-alocation
for protection data, for example, 500+MB can be saved on lpfc.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 07dfc17d4824..bdcf40851356 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -39,6 +39,12 @@
 #include "scsi_priv.h"
 #include "scsi_logging.h"
 
+/*
+ * Size of integrity meta data size is usually small, 1 inline sg
+ * should cover normal cases.
+ */
+#define  SCSI_INLINE_PROT_SG_CNT  1
+
 static struct kmem_cache *scsi_sdb_cache;
 static struct kmem_cache *scsi_sense_cache;
 static struct kmem_cache *scsi_sense_isadma_cache;
@@ -553,12 +559,21 @@ static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 	}
 }
 
+static inline bool scsi_prot_use_inline_sg(struct scsi_cmnd *cmd)
+{
+	if (!scsi_prot_sglist(cmd))
+		return false;
+
+	return cmd->prot_sdb->table.sgl ==
+		(struct scatterlist *)(cmd->prot_sdb + 1);
+}
+
 static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 {
 	if (cmd->sdb.table.nents)
 		sg_free_table_chained(&cmd->sdb.table, true);
-	if (scsi_prot_sg_count(cmd))
-		sg_free_table_chained(&cmd->prot_sdb->table, true);
+	if (scsi_prot_sg_count(cmd) && !scsi_prot_use_inline_sg(cmd))
+		sg_free_table_chained(&cmd->prot_sdb->table, false);
 }
 
 static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
@@ -1044,9 +1059,11 @@ blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
 		}
 
 		ivecs = blk_rq_count_integrity_sg(rq->q, rq->bio);
-
-		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
-				prot_sdb->table.sgl)) {
+		if (ivecs <= SCSI_INLINE_PROT_SG_CNT)
+			prot_sdb->table.nents = prot_sdb->table.orig_nents =
+				SCSI_INLINE_PROT_SG_CNT;
+		else if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
+					NULL)) {
 			ret = BLK_STS_RESOURCE;
 			goto out_free_sgtables;
 		}
@@ -1846,7 +1863,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
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

