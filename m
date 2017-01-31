Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34269 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdAaXBz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 18:01:55 -0500
Received: by mail-pf0-f172.google.com with SMTP id e4so112216318pfg.1
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 15:01:55 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 3/6] blktrace: make do_blk_trace_setup() static
Date: Tue, 31 Jan 2017 14:53:19 -0800
Message-Id: <e065ee45833a06d87402122f2e0fb339f6c67aab.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This isn't used outside of blktrace.c anymore.

Fixes: 62c2a7d969f3 ("block: push BKL into blktrace ioctls")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/blktrace_api.h | 4 ----
 kernel/trace/blktrace.c      | 6 +++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index e417f080219a..75458bc19a16 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -30,9 +30,6 @@ struct blk_trace {
 
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);
 extern void blk_trace_shutdown(struct request_queue *);
-extern int do_blk_trace_setup(struct request_queue *q, char *name,
-			      dev_t dev, struct block_device *bdev,
-			      struct blk_user_trace_setup *buts);
 extern __printf(2, 3)
 void __trace_note_message(struct blk_trace *, const char *fmt, ...);
 
@@ -80,7 +77,6 @@ extern struct attribute_group blk_trace_attr_group;
 #else /* !CONFIG_BLK_DEV_IO_TRACE */
 # define blk_trace_ioctl(bdev, cmd, arg)		(-ENOTTY)
 # define blk_trace_shutdown(q)				do { } while (0)
-# define do_blk_trace_setup(q, name, dev, bdev, buts)	(-ENOTTY)
 # define blk_add_driver_data(q, rq, data, len)		do {} while (0)
 # define blk_trace_setup(q, name, dev, bdev, arg)	(-ENOTTY)
 # define blk_trace_startstop(q, start)			(-ENOTTY)
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 95cecbf67f5c..83d3b5b58f53 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -433,9 +433,9 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
 /*
  * Setup everything required to start tracing
  */
-int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-		       struct block_device *bdev,
-		       struct blk_user_trace_setup *buts)
+static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
+			      struct block_device *bdev,
+			      struct blk_user_trace_setup *buts)
 {
 	struct blk_trace *bt = NULL;
 	struct dentry *dir = NULL;
-- 
2.11.0

