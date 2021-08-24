Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A1C4320E
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 14:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3855E6127B
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 14:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbhHXODA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:03:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8922 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbhHXOC7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 10:02:59 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gv9fw1YDcz8tnd;
        Tue, 24 Aug 2021 21:58:00 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 22:02:08 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 24
 Aug 2021 22:02:07 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 1/5] blk-mq: add a new interface to get request by tag
Date:   Tue, 24 Aug 2021 22:12:23 +0800
Message-ID: <20210824141227.808340-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824141227.808340-1-yukuai3@huawei.com>
References: <20210824141227.808340-1-yukuai3@huawei.com>
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

Ming Lei had fixed the request uaf while iterating tags in
commit bd63141d585b ("blk-mq: clear stale request in tags->rq[] before
freeing one request pool").

However, hctx->tags->rq[] will point to hctx->sched_tags->static_rq[]
in blk_mq_get_driver_tag(), and blk_mq_tag_to_rq() can access such
request in some drivers. Generally it won't be a problem if the
driver can make sure to get drivet tag before calling
blk_mq_tag_to_rq(). However, nbd will do such thing once it receive
a reply message from server, and there isn't any mechanism to
protect that it won't handle the reply message without a corresponding
request message.

Thus add new interface to make sure it won't return a freed request,
and then nbd can check if it had sent the corresponding request message.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c     | 37 +++++++++++++++++++++++++++++++++++++
 block/blk-mq.c         |  1 +
 block/blk-mq.h         |  1 -
 include/linux/blk-mq.h |  4 ++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 86f87346232a..ddb159414661 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -652,3 +652,40 @@ u32 blk_mq_unique_tag(struct request *rq)
 		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
 }
 EXPORT_SYMBOL(blk_mq_unique_tag);
+
+
+/**
+ * blk_mq_get_rq_by_tag - if the request that is represented by the tag is
+ * not idle, increment it's reference and then return it. Otherwise return
+ * NULL.
+ *
+ * @tags: the tags we are looking from
+ * @tag: the tag that represents the request
+ */
+struct request *blk_mq_get_rq_by_tag(struct blk_mq_tags *tags,
+				     unsigned int tag)
+{
+	unsigned long flags;
+	struct request *rq;
+
+	/* hold lock to prevent accessing freed request by tag */
+	spin_lock_irqsave(&tags->lock, flags);
+	rq = blk_mq_tag_to_rq(tags, tag);
+	if (!rq)
+		goto out_unlock;
+
+	if (!refcount_inc_not_zero(&rq->ref)) {
+		rq = NULL;
+		goto out_unlock;
+	}
+
+	if (!blk_mq_request_started(rq)) {
+		blk_mq_put_rq_ref(rq);
+		rq = NULL;
+	}
+
+out_unlock:
+	spin_unlock_irqrestore(&tags->lock, flags);
+	return rq;
+}
+EXPORT_SYMBOL(blk_mq_get_rq_by_tag);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0b3d3e2acb6a..c756a26ed92d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -916,6 +916,7 @@ void blk_mq_put_rq_ref(struct request *rq)
 	else if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 }
+EXPORT_SYMBOL_GPL(blk_mq_put_rq_ref);
 
 static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d08779f77a26..20ef743a3ff6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -47,7 +47,6 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
-void blk_mq_put_rq_ref(struct request *rq);
 
 /*
  * Internal helpers for allocating/freeing the request map
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 22215db36122..ccd8fc4a0bdb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -641,4 +641,8 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio);
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 
+struct request *blk_mq_get_rq_by_tag(struct blk_mq_tags *tags,
+		unsigned int tag);
+void blk_mq_put_rq_ref(struct request *rq);
+
 #endif
-- 
2.31.1

