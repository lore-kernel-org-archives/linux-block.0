Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DBBC282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF484222BB
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D6iQnOMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbfBMJx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:53:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53074 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbfBMJx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 04:53:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D9mmfO163884;
        Wed, 13 Feb 2019 09:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=2wZDrRNrAY5VIL2j189QrnXnQMZPgZexfpu7AfD7Jcw=;
 b=D6iQnOMZNOFS/c+y1HeMx1uNa9jPD/OyIL4PivtVrhfQQt2vBkaw0YKVSfRD4PyA7BuK
 L7XVWNpWzFCg+xLC8AHtbq2ftI+JnoYsE2Mm/AHLpcLlDKFPZRP6xqZXCdAIMnHsEH/4
 Mg2Kf3cm5Sx+lmyA09YRc7KkdAi9Wbr3lGy8Q6f3t66ycEtruAW1QBvs5PDKvreQj+Sa
 3oxoUg15riR13PRUS+V6Sbltt35wYJ5OIHUqgSxjd3bxnrEXlqRjUlY4djczIvKqbH/R
 8U9DMX8vR8Misw39v/iogCp5mOujbIcavcQpou9sfhhjLQnZcgFim2atnsK3cerYi0X5 cw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qhree11rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:22 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rLbh019626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:21 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rLtL000518;
        Wed, 13 Feb 2019 09:53:21 GMT
Received: from localhost.localdomain (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 09:53:20 +0000
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        Bob Liu <bob.liu@oracle.com>
Subject: [RFC PATCH v2 2/9] block: add rd_hint to bio and request
Date:   Wed, 13 Feb 2019 17:50:37 +0800
Message-Id: <20190213095044.29628-3-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213095044.29628-1-bob.liu@oracle.com>
References: <20190213095044.29628-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rd_hint is a bitmap for stacked layer support(see patch 4/9),
set a bit to 1 means already read from the corresponding mirror device.

rd_hint will be set properly recording read i/o went to which real device
during end_bio().
If the upper layer want to retry other mirrors, just preserve the returned
bi_rd_hint and resubmit bio.

The upper layer e.g fs can set bitmap_zero(rd_hint) if don't care about alt
mirror device retry feature which is also the default setting.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 Documentation/block/biodoc.txt | 3 +++
 block/bio.c                    | 1 +
 block/blk-core.c               | 1 +
 block/blk-merge.c              | 6 ++++++
 block/bounce.c                 | 1 +
 drivers/md/raid1.c             | 1 +
 include/linux/blk_types.h      | 1 +
 include/linux/blkdev.h         | 1 +
 8 files changed, 15 insertions(+)

diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index ac18b488cb5e..c6b5dfc9314b 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -430,6 +430,7 @@ struct bio {
        struct bio          *bi_next;    /* request queue link */
        struct block_device *bi_bdev;	/* target device */
        unsigned long       bi_flags;    /* status, command, etc */
+       DECLARE_BITMAP(bi_rd_hint, BLKDEV_MAX_MIRRORS); /* bio read hint */
        unsigned long       bi_opf;       /* low bits: r/w, high: priority */
 
        unsigned int	bi_vcnt;     /* how may bio_vec's */
@@ -464,6 +465,8 @@ With this multipage bio design:
   (e.g a 1MB bio_vec needs to be handled in max 128kB chunks for IDE)
   [TBD: Should preferably also have a bi_voffset and bi_vlen to avoid modifying
    bi_offset an len fields]
+- bi_rd_hint is an in/out bitmap parameter, set a bit to 1 means already read
+  from the corresponding mirror device.
 
 (*) unrelated merges -- a request ends up containing two or more bios that
     didn't originate from the same place.
diff --git a/block/bio.c b/block/bio.c
index 4db1008309ed..0e97d75edbd4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -606,6 +606,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
+	bitmap_copy(bio->bi_rd_hint, bio_src->bi_rd_hint, BLKDEV_MAX_MIRRORS);
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
diff --git a/block/blk-core.c b/block/blk-core.c
index b838c6dc5357..c93162b7140c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -742,6 +742,7 @@ void blk_init_request_from_bio(struct request *req, struct bio *bio)
 	req->__sector = bio->bi_iter.bi_sector;
 	req->ioprio = bio_prio(bio);
 	req->write_hint = bio->bi_write_hint;
+	bitmap_copy(req->rd_hint, bio->bi_rd_hint, BLKDEV_MAX_MIRRORS);
 	blk_rq_bio_prep(req->q, req, bio);
 }
 EXPORT_SYMBOL_GPL(blk_init_request_from_bio);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 71e9ac03f621..58982a80eca8 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -745,6 +745,9 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->write_hint != next->write_hint)
 		return NULL;
 
+	if (!bitmap_equal(req->rd_hint, next->rd_hint, BLKDEV_MAX_MIRRORS))
+		return NULL;
+
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
@@ -877,6 +880,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (rq->write_hint != bio->bi_write_hint)
 		return false;
 
+	if (!bitmap_equal(rq->rd_hint, bio->bi_rd_hint, BLKDEV_MAX_MIRRORS))
+		return false;
+
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
diff --git a/block/bounce.c b/block/bounce.c
index ffb9e9ecfa7e..fba66e06b735 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -250,6 +250,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_opf		= bio_src->bi_opf;
 	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
+	bitmap_copy(bio->bi_rd_hint, bio_src->bi_rd_hint, BLKDEV_MAX_MIRRORS);
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 1d54109071cc..1e5a51f22332 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1103,6 +1103,7 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 	}
 
 	behind_bio->bi_write_hint = bio->bi_write_hint;
+	bitmap_copy(behind_bio->bi_rd_hint, bio->bi_rd_hint, BLKDEV_MAX_MIRRORS);
 
 	while (i < vcnt && size) {
 		struct page *page;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d66bf5f32610..49bdd96e2623 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -151,6 +151,7 @@ struct bio {
 	unsigned short		bi_flags;	/* status, etc and bvec pool number */
 	unsigned short		bi_ioprio;
 	unsigned short		bi_write_hint;
+	DECLARE_BITMAP(bi_rd_hint, BLKDEV_MAX_MIRRORS);
 	blk_status_t		bi_status;
 	u8			bi_partno;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0191dc4d3f2d..0a1e93b282c4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -214,6 +214,7 @@ struct request {
 #endif
 
 	unsigned short write_hint;
+	DECLARE_BITMAP(rd_hint, BLKDEV_MAX_MIRRORS);
 	unsigned short ioprio;
 
 	void *special;		/* opaque pointer available for LLD use */
-- 
2.17.1

