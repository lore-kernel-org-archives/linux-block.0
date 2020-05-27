Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4BFC433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B84A2075A
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WfNh2tiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388996AbgE0SGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388138AbgE0SGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:06:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FACC03E97D
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GZHK7ojbE9JEQt7G0TTJxEDV3ZWIqb3+Cw6lVNqm5Ro=; b=WfNh2tizpfcpxBq9LZd/G8POHY
        wD+Uu5p780612RowFUJ/0oVQ5OQ31u4bVncPtegCqY06IzuvKwmhBH+pl9L2LQzwvo5vOfR/PwN3/
        6BFwynrVautQ/T8bcMZWkVlOCcc16PmErpLKBBpfl4ksse/v2XNTS2tCUW3AYdJW/Hq2oRbnmWuUw
        NV6UjX1cDKwPXTzIQBtLmZlASiyO5aKBiKDa2xWTRctn6PMay33qi0Nb6qfOsCUcJNBaYhDFNF+0/
        CCxZO4pJqMBiv9xk0qUywe5p+z/FR+u9C8hJAsbgKTUMQ5hTcnO/dZDSaz2nI30jKCSHSz7MF1y1I
        xcbFk0lg==;
Received: from p4fdb0aaa.dip0.t-ipconnect.de ([79.219.10.170] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je0S2-00050K-70; Wed, 27 May 2020 18:06:50 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 1/8] blk-mq: remove the bio argument to ->prepare_request
Date:   Wed, 27 May 2020 20:06:37 +0200
Message-Id: <20200527180644.514302-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527180644.514302-1-hch@lst.de>
References: <20200527180644.514302-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

None of the I/O schedulers actually needs it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
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
index cac11945f6023..850e3642efc40 100644
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

