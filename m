Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F45C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245A7610FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhJMRQz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhJMRQy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:16:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1231EC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Tptwe3VtOeOmnfgeb2i1pE7pocGZd0wrI/yLBhTUc+Q=; b=JBvm8qiD2eOF4BGi5SqBRYear4
        1HoaBxpDChiDcmiZQn6UfhhiE3xCk5Zgg6vOG+wu66B/4to2BibvdHBk2MRhpjfPlZM9k4AJtp2sL
        YYAilLeF5jayc/jhsmJt9GuGF00kQxMdqy7bzlD7PlP6syOUN4CTB+CslGQmFhuMrdiyfzGqj4EHj
        AXiY+mE3Ia4a9D+P6ib1fRV67hzHKWyN/wRIeskO59ejTR2wGxwnlfGwB81RD7AjipxzQLdE8oQrK
        keMJ+a93sXyPIXP5bgch9D6nQl25UUyjYW12s8GgRc1upBjN5hcFlu+NSo5/zaIEHeuhlftzwlvPS
        lc0V8KYQ==;
Received: from [2001:4bb8:199:73c5:265:8549:750e:c7f7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mahom-007eNn-An; Wed, 13 Oct 2021 17:13:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 1/6] block: factor out a chunk_size_left helper
Date:   Wed, 13 Oct 2021 19:12:10 +0200
Message-Id: <20211013171215.1177671-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013171215.1177671-1-hch@lst.de>
References: <20211013171215.1177671-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out a helper from blk_max_size_offset so that it can be reused
independently.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17705c970d7e1..c6ecd996c2d46 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -622,6 +622,18 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	return q->limits.max_sectors;
 }
 
+/*
+ * Return how much of the chunk sectors is left to be used for an I/O at the
+ * given offset.
+ */
+static inline unsigned int blk_chunk_sectors_left(sector_t offset,
+		unsigned int chunk_sectors)
+{
+	if (unlikely(!is_power_of_2(chunk_sectors)))
+		return chunk_sectors - sector_div(offset, chunk_sectors);
+	return chunk_sectors - (offset & (chunk_sectors - 1));
+}
+
 /*
  * Return maximum size of a request at given offset. Only valid for
  * file system requests.
@@ -637,12 +649,8 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
 			return q->limits.max_sectors;
 	}
 
-	if (likely(is_power_of_2(chunk_sectors)))
-		chunk_sectors -= offset & (chunk_sectors - 1);
-	else
-		chunk_sectors -= sector_div(offset, chunk_sectors);
-
-	return min(q->limits.max_sectors, chunk_sectors);
+	return min(q->limits.max_sectors,
+			blk_chunk_sectors_left(offset, chunk_sectors));
 }
 
 /*
-- 
2.30.2

