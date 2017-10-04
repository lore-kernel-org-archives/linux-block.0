Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33901 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752267AbdJDNzb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Oct 2017 09:55:31 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, shli@kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 6/9] dm: add nowait support
Date: Wed,  4 Oct 2017 08:55:08 -0500
Message-Id: <20171004135511.26110-7-rgoldwyn@suse.de>
In-Reply-To: <20171004135511.26110-1-rgoldwyn@suse.de>
References: <20171004135511.26110-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Add support for bio based dm devices, which exclusively
sets a make_request_fn(). Request based devices are supported
by default.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/dm.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 6e54145969c5..b721716862a2 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1522,6 +1522,8 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 
 		if (!(bio->bi_opf & REQ_RAHEAD))
 			queue_io(md, bio);
+		else if (bio->bi_opf & REQ_NOWAIT)
+			bio_wouldblock_error(bio);
 		else
 			bio_io_error(bio);
 		return BLK_QC_T_NONE;
@@ -2011,6 +2013,29 @@ struct queue_limits *dm_get_queue_limits(struct mapped_device *md)
 }
 EXPORT_SYMBOL_GPL(dm_get_queue_limits);
 
+static int device_supports_nowait(struct dm_target *ti, struct dm_dev *dev,
+				  sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+	return q && blk_queue_supports_nowait(q);
+}
+
+static bool dm_table_supports_nowait(struct dm_table *t)
+{
+	struct dm_target *ti;
+	unsigned i;
+
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->type->iterate_devices ||
+		    !ti->type->iterate_devices(ti, device_supports_nowait, NULL))
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * Setup the DM device's queue based on md's type
  */
@@ -2044,7 +2069,8 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 		 */
 		bioset_free(md->queue->bio_split);
 		md->queue->bio_split = NULL;
-
+		if (dm_table_supports_nowait(t))
+			queue_flag_set_unlocked(QUEUE_FLAG_NOWAIT, md->queue);
 		if (type == DM_TYPE_DAX_BIO_BASED)
 			queue_flag_set_unlocked(QUEUE_FLAG_DAX, md->queue);
 		break;
-- 
2.14.2
