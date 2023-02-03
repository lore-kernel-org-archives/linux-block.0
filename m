Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E78C64EC4
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 10:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjBCKda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Feb 2023 05:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjBCKdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2023 05:33:04 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AC6A42AB
        for <linux-block@vger.kernel.org>; Fri,  3 Feb 2023 02:31:29 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230203103128euoutp02c9a875a9674e923be31b7763f0bb97a6~ASeAdUMFa1485114851euoutp02P
        for <linux-block@vger.kernel.org>; Fri,  3 Feb 2023 10:31:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230203103128euoutp02c9a875a9674e923be31b7763f0bb97a6~ASeAdUMFa1485114851euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675420288;
        bh=9L7QX4wmZeQtgIz4OuKDXIM6BjBhTEzDsWEz/pfs10M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OM9BZk4r3/x9fia/I+7LTIJKP+tSZImGgs02MPlk9yQrOB90ZN1wX380t1gePs0Oa
         S7f/GZL29cqDW/rcbyGN852WWar+xM2PI4kUU0tYD1CDtRIr5/iTQo/naAtCwX7HnW
         fDNepnC7v3OnoYXZI0R0A5QO2xk41KqCMSueWex4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230203103127eucas1p1c9189464659a99e7acf5e4dbe918e96e~ASd-sYzSX1026510265eucas1p10;
        Fri,  3 Feb 2023 10:31:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BA.37.01471.F72ECD36; Fri,  3
        Feb 2023 10:31:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230203103127eucas1p293a9fa97366fc89c62f18053be6aca1f~ASd-RICYW2641226412eucas1p2F;
        Fri,  3 Feb 2023 10:31:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230203103126eusmtrp286e7f173d844d6e9fa869f6fa797915f~ASd-OJqg_2939029390eusmtrp2_;
        Fri,  3 Feb 2023 10:31:26 +0000 (GMT)
X-AuditID: cbfec7f2-29bff700000105bf-57-63dce27fbf6d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6C.14.00518.E72ECD36; Fri,  3
        Feb 2023 10:31:26 +0000 (GMT)
Received: from localhost (unknown [106.210.248.242]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230203103126eusmtip1c47cca5b3934e3334bbdbac4a31db44c~ASd_3bxvy2041120411eusmtip1N;
        Fri,  3 Feb 2023 10:31:26 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, mcgrof@kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] brd: improve performance with blk-mq
