Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30063 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752692AbcFHUvj (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 8 Jun 2016 16:51:39 -0400
From: Michael Callahan <michaelcallahan@fb.com>
To: <linux-block@vger.kernel.org>
CC: Michael Callahan <michaelcallahan@fb.com>, <axboe@fb.com>,
	<coder.callahan@gmail.com>, <kernel-team@fb.com>
Subject: [PATCH 1/4] block: Add part_stat_read_accum to read across field entries.
Date: Wed, 8 Jun 2016 16:50:52 -0400
Message-ID: <2a33028bd4631b4f85e62b0790201fa3ecb12964.1464912896.git.michaelcallahan@fb.com>
In-Reply-To: <cover.1464912896.git.michaelcallahan@fb.com>
References: <cover.1464912896.git.michaelcallahan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a part_stat_read_accum macro to genhd.h to read and sum across field
entries.  For example to sum up the number read and write sectors
completed.  In addition to being ar reasonable cleanup by itself this
will make it easier to add new stat fields in the future.

Signed-off-by: Michael Callahan <michaelcallahan@fb.com>
---
 drivers/block/drbd/drbd_receiver.c | 3 +--
 drivers/block/drbd/drbd_worker.c   | 4 +---
 drivers/md/md.c                    | 3 +--
 include/linux/genhd.h              | 4 ++++
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 050aaa1..3d490a7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2504,8 +2504,7 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 	if (c_min_rate == 0)
 		return false;
 
-	curr_events = (int)part_stat_read(&disk->part0, sectors[0]) +
-		      (int)part_stat_read(&disk->part0, sectors[1]) -
+	curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
 			atomic_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 4d87499..3e56209 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1591,9 +1591,7 @@ void drbd_rs_controller_reset(struct drbd_device *device)
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
index 866825f..38f819c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7635,8 +7635,7 @@ static int is_mddev_idle(struct mddev *mddev, int init)
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
index 359a8e4..6ab71b6 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -364,6 +364,10 @@ static inline void free_part_stats(struct hd_struct *part)
 
 #endif /* CONFIG_SMP */
 
+#define part_stat_read_accum(part, field)				\
+	(part_stat_read(part, field[0]) +				\
+	 part_stat_read(part, field[1]))
+
 #define part_stat_add(cpu, part, field, addnd)	do {			\
 	__part_stat_add((cpu), (part), field, addnd);			\
 	if ((part)->partno)						\
-- 
1.9.3

