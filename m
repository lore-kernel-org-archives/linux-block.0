Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05547C4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 04:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiKHExU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 23:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiKHEwn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 23:52:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5121B1F2;
        Mon,  7 Nov 2022 20:52:35 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5wgs6vr6zRp5b;
        Tue,  8 Nov 2022 12:52:25 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 12:52:32 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 09/10] block, bfq: remove unused bfq_wr_max_time in struct bfq_data
Date:   Tue, 8 Nov 2022 12:52:23 +0800
Message-ID: <20221108045224.19092-10-shikemeng@huawei.com>
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

bfqd->bfq_wr_max_time is set to 0 in bfq_init_queue and is never changed.
It is only used in bfq_wr_duration when bfq_wr_max_time > 0 which never
meets, so bfqd->bfq_wr_max_time is not used actually. Just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 4 ----
 block/bfq-iosched.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 64c1249d8eda..40ac219b2d8f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1120,9 +1120,6 @@ static unsigned int bfq_wr_duration(struct bfq_data *bfqd)
 {
 	u64 dur;
 
-	if (bfqd->bfq_wr_max_time > 0)
-		return bfqd->bfq_wr_max_time;
-
 	dur = bfqd->rate_dur_prod;
 	do_div(dur, bfqd->peak_rate);
 
@@ -7138,7 +7135,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	 */
 	bfqd->bfq_wr_coeff = 30;
 	bfqd->bfq_wr_rt_max_time = msecs_to_jiffies(300);
-	bfqd->bfq_wr_max_time = 0;
 	bfqd->bfq_wr_min_idle_time = msecs_to_jiffies(2000);
 	bfqd->bfq_wr_min_inter_arr_async = msecs_to_jiffies(500);
 	bfqd->bfq_wr_max_softrt_rate = 7000; /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 71f721670ab6..48c147e5f9e0 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -719,8 +719,6 @@ struct bfq_data {
 	 * is multiplied.
 	 */
 	unsigned int bfq_wr_coeff;
-	/* maximum duration of a weight-raising period (jiffies) */
-	unsigned int bfq_wr_max_time;
 
 	/* Maximum weight-raising duration for soft real-time processes */
 	unsigned int bfq_wr_rt_max_time;
-- 
2.30.0

