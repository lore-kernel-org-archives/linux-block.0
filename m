Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F966C54FCB
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654D8206B6
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o6lH4Y1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgDYRKC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYRKC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 13:10:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937C5C09B04D
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IRDWfJk7A5BO9vbCNklpTf/6nPZ1vyaeT1MEgNALCAE=; b=o6lH4Y1qxZuzJHGaVvysEhVy40
        Zd5ueFVjt7kPtiibs7qjYzkVYYKKCoZ+15gfeCB0KMShAvjmtUIroIm6mbPc5uHut+2AZ483oty2C
        UwvSAPR7DDYgoayOcvlzRQs+fkqVAKRBogemlmTcpjBONzrE0T4t+n5kCj9MH82n/gALoWifOP8j/
        sK59qKTpg7mgS+01Y8fmKxP4hzJs7amw8A4UqoD7HRLlU1msNEDNguxOnuuoIDs8o+E3ckTWoCfnp
        m1TEa3E4ii/oj8rLL8v9OSX4PnKRDneNPBswEuiiodV6QkOfMOuF7gSyZpDf/L490vuvTbmavACMo
        sowAU95Q==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSOJV-0001lG-RV; Sat, 25 Apr 2020 17:10:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 06/11] block: optimize generic_make_request for direct to blk-mq issue
Date:   Sat, 25 Apr 2020 19:09:39 +0200
Message-Id: <20200425170944.968861-7-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425170944.968861-1-hch@lst.de>
References: <20200425170944.968861-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't bother with the on-stack bio list if we know that we directly
issue to a request based driver that can't re-inject bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 732d5b8d3cd25..e8c48203b2c55 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1008,6 +1008,18 @@ generic_make_request_checks(struct bio *bio)
 	return false;
 }
 
+static inline blk_qc_t __direct_make_request(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	blk_qc_t ret;
+
+	if (unlikely(bio_queue_enter(bio)))
+		return BLK_QC_T_NONE;
+	ret = blk_mq_make_request(q, bio);
+	blk_queue_exit(q);
+	return ret;
+}
+
 static blk_qc_t do_make_request(struct bio *bio,
 		struct bio_list bio_list_on_stack[2])
 {
@@ -1116,7 +1128,10 @@ blk_qc_t generic_make_request(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
-	return __generic_make_request(bio);
+	if (bio->bi_disk->queue->make_request_fn)
+		return __generic_make_request(bio);
+	return __direct_make_request(bio);
+
 }
 EXPORT_SYMBOL(generic_make_request);
 
@@ -1130,20 +1145,14 @@ EXPORT_SYMBOL(generic_make_request);
  */
 blk_qc_t direct_make_request(struct bio *bio)
 {
-	struct request_queue *q = bio->bi_disk->queue;
-	blk_qc_t ret;
-
-	if (WARN_ON_ONCE(q->make_request_fn)) {
+	if (WARN_ON_ONCE(bio->bi_disk->queue->make_request_fn)) {
 		bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
+
 	if (!generic_make_request_checks(bio))
 		return BLK_QC_T_NONE;
-	if (unlikely(bio_queue_enter(bio)))
-		return BLK_QC_T_NONE;
-	ret = blk_mq_make_request(q, bio);
-	blk_queue_exit(q);
-	return ret;
+	return __direct_make_request(bio);
 }
 EXPORT_SYMBOL_GPL(direct_make_request);
 
-- 
2.26.1

