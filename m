Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDB3C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 06:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiKWGEW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 01:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiKWGEN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 01:04:13 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116EFF2C05;
        Tue, 22 Nov 2022 22:04:13 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NH9Y26TlDzHw2Z;
        Wed, 23 Nov 2022 14:03:34 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 14:04:10 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH 10/11] blk-throttle: remove unused variable td in tg_update_has_rules
Date:   Wed, 23 Nov 2022 14:04:00 +0800
Message-ID: <20221123060401.20392-11-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221123060401.20392-1-shikemeng@huawei.com>
References: <20221123060401.20392-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

remove unused variable td in tg_update_has_rules

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-throttle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6f509cadd92b..82fe23e79b4b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -412,7 +412,6 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 static void tg_update_has_rules(struct throtl_grp *tg)
 {
 	struct throtl_grp *parent_tg = sq_to_tg(tg->service_queue.parent_sq);
-	struct throtl_data *td = tg->td;
 	int rw;
 
 	for (rw = READ; rw <= WRITE; rw++) {
-- 
2.30.0

