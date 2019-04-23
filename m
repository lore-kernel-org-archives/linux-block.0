Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC23C282DD
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 12:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589BF2175B
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 12:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfDWM37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727674AbfDWM37 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 08:29:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7367AE56;
        Tue, 23 Apr 2019 12:29:57 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 2/5] blk-mq: drop 'hctx_idx' argument from blk_mq_alloc_hctx()
Date:   Tue, 23 Apr 2019 14:29:48 +0200
Message-Id: <20190423122951.134531-3-hare@suse.de>
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
 block/blk-mq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6f016d0cc69b..d16672bfa97d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2324,8 +2324,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
 static struct blk_mq_hw_ctx *
 blk_mq_alloc_hctx(struct request_queue *q,
-		  struct blk_mq_tag_set *set,
-		  unsigned hctx_idx, int node)
+		  struct blk_mq_tag_set *set, int node)
 {
 	struct blk_mq_hw_ctx *hctx;
 
@@ -2753,7 +2752,7 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 	spin_unlock(&q->unused_hctx_lock);
 
 	if (!hctx)
-		hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
+		hctx = blk_mq_alloc_hctx(q, set, node);
 	if (!hctx)
 		goto fail;
 
-- 
2.16.4

