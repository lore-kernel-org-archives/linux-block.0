Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7899DC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbjDFOnN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjDFOmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE70AF3A
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=al8zLM9Ic7CC0VUR/uH9Jjzv8yEWaSLP1IoPzglULr4=; b=Vl6DV0vgPerIIsI3H3er4jjF7t
        4kzOyOu94rgJU0kn2Yplb/3786autjpYwXW4P5Db00FIpfWohU3ZC5XCj+oQnosdwmXG/qS7lHeLp
        8rAs2OvhQy/B0wXZ/6Hqwc0aFlfViVnNoagiha5EOxpCjWYNFAmwFILwcOJavhFl1RFZN5uaRA43c
        BE3dCI0BQu4OWszwJXmhBDSMLALgoc+dUtyRkIqKvar3mWCtKDM+a4QiEUxNqV0jMtBRobYjw6+md
        rS+ZvwK9UIr+qScZsfUyDyOVopJ2eGgooBuJDqgiJ6C8MRusle//fcZUXkrCPb9oBAk+bx2+Th8GX
        6QsqqQWw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQne-007fhe-0Z;
        Thu, 06 Apr 2023 14:41:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 05/16] zram: return early on error in zram_bvec_rw
Date:   Thu,  6 Apr 2023 16:40:51 +0200
Message-Id: <20230406144102.149231-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
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
index 7adc6b02b531d6..0b8e49aa3be24b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1939,23 +1939,23 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
 
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

