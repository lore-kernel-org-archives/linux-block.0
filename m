Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D0FA3745
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 09:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKAJe2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKAJe0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 05:34:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DA018B13;
        Tue,  1 Nov 2022 02:34:26 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1l8m1Xl4zRnsP;
        Tue,  1 Nov 2022 17:29:28 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:23 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 07/20] block, bfq: simpfy check for interactive bfqq in bfq_update_wr_data
Date:   Tue, 1 Nov 2022 17:34:04 +0800
Message-ID: <20221101093417.10540-8-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221101093417.10540-1-shikemeng@huawei.com>
References: <20221101093417.10540-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bfqq->wr_coeff will be set to bfqd->bfq_wr_coeff if bfqq is in
interactive weight raising. So we can simpfy interactive weight raising
check in function bfq_update_wr_data.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 20ae52882235..15e7d6c6fa83 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4997,8 +4997,7 @@ static void bfq_update_wr_data(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 				bfqq->entity.prio_changed = 1;
 			}
 		}
-		if (bfqq->wr_coeff > 1 &&
-		    bfqq->wr_cur_max_time != bfqd->bfq_wr_rt_max_time &&
+		if (bfqq->wr_coeff == bfqd->bfq_wr_coeff &&
 		    bfqq->service_from_wr > max_service_from_wr) {
 			/* see comments on max_service_from_wr */
 			bfq_bfqq_end_wr(bfqq);
-- 
2.30.0

