Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	shli@kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 7/9] dm: Add nowait support to raid1
Date: Wed,  4 Oct 2017 08:55:09 -0500
Message-Id: <20171004135511.26110-8-rgoldwyn@suse.de>
In-Reply-To: <20171004135511.26110-1-rgoldwyn@suse.de>
References: <20171004135511.26110-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

If the I/O would block because the devices are syncing, bail.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/dm-raid1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index c0b82136b2d1..96044b7787f9 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -1204,6 +1204,14 @@ static int mirror_map(struct dm_target *ti, struct bio *bio)
 	if (rw == WRITE) {
 		/* Save region for mirror_end_io() handler */
 		bio_record->write_region = dm_rh_bio_to_region(ms->rh, bio);
+		if (bio->bi_opf & REQ_NOWAIT) {
+			int state = dm_rh_get_state(ms->rh,
+					bio_record->write_region, 1);
+			if (state != DM_RH_CLEAN && state != DM_RH_DIRTY) {
+				bio_wouldblock_error(bio);
+				return DM_MAPIO_SUBMITTED;
+			}
+		}
 		queue_bio(ms, bio, rw);
 		return DM_MAPIO_SUBMITTED;
 	}
@@ -1219,6 +1227,11 @@ static int mirror_map(struct dm_target *ti, struct bio *bio)
 		if (bio->bi_opf & REQ_RAHEAD)
 			return DM_MAPIO_KILL;
 
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return DM_MAPIO_SUBMITTED;
+		}
+
 		queue_bio(ms, bio, rw);
 		return DM_MAPIO_SUBMITTED;
 	}
-- 
2.14.2
