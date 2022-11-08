Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE5CC433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 04:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiKHExS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 23:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiKHEwn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 23:52:43 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D8B326E2;
        Mon,  7 Nov 2022 20:52:34 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N5wgp0BfMz15MSb;
        Tue,  8 Nov 2022 12:52:22 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 12:52:32 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 08/10] block, bfq: remove unnecessary goto tag in bfq_dispatch_rq_from_bfqq
Date:   Tue, 8 Nov 2022 12:52:22 +0800
Message-ID: <20221108045224.19092-9-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221108045224.19092-1-shikemeng@huawei.com>
References: <20221108045224.19092-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We jump to tag only for returning current rq. Return directly to
remove this tag.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index cffc5ff66ee6..64c1249d8eda 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5031,7 +5031,7 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 	bfq_dispatch_remove(bfqd->queue, rq);
 
 	if (bfqq != bfqd->in_service_queue)
-		goto return_rq;
+		return rq;
 
 	/*
 	 * If weight raising has to terminate for bfqq, then next
@@ -5051,12 +5051,9 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 	 * belongs to CLASS_IDLE and other queues are waiting for
 	 * service.
 	 */
-	if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
-		goto return_rq;
+	if ((bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
+		bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
 
-	bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
-
-return_rq:
 	return rq;
 }
 
-- 
2.30.0

