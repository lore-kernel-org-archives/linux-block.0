Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AD5C43217
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 04:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiKNE05 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Nov 2022 23:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbiKNE0z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Nov 2022 23:26:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7941C167E1
        for <linux-block@vger.kernel.org>; Sun, 13 Nov 2022 20:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=crEwypbPthAf0SoYH9S8dhl48eqaJ23MRKCDlUDUMwg=; b=dWSu99u5Z175Za89siPwBmlpSb
        94q5QeEHEgsKHwb45UR8b0oy6ulI0N+d0VsjVtdLKb9j5Lh4r46Vvq9IsyGuDIkq0qOogge2ebvmw
        eVTqkBoBUX6wI3YCLbkUDShJj6ePMQRfHYnk69dCGPcC1WGnD+lsAP/ukj2WO/XQTbS6AJ6mAO4Ci
        RQkGEI9HdpTH9JbmYuegMz6D5TGnHj3DqRnagEdPbe+Cu+N9ZGzqcHti/YLH3FXp/IG1P7M1kOMcf
        4+4cC7TU3ay4/nGdtluCIEYtv6LU/5bygAIXSwK2uyFW1IBvGjcyAogvm8AyfkG6U2FEr6NjHfwbQ
        7gNHJWzg==;
Received: from [2001:4bb8:191:2606:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouR3c-00Fv86-Sd; Mon, 14 Nov 2022 04:26:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 5/5] block: mark blk_put_queue as potentially blocking
Date:   Mon, 14 Nov 2022 05:26:37 +0100
Message-Id: <20221114042637.1009333-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114042637.1009333-1-hch@lst.de>
References: <20221114042637.1009333-1-hch@lst.de>
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

