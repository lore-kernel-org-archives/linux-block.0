Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35582 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdEDHbr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 03:31:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id v14so3724617pfd.2
        for <linux-block@vger.kernel.org>; Thu, 04 May 2017 00:31:46 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH v2 04/12] blk-mq-debugfs: don't open code strstrip()
Date: Thu,  4 May 2017 00:31:26 -0700
Message-Id: <65b6e5cb3c0be1eaa543a38e47512c2f45a0ace1.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Slightly more readable, plus we also strip leading spaces.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2a19237455d4..109ae9f3d400 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -111,17 +111,16 @@ static ssize_t blk_queue_flags_store(struct file *file, const char __user *buf,
 				     size_t count, loff_t *ppos)
 {
 	struct request_queue *q = file_inode(file)->i_private;
-	char op[16] = { }, *s;
+	char opbuf[16] = { }, *op;
 
-	if (count >= sizeof(op)) {
+	if (count >= sizeof(opbuf)) {
 		pr_err("%s: operation too long\n", __func__);
 		goto inval;
 	}
 
-	if (copy_from_user(op, buf, count))
+	if (copy_from_user(opbuf, buf, count))
 		return -EFAULT;
-	s = op;
-	strsep(&s, " \t\n"); /* strip trailing whitespace */
+	op = strstrip(opbuf);
 	if (strcmp(op, "run") == 0) {
 		blk_mq_run_hw_queues(q, true);
 	} else if (strcmp(op, "start") == 0) {
-- 
2.12.2
