Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35210 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdDNIBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2017 04:01:07 -0400
Received: by mail-pg0-f54.google.com with SMTP id 72so32637091pge.2
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2017 01:01:07 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v4 2/5] blk-mq: add shallow depth option for blk_mq_get_tag()
Date: Fri, 14 Apr 2017 00:59:59 -0700
Message-Id: <21ada8d490f8b662fd0866e651622f2dd64e73fb.1492156558.git.osandov@fb.com>
In-Reply-To: <cover.1492156558.git.osandov@fb.com>
References: <cover.1492156558.git.osandov@fb.com>
In-Reply-To: <cover.1492156558.git.osandov@fb.com>
References: <cover.1492156558.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Wire up the sbitmap_get_shallow() operation to the tag code so that a
caller can limit the number of tags available to it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-tag.c | 5 ++++-
 block/blk-mq.h     | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9d97bfc4d465..d0be72ccb091 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -96,7 +96,10 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 	if (!(data->flags & BLK_MQ_REQ_INTERNAL) &&
 	    !hctx_may_queue(data->hctx, bt))
 		return -1;
-	return __sbitmap_queue_get(bt);
+	if (data->shallow_depth)
+		return __sbitmap_queue_get_shallow(bt, data->shallow_depth);
+	else
+		return __sbitmap_queue_get(bt);
 }
 
 unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 7e6f2e467696..524f44742816 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -141,6 +141,7 @@ struct blk_mq_alloc_data {
 	/* input parameter */
 	struct request_queue *q;
 	unsigned int flags;
+	unsigned int shallow_depth;
 
 	/* input & output parameter */
 	struct blk_mq_ctx *ctx;
-- 
2.12.2
