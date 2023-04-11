Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DA0C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDKNdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDKNdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:33:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B97330FE
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AZsjObN7Qh7UZ9W/DpY4UKrhDcveu/XrjNgEP6f2bg0=; b=Or9IasAYN0tAHKyPd1gKd9Lh6o
        L3JtxT8glveghXqj1risfgQFncr0cDvYhel4gwq75Q+/zOB7c3Ex4Lxoa4gTU1SIr4/4sN4+FQeRD
        xUuVWBbSjw9xGMH6oIkUOPp53g6NgMKLMqE0ZmfTQmllFJmerRRxDJsUoobyQSR537CUAGSNqZ8h+
        zkPHxnRV46RRyz0GEqiQMI5FyvxCYVtnXTaIgbX1B6eRrQmvKC7XgijxKritnxyLeSkL0ZXHBkvLi
        AgHAeFO1pqQbz7cYcrLwjs7LD9pP736xWWiwiJB3kx4+lh9UxVsQjs6e/KjEaqJCsVWA0xKB9EfR6
        gTU0fkEw==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE7v-0007r9-0p;
        Tue, 11 Apr 2023 13:33:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 01/16] blk-mq: don't plug for head insertations in blk_execute_rq_nowait
Date:   Tue, 11 Apr 2023 15:33:14 +0200
Message-Id: <20230411133329.554624-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Plugs never insert at head, so don't plug for head insertations.

Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
Signed-off-by: Christoph Hellwig <hch@lst.de>
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

