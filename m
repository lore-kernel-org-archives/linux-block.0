Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA2C67838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93523208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5wLapv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93523208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLFPxP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLFPxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dhzP1EurzzYpyItFhfR6NVlMCDd+bprodIbJ7mgAfkI=; b=b5wLapv3nyAyDMZKerajWr7KO1
        Bc0e/KDL0v4yDcX7V3FD/8YcIAS8ohWjLjpM4ry7JGFGO13pN6bUe6C9yEJ+eTorPyDIrkz55DWNB
        u6sA+2yUrKChcO0V3NZ9gu8PK7LUkMtO2Ksdsi48IwsGG4vRBNocJ3JA1bOT1ZHFi+x0+rArtveXz
        OaYOv/Xp21EW3cjWHnPJSPF+ZwtsSQHrSJS2L2bydod2gZLJPKp+2OihNCLJyGzb+g2zl75aFiCAm
        HLcpVSOAZPU/hnjmVX4bBqI+B65pkqgaxzD2vYkJtuYopB8sQKs2Ij7be6bPYftogHK04F0s6H7u1
        VIRDQMuA==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvxU-0008MB-M8; Thu, 06 Dec 2018 15:53:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 6/9] mesh: remove DISABLE_CLUSTERING
Date:   Thu,  6 Dec 2018 07:52:55 -0800
Message-Id: <20181206155258.11465-7-hch@lst.de>
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

mesh has no limitations on crossing pages for segments.  Just make
the 65535 byte segment size limit explicit, even if it matches the
current block layer limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/mesh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index ec6940f2fcb3..f3e182eb0970 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -1838,7 +1838,7 @@ static struct scsi_host_template mesh_template = {
 	.this_id			= 7,
 	.sg_tablesize			= SG_ALL,
 	.cmd_per_lun			= 2,
-	.use_clustering			= DISABLE_CLUSTERING,
+	.max_segment_size		= 65535,
 };
 
 static int mesh_probe(struct macio_dev *mdev, const struct of_device_id *match)
-- 
2.19.1

