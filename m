Return-Path: <SRS0=DGx4=32=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D40AC33CAC
	for <linux-block@archiver.kernel.org>; Thu,  6 Feb 2020 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5A520659
	for <linux-block@archiver.kernel.org>; Thu,  6 Feb 2020 17:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBFRuJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:50:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:48858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgBFRuJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Feb 2020 12:50:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DFAF9AF3F;
        Thu,  6 Feb 2020 17:50:07 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] blk-mq: Update blk_mq_map_queue() documentation
Date:   Thu,  6 Feb 2020 18:50:05 +0100
Message-Id: <20200206175005.7426-1-dwagner@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 8ccdf4a37752 ("blk-mq: save queue mapping result into ctx
directly") changed the last argument name from cpu to ctx but missed
to update the documentation.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index eaaca8fc1c28..76921a970c32 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -97,7 +97,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
  * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
  * @q: request queue
  * @flags: request command flags
- * @cpu: cpu ctx
+ * @ctx: software queue state
  */
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 						     unsigned int flags,
-- 
2.25.0

