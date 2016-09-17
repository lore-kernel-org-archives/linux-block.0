Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36402 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758480AbcIQI2n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Sep 2016 04:28:43 -0400
Received: by mail-pf0-f182.google.com with SMTP id q2so14511957pfj.3
        for <linux-block@vger.kernel.org>; Sat, 17 Sep 2016 01:28:43 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@fb.com>
Subject: [PATCH v4 6/6] sbitmap: re-initialize allocation hints after resize
Date: Sat, 17 Sep 2016 01:28:26 -0700
Message-Id: <bdfa41b6f22207f650ab743e87fec2cd7fd8b327.1474100040.git.osandov@fb.com>
In-Reply-To: <cover.1474100040.git.osandov@fb.com>
References: <cover.1474100040.git.osandov@fb.com>
In-Reply-To: <cover.1474100040.git.osandov@fb.com>
References: <cover.1474100040.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

After a struct sbitmap_queue is resized smaller, the allocation hints
may still be set to bits beyond the new depth of the bitmap. This means
that, for example, if the number of blk-mq tags is reduced through
sysfs, more requests than the nominal queue depth may be in flight.

It's tempting to fix this at resize time by doing a one-time
reinitialization of the hints, but this can race with
__sbitmap_queue_get() updating the hint. Instead, check the hint before
we use it. This caused no measurable performance difference in my
synthetic benchmarks.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 lib/sbitmap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 928b82a..f736c52 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -246,10 +246,15 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_resize);
 
 int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 {
-	unsigned int hint;
+	unsigned int hint, depth;
 	int nr;
 
 	hint = this_cpu_read(*sbq->alloc_hint);
+	depth = READ_ONCE(sbq->sb.depth);
+	if (unlikely(hint >= depth)) {
+		hint = depth ? prandom_u32() % depth : 0;
+		this_cpu_write(*sbq->alloc_hint, hint);
+	}
 	nr = sbitmap_get(&sbq->sb, hint, sbq->round_robin);
 
 	if (nr == -1) {
@@ -258,7 +263,7 @@ int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 	} else if (nr == hint || unlikely(sbq->round_robin)) {
 		/* Only update the hint if we used it. */
 		hint = nr + 1;
-		if (hint >= sbq->sb.depth - 1)
+		if (hint >= depth - 1)
 			hint = 0;
 		this_cpu_write(*sbq->alloc_hint, hint);
 	}
-- 
2.9.3

