Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C77C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB007208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="irDJ2VzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB007208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFPxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeLFPxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M4MRa+cr23uPG9DNjLycM7DKP11bmYaU8LaQAXXiAa4=; b=irDJ2VzCfBEX7XjUoCpO3VLJYH
        L2kEBfO5z/0HaHxASxNftkdPIWyYS03dsUSS3gqpiYcQ4zgiYew+6msIxypSEjXzqxsXKnJAVfCNs
        8EYw5dXaKW/3uenf/LSu6x+xZJieacqoIOGVmemzxNsif1f6scSCLOa542/kX6slfSSdlk1mw5jRk
        tSR1HcB7/ipLDu3iUOTOT1kUOyf8Xah7EARgRx6kgywQiAPvv1cx/CMYoHHT/xw6GG2CsCHCI8bXW
        ZBmuASXbs74yGQEK8jAkjEazaHMg6H9+InymfJbU3ngQUkpZBJmz4jyBi+yVayop9tBnFchLIuHBP
        dSVS19KQ==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvxT-0008L7-PT; Thu, 06 Dec 2018 15:52:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 2/9] scsi: introduce a max_segment_size host_template parameters
Date:   Thu,  6 Dec 2018 07:52:51 -0800
Message-Id: <20181206155258.11465-3-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206155258.11465-1-hch@lst.de>
References: <20181206155258.11465-1-hch@lst.de>
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
2.19.1

