Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68821C77B60
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjDDPF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjDDPFz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:05:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B23C05
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fMS40iXJa71LmN6xX/XbckcO7Y//89KuzfFDoE/2Ixs=; b=S7Fh5PHkgidtuux4uyGzszQlFZ
        vwWBfxEe2jEfl4aWJg+enuA7k2vvG2FzCTMAa3C+E16s5+OU6WjBAlxm1YMCWh/1I91LK55prwdm/
        981nF9oi/JQ1vgF9j3M1LRUXPPK+KLqXvW6vL4ie1kO/Z8IQjvuJxqcJSCBBqPg7RvxhLZu9/F081
        0bw5IvaU3idRt9QG+Y1D7qm47gvcn6W9AlTvYijTKb/j0zfD3bMoaIL1yHFm7v9QjVIm06Sbw7//e
        gb6FZiDF7p4Veeuh1PIlGVI8feGIwkLuFr373iWw4Atu60b9RPQLQT1Z+XAEwpO6ckc62KpipLQid
        rmf71GKg==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiEK-001vqk-1h;
        Tue, 04 Apr 2023 15:05:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 05/16] zram: return early on error in zram_bvec_rw
Date:   Tue,  4 Apr 2023 17:05:25 +0200
Message-Id: <20230404150536.2142108-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the low-level access fails, don't clear the idle flag or clear
the caches, and just return.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6522b888839cb1..6196187e9ac36f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1939,23 +1939,23 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
 
 	if (!op_is_write(op)) {
 		ret = zram_bvec_read(zram, bvec, index, offset, bio);
+		if (unlikely(ret < 0)) {
+			atomic64_inc(&zram->stats.failed_writes);
+			return ret;
+		}
 		flush_dcache_page(bvec->bv_page);
 	} else {
 		ret = zram_bvec_write(zram, bvec, index, offset, bio);
+		if (unlikely(ret < 0)) {
+			atomic64_inc(&zram->stats.failed_reads);
+			return ret;
+		}
 	}
 
 	zram_slot_lock(zram, index);
 	zram_accessed(zram, index);
 	zram_slot_unlock(zram, index);
-
-	if (unlikely(ret < 0)) {
-		if (!op_is_write(op))
-			atomic64_inc(&zram->stats.failed_reads);
-		else
-			atomic64_inc(&zram->stats.failed_writes);
-	}
-
-	return ret;
+	return 0;
 }
 
 static void __zram_make_request(struct zram *zram, struct bio *bio)
-- 
2.39.2

