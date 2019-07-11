Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F788C74A4B
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 11:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1450E21019
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 11:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lq5moF9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfGKLRd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:17:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfGKLRd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 07:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=teEjOplBHjabhctpyxIukvPI327eLEHlXVMxza1ioqA=; b=lq5moF9HJhTFH2vPGr+ybdibX
        l9mE2j3h2Rn4dje+84c1DDdncsi7jvsucSgYBJOUx4XmlAXQAabvYUZ2DvDWKnCDqYSY3Getcwoep
        P0iU0ze9qyDl6lzdVdgKjx/UeWdlzxJus0DsnEtzJvS3vnVBuBIaUyXl+eZiAXgZSzmbVz4jYJdrW
        5/Q/Uicmiez2cnejTmBaHUlkjU2TCkPo6NrDb5tsHId78ZFOpbTeQjxolDTzF7Zs71Nc+LrZyBls5
        l1lOI5uaV7z/vRSHRNOcFt4uz2Vr2J+jUY5NhgeZbEfjzkPsLcvdzieGubRFAk7pAz8rW5J2lrgG/
        NcRNHk4jg==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlX4q-0002HU-PA; Thu, 11 Jul 2019 11:17:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     damien.lemoal@wdc.com, linux-block@vger.kernel.org
Subject: [PATCH] block: tidy up blk_mq_plug
Date:   Thu, 11 Jul 2019 13:17:14 +0200
Message-Id: <20190711111714.4802-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the zoned device write path the special case and just fall
though to the defaul case to make the code easier to read.  Also
update the top of function comment to use the proper kdoc format
and remove the extra in-function comments that just duplicate it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 32c62c64e6c2..ab80fd2b3803 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -233,7 +233,7 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 		qmap->mq_map[cpu] = 0;
 }
 
-/*
+/**
  * blk_mq_plug() - Get caller context plug
  * @q: request queue
  * @bio : the bio being submitted by the caller context
@@ -254,15 +254,9 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
 					   struct bio *bio)
 {
-	/*
-	 * For regular block devices or read operations, use the context plug
-	 * which may be NULL if blk_start_plug() was not executed.
-	 */
-	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))
-		return current->plug;
-
-	/* Zoned block device write operation case: do not plug the BIO */
-	return NULL;
+	if (blk_queue_is_zoned(q) && op_is_write(bio_op(bio)))
+		return NULL;
+	return current->plug;
 }
 
 #endif
-- 
2.20.1

