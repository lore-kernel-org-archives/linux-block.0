Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	shli@kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/9] md: raid1 nowait support
Date: Wed,  4 Oct 2017 08:55:05 -0500
Message-Id: <20171004135511.26110-4-rgoldwyn@suse.de>
In-Reply-To: <20171004135511.26110-1-rgoldwyn@suse.de>
References: <20171004135511.26110-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

The RAID1 driver would bail with EAGAIN in case of:
 + I/O has to wait for a barrier
 + array is frozen
 + Area is suspended
 + There are too many pending I/O that it will be queued.

To facilitate error for wait barriers, wait_barrier() is
returning bool. True in case if there was a wait (or is not
required). False in case a wait was required, but was not performed.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/raid1.c | 88 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f3f3e40dc9d8..37ec283e67af 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -891,8 +891,9 @@ static void lower_barrier(struct r1conf *conf, sector_t sector_nr)
 	wake_up(&conf->wait_barrier);
 }
 
-static void _wait_barrier(struct r1conf *conf, int idx)
+static bool _wait_barrier(struct r1conf *conf, int idx, bool nowait)
 {
+	bool ret = true;
 	/*
 	 * We need to increase conf->nr_pending[idx] very early here,
 	 * then raise_barrier() can be blocked when it waits for
@@ -923,7 +924,7 @@ static void _wait_barrier(struct r1conf *conf, int idx)
 	 */
 	if (!READ_ONCE(conf->array_frozen) &&
 	    !atomic_read(&conf->barrier[idx]))
-		return;
+		return ret;
 
 	/*
 	 * After holding conf->resync_lock, conf->nr_pending[idx]
@@ -941,18 +942,29 @@ static void _wait_barrier(struct r1conf *conf, int idx)
 	 */
 	wake_up(&conf->wait_barrier);
 	/* Wait for the barrier in same barrier unit bucket to drop. */
-	wait_event_lock_irq(conf->wait_barrier,
-			    !conf->array_frozen &&
-			     !atomic_read(&conf->barrier[idx]),
-			    conf->resync_lock);
+	if (conf->array_frozen || atomic_read(&conf->barrier[idx])) {
+		if (nowait) {
+			ret = false;
+			goto dec_waiting;
+		} else {
+			wait_event_lock_irq(conf->wait_barrier,
+					!conf->array_frozen &&
+					!atomic_read(&conf->barrier[idx]),
+					conf->resync_lock);
+		}
+	}
 	atomic_inc(&conf->nr_pending[idx]);
+dec_waiting:
 	atomic_dec(&conf->nr_waiting[idx]);
 	spin_unlock_irq(&conf->resync_lock);
+	return ret;
 }
 
-static void wait_read_barrier(struct r1conf *conf, sector_t sector_nr)
+static bool wait_read_barrier(struct r1conf *conf, sector_t sector_nr,
+		bool nowait)
 {
 	int idx = sector_to_idx(sector_nr);
+	bool ret = true;
 
 	/*
 	 * Very similar to _wait_barrier(). The difference is, for read
@@ -964,7 +976,7 @@ static void wait_read_barrier(struct r1conf *conf, sector_t sector_nr)
 	atomic_inc(&conf->nr_pending[idx]);
 
 	if (!READ_ONCE(conf->array_frozen))
-		return;
+		return ret;
 
 	spin_lock_irq(&conf->resync_lock);
 	atomic_inc(&conf->nr_waiting[idx]);
@@ -975,19 +987,31 @@ static void wait_read_barrier(struct r1conf *conf, sector_t sector_nr)
 	 */
 	wake_up(&conf->wait_barrier);
 	/* Wait for array to be unfrozen */
-	wait_event_lock_irq(conf->wait_barrier,
-			    !conf->array_frozen,
-			    conf->resync_lock);
+	if (conf->array_frozen) {
+		/* If nowait flag is set, return false to
+		 * show we did not wait
+		 */
+		if (nowait) {
+			ret = false;
+			goto dec_waiting;
+		} else {
+			wait_event_lock_irq(conf->wait_barrier,
+					!conf->array_frozen,
+					conf->resync_lock);
+		}
+	}
 	atomic_inc(&conf->nr_pending[idx]);
+dec_waiting:
 	atomic_dec(&conf->nr_waiting[idx]);
 	spin_unlock_irq(&conf->resync_lock);
+	return ret;
 }
 
-static void wait_barrier(struct r1conf *conf, sector_t sector_nr)
+static bool wait_barrier(struct r1conf *conf, sector_t sector_nr, bool nowait)
 {
 	int idx = sector_to_idx(sector_nr);
 
-	_wait_barrier(conf, idx);
+	return _wait_barrier(conf, idx, nowait);
 }
 
 static void wait_all_barriers(struct r1conf *conf)
@@ -995,7 +1019,7 @@ static void wait_all_barriers(struct r1conf *conf)
 	int idx;
 
 	for (idx = 0; idx < BARRIER_BUCKETS_NR; idx++)
-		_wait_barrier(conf, idx);
+		_wait_barrier(conf, idx, false);
 }
 
 static void _allow_barrier(struct r1conf *conf, int idx)
@@ -1212,7 +1236,11 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	 * Still need barrier for READ in case that whole
 	 * array is frozen.
 	 */
-	wait_read_barrier(conf, bio->bi_iter.bi_sector);
+	if (!wait_read_barrier(conf, bio->bi_iter.bi_sector,
+				bio->bi_opf & REQ_NOWAIT)) {
+		bio_wouldblock_error(bio);
+		return;
+	}
 
 	if (!r1_bio)
 		r1_bio = alloc_r1bio(mddev, bio);
@@ -1321,6 +1349,11 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		 * an interruptible wait.
 		 */
 		DEFINE_WAIT(w);
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
+
 		for (;;) {
 			sigset_t full, old;
 			prepare_to_wait(&conf->wait_barrier,
@@ -1339,17 +1372,26 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		}
 		finish_wait(&conf->wait_barrier, &w);
 	}
-	wait_barrier(conf, bio->bi_iter.bi_sector);
-
-	r1_bio = alloc_r1bio(mddev, bio);
-	r1_bio->sectors = max_write_sectors;
+	if (!wait_barrier(conf, bio->bi_iter.bi_sector,
+				bio->bi_opf & REQ_NOWAIT)) {
+		bio_wouldblock_error(bio);
+		return;
+	}
 
 	if (conf->pending_count >= max_queued_requests) {
 		md_wakeup_thread(mddev->thread);
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		raid1_log(mddev, "wait queued");
 		wait_event(conf->wait_barrier,
 			   conf->pending_count < max_queued_requests);
 	}
+
+	r1_bio = alloc_r1bio(mddev, bio);
+	r1_bio->sectors = max_write_sectors;
+
 	/* first select target devices under rcu_lock and
 	 * inc refcount on their rdev.  Record them by setting
 	 * bios[x] to bio
@@ -1435,9 +1477,15 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 				rdev_dec_pending(conf->mirrors[j].rdev, mddev);
 		r1_bio->state = 0;
 		allow_barrier(conf, bio->bi_iter.bi_sector);
+
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			free_r1bio(r1_bio);
+			return;
+		}
 		raid1_log(mddev, "wait rdev %d blocked", blocked_rdev->raid_disk);
 		md_wait_for_blocked_rdev(blocked_rdev, mddev);
-		wait_barrier(conf, bio->bi_iter.bi_sector);
+		wait_barrier(conf, bio->bi_iter.bi_sector, false);
 		goto retry_write;
 	}
 
-- 
2.14.2
