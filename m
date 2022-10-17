Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D91C43219
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 02:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJQCAV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJQCAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Oct 2022 22:00:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D874324F2D;
        Sun, 16 Oct 2022 19:00:17 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrKny6ypvz1P7m7;
        Mon, 17 Oct 2022 09:55:34 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:00:14 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shikemeng@huawei.com>
Subject: [PATCH 2/8] blk-iocost: Reset vtime_base_rate in ioc_refresh_params
Date:   Mon, 17 Oct 2022 10:00:05 +0800
Message-ID: <20221017020011.25016-3-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221017020011.25016-1-shikemeng@huawei.com>
References: <20221017020011.25016-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit ac33e91e2daca("blk-iocost: implement vtime loss compensation")
split vtime_rate into vtime_rate and vtime_base_rate, we need reset both
vtime_base_rate and vtime_rate when device parameters are refreshed.
If vtime_base_rate is no reset here, vtime_rate will be overwritten with
old vtime_base_rate soon in ioc_refresh_vrate.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-iocost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index be4bc38821e2..9214733bbc14 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -906,8 +906,10 @@ static bool ioc_refresh_params(struct ioc *ioc, bool force)
 	if (idx == ioc->autop_idx && !force)
 		return false;
 
-	if (idx != ioc->autop_idx)
+	if (idx != ioc->autop_idx) {
 		atomic64_set(&ioc->vtime_rate, VTIME_PER_USEC);
+		ioc->vtime_base_rate = VTIME_PER_USEC;
+	}
 
 	ioc->autop_idx = idx;
 	ioc->autop_too_fast_at = 0;
-- 
2.30.0

