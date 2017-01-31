Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32977 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdAaXBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 18:01:06 -0500
Received: by mail-pf0-f175.google.com with SMTP id y143so112699878pfb.0
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 15:01:05 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 6/6] blktrace: use existing disk debugfs directory
Date: Tue, 31 Jan 2017 14:53:22 -0800
Message-Id: <d5352b86e54c7596cfb8c511868b54b724110d09.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We may already have a directory to put the blktrace stuff in if

1. The disk uses blk-mq
2. CONFIG_BLK_DEBUG_FS is enabled
3. We are tracing the whole disk and not a partition

Instead of hardcoding this very specific case, let's use the new
debugfs_lookup(). If the directory exists, we use it, otherwise we
create one and clean it up later.

Fixes: 07e4fead45e6 ("blk-mq: create debugfs directory tree")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 kernel/trace/blktrace.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 38052f625a0f..cc9d23692a35 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -470,12 +470,12 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!blk_debugfs_root)
 		goto err;
 
-	dir = debugfs_create_dir(buts->name, blk_debugfs_root);
-
+	dir = debugfs_lookup(buts->name, blk_debugfs_root);
+	if (!dir)
+		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 	if (!dir)
 		goto err;
 
-	bt->dir = dir;
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
@@ -517,9 +517,12 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (atomic_inc_return(&blk_probes_ref) == 1)
 		blk_register_tracepoints();
 
-	return 0;
+	ret = 0;
 err:
-	blk_trace_free(bt);
+	if (dir && !bt->dir)
+		dput(dir);
+	if (ret)
+		blk_trace_free(bt);
 	return ret;
 }
 
-- 
2.11.0

