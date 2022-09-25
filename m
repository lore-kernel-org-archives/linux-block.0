Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C11CC6FA82
	for <linux-block@archiver.kernel.org>; Sun, 25 Sep 2022 18:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiIYSx5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Sep 2022 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiIYSxz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Sep 2022 14:53:55 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C812AF6
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 11:53:53 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220925185352euoutp02affca627b04d407dd359324d0f26f222~YL0RJ1mta2348323483euoutp02F
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 18:53:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220925185352euoutp02affca627b04d407dd359324d0f26f222~YL0RJ1mta2348323483euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664132032;
        bh=9Vp3pv5yyz+4l10DcE3fo6lgTfafWIbWfxxlr2bc/YU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oi91aago0HE7tuUyM/FDNvr6R/hx2HgUzAoG2L40kFJbkB8fKhZG1660sM/sFHTkn
         xWZFY5Fr13DuFBoUknwocboem1Bc9EQ7JB+3pyoXQcPgcmps+78BmjleL17aMu+9pI
         Cdn32PmJluewjlM2WR4SO/I3r+ZlRUNxLsMmCiz4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220925185350eucas1p21ec04b807565b3b1f126e1ea9339d261~YL0PfYNpm2813128131eucas1p2h;
        Sun, 25 Sep 2022 18:53:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 27.D8.19378.EB3A0336; Sun, 25
        Sep 2022 19:53:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef~YL0O5KWKW1290012900eucas1p1_;
        Sun, 25 Sep 2022 18:53:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220925185350eusmtrp12884db8ebdefc0af464b1814ceb081f1~YL0O4mOy50942709427eusmtrp1K;
        Sun, 25 Sep 2022 18:53:50 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-3a-6330a3beca14
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.00.07473.EB3A0336; Sun, 25
        Sep 2022 19:53:50 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220925185349eusmtip1b72890b26b59c83bc5a654832ea28c16~YL0OmbSHH0145001450eusmtip10;
        Sun, 25 Sep 2022 18:53:49 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     damien.lemoal@opensource.wdc.com, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Date:   Sun, 25 Sep 2022 20:53:46 +0200
