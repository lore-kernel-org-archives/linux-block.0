Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E383BC4321E
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 03:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiK2DCK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 22:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiK2DB7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 22:01:59 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874E3D92C;
        Mon, 28 Nov 2022 19:01:58 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLnCy0SkqzRpWf;
        Tue, 29 Nov 2022 11:01:18 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 11:01:55 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 09/10] blk-throttle: Use more siutable time_after check for update of slice_start
Date:   Tue, 29 Nov 2022 11:01:46 +0800
Message-ID: <20221129030147.27400-10-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221129030147.27400-1-shikemeng@huawei.com>
References: <20221129030147.27400-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to update tg->slice_start[rw] to start when they are
equal already. So remove "eq" part of check before update slice_start.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 94d850b57462..4c80f2aa1e29 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -645,7 +645,7 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 	 * that bandwidth. Do try to make use of that bandwidth while giving
 	 * credit.
 	 */
-	if (time_after_eq(start, tg->slice_start[rw]))
+	if (time_after(start, tg->slice_start[rw]))
 		tg->slice_start[rw] = start;
 
 	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
-- 
2.30.0

