Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:38819 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdHXHD5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 03:03:57 -0400
Received: by mail-pg0-f54.google.com with SMTP id m133so12452232pga.5
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2017 00:03:57 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH 4/4] loop: fold loop_switch() into callers
Date: Thu, 24 Aug 2017 00:03:44 -0700
Message-Id: <1f86996dec0b19370c4be16e0ec6399f6c8eeb5a.1503558155.git.osandov@fb.com>
In-Reply-To: <cover.1503558155.git.osandov@fb.com>
References: <cover.1503558155.git.osandov@fb.com>
In-Reply-To: <cover.1503558155.git.osandov@fb.com>
References: <cover.1503558155.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The comments here are really outdated, and blk-mq made flushing much
simpler, so just fold the two cases into the callers.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 76 ++++++++--------------------------------------------
 1 file changed, 11 insertions(+), 65 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6b1d932028e3..e60b4ac77577 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -546,72 +546,12 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	}
 }
 
-struct switch_request {
-	struct file *file;
-	struct completion wait;
-};
-
 static inline void loop_update_dio(struct loop_device *lo)
 {
 	__loop_update_dio(lo, io_is_direct(lo->lo_backing_file) |
 			lo->use_dio);
 }
 
-/*
- * Do the actual switch; called from the BIO completion routine
- */
-static void do_loop_switch(struct loop_device *lo, struct switch_request *p)
-{
-	struct file *file = p->file;
-	struct file *old_file = lo->lo_backing_file;
-	struct address_space *mapping;
-
-	/* if no new file, only flush of queued bios requested */
-	if (!file)
-		return;
-
-	mapping = file->f_mapping;
-	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
-	lo->lo_backing_file = file;
-	lo->old_gfp_mask = mapping_gfp_mask(mapping);
-	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
-	loop_update_dio(lo);
-}
-
-/*
- * loop_switch performs the hard work of switching a backing store.
- * First it needs to flush existing IO, it does this by sending a magic
- * BIO down the pipe. The completion of this BIO does the actual switch.
- */
-static int loop_switch(struct loop_device *lo, struct file *file)
-{
-	struct switch_request w;
-
-	w.file = file;
-
-	/* freeze queue and wait for completion of scheduled requests */
-	blk_mq_freeze_queue(lo->lo_queue);
-
-	/* do the switch action */
-	do_loop_switch(lo, &w);
-
-	/* unfreeze */
-	blk_mq_unfreeze_queue(lo->lo_queue);
-
-	return 0;
-}
-
-/*
- * Helper to flush the IOs in loop, but keeping loop thread running
- */
-static int loop_flush(struct loop_device *lo)
-{
-	/* loop not yet configured, no running thread, nothing to flush */
-	if (lo->lo_state != Lo_bound)
-		return 0;
-	return loop_switch(lo, NULL);
-}
-
 static void loop_reread_partitions(struct loop_device *lo,
 				   struct block_device *bdev)
 {
@@ -676,9 +616,14 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		goto out_putf;
 
 	/* and ... switch */
-	error = loop_switch(lo, file);
-	if (error)
-		goto out_putf;
+	blk_mq_freeze_queue(lo->lo_queue);
+	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
+	lo->lo_backing_file = file;
+	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
+	mapping_set_gfp_mask(file->f_mapping,
+			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
+	loop_update_dio(lo);
+	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	fput(old_file);
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
@@ -1601,12 +1546,13 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		err = loop_clr_fd(lo);
 		if (!err)
 			return;
-	} else {
+	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
 		 * but flush possible ongoing bios in thread.
 		 */
-		loop_flush(lo);
+		blk_mq_freeze_queue(lo->lo_queue);
+		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
 
 	mutex_unlock(&lo->lo_ctl_mutex);
-- 
2.14.1