Message-Id: <20220925185348.120964-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220925185348.120964-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djP87r7FhskGzxaZ2Cx+m4/m8Xvs+eZ
        LW4e2MlksfeWtsXnpS3sDqwel8+Weuxsvc/q0bdlFaPH501yASxRXDYpqTmZZalF+nYJXBnL
        fsxmLmjnrlixbilrA+MXji5GTg4JAROJFU1NzF2MXBxCAisYJfbcamSFcL4wSnw7dYERwvnM
        KNF74BwrTMvPb5vZIRLLGSWe/VjDAuG8ZJS4f/0PWxcjBwebgJZEYyc7SIOIgIHEqnUdbCA2
        s0CSxJe/K5lBbGGBOImJ+1aC1bAIqEp8vLIErIZXwEpiVeNfJohl8hIzL31nBxnJKWAt0X7d
        BqJEUOLkzCcsECPlJZq3zmaGKF/IITHjNj+E7SLx7vIJdghbWOLV8S1QtozE6ck9LBB2tcTT
        G7/B3pcQaGGU6N+5Hux8CaBdfWdyQExmAU2J9bv0IcodJc78W8AMUcEnceOtIMQFfBKTtk2H
        CvNKdLQJQVQrSez8+QRqqYTE5aY5UEs9JL4u+8s8gVFxFpJfZiH5ZRbC3gWMzKsYxVNLi3PT
        U4uN81LL9YoTc4tL89L1kvNzNzECU8jpf8e/7mBc8eqj3iFGJg7GQ4wSHMxKIrwpF3WThXhT
        EiurUovy44tKc1KLDzFKc7AoifOyzdBKFhJITyxJzU5NLUgtgskycXBKNTB1LBW+yrhmccE2
        5sJrO9VaPNTqYjfvzvhtF2Ju75L1IWe+VdqSg08kewQkTievNGYTzTlu08HX/vEm06d1Sj+z
        HcrtHt7PeDUxO3+jrn1q8vIDHw0nrcvevb1Z2mvidLH1+7isc90TDzVr1h34wGy0lFvx+cdy
        Jp/8865/bwceKZMJbqv5MqFmnZxq8sLWzilTPRtDr2l+1t0Wa3HivVJT+zPZGJX1Nk+zg4oc
        WI99fC+au71cRrxUopn17fc5RWuXCMgIhKjeVGqf+1x2Puvyo38ZBKWiZnbfW+6s+Ltpfb05
        j4LV0jDNice7uI02T1B8HLhFo7yz+OYVfTsblh5hkaKjex0zVj4P1D4brcRSnJFoqMVcVJwI
        AMGe/4yQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xu7r7FhskG6w4xmWx+m4/m8Xvs+eZ
        LW4e2MlksfeWtsXnpS3sDqwel8+Weuxsvc/q0bdlFaPH501yASxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnLfsxmLmjnrlixbilrA+MXji5G
        Tg4JAROJn982s3cxcnEICSxllDh+9AwrREJC4vbCJkYIW1jiz7UuNoii54wSq44sBUpwcLAJ
        aEk0drKD1IgIGEn8XnsNrJdZIEVi7ZvDTCC2sECMxOHtc9hAbBYBVYmPV5aA2bwCVhKrGv8y
        QcyXl5h56Ts7yEhOAWuJ9us2IGEhoJJtF64zQpQLSpyc+YQFYry8RPPW2cwTGAVmIUnNQpJa
        wMi0ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzDctx37uXkH47xXH/UOMTJxMB5ilOBgVhLh
        TbmomyzEm5JYWZValB9fVJqTWnyI0RTo7InMUqLJ+cCIyyuJNzQzMDU0MbM0MLU0M1YS5/Us
        6EgUEkhPLEnNTk0tSC2C6WPi4JRqYLIW1DdiFgqW3xCce19d8PL8lY83f7o0a93setvm4py3
        Cj13q3J1F22YwsHeM9m9br3O8+TWsvQpk+Yu3zT140PJEPOCEKOeCfzn/RcWzNs9KdnSJC7g
        xKrWlHKVQ5PVKjdMq4s//dvh90y77tpF3ZNnZahPvvlp6orDDD1GntkHNyw+JbV64xGzTbrS
        Mj638n0Xn7Guu2OukhCadjrTwU/yzZ/Ywp3Npc6N7Iv2x62PdWG2P1Kz9Od7jjuG4hvqZOTZ
        s7+uuN5h5f/HXS+ta0Hgso+mq649Y7zOKWs079MlDTWpqrbJF8XfP9hW3cevt2j3qvzF+vaT
        d+w7PYen8L3y42d9nNYnTVQ33Q1jS1FiKc5INNRiLipOBAD8Am/nAAMAAA==
X-CMS-MailID: 20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef
References: <20220925185348.120964-1-p.raghav@samsung.com>
        <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Modify blk_mq_plug() to allow plugging only for read operations in zoned
block devices as there are alternative IO paths in the linux block
layer which can end up doing a write via driver private requests in
sequential write zones.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-mq.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8ca453ac243d..005343df64ca 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -305,14 +305,15 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
  * change can cause write BIO failures with zoned block devices as these
  * require sequential write patterns to zones. Prevent this from happening by
  * ignoring the plug state of a BIO issuing context if it is for a zoned block
- * device and the BIO to plug is a write operation.
+ * device and the BIO to plug is not a read operation.
+ *
  *
  * Return current->plug if the bio can be plugged and NULL otherwise
  */
 static inline struct blk_plug *blk_mq_plug( struct bio *bio)
 {
-	/* Zoned block device write operation case: do not plug the BIO */
-	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
+	/* Allow plugging only for read operations in zoned block devices */
+	if (bdev_is_zoned(bio->bi_bdev) && bio_op(bio) != REQ_OP_READ)
 		return NULL;
 
 	/*
-- 
2.25.1

