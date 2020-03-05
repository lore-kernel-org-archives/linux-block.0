Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC7C3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 10:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9878208CD
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 10:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCEKDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:03:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:45202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCEKDf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 05:03:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1FA98B2DE;
        Thu,  5 Mar 2020 10:03:33 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] xen/blkfront: fix ring info addressing
Date:   Thu,  5 Mar 2020 11:03:31 +0100
Message-Id: <20200305100331.16790-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to
actual use case") made struct blkfront_ring_info size dynamic. This is
fine when running with only one queue, but with multiple queues the
addressing of the single queues has to be adapted as the structs are
allocated in an array.

Fixes: 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to actual use case")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 82 ++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index e2ad6bba2281..a8d4a3838e5d 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -213,6 +213,7 @@ struct blkfront_info
 	struct blk_mq_tag_set tag_set;
 	struct blkfront_ring_info *rinfo;
 	unsigned int nr_rings;
+	unsigned int rinfo_size;
 	/* Save uncomplete reqs and bios for migration. */
 	struct list_head requests;
 	struct bio_list bio_list;
@@ -259,6 +260,21 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
 static void blkfront_gather_backend_features(struct blkfront_info *info);
 static int negotiate_mq(struct blkfront_info *info);
 
+#define rinfo_ptr(rinfo, off) \
+	(struct blkfront_ring_info *)((unsigned long)(rinfo) + (off))
+
+#define for_each_rinfo(info, rinfo, idx)				\
+	for (rinfo = info->rinfo, idx = 0;				\
+	     idx < info->nr_rings;					\
+	     idx++, rinfo = rinfo_ptr(rinfo, info->rinfo_size))
+
+static struct blkfront_ring_info *get_rinfo(struct blkfront_info *info,
+					    unsigned int i)
+{
+	BUG_ON(i >= info->nr_rings);
+	return rinfo_ptr(info->rinfo, i * info->rinfo_size);
+}
+
 static int get_id_from_freelist(struct blkfront_ring_info *rinfo)
 {
 	unsigned long free = rinfo->shadow_free;
@@ -883,8 +899,7 @@ static blk_status_t blkif_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct blkfront_info *info = hctx->queue->queuedata;
 	struct blkfront_ring_info *rinfo = NULL;
 
-	BUG_ON(info->nr_rings <= qid);
-	rinfo = &info->rinfo[qid];
+	rinfo = get_rinfo(info, qid);
 	blk_mq_start_request(qd->rq);
 	spin_lock_irqsave(&rinfo->ring_lock, flags);
 	if (RING_FULL(&rinfo->ring))
@@ -1181,6 +1196,7 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 static void xlvbd_release_gendisk(struct blkfront_info *info)
 {
 	unsigned int minor, nr_minors, i;
+	struct blkfront_ring_info *rinfo;
 
 	if (info->rq == NULL)
 		return;
@@ -1188,8 +1204,7 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 	/* No more blkif_request(). */
 	blk_mq_stop_hw_queues(info->rq);
 
-	for (i = 0; i < info->nr_rings; i++) {
-		struct blkfront_ring_info *rinfo = &info->rinfo[i];
+	for_each_rinfo(info, rinfo, i) {
 
 		/* No more gnttab callback work. */
 		gnttab_cancel_free_callback(&rinfo->callback);
@@ -1339,6 +1354,7 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 static void blkif_free(struct blkfront_info *info, int suspend)
 {
 	unsigned int i;
+	struct blkfront_ring_info *rinfo;
 
 	/* Prevent new requests being issued until we fix things up. */
 	info->connected = suspend ?
@@ -1347,8 +1363,8 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 	if (info->rq)
 		blk_mq_stop_hw_queues(info->rq);
 
-	for (i = 0; i < info->nr_rings; i++)
-		blkif_free_ring(&info->rinfo[i]);
+	for_each_rinfo(info, rinfo, i)
+		blkif_free_ring(rinfo);
 
 	kvfree(info->rinfo);
 	info->rinfo = NULL;
@@ -1775,6 +1791,7 @@ static int talk_to_blkback(struct xenbus_device *dev,
 	int err;
 	unsigned int i, max_page_order;
 	unsigned int ring_page_order;
+	struct blkfront_ring_info *rinfo;
 
 	if (!info)
 		return -ENODEV;
@@ -1788,9 +1805,7 @@ static int talk_to_blkback(struct xenbus_device *dev,
 	if (err)
 		goto destroy_blkring;
 
-	for (i = 0; i < info->nr_rings; i++) {
-		struct blkfront_ring_info *rinfo = &info->rinfo[i];
-
+	for_each_rinfo(info, rinfo, i) {
 		/* Create shared ring, alloc event channel. */
 		err = setup_blkring(dev, rinfo);
 		if (err)
@@ -1815,7 +1830,7 @@ static int talk_to_blkback(struct xenbus_device *dev,
 
 	/* We already got the number of queues/rings in _probe */
 	if (info->nr_rings == 1) {
-		err = write_per_ring_nodes(xbt, &info->rinfo[0], dev->nodename);
+		err = write_per_ring_nodes(xbt, info->rinfo, dev->nodename);
 		if (err)
 			goto destroy_blkring;
 	} else {
@@ -1837,10 +1852,10 @@ static int talk_to_blkback(struct xenbus_device *dev,
 			goto abort_transaction;
 		}
 
-		for (i = 0; i < info->nr_rings; i++) {
+		for_each_rinfo(info, rinfo, i) {
 			memset(path, 0, pathsize);
 			snprintf(path, pathsize, "%s/queue-%u", dev->nodename, i);
-			err = write_per_ring_nodes(xbt, &info->rinfo[i], path);
+			err = write_per_ring_nodes(xbt, rinfo, path);
 			if (err) {
 				kfree(path);
 				goto destroy_blkring;
@@ -1868,9 +1883,8 @@ static int talk_to_blkback(struct xenbus_device *dev,
 		goto destroy_blkring;
 	}
 
-	for (i = 0; i < info->nr_rings; i++) {
+	for_each_rinfo(info, rinfo, i) {
 		unsigned int j;
-		struct blkfront_ring_info *rinfo = &info->rinfo[i];
 
 		for (j = 0; j < BLK_RING_SIZE(info); j++)
 			rinfo->shadow[j].req.u.rw.id = j + 1;
@@ -1900,6 +1914,7 @@ static int negotiate_mq(struct blkfront_info *info)
 {
 	unsigned int backend_max_queues;
 	unsigned int i;
+	struct blkfront_ring_info *rinfo;
 
 	BUG_ON(info->nr_rings);
 
@@ -1911,20 +1926,16 @@ static int negotiate_mq(struct blkfront_info *info)
 	if (!info->nr_rings)
 		info->nr_rings = 1;
 
-	info->rinfo = kvcalloc(info->nr_rings,
-			       struct_size(info->rinfo, shadow,
-					   BLK_RING_SIZE(info)),
-			       GFP_KERNEL);
+	info->rinfo_size = struct_size(info->rinfo, shadow,
+				       BLK_RING_SIZE(info));
+	info->rinfo = kvcalloc(info->nr_rings, info->rinfo_size, GFP_KERNEL);
 	if (!info->rinfo) {
 		xenbus_dev_fatal(info->xbdev, -ENOMEM, "allocating ring_info structure");
 		info->nr_rings = 0;
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < info->nr_rings; i++) {
-		struct blkfront_ring_info *rinfo;
-
-		rinfo = &info->rinfo[i];
+	for_each_rinfo(info, rinfo, i) {
 		INIT_LIST_HEAD(&rinfo->indirect_pages);
 		INIT_LIST_HEAD(&rinfo->grants);
 		rinfo->dev_info = info;
@@ -2017,6 +2028,7 @@ static int blkif_recover(struct blkfront_info *info)
 	int rc;
 	struct bio *bio;
 	unsigned int segs;
+	struct blkfront_ring_info *rinfo;
 
 	blkfront_gather_backend_features(info);
 	/* Reset limits changed by blk_mq_update_nr_hw_queues(). */
@@ -2024,9 +2036,7 @@ static int blkif_recover(struct blkfront_info *info)
 	segs = info->max_indirect_segments ? : BLKIF_MAX_SEGMENTS_PER_REQUEST;
 	blk_queue_max_segments(info->rq, segs / GRANTS_PER_PSEG);
 
-	for (r_index = 0; r_index < info->nr_rings; r_index++) {
-		struct blkfront_ring_info *rinfo = &info->rinfo[r_index];
-
+	for_each_rinfo(info, rinfo, r_index) {
 		rc = blkfront_setup_indirect(rinfo);
 		if (rc)
 			return rc;
@@ -2036,10 +2046,7 @@ static int blkif_recover(struct blkfront_info *info)
 	/* Now safe for us to use the shared ring */
 	info->connected = BLKIF_STATE_CONNECTED;
 
-	for (r_index = 0; r_index < info->nr_rings; r_index++) {
-		struct blkfront_ring_info *rinfo;
-
-		rinfo = &info->rinfo[r_index];
+	for_each_rinfo(info, rinfo, r_index) {
 		/* Kick any other new requests queued since we resumed */
 		kick_pending_request_queues(rinfo);
 	}
@@ -2072,13 +2079,13 @@ static int blkfront_resume(struct xenbus_device *dev)
 	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
 	int err = 0;
 	unsigned int i, j;
+	struct blkfront_ring_info *rinfo;
 
 	dev_dbg(&dev->dev, "blkfront_resume: %s\n", dev->nodename);
 
 	bio_list_init(&info->bio_list);
 	INIT_LIST_HEAD(&info->requests);
-	for (i = 0; i < info->nr_rings; i++) {
-		struct blkfront_ring_info *rinfo = &info->rinfo[i];
+	for_each_rinfo(info, rinfo, i) {
 		struct bio_list merge_bio;
 		struct blk_shadow *shadow = rinfo->shadow;
 
@@ -2337,6 +2344,7 @@ static void blkfront_connect(struct blkfront_info *info)
 	unsigned int binfo;
 	char *envp[] = { "RESIZE=1", NULL };
 	int err, i;
+	struct blkfront_ring_info *rinfo;
 
 	switch (info->connected) {
 	case BLKIF_STATE_CONNECTED:
@@ -2394,8 +2402,8 @@ static void blkfront_connect(struct blkfront_info *info)
 						    "physical-sector-size",
 						    sector_size);
 	blkfront_gather_backend_features(info);
-	for (i = 0; i < info->nr_rings; i++) {
-		err = blkfront_setup_indirect(&info->rinfo[i]);
+	for_each_rinfo(info, rinfo, i) {
+		err = blkfront_setup_indirect(rinfo);
 		if (err) {
 			xenbus_dev_fatal(info->xbdev, err, "setup_indirect at %s",
 					 info->xbdev->otherend);
@@ -2416,8 +2424,8 @@ static void blkfront_connect(struct blkfront_info *info)
 
 	/* Kick pending requests. */
 	info->connected = BLKIF_STATE_CONNECTED;
-	for (i = 0; i < info->nr_rings; i++)
-		kick_pending_request_queues(&info->rinfo[i]);
+	for_each_rinfo(info, rinfo, i)
+		kick_pending_request_queues(rinfo);
 
 	device_add_disk(&info->xbdev->dev, info->gd, NULL);
 
@@ -2652,9 +2660,9 @@ static void purge_persistent_grants(struct blkfront_info *info)
 {
 	unsigned int i;
 	unsigned long flags;
+	struct blkfront_ring_info *rinfo;
 
-	for (i = 0; i < info->nr_rings; i++) {
-		struct blkfront_ring_info *rinfo = &info->rinfo[i];
+	for_each_rinfo(info, rinfo, i) {
 		struct grant *gnt_list_entry, *tmp;
 
 		spin_lock_irqsave(&rinfo->ring_lock, flags);
-- 
2.16.4

