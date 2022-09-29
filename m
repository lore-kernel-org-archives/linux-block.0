Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D21C07E9D
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 06:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiI2GYj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 02:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiI2GYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 02:24:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2BEB6F
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 23:24:32 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220929062429euoutp02550af5ff9e2bf519efdd7eacfbb74357~ZQLG7HU3W0561805618euoutp02t
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:24:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220929062429euoutp02550af5ff9e2bf519efdd7eacfbb74357~ZQLG7HU3W0561805618euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664432669;
        bh=EY7aDZPCgJ331fQZRDcffM+8OQ4Ci2fOSZ40zXQaSSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=da3ExLPdP2p2AelmHXQ5elqUudaZpv/nKV4/+AIZq3sr0EgLD5KNWf8uILIZprIXT
         1XDIQMDogHVuMyyNAoqY6NTRcsTzyJJmZ/9MI1NJSO1iY9YBWGgjw2613GWVKQSGYb
         5GJnjZ3Gzc1Pp/ZXqeRzhjJqyQLGHUbMN/MgYKZQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220929062428eucas1p1c15157ec69560ddd2599363648240e9a~ZQLF_xBsc1926419264eucas1p17;
        Thu, 29 Sep 2022 06:24:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5C.83.07817.C1A35336; Thu, 29
        Sep 2022 07:24:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220929062427eucas1p25a6efd73d6cdf8d481adb42f9d4006c3~ZQLFl3Az32726927269eucas1p2J;
        Thu, 29 Sep 2022 06:24:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220929062427eusmtrp1b1dae56e523b898535172500db3a2f80~ZQLFkDUEA0651006510eusmtrp1d;
        Thu, 29 Sep 2022 06:24:27 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-69-63353a1cdcec
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 80.98.10862.B1A35336; Thu, 29
        Sep 2022 07:24:27 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220929062427eusmtip148d0a41123ee6271c07549a0daae2f63~ZQLFUTFIX0995809958eusmtip1G;
        Thu, 29 Sep 2022 06:24:27 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 1/2] block: adapt blk_mq_plug() to not plug for writes
 that require a zone lock
