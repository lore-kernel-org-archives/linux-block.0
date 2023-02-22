Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6A7C636D6
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 14:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBVOe7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 09:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBVOe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 09:34:59 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F739BAF
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 06:34:56 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230222143451euoutp01b9295c8867c8fdfb381bc0591d51e91c~GLC77SHmG2677726777euoutp01f
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 14:34:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230222143451euoutp01b9295c8867c8fdfb381bc0591d51e91c~GLC77SHmG2677726777euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677076491;
        bh=b6G1mqUpjDbyKmsRX5aHIaUN7A143eAIimKoCyTTXdY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ir8WnOlyv35JgI83UCvCZ/mBNAmDhNqqprCIThQVN3ZZ34nqMKLUOBfIIOvVok5qh
         TZ/Dn8E7Y/xLtt8SF5FLgkmSf92KeLyHyIcKeXMZGjWnuPJCe1VDvQDFNylQSU7P70
         lDrPNNrmiiug/JZXDEKceQbs/ib1aqTEebFmJHXo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230222143450eucas1p2f38228dbc3d985d310bb34e0f63d7962~GLC7BEmOg2986229862eucas1p20;
        Wed, 22 Feb 2023 14:34:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1A.C1.61197.A0826F36; Wed, 22
        Feb 2023 14:34:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5~GLC6iUmG21691316913eucas1p1P;
        Wed, 22 Feb 2023 14:34:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230222143450eusmtrp289af464fad3207c57038e1866a9f7945~GLC6hhHGc0513905139eusmtrp2q;
        Wed, 22 Feb 2023 14:34:50 +0000 (GMT)
X-AuditID: cbfec7f5-7c5ff7000000ef0d-1d-63f6280ab8ca
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.74.00518.90826F36; Wed, 22
        Feb 2023 14:34:49 +0000 (GMT)
Received: from localhost (unknown [106.210.248.119]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230222143449eusmtip1bd0f8cd3ffab2d358187030801d411c3~GLC6I1N4-2653026530eusmtip1V;
        Wed, 22 Feb 2023 14:34:49 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, gost.dev@samsung.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] block: shift with PAGE_SHIFT instead of dividing with
 PAGE_SIZE
