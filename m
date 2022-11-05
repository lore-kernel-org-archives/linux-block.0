Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBD8C43217
	for <linux-block@archiver.kernel.org>; Sat,  5 Nov 2022 08:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiKEII2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Nov 2022 04:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKEIIZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2022 04:08:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74BFB09
        for <linux-block@vger.kernel.org>; Sat,  5 Nov 2022 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=crEwypbPthAf0SoYH9S8dhl48eqaJ23MRKCDlUDUMwg=; b=UlkZMU+BvsP1WnrqaecnVy3H/T
        681PD4dPBywL+qUgBemRwKaoPaTFRfAmirMN0Rkyi/DneurdnT6WLn4T1NALVS+KciRZePSSb7uwC
        LyNWUDLSBkNmhocZylmWNecsXyJc2cKBQGFm11RIzlcd2zfV+lnpNQvqJWVTJ5TakPfefT7bKISJ0
        alxYmckaLYlHuw10wXOpLzjmuhe5l/RoHZ0azxH5T6o3qzQMbEBAbrUckQrpj3X6SZfXRr0exIF8V
        4xtcmSEm75R4f1zIu0qjdPyv0LXaUyJzd9eZ33WMISYVkPmvJ8BheAmZrPjp4hQVF6cWxFHvEktgN
        5pAj1m1A==;
Received: from [2001:4bb8:182:29ca:2575:8443:617d:3eec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1orEE2-0064K1-Un; Sat, 05 Nov 2022 08:08:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: mark blk_put_queue as potentially blocking
Date:   Sat,  5 Nov 2022 09:08:15 +0100
Message-Id: <20221105080815.775721-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221105080815.775721-1-hch@lst.de>
References: <20221105080815.775721-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can't just say that the last reference release may block, as any
reference dropped could be the last one.  So move the might_sleep() from
blk_free_queue to blk_put_queue and update the documentation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d14317bfdf654..8ab21dd01cd1c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -260,8 +260,6 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 
 static void blk_free_queue(struct request_queue *q)
 {
-	might_sleep();
-
 	percpu_ref_exit(&q->q_usage_counter);
 
 	if (q->poll_stat)
@@ -285,11 +283,11 @@ static void blk_free_queue(struct request_queue *q)
  * Decrements the refcount of the request_queue and free it when the refcount
  * reaches 0.
  *
- * Context: Any context, but the last reference must not be dropped from
- *          atomic context.
+ * Context: Can sleep.
  */
 void blk_put_queue(struct request_queue *q)
 {
+	might_sleep();
 	if (refcount_dec_and_test(&q->refs))
 		blk_free_queue(q);
 }
-- 
2.30.2

