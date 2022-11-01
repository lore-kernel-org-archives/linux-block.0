Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557DEC433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiKAPIq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKAPIP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:08:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F6922B2A
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vFIffKMuruxaQXIDQ4KlSxJoVoIR2c5sW2+Wi5AWYDI=; b=DtetXMpKTvWn3HezyW+8KtmYTv
        RvZOTXigRlmLrfHy9FPjMf9y1in4QugdE5e+SDkMJ9WzVBxjnjGUFw9aEhX0LKqfBkWOCdIgTbol4
        GTfAML6bK6CBT1AqH/3UJGIzqtmBUEJAWxHryXu3XrDvdXame5pBrlutovfxwwEd8pw84pBgJYx1M
        YSUQ4P6GBFDdkayI47yScvsOGq2bdCNK4Fid0o1oLl6crNrtknhLk3z399K/0wYplFynNTgtZ0UYg
        HZ6s9N1wwC7u76MPM3OLOe9IkEAzm4O5O86l4+aClhsc5RV8UmoscVzNRpaqnMG17G6C+wpjsKBmZ
        pkZ/c/QQ==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opsla-005gqg-2H; Tue, 01 Nov 2022 15:01:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/14] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Date:   Tue,  1 Nov 2022 16:00:46 +0100
Message-Id: <20221101150050.3510-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
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
index 623e8a506539c..b8f37cfd3ae22 100644
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

