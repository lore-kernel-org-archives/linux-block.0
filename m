Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4849AC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0334520851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VCZ4WIcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0334520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbeLMPR1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:17:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMPR0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vAmTFYcCVnGaKsvkjPR4rlPqbwqqFbQet/H+ajgKMpE=; b=VCZ4WIcYm/TKECoUjg43J5fpDH
        RSjOtb5RM86UmGb4RqEf6U6PWCc+LQ5RLVC3ziXH/whmuzZtt2jtUFuU+JIdQWNjX200s7gnJ33hw
        72wEONiUeLLi+CeArku4PiZlNG5vpfnUSj1UQiCE5N7hcvrmbVasATv13M3+gFeZk9hvZT/bsoyyW
        5UGOSiKzd/capnFa3yrnO7Q4OqX1QbiYUlePEWnrHmG+xJY1GiYC9jGq6cORBVM2zH3OD7pkvL0Eq
        503qVeFKPBd07kaAn7qAy8JLYMU8/GsVDvUmOngyLSL2wKPeDhdTchXkarC1CbByX113PN89r7Rxt
        oihjD3xQ==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXSjp-0001DA-9D; Thu, 13 Dec 2018 15:17:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 03/10] scsi: introduce a max_segment_size host_template parameters
Date:   Thu, 13 Dec 2018 16:17:03 +0100
Message-Id: <20181213151710.30036-4-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213151710.30036-1-hch@lst.de>
References: <20181213151710.30036-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This allows the host driver to indicate the maximum supported
segment size in a nice an easy way, so that the driver doesn't
have to worry about DMA-layer imposed limitations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/be2iscsi/be_main.c | 8 +-------
 drivers/scsi/hosts.c            | 5 +++++
 drivers/scsi/scsi_debug.c       | 2 +-
 drivers/scsi/scsi_lib.c         | 3 ++-
 include/scsi/scsi_host.h        | 6 ++++++
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index c4108b17d5ab..39f3820572b4 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -214,12 +214,6 @@ static char const *cqe_desc[] = {
 	"CXN_KILLED_IMM_DATA_RCVD"
 };
 
-static int beiscsi_slave_configure(struct scsi_device *sdev)
-{
-	blk_queue_max_segment_size(sdev->request_queue, 65536);
-	return 0;
-}
-
 static int beiscsi_eh_abort(struct scsi_cmnd *sc)
 {
 	struct iscsi_task *abrt_task = (struct iscsi_task *)sc->SCp.ptr;
@@ -393,7 +387,6 @@ static struct scsi_host_template beiscsi_sht = {
 	.proc_name = DRV_NAME,
 	.queuecommand = iscsi_queuecommand,
 	.change_queue_depth = scsi_change_queue_depth,
-	.slave_configure = beiscsi_slave_configure,
 	.target_alloc = iscsi_target_alloc,
 	.eh_timed_out = iscsi_eh_cmd_timed_out,
 	.eh_abort_handler = beiscsi_eh_abort,
@@ -404,6 +397,7 @@ static struct scsi_host_template beiscsi_sht = {
 	.can_queue = BE2_IO_DEPTH,
 	.this_id = -1,
 	.max_sectors = BEISCSI_MAX_SECTORS,
+	.max_segment_size = 65536,
 	.cmd_per_lun = BEISCSI_CMD_PER_LUN,
 	.vendor_id = SCSI_NL_VID_TYPE_PCI | BE_VENDOR_ID,
 	.track_queue_depth = 1,
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index ea4b0bb0c1cd..e8148ba414a3 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -464,6 +464,11 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	else
 		shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS;
 
+	if (sht->max_segment_size)
+		shost->max_segment_size = sht->max_segment_size;
+	else
+		shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
+
 	/*
 	 * assume a 4GB boundary, if not set
 	 */
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 53ba417bef8a..57d418d7d74e 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -3973,7 +3973,6 @@ static int scsi_debug_slave_configure(struct scsi_device *sdp)
 			return 1;  /* no resources, will be marked offline */
 	}
 	sdp->hostdata = devip;
-	blk_queue_max_segment_size(sdp->request_queue, -1U);
 	if (sdebug_no_uld)
 		sdp->no_uld_attach = 1;
 	config_cdb_len(sdp);
@@ -5851,6 +5850,7 @@ static struct scsi_host_template sdebug_driver_template = {
 	.sg_tablesize =		SG_MAX_SEGMENTS,
 	.cmd_per_lun =		DEF_CMD_PER_LUN,
 	.max_sectors =		-1U,
+	.max_segment_size =	-1U,
 	.module =		THIS_MODULE,
 	.track_queue_depth =	1,
 };
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index f6900e0b3024..2d4fd6b4bd92 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2227,7 +2227,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 	blk_queue_segment_boundary(q, shost->dma_boundary);
 	dma_set_seg_boundary(dev, shost->dma_boundary);
 
-	blk_queue_max_segment_size(q, dma_get_max_seg_size(dev));
+	blk_queue_max_segment_size(q,
+		min(shost->max_segment_size, dma_get_max_seg_size(dev)));
 
 	if (shost->use_clustering == DISABLE_CLUSTERING)
 		q->limits.cluster = 0;
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 7dc534c794dc..834204681ca3 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -364,6 +364,11 @@ struct scsi_host_template {
 	 */
 	unsigned int max_sectors;
 
+	/*
+	 * Maximum size in bytes of a single segment.
+	 */
+	unsigned int max_segment_size;
+
 	/*
 	 * DMA scatter gather segment boundary limit. A segment crossing this
 	 * boundary will be split in two.
@@ -603,6 +608,7 @@ struct Scsi_Host {
 	short unsigned int sg_tablesize;
 	short unsigned int sg_prot_tablesize;
 	unsigned int max_sectors;
+	unsigned int max_segment_size;
 	unsigned long dma_boundary;
 	/*
 	 * In scsi-mq mode, the number of hardware queues supported by the LLD.
-- 
2.19.2

