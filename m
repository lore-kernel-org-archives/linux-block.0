Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33354 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdA0UZV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 15:25:21 -0500
Received: by mail-pg0-f54.google.com with SMTP id 204so83877992pge.0
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2017 12:24:56 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH] blk-mq: fix compilation in !CONFIG_DEBUG_FS case
Date: Fri, 27 Jan 2017 12:18:02 -0800
Message-Id: <9980eb1d180dc482953b8e473f607bec7411e2b1.1485548245.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

My bad for not testing it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 57cdbf6c0cee..f7b41dc5eb60 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -95,21 +95,22 @@ static inline void blk_mq_debugfs_init(void)
 {
 }
 
-int blk_mq_debugfs_register(struct request_queue *q, const char *name);
+static inline int blk_mq_debugfs_register(struct request_queue *q,
+					  const char *name)
 {
 	return 0;
 }
 
-void blk_mq_debugfs_unregister(struct request_queue *q)
+static inline void blk_mq_debugfs_unregister(struct request_queue *q)
 {
 }
 
-int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+static inline int blk_mq_debugfs_register_hctxs(struct request_queue *q)
 {
 	return 0;
 }
 
-void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
+static inline void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 {
 }
 #endif
-- 
2.11.0

