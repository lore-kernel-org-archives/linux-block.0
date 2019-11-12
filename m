Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D40C43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56EA2196E
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 09:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYwPtczU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKLJCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:02:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42928 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfKLJCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 04:02:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id m13so14268789edv.9
        for <linux-block@vger.kernel.org>; Tue, 12 Nov 2019 01:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FiBTzLxn2jmmAJHiU6Ail4kLdqUAxeoS/3linM3WkuQ=;
        b=bYwPtczU9bsG6vJDD6mLtXcua+tDEgKMICHBq82mgOje5qpjPikA1U7ra65oSO6bXu
         ysmA+fF5kRamb4MMMgZsnUesjS/oqzxEd/Rz5t7lFcikRVjbzlerJ6tofLW+SOk4XcxJ
         wm+Ii9mxHtyha+109H27BBNNNcCVZ+J9rAhA9hki+RvOsQRkDLZanRs7IR5S+fIT1d/O
         K0JORR3rindJgz+OgSioZnfU9pPEBkX/st9JikfAJ1FbR2SxrhbfMAZuW8yGYv2HhOO5
         1A1zTIP2Bn3KjK3X6XmEPvc2VV3xLPvK8QLAxUdEDVBqtbkGbwaUYTAtIdXobgf+Q3vk
         CAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FiBTzLxn2jmmAJHiU6Ail4kLdqUAxeoS/3linM3WkuQ=;
        b=EuPmAhoNkryL1qqSw/HRKTpjka3oL6SOdyneT/W3Ju37mnEsVMSaTJCcXS5PtHhqt0
         3gX6x2DHW5hAa3hf5RGrqDmVILms4ISwtX8tcthN7G+EV8cpFRirJTqcvVQaH3bfAPNh
         h6EWrcAPgSXT0a/wluh53MrU3wox9DThEoDjB2cDfNbOdUZN1jEhNmrBfaoUDD9w0Mve
         USxPVydXmSrpQa/7kNUiGmZ3PEb3K62fiEVBfU0RGLXWg3KfrsOyQHOUmZv11ERyUwQ2
         FwZOwdHvbI6lGpuXSKzJM/RqFITyxcKqWRIHQolJCQlierYtGRtlIxkaqwk7vQkjmgGd
         4a/Q==
X-Gm-Message-State: APjAAAV6LhaKMvvyuSy6twYvx27lcvLA/kEE3IsFyL2xxoDXbpwvWSZw
        buXl8oz/ni1725WBIF/HghgssQsi
X-Google-Smtp-Source: APXvYqxzjfnmYz/AbktPhoFaQ9j1goPGTzg1D5A96mwhqsIE6qUI52/d+Q+c1JpP3FsddNrR+QHXSw==
X-Received: by 2002:aa7:d64e:: with SMTP id v14mr31551896edr.88.1573549318220;
        Tue, 12 Nov 2019 01:01:58 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:8148:8ecb:9630:da5c])
        by smtp.gmail.com with ESMTPSA id u24sm660246edt.84.2019.11.12.01.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 01:01:56 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [RFC PATCH] block: move rb interval tree from drbd to block
Date:   Tue, 12 Nov 2019 10:01:39 +0100
Message-Id: <20191112090139.16092-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Currently, drbd has the implementation of rb interval tree.
And we would like to reuse it for raid1 io serialization [1],
so move it to a common place, rename to block_interval, export
those symbols and make necessary changes to drbd.

[1]. https://marc.info/?l=linux-raid&m=157261819803609&w=2

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/Makefile                                |  2 +-
 .../drbd_interval.c => block/block_interval.c | 51 ++++++++++---------
 drivers/block/drbd/Makefile                   |  2 +-
 drivers/block/drbd/drbd_actlog.c              | 10 ++--
 drivers/block/drbd/drbd_int.h                 | 19 ++++---
 drivers/block/drbd/drbd_interval.h            | 43 ----------------
 drivers/block/drbd/drbd_main.c                |  4 +-
 drivers/block/drbd/drbd_receiver.c            | 32 ++++++------
 drivers/block/drbd/drbd_req.c                 | 20 ++++----
 drivers/block/drbd/drbd_worker.c              |  2 +-
 include/linux/block_interval.h                | 42 +++++++++++++++
 11 files changed, 115 insertions(+), 112 deletions(-)
 rename drivers/block/drbd/drbd_interval.c => block/block_interval.c (66%)
 delete mode 100644 drivers/block/drbd/drbd_interval.h
 create mode 100644 include/linux/block_interval.h

