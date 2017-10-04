Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	shli@kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/9] md: Add nowait support to md
Date: Wed,  4 Oct 2017 08:55:04 -0500
Message-Id: <20171004135511.26110-3-rgoldwyn@suse.de>
In-Reply-To: <20171004135511.26110-1-rgoldwyn@suse.de>
References: <20171004135511.26110-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Set queue flags to QUEUE_FLAG_NOWAIT to indicate REQ_NOWAIT
will be handled. If any of the underlying devices do not support
NOWAIT feature, we do not set the flag.

If the device is suspended, it returns -EWOULDBLOCK.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/md.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0ff1bbf6c90e..7325f8be36b4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -237,6 +237,19 @@ EXPORT_SYMBOL_GPL(md_new_event);
 static LIST_HEAD(all_mddevs);
 static DEFINE_SPINLOCK(all_mddevs_lock);
 
+static bool is_suspended(struct mddev *mddev, struct bio *bio)
+{
+	/* We can serve READ requests when device is suspended */
+	if (bio_data_dir(bio) == READ)
+		return false;
+
+	if (mddev->suspended)
+		return true;
+
+	return  (mddev->suspend_lo < bio_end_sector(bio) &&
+			mddev->suspend_hi > bio->bi_iter.bi_sector);
+}
+
 /*
  * iterates through all used mddevs in the system.
  * We take care to grab the all_mddevs_lock whenever navigating
@@ -316,6 +329,11 @@ static blk_qc_t md_make_request(struct request_queue *q, struct bio *bio)
 		bio_endio(bio);
 		return BLK_QC_T_NONE;
 	}
+	/* Bail out if we would have to wait for suspended device */
+	if ((bio->bi_opf & REQ_NOWAIT) && is_suspended(mddev, bio)) {
+		bio_wouldblock_error(bio);
+		return BLK_QC_T_NONE;
+	}
 
 	/*
 	 * save the sectors now since our bio can
@@ -5404,6 +5422,7 @@ int md_run(struct mddev *mddev)
 	int err;
 	struct md_rdev *rdev;
 	struct md_personality *pers;
+	bool nowait = true;
 
 	if (list_empty(&mddev->disks))
 		/* cannot run an array with no devices.. */
@@ -5470,8 +5489,15 @@ int md_run(struct mddev *mddev)
 			}
 		}
 		sysfs_notify_dirent_safe(rdev->sysfs_state);
+		if (!blk_queue_supports_nowait(rdev->bdev->bd_queue))
+			nowait = false;
 	}
 
+	/* Set the NOWAIT flags if all underlying devices support it */
+	if (nowait)
+		queue_flag_set_unlocked(QUEUE_FLAG_NOWAIT, mddev->queue);
+
+
 	if (mddev->bio_set == NULL) {
 		mddev->bio_set = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 		if (!mddev->bio_set)
@@ -6554,6 +6580,15 @@ static int hot_add_disk(struct mddev *mddev, dev_t dev)
 	set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
 	if (!mddev->thread)
 		md_update_sb(mddev, 1);
+
+	/* If the new disk does not support REQ_NOWAIT,
+	   disable on whole MD */
+	if (!blk_queue_supports_nowait(rdev->bdev->bd_queue)) {
+		pr_info("%s: Disabling nowait because %s does not support nowait\n",
+				mdname(mddev), bdevname(rdev->bdev,b));
+		queue_flag_clear_unlocked(QUEUE_FLAG_NOWAIT, mddev->queue);
+	}
+
 	/*
 	 * Kick recovery, maybe this spare has to be added to the
 	 * array immediately.
-- 
2.14.2
