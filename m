Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F28C433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 02:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A06E2074A
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 02:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHZCON (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 22:14:13 -0400
Received: from smtp.h3c.com ([60.191.123.56]:31932 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgHZCOM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 22:14:12 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 07Q2Ddmm051523
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 10:13:39 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Aug 2020 10:13:40 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] [v2] blk-mq: use BLK_MQ_NO_TAG for no tag
Date:   Wed, 26 Aug 2020 10:06:51 +0800
Message-ID: <20200826020651.9856-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 07Q2Ddmm051523
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace various magic -1 constants for tags with BLK_MQ_NO_TAG.
And move the definition of BLK_MQ_NO_TAG from 'block/blk-mq-tag.h'
to 'include/linux/blk-mq.h'

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 block/blk-core.c       | 4 ++--
 block/blk-mq-sched.c   | 2 +-
 block/blk-mq-tag.h     | 6 ------
 include/linux/blk-mq.h | 8 +++++++-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639..c7eaf7504 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -116,8 +116,8 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->__sector = (sector_t) -1;
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
-	rq->tag = -1;
-	rq->internal_tag = -1;
+	rq->tag = BLK_MQ_NO_TAG;
+	rq->internal_tag = BLK_MQ_NO_TAG;
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
 	refcount_set(&rq->ref, 1);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a19cdf159..439481f59 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -522,7 +522,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		goto run;
 	}
 
-	WARN_ON(e && (rq->tag != -1));
+	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
 
 	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
 		/*
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index b1acac518..8fc48aa72 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -45,12 +45,6 @@ static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 	return sbq_wait_ptr(bt, &hctx->wait_index);
 }
 
-enum {
-	BLK_MQ_NO_TAG		= -1U,
-	BLK_MQ_TAG_MIN		= 1,
-	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
-};
-
 extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
 extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9d2d5ad36..2499d8aae 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -209,6 +209,12 @@ enum hctx_type {
 	HCTX_MAX_TYPES,
 };
 
+enum {
+	BLK_MQ_NO_TAG		= -1U,
+	BLK_MQ_TAG_MIN		= 1,
+	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
+};
+
 /**
  * struct blk_mq_tag_set - tag set that can be shared between request queues
  * @map:	   One or more ctx -> hctx mappings. One map exists for each
@@ -569,7 +575,7 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx,
 		struct request *rq)
 {
-	if (rq->tag != -1)
+	if (rq->tag != BLK_MQ_NO_TAG)
 		return rq->tag | (hctx->queue_num << BLK_QC_T_SHIFT);
 
 	return rq->internal_tag | (hctx->queue_num << BLK_QC_T_SHIFT) |
-- 
2.17.1

