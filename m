Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45179 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S969516AbdD1Ozv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:55:51 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/7] blk-mq: add and export helper to tell if a request is reserved
Date: Fri, 28 Apr 2017 08:55:37 -0600
Message-ID: <1493391340-24629-5-git-send-email-axboe@fb.com>
In-Reply-To: <1493391340-24629-1-git-send-email-axboe@fb.com>
References: <1493391340-24629-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We only have an internal helper for checking a tag value. Add
an exported helper that takes a request and hardware queue,
and check against the driver tags.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq-tag.c     | 6 ++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d0be72ccb091..0a04b5c14076 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -476,3 +476,9 @@ u32 blk_mq_unique_tag(struct request *rq)
 		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
 }
 EXPORT_SYMBOL(blk_mq_unique_tag);
+
+bool blk_mq_rq_is_reserved(struct blk_mq_hw_ctx *hctx, struct request *rq)
+{
+	return blk_mq_tag_is_reserved(hctx->tags, rq->tag);
+}
+EXPORT_SYMBOL_GPL(blk_mq_rq_is_reserved);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 32bd8eb5ba67..13e51520fa27 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -224,6 +224,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 	return unique_tag & BLK_MQ_UNIQUE_TAG_MASK;
 }
 
+bool blk_mq_rq_is_reserved(struct blk_mq_hw_ctx *hctx, struct request *rq);
 
 int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
-- 
2.7.4
