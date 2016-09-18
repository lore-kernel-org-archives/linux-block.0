Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757896AbcIRHhe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:34 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 02/14] blk-mq: Fix a potential NULL pointer assignment to hctx tags
Date: Sun, 18 Sep 2016 09:37:12 +0200
Message-Id: <6eacfdd163d2c1a80f8b8280e480d94056896e2b.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If number of used hardware queues is dynamically decreased
then tags corresponding to the newly unused queues are freed.

If previously unused hardware queues are then reused again
they will start referring the previously freed tags.

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 66505af7..7fa58fe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1995,6 +1995,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		if (hctxs[i])
 			continue;
+		if (!set->tags[i])
+			break;
 
 		node = blk_mq_hw_queue_to_node(q->mq_map, i);
 		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
-- 
1.8.3.1

