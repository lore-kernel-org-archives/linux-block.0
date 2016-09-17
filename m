Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36050 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755250AbcIQI2j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Sep 2016 04:28:39 -0400
Received: by mail-pa0-f52.google.com with SMTP id id6so32978053pad.3
        for <linux-block@vger.kernel.org>; Sat, 17 Sep 2016 01:28:39 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@fb.com>
Subject: [PATCH v4 2/6] sbitmap: allocate wait queues on a specific node
Date: Sat, 17 Sep 2016 01:28:22 -0700
Message-Id: <b0139db1c481aeb4b5484dba4a23328e7800b8d7.1474100040.git.osandov@fb.com>
In-Reply-To: <cover.1474100040.git.osandov@fb.com>
References: <cover.1474100040.git.osandov@fb.com>
In-Reply-To: <cover.1474100040.git.osandov@fb.com>
References: <cover.1474100040.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The original bt_alloc() we converted from was using kzalloc(), not
kzalloc_node(), to allocate the wait queues. This was probably an
oversight, so fix it for sbitmap_queue_init_node().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 lib/sbitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index dfc084a..4d8e97e 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -208,7 +208,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	sbq->wake_batch = sbq_calc_wake_batch(depth);
 	atomic_set(&sbq->wake_index, 0);
 
-	sbq->ws = kzalloc(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags);
+	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
 		sbitmap_free(&sbq->sb);
 		return -ENOMEM;
-- 
2.9.3

