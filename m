Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33613 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdEDHbs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 03:31:48 -0400
Received: by mail-pf0-f178.google.com with SMTP id q20so3747300pfg.0
        for <linux-block@vger.kernel.org>; Thu, 04 May 2017 00:31:47 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH v2 05/12] blk-mq-debugfs: rename hw queue directories from <n> to hctx<n>
Date: Thu,  4 May 2017 00:31:27 -0700
Message-Id: <d93cf237ca97fa3fa7213689ebdaffaf12a32146.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

It's not clear what these numbered directories represent unless you
consult the code. We're about to get rid of the intermediate "mq"
directory, so these would be even more confusing without that context.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 109ae9f3d400..2eae3238fb35 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -936,7 +936,7 @@ static int blk_mq_debugfs_register_hctx(struct request_queue *q,
 	char name[20];
 	int i;
 
-	snprintf(name, sizeof(name), "%u", hctx->queue_num);
+	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
 	hctx_dir = debugfs_create_dir(name, q->mq_debugfs_dir);
 	if (!hctx_dir)
 		return -ENOMEM;
-- 
2.12.2
