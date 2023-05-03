Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8AEC7EE22
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 10:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjECKQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjECKQV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 06:16:21 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D14749E4
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 03:16:15 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230503101612epoutp01f5891d0a6a16fd1844c95cab855b8930~bmrFx7Rb32321123211epoutp01F
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 10:16:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230503101612epoutp01f5891d0a6a16fd1844c95cab855b8930~bmrFx7Rb32321123211epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683108972;
        bh=dsClYh4QK7KsYkk+2+MP7q9EBU8OpMqvWeVl/PtqLS8=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=YeGXTCaqh/tFo7vqlLQJjqwH3JvYRDv5alKJu+0jsrOP7xan87j/1IDxsGPjQzeKG
         5u0VMJGChzEnE64xF/TNjaiBgQ81YiF/h6whbg+MT7usJddlPowvh5hEb5+a5DygfB
         tifqjP/h1eOQsjUHF9uvsUd1S5Df/cSpwnK5lZX8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230503101612epcas2p117ba29f6e7f6f3ec8f6119f8fa637983~bmrFh2yCv3199031990epcas2p1S;
        Wed,  3 May 2023 10:16:12 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QBCXC4cVVz4x9Pv; Wed,  3 May
        2023 10:16:11 +0000 (GMT)
X-AuditID: b6c32a46-b23fd7000001438d-a7-6452346b8ec5
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.16.17293.B6432546; Wed,  3 May 2023 19:16:11 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 08/15] block: add helper function to get the number of
 integrity segments
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230503101611epcms2p57098b1a64ba519b0e2d3cd132d96051a@epcms2p5>
Date:   Wed, 03 May 2023 19:16:11 +0900
X-CMS-MailID: 20230503101611epcms2p57098b1a64ba519b0e2d3cd132d96051a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmmW62SVCKwYJ+eYvVd/vZLF4e0rRY
        ufook0Vv/1Y2i723tC0u75rDZrH8+D8mB3aPy2dLPXbfbGDz+Pj0FotH35ZVjB6fN8kFsEZl
        22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA3aCkUJaY
        UwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM6Y
        /OYSY8F7roop138xNzB2cXYxcnBICJhI3Dru08XIxSEksINR4sSscywgcV4BQYm/O4RBTGGB
        aInJ5327GDmBSpQkzq2ZxQgRNpC41WsOEmYT0JP4uWQGG4gtIrCaSaL5eQ2ILSHAKzGj/SkL
        hC0tsX35VkYQm1PAT+LxhluMEHENiR/LepkhbFGJm6vfssPY74/Nh6oRkWi9dxaqRlDiwc/d
        UHFJiUOHvrJBPJIvseFAIES4RuLt8gNQJfoS1zo2gp3AK+ArMXXfebAzWQRUJZpmbIVa5SKx
        9sZ2JhCbWUBeYvvbOcwgI5kFNCXW79KHmK4sceQWC0QFn0TH4b/sMA82bPyNlb1j3hMmiFY1
        iUVNRhBhGYmvh+ezT2BUmoUI41lI1s5CWLuAkXkVo1hqQXFuemqxUYERPFaT83M3MYLToZbb
        DsYpbz/oHWJk4mA8xCjBwawkwvuh0C9FiDclsbIqtSg/vqg0J7X4EKMp0MMTmaVEk/OBCTmv
        JN7QxNLAxMzM0NzI1MBcSZxX2vZkspBAemJJanZqakFqEUwfEwenVAOT0LSborkaqR+2yH8M
        kJzhKLNS+++ZGU3Vl1xWfCkO4mEvOXDysl/W3vkJL9p/fztTVLd82Qsr1ssiDJY3liwM+3qJ
        bUVxpIWBzrF/kw9PN19gqGJpudH2+nTNvo37Xvws1RJe7H7owYnvVn68ofeCHid3T7YX/+T4
        yGbRUuEFQQXa7xc1CjAes1x29v+/iepXyv7E7P5nYZ96cY/87es5ZzUW7ZumKvnvmJNXSgnP
        f9PVTTtCD34x17X+0lAjzmi546Mh559L/Bwnzu18XLj6YohQ69kXOVc2ci3PalHm3iu4NGpJ
        XojS6rP+iyf69N1xOzfxUueGhubeiZrRUz79dUy/t2fCuznT10wsujahaqESS3FGoqEWc1Fx
        IgCslwboEAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p5>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since request always has the number of integrity segments in the process
of generating and merging, a function for simply obtained this has been
added.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 include/linux/blk-integrity.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 378b2459efe2..45b9fde1fee1 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -43,6 +43,11 @@ int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
 				   struct scatterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 
+static inline unsigned short blk_rq_nr_integrity_segments(struct request *rq)
+{
+	return rq->nr_integrity_segments;
+}
+
 static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
 {
 	struct blk_integrity *bi = &disk->queue->integrity;
@@ -120,6 +125,10 @@ static inline int blk_rq_count_integrity_sg(struct request_queue *q,
 {
 	return 0;
 }
+static inline unsigned short blk_rq_nr_integrity_segments(struct request *rq)
+{
+	return 0;
+}
 static inline int blk_rq_map_integrity_sg(struct request_queue *q,
 					  struct bio *b,
 					  struct scatterlist *s)
-- 
2.34.1
