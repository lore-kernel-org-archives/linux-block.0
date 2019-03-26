Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03DAC43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4822075C
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 12:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCZMHP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:07:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbfCZMHO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 08:07:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE0B6AC94;
        Tue, 26 Mar 2019 12:07:13 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: don't call blk_mq_run_hw_queues() for dead or dying queues
Date:   Tue, 26 Mar 2019 13:07:12 +0100
Message-Id: <20190326120712.41657-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a queue is dying or dead there is no point in calling
blk_mq_run_hw_queues() in blk_mq_unquiesce_queue(); in fact, doing
so might crash the machine as the queue structures are in the
process of being deleted.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9c181603cbd..b1eeba38bc79 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -258,7 +258,8 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
 
 	/* dispatch requests which are inserted during quiescing */
-	blk_mq_run_hw_queues(q, true);
+	if (!blk_queue_dying(q) && !blk_queue_dead(q))
+		blk_mq_run_hw_queues(q, true);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
-- 
2.16.4

