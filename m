Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD922C43217
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 12:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJRMTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJRMTn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 08:19:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DDC13E3B;
        Tue, 18 Oct 2022 05:19:39 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MsCXW3M71zJn2y;
        Tue, 18 Oct 2022 20:16:59 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 20:19:37 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 4/5] blk-iocost: Remove vrate member in struct ioc_now
Date:   Tue, 18 Oct 2022 20:19:31 +0800
Message-ID: <20221018121932.10792-5-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221018121932.10792-1-shikemeng@huawei.com>
References: <20221018121932.10792-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we trace vtime_base_rate instead of vtime_rate, there is nowhere
which accesses now->vrate except function ioc_now using now->vrate locally.
Just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b0991b52e3dd..761295ed9c5a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -556,7 +556,6 @@ struct ioc_now {
 	u64				now_ns;
 	u64				now;
 	u64				vnow;
-	u64				vrate;
 };
 
 struct iocg_wait {
@@ -1020,10 +1019,11 @@ static void ioc_adjust_base_vrate(struct ioc *ioc, u32 rq_wait_pct,
 static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 {
 	unsigned seq;
+	u64 vrate;
 
 	now->now_ns = ktime_get();
 	now->now = ktime_to_us(now->now_ns);
-	now->vrate = atomic64_read(&ioc->vtime_rate);
+	vrate = atomic64_read(&ioc->vtime_rate);
 
 	/*
 	 * The current vtime is
@@ -1036,7 +1036,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 	do {
 		seq = read_seqcount_begin(&ioc->period_seqcount);
 		now->vnow = ioc->period_at_vtime +
-			(now->now - ioc->period_at) * now->vrate;
+			(now->now - ioc->period_at) * vrate;
 	} while (read_seqcount_retry(&ioc->period_seqcount, seq));
 }
 
-- 
2.30.0

