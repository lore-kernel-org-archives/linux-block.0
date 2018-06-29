Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42790 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965464AbeF2B5L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jun 2018 21:57:11 -0400
From: Liu Bo <bo.liu@linux.alibaba.com>
To: <linux-block@vger.kernel.org>
Subject: [PATCH] Blktrace: bail out early if block debugfs is not configured
Date: Fri, 29 Jun 2018 09:56:08 +0800
Message-Id: <1530237368-105049-1-git-send-email-bo.liu@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since @blk_debugfs_root couldn't be configured dynamically, we can
save a few memory allocation if it's not there.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 kernel/trace/blktrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 987d9a9ae283..b951aa1fac61 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -494,6 +494,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
+	if (!blk_debugfs_root)
+		return -ENOENT;
+
 	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
 	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
 
@@ -518,9 +521,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = -ENOENT;
 
-	if (!blk_debugfs_root)
-		goto err;
-
 	dir = debugfs_lookup(buts->name, blk_debugfs_root);
 	if (!dir)
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
-- 
1.8.3.1
