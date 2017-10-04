Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	shli@kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 8/9] dm: Add nowait support to dm-delay
Date: Wed,  4 Oct 2017 08:55:10 -0500
Message-Id: <20171004135511.26110-9-rgoldwyn@suse.de>
In-Reply-To: <20171004135511.26110-1-rgoldwyn@suse.de>
References: <20171004135511.26110-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

I/O should bail out if any value for delay is set.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/dm-delay.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 2209a9700acd..e67a7042ae68 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -240,6 +240,10 @@ static int delay_bio(struct delay_c *dc, int delay, struct bio *bio)
 	if (!delay || !atomic_read(&dc->may_delay))
 		return DM_MAPIO_REMAPPED;
 
+	if (bio->bi_opf & REQ_NOWAIT) {
+		bio_wouldblock_error(bio);
+		return DM_MAPIO_SUBMITTED;
+	}
 	delayed = dm_per_bio_data(bio, sizeof(struct dm_delay_info));
 
 	delayed->context = dc;
-- 
2.14.2
