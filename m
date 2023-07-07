Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55826C0015E
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 09:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjGGJnH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 05:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjGGJnA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 05:43:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27901BE9
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 02:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2jjPUU+RLUJPjT0djd+XgosiKYK1DO6QfrHaQmdqcYM=; b=PzV7BUTq0OxI13THOQvd67JR3w
        NNdcUnQhXwGoJjbBQakKc4gi8nYiIZknRi1jIdCU/AHINzycR8LB5PnBJQm6KXPNIvnyzbVGTI25q
        M22PhMbf7MCXXb3g7yzLP6MuHYZaVpSLuQaeaBcIeVbRE8ufvRbNX2GJyECnZN8YKq4eDCu/z0I6o
        jbIgmlri2kGyk1GPL2KiXrKpKGFRQeljuE2HyUvVkV5DrSWrVvTcQWVvAvTy4p04S/53YPJP59ssT
        kd2omFD9cpkjWw+GvrBKe5U3b3ycHUE/lt0jgjtUuRV2xgCRgwlfqTlcGgIrgpnEW/1SLdyc3K7t3
        rcrW9qbQ==;
Received: from [89.144.223.112] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHhzO-0049KD-0n;
        Fri, 07 Jul 2023 09:42:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: don't allow enabling a cache on devices that don't support it
Date:   Fri,  7 Jul 2023 11:42:39 +0200
Message-Id: <20230707094239.107968-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707094239.107968-1-hch@lst.de>
References: <20230707094239.107968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the write_cache attribute allows enabling the QUEUE_FLAG_WC
flag on devices that never claimed the capability.

Fix that by adding a QUEUE_FLAG_HW_WC flag that is set by
blk_queue_write_cache and guards re-enabling the cache through sysfs.

Note that any rescan that calls blk_queue_write_cache will still
re-enable the write cache as in the current code.

Fixes: 93e9d8e836cb ("block: add ability to flag write back caching on a device")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   |  7 +++++--
 block/blk-sysfs.c      | 11 +++++++----
 include/linux/blkdev.h |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 4dd59059b788eb..0046b447268f91 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -830,10 +830,13 @@ EXPORT_SYMBOL(blk_set_queue_depth);
  */
 void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 {
-	if (wc)
+	if (wc) {
+		blk_queue_flag_set(QUEUE_FLAG_HW_WC, q);
 		blk_queue_flag_set(QUEUE_FLAG_WC, q);
-	else
+	} else {
+		blk_queue_flag_clear(QUEUE_FLAG_HW_WC, q);
 		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
+	}
 	if (fua)
 		blk_queue_flag_set(QUEUE_FLAG_FUA, q);
 	else
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0cde6598fb2f4d..63e4812623361d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -449,13 +449,16 @@ static ssize_t queue_wc_show(struct request_queue *q, char *page)
 static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 			      size_t count)
 {
-	if (!strncmp(page, "write back", 10))
+	if (!strncmp(page, "write back", 10)) {
+		if (!test_bit(QUEUE_FLAG_HW_WC, &q->queue_flags))
+			return -EINVAL;
 		blk_queue_flag_set(QUEUE_FLAG_WC, q);
-	else if (!strncmp(page, "write through", 13) ||
-		 !strncmp(page, "none", 4))
+	} else if (!strncmp(page, "write through", 13) ||
+		 !strncmp(page, "none", 4)) {
 		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
-	else
+	} else {
 		return -EINVAL;
+	}
 
 	return count;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629f5..2f5371b8482c00 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -538,6 +538,7 @@ struct request_queue {
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
+#define QUEUE_FLAG_HW_WC	18	/* Write back caching supported */
 #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
 #define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
 #define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
-- 
2.39.2

