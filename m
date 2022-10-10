Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059D6C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 02:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiJJCjI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Oct 2022 22:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJJCjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Oct 2022 22:39:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800014A82F;
        Sun,  9 Oct 2022 19:39:05 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mm2zf0m1jzHv7N;
        Mon, 10 Oct 2022 10:34:06 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 10:39:03 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH 3/4] blk-cgroup: Add NULL check of pd_alloc_fn in blkcg_activate_policy
Date:   Mon, 10 Oct 2022 10:38:58 +0800
Message-ID: <20221010023859.11896-4-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221010023859.11896-1-shikemeng@huawei.com>
References: <20221010023859.11896-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Function blkcg_policy_register only make sure pd_alloc_fn and pd_free_fn in
pairs, so pd_alloc_fn could be NULL in registered blkcg_policy. Check NULL
before use for pd_alloc_fn in blkcg_activate_policy to avoid protential
NULL dereference.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 463c568d3e86..fc083c35dc42 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1404,6 +1404,9 @@ int blkcg_activate_policy(struct request_queue *q,
 	if (blkcg_policy_enabled(q, pol))
 		return 0;
 
+	if (pol->pd_alloc_fn == NULL)
+		return -EINVAL;
+
 	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 retry:
-- 
2.30.0

