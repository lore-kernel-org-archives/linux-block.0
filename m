Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35593 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbdEDHbu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 03:31:50 -0400
Received: by mail-pf0-f172.google.com with SMTP id v14so3725115pfd.2
        for <linux-block@vger.kernel.org>; Thu, 04 May 2017 00:31:49 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH v2 07/12] blk-mq: Do not invoke queue operations on a dead queue
Date: Thu,  4 May 2017 00:31:29 -0700
Message-Id: <71712db1ecbe0432055c4976314a57485fff7f18.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
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
index 1579af6fcbed..347fbb8e059c 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -102,6 +102,14 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 	struct request_queue *q = data;
 	char opbuf[16] = { }, *op;
 
+	/*
+	 * The "state" attribute is removed after blk_cleanup_queue() has called
+	 * blk_mq_free_queue(). Return if QUEUE_FLAG_DEAD has been set to avoid
+	 * triggering a use-after-free.
+	 */
+	if (blk_queue_dead(q))
+		return -ENOENT;
+
 	if (count >= sizeof(opbuf)) {
 		pr_err("%s: operation too long\n", __func__);
 		goto inval;
-- 
2.12.2
