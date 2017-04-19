Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757515AbdDSAcG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2017 20:32:06 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] blk-mq: export blk_mq_get_driver_tag
Date: Wed, 19 Apr 2017 08:31:40 +0800
Message-Id: <20170419003142.9581-2-ming.lei@redhat.com>
In-Reply-To: <20170419003142.9581-1-ming.lei@redhat.com>
References: <20170419003142.9581-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Before blk-mq iosched is introduced, drivers may suppose
the the allocated request includes one valid tag number,
but it becomes not true any more after we bring mq iosched in.

So introduces this helper to make driver get req's hw tag.

Mtip32xx needs this helper for sending internal command via
one request.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 1 +
 include/linux/blk-mq.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 572966f49596..4614ab8b941e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -865,6 +865,7 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 		*hctx = data.hctx;
 	return rq->tag != -1;
 }
+EXPORT_SYMBOL(blk_mq_get_driver_tag);
 
 static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 				    struct request *rq)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9382c5da7a2e..ecb7b681aa7c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -255,6 +255,9 @@ int blk_mq_reinit_tagset(struct blk_mq_tag_set *set);
 int blk_mq_map_queues(struct blk_mq_tag_set *set);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
+bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
+			   bool wait);
+
 /*
  * Driver command data is immediately after the request. So subtract request
  * size to get back to the original request, add request size to get the PDU.
-- 
2.9.3
