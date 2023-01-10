Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA07BC63797
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 14:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjAJOgr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 09:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbjAJOgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 09:36:45 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7744D431AB
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 06:36:42 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230110143639euoutp027b84c3687c727964000d6a5f8c389ae9~4_VOZCsfH0464004640euoutp02Q
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 14:36:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230110143639euoutp027b84c3687c727964000d6a5f8c389ae9~4_VOZCsfH0464004640euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673361399;
        bh=SHvT0Iim03zZBGBqzNi6q7H4Efd4JG0NRYcOMqYqopo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtbvNMUWx48FA3wzuBC/BXlVL9UhX2uZs/vLVVwGMFthhqvNzE3f5PEZrV1FLZP7G
         pH2thY4TrA0f3irfyMTUDRC9elmOKG0lcT1eKg/oSjwKJhlCabUGqTu+lLeqWX5868
         VhHjQLxYCAXcJf1D6gRZXr+MmcxlN1D74EHcJoe0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230110143638eucas1p263a3c1dfaa18b20444ab7589f281a81d~4_VNpIFwt0231602316eucas1p2k;
        Tue, 10 Jan 2023 14:36:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B6.A6.56180.6F77DB36; Tue, 10
        Jan 2023 14:36:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230110143637eucas1p1fa9ab24ea73f524dd3dcb11c10b5c11a~4_VNW5oXN2955929559eucas1p1s;
        Tue, 10 Jan 2023 14:36:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230110143637eusmtrp2099788fad2206056ff1a357ffc00c48c~4_VNV4q4T0701607016eusmtrp2V;
        Tue, 10 Jan 2023 14:36:37 +0000 (GMT)
X-AuditID: cbfec7f2-ab5ff7000000db74-07-63bd77f6d085
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 63.1C.23420.5F77DB36; Tue, 10
        Jan 2023 14:36:37 +0000 (GMT)
Received: from localhost (unknown [106.210.248.241]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230110143637eusmtip27e188158996471fbce28fafe158dc88f~4_VNKnuAw3006630066eusmtip2i;
        Tue, 10 Jan 2023 14:36:37 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com, snitzer@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/3] block: remove superfluous check for request queue in
 bdev_is_zoned()