Date:   Fri,  3 Feb 2023 16:00:06 +0530
Message-Id: <20230203103005.31290-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203103005.31290-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOd36R3eSDR69FrVYfbefzeLmgZ1M
        FitXH2Wy2HtL2+LGhKeMFp+XtrA7sHlcPlvqsWlVJ5vH7psNbB59W1YxenzeJBfAGsVlk5Ka
        k1mWWqRvl8CVcWiJWsE37Yo7N+4zNzBuV+pi5OSQEDCR+LCml7GLkYtDSGAFo8SyR9NYIJwv
        jBLHfm9kgnA+M0psnrGcGablZNtNqJbljBKvj/5kg3BeMkpsf/weqJ+Dg01AS6Kxkx2kQURA
        WGJ/RysLiM0sUCOx9NR+sEHCAqYSbdePs4HYLAKqEn1HDoLZvAKWEtcPv2aHWCYvMfPSdzCb
        U8BK4u3TxVA1ghInZz6Bmikv0bx1NjPIDRICKzkk2l+fYgK5QULAReL6VA6IOcISr45vgZop
        I/F/53wmCLta4umN31C9LYwS/TvXs0H0Wkv0nckBMZkFNCXW79KHiDpKdGzThjD5JG68FYQ4
        gE9i0rbpzBBhXomONiGI2UoSO38+gdopIXG5aQ4LhO0hMf17B8sERsVZSF6ZheSVWQhrFzAy
        r2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMKqf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ
        8C4/fSdZiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+27clkIYH0xJLU7NTUgtQimCwTB6dUA5Pl
        3KVle3hnncx+Y23XFfHd3LSk4uBtw4IgOaG7VieltrR/fjZ9ssV963W1dhdOXpn7uZlxHtPD
        KQu5V1gkWT0TepY6882tKlGG+N3xO7w/alUZ5it6byhkyEw+uWc/u7H2CoNZl5/9tfG+fPvl
        Tp/Z8a6miUeazcQTD07UqJwsts//6Kmd6gV21p/am97MzmlWm/v7saprZ7m7WYFwzjeDY7Mz
        25cxy381md9643DQgiYVuTes0SF/mz0jAwsOJtReDG68diHfPzh1z9nMd5oNH+e+SbG6pT6D
        PSvNIsLRu26S677v5g92nsrbf06wfeWOslOhJWvUv63y+i5RelpV8SePtrHOoxO/36v+L1di
        Kc5INNRiLipOBACGAdjwmQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsVy+t/xu7p1j+4kG/zdb2Gx+m4/m8XNAzuZ
        LFauPspksfeWtsWNCU8ZLT4vbWF3YPO4fLbUY9OqTjaP3Tcb2Dz6tqxi9Pi8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49AStYJv2hV3
        btxnbmDcrtTFyMkhIWAicbLtJmMXIxeHkMBSRom/m5+wQiQkJG4vbGKEsIUl/lzrYoMoes4o
        MWEeiMPBwSagJdHYyQ5SIwJUs7+jlQWkhlmgiVFi+dLZLCAJYQFTibbrx9lAbBYBVYm+IwfB
        bF4BS4nrh1+zQyyQl5h56TuYzSlgJfH26WKwGiGgmjX7djNB1AtKnJz5BGwmM1B989bZzBMY
        BWYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMAq2Hfu5ZQfjylcf9Q4xMnEw
        HmKU4GBWEuFdfvpOshBvSmJlVWpRfnxRaU5q8SFGU6C7JzJLiSbnA+MwryTe0MzA1NDEzNLA
        1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBqWWZyzKWhKY9y5Nmfdmds4y/NCjv3NIt
        ptLnd78vPnzSZ/0My0tb9H2M5162adOWTnh7aO2GbIPamN1L9TynPPQu9rZLesdhKyDRKD01
        7/S87/IvszV52OJYZ10oec94Y+LNcJuLd5rP3SkP7VrWV2PfzHsl8PHKfdZKIU5f4q+dn/lu
        YmNa65ZNph4CRm+P5dwWXOzzynXNMT/v9te7bvI7V/T/9csqPZF8JXeDZeKDDpeA1xN8W+5a
        MnUzLGTZslvTesFXBgHDSf/ET9hf0S4N/23ibSZ1fNLy7v/BEpXvj04KXfJoyxdX65Ozw3L9
        1L8+6J93YpfhM+3W56+UfBwWRhfHhKYaHj756M0MSyWW4oxEQy3mouJEALoP5CQLAwAA
X-CMS-MailID: 20230203103127eucas1p293a9fa97366fc89c62f18053be6aca1f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230203103127eucas1p293a9fa97366fc89c62f18053be6aca1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203103127eucas1p293a9fa97366fc89c62f18053be6aca1f
References: <20230203103005.31290-1-p.raghav@samsung.com>
        <CGME20230203103127eucas1p293a9fa97366fc89c62f18053be6aca1f@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

move to blk-mq based request processing as brd is one of the few drivers
that still uses submit_bio interface. The changes are pretty trivial
to start using blk-mq. The performance increases up to 125% for direct IO
read workloads. There is a slight dip in performance for direct IO write
workload but considering the general performance gain with blk-mq
support, it is not a lot.

SW queues are mapped to one hw queue in the brd device, and rest of IO
processing is retained as is.

Performance results with none scheduler:

--direct=0
------------------------------------------------------
|            | bio(base) | blk-mq            | delta |
------------------------------------------------------
| randread   | 133       | 223               | +75%  |
------------------------------------------------------
| read       | 150       | 313               | +108% |
-----------------------------------------------------
| randwrite  | 111       | 109               | -1.8% |
-----------------------------------------------------
| write      | 118       | 117               | -0.8%|
-----------------------------------------------------

--direct=1
------------------------------------------------------
|            | bio(base) | blk-mq            | delta |
------------------------------------------------------
| randread   | 182       | 414               | +127% |
------------------------------------------------------
| read       | 190       | 429               | +125% |
-----------------------------------------------------
| randwrite  | 378       | 387               | +2.38%|
-----------------------------------------------------
| write      | 443       | 420               | -5.1% |
-----------------------------------------------------

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/brd.c | 64 +++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 37dce184eb56..99b37ac31532 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -16,6 +16,7 @@
 #include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/bio.h>
