Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A41BC04A95
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 07:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiI2Hry (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 03:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiI2Hrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 03:47:53 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487F213940E
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 00:47:52 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220929074750euoutp02e078e797210148e481bb8b5870013e28~ZRT4MBNnL0229902299euoutp02p
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 07:47:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220929074750euoutp02e078e797210148e481bb8b5870013e28~ZRT4MBNnL0229902299euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664437670;
        bh=pZy4r7iqahFnpHPjfTyCoAjWDosoGm53ntzBPmPZ8tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2MxQuSM1UjtVP6YLM0c8dY+rnGVrFlB0x828h/aJb48m5RKfUX1ydTwTL9EO8lSN
         b3RbQml5SQwg2hELBZdIhzG4wwUhH8uCkBIp5zg46EIBsvlg4UEa3KDKNPje/aB6CO
         xn3E2cb+gB8khsP3cgbHijxUBGhaNivoZyAHoWR8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220929074748eucas1p13d26244319a6712fba0a351cad4adbe1~ZRT2xxyTw0530905309eucas1p1E;
        Thu, 29 Sep 2022 07:47:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.88.29727.4AD45336; Thu, 29
        Sep 2022 08:47:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220929074748eucas1p1145790d433b4f57cc9e9238df480091b~ZRT2VEmMa2537025370eucas1p17;
        Thu, 29 Sep 2022 07:47:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220929074748eusmtrp13f39090b305e1b84278746fbbe16ad72~ZRT2UQdNt2626326263eusmtrp1g;
        Thu, 29 Sep 2022 07:47:48 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-30-63354da474ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.C5.10862.3AD45336; Thu, 29
        Sep 2022 08:47:48 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220929074747eusmtip1bcd50b4ea3e9782fab825f111099c12a~ZRT2EkmDP2988729887eusmtip1W;
        Thu, 29 Sep 2022 07:47:47 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     gost.dev@samsung.com, linux-block@vger.kernel.org,
        damien.lemoal@opensource.wdc.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 1/2] block: adapt blk_mq_plug() to not plug for writes
 that require a zone lock
Date:   Thu, 29 Sep 2022 09:47:44 +0200
Message-Id: <20220929074745.103073-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929074745.103073-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOd0lvqbJBtefylusvtvPZvH77Hlm
        i5sHdjJZrFx9lMli7y1ti89LW9gd2Dwuny312H2zgc1jZ+t9Vo++LasYPT5vkgtgjeKySUnN
        ySxLLdK3S+DKOP/3D2vBP6GKtsdvGBsY3/J3MXJySAiYSHS2z2XqYuTiEBJYwShxavJ9dgjn
        C6NE77U1UJnPjBILb2xggmnpvn+KFSKxnFHi794dUM5LRomdv/4DVXFwsAloSTR2soM0iAjI
        S3y5vZYFxGYWqJdovvATLC4skCKx+dJzMJtFQFWif94PMJtXwEri1toV7BDL5CVmXvoOZnMK
        WEus+vCPFaJGUOLkzCdQM+UlmrfOZga5QUJgJYfEs+tv2SCaXSRm7ZgNdbWwxKvjW6CGykic
        ntzDAmFXSzy98RuquYVRon/nejaQBySAtvWdyQExmQU0Jdbv0ocod5TYdq2PEaKCT+LGW0GI
        E/gkJm2bzgwR5pXoaBOCqFaS2PnzCdRSCYnLTXOglnpInFqyn3kCo+IsJM/MQvLMLIS9CxiZ
        VzGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgSmltP/jn/awTj31Ue9Q4xMHIyHGCU4mJVE
        eH8fNUwW4k1JrKxKLcqPLyrNSS0+xCjNwaIkzss2QytZSCA9sSQ1OzW1ILUIJsvEwSnVwOSe
        v/BAbUpW1dtk2afTuIq+LfTNn/v9U9PKih3ibv7vtfluvy0VePkrVe1KHfPDGaf/+ZcmtByb
        /eyD/mzzacKC8+6br3N0VE4IZVv8/eO/HzdfG7upfmxSY1hhYndyxRPv0Jj4t/l/Mmy9+/cd
        WRZmcj6lRPe7VsCSPpUPdv4Gs+LdIgNSThw5d6cpuz/JPPHxi+rYtMTovYl3NN4FPHD6mfXe
        LnuTkl7XprRp3/xkHVcL6vJNyFf9q5I3PzDr1MwX8x546b5w3+T/zn9NJZtPAs8Bd77eIItK
        lQix/6zV1xi9omSCbfrjGX7k3rGeePTiIqfmf76XHk1aZvwsaNtmvc4ZkiV5stX3bqQnKLEU
        ZyQaajEXFScCAKGj/aycAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsVy+t/xu7pLfE2TDY5lWKy+289m8fvseWaL
        mwd2MlmsXH2UyWLvLW2Lz0tb2B3YPC6fLfXYfbOBzWNn631Wj74tqxg9Pm+SC2CN0rMpyi8t
        SVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Ms4//cPa8E/oYq2
        x28YGxjf8ncxcnJICJhIdN8/xdrFyMUhJLCUUWLHtddMEAkJidsLmxghbGGJP9e62CCKnjNK
        rPj1H6iDg4NNQEuisZMdpEZEQFFi40eIemaBZkaJ5/MqQGxhgSSJhsPPWUFsFgFVif55P8Dq
        eQWsJG6tXcEOMV9eYual72A2p4C1xKoP/8DqhYBq1t7axgxRLyhxcuYTFoj58hLNW2czT2AU
        mIUkNQtJagEj0ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAGNh27OeWHYwrX33UO8TIxMF4
        iFGCg1lJhPf3UcNkId6UxMqq1KL8+KLSnNTiQ4ymQHdPZJYSTc4HRmFeSbyhmYGpoYmZpYGp
        pZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOT6c1/DVPlYxietQRdq7Axtpy0pnPalI+3
        Sx9eXsOWceVuwhtXpvxrFwXddjL5++Ue6Fp8Y6a00569IYoCTn9eSX6P9VjVfv6uedBJkWWr
        GE7Gz+oyTFre/fcBt133X5t7G9vqTm410FBOzm5X4z8071Pleekfly+5Trvoc1iXtTP5mXh3
        FPvTGdcTQzeUlgY71jfs7FD7OOvPwQyxXRJ3q1oLyo7XehtuTHwsMn1J6ZvJLnrffD89zhMR
        On485uGlkJk2uv/19posZKv/H84rfTp39+fHq08HLlxyf/c3hrps2TYfxWndGxh2csYISWdI
        Tje/ujgs8UiFj5Dsgr1Ly5jkXfYI1iUqK/zYvvGiEktxRqKhFnNRcSIA5xcQ2QoDAAA=
X-CMS-MailID: 20220929074748eucas1p1145790d433b4f57cc9e9238df480091b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220929074748eucas1p1145790d433b4f57cc9e9238df480091b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220929074748eucas1p1145790d433b4f57cc9e9238df480091b
References: <20220929074745.103073-1-p.raghav@samsung.com>
        <CGME20220929074748eucas1p1145790d433b4f57cc9e9238df480091b@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current implementation of blk_mq_plug() disables plugging for all
operations that involves a transfer to the device as we just check if
the last bit in op_is_write() function.

Modify blk_mq_plug() to disable plugging only for REQ_OP_WRITE and
REQ_OP_WRITE_ZEROS as they might require a zone lock.

Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

