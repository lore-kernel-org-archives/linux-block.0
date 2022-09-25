Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6DDC54EE9
	for <linux-block@archiver.kernel.org>; Sun, 25 Sep 2022 18:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiIYSx5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Sep 2022 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiIYSx5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Sep 2022 14:53:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292E82E9F0
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 11:53:56 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220925185353euoutp01db061cc0891b297468115088620c0aef~YL0Rm_79e0714507145euoutp01E
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 18:53:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220925185353euoutp01db061cc0891b297468115088620c0aef~YL0Rm_79e0714507145euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664132033;
        bh=Ue10Z1qFDMnoAD/RWgDr2Sr/jCLAYc+JS8fwi1z9b6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4y5fGBPZTdgZekSutV6k8j6Uon4oIyNz+HXaRIEe9QLvW7yK2YG79bkaJB8SIofJ
         7/hLt9Phb/o/gd6TkhO9mGsLvDaq/EGE5mnorikT0tSJpZpdjuD564M3bh9AH1dvO0
         uGMRcz3+g9N4yrl8S1yckkMTHmUER4pZUr6OwklI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220925185352eucas1p231eb5e413d4aec0f0c0469e92cc7aa8f~YL0Q0vXOD3009130091eucas1p2R;
        Sun, 25 Sep 2022 18:53:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B2.50.07817.0C3A0336; Sun, 25
        Sep 2022 19:53:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220925185351eucas1p1e0c37396c09611509c0b18bdcdeddfe1~YL0P4Kr721286912869eucas1p1l;
        Sun, 25 Sep 2022 18:53:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220925185351eusmtrp24822ab53a906ce7561abe83bf2c6b254~YL0P3ojRp1617516175eusmtrp2R;
        Sun, 25 Sep 2022 18:53:51 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-02-6330a3c0ff6d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B4.37.10862.FB3A0336; Sun, 25
        Sep 2022 19:53:51 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220925185350eusmtip2d1db84efc16027aff16bbd09ed6d3607~YL0Pj0Ygv2337223372eusmtip2K;
        Sun, 25 Sep 2022 18:53:50 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     damien.lemoal@opensource.wdc.com, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 2/2] block: use blk_mq_plug() in blk_execute_rq_nowait()
