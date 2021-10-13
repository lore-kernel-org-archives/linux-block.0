Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED02C433FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 11:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B8B610CB
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 11:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJMLPI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 07:15:08 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25130 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhJMLPI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 07:15:08 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HTqbc1rLjz1DHXS;
        Wed, 13 Oct 2021 19:11:24 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
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
Subject: [PATCH v3 1/2] block, bfq: counted root group into 'num_groups_with_pending_reqs'
Date:   Wed, 13 Oct 2021 19:25:33 +0800
Message-ID: <20211013112534.3073296-2-yukuai3@huawei.com>
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

'num_groups_with_pending_reqs' represents how many groups that are
not root group and have pending requests. This patch also counted
root group into 'num_groups_with_pending_reqs'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 36 ++++++++++++++++++++++++++------
 block/bfq-wf2q.c    | 50 +++++++++++++++++++++++++++++++++------------
 2 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fec18118dc30..d251735383f7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -852,6 +852,16 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 	bfq_put_queue(bfqq);
 }
 
+static inline void
+bfq_clear_group_with_pending_reqs(struct bfq_data *bfqd,
+				  struct bfq_entity *entity)
+{
+	if (entity->in_groups_with_pending_reqs) {
+		entity->in_groups_with_pending_reqs = false;
+		bfqd->num_groups_with_pending_reqs--;
+	}
+}
+
 /*
  * Invoke __bfq_weights_tree_remove on bfqq and decrement the number
  * of active groups for each queue's inactive parent entity.
@@ -860,9 +870,25 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			     struct bfq_queue *bfqq)
 {
 	struct bfq_entity *entity = bfqq->entity.parent;
+	struct bfq_sched_data *sd;
+
+	/*
+	 * If the bfq queue is in root group, the decrement of
+	 * num_groups_with_pending_reqs is performed immediately upon the
+	 * deactivation of entity.
+	 */
+	if (!entity) {
+		entity = &bfqd->root_group->entity;
+		sd = entity->my_sched_data;
+
+		if (!sd->in_service_entity)
+			bfq_clear_group_with_pending_reqs(bfqd, entity);
+
+		return;
+	}
 
 	for_each_entity(entity) {
-		struct bfq_sched_data *sd = entity->my_sched_data;
+		sd = entity->my_sched_data;
 
 		if (sd->next_in_service || sd->in_service_entity) {
 			/*
@@ -880,7 +906,8 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 		}
 
 		/*
-		 * The decrement of num_groups_with_pending_reqs is
+		 * If the bfq queue is not in root group,
+		 * the decrement of num_groups_with_pending_reqs is
 		 * not performed immediately upon the deactivation of
 		 * entity, but it is delayed to when it also happens
 		 * that the first leaf descendant bfqq of entity gets
@@ -889,10 +916,7 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 		 * needed. See the comments on
 		 * num_groups_with_pending_reqs for details.
 		 */
-		if (entity->in_groups_with_pending_reqs) {
-			entity->in_groups_with_pending_reqs = false;
-			bfqd->num_groups_with_pending_reqs--;
-		}
+		bfq_clear_group_with_pending_reqs(bfqd, entity);
 	}
 
 	/*
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index b74cc0da118e..5c70973c65ea 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -945,6 +945,42 @@ static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
 
 	bfq_active_insert(st, entity);
 }
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+static inline void
+bfq_set_group_with_pending_reqs(struct bfq_data *bfqd,
+				struct bfq_entity *entity)
+{
+	if (!entity->in_groups_with_pending_reqs) {
+		entity->in_groups_with_pending_reqs = true;
+		bfqd->num_groups_with_pending_reqs++;
+	}
+}
+
+static void bfq_update_groups_with_pending_reqs(struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	if (bfqq) {
+		/*
+		 * If the entity represents bfq_queue, and the queue belongs to
+		 * root cgroup.
+		 */
+		if (!entity->parent)
+			bfq_set_group_with_pending_reqs(bfqq->bfqd,
+				&bfqq->bfqd->root_group->entity);
+	} else {
+		/* If the entity represents bfq_group. */
+		struct bfq_group *bfqg =
+			container_of(entity, struct bfq_group, entity);
+		struct bfq_data *bfqd = bfqg->bfqd;
+
+		bfq_set_group_with_pending_reqs(bfqd, entity);
+	}
+}
+#else
+#define bfq_update_groups_with_pending_reqs(struct bfq_entity *entity) \
+	do {} while (0)
+#endif
 
 /**
  * __bfq_activate_entity - handle activation of entity.
@@ -999,19 +1035,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 		entity->on_st_or_in_serv = true;
 	}
 
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
-		struct bfq_group *bfqg =
-			container_of(entity, struct bfq_group, entity);
-		struct bfq_data *bfqd = bfqg->bfqd;
-
-		if (!entity->in_groups_with_pending_reqs) {
-			entity->in_groups_with_pending_reqs = true;
-			bfqd->num_groups_with_pending_reqs++;
-		}
-	}
-#endif
-
+	bfq_update_groups_with_pending_reqs(entity);
 	bfq_update_fin_time_enqueue(entity, st, backshifted);
 }
 
-- 
2.31.1

