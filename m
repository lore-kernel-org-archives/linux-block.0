Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D601C48BE5
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 09:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABB4611CE
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 09:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhFSJaU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jun 2021 05:30:20 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5047 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbhFSJaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jun 2021 05:30:20 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G6Vh72NlpzXhVC;
        Sat, 19 Jun 2021 17:23:03 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 19
 Jun 2021 17:28:08 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <jbacik@fb.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 2/2] blk-wbt: make sure throttle is enabled properly
Date:   Sat, 19 Jun 2021 17:37:00 +0800
Message-ID: <20210619093700.920393-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210619093700.920393-1-yi.zhang@huawei.com>
References: <20210619093700.920393-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After commit a79050434b45 ("blk-rq-qos: refactor out common elements of
blk-wbt"), if throttle was disabled by wbt_disable_default(), we could
not enable again, fix this by set enable_state back to
WBT_STATE_ON_DEFAULT.

Fixes: a79050434b45 ("blk-rq-qos: refactor out common elements of blk-wbt")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 block/blk-wbt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index b098ac6a84f0..f5e5ac915bf7 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -637,9 +637,13 @@ void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
 void wbt_enable_default(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
+
 	/* Throttling already enabled? */
-	if (rqos)
+	if (rqos) {
+		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
+			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
 		return;
+	}
 
 	/* Queue not registered? Maybe shutting down... */
 	if (!blk_queue_registered(q))
-- 
2.31.1

