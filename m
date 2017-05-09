Return-Path: <linux-block-owner@vger.kernel.org>
Received: from iad1-shared-relay2.dreamhost.com ([208.113.157.41]:45170 "EHLO
        iad1-shared-relay2.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752406AbdF3KVU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 06:21:20 -0400
Received: from iad1-shared-relay1.dreamhost.com (iad1-shared-relay1.dreamhost.com [208.113.157.50])
        by iad1-shared-relay2.dreamhost.com (Postfix) with ESMTP id CA38F3E5684
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:21:08 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
        by iad1-shared-relay1.dreamhost.com (Postfix) with ESMTP id 17A07B4009F
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:21:08 -0700 (PDT)
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
From: Tang Junhui <tang.junhui@zte.com.cn>
Date: Tue, 9 May 2017 12:07:13 -0700
Subject: [PATCH 03/19] bcache: do not subtract sectors_to_gc for bypassed IO
To: linux-block@vger.kernel.org
Message-Id: <20170629222107.D7B5F10012A@ware.dreamhost.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since bypassed IOs use no bucket, so do not subtract sectors_to_gc to
trigger gc thread.

Signed-off-by: tang.junhui <tang.junhui@zte.com.cn>
Reviewed-by: Eric Wheeler <bcache@linux.ewheeler.net>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 958072a..4b413db 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -196,12 +196,12 @@ static void bch_data_insert_start(struct closure *cl)
 	struct data_insert_op *op = container_of(cl, struct data_insert_op, cl);
 	struct bio *bio = op->bio, *n;
 
-	if (atomic_sub_return(bio_sectors(bio), &op->c->sectors_to_gc) < 0)
-		wake_up_gc(op->c);
-
 	if (op->bypass)
 		return bch_data_invalidate(cl);
 
+	if (atomic_sub_return(bio_sectors(bio), &op->c->sectors_to_gc) < 0)
+		wake_up_gc(op->c);
+
 	/*
 	 * Journal writes are marked REQ_PREFLUSH; if the original write was a
 	 * flush, it'll wait on the journal write.
-- 
1.8.3.1
