Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8CAC4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 10:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiJTK47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 06:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiJTK4t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 06:56:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532F41E044B
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rdh/ukHkGwTBSIvYNfMZv3IMoj7GaM7F+XPHF6FU2sI=; b=r+KybVKR0R2+Dx/eYT9rApe4tR
        B3NlPpV9W+KB5N05rsWh83UckqOjIEQo7bigl38+TuW4pt/Fvz1A9qk7C4WaUHc/lMG5E/r8Php2l
        Fee7X1AvoC8kt7LbseRF4khmgQ0iU26kZgXMHxMBpHZu3KoV/nfVrB2uHPFXX+E7OhZF2xLNhacuf
        wJFQ5X9E0Wf+fIlxT2RsduNuKtcSokE+D1RJmh587J87lmLmVkeBuXjnjpghFK3qptBHaX1EYAukI
        XSBiSnJJ0S84wSYYasWj5GP8C4GS+c8XWhSL4RH8NUDxEBRzAydDG2MrEw+iBjwgJONk2DZ2iAyle
        8cBHE1bg==;
Received: from [88.128.92.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTDv-00Dqfc-90; Thu, 20 Oct 2022 10:56:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Date:   Thu, 20 Oct 2022 12:56:02 +0200
Message-Id: <20221020105608.1581940-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
References: <20221020105608.1581940-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For submit_bio based queues there is no (S)RCU critical section during
I/O submission and thus nothing to wait for in blk_mq_wait_quiesce_done,
so skip doing any synchronization.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 33292c01875d5..df967c8af9fee 100644
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

