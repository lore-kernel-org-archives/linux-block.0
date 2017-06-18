Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44901 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752998AbdFREk2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 00:40:28 -0400
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@fb.com>
Date: Sun, 18 Jun 2017 14:38:58 +1000
Subject: [PATCH 08/13] pktcdvd: use bio_clone_fast() instead of bio_clone()
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <149776073849.23258.16678605618298313321.stgit@noble>
In-Reply-To: <149776047907.23258.8058071140236879834.stgit@noble>
References: <149776047907.23258.8058071140236879834.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

pktcdvd doesn't change the bi_io_vec of the clone bio,
so it is more efficient to use bio_clone_fast(), and not clone
the bi_io_vec.
This requires providing a bio_set, and it is safest to
provide a dedicated bio_set rather than sharing
fs_bio_set, which filesytems use.
This new bio_set, pkt_bio_set, can also be use for the bio_split()
call as the two allocations (bio_clone_fast, and bio_split) are
independent, neither can block a bio allocated by the other.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/block/pktcdvd.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 1f363638b453..26c04baae967 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -98,6 +98,7 @@ static int write_congestion_on  = PKT_WRITE_CONGESTION_ON;
 static int write_congestion_off = PKT_WRITE_CONGESTION_OFF;
 static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
 static mempool_t *psd_pool;
+static struct bio_set *pkt_bio_set;
 
 static struct class	*class_pktcdvd = NULL;    /* /sys/class/pktcdvd */
 static struct dentry	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
@@ -2310,7 +2311,7 @@ static void pkt_end_io_read_cloned(struct bio *bio)
 
 static void pkt_make_request_read(struct pktcdvd_device *pd, struct bio *bio)
 {
-	struct bio *cloned_bio = bio_clone(bio, GFP_NOIO);
+	struct bio *cloned_bio = bio_clone_fast(bio, GFP_NOIO, pkt_bio_set);
 	struct packet_stacked_data *psd = mempool_alloc(psd_pool, GFP_NOIO);
 
 	psd->pd = pd;
@@ -2455,7 +2456,7 @@ static blk_qc_t pkt_make_request(struct request_queue *q, struct bio *bio)
 
 			split = bio_split(bio, last_zone -
 					  bio->bi_iter.bi_sector,
-					  GFP_NOIO, fs_bio_set);
+					  GFP_NOIO, pkt_bio_set);
 			bio_chain(split, bio);
 		} else {
 			split = bio;
@@ -2924,6 +2925,11 @@ static int __init pkt_init(void)
 					sizeof(struct packet_stacked_data));
 	if (!psd_pool)
 		return -ENOMEM;
+	pkt_bio_set = bioset_create(BIO_POOL_SIZE, 0, 0);
+	if (!pkt_bio_set) {
+		mempool_destroy(psd_pool);
+		return -ENOMEM;
+	}
 
 	ret = register_blkdev(pktdev_major, DRIVER_NAME);
 	if (ret < 0) {
@@ -2956,6 +2962,7 @@ static int __init pkt_init(void)
 	unregister_blkdev(pktdev_major, DRIVER_NAME);
 out2:
 	mempool_destroy(psd_pool);
+	bioset_free(pkt_bio_set);
 	return ret;
 }
 
@@ -2969,6 +2976,7 @@ static void __exit pkt_exit(void)
 
 	unregister_blkdev(pktdev_major, DRIVER_NAME);
 	mempool_destroy(psd_pool);
+	bioset_free(pkt_bio_set);
 }
 
 MODULE_DESCRIPTION("Packet writing layer for CD/DVD drives");
