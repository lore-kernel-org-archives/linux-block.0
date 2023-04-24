Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77881C77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 20:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjDXUdn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXUdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:41 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0FE55AE
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:36 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso6085491b3a.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368416; x=1684960416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tdPWENE116TMSBILZv2mWrtRSpu1nCQ7jTo9np+GS8=;
        b=LCAtN0YKn+EH80A5X9XTHaxMOS1zl/9fqPLfYvnP2ZOqvUsucjZazdNw73R6Xac2av
         N0jKrQH22crcfcLXafiGlXEB8/0WlFxqLzSh1OHplYwlJnnbq0nzJBlIseKmw+RraJ1v
         13mD/eoZAnbHGqL39xsDWNE6H/Vh5e7UU4u6vgR2TLK04c6EYA0L8TB+nKMMjYZCUga2
         /rWOoKTaFnEiDnwcjE/FuFmWVGZ0hNepOSVro9Y25LUcJwH8MdiBZjqLwAkSYEThFywb
         Ta4VpORuk6dponMfcfqR/bcIZI6WrGJfyXjVU0xeNequABrEXWjVR+wnMRRdRVJHDOpk
         2rlw==
X-Gm-Message-State: AAQBX9cvviyrzA0i1L1Aio8qWeaKPlFvUJpfRPT8/OlwG1UQbVYMZxF0
        TQz1/CDdlH5VFKeOneFd2aI=
X-Google-Smtp-Source: AKy350YAi3/DSSlzNpGv43wAgZJ++DR3PS9RxHF53PxCSJcTxJnPqnGlgk5FcTnpRPgck2WCg4Tf6Q==
X-Received: by 2002:a05:6a21:2c94:b0:f0:916:e6f with SMTP id ua20-20020a056a212c9400b000f009160e6fmr13502831pzb.32.1682368416261;
        Mon, 24 Apr 2023 13:33:36 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56cb:b39a:c8b:8c37])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm7417505pff.73.2023.04.24.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:33:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 2/9] block: Micro-optimize blk_req_needs_zone_write_lock()
Date:   Mon, 24 Apr 2023 13:33:22 -0700
Message-ID: <20230424203329.2369688-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230424203329.2369688-1-bvanassche@acm.org>
References: <20230424203329.2369688-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Micro-optimize blk_req_needs_zone_write_lock() by inlining
bdev_op_is_zoned_write(). This is a micro-optimization because the
number of pointers that is dereferenced while testing whether the
request queue is associated with a zoned device is reduced.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.h         |  5 +++--
 block/blk-zoned.c      | 11 ++++-------
 include/linux/blkdev.h |  9 ---------
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index e876584d3516..6bb1281a61f2 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -367,8 +367,9 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 static inline struct blk_plug *blk_mq_plug( struct bio *bio)
 {
 	/* Zoned block device write operation case: do not plug the BIO */
-	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
+	if ((bio_op(bio) == REQ_OP_WRITE ||
+	     bio_op(bio) == REQ_OP_WRITE_ZEROES) &&
+	    disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector))
 		return NULL;
 
 	/*
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 835d9e937d4d..4640b75ae66f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -57,13 +57,10 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
  */
 bool blk_req_needs_zone_write_lock(struct request *rq)
 {
-	if (!rq->q->disk->seq_zones_wlock)
-		return false;
-
-	if (bdev_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
-		return blk_rq_zone_is_seq(rq);
-
-	return false;
+	return rq->q->disk->seq_zones_wlock &&
+		(req_op(rq) == REQ_OP_WRITE ||
+		 req_op(rq) == REQ_OP_WRITE_ZEROES) &&
+		blk_rq_zone_is_seq(rq);
 }
 EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e3242e67a8e3..b700c935e230 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1284,15 +1284,6 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
 	return disk_zone_no(bdev->bd_disk, sec);
 }
 
-static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
-					  blk_opf_t op)
-{
-	if (!bdev_is_zoned(bdev))
-		return false;
-
-	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
-}
-
 static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