Date:   Sun, 25 Sep 2022 20:53:47 +0200
Message-Id: <20220925185348.120964-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220925185348.120964-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djP87oHFhskG+z9yWex+m4/m8Xvs+eZ
        LW4e2MlksfeWtsXnpS3sDqwel8+Weuxsvc/q0bdlFaPH501yASxRXDYpqTmZZalF+nYJXBmX
        Lu9kK1jIUTFt2n+mBsb/bF2MnBwSAiYS+19uYepi5OIQEljBKLFn9woo5wujxKIJJ6Ccz4wS
        b9fdZ4Zp+fT/HFRiOaPE/qmLWSGcl4wSx/5NAari4GAT0JJo7GQHaRARMJBYta4DbB+zQJLE
        l78rwQYJC3hI/F3xGcxmEVCVmPn/IQuIzStgJXF+2mNWiGXyEjMvfWcHGckpYC3Rft0GokRQ
        4uTMJywQI+UlmrfOZgY5QUJgKYfE7kM32UDqJQRcJB7M0IMYIyzx6vgWdghbRuL/zvlMEHa1
        xNMbv6F6Wxgl+neuh+q1lug7kwNiMgtoSqzfpQ9R7ijx6+QfdogKPokbbwUhLuCTmLRtOjNE
        mFeio00IolpJYufPJ1BLJSQuN81hgbA9JCYc+sU2gVFxFpJfZiH5ZRbC3gWMzKsYxVNLi3PT
        U4uN8lLL9YoTc4tL89L1kvNzNzECU8jpf8e/7GBc/uqj3iFGJg7GQ4wSHMxKIrwpF3WThXhT
        EiurUovy44tKc1KLDzFKc7AoifOyzdBKFhJITyxJzU5NLUgtgskycXBKNTDJ86przo5ULkgR
        2v21PiIj8VmKZo70ym8rA4svTXmv6GRs5mtuHfOdbdcmZ031xROW3Z7b2/xr6oujm3x8NH6z
        PZOQl9HVYv9oX16r2xe+0OvpI+uKMCldhdSzstejLmgq6/JG6J26xPC/ruHZXI2IoKXWhjtW
        7c+yOTnpm+879105Ab+D7lz9um3Pua70L+yNVknfz/EJ3EhOjHTfKB6Zd+6V4cXGlqvuS8QU
        c2sZAlh5a61aVum6Zd6/q1sSsTQ0+/SsPKbs8l+RE88vYxd/aF7F1MStFL1lxbI3jj7eGYs/
        tU9NXXwqmilCfzP3/Du7L7wo319jyiTSM3m56c0Vnf6HFZb/eK3Yav+mTYmlOCPRUIu5qDgR
        AG+Yym6QAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xe7r7FxskG+yby2Ox+m4/m8Xvs+eZ
        LW4e2MlksfeWtsXnpS3sDqwel8+Weuxsvc/q0bdlFaPH501yASxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmXLu9kK1jIUTFt2n+mBsb/bF2M
        nBwSAiYSn/6fY+pi5OIQEljKKPF5dQMTREJC4vbCJkYIW1jiz7UuNoii54wS7zo2sHQxcnCw
        CWhJNHayg9SICBhJ/F57jRXEZhZIkVj75jDYHGEBD4m/Kz4zg9gsAqoSM/8/ZAGxeQWsJM5P
        e8wKMV9eYual7+wgIzkFrCXar9uAhIWASrZduM4IUS4ocXLmExaI8fISzVtnM09gFJiFJDUL
        SWoBI9MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwHDfduznlh2MK1991DvEyMTBeIhRgoNZ
        SYQ35aJushBvSmJlVWpRfnxRaU5q8SFGU6CzJzJLiSbnAyMuryTe0MzA1NDEzNLA1NLMWEmc
        17OgI1FIID2xJDU7NbUgtQimj4mDU6qBSVJ19caS73eEBL0/rr4f+/nEdck9ie7HeCut34e6
        urxomhvcevbGufgQub33yn4HSqd5K8i17Sh68tbTfckk25Lft27l50zYs9mFj3vHzsQXto4S
        oS7MN57vvqmXNkO25vcBhssvCg6HGa4NcX7qdDMupnHNRidBpw1rvPS27OKwqHeftl07X1Yn
        +df53ZdmS3H8YdDwPDDrqcabtObmozEL8tNOPmy5kJHBy3x47dRvb1c/EZF88Wzm7FyPiO0K
        r692PRXUMzpW7CBTUv9V1uEwx16z7TEvt73+p3crecmZcxP2ppkd+dG0MWa9Zu2ByodcK+4V
        B7G8M9su8lF6RvXthJVb1PL2uzEcZfqy7JkSS3FGoqEWc1FxIgBsvL5bAAMAAA==
X-CMS-MailID: 20220925185351eucas1p1e0c37396c09611509c0b18bdcdeddfe1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220925185351eucas1p1e0c37396c09611509c0b18bdcdeddfe1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220925185351eucas1p1e0c37396c09611509c0b18bdcdeddfe1
References: <20220925185348.120964-1-p.raghav@samsung.com>
        <CGME20220925185351eucas1p1e0c37396c09611509c0b18bdcdeddfe1@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_execute_rq_nowait() function mainly was used by low-level drivers
such as NVMe to submit one-off passthrough requests. However, recently
introduced uring-cmd based io-passthrough also uses the same function to
submit io requests.

As the plugging support is coming to io-passthrough[1], use the
blk_mq_plug() helper to ensure plugging is not used in all scenarios.

[1]
https://lore.kernel.org/linux-block/20220922182805.96173-1-axboe@kernel.dk/

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d66163..840541c1ab40 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1213,7 +1213,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 	WARN_ON(!blk_rq_is_passthrough(rq));
 
 	blk_account_io_start(rq);
-	if (current->plug)
+	if (blk_mq_plug(rq->bio))
 		blk_add_rq_to_plug(current->plug, rq);
 	else
 		blk_mq_sched_insert_request(rq, at_head, true, false);
-- 
2.25.1

