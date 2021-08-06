Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF73C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 01:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDEB60C51
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 01:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhHFB55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:57:57 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13286 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhHFB54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 21:57:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GgpQR1050z83BF;
        Fri,  6 Aug 2021 09:52:47 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 09:57:39 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 6 Aug
 2021 09:57:39 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 3/4] block, bfq: add support to record request size information
Date:   Fri, 6 Aug 2021 10:08:25 +0800
Message-ID: <20210806020826.1407257-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806020826.1407257-1-yukuai3@huawei.com>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If bfq keep dispatching requests with same size, the following
information are stored if CONFIG_BFQ_GROUP_IOSCHED is enabled:

1) the size
2) the count of requests
3) when the first request was dispatched

These will be used in later patch to support concurrent sync
io in such situation.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 15 +++++++++++++++
 block/bfq-iosched.h | 16 ++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a780205a1be4..7df3fc0ef4ef 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4936,6 +4936,20 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
 		bfq_tot_busy_queues(bfqd) > 0;
 }
 
+static void bfq_update_dispatch_size_info(struct bfq_data *bfqd,
+					  unsigned int size)
+{
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (bfqd->dispatch_size == size) {
+		bfqd->dispatch_count++;
+	} else {
+		bfqd->dispatch_size = size;
+		bfqd->dispatch_count = 1;
+		bfqd->dispatch_time = jiffies;
+	}
+#endif
+}
+
 static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
@@ -5019,6 +5033,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		bfqd->rq_in_driver++;
 start_rq:
 		rq->rq_flags |= RQF_STARTED;
+		bfq_update_dispatch_size_info(bfqd, blk_rq_bytes(rq));
 	}
 exit:
 	return rq;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 610769214f72..9ab498839e7c 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -777,6 +777,22 @@ struct bfq_data {
 	 * function)
 	 */
 	unsigned int word_depths[2][2];
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	/* the size of last dispatched request */
+	unsigned int dispatch_size;
+	/*
+	 * If bfq keep dispatching requests with same size, this store the
+	 * count of requests. We use unsigned long here, so we don't care
+	 * about overflow.
+	 */
+	unsigned long dispatch_count;
+	/*
+	 * If bfq keep dispatching requests with same size, this store the
+	 * time when the first request was dispatched.
+	 */
+	unsigned long dispatch_time;
+#endif
 };
 
 enum bfqq_state_flags {
-- 
2.31.1

