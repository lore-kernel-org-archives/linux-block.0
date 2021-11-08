Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865C3C4332F
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 15:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721C56120D
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 15:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhKHPPs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Nov 2021 10:15:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:12228 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbhKHPNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Nov 2021 10:13:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211108151031euoutp018b25c99a9573b4d41f202c070c840c81~1msnc0NO50988409884euoutp01e
        for <linux-block@vger.kernel.org>; Mon,  8 Nov 2021 15:10:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211108151031euoutp018b25c99a9573b4d41f202c070c840c81~1msnc0NO50988409884euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1636384231;
        bh=JfQftMPNSQ0nii0JnsaUG6Ori1dCx6yZ3qkFWx2SfFM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=e08QPkuoRc9oRH6DVkasNd56Hcz2YeuMBJ9BMoYJpB3sgnIbtR1hKmtqEqzE1a96Q
         TDkpn+jv6NXMiTNi3b6V9wcMyFO8cJaLdFRZtamZP9tGi2zF6+wKBuRm3Au5C8pmw9
         UUlkO/9eCh50IaRnu8EWMD21Zsh3UmdcyTc/8XpE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211108151031eucas1p19d18dc9223db3ff5f4974b0b9e17e4fe~1msnKEJiK1761717617eucas1p1u;
        Mon,  8 Nov 2021 15:10:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B7.F2.09887.7ED39816; Mon,  8
        Nov 2021 15:10:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211108151030eucas1p257602208c9a532f3d0e002d7a81b308b~1msmsT00u1342513425eucas1p22;
        Mon,  8 Nov 2021 15:10:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211108151030eusmtrp2eda5415ac7edc4e8d5e566081944a0e8~1msmrwLEM1701917019eusmtrp2_;
        Mon,  8 Nov 2021 15:10:30 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-cf-61893de77bf3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 84.D6.09404.6ED39816; Mon,  8
        Nov 2021 15:10:30 +0000 (GMT)
Received: from localhost (unknown [106.210.248.42]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211108151030eusmtip108f33d57af8b73a39e25b8cecc7a97ea~1msmOL4GQ1942019420eusmtip1Y;
        Mon,  8 Nov 2021 15:10:30 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2] block: Remove the redundant empty list check in
 blk_flush_plug
