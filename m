Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35017 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdCRAN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 20:13:56 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so38377989pfx.2
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2017 17:12:14 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [RFC PATCH 2/4] blk-mq: add shallow depth option for blk_mq_get_tag()
Date: Fri, 17 Mar 2017 15:03:31 -0700
Message-Id: <15f01b81a47fd841684b692efcbbe4a49ce9e323.1489787289.git.osandov@fb.com>
In-Reply-To: <cover.1489787289.git.osandov@fb.com>
References: <cover.1489787289.git.osandov@fb.com>
In-Reply-To: <cover.1489787289.git.osandov@fb.com>
References: <cover.1489787289.git.osandov@fb.com>
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
index e48bc2c72615..1f25d466ebdc 100644
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
index 8d49c06fc520..77ec66369f21 100644
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
2.12.0
