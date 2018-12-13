Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A84C67872
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996B720880
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZUM4NLYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996B720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbeLMPRT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:17:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbeLMPRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1yOjEamTl/6Ql4NycO3OLD6ozTWUGVRj2R9NMESxoak=; b=ZUM4NLYgkyxe4pK1WsfAU7c8WR
        fQsb4RX9bVyH/iSK4NP5skVb2BW1NRms8yJj0aQcWaML3MJibpCd8P5k2ZFtF0bTF8cMnk/2/B/un
        M8HcJHuAS8/UEeAaqKmyBJQJhhnxxTj5y3+1DsvTSIV2GG/URFDgtpZSYbqUaYfqpfFof4gmc5qt+
        2sGiT7iSp2WqVTayX+HX2DVBxQn5RG0QPEfqlD6xu53q0ikRz421uJYhwiCAi4rbjntl2gCE0gsAv
        aGvPQO/lmq3Y5O/kaWXCZ3LlNmPvKZFA2wuunhaZ1kuYa0gg6+qW1si1p5bWjtBv/XnMWFPwl1CJC
        eOW6fPjw==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXSjj-0001Ca-KV; Thu, 13 Dec 2018 15:17:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 01/10] scsi: make sure all drivers set the use_clustering flag
Date:   Thu, 13 Dec 2018 16:17:01 +0100
Message-Id: <20181213151710.30036-2-hch@lst.de>
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

A few drivers were not setting the use_clustering flag at all and thus
default to disable.  Fix them up to explicitly set this field in
preparation for additional cleanups.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/mvumi.c      | 1 +
 drivers/scsi/myrb.c       | 1 +
 drivers/scsi/myrs.c       | 1 +
 drivers/scsi/stex.c       | 1 +
 drivers/scsi/ufs/ufshcd.c | 1 +
 drivers/usb/storage/uas.c | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 3d2d026d1ccf..d0c3f867fc58 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2197,6 +2197,7 @@ static struct scsi_host_template mvumi_template = {
 	.eh_timed_out = mvumi_timed_out,
 	.eh_host_reset_handler = mvumi_host_reset,
 	.bios_param = mvumi_bios_param,
+	.use_clustering = DISABLE_CLUSTERING,
 	.this_id = -1,
 };
 
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index aeb282f617c5..f1abe38e3b3a 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -2236,6 +2236,7 @@ struct scsi_host_template myrb_template = {
 	.shost_attrs		= myrb_shost_attrs,
 	.sdev_attrs		= myrb_sdev_attrs,
 	.this_id		= -1,
+	.use_clustering		= DISABLE_CLUSTERING,
 };
 
 /**
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 0264a2e2bc19..f47b36382afa 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -1929,6 +1929,7 @@ struct scsi_host_template myrs_template = {
 	.shost_attrs		= myrs_shost_attrs,
 	.sdev_attrs		= myrs_sdev_attrs,
 	.this_id		= -1,
+	.use_clustering		= DISABLE_CLUSTERING,
 };
 
 static struct myrs_hba *myrs_alloc_host(struct pci_dev *pdev,
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 95f370ad05e0..af9078320d4b 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1489,6 +1489,7 @@ static struct scsi_host_template driver_template = {
 	.eh_abort_handler		= stex_abort,
 	.eh_host_reset_handler		= stex_reset,
 	.this_id			= -1,
+	.use_clustering			= DISABLE_CLUSTERING,
 };
 
 static struct pci_device_id stex_pci_tbl[] = {
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 751027d73cf3..e5800da0053d 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6982,6 +6982,7 @@ static struct scsi_host_template ufshcd_driver_template = {
 	.max_host_blocked	= 1,
 	.track_queue_depth	= 1,
 	.sdev_groups		= ufshcd_driver_groups,
+	.use_clustering		= DISABLE_CLUSTERING,
 };
 
 static int ufshcd_config_vreg_load(struct device *dev, struct ufs_vreg *vreg,
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 1f7b401c4d04..6c75a0a50b3a 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -879,6 +879,7 @@ static struct scsi_host_template uas_host_template = {
 	.this_id = -1,
 	.sg_tablesize = SG_NONE,
 	.skip_settle_delay = 1,
+	.use_clustering = DISABLE_CLUSTERING,
 };
 
 #define UNUSUAL_DEV(id_vendor, id_product, bcdDeviceMin, bcdDeviceMax, \
-- 
2.19.2

