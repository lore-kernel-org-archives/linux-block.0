Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8885C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 11:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjEWLWy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 07:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEWLWx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 07:22:53 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB41FA
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 04:22:52 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230523112249epoutp04d26b8aa6cea11e178d5a37b32b420f0d~hwe9dcqrM1045310453epoutp04y
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 11:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230523112249epoutp04d26b8aa6cea11e178d5a37b32b420f0d~hwe9dcqrM1045310453epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684840969;
        bh=sL1sWiNcl5+dbIYqXrLl0dvDtnB3fcMJxT4A6ZzWO50=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iw/M5YgIAXUs1Es+ghMyEGiYB2iPLE+qKatoE/4huXzz8jIjYMeaLEJ47c3vK7rZv
         IGZkDiyZkgQOm8dpoa8DOtOPrFWkU4mOEjleVMaYvKxvc/OcCyWsHM+wILTn8X4yBG
         GrLfeOTc1TH/ZIQ/3aiapSvWvu5grIi3t/mbY5tc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230523112248epcas5p16088ed39dc063346d4053a5774d3051a~hwe82vqTt2006620066epcas5p1u;
        Tue, 23 May 2023 11:22:48 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QQX3p718Kz4x9Py; Tue, 23 May
        2023 11:22:46 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.05.16380.602AC646; Tue, 23 May 2023 20:22:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230523112014epcas5p267f30562f3f2e3c6d58fbb76c0084e5b~hwctU0W_Z1533515335epcas5p2K;
        Tue, 23 May 2023 11:20:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523112014epsmtrp26dd133f0ab7cc18bed8d35c6faac9f4a~hwctUH8Ip2813528135epsmtrp2M;
        Tue, 23 May 2023 11:20:14 +0000 (GMT)
X-AuditID: b6c32a4b-7dffd70000013ffc-b8-646ca2067c5c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.B1.27706.E61AC646; Tue, 23 May 2023 20:20:14 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523112013epsmtip1d16ddeccd0da295f03983ed19f7efa08~hwcsCJyTF3174831748epsmtip1G;
        Tue, 23 May 2023 11:20:13 +0000 (GMT)
From:   Anuj Gupta <anuj20.g@samsung.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, gost.dev@samsung.com,
        anuj1072538@gmail.com, joshiiitr@gmail.com,
        Anuj Gupta <anuj20.g@samsung.com>, stable@vger.kernel.org,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] block: fix bio-cache for passthru IO
