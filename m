Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34679 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756404AbdECTTO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 15:19:14 -0400
Received: by mail-pg0-f54.google.com with SMTP id v1so83102367pgv.1
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 12:19:14 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH 4/9] blk-mq: Do not invoke queue operations on a dead queue
Date: Wed,  3 May 2017 12:18:57 -0700
Message-Id: <e3f2929bbfacac5ad5b02cf3de39ecd5e6287e40.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Bart Van Assche <bart.vanassche@sandisk.com>

In commit e869b5462f83 ("blk-mq: Unregister debugfs attributes
earlier"), we shuffled the debugfs cleanup around so that the "state"
attribute was removed before we freed the blk-mq data structures.
However, later changes are going to undo that, so we need to explicitly
disallow running a dead queue.

[Omar: rebased and updated commit message]
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 block/blk-mq-debugfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 00cc89c34590..48b9f59acd91 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -102,6 +102,14 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 	struct request_queue *q = data;
 	char op[16] = { }, *s;
 
+	/*
+	 * The "state" attribute is removed after blk_cleanup_queue() has called
+	 * blk_mq_free_queue(). Return if QUEUE_FLAG_DEAD has been set to avoid
+	 * triggering a use-after-free.
+	 */
+	if (blk_queue_dead(q))
+		return -ENOENT;
+
 	if (copy_from_user(op, buf, min(count, sizeof(op) - 1)))
 		return -EFAULT;
 	s = op;
-- 
2.12.2
