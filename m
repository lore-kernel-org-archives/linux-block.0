Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19038C43218
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 07:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FCC206BF
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 07:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfD1Hjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 03:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfD1Hjz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 03:39:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C81E059447;
        Sun, 28 Apr 2019 07:39:54 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE1E51018A0C;
        Sun, 28 Apr 2019 07:39:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH V4 2/3] scsi: core: avoid to pre-allocate big chunk for protection meta data
Date:   Sun, 28 Apr 2019 15:39:31 +0800
Message-Id: <20190428073932.9898-3-ming.lei@redhat.com>
In-Reply-To: <20190428073932.9898-1-ming.lei@redhat.com>
References: <20190428073932.9898-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 28 Apr 2019 07:39:54 +0000 (UTC)
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c37263c123eb..2eaba41655de 100644
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
@@ -543,7 +549,8 @@ static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 	if (cmd->sdb.table.nents)
 		sg_free_table_chained(&cmd->sdb.table, SG_CHUNK_SIZE);
 	if (scsi_prot_sg_count(cmd))
-		sg_free_table_chained(&cmd->prot_sdb->table, SG_CHUNK_SIZE);
+		sg_free_table_chained(&cmd->prot_sdb->table,
+				SCSI_INLINE_PROT_SG_CNT);
 }
 
 static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
@@ -1032,7 +1039,7 @@ blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
 
 		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
 				prot_sdb->table.sgl,
-				SG_CHUNK_SIZE)) {
+				SCSI_INLINE_PROT_SG_CNT)) {
 			ret = BLK_STS_RESOURCE;
 			goto out_free_sgtables;
 		}
@@ -1820,7 +1827,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
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

