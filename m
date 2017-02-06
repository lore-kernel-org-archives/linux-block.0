Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34325 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbdBFUxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2017 15:53:08 -0500
Received: by mail-pf0-f177.google.com with SMTP id e4so26550943pfg.1
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2017 12:53:02 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH] blk-mq-sched: (un)register elevator when (un)registering queue
Date: Mon,  6 Feb 2017 12:52:24 -0800
Message-Id: <ff62b5d76fa68f6595446d2a6c4aa13db4113d71.1486414181.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

I noticed that when booting with a default blk-mq I/O scheduler, the
/sys/block/*/queue/iosched directory was missing. However, switching
after boot did create the directory. This is because we skip the initial
elevator register/unregister when we don't have a ->request_fn(), but we
should still do it for the ->mq_ops case.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-sysfs.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 3ce1217778f4..48032c4759a7 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -903,16 +903,15 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_wb_init(q);
 
-	if (!q->request_fn)
-		return 0;
-
-	ret = elv_register_queue(q);
-	if (ret) {
-		kobject_uevent(&q->kobj, KOBJ_REMOVE);
-		kobject_del(&q->kobj);
-		blk_trace_remove_sysfs(dev);
-		kobject_put(&dev->kobj);
-		return ret;
+	if (q->request_fn || (q->mq_ops && q->elevator)) {
+		ret = elv_register_queue(q);
+		if (ret) {
+			kobject_uevent(&q->kobj, KOBJ_REMOVE);
+			kobject_del(&q->kobj);
+			blk_trace_remove_sysfs(dev);
+			kobject_put(&dev->kobj);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -928,7 +927,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	if (q->mq_ops)
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
 
-	if (q->request_fn)
+	if (q->request_fn || (q->mq_ops && q->elevator))
 		elv_unregister_queue(q);
 
 	kobject_uevent(&q->kobj, KOBJ_REMOVE);
-- 
2.11.1
