Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA45C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 12:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93ED21738
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 12:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfDWM37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbfDWM37 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 08:29:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5A25ADD2;
        Tue, 23 Apr 2019 12:29:57 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 3/5] blk-mq: remove 'nr_queue' argument in blk_mq_exit_hw_queues()
Date:   Tue, 23 Apr 2019 14:29:49 +0200
Message-Id: <20190423122951.134531-4-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190423122951.134531-1-hare@suse.de>
References: <20190423122951.134531-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unused.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d16672bfa97d..3da453b11deb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2267,14 +2267,12 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
-		struct blk_mq_tag_set *set, int nr_queue)
+		struct blk_mq_tag_set *set)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (i == nr_queue)
-			break;
 		blk_mq_debugfs_unregister_hctx(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
 	}
@@ -2930,7 +2928,7 @@ void blk_mq_exit_queue(struct request_queue *q)
 	struct blk_mq_tag_set	*set = q->tag_set;
 
 	blk_mq_del_queue_tag_set(q);
-	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
+	blk_mq_exit_hw_queues(q, set);
 }
 
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
-- 
2.16.4