Date:   Thu, 29 Sep 2022 08:24:24 +0200
Message-Id: <20220929062425.91254-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929062425.91254-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87oyVqbJBv8WC1usvtvPZvH77Hlm
        i5sHdjJZnJ6wiMli5eqjTBZ7b2lbfF7awu7A7rF5hZbH5bOlHrtvNrB57Gy9z+rRt2UVo8fn
        TXIBbFFcNimpOZllqUX6dglcGT/Or2EvuCFUsXbZFrYGxjP8XYycHBICJhJdG24xdjFycQgJ
        rGCUuPbkBDOE84VR4vWG22wgVUICnxklXl1Sh+m4eGEXG0TRckaJ6a/3skI4Lxkl9p75w9LF
        yMHBJqAl0djJDtIgIiAv8eX2WhaQGmaQFatv/mMCSQgLpEg82X8DrIhFQFXi6oxOsDivgKXE
        +2d/WSG2yUvMvPQdrIZTwEqi9dg3RogaQYmTM5+wgNjMQDXNW2eDnS0hsIdD4tOS88wgR0gI
        uEjM+B8DMUdY4tXxLewQtozE6ck9LBB2tcTTG7+helsYJfp3rmeD6LWW6DuTA2IyC2hKrN+l
        D1HuKLF7z3QWiAo+iRtvBSEu4JOYtG061FJeiY42IYhqJYmdP59ALZWQuNw0B2qph8SSM5sY
        JzAqzkLyyywkv8xC2LuAkXkVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYKo5/e/4lx2M
        y1991DvEyMTBeIhRgoNZSYT391HDZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8bDO0koUE0hNL
        UrNTUwtSi2CyTBycUg1MbAYtyzTuSrjcStV8E6qwoTZxgQIrg+ez+zz+RUyGX4+cf2TMYaib
        IztV+nCZJjf7JqUbQarBRsfPzBW9syEje0WucZeSQ5GrRITEm9D7Yd6f/l6cwXdq4f3+NQ8r
        sjy3mnlPkkiWmVmmvEp3eUPN4wcPzxRbTX/v6/BMyciWI2n5x+Wnvgqe93l+pXlVO+sJpyvH
        Vpk/y/atyNfNLzK+lx3W2GOyc9d89tjpwXqnmLJXfX7ZcnLfBBM5xfe2BqK2u+Q17nC2ae9m
        WlUewV40e8sulXmhK20a5s2ru+QgruuR5pGzRuk2Ry3ndLuGz0dsX++/FZHvlv7r5mJVsRiz
        l5be0pYHXLW35E91TFNiKc5INNRiLipOBACQCfLapAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4XV1pK9Nkg5k3TCxW3+1ns/h99jyz
        xc0DO5ksTk9YxGSxcvVRJou9t7QtPi9tYXdg99i8Qsvj8tlSj903G9g8drbeZ/Xo27KK0ePz
        JrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9
        jB/n17AX3BCqWLtsC1sD4xn+LkZODgkBE4mLF3axdTFycQgJLGWU6H43nRUiISFxe2ETI4Qt
        LPHnWhdU0XNGiY6d14ESHBxsAloSjZ3sIDUiAooSGz+C1HNxMAusYZS4P/EtWLOwQJJE5+1W
        sCIWAVWJqzM6mUBsXgFLiffP/kItk5eYeek7WA2ngJVE67FvYL1CQDUPr/ayQNQLSpyc+QTM
        Zgaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbGtmM/t+xg
        XPnqo94hRiYOxkOMEhzMSiK8v48aJgvxpiRWVqUW5ccXleakFh9iNAW6eyKzlGhyPjA280ri
        Dc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamPaaC11OySt6PO/Gj3fn
        N0m9q3Xk8Q5fv6TJ2q/b2Ze1zel3yr9khS9bDpYm5KW5PWS633p70Q9/zUlbp11bqmoZtGJL
        d9/0J3d+6b/uujut3+ws39SatuzwfXyeDx+pfbzV8ax97Z3JPoJ99xQLEvRS+g7pqj7YuDPv
        vD/P1A4pY9HPU7Wb/NovWvqJrJhwSqI5uG9Rz99mfnYFdy+u57tnCk2fvXPikSnPD+5+wZHd
        f3CngkSw0/aLmyO3dMw74Ctyqdf/9/Kl89NWPjrWtbc9J3hqiPQjH84b9x310l6mXWpd/shV
        r2beR78jZw8J+Wr6eP+Se5H067uzufzH55pHV8tsq07OneF1e3HzqQQlluKMREMt5qLiRAB4
        WjfvFQMAAA==
X-CMS-MailID: 20220929062427eucas1p25a6efd73d6cdf8d481adb42f9d4006c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220929062427eucas1p25a6efd73d6cdf8d481adb42f9d4006c3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220929062427eucas1p25a6efd73d6cdf8d481adb42f9d4006c3
References: <20220929062425.91254-1-p.raghav@samsung.com>
        <CGME20220929062427eucas1p25a6efd73d6cdf8d481adb42f9d4006c3@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current implementation of blk_mq_plug() disables plugging for all
operations that involves a transfer to the device as we just check if
the last bit in op_is_write() function.

Modify blk_mq_plug() to disable plugging only for REQ_OP_WRITE and
REQ_OP_WRITE_ZEROS as they might require a zone lock.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-mq.h         | 3 ++-
 block/blk-zoned.c      | 9 +++------
 include/linux/blkdev.h | 9 +++++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8ca453ac243d..0b2870839cdd 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -312,7 +312,8 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 static inline struct blk_plug *blk_mq_plug( struct bio *bio)
 {
 	/* Zoned block device write operation case: do not plug the BIO */
-	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
 		return NULL;
 
 	/*
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a264621d4905..db829401d8d0 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -63,13 +63,10 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 	if (!rq->q->disk->seq_zones_wlock)
 		return false;
 
-	switch (req_op(rq)) {
-	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE:
+	if (bdev_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
 		return blk_rq_zone_is_seq(rq);
-	default:
-		return false;
-	}
+
+	return false;
 }
 EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8038c5fbde40..74bc30c680d6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1300,6 +1300,15 @@ static inline bool bdev_is_zoned(struct block_device *bdev)
 	return false;
 }
 
+static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
+					  blk_opf_t op)
+{
+	if (!bdev_is_zoned(bdev))
+		return false;
+
+	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
+}
+
 static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.25.1

