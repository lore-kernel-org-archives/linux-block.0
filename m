Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0110C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEB720756
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p87GCtIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgEPPlD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgEPPlD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 11:41:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE6C061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8VYDef1yaLwa5PidqvCtcX67waE0+z7sXbn+57oBtyE=; b=p87GCtIaVg1NspvVcmwYpcyKYx
        sRPi1HU2PGhRzfxdG5p/SH2vhceJCI8b8weC8JTC8BCtixCreCZZkJxWyzmNtGUQ35SmyedyNlDc/
        m76T4mpINXkIxS67HFOsNj3NUrRdVFLkcCF/wc7dJ2nFwR+9Sakq4JvLdvUeuoi+zfApzqh3yqchH
        APDCpT57/ELPf0Idfa9yUz/umw7RJ/L2v8lQZ7U0IPh+qoGPaB9ukLbvx7K2y5S3q3WmQtNxlG/bw
        YiAhiSw+e3qLuu9PTrmiNjara4q0lcRKJUqDOXUJMB0O48O6paZL1zf7FpHQB9hpwgVJ1AT2Xko13
        bGI83YJw==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZyvt-00035K-IP; Sat, 16 May 2020 15:41:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: remove the bio argument to ->prepare_request
Date:   Sat, 16 May 2020 17:40:59 +0200
Message-Id: <20200516154059.328211-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

None of the I/O schedulers actually needs it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c      | 2 +-
 block/blk-mq.c           | 2 +-
 block/kyber-iosched.c    | 2 +-
 block/mq-deadline.c      | 2 +-
 include/linux/elevator.h | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3d411716d7ee4..50c8f034c01c5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6073,7 +6073,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
  * comments on bfq_init_rq for the reason behind this delayed
  * preparation.
  */
-static void bfq_prepare_request(struct request *rq, struct bio *bio)
+static void bfq_prepare_request(struct request *rq)
 {
 	/*
 	 * Regardless of whether we have an icq attached, we have to
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6f0279a7b59aa..60adad51ad816 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -387,7 +387,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 			if (e->type->icq_cache)
 				blk_mq_sched_assign_ioc(rq);
 
-			e->type->ops.prepare_request(rq, bio);
+			e->type->ops.prepare_request(rq);
 			rq->rq_flags |= RQF_ELVPRIV;
 		}
 	}
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 34dcea0ef6377..a38c5ab103d12 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -579,7 +579,7 @@ static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
 	return merged;
 }
 
-static void kyber_prepare_request(struct request *rq, struct bio *bio)
+static void kyber_prepare_request(struct request *rq)
 {
 	rq_set_domain_token(rq, -1);
 }
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b490f47fd553c..b57470e154c8f 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -541,7 +541,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
  * Nothing to do here. This is defined only to ensure that .finish_request
  * method is called upon request completion.
  */
-static void dd_prepare_request(struct request *rq, struct bio *bio)
+static void dd_prepare_request(struct request *rq)
 {
 }
 
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 901bda352dcb7..bacc40a0bdf39 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -39,7 +39,7 @@ struct elevator_mq_ops {
 	void (*request_merged)(struct request_queue *, struct request *, enum elv_merge);
 	void (*requests_merged)(struct request_queue *, struct request *, struct request *);
 	void (*limit_depth)(unsigned int, struct blk_mq_alloc_data *);
-	void (*prepare_request)(struct request *, struct bio *bio);
+	void (*prepare_request)(struct request *);
 	void (*finish_request)(struct request *);
 	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head *, bool);
 	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
-- 
2.26.2

