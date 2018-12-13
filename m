Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE751C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8158820851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QSEV0Jp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8158820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeLMPRd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:17:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbeLMPRd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aGzlNTCb21tmBIuA98N94uY7n+JyPrWIKYYkewEjQjk=; b=QSEV0Jp/LgYWVLLEtDRZKU+8Cw
        I+RdlH+0sWxZFl5Rs3+pzv7DYev+oxniMNwP3UxlYbdosjUh5rOdT/2lPFnm0m8tPjG2UMxKddvAx
        H8ool2vU3mvy7gwWkXrJstau8MW286I9/hHg3k1z0PlYTFtfeBq4hdNDTU7ceqwqlDShGgJOnLx9j
        zHbIJ00D3LCMRi5jbGfNe/hv9ghhzbORDlGSsn/z3PBmZ93GiS0QXgjGuI1H6RSVjg0UCqk70eFvu
        hzCc6TQjnEoTNY7z87/PJEHlaU3SZwGVJYnNQwCUoraCYCh3EqhYWgyMdsGyodJsfu20XLkmjxg0T
        ceG7pU4g==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXSjv-0001HL-6H; Thu, 13 Dec 2018 15:17:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 05/10] powertec: remove the explicit use_clustering setting
Date:   Thu, 13 Dec 2018 16:17:05 +0100
Message-Id: <20181213151710.30036-6-hch@lst.de>
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

This driver already sets the dma_boundary to PAGE_SIZE - 1, which
has the same result.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/arm/eesox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/arm/eesox.c b/drivers/scsi/arm/eesox.c
index e93e047f4316..8f64c370a8a7 100644
--- a/drivers/scsi/arm/eesox.c
+++ b/drivers/scsi/arm/eesox.c
@@ -486,7 +486,6 @@ static struct scsi_host_template eesox_template = {
 	.this_id			= 7,
 	.sg_tablesize			= SG_MAX_SEGMENTS,
 	.dma_boundary			= IOMD_DMA_BOUNDARY,
-	.use_clustering			= DISABLE_CLUSTERING,
 	.proc_name			= "eesox",
 };
 
-- 
2.19.2

