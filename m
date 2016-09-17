Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33223 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754376AbcIQTVE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Sep 2016 15:21:04 -0400
Received: by mail-pf0-f169.google.com with SMTP id 21so26797042pfy.0
        for <linux-block@vger.kernel.org>; Sat, 17 Sep 2016 12:21:03 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@fb.com>
Subject: [PATCH] sbitmap: don't update the allocation hint on clear after resize
Date: Sat, 17 Sep 2016 12:20:54 -0700
Message-Id: <29fb3ca2c78084b3548fd87c0c9a946e2b68bffc.1474139647.git.osandov@fb.com>
In-Reply-To: <54286aca-7ce6-5138-9189-83a2dff444b1@fb.com>
References: <54286aca-7ce6-5138-9189-83a2dff444b1@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

If we have a bunch of high-numbered bits allocated and then we resize
the struct sbitmap_queue, when those bits get cleared, we'll update the
hint and then have to re-randomize it repeatedly. Avoid that by checking
that the cleared bit is still a valid hint. No measurable performance
difference in the common case.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Jens,

Small tweak to patch 6 that occurred to me after I sent the series out.
Feel free to fold it in to patch 6 or apply it separately as you see
fit.

Thanks!

 lib/sbitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index f736c52..e408089 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -321,7 +321,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
 {
 	sbitmap_clear_bit(&sbq->sb, nr);
 	sbq_wake_up(sbq);
-	if (likely(!sbq->round_robin))
+	if (likely(!sbq->round_robin && nr < sbq->sb.depth))
 		*per_cpu_ptr(sbq->alloc_hint, cpu) = nr;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_clear);
-- 
2.9.3