+#include <linux/blk-mq.h>
 #include <linux/highmem.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
@@ -46,6 +47,7 @@ struct brd_device {
 	spinlock_t		brd_lock;
 	struct radix_tree_root	brd_pages;
 	u64			brd_nr_pages;
+	struct blk_mq_tag_set tag_set;
 };
 
 /*
@@ -282,36 +284,46 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 	return err;
 }
 
-static void brd_submit_bio(struct bio *bio)
+static blk_status_t brd_queue_rq(struct blk_mq_hw_ctx *hctx,
+				 const struct blk_mq_queue_data *bd)
 {
-	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
-	sector_t sector = bio->bi_iter.bi_sector;
+	struct request *rq = bd->rq;
+	struct brd_device *brd = hctx->queue->queuedata;
+	sector_t sector = blk_rq_pos(rq);
 	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct req_iterator iter;
+	blk_status_t err = BLK_STS_OK;
 
-	bio_for_each_segment(bvec, bio, iter) {
+	blk_mq_start_request(bd->rq);
+	rq_for_each_segment(bvec, rq, iter) {
 		unsigned int len = bvec.bv_len;
-		int err;
+		int ret;
 
 		/* Don't support un-aligned buffer */
 		WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
-				(len & (SECTOR_SIZE - 1)));
+			     (len & (SECTOR_SIZE - 1)));
 
-		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
-				  bio_op(bio), sector);
-		if (err) {
-			bio_io_error(bio);
-			return;
+		ret = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
+				  req_op(rq), sector);
+		if (ret) {
+			err = BLK_STS_IOERR;
+			goto end_request;
 		}
 		sector += len >> SECTOR_SHIFT;
 	}
 
-	bio_endio(bio);
+end_request:
+	blk_mq_end_request(bd->rq, err);
+	return BLK_STS_OK;
 }
 
+static const struct blk_mq_ops brd_mq_ops = {
+	.queue_rq = brd_queue_rq,
+};
+
+
 static const struct block_device_operations brd_fops = {
 	.owner =		THIS_MODULE,
-	.submit_bio =		brd_submit_bio,
 };
 
 /*
@@ -355,7 +367,7 @@ static int brd_alloc(int i)
 	struct brd_device *brd;
 	struct gendisk *disk;
 	char buf[DISK_NAME_LEN];
-	int err = -ENOMEM;
+	int err = 0;
 
 	list_for_each_entry(brd, &brd_devices, brd_list)
 		if (brd->brd_number == i)
@@ -364,6 +376,14 @@ static int brd_alloc(int i)
 	if (!brd)
 		return -ENOMEM;
 	brd->brd_number		= i;
+	brd->tag_set.ops = &brd_mq_ops;
+	brd->tag_set.queue_depth = 128;
+	brd->tag_set.numa_node = NUMA_NO_NODE;
+	brd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	brd->tag_set.cmd_size = 0;
+	brd->tag_set.driver_data = brd;
+	brd->tag_set.nr_hw_queues = 1;
+
 	list_add_tail(&brd->brd_list, &brd_devices);
 
 	spin_lock_init(&brd->brd_lock);
@@ -374,9 +394,17 @@ static int brd_alloc(int i)
 		debugfs_create_u64(buf, 0444, brd_debugfs_dir,
 				&brd->brd_nr_pages);
 
-	disk = brd->brd_disk = blk_alloc_disk(NUMA_NO_NODE);
-	if (!disk)
+	err = blk_mq_alloc_tag_set(&brd->tag_set);
+	if (err) {
+		err = -ENOMEM;
 		goto out_free_dev;
+	}
+
+	disk = brd->brd_disk = blk_mq_alloc_disk(&brd->tag_set, brd);
+	if (IS_ERR(disk)) {
+		err = PTR_ERR(disk);
+		goto out_free_tags;
+	}
 
 	disk->major		= RAMDISK_MAJOR;
 	disk->first_minor	= i * max_part;
@@ -407,6 +435,8 @@ static int brd_alloc(int i)
 
 out_cleanup_disk:
 	put_disk(disk);
+out_free_tags:
+	blk_mq_free_tag_set(&brd->tag_set);
 out_free_dev:
 	list_del(&brd->brd_list);
 	kfree(brd);
-- 
2.39.0

