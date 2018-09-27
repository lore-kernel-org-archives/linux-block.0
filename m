Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f180.google.com ([209.85.210.180]:34818 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeI1FRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Sep 2018 01:17:10 -0400
Received: by mail-pf1-f180.google.com with SMTP id p12-v6so2920499pfh.2
        for <linux-block@vger.kernel.org>; Thu, 27 Sep 2018 15:56:32 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH v2 2/5] block: export blk_stat_enable_accounting()
Date: Thu, 27 Sep 2018 15:55:52 -0700
Message-Id: <c836d32bf3d1f5f7a06050fde4a027654aed8d34.1538088475.git.osandov@fb.com>
In-Reply-To: <cover.1538088475.git.osandov@fb.com>
References: <cover.1538088475.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Kyber will need this in a future change if it is built as a module.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 7587b1c3caaf..90561af85a62 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -190,6 +190,7 @@ void blk_stat_enable_accounting(struct request_queue *q)
 	blk_queue_flag_set(QUEUE_FLAG_STATS, q);
 	spin_unlock(&q->stats->lock);
 }
+EXPORT_SYMBOL_GPL(blk_stat_enable_accounting);
 
 struct blk_queue_stats *blk_alloc_queue_stats(void)
 {
-- 
2.19.0