Date:   Tue, 23 May 2023 16:47:09 +0530
Message-Id: <20230523111709.145676-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTS5dtUU6KwZQfphYfv/5msWia8JfZ
        YvXdfjaLmwd2MlmsXH2UyeLo/7dsFuffHmay2HtL22LBxkeMDpweO2fdZfe4fLbUY/fNBjaP
        vi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLx
        CdB1y8wBOkdJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5da
        YmVoYGBkClSYkJ3x6dkHloKNXBVft71jbmC8wNHFyMkhIWAicfX6a2YQW0hgN6PEgsksXYxc
        QPYnRol1+1czQTjfGCUedh5ngun4NmEPO0RiL6NE08tFUC2fGSXmvLjEAlLFJqAuceR5KyOI
        LSIgL/Hl9lqwOLPAcUaJtUvrQGxhAVOJA0fmgNWwCKhKLFi9G+wOXgEridYXjSwQ2+QlZl76
        zg4RF5Q4OfMJ1Bx5ieats5lBFksI3GKXeLXoMTNEg4vE+X932SBsYYlXx7ewQ9hSEp/f7YWK
        p0v8uPwU6p0CieZj+xghbHuJ1lP9QHM4gBZoSqzfpQ8RlpWYemodE8RePone30+gWnkldsyD
        sZUk2lfOgbIlJPaea4CyPSTWfDnLCAnfWInZ3a1sExjlZyF5ZxaSd2YhbF7AyLyKUTK1oDg3
        PbXYtMA4L7UcHrHJ+bmbGMGpUst7B+OjBx/0DjEycTAeYpTgYFYS4T1Rnp0ixJuSWFmVWpQf
        X1Sak1p8iNEUGMYTmaVEk/OByTqvJN7QxNLAxMzMzMTS2MxQSZxX3fZkspBAemJJanZqakFq
        EUwfEwenVAOThOi85NP8Er4Gni0XC53dbzTe85zk+0jsttoSmXQ3A9/3l44zhp8u45tyRe/N
        TKdlF5O2FYonHQ8WFYsJdP9Tmjqv0OjKxfw7TMe27Fk2pWqazhyzRLGPKyazcHuvrnY5et5W
        6lC9y/mI9wyL195LMyz1mqdm0KKSdd7LawWXtbfIzT3Ht+l+nnLwq4TFpzcFc/qTbxwyYUl1
        +HuGcVuz32099RezzJpKczflHOVtao16kFmuqBzb/C3+533326+rTux9YfVY2L2ovs/2xFvZ
        CYGhsfvf5Ldn3NNYNzdTwTL4/KfqLY6W6x6fOcL07+yRHH8jLwm9kPJ/Btw3b9l3ZdfNEovp
        XbQr+MjEfROUWIozEg21mIuKEwGuyz/oHgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSnG7ewpwUg0WXlS0+fv3NYtE04S+z
        xeq7/WwWNw/sZLJYufook8XR/2/ZLM6/PcxksfeWtsWCjY8YHTg9ds66y+5x+Wypx+6bDWwe
        fVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlfHp2QeWgo1cFV+3vWNuYLzA0cXIySEhYCLxbcIe
        9i5GLg4hgd2MEp0LNrJDJCQkTr1cxghhC0us/Pccqugjo8T3Y2vYQBJsAuoSR563ghWJCChK
        bPzYxAhSxCxwllHi1MWzYAlhAVOJA0fmgNksAqoSC1bvZgaxeQWsJFpfNLJAbJCXmHnpOztE
        XFDi5MwnYHFmoHjz1tnMExj5ZiFJzUKSWsDItIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85
        P3cTIzhwtTR3MG5f9UHvECMTB+MhRgkOZiUR3hPl2SlCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        eS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MC076r1E8uP0RJFPr8KOrTt6YdIrgX0NmrqbJ3rz
        nfz+LfjKUe33/D2X5sZcXLVNYeqvz5MTeXs/dRhO2is4oYTX4kvmeyc/pSTlTUL3l8741Vl7
        Q2hX37Tbeod8jxzcxfTJtUTwnjB7/rsF4Rbvs2e7Sf2dcXb2zon+otmBR0UvP05M6TpbcO7F
        Ef/dE5QMFbkWrbRznmxy+4NJ1hHx31wZsrzrepTt0pS2aecwnRT6uc2Yh4vjrJBNwu0Zl2W0
        tt49+CJ0BqcLq96MJaoPj7PsdYl7883r/qFnaybKbP0aYDV7zlTn75zGMjKnphWnRr25cfHU
        rsCQRKv0nBonY1kllnsXbXfb7SwNuTpDMSBUiaU4I9FQi7moOBEA+UmoJcsCAAA=
X-CMS-MailID: 20230523112014epcas5p267f30562f3f2e3c6d58fbb76c0084e5b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230523112014epcas5p267f30562f3f2e3c6d58fbb76c0084e5b
References: <CGME20230523112014epcas5p267f30562f3f2e3c6d58fbb76c0084e5b@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit <8af870aa5b847> ("block: enable bio caching use for passthru IO")
introduced bio-cache for passthru IO. In case when nr_vecs are greater
than BIO_INLINE_VECS, bio and bvecs are allocated from mempool (instead
of percpu cache) and REQ_ALLOC_CACHE is cleared. This causes the side
effect of not freeing bio/bvecs into mempool on completion.

This patch lets the passthru IO fallback to allocation using bio_kmalloc
when nr_vecs are greater than BIO_INLINE_VECS. The corresponding bio
is freed during call to blk_mq_map_bio_put during completion.

Cc: stable@vger.kernel.org # 6.1
fixes <8af870aa5b847> ("block: enable bio caching use for passthru IO")

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9137d16cecdc..9c03e641d32c 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -247,7 +247,7 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 {
 	struct bio *bio;
 
-	if (rq->cmd_flags & REQ_ALLOC_CACHE) {
+	if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <= BIO_INLINE_VECS)) {
 		bio = bio_alloc_bioset(NULL, nr_vecs, rq->cmd_flags, gfp_mask,
 					&fs_bio_set);
 		if (!bio)
-- 
2.34.1

