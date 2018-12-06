Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30124C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E897A21582
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tSzttWuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E897A21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLFPxP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeLFPxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jPOSGoJw4VTHj6tXqG5MHvK89wmZQyW2+oHDTvj8L6A=; b=tSzttWuMORZGIfQYaHv7Ug7QVq
        ezkdJPFonmo2kQaNSRGuzp6hOm9cXL9BCE1XI0KGFeJRfV983tOggqwcqZoOZrLkH2GxHhyuk0tgm
        znT0A4j3w0Vp2LibqzWaRhct1ErxAwXfs01cqlz0dw1ekeATS9QCp5ilNdfWiM7ZnTRBUxVq7VLer
        W5qontffABy/QkKd2YH5aIonc0Y+RXnpk5kGL1jzazoU7pc0Snrh1R1IFzQxabs3+yCQCfrMtCzCq
        t8aHlQ2cLZkcIaWWomb8ZC4ec0cXNDz/88BhPLOKfElZid39ab8Tw9Ma5zCR+Num2cgfyNx1zqSHI
        WV9YHJDQ==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvxU-0008Lk-8R; Thu, 06 Dec 2018 15:53:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 4/9] myrs: remove the DISABLE_CLUSTERING flag
Date:   Thu,  6 Dec 2018 07:52:53 -0800
Message-Id: <20181206155258.11465-5-hch@lst.de>
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

The old DAC960 drivers was fine with merging over segment bondaries,
so this new driver should be to.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/myrs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index f47b36382afa..0264a2e2bc19 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -1929,7 +1929,6 @@ struct scsi_host_template myrs_template = {
 	.shost_attrs		= myrs_shost_attrs,
 	.sdev_attrs		= myrs_sdev_attrs,
 	.this_id		= -1,
-	.use_clustering		= DISABLE_CLUSTERING,
 };
 
 static struct myrs_hba *myrs_alloc_host(struct pci_dev *pdev,
-- 
2.19.1

