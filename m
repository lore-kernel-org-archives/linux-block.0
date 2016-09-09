Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34020 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbcIISma (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2016 14:42:30 -0400
Received: by mail-pf0-f174.google.com with SMTP id p64so32004207pfb.1
        for <linux-block@vger.kernel.org>; Fri, 09 Sep 2016 11:42:29 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@fb.com>
Subject: [PATCH v3 2/5] sbitmap: allocate wait queues on a specific node
Date: Fri,  9 Sep 2016 11:42:08 -0700
Message-Id: <ab0ffdba530d6dffb86c47745c2976a9be53dd5d.1473446095.git.osandov@fb.com>
In-Reply-To: <cover.1473446095.git.osandov@fb.com>
References: <cover.1473446095.git.osandov@fb.com>
In-Reply-To: <cover.1473446095.git.osandov@fb.com>
References: <cover.1473446095.git.osandov@fb.com>
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
index 303d83e..213d831 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -208,7 +208,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 
 	atomic_set(&sbq->wake_index, 0);
 
-	sbq->ws = kzalloc(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags);
+	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
 		sbitmap_free(&sbq->sb);
 		return -ENOMEM;
-- 
2.9.3

