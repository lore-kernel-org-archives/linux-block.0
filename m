Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04FAC433FE
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 11:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A1660F36
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 11:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhKBLfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:35:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4050 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhKBLfZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 07:35:25 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hk71y0pz8z67v1F;
        Tue,  2 Nov 2021 19:28:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Tue, 2 Nov 2021 12:32:48 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 11:32:46 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH RFT 2/3] blk-mq: Delete busy_iter_fn
Date:   Tue, 2 Nov 2021 19:27:34 +0800
Message-ID: <1635852455-39935-3-git-send-email-john.garry@huawei.com>
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

Typedefs busy_iter_fn and busy_tag_iter_fn are now identical, so delete
busy_iter_fn to reduce duplication.

It would be nicer to delete busy_tag_iter_fn, as the name busy_iter_fn is
less specific.

However busy_tag_iter_fn is used in many different parts of the tree,
unlike busy_iter_fn which is just use in block/, so just take the
straightforward path now, so that we could rename later treewide.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq-tag.c     | 6 +++---
 block/blk-mq-tag.h     | 2 +-
 include/linux/blk-mq.h | 1 -
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 0d773c44a7ec..bc233ea92adf 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -215,7 +215,7 @@ void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags)
 
 struct bt_iter_data {
 	struct blk_mq_hw_ctx *hctx;
-	busy_iter_fn *fn;
+	busy_tag_iter_fn *fn;
 	void *data;
 	bool reserved;
 };
@@ -274,7 +274,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		bitmap_tags member of struct blk_mq_tags.
  */
 static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
-			busy_iter_fn *fn, void *data, bool reserved)
+			busy_tag_iter_fn *fn, void *data, bool reserved)
 {
 	struct bt_iter_data iter_data = {
 		.hctx = hctx,
@@ -457,7 +457,7 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
  * called for all requests on all queues that share that tag set and not only
  * for requests associated with @q.
  */
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index df787b5a23bd..5668e28be0b7 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -28,7 +28,7 @@ extern void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set,
 extern void blk_mq_tag_update_sched_shared_tags(struct request_queue *q);
 
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv);
 void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index da8de0d6f99b..2344c68bff35 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -479,7 +479,6 @@ struct blk_mq_queue_data {
 	bool last;
 };
 
-typedef bool (busy_iter_fn)(struct request *, void *, bool);
 typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
 
 /**
-- 
2.17.1

