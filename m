Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2BCC4320E
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 01:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B501460C51
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 01:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhHFB56 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:57:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7795 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhHFB54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 21:57:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GgpWv6c3LzYlXr;
        Fri,  6 Aug 2021 09:57:31 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 09:57:39 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 6 Aug
 2021 09:57:38 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 2/4] block, bfq: do not idle if only one cgroup is activated
Date:   Fri, 6 Aug 2021 10:08:24 +0800
Message-ID: <20210806020826.1407257-3-yukuai3@huawei.com>
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

If only one group is activated, there is no need to guarantee the same
share of the throughput of queues in the same group.

If CONFIG_BFQ_GROUP_IOSCHED is enabled, there is no need to check
'varied_queue_weights' and 'multiple_classes_busy':
1) num_groups_with_pending_reqs = 0, idle is not needed
2) num_groups_with_pending_reqs = 1
   - if root group have any pending requests, idle is needed
   - if root group is idle, idle is not needed
3) num_groups_with_pending_reqs > 1, idle is needed

Test procedure:
run "fio -numjobs=1 -ioengine=psync -bs=4k -direct=1 -rw=randread..."
multiple times in the same cgroup(not root).

Test result: total bandwidth(Mib/s)
| total jobs | before this patch | after this patch      |
| ---------- | ----------------- | --------------------- |
| 1          | 33.8              | 33.8                  |
| 2          | 33.8              | 65.4 (32.7 each job)  |
| 4          | 33.8              | 106.8 (26.7 each job) |
| 8          | 33.8              | 126.4 (15.8 each job) |

By the way, if I test with "fio -numjobs=1/2/4/8 ...", test result is
the same with or without this patch.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7c6b412f9a9c..a780205a1be4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -709,7 +709,9 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
  * much easier to maintain the needed state:
  * 1) all active queues have the same weight,
  * 2) all active queues belong to the same I/O-priority class,
- * 3) there are no active groups.
+ * 3) there are one active group at most(incluing root_group).
+ * If the last condition is false, there is no need to guarantee the,
+ * same share of the throughput of queues in the same group.
  * In particular, the last condition is always true if hierarchical
  * support or the cgroups interface are not enabled, thus no state
  * needs to be maintained in this case.
@@ -717,7 +719,26 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
 				   struct bfq_queue *bfqq)
 {
-	bool smallest_weight = bfqq &&
+	bool smallest_weight;
+	bool varied_queue_weights;
+	bool multiple_classes_busy;
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	if (bfqd->num_groups_with_pending_reqs > 1)
+		return true;
+
+	if (bfqd->num_groups_with_pending_reqs &&
+	    bfqd->num_queues_with_pending_reqs_in_root)
+		return true;
+
+	/*
+	 * Reach here means only one group(incluing root group) has pending
+	 * requests, thus it's safe to return.
+	 */
+	return false;
+#endif
+
+	smallest_weight = bfqq &&
 		bfqq->weight_counter &&
 		bfqq->weight_counter ==
 		container_of(
@@ -729,21 +750,17 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
 	 * For queue weights to differ, queue_weights_tree must contain
 	 * at least two nodes.
 	 */
-	bool varied_queue_weights = !smallest_weight &&
+	varied_queue_weights = !smallest_weight &&
 		!RB_EMPTY_ROOT(&bfqd->queue_weights_tree.rb_root) &&
 		(bfqd->queue_weights_tree.rb_root.rb_node->rb_left ||
 		 bfqd->queue_weights_tree.rb_root.rb_node->rb_right);
 
-	bool multiple_classes_busy =
+	multiple_classes_busy =
 		(bfqd->busy_queues[0] && bfqd->busy_queues[1]) ||
 		(bfqd->busy_queues[0] && bfqd->busy_queues[2]) ||
 		(bfqd->busy_queues[1] && bfqd->busy_queues[2]);
 
-	return varied_queue_weights || multiple_classes_busy
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	       || bfqd->num_groups_with_pending_reqs > 0
-#endif
-		;
+	return varied_queue_weights || multiple_classes_busy;
 }
 
 /*
-- 
2.31.1

