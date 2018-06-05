Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: axboe@kernel.dk
Cc: michaelcallahan@fb.com,
	newella@fb.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] block: Add part_stat_read_accum to read across field entries.
Date: Tue,  5 Jun 2018 11:01:16 -0700
Message-Id: <20180605180120.2726113-3-tj@kernel.org>
In-Reply-To: <20180605180120.2726113-1-tj@kernel.org>
References: <20180605180120.2726113-1-tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>

From: Michael Callahan <michaelcallahan@fb.com>

Add a part_stat_read_accum macro to genhd.h to read and sum across
field entries.  For example to sum up the number read and write
sectors completed.  In addition to being ar reasonable cleanup by
itself this will make it easier to add new stat fields in the future.

tj: Refreshed on top of v4.17.

Signed-off-by: Michael Callahan <michaelcallahan@fb.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c | 3 +--
 drivers/block/drbd/drbd_worker.c   | 4 +---
 drivers/md/md.c                    | 3 +--
 include/linux/genhd.h              | 4 ++++
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index be9450f..d7e6973 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2674,8 +2674,7 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 	if (c_min_rate == 0)
 		return false;
 
-	curr_events = (int)part_stat_read(&disk->part0, sectors[0]) +
-		      (int)part_stat_read(&disk->part0, sectors[1]) -
+	curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
 			atomic_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 1476cb3..2063804 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1690,9 +1690,7 @@ void drbd_rs_controller_reset(struct drbd_device *device)
 	atomic_set(&device->rs_sect_in, 0);
 	atomic_set(&device->rs_sect_ev, 0);
 	device->rs_in_flight = 0;
-	device->rs_last_events =
-		(int)part_stat_read(&disk->part0, sectors[0]) +
-		(int)part_stat_read(&disk->part0, sectors[1]);
+	device->rs_last_events = (int)part_stat_read_accum(&disk->part0, sectors);
 
 	/* Updating the RCU protected object in place is necessary since
 	   this function gets called from atomic context.
diff --git a/drivers/md/md.c b/drivers/md/md.c
index fc692b7..817dd97 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8001,8 +8001,7 @@ static int is_mddev_idle(struct mddev *mddev, int init)
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		struct gendisk *disk = rdev->bdev->bd_contains->bd_disk;
-		curr_events = (int)part_stat_read(&disk->part0, sectors[0]) +
-			      (int)part_stat_read(&disk->part0, sectors[1]) -
+		curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
 			      atomic_read(&disk->sync_io);
 		/* sync IO will cause sync_io to increase before the disk_stats
 		 * as sync_io is counted when a request starts, and
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6cb8a57..19f36fa 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -353,6 +353,10 @@ static inline void free_part_stats(struct hd_struct *part)
 
 #endif /* CONFIG_SMP */
 
+#define part_stat_read_accum(part, field)				\
+	(part_stat_read(part, field[0]) +				\
+	 part_stat_read(part, field[1]))
+
 #define part_stat_add(cpu, part, field, addnd)	do {			\
 	__part_stat_add((cpu), (part), field, addnd);			\
 	if ((part)->partno)						\
-- 
2.9.5