Date:   Wed, 22 Feb 2023 20:04:43 +0530
Message-Id: <20230222143443.69599-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djP87pcGt+SDV4fl7JYfbefzeLmgZ1M
        FitXH2Wy2HtL2+Lz0hZ2B1aPy2dLPXbfbGDz6NuyitHj8ya5AJYoLpuU1JzMstQifbsEroxJ
        3/6xFyzkrTg8czlbA+Mjri5GDg4JAROJrbdTuxi5OIQEVjBKrLh+kg3C+cIo8XrbE1YI5zOj
        xJwz/5i6GDnBOr6v7GCHSCxnlJjyuZMRwnnJKHHzz382kLlsAloSjZ3sIA0iAsIS+ztaWUBs
        ZoFMiZPNC8FsYYEgicl3roOVswioSjT/9gMJ8wpYSsw58YYNYpe8xMxL39kh4oISJ2c+gRoj
        L9G8dTYzRE0rh8TxXmuIb1wkps7nhggLS7w6voUdwpaR+L9zPtT51RJPb/xmBrlYQqCFUaJ/
        53o2iF5rib4zOSAms4CmxPpd+hDljhLTN/9hgqjgk7jxVhDiAD6JSdumM0OEeSU62oQgqpUk
        dv58ArVUQuJy0xwWCNtD4vX8Q6wgtpBArMSCeT9ZJzAqzELy1iwkb81CuGEBI/MqRvHU0uLc
        9NRi47zUcr3ixNzi0rx0veT83E2MwPRx+t/xrzsYV7z6qHeIkYmD8RCjBAezkgjvf97PyUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFkmTg4pRqY+F+ohv25d/Ln
        nuds7t+WOPNetWHT/fRmXvu/3wwrToTMetxmybQk4bCtyr6+LHfbF+kix3fubHSMnPGHmW2V
        +DGrcJue25XH1Hce73xwKDC11WFKpuvJ4vknj9geFpj9J9nt94mew6fNbrWp8HT3mx/lMfL/
        NL8uSYkx5I8EG79pppsk+6nqf6wFAj9F2DYbOT78tOjf1CC/jhtMx+c9vfLwwQ1tE/edSWI5
        KdM9i3vqJm/cZ+ATYFYQKfNq0dJ3B1T05dP+tl9sXqDTmKWkEusm9+nfsgfMpsqvsi0uJAUL
        z5V66fLmUd/ynOe2c16uX6/zYvn7ztREw6c8GY4ZNyQXF34STc95dM3h/YoNSizFGYmGWsxF
        xYkAmKXExI4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xu7qcGt+SDWbPsrRYfbefzeLmgZ1M
        FitXH2Wy2HtL2+Lz0hZ2B1aPy2dLPXbfbGDz6NuyitHj8ya5AJYoPZui/NKSVIWM/OISW6Vo
        QwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxJ3/6xFyzkrTg8czlbA+Mjri5G
        Tg4JAROJ7ys72LsYuTiEBJYySryY3MsCkZCQuL2wiRHCFpb4c62LDaLoOaPEjuNfmboYOTjY
        BLQkGjvZQWpEgGr2d7SC9TIL5Epce/SCDcQWFgiQmDWtAaycRUBVovm3H0iYV8BSYs6JN2wQ
        4+UlZl76zg4RF5Q4OfMJ1Bh5ieats5knMPLNQpKahSS1gJFpFaNIamlxbnpusZFecWJucWle
        ul5yfu4mRmD4bjv2c8sOxpWvPuodYmTiYDzEKMHBrCTC+5/3c7IQb0piZVVqUX58UWlOavEh
        RlOg8yYyS4km5wMjKK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1Oq
        gSk3cEaQhvSc04/Z828+iJjSMN2vTYQxxtR7sqGkbZlzbtpz3xiWlsZT2gE5autvskU8buc7
        cG7evBsTJj9dwrX/Zo3OiU2TFJKeBdbcqi0/09u7fNnymDWsIbIXlDh9QwwsMnd+LbKcYdHn
        7Lgk7MjhIq0Fno+8rDhmnr5/t3rNomdHnOeuKLZZWxH3a9mUHU84PvSdnaUhq+09d5+HUkLX
        XqXud7FfvPxtb379nRco6qy+bKL31RVnjwUnZOXmOC+4vnyP1A05AXcLvdVWD366GW7+FdHx
        LFFT/fjBWXHZnc1z5/YJ7p3EJvP54DePnu5t/5TqiyxiE3+7LtzwOuZRNPOrpKuGrsnr7OY9
        a1FiKc5INNRiLipOBADX8It+6AIAAA==
X-CMS-MailID: 20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5
References: <CGME20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No functional change. Division will be costly, especially in the hot
path (page_is_mergeable() and bio_copy_user_iov())

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/bio.c     | 3 ++-
 block/blk-map.c | 2 +-
 block/ioctl.c   | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 2e421c0dad13..2dc248e03ec2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -922,7 +922,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return true;
 	else if (IS_ENABLED(CONFIG_KMSAN))
 		return false;
-	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
+	return (bv->bv_page + (bv_end >> PAGE_SHIFT)) ==
+	       (page + (off >> PAGE_SHIFT));
 }
 
 /**
diff --git a/block/blk-map.c b/block/blk-map.c
index 9137d16cecdc..22a0b65cafce 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -160,7 +160,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 
 	if (map_data) {
 		nr_pages = 1U << map_data->page_order;
-		i = map_data->offset / PAGE_SIZE;
+		i = map_data->offset >> PAGE_SHIFT;
 	}
 	while (len) {
 		unsigned int bytes = PAGE_SIZE;
diff --git a/block/ioctl.c b/block/ioctl.c
index 9c5f637ff153..afb435adce71 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -521,7 +521,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKFRASET:
 		if(!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-		bdev->bd_disk->bdi->ra_pages = (arg * 512) / PAGE_SIZE;
+		bdev->bd_disk->bdi->ra_pages = arg >> PAGE_SECTORS_SHIFT;
 		return 0;
 	case BLKRRPART:
 		if (!capable(CAP_SYS_ADMIN))
-- 
2.39.1

