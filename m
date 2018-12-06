Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79027C65BAF
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FEC223C7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N+nmGwdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FEC223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeLFPxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeLFPxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9Nty6VvCEL4SWtGt1WIES77Pyo246dP1qfYxtCZwWpQ=; b=N+nmGwdRiVSGHwqqA03XyqvDpm
        IuBpM2uwgrqgd7sIU7T9vvV1LdXZW/mTX2vRsF9NTlbp/PSpbQ3XWO7EUA4TrJ4qgizXwbTEIyzXR
        V/pXdEA4vCK9ZWMlgHr6RqGo5yw94/mtQdTXM8GvDl3oCXsq2ncI2UVVykxj4LMVITYeNyFI4gbDw
        wYKc7mc0nx2z2ZKTm9EKSyiSGhwt4DlC++iz7dxqxxrWI3kqmliPTnUr0WhDC1zGBFCgbJu1kjezK
        fNIrV7mre3Nrql+9PZ7yeT4JZH6TtJ/gqgiEbIfKWVebYSX+ds2ez2yw0Q4L2A77Uj4uVkxwkIuZz
        qLtzgI2A==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvxU-0008MS-TN; Thu, 06 Dec 2018 15:53:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 7/9] mac53c94: remove DISABLE_CLUSTERING
Date:   Thu,  6 Dec 2018 07:52:56 -0800
Message-Id: <20181206155258.11465-8-hch@lst.de>
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

mac53c94 has no limitations on crossing pages for segments.  Just make
the 65535 byte segment size limit explicit, even if it matches the
current block layer limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/mac53c94.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index 177701dfdfcb..c8e6ae98a4a6 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -403,7 +403,7 @@ static struct scsi_host_template mac53c94_template = {
 	.can_queue	= 1,
 	.this_id	= 7,
 	.sg_tablesize	= SG_ALL,
-	.use_clustering	= DISABLE_CLUSTERING,
+	.max_segment_size = 65535,
 };
 
 static int mac53c94_probe(struct macio_dev *mdev, const struct of_device_id *match)
-- 
2.19.1

