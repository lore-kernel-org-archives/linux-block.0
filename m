Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435BDC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FD820870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mBaB8Wnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FD820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeLMPRb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:17:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMPRa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v0CUE6KrqhEar+arwSpYh7HRV6zvDmYJ11t7v3JJZ1k=; b=mBaB8Wnl9xymOO6Md/fUvdmg/Q
        BYXtDFc1iA1F6zDOnhbxJMaxPu6EYjGi1Lhd8Lmm2jHfauBGgt4uftwKCVrGKLcpwbvDUx1bQACQM
        D6x9nlP640/gx6fWjgzX5wD2H++ON2LLA8LFnc1zYd/l1xkrtX82/rw2O84jc+aE6c+22CEehmQGI
        yot9MJ+nPZ/fRO1UFOX0KpaCZfrI21lRGqNnQYY8K7csBIx9CrpLkWLbdIfh/NuafmbfW6CokIpqm
        QVKgi1JGU06WXGhy/YbCEurTkNQ2hZ+7sSdOXS8zQeJf74pd+RGGf9kri/MlH3KSTsfhHA8/UK0la
        tZI3qRJQ==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXSjs-0001EI-5z; Thu, 13 Dec 2018 15:17:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 04/10] cumana_2: remove the explicit use_clustering setting
Date:   Thu, 13 Dec 2018 16:17:04 +0100
Message-Id: <20181213151710.30036-5-hch@lst.de>
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
 drivers/scsi/arm/cumana_2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/arm/cumana_2.c b/drivers/scsi/arm/cumana_2.c
index edce5f3cfdba..40afcbd8de61 100644
--- a/drivers/scsi/arm/cumana_2.c
+++ b/drivers/scsi/arm/cumana_2.c
@@ -367,7 +367,6 @@ static struct scsi_host_template cumanascsi2_template = {
 	.this_id			= 7,
 	.sg_tablesize			= SG_MAX_SEGMENTS,
 	.dma_boundary			= IOMD_DMA_BOUNDARY,
-	.use_clustering			= DISABLE_CLUSTERING,
 	.proc_name			= "cumanascsi2",
 };
 
-- 
2.19.2