diff --git a/block/Makefile b/block/Makefile
index 9ef57ace90d4..9d0ab1149b1f 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o partition-generic.o ioprio.o \
-			badblocks.o partitions/ blk-rq-qos.o
+			badblocks.o partitions/ blk-rq-qos.o block_interval.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
diff --git a/drivers/block/drbd/drbd_interval.c b/block/block_interval.c
similarity index 66%
rename from drivers/block/drbd/drbd_interval.c
rename to block/block_interval.c
index 651bd0236a99..44d5abf5020f 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/block/block_interval.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/bug.h>
 #include <linux/rbtree_augmented.h>
-#include "drbd_interval.h"
+#include <linux/block_interval.h>
 
 /**
  * interval_end  -  return end of @node
@@ -9,20 +9,20 @@
 static inline
 sector_t interval_end(struct rb_node *node)
 {
-	struct drbd_interval *this = rb_entry(node, struct drbd_interval, rb);
+	struct block_interval *this = rb_entry(node, struct block_interval, rb);
 	return this->end;
 }
 
 #define NODE_END(node) ((node)->sector + ((node)->size >> 9))
 
 RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks,
-			 struct drbd_interval, rb, sector_t, end, NODE_END);
+			 struct block_interval, rb, sector_t, end, NODE_END);
 
 /**
- * drbd_insert_interval  -  insert a new interval into a tree
+ * block_insert_interval  -  insert a new interval into a tree
  */
 bool
-drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
+block_insert_interval(struct rb_root *root, struct block_interval *this)
 {
 	struct rb_node **new = &root->rb_node, *parent = NULL;
 	sector_t this_end = this->sector + (this->size >> 9);
@@ -30,8 +30,8 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
 	BUG_ON(!IS_ALIGNED(this->size, 512));
 
 	while (*new) {
-		struct drbd_interval *here =
-			rb_entry(*new, struct drbd_interval, rb);
+		struct block_interval *here =
+			rb_entry(*new, struct block_interval, rb);
 
 		parent = *new;
 		if (here->end < this_end)
@@ -53,9 +53,10 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
 	rb_insert_augmented(&this->rb, root, &augment_callbacks);
 	return true;
 }
+EXPORT_SYMBOL_GPL(block_insert_interval);
 
 /**
- * drbd_contains_interval  -  check if a tree contains a given interval
+ * block_contains_interval  -  check if a tree contains a given interval
  * @sector:	start sector of @interval
  * @interval:	may not be a valid pointer
  *
@@ -65,14 +66,14 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
  * sector number.
  */
 bool
-drbd_contains_interval(struct rb_root *root, sector_t sector,
-		       struct drbd_interval *interval)
+block_contains_interval(struct rb_root *root, sector_t sector,
+		       struct block_interval *interval)
 {
 	struct rb_node *node = root->rb_node;
 
 	while (node) {
-		struct drbd_interval *here =
-			rb_entry(node, struct drbd_interval, rb);
+		struct block_interval *here =
+			rb_entry(node, struct block_interval, rb);
 
 		if (sector < here->sector)
 			node = node->rb_left;
@@ -87,18 +88,20 @@ drbd_contains_interval(struct rb_root *root, sector_t sector,
 	}
 	return false;
 }
+EXPORT_SYMBOL_GPL(block_contains_interval);
 
 /**
- * drbd_remove_interval  -  remove an interval from a tree
+ * block_remove_interval  -  remove an interval from a tree
  */
 void
-drbd_remove_interval(struct rb_root *root, struct drbd_interval *this)
+block_remove_interval(struct rb_root *root, struct block_interval *this)
 {
 	rb_erase_augmented(&this->rb, root, &augment_callbacks);
 }
+EXPORT_SYMBOL_GPL(block_remove_interval);
 
 /**
- * drbd_find_overlap  - search for an interval overlapping with [sector, sector + size)
+ * block_find_overlap  - search for an interval overlapping with [sector, sector + size)
  * @sector:	start sector
  * @size:	size, aligned to 512 bytes
  *
@@ -108,18 +111,18 @@ drbd_remove_interval(struct rb_root *root, struct drbd_interval *this)
  * overlapping intervals will be on the right side of the tree, reachable with
  * rb_next().
  */
-struct drbd_interval *
-drbd_find_overlap(struct rb_root *root, sector_t sector, unsigned int size)
+struct block_interval *
+block_find_overlap(struct rb_root *root, sector_t sector, unsigned int size)
 {
 	struct rb_node *node = root->rb_node;
-	struct drbd_interval *overlap = NULL;
+	struct block_interval *overlap = NULL;
 	sector_t end = sector + (size >> 9);
 
 	BUG_ON(!IS_ALIGNED(size, 512));
 
 	while (node) {
-		struct drbd_interval *here =
-			rb_entry(node, struct drbd_interval, rb);
+		struct block_interval *here =
+			rb_entry(node, struct block_interval, rb);
 
 		if (node->rb_left &&
 		    sector < interval_end(node->rb_left)) {
@@ -137,9 +140,10 @@ drbd_find_overlap(struct rb_root *root, sector_t sector, unsigned int size)
 	}
 	return overlap;
 }
+EXPORT_SYMBOL_GPL(block_find_overlap);
 
-struct drbd_interval *
-drbd_next_overlap(struct drbd_interval *i, sector_t sector, unsigned int size)
+struct block_interval *
+block_next_overlap(struct block_interval *i, sector_t sector, unsigned int size)
 {
 	sector_t end = sector + (size >> 9);
 	struct rb_node *node;
@@ -148,10 +152,11 @@ drbd_next_overlap(struct drbd_interval *i, sector_t sector, unsigned int size)
 		node = rb_next(&i->rb);
 		if (!node)
 			return NULL;
-		i = rb_entry(node, struct drbd_interval, rb);
+		i = rb_entry(node, struct block_interval, rb);
 		if (i->sector >= end)
 			return NULL;
 		if (sector < i->sector + (i->size >> 9))
 			return i;
 	}
 }
+EXPORT_SYMBOL_GPL(block_next_overlap);
diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 8bd534697d1b..54f6bc1c95ce 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -2,7 +2,7 @@
 drbd-y := drbd_bitmap.o drbd_proc.o
 drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
-drbd-y += drbd_interval.o drbd_state.o
+drbd-y += drbd_state.o
 drbd-y += drbd_nla.o
 drbd-$(CONFIG_DEBUG_FS) += drbd_debugfs.o
 
diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index b41897dceb2b..1453fe61a63e 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -238,7 +238,7 @@ static struct lc_element *_al_get(struct drbd_device *device, unsigned int enr,
 	return al_ext;
 }
 
-bool drbd_al_begin_io_fastpath(struct drbd_device *device, struct drbd_interval *i)
+bool drbd_al_begin_io_fastpath(struct drbd_device *device, struct block_interval *i)
 {
 	/* for bios crossing activity log extent boundaries,
 	 * we may need to activate two extents in one go */
@@ -255,7 +255,7 @@ bool drbd_al_begin_io_fastpath(struct drbd_device *device, struct drbd_interval
 	return _al_get(device, first, true);
 }
 
-bool drbd_al_begin_io_prepare(struct drbd_device *device, struct drbd_interval *i)
+bool drbd_al_begin_io_prepare(struct drbd_device *device, struct block_interval *i)
 {
 	/* for bios crossing activity log extent boundaries,
 	 * we may need to activate two extents in one go */
@@ -475,13 +475,13 @@ void drbd_al_begin_io_commit(struct drbd_device *device)
 /*
  * @delegate:   delegate activity log I/O to the worker thread
  */
-void drbd_al_begin_io(struct drbd_device *device, struct drbd_interval *i)
+void drbd_al_begin_io(struct drbd_device *device, struct block_interval *i)
 {
 	if (drbd_al_begin_io_prepare(device, i))
 		drbd_al_begin_io_commit(device);
 }
 
-int drbd_al_begin_io_nonblock(struct drbd_device *device, struct drbd_interval *i)
+int drbd_al_begin_io_nonblock(struct drbd_device *device, struct block_interval *i)
 {
 	struct lru_cache *al = device->act_log;
 	/* for bios crossing activity log extent boundaries,
@@ -541,7 +541,7 @@ int drbd_al_begin_io_nonblock(struct drbd_device *device, struct drbd_interval *
 	return 0;
 }
 
-void drbd_al_complete_io(struct drbd_device *device, struct drbd_interval *i)
+void drbd_al_complete_io(struct drbd_device *device, struct block_interval *i)
 {
 	/* for bios crossing activity log extent boundaries,
 	 * we may need to activate two extents in one go */
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ddbf56014c51..95a2037491eb 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -27,6 +27,7 @@
 #include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/block_interval.h>
 #include <linux/genhd.h>
 #include <linux/idr.h>
 #include <linux/dynamic_debug.h>
@@ -264,9 +265,7 @@ struct drbd_device_work {
 	struct drbd_device *device;
 };
 
-#include "drbd_interval.h"
-
-extern int drbd_wait_misc(struct drbd_device *, struct drbd_interval *);
+extern int drbd_wait_misc(struct drbd_device *, struct block_interval *);
 
 extern void lock_all_resources(void);
 extern void unlock_all_resources(void);
@@ -281,7 +280,7 @@ struct drbd_request {
 	 * see drbd_request_endio(). */
 	struct bio *private_bio;
 
-	struct drbd_interval i;
+	struct block_interval i;
 
 	/* epoch: used to check on "completion" whether this req was in
 	 * the current epoch, and we therefore have to close it,
@@ -397,7 +396,7 @@ struct drbd_peer_request {
 	struct drbd_epoch *epoch; /* for writes */
 	struct page *pages;
 	atomic_t pending_bios;
-	struct drbd_interval i;
+	struct block_interval i;
 	/* see comments on ee flag bits below */
 	unsigned long flags;
 	unsigned long submit_jif;
@@ -1629,12 +1628,12 @@ extern struct proc_dir_entry *drbd_proc;
 int drbd_seq_show(struct seq_file *seq, void *v);
 
 /* drbd_actlog.c */
-extern bool drbd_al_begin_io_prepare(struct drbd_device *device, struct drbd_interval *i);
-extern int drbd_al_begin_io_nonblock(struct drbd_device *device, struct drbd_interval *i);
+extern bool drbd_al_begin_io_prepare(struct drbd_device *device, struct block_interval *i);
+extern int drbd_al_begin_io_nonblock(struct drbd_device *device, struct block_interval *i);
 extern void drbd_al_begin_io_commit(struct drbd_device *device);
-extern bool drbd_al_begin_io_fastpath(struct drbd_device *device, struct drbd_interval *i);
-extern void drbd_al_begin_io(struct drbd_device *device, struct drbd_interval *i);
-extern void drbd_al_complete_io(struct drbd_device *device, struct drbd_interval *i);
+extern bool drbd_al_begin_io_fastpath(struct drbd_device *device, struct block_interval *i);
+extern void drbd_al_begin_io(struct drbd_device *device, struct block_interval *i);
+extern void drbd_al_complete_io(struct drbd_device *device, struct block_interval *i);
 extern void drbd_rs_complete_io(struct drbd_device *device, sector_t sector);
 extern int drbd_rs_begin_io(struct drbd_device *device, sector_t sector);
 extern int drbd_try_rs_begin_io(struct drbd_device *device, sector_t sector);
diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
deleted file mode 100644
index b8c2dee5edc8..000000000000
--- a/drivers/block/drbd/drbd_interval.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DRBD_INTERVAL_H
-#define __DRBD_INTERVAL_H
-
-#include <linux/types.h>
-#include <linux/rbtree.h>
-
-struct drbd_interval {
-	struct rb_node rb;
-	sector_t sector;		/* start sector of the interval */
-	unsigned int size;		/* size in bytes */
-	sector_t end;			/* highest interval end in subtree */
-	unsigned int local:1		/* local or remote request? */;
-	unsigned int waiting:1;		/* someone is waiting for completion */
-	unsigned int completed:1;	/* this has been completed already;
-					 * ignore for conflict detection */
-};
-
-static inline void drbd_clear_interval(struct drbd_interval *i)
-{
-	RB_CLEAR_NODE(&i->rb);
-}
-
-static inline bool drbd_interval_empty(struct drbd_interval *i)
-{
-	return RB_EMPTY_NODE(&i->rb);
-}
-
-extern bool drbd_insert_interval(struct rb_root *, struct drbd_interval *);
-extern bool drbd_contains_interval(struct rb_root *, sector_t,
-				   struct drbd_interval *);
-extern void drbd_remove_interval(struct rb_root *, struct drbd_interval *);
-extern struct drbd_interval *drbd_find_overlap(struct rb_root *, sector_t,
-					unsigned int);
-extern struct drbd_interval *drbd_next_overlap(struct drbd_interval *, sector_t,
-					unsigned int);
-
-#define drbd_for_each_overlap(i, root, sector, size)		\
-	for (i = drbd_find_overlap(root, sector, size);		\
-	     i;							\
-	     i = drbd_next_overlap(i, sector, size))
-
-#endif  /* __DRBD_INTERVAL_H */
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 5b248763a672..353cad1aac4a 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3778,10 +3778,10 @@ const char *cmdname(enum drbd_packet cmd)
 /**
  * drbd_wait_misc  -  wait for a request to make progress
  * @device:	device associated with the request
- * @i:		the struct drbd_interval embedded in struct drbd_request or
+ * @i:		the struct block_interval embedded in struct drbd_request or
  *		struct drbd_peer_request
  */
-int drbd_wait_misc(struct drbd_device *device, struct drbd_interval *i)
+int drbd_wait_misc(struct drbd_device *device, struct block_interval *i)
 {
 	struct net_conf *nc;
 	DEFINE_WAIT(wait);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2b3103c30857..0c72b0f4146d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -382,7 +382,7 @@ drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector_t secto
 
 	memset(peer_req, 0, sizeof(*peer_req));
 	INIT_LIST_HEAD(&peer_req->w.list);
-	drbd_clear_interval(&peer_req->i);
+	block_clear_interval(&peer_req->i);
 	peer_req->i.size = request_size;
 	peer_req->i.sector = sector;
 	peer_req->submit_jif = jiffies;
@@ -409,7 +409,7 @@ void __drbd_free_peer_req(struct drbd_device *device, struct drbd_peer_request *
 		kfree(peer_req->digest);
 	drbd_free_pages(device, peer_req->pages, is_net);
 	D_ASSERT(device, atomic_read(&peer_req->pending_bios) == 0);
-	D_ASSERT(device, drbd_interval_empty(&peer_req->i));
+	D_ASSERT(device, block_interval_empty(&peer_req->i));
 	if (!expect(!(peer_req->flags & EE_CALL_AL_COMPLETE_IO))) {
 		peer_req->flags &= ~EE_CALL_AL_COMPLETE_IO;
 		drbd_al_complete_io(device, &peer_req->i);
@@ -1738,10 +1738,10 @@ int drbd_submit_peer_request(struct drbd_device *device,
 static void drbd_remove_epoch_entry_interval(struct drbd_device *device,
 					     struct drbd_peer_request *peer_req)
 {
-	struct drbd_interval *i = &peer_req->i;
+	struct block_interval *i = &peer_req->i;
 
-	drbd_remove_interval(&device->write_requests, i);
-	drbd_clear_interval(i);
+	block_remove_interval(&device->write_requests, i);
+	block_clear_interval(i);
 
 	/* Wake up any processes waiting for this peer request to complete.  */
 	if (i->waiting)
@@ -2066,7 +2066,7 @@ static int e_end_resync_block(struct drbd_work *w, int unused)
 	sector_t sector = peer_req->i.sector;
 	int err;
 
-	D_ASSERT(device, drbd_interval_empty(&peer_req->i));
+	D_ASSERT(device, block_interval_empty(&peer_req->i));
 
 	if (likely((peer_req->flags & EE_WAS_ERROR) == 0)) {
 		drbd_set_in_sync(device, sector, peer_req->i.size);
@@ -2130,7 +2130,7 @@ find_request(struct drbd_device *device, struct rb_root *root, u64 id,
 
 	/* Request object according to our peer */
 	req = (struct drbd_request *)(unsigned long)id;
-	if (drbd_contains_interval(root, sector, &req->i) && req->i.local)
+	if (block_contains_interval(root, sector, &req->i) && req->i.local)
 		return req;
 	if (!missing_ok) {
 		drbd_err(device, "%s: failed to find request 0x%lx, sector %llus\n", func,
@@ -2212,10 +2212,10 @@ static int receive_RSDataReply(struct drbd_connection *connection, struct packet
 static void restart_conflicting_writes(struct drbd_device *device,
 				       sector_t sector, int size)
 {
-	struct drbd_interval *i;
+	struct block_interval *i;
 	struct drbd_request *req;
 
-	drbd_for_each_overlap(i, &device->write_requests, sector, size) {
+	block_for_each_overlap(i, &device->write_requests, sector, size) {
 		if (!i->local)
 			continue;
 		req = container_of(i, struct drbd_request, i);
@@ -2261,13 +2261,13 @@ static int e_end_block(struct drbd_work *w, int cancel)
 	 * P_WRITE_ACK / P_NEG_ACK, to get the sequence number right.  */
 	if (peer_req->flags & EE_IN_INTERVAL_TREE) {
 		spin_lock_irq(&device->resource->req_lock);
-		D_ASSERT(device, !drbd_interval_empty(&peer_req->i));
+		D_ASSERT(device, !block_interval_empty(&peer_req->i));
 		drbd_remove_epoch_entry_interval(device, peer_req);
 		if (peer_req->flags & EE_RESTART_REQUESTS)
 			restart_conflicting_writes(device, sector, peer_req->i.size);
 		spin_unlock_irq(&device->resource->req_lock);
 	} else
-		D_ASSERT(device, drbd_interval_empty(&peer_req->i));
+		D_ASSERT(device, block_interval_empty(&peer_req->i));
 
 	drbd_may_finish_epoch(peer_device->connection, peer_req->epoch, EV_PUT + (cancel ? EV_CLEANUP : 0));
 
@@ -2451,10 +2451,10 @@ static unsigned long wire_flags_to_bio_op(u32 dpf)
 static void fail_postponed_requests(struct drbd_device *device, sector_t sector,
 				    unsigned int size)
 {
-	struct drbd_interval *i;
+	struct block_interval *i;
 
     repeat:
-	drbd_for_each_overlap(i, &device->write_requests, sector, size) {
+	block_for_each_overlap(i, &device->write_requests, sector, size) {
 		struct drbd_request *req;
 		struct bio_and_error m;
 
@@ -2480,7 +2480,7 @@ static int handle_write_conflicts(struct drbd_device *device,
 	bool resolve_conflicts = test_bit(RESOLVE_CONFLICTS, &connection->flags);
 	sector_t sector = peer_req->i.sector;
 	const unsigned int size = peer_req->i.size;
-	struct drbd_interval *i;
+	struct block_interval *i;
 	bool equal;
 	int err;
 
@@ -2488,10 +2488,10 @@ static int handle_write_conflicts(struct drbd_device *device,
 	 * Inserting the peer request into the write_requests tree will prevent
 	 * new conflicting local requests from being added.
 	 */
-	drbd_insert_interval(&device->write_requests, &peer_req->i);
+	block_insert_interval(&device->write_requests, &peer_req->i);
 
     repeat:
-	drbd_for_each_overlap(i, &device->write_requests, sector, size) {
+	block_for_each_overlap(i, &device->write_requests, sector, size) {
 		if (i == &peer_req->i)
 			continue;
 		if (i->completed)
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index f86cea4c0f8d..354d65a64256 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -57,7 +57,7 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio
 	req->master_bio = bio_src;
 	req->epoch = 0;
 
-	drbd_clear_interval(&req->i);
+	block_clear_interval(&req->i);
 	req->i.sector     = bio_src->bi_iter.bi_sector;
 	req->i.size      = bio_src->bi_iter.bi_size;
 	req->i.local = true;
@@ -79,9 +79,9 @@ static void drbd_remove_request_interval(struct rb_root *root,
 					 struct drbd_request *req)
 {
 	struct drbd_device *device = req->device;
-	struct drbd_interval *i = &req->i;
+	struct block_interval *i = &req->i;
 
-	drbd_remove_interval(root, i);
+	block_remove_interval(root, i);
 
 	/* Wake up any processes waiting for this request to complete.  */
 	if (i->waiting)
@@ -115,7 +115,7 @@ void drbd_req_destroy(struct kref *kref)
 
 	/* finally remove the request from the conflict detection
 	 * respective block_id verification interval tree. */
-	if (!drbd_interval_empty(&req->i)) {
+	if (!block_interval_empty(&req->i)) {
 		struct rb_root *root;
 
 		if (s & RQ_WRITE)
@@ -653,8 +653,8 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		/* So we can verify the handle in the answer packet.
 		 * Corresponding drbd_remove_request_interval is in
 		 * drbd_req_complete() */
-		D_ASSERT(device, drbd_interval_empty(&req->i));
-		drbd_insert_interval(&device->read_requests, &req->i);
+		D_ASSERT(device, block_interval_empty(&req->i));
+		block_insert_interval(&device->read_requests, &req->i);
 
 		set_bit(UNPLUG_REMOTE, &device->flags);
 
@@ -672,8 +672,8 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 
 		/* Corresponding drbd_remove_request_interval is in
 		 * drbd_req_complete() */
-		D_ASSERT(device, drbd_interval_empty(&req->i));
-		drbd_insert_interval(&device->write_requests, &req->i);
+		D_ASSERT(device, block_interval_empty(&req->i));
+		block_insert_interval(&device->write_requests, &req->i);
 
 		/* NOTE
 		 * In case the req ended up on the transfer log before being
@@ -960,12 +960,12 @@ static void complete_conflicting_writes(struct drbd_request *req)
 {
 	DEFINE_WAIT(wait);
 	struct drbd_device *device = req->device;
-	struct drbd_interval *i;
+	struct block_interval *i;
 	sector_t sector = req->i.sector;
 	int size = req->i.size;
 
 	for (;;) {
-		drbd_for_each_overlap(i, &device->write_requests, sector, size) {
+		block_for_each_overlap(i, &device->write_requests, sector, size) {
 			/* Ignore, if already completed to upper layers. */
 			if (i->completed)
 				continue;
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 5bdcc70ad589..8d0b4d2f3a26 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -104,7 +104,7 @@ void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __releases(l
 	struct drbd_peer_device *peer_device = peer_req->peer_device;
 	struct drbd_device *device = peer_device->device;
 	struct drbd_connection *connection = peer_device->connection;
-	struct drbd_interval i;
+	struct block_interval i;
 	int do_wake;
 	u64 block_id;
 	int do_al_complete_io;
diff --git a/include/linux/block_interval.h b/include/linux/block_interval.h
new file mode 100644
index 000000000000..e3bc2cfe6ecc
--- /dev/null
+++ b/include/linux/block_interval.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/types.h>
+#include <linux/rbtree.h>
+
+struct block_interval {
+	struct rb_node rb;
+	sector_t sector;		/* start sector of the interval */
+	unsigned int size;		/* size in bytes */
+	sector_t end;			/* highest interval end in subtree */
+
+	/* used by drbd */
+	unsigned int local:1;		/* local or remote request? */
+	unsigned int waiting:1;		/* someone is waiting for completion */
+	unsigned int completed:1;	/* this has been completed already;
+					 * ignore for conflict detection */
+};
+
+static inline void block_clear_interval(struct block_interval *i)
+{
+	RB_CLEAR_NODE(&i->rb);
+}
+
+static inline bool block_interval_empty(struct block_interval *i)
+{
+	return RB_EMPTY_NODE(&i->rb);
+}
+
+extern bool block_insert_interval(struct rb_root *root,
+				  struct block_interval *this);
+extern bool block_contains_interval(struct rb_root *root, sector_t sector,
+				    struct block_interval *interval);
+extern void block_remove_interval(struct rb_root *root,
+				  struct block_interval *this);
+extern struct block_interval *block_find_overlap(struct rb_root *root,
+					sector_t sector, unsigned int size);
+extern struct block_interval *block_next_overlap(struct block_interval *i,
+					sector_t sector, unsigned int size);
+
+#define block_for_each_overlap(i, root, sector, size)		\
+	for (i = block_find_overlap(root, sector, size);	\
+	     i;							\
+	     i = block_next_overlap(i, sector, size))
-- 
2.17.1

