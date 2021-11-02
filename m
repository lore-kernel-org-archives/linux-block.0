Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93332C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 11:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEC3603E5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 11:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhKBLf2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:35:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4051 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhKBLf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 07:35:27 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hk7201Fdsz67v1F;
        Tue,  2 Nov 2021 19:28:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Tue, 2 Nov 2021 12:32:50 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 11:32:48 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH RFT 3/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags
Date:   Tue, 2 Nov 2021 19:27:35 +0800
Message-ID: <1635852455-39935-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Kashyap reports high CPU usage in blk_mq_queue_tag_busy_iter() and callees
using megaraid SAS RAID card since moving to shared tags [0].

Previously, when shared tags was shared sbitmap, this function was less
than optimum since we would iter through all tags for all hctx's,
yet only ever match upto tagset depth number of rqs.

Since the change to shared tags, things are even less efficient if we have
parallel callers of blk_mq_queue_tag_busy_iter(). This is because in
bt_iter() -> blk_mq_find_and_get_req() there would be more contention on
accessing each request ref and tags->lock since they are now shared among
all HW queues.

Optimise by having separate calls to bt_for_each() for when we're using
shared tags. In this case no longer pass a hctx, as it is no longer
relevant, and teach bt_iter() about this.

Ming suggested something along the lines of this change, apart from a
different implementation.

[0] https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq-tag.c | 52 +++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index bc233ea92adf..00515933c8a8 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -215,6 +215,7 @@ void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags)
 
 struct bt_iter_data {
 	struct blk_mq_hw_ctx *hctx;
+	struct request_queue *q;
 	busy_tag_iter_fn *fn;
 	void *data;
 	bool reserved;
@@ -238,11 +239,18 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_iter_data *iter_data = data;
 	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
-	struct blk_mq_tags *tags = hctx->tags;
+	struct request_queue *q = iter_data->q;
 	bool reserved = iter_data->reserved;
+	struct blk_mq_tag_set *set = q->tag_set;
+	struct blk_mq_tags *tags;
 	struct request *rq;
 	bool ret = true;
 
+	if (blk_mq_is_shared_tags(set->flags))
+		tags = set->shared_tags;
+	else
+		tags = hctx->tags;
+
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
 	/*
@@ -253,7 +261,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (!rq)
 		return true;
 
-	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
+	if (rq->q == q && (!hctx || rq->mq_hctx == hctx))
 		ret = iter_data->fn(rq, iter_data->data, reserved);
 	blk_mq_put_rq_ref(rq);
 	return ret;
@@ -274,13 +282,15 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		bitmap_tags member of struct blk_mq_tags.
  */
 static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
-			busy_tag_iter_fn *fn, void *data, bool reserved)
+			busy_tag_iter_fn *fn, void *data, bool reserved,
+			struct request_queue *q)
 {
 	struct bt_iter_data iter_data = {
 		.hctx = hctx,
 		.fn = fn,
 		.data = data,
 		.reserved = reserved,
+		.q = q,
 	};
 
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
@@ -460,9 +470,6 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv)
 {
-	struct blk_mq_hw_ctx *hctx;
-	int i;
-
 	/*
 	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
 	 * while the queue is frozen. So we can use q_usage_counter to avoid
@@ -471,19 +478,30 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		struct blk_mq_tags *tags = hctx->tags;
-
-		/*
-		 * If no software queues are currently mapped to this
-		 * hardware queue, there's nothing to check
-		 */
-		if (!blk_mq_hw_queue_mapped(hctx))
-			continue;
+	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
+		struct blk_mq_tags *tags = q->tag_set->shared_tags;
 
 		if (tags->nr_reserved_tags)
-			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
-		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
+			bt_for_each(NULL, &tags->breserved_tags, fn, priv, true, q);
+		bt_for_each(NULL, &tags->bitmap_tags, fn, priv, false, q);
+	} else {
+		struct blk_mq_hw_ctx *hctx;
+		int i;
+
+		queue_for_each_hw_ctx(q, hctx, i) {
+			struct blk_mq_tags *tags = hctx->tags;
+
+			/*
+			 * If no software queues are currently mapped to this
+			 * hardware queue, there's nothing to check
+			 */
+			if (!blk_mq_hw_queue_mapped(hctx))
+				continue;
+
+			if (tags->nr_reserved_tags)
+				bt_for_each(hctx, &tags->breserved_tags, fn, priv, true, q);
+			bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false, q);
+		}
 	}
 	blk_queue_exit(q);
 }
-- 
2.17.1

