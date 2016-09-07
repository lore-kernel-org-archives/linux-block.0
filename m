Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34244 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbcIGXqU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2016 19:46:20 -0400
Received: by mail-pa0-f54.google.com with SMTP id to9so10872901pac.1
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2016 16:46:20 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/5] scale_bitmap: allocate wait queues on a specific node
Date: Wed,  7 Sep 2016 16:46:03 -0700
Message-Id: <e961019b6ad33891fe70ffdd9ee6b78ffa84c396.1473291702.git.osandov@fb.com>
In-Reply-To: <cover.1473291702.git.osandov@fb.com>
References: <cover.1473291702.git.osandov@fb.com>
In-Reply-To: <cover.1473291702.git.osandov@fb.com>
References: <cover.1473291702.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The original `bt_alloc()` we converted from was using `kzalloc()`, not
`kzalloc_node()`, to allocate the wait queues. This was probably an
oversight, so fix it for `scale_bitmap_queue_init_node()`.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 lib/scale_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scale_bitmap.c b/lib/scale_bitmap.c
index 4d47c19..237170c 100644
--- a/lib/scale_bitmap.c
+++ b/lib/scale_bitmap.c
@@ -212,7 +212,7 @@ int scale_bitmap_queue_init_node(struct scale_bitmap_queue *sbq,
 
 	atomic_set(&sbq->wake_index, 0);
 
-	sbq->ws = kzalloc(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags);
+	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
 		scale_bitmap_free(&sbq->map);
 		return -ENOMEM;
-- 
2.9.3

