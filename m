Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32842 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754984AbdECT52 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 15:57:28 -0400
Received: by mail-pf0-f179.google.com with SMTP id q20so23623pfg.0
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 12:57:28 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH 10/9] blk-mq-debugfs: rename hw queue directories from <n> to hctx<n>
Date: Wed,  3 May 2017 12:57:19 -0700
Message-Id: <7dd56561c651b20e54e82b7246e6732471b40f38.1493841286.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Since we got rid of the intermediate "mq" directory, it's not completely
clear what these numbered directories represent. Rename them.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
One more bonus change.

 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3a33f7e2f68c..115d73d99bb3 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -761,7 +761,7 @@ int blk_mq_debugfs_register_hctx(struct request_queue *q,
 	if (!q->debugfs_dir)
 		return -ENOENT;
 
-	snprintf(name, sizeof(name), "%u", hctx->queue_num);
+	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
 	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
 	if (!hctx->debugfs_dir)
 		return -ENOMEM;
-- 
2.12.2
