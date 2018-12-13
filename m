Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D73C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F69320851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RE0f3lm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F69320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbeLMPRh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:17:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbeLMPRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7YUeKzPErcMocRJUmal2TJAsNW6F6ogrrfmn+VCJJQM=; b=RE0f3lm0xCf2nr2E+8KHOusBX5
        7mduh5SWo43/lWaJn0lGZPeL2stbalO4JRNjuRLrJLqSPSU12uLJyvBmBWzl1xZkTCEiVlgbf9fx7
        MBFzjgMrjorCAQMni1YzufevqYzdkLS6UPVJ3qsHRQbcRVztKcKvPrGFCzxetRtsgcOKw1EDwWuoQ
        VTXb683u+yg4856rgr91lm9EekdClTWXOZrDLY4Oe6fJuzcJA9O9pfWkm7IqSHa7O43jkiRPeicFo
        R7tKEKG4m3SmfLXoXO5G+s53qIzf14KDZHv4vpVWbfPTtzIhvRhpjO1D/O7F3pHDto29DRw7LCA5t
        GU44KZcw==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXSk0-0001ON-Tv; Thu, 13 Dec 2018 15:17:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 07/10] mesh: remove DISABLE_CLUSTERING
Date:   Thu, 13 Dec 2018 16:17:07 +0100
Message-Id: <20181213151710.30036-8-hch@lst.de>
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

mesh has no limitations on crossing pages for segments.  Just make
the 65535 byte segment size limit explicit, even if it matches the
current block layer limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Paul Mackerras <paulus@ozlabs.org>
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
2.19.2