Date:   Mon,  8 Nov 2021 20:40:11 +0530
Message-Id: <20211108151011.256796-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7djPc7rPbTsTDVqvc1usvtvPZrH3lrbF
        56Ut7BZrbj5lcWDx2DnrLrvH5bOlHn1bVjF6fN4kF8ASxWWTkpqTWZZapG+XwJWxc+4VpoJW
        9oqG/qeMDYxfWLsYOTkkBEwk3i67xdbFyMUhJLCCUeLsmr0sEM4XRompm7cxQzifGSV+XFjH
        DNPy5P9yJojEckaJ4//2s0I4Lxgl7p65C1TFwcEmoCXR2MkO0iAioCDR83slG4jNLJAjselx
        L9ggYYEQib5zB8BqWARUJc68vgVm8wpYSax42QB1n7zEzEvfoeKCEidnPmGBmCMv0bx1Nth1
        EgI/2SVWH//FDtHgInH1VisbhC0s8er4Fqi4jMT/nfOZIOzJjBLHViVCNK9nlGjpXsAKcrSE
        gLVE35kcEJNZQFNi/S59iKijRM+mNAiTT+LGW0GIC/gkJm2bzgwR5pXoaBOCmK0ksfPnE6id
        EhKXm+awQNgeElfn7AZ7SkggVuLOkaOsExgVZiH5axaSv2YhnLCAkXkVo3hqaXFuemqxUV5q
        uV5xYm5xaV66XnJ+7iZGYOo4/e/4lx2My1991DvEyMTBeIhRgoNZSYT33tGORCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8In8aEoUE0hNLUrNTUwtSi2CyTBycUg1MK67zbNYWqhAR2/vXyeM7
        by6T7IOHMxTulrkfbL508tjhvex3XjOHWMzXsXnOcG7FqUNJKZlG4b+bG3LXm547qSRV1ndY
        9IUXy577FdlvubW3HKvlXz/bSJl7lb/zsTyzFV5X50/4vtpjjUf8JfPit5O5GR92rMitd/6d
        48HVLyK/ZdmPSw066j9eRwWnzgjvlPvCtIpl6yS30+9kQ04fzPIRn5+Xqt+m/+MTj9VUhmRJ
        4cOOXff7XOR5tzqv2nlMeneuOf+8YrcjX/I8TxV+/qU+93nEga28kznOXt5sJNnxg+PrpOBE
        ntXO/B/SL865V6G6at3v4stHpeLuzLUw3C2r//LOG31hE65aG63DSizFGYmGWsxFxYkA1kNC
        FIwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsVy+t/xu7rPbDsTDY5u4rNYfbefzWLvLW2L
        z0tb2C3W3HzK4sDisXPWXXaPy2dLPfq2rGL0+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j59wrTAWt7BUN/U8ZGxi/sHYxcnJICJhI
        PPm/nKmLkYtDSGApo0T7hOtMEAkJidsLmxghbGGJP9e62CCKnjFKnJ4+A6ibg4NNQEuisZMd
        pEZEQEGi5/dKNhCbWSBPYvGjy8wgJcICQRI3JgqChFkEVCXOvL4FVs4rYCWx4mUD1A3yEjMv
        fYeKC0qcnPmEBWKMvETz1tnMExj5ZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0L10vOT93
        EyMwaLcd+7llB+PKVx/1DjEycTAeYpTgYFYS4b13tCNRiDclsbIqtSg/vqg0J7X4EKMp0H0T
        maVEk/OBcZNXEm9oZmBqaGJmaWBqaWasJM7rWQDUJJCeWJKanZpakFoE08fEwSnVwDQ/7aL5
        GxehSuXrV9rvMl4pZptYMcfxu/qjYnP9i5oXimSU2jhkbV7lyqXuXfx455fSzafyNjf/Pqh+
        MNzTkHu3w42IQ9Us3+R2z41J37YikIl9C0NVS3HXlmev1VK6PxV/9T2y9J/2RWGlL94+PxRu
        3sv3ua/hItEZoj8/z2vChjnbjrg+FZofPWXfjjcXFXTc3QIUl7X89w6aMOnnxKQjMQYn8rc4
        xs7sfiN9UVbfZraAWZb1e4NklvmtShXq6TwPfienLNRhtZsTulny4Wu5Nao6NqlWGq0H2Jtn
        JxnWdv19c53rY+Qk+2Vrap6elrh3c/mvjvqs922fT18+3G4YwRWc97FvukjkpXuRwkosxRmJ
        hlrMRcWJAKFsKFbjAgAA
X-CMS-MailID: 20211108151030eucas1p257602208c9a532f3d0e002d7a81b308b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211108151030eucas1p257602208c9a532f3d0e002d7a81b308b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211108151030eucas1p257602208c9a532f3d0e002d7a81b308b
References: <CGME20211108151030eucas1p257602208c9a532f3d0e002d7a81b308b@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The callee: blk_mq_flush_plug_list already has an empty list check for
plug->mq_list. Remove the check for empty list from the
caller:blk_flush_plug.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b043de2baaac..a309e7cca218 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1588,8 +1588,8 @@ void blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 {
 	if (!list_empty(&plug->cb_list))
 		flush_plug_callbacks(plug, from_schedule);
-	if (!rq_list_empty(plug->mq_list))
-		blk_mq_flush_plug_list(plug, from_schedule);
+
+	blk_mq_flush_plug_list(plug, from_schedule);
 	/*
 	 * Unconditionally flush out cached requests, even if the unplug
 	 * event came from schedule. Since we know hold references to the
-- 
2.25.1

