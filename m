Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43499C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDKRPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDKRPT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2885FF0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=S9/onjPMXW41EiRlJRfmEj2id+WMicqq8esrZm63UGw=; b=b4QEtafAWjVOvYcDOXvaDZfCmX
        XULDTCn4CdsBYdmn2X7yqFZmfMQGXCRfZBKUCbaNCGZz0jfrlwwESG8rhcSRPHC/eSoPm2iV1+VtD
        C8Kpv8kOVZfsEV2cWEqpimVdeDRSuXD+Ok3y2LvXlv1S6olQsojT+5Chy+xjwxbXPdvqfbIMDsT8x
        8TzRDfNCGfx8PcdSqcyuNcOn/xo4Urj0xy9I1ZVUX7rH9mDQgU6TpiKinHixJnxwU+OP8P1phS2g+
        ATzF2YDWoPRB4lryzLblTUeQ51Lh/rFFy8K+oqi9KVnOmzeNP0dtLMIHPiEw+w/y6h+/22aNuMvVg
        1F1NCIUw==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHaO-000gmF-22;
        Tue, 11 Apr 2023 17:15:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 06/17] zram: return early on error in zram_bvec_rw
Date:   Tue, 11 Apr 2023 19:14:48 +0200
Message-Id: <20230411171459.567614-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the low-level access fails, don't clear the idle flag or clear
the caches, and just return.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 00f13eb1c800c3..46dc7a2748672e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1933,23 +1933,23 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
 
 	if (!op_is_write(op)) {
 		ret = zram_bvec_read(zram, bvec, index, offset, bio);
+		if (unlikely(ret < 0)) {
+			atomic64_inc(&zram->stats.failed_reads);
+			return ret;
+		}
 		flush_dcache_page(bvec->bv_page);
 	} else {
 		ret = zram_bvec_write(zram, bvec, index, offset, bio);
+		if (unlikely(ret < 0)) {
+			atomic64_inc(&zram->stats.failed_writes);
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

