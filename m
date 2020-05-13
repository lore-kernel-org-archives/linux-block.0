Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E80C2D0FC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3231C206B7
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NMq03b28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbgEMMgL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbgEMMgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:36:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A6BC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+GeFz6pp76lpQ8ukK/KmbfH1s2Fmo8dON3WRK/QjapY=; b=NMq03b28rStPDgv0AtEtNwKK1W
        QYgJ0EHJN9Rl+nX+TfE/4wQMq639k3pKdaXEE1oAUuXBYniYJ8DqpQ4OSWt6MOt7rrVeZs1WX+f1A
        QQvZtTe/zcXZY5qYM8gv/E30kSSDfFVCmFNhWAWwK2NAV2hea97FR211DAK/lk0bypmap4ssv9zxN
        gpy7ySmIm1/zfrN87Dm8o2VniaTzMLsLMnOqKM1qU+ltR1G4JJST3KdZ7MYI+UcE+jldlFfkFusj/
        qTKxJ33HRqQb92ju7hTCMKbR32c3KX2PfVxMLu8DIv3VhrsssfkkteUypJnWSwkILlXEs9pFAtXEp
        S7/y/OOg==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqcK-0004Qz-KC; Wed, 13 May 2020 12:36:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: remove the disk and queue NULL checks in blkdev_issue_flush
Date:   Wed, 13 May 2020 14:36:01 +0200
Message-Id: <20200513123601.2465370-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513123601.2465370-1-hch@lst.de>
References: <20200513123601.2465370-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Both of these never can be NULL for a live block device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index dc23d5177f9bb..d5f0ed740e79f 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -439,17 +439,9 @@ void blk_insert_flush(struct request *rq)
  */
 int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask)
 {
-	struct request_queue *q;
 	struct bio *bio;
 	int ret = 0;
 
-	if (bdev->bd_disk == NULL)
-		return -ENXIO;
-
-	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
-
 	bio = bio_alloc(gfp_mask, 0);
 	bio_set_dev(bio, bdev);
 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
-- 
2.26.2

