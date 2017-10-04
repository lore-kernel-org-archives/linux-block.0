Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	shli@kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/9] md: raid10 nowait support
Date: Wed,  4 Oct 2017 08:55:06 -0500
Message-Id: <20171004135511.26110-5-rgoldwyn@suse.de>
In-Reply-To: <20171004135511.26110-1-rgoldwyn@suse.de>
References: <20171004135511.26110-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Bail and status to EAGAIN if raid10 is going to wait for:
 + barriers
 + reshape operation
 + Too many queued requests

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/raid10.c | 67 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 374df5796649..b0701f5751fe 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -969,8 +969,9 @@ static void lower_barrier(struct r10conf *conf)
 	wake_up(&conf->wait_barrier);
 }
 
-static void wait_barrier(struct r10conf *conf)
+static bool wait_barrier(struct r10conf *conf, bool nowait)
 {
+	bool ret = true;
 	spin_lock_irq(&conf->resync_lock);
 	if (conf->barrier) {
 		conf->nr_waiting++;
@@ -984,19 +985,25 @@ static void wait_barrier(struct r10conf *conf)
 		 * count down.
 		 */
 		raid10_log(conf->mddev, "wait barrier");
-		wait_event_lock_irq(conf->wait_barrier,
-				    !conf->barrier ||
-				    (atomic_read(&conf->nr_pending) &&
-				     current->bio_list &&
-				     (!bio_list_empty(&current->bio_list[0]) ||
-				      !bio_list_empty(&current->bio_list[1]))),
-				    conf->resync_lock);
+		if (!nowait)
+			wait_event_lock_irq(conf->wait_barrier,
+					    !conf->barrier ||
+				            (atomic_read(&conf->nr_pending) &&
+				             current->bio_list &&
+				             (!bio_list_empty(&current->bio_list[0]) ||
+				              !bio_list_empty(&current->bio_list[1]))),
+					    conf->resync_lock);
+		else
+			ret = false;
 		conf->nr_waiting--;
 		if (!conf->nr_waiting)
 			wake_up(&conf->wait_barrier);
 	}
-	atomic_inc(&conf->nr_pending);
+	/* Do not increment nr_pending if we din't wait */
+	if (ret)
+		atomic_inc(&conf->nr_pending);
 	spin_unlock_irq(&conf->resync_lock);
+	return ret;
 }
 
 static void allow_barrier(struct r10conf *conf)
@@ -1148,7 +1155,10 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	 * thread has put up a bar for new requests.
 	 * Continue immediately if no resync is active currently.
 	 */
-	wait_barrier(conf);
+	if (!wait_barrier(conf, bio->bi_opf & REQ_NOWAIT)) {
+		bio_wouldblock_error(bio);
+		return;
+	}
 
 	sectors = r10_bio->sectors;
 	while (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
@@ -1159,12 +1169,16 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		 * pass
 		 */
 		raid10_log(conf->mddev, "wait reshape");
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		allow_barrier(conf);
 		wait_event(conf->wait_barrier,
 			   conf->reshape_progress <= bio->bi_iter.bi_sector ||
 			   conf->reshape_progress >= bio->bi_iter.bi_sector +
 			   sectors);
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 	}
 
 	rdev = read_balance(conf, r10_bio, &max_sectors);
@@ -1298,12 +1312,19 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	 * thread has put up a bar for new requests.
 	 * Continue immediately if no resync is active currently.
 	 */
-	wait_barrier(conf);
+	if (!wait_barrier(conf, bio->bi_opf & REQ_NOWAIT)) {
+		bio_wouldblock_error(bio);
+		return;
+	}
 
 	sectors = r10_bio->sectors;
 	while (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 	    bio->bi_iter.bi_sector < conf->reshape_progress &&
 	    bio->bi_iter.bi_sector + sectors > conf->reshape_progress) {
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		/*
 		 * IO spans the reshape position.  Need to wait for reshape to
 		 * pass
@@ -1314,7 +1335,7 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 			   conf->reshape_progress <= bio->bi_iter.bi_sector ||
 			   conf->reshape_progress >= bio->bi_iter.bi_sector +
 			   sectors);
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 	}
 
 	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
@@ -1328,6 +1349,10 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		set_mask_bits(&mddev->sb_flags, 0,
 			      BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
 		md_wakeup_thread(mddev->thread);
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		raid10_log(conf->mddev, "wait reshape metadata");
 		wait_event(mddev->sb_wait,
 			   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
@@ -1337,6 +1362,10 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 
 	if (conf->pending_count >= max_queued_requests) {
 		md_wakeup_thread(mddev->thread);
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		raid10_log(mddev, "wait queued");
 		wait_event(conf->wait_barrier,
 			   conf->pending_count < max_queued_requests);
@@ -1462,9 +1491,15 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 			}
 		}
 		allow_barrier(conf);
+
+		/* Don't wait for REQ_NOWAIT */
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		raid10_log(conf->mddev, "wait rdev %d blocked", blocked_rdev->raid_disk);
 		md_wait_for_blocked_rdev(blocked_rdev, mddev);
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 		goto retry_write;
 	}
 
@@ -1693,7 +1728,7 @@ static void print_conf(struct r10conf *conf)
 
 static void close_sync(struct r10conf *conf)
 {
-	wait_barrier(conf);
+	wait_barrier(conf, false);
 	allow_barrier(conf);
 
 	mempool_destroy(conf->r10buf_pool);
@@ -4365,7 +4400,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 	if (need_flush ||
 	    time_after(jiffies, conf->reshape_checkpoint + 10*HZ)) {
 		/* Need to update reshape_position in metadata */
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 		mddev->reshape_position = conf->reshape_progress;
 		if (mddev->reshape_backwards)
 			mddev->curr_resync_completed = raid10_size(mddev, 0, 0)
-- 
2.14.2
