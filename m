Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34135 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdAaXBY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 18:01:24 -0500
Received: by mail-pf0-f181.google.com with SMTP id e4so112209330pfg.1
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 15:01:24 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 5/6] blk-mq: move debugfs_remove() of disk dir to blk_release_queue()
Date: Tue, 31 Jan 2017 14:53:21 -0800
Message-Id: <dc81bbb139cccd46b31e049df9279093457c50be.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This needs to happen after we tear down blktrace.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-sysfs.c | 2 +-
 block/blk-sysfs.c    | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 308b3f4fc310..295e69670c39 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -254,7 +254,7 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 		kobject_put(&hctx->kobj);
 	}
 
-	blk_mq_debugfs_unregister(q);
+	blk_mq_debugfs_unregister_hctxs(q);
 
 	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(&q->mq_kobj);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1dbce057592d..6cb637648936 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -821,6 +821,9 @@ static void blk_release_queue(struct kobject *kobj)
 
 	blk_trace_shutdown(q);
 
+	if (q->mq_ops)
+		blk_mq_debugfs_unregister(q);
+
 	if (q->bio_split)
 		bioset_free(q->bio_split);
 
-- 
2.11.0

