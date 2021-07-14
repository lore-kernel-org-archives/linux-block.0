Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FB4C11F68
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 09:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116AB6120A
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 09:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhGNJkO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:40:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11414 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbhGNJkJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jul 2021 05:40:09 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GPslC2yGkzcdKD;
        Wed, 14 Jul 2021 17:33:59 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 17:37:16 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 14
 Jul 2021 17:37:16 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 3/3] block, bfq: consider request size in bfq_asymmetric_scenario()
Date:   Wed, 14 Jul 2021 17:45:29 +0800
Message-ID: <20210714094529.758808-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714094529.758808-1-yukuai3@huawei.com>
References: <20210714094529.758808-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a special case when bfq do not need to idle when more than
one groups is active:

 1) all active queues have the same weight,
 2) all active queues have the same request size.
 3) all active queues belong to the same I/O-priority class,

Each time a request is dispatched, bfq can switch in service queue
safely, since the throughput of each active queue is guaranteed to
be equivalent.

Test procedure:
run "fio -numjobs=1 -ioengine=psync -bs=4k -direct=1 -rw=randread..." in
different cgroup(not root).

Test result: total bandwidth(Mib/s)
| total jobs | before this patch | after this patch      |
| ---------- | ----------------- | --------------------- |
| 1          | 33.8              | 33.8                  |
| 2          | 33.8              | 65.4 (32.7 each job)  |
| 4          | 33.8              | 106.8 (26.7 each job) |
| 8          | 33.8              | 126.4 (15.8 each job) |

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e5a1093ec30a..b78fe8a1537e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -268,6 +268,15 @@ static struct kmem_cache *bfq_pool;
  */
 #define BFQ_RATE_SHIFT		16
 
+/*
+ * 1) bfq keep dispatching requests with same size for at least one second.
+ * 2) bfq dispatch at lease 1024 requests
+ *
+ * We think bfq are dispatching request with same size if the above two
+ * conditions hold true.
+ */
+#define VARIED_REQUEST_SIZE(bfqd) ((bfqd)->dispatch_count < 1024 ||\
+		time_before(jiffies, (bfqd)->dispatch_time + HZ))
 /*
  * When configured for computing the duration of the weight-raising
  * for interactive queues automatically (see the comments at the
@@ -724,7 +733,8 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
 	bool multiple_classes_busy;
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-	if (bfqd->num_groups_with_pending_reqs > 1)
+	if (bfqd->num_groups_with_pending_reqs > 1 &&
+	    VARIED_REQUEST_SIZE(bfqd))
 		return true;
 #endif
 
-- 
2.31.1

