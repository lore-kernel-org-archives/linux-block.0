Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	shli@kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 5/9] md: raid5 nowait support
Date: Wed,  4 Oct 2017 08:55:07 -0500
Message-Id: <20171004135511.26110-6-rgoldwyn@suse.de>
In-Reply-To: <20171004135511.26110-1-rgoldwyn@suse.de>
References: <20171004135511.26110-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Return EAGAIN in case RAID5 would block because of waiting due to
reshaping.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/raid5.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 928e24a07133..707a3907d100 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5601,6 +5601,13 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	last_sector = bio_end_sector(bi);
 	bi->bi_next = NULL;
 
+	if ((bi->bi_opf & REQ_NOWAIT) &&
+	    conf->reshape_progress != MaxSector &&
+	    (mddev->reshape_backwards ? logical_sector < conf->reshape_safe : last_sector >= conf->reshape_safe)) {
+		bio_wouldblock_error(bi);
+		return true;
+	}
+
 	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
 	for (;logical_sector < last_sector; logical_sector += STRIPE_SECTORS) {
 		int previous;
-- 
2.14.2
