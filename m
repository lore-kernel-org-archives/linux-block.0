Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB93C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDKRPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjDKRPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E05FC2
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NaGh447c3Z5O8Q1bwlc/CmWQq2CtUmxa/8UXLYlOKnY=; b=AWyPUXA1ggJqNE7/uiKSf00eSE
        4XKDeG9aX5oFbo9YAcckIE99yPuDDxKmHsdQZeYnuDEssBQnaodnR52gzJvqdPojfayHViXG3Y9yD
        xcuI9Qd2xGw9PozQQuEz7AdtgWEtrHkqEbXpT61+MAjaPGnBViWLTdkn1Raze2xG9echvc1uohALa
        8JuaM//HVrSDN0Q4ovHZgwrJdE+YkzdB2wcKO1Q3tA9TMV2ytEXkMTQ5yaaknzWsiPFx1rIzwyzv+
        CKkwC0E/lpgy4wNt3K3QhdHBkwf2WWkdpwUpNReCxCQKkht9/q5tWKQsdlUOTZqy9ZnQVSQ12UXPY
        KvhGi2VA==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHaB-000gk2-1M;
        Tue, 11 Apr 2023 17:15:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 01/17] zram: always compile read_from_bdev_sync
Date:   Tue, 11 Apr 2023 19:14:43 +0200
Message-Id: <20230411171459.567614-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

read_from_bdev_sync is currently only compiled for non-4k PAGE_SIZE,
which means it won't be built with the most common configurations.

Replace the ifdef with a check for the PAGE_SIZE in an if instead.
The check uses an extra symbol and IS_ENABLED to allow the compiler
to eliminate the dead code, leading to the same generated code size:

   text	   data	    bss	    dec	    hex	filename
  16709	   1428	     12	  18149	   46e5	drivers/block/zram/zram_drv.o.old
  16709	   1428	     12	  18149	   46e5	drivers/block/zram/zram_drv.o.new

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aa490da3cef233..57787cbdf1f728 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -148,6 +148,7 @@ static inline bool is_partial_io(struct bio_vec *bvec)
 {
 	return bvec->bv_len != PAGE_SIZE;
 }
+#define ZRAM_PARTIAL_IO		1
 #else
 static inline bool is_partial_io(struct bio_vec *bvec)
 {
@@ -833,7 +834,6 @@ struct zram_work {
 	struct bio_vec bvec;
 };
 
-#if PAGE_SIZE != 4096
 static void zram_sync_read(struct work_struct *work)
 {
 	struct zram_work *zw = container_of(work, struct zram_work, work);
@@ -866,23 +866,17 @@ static int read_from_bdev_sync(struct zram *zram, struct bio_vec *bvec,
 
 	return 1;
 }
-#else
-static int read_from_bdev_sync(struct zram *zram, struct bio_vec *bvec,
-				unsigned long entry, struct bio *bio)
-{
-	WARN_ON(1);
-	return -EIO;
-}
-#endif
 
 static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
 			unsigned long entry, struct bio *parent, bool sync)
 {
 	atomic64_inc(&zram->stats.bd_reads);
-	if (sync)
+	if (sync) {
+		if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
+			return -EIO;
 		return read_from_bdev_sync(zram, bvec, entry, parent);
-	else
-		return read_from_bdev_async(zram, bvec, entry, parent);
+	}
+	return read_from_bdev_async(zram, bvec, entry, parent);
 }
 #else
 static inline void reset_bdev(struct zram *zram) {};
-- 
2.39.2