Date:   Tue, 10 Jan 2023 15:36:33 +0100
Message-Id: <20230110143635.77300-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110143635.77300-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtd+8276ar253kh0aj9aKHTinh2rtIuFlBJPSwsNa6aLWt2DLL
        iFY+18NHoTkzl5Ll1kOcD1z5ykiLWi9rppCZbZBCZpnVECu3u6j/zvl95/udc+AjcKqeH0zs
        1RxitRqFSiYQ8era3M9Cvyc3KsNb0gj6xtscAV0w5MbpUfsznO5qsWG0+cYDjB473YPRrtdF
        GN3YPZ82XXP50cPlaX70w+6Qlf5Mx6t1TIc9ibFaDAKm+uoJ5m6XXsCcSx0UMLb0d3wmu8aC
        mGHrNCaz5Qy2URQnWrqHVe09zGrly3eJEn+P6AUHXcSRkpFkPWrzO42EBJCLwJmTP45FBEVW
        IPja8B7nyDcEvW0WxJFhBCUt5/h/VxzWXp/qOgJDhVHAkX4E6f0j44QgBOQ8OGnwegSSEmjO
        Sud5NDhZicGHzjO4ZyAh4+GeyYl5MI+cBXk1Ri8Wk1FwPSML59ykYHz5w/uRkFwMz/NGEaeZ
        DI+MTp4H4+Oa1NpL3kRADhEwOlbsi7oGfr4y8jgsgYH2Gl/rqfDbZsI4fAxcb0Z9y2kIcmyV
        3gZALoHsJyoPxMm5UHlHzslXwad+p08xEd58msxFmAjn6y7i3LMYsjIoTi0Dm9vpMwXoOFXs
        C8NAZfmYXy6aXvRfmaL/yhT9872CcAsKYpN06gRWF6Fhk8N0CrUuSZMQpjygtqLx43r8q/1r
        Pbo88CWsFWEEakVA4LJAsVnYoKTEexRHU1jtgZ3aJBWra0UhBE8WJC6sNSkpMkFxiN3PsgdZ
        7d8pRgiD9RgdorSU4ds1FnfAk41bC2bbNeU/H2663x7g+NDgEMfIC/dFr2KqYqXV26XALBkq
        M/fFOdJmqj/mYbc08gaqPWjSgmXsHLxL/aWuvMNxsy/MSaVHPWXyqweloZv5u+cP58YYrNtS
        AiPlnbFdKcKnJRdi8KEtjcLjhIqJXhHlnxs+0Lxw9ZrS6mJ1/Fa56xraGTc4Z0a8vyLavfms
        CasvrQhoOpZYdaJnLaWfe6vO/2ZiVcSMZkI0xZBZdmrZggkFkWOf7bnHXydkSsJr74bKFEt5
        0Tt65JmO9/LbyavVJ/m/NphnRVKpTfESS7BR2tfb/+Lz+oxOe2G20Cxp6g6X8XSJioh5uFan
        +APlsj4OywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7pfy/cmGyzYYWSx+m4/m8W0Dz+Z
        LX6fPc9scfPATiaLlauPMln87brHZPH06iwmi723tC3mL3vKbvF5aQu7xYlb0g7cHpeveHtc
        PlvqsWlVJ5vH5iX1HrtvNrB59Da/Y/PY2Xqf1aNvyypGj8+b5DzaD3QzBXBF6dkU5ZeWpCpk
        5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GX8/9rAVvCUo2Le1/IG
        xmPsXYycHBICJhLXNj1g7mLk4hASWMoocbZpKxNEQkLi9sImRghbWOLPtS42iKLnjBKLtt4F
        KuLgYBPQkmjsBBskAlSzv6OVBaSGWWAnk8Sizf/BmoUFYiQm/+gEG8oioCoxcctMMJtXwFJi
        eVsHM8QCeYmZl76DDeIUsJK4MPE3I8h8IaCa/ovSEOWCEidnPmEBsZmBypu3zmaewCgwC0lq
        FpLUAkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIERtu3Yz807GOe9+qh3iJGJg/EQowQH
        s5II70rOPclCvCmJlVWpRfnxRaU5qcWHGE2Bzp7ILCWanA+M8bySeEMzA1NDEzNLA1NLM2Ml
        cV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBibbrT9jZD7/u91/tb/FbI8Cd+pMYQHn6882WJcs
        4tw99cpkZVm+dqV7kyNit9+8VLVm1t5iLsubsQ3L/nKvn+88TfXm7PUemlErvA8EShbOrrnL
        O2dG4+6V52dFtoZtP/frwjvvgrJN8sE8S3wE2lJNm3aEWOixxTTGs0ezc+k4vboWs8HVLmzH
        x/76dV0XhbM27vvg/XHjeaG+x8XuSxYrtIWv+mUVPlXu8l27OQtn/V159Vh0xTJT2/3ruJq0
        bT+Y/ZykuKg51X75Q7MY1WUhbiLve46pF00W8Tig/8C4jv9z6rRi3wLl6m25z+XU1LabVznl
        Mpzo+CaSPOfKHqkquRdTvXVq5m3f9M71hbkSS3FGoqEWc1FxIgDMdbZGOQMAAA==
X-CMS-MailID: 20230110143637eucas1p1fa9ab24ea73f524dd3dcb11c10b5c11a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230110143637eucas1p1fa9ab24ea73f524dd3dcb11c10b5c11a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110143637eucas1p1fa9ab24ea73f524dd3dcb11c10b5c11a
References: <20230110143635.77300-1-p.raghav@samsung.com>
        <CGME20230110143637eucas1p1fa9ab24ea73f524dd3dcb11c10b5c11a@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the superfluous request queue check in bdev_is_zoned() as
bdev_get_queue() can never return NULL.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/blkdev.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b87ed829ab94..0956bc0fb5b0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1285,12 +1285,7 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 
 static inline bool bdev_is_zoned(struct block_device *bdev)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return blk_queue_is_zoned(q);
-
-	return false;
+	return blk_queue_is_zoned(bdev_get_queue(bdev));
 }
 
 static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
-- 
2.25.1

