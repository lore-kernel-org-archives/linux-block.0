Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C23C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 11:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC72D60F36
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 11:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKBLfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:35:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4049 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhKBLfX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 07:35:23 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hk71N6Ng7z6H6rk;
        Tue,  2 Nov 2021 19:27:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Tue, 2 Nov 2021 12:32:46 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 11:32:44 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH RFT 1/3] blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument
Date:   Tue, 2 Nov 2021 19:27:33 +0800
Message-ID: <1635852455-39935-2-git-send-email-john.garry@huawei.com>
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

The only user of blk_mq_hw_ctx blk_mq_hw_ctx argument is
blk_mq_rq_inflight().

Function blk_mq_rq_inflight() uses the hctx to find the associated request
queue to match against the request. However this same check is already
done in caller bt_iter(), so drop this check.

With that change there are no more users of busy_iter_fn blk_mq_hw_ctx
argument, so drop the argument.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq-tag.c     |  2 +-
 block/blk-mq.c         | 17 ++++++++---------
 include/linux/blk-mq.h |  3 +--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 995336abee33..0d773c44a7ec 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -254,7 +254,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 		return true;
 
 	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
-		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
+		ret = iter_data->fn(rq, iter_data->data, reserved);
 	blk_mq_put_rq_ref(rq);
 	return ret;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 07eb1412760b..c26e6c9301dd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -126,8 +126,7 @@ struct mq_inflight {
 	unsigned int inflight[2];
 };
 
-static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
-				  struct request *rq, void *priv,
+static bool blk_mq_check_inflight(struct request *rq, void *priv,
 				  bool reserved)
 {
 	struct mq_inflight *mi = priv;
@@ -1136,14 +1135,15 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
-static bool blk_mq_rq_inflight(struct blk_mq_hw_ctx *hctx, struct request *rq,
-			       void *priv, bool reserved)
+static bool blk_mq_rq_inflight(struct request *rq, void *priv,
+			       bool reserved)
 {
 	/*
-	 * If we find a request that isn't idle and the queue matches,
-	 * we know the queue is busy. Return false to stop the iteration.
+	 * If we find a request that isn't idle we know the queue is busy
+	 * as it's checked in the iter.
+	 * Return false to stop the iteration.
 	 */
-	if (blk_mq_request_started(rq) && rq->q == hctx->queue) {
+	if (blk_mq_request_started(rq)) {
 		bool *busy = priv;
 
 		*busy = true;
@@ -1205,8 +1205,7 @@ void blk_mq_put_rq_ref(struct request *rq)
 		__blk_mq_free_request(rq);
 }
 
-static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, void *priv, bool reserved)
+static bool blk_mq_check_expired(struct request *rq, void *priv, bool reserved)
 {
 	unsigned long *next = priv;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8682663e7368..da8de0d6f99b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -479,8 +479,7 @@ struct blk_mq_queue_data {
 	bool last;
 };
 
-typedef bool (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
-		bool);
+typedef bool (busy_iter_fn)(struct request *, void *, bool);
 typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
 
 /**
-- 
2.17.1

