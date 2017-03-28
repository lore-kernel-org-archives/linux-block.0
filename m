Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34937 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753925AbdC1G3x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 02:29:53 -0400
Received: by mail-pg0-f52.google.com with SMTP id 81so48594290pgh.2
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 23:29:52 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com, "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6/6] jsflash: stop sharing request queue across multiple gendisks
Date: Mon, 27 Mar 2017 23:28:47 -0700
Message-Id: <177c67289c6878fa56c273a92f9c0069ee0f113f.1490681910.git.osandov@fb.com>
In-Reply-To: <cover.1490681910.git.osandov@fb.com>
References: <cover.1490681910.git.osandov@fb.com>
In-Reply-To: <cover.1490681910.git.osandov@fb.com>
References: <cover.1490681910.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Compile-tested only (by hacking it to compile on x86).

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/sbus/char/jsflash.c | 50 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
index 6ff61dad5e21..62fed9dc893e 100644
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -183,11 +183,33 @@ static void jsfd_read(char *buf, unsigned long p, size_t togo) {
 	}
 }
 
-static void jsfd_do_request(struct request_queue *q)
+static int jsfd_queue;
+
+static struct request *jsfd_next_request(void)
+{
+	struct request_queue *q;
+	struct request *rq;
+	int old_pos = jsfd_queue;
+
+	do {
+		q = jsfd_disk[jsfd_queue]->queue;
+		if (++jsfd_queue == JSF_MAX)
+			jsfd_queue = 0;
+		if (q) {
+			rq = blk_fetch_request(q);
+			if (rq)
+				return rq;
+		}
+	} while (jsfd_queue != old_pos);
+
+	return NULL;
+}
+
+static void jsfd_request(void)
 {
 	struct request *req;
 
-	req = blk_fetch_request(q);
+	req = jsfd_next_request();
 	while (req) {
 		struct jsfd_part *jdp = req->rq_disk->private_data;
 		unsigned long offset = blk_rq_pos(req) << 9;
@@ -211,10 +233,15 @@ static void jsfd_do_request(struct request_queue *q)
 		err = 0;
 	end:
 		if (!__blk_end_request_cur(req, err))
-			req = blk_fetch_request(q);
+			req = jsfd_next_request();
 	}
 }
 
+static void jsfd_do_request(struct request_queue *q)
+{
+	jsfd_request();
+}
+
 /*
  * The memory devices use the full 32/64 bits of the offset, and so we cannot
  * check against negative addresses: they are ok. The return value is weird,
@@ -544,8 +571,6 @@ static int jsflash_init(void)
 	return 0;
 }
 
-static struct request_queue *jsf_queue;
-
 static int jsfd_init(void)
 {
 	static DEFINE_SPINLOCK(lock);
@@ -562,6 +587,11 @@ static int jsfd_init(void)
 		struct gendisk *disk = alloc_disk(1);
 		if (!disk)
 			goto out;
+		disk->queue = blk_init_queue(jsfd_do_request, &lock);
+		if (!disk->queue) {
+			put_disk(disk);
+			goto out;
+		}
 		jsfd_disk[i] = disk;
 	}
 
@@ -570,13 +600,6 @@ static int jsfd_init(void)
 		goto out;
 	}
 
-	jsf_queue = blk_init_queue(jsfd_do_request, &lock);
-	if (!jsf_queue) {
-		err = -ENOMEM;
-		unregister_blkdev(JSFD_MAJOR, "jsfd");
-		goto out;
-	}
-
 	for (i = 0; i < JSF_MAX; i++) {
 		struct gendisk *disk = jsfd_disk[i];
 		if ((i & JSF_PART_MASK) >= JSF_NPART) continue;
@@ -589,7 +612,6 @@ static int jsfd_init(void)
 		disk->fops = &jsfd_fops;
 		set_capacity(disk, jdp->dsize >> 9);
 		disk->private_data = jdp;
-		disk->queue = jsf_queue;
 		add_disk(disk);
 		set_disk_ro(disk, 1);
 	}
@@ -619,6 +641,7 @@ static void __exit jsflash_cleanup_module(void)
 	for (i = 0; i < JSF_MAX; i++) {
 		if ((i & JSF_PART_MASK) >= JSF_NPART) continue;
 		del_gendisk(jsfd_disk[i]);
+		blk_cleanup_queue(jsfd_disk[i]->queue);
 		put_disk(jsfd_disk[i]);
 	}
 	if (jsf0.busy)
@@ -628,7 +651,6 @@ static void __exit jsflash_cleanup_module(void)
 
 	misc_deregister(&jsf_dev);
 	unregister_blkdev(JSFD_MAJOR, "jsfd");
-	blk_cleanup_queue(jsf_queue);
 }
 
 module_init(jsflash_init_module);
-- 
2.12.1
