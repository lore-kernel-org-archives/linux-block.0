Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35579 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdEDHbq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 03:31:46 -0400
Received: by mail-pf0-f171.google.com with SMTP id v14so3724436pfd.2
        for <linux-block@vger.kernel.org>; Thu, 04 May 2017 00:31:46 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH v2 03/12] blk-mq-debugfs: error on long write to queue "state" file
Date: Thu,  4 May 2017 00:31:25 -0700
Message-Id: <859ef1939e07171f902b4fbb5bebbb274d68df18.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

blk_queue_flags_store() currently truncates and returns a short write if
the operation being written is too long. This can give us weird results,
like here:

$ echo "run            bar"
echo: write error: invalid argument
$ dmesg
[ 1103.075435] blk_queue_flags_store: unsupported operation bar. Use either 'run' or 'start'

Instead, return an error if the user does this. While we're here, make
the argument names consistent with everywhere else in this file.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f58a116d6cca..2a19237455d4 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -107,14 +107,18 @@ static int blk_queue_flags_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t blk_queue_flags_store(struct file *file, const char __user *ubuf,
-				     size_t len, loff_t *offp)
+static ssize_t blk_queue_flags_store(struct file *file, const char __user *buf,
+				     size_t count, loff_t *ppos)
 {
 	struct request_queue *q = file_inode(file)->i_private;
 	char op[16] = { }, *s;
 
-	len = min(len, sizeof(op) - 1);
-	if (copy_from_user(op, ubuf, len))
+	if (count >= sizeof(op)) {
+		pr_err("%s: operation too long\n", __func__);
+		goto inval;
+	}
+
+	if (copy_from_user(op, buf, count))
 		return -EFAULT;
 	s = op;
 	strsep(&s, " \t\n"); /* strip trailing whitespace */
@@ -123,11 +127,12 @@ static ssize_t blk_queue_flags_store(struct file *file, const char __user *ubuf,
 	} else if (strcmp(op, "start") == 0) {
 		blk_mq_start_stopped_hw_queues(q, true);
 	} else {
-		pr_err("%s: unsupported operation %s. Use either 'run' or 'start'\n",
-		       __func__, op);
+		pr_err("%s: unsupported operation '%s'\n", __func__, op);
+inval:
+		pr_err("%s: use either 'run' or 'start'\n", __func__);
 		return -EINVAL;
 	}
-	return len;
+	return count;
 }
 
 static int blk_queue_flags_open(struct inode *inode, struct file *file)
-- 
2.12.2
