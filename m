Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45562 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHIWxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Aug 2018 18:53:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so3362051pfo.12
        for <linux-block@vger.kernel.org>; Thu, 09 Aug 2018 13:26:57 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [RFC PATCH 2/5] block: export blk_stat_enable_accounting()
Date: Thu,  9 Aug 2018 13:26:44 -0700
Message-Id: <0201bd7f86112ddbe7c190a1344b6a030cc2e971.1533846185.git.osandov@fb.com>
In-Reply-To: <cover.1533846185.git.osandov@fb.com>
References: <cover.1533846185.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Kyber will need this in a future change if it is built as a module.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 175c143ac5b9..d98f3ad6794e 100644
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
2.18.0
