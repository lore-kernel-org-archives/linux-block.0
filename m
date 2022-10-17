Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2BBC4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 02:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJQCAS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiJQCAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Oct 2022 22:00:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA925283;
        Sun, 16 Oct 2022 19:00:16 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrKqZ75l7zpVlL;
        Mon, 17 Oct 2022 09:56:58 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:00:14 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shikemeng@huawei.com>
Subject: [PATCH 1/8] blk-iocost: Fix typo in comment
Date:   Mon, 17 Oct 2022 10:00:04 +0800
Message-ID: <20221017020011.25016-2-shikemeng@huawei.com>
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

soley -> solely

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 495396425bad..be4bc38821e2 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -111,7 +111,7 @@
  * busy signal.
  *
  * As devices can have deep queues and be unfair in how the queued commands
- * are executed, soley depending on rq wait may not result in satisfactory
+ * are executed, solely depending on rq wait may not result in satisfactory
  * control quality.  For a better control quality, completion latency QoS
  * parameters can be configured so that the device is considered saturated
  * if N'th percentile completion latency rises above the set point.
-- 
2.30.0

