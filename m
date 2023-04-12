Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FAAC7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjDLFc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDLFc4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:32:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F649FC
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8hnTL5VbbmBKR8mcqGndv6fVJkaIQQR+/kjZzSfIARI=; b=dKDslKyc4j98QBeHtpMGGqwUMV
        bU42qMyVpbG1+aU2tuGj5jzpkVWkoKZEAwDpJUiQUCLuWr+aI8BhQ+WaNVhLAo0bcg9GvjFRKvnQp
        n7QKefdoxgqwzBlC8uGtS6DqzRHZ6aS+E3V4fTw3ANvIY97h8O8015xorRZCOu/sfTVJ60V3k6xkw
        JbualpmirGw35qnpENToIOH8+5/XtDG0L7VFTl6mYVIPvO/aUBdhZzA14SNUWB9wCucGsIu3+qAU1
        0aRq/syRkTHaGEcdoyDGLgW/AjJq0/zQiPpoCVd3MS7Uqh10DPjbpl0r7vipyXA2KEF27U3AQedTH
        tQomDD4g==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6E-001rEH-0g;
        Wed, 12 Apr 2023 05:32:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 01/18] blk-mq: don't plug for head insertions in blk_execute_rq_nowait
Date:   Wed, 12 Apr 2023 07:32:31 +0200
Message-Id: <20230412053248.601961-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Plugs never insert at head, so don't plug for head insertions.

Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 52f8e0099c7f4b..7908d19f140815 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1299,7 +1299,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 	 * device, directly accessing the plug instead of using blk_mq_plug()
 	 * should not have any consequences.
 	 */
-	if (current->plug)
+	if (current->plug && !at_head)
 		blk_add_rq_to_plug(current->plug, rq);
 	else
 		blk_mq_sched_insert_request(rq, at_head, true, false);
-- 
2.39.2

