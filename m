Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9EDC4332F
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 11:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647B1601FC
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 11:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhJMLPJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 07:15:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25181 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhJMLPI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 07:15:08 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HTqcC60wFz8tbx;
        Wed, 13 Oct 2021 19:11:55 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 19:13:01 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 13
 Oct 2021 19:13:01 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 2/2] block, bfq: do not idle if only one cgroup is activated
Date:   Wed, 13 Oct 2021 19:25:34 +0800
Message-ID: <20211013112534.3073296-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013112534.3073296-1-yukuai3@huawei.com>
References: <20211013112534.3073296-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If only one group is activated, there is no need to guarantee the
same share of the throughput of queues in the same group.

Test procedure:
run "fio -numjobs=1 -ioengine=psync -bs=4k -direct=1 -rw=randread..."
multiple times in the same cgroup.

Test result: total bandwidth(Mib/s)
| total jobs | before this patch | after this patch      |
| ---------- | ----------------- | --------------------- |
| 1          | 33.8              | 33.8                  |
| 2          | 33.8              | 65.4 (32.7 each job)  |
| 4          | 33.8              | 106.8 (26.7 each job) |
| 8          | 33.8              | 126.4 (15.8 each job) |

By the way, if I test with "fio -numjobs=1/2/4/8 ...", test result is
the same with or without this patch. This is because bfq_queue can
be merged in this situation.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d251735383f7..8d94f511bee8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -709,7 +709,7 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
  * much easier to maintain the needed state:
  * 1) all active queues have the same weight,
  * 2) all active queues belong to the same I/O-priority class,
- * 3) there are no active groups.
+ * 3) there are one active group at most.
  * In particular, the last condition is always true if hierarchical
  * support or the cgroups interface are not enabled, thus no state
  * needs to be maintained in this case.
@@ -741,7 +741,7 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
 
 	return varied_queue_weights || multiple_classes_busy
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-	       || bfqd->num_groups_with_pending_reqs > 0
+	       || bfqd->num_groups_with_pending_reqs > 1
 #endif
 		;
 }
-- 
2.31.1

