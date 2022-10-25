Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01629FA3741
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiJYOkg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiJYOkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC3175382
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OgogIQv5ozkAFUETwB3waP6eD0GYiCdS1Pc10C/c+3g=; b=19cXos6LvVK9nZZ9Y2akRKza9D
        JtLVhsqTRbLn2fh9H6Au0f/hkumAfPGlfM8fPC1GLgVDZfFY1MKmO8vpGZqH09yecRUaQ/Ptheg7F
        YglrSFRqVmmcXAnwSg7sCd+dU6VSqbGn42UORRWmf1z3m+rYgl5SRMNudmQemqL4+AyIXHjrrh1fD
        BuhVz4p4gYCK/yZUGBxYIh3sK10B1C8a+l2z+F2qlRJeJ4xKn2OZ/Ta3FuNGYBpe3+NeAKaR4PFlA
        /P8wXm/k3h+qcYdbw6t5zigw/WFn5Gc+ZkVsCoNKwAQWTRnIxGSm3Lwb8lXiFLohVObEc6r3oFP8v
        NcS1nLvw==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6O-005poN-Q1; Tue, 25 Oct 2022 14:40:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 13/17] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Date:   Tue, 25 Oct 2022 07:40:16 -0700
Message-Id: <20221025144020.260458-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For submit_bio based queues there is no (S)RCU critical section during
I/O submission and thus nothing to wait for in blk_mq_wait_quiesce_done,
so skip doing any synchronization.  No non-mq driver should be calling
this, but for now we have core callers that unconditionally call into it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 098432d3caf1c..802fdd3d737e3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -280,7 +280,9 @@ EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
 void blk_mq_quiesce_queue(struct request_queue *q)
 {
 	blk_mq_quiesce_queue_nowait(q);
-	blk_mq_wait_quiesce_done(q);
+	/* nothing to wait for non-mq queues */
+	if (queue_is_mq(q))
+		blk_mq_wait_quiesce_done(q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
-- 
2.30.2

