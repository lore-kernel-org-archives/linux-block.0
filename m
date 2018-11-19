Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5618CC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1732920823
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fe4ng7vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1732920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeKSOOQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:14:16 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62740 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeKSOOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 09:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542599519; x=1574135519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2bteIgvU+Xj6dWadF96GiJ3sWnt5ZWQMBkBQRMZuUng=;
  b=Fe4ng7vClIJcZMps+TkB1SSK5DhO0JR7RPrpOf2qUgSURPXdXvaVEhW0
   PZUtd468Lk5S/R8B/C18MR2genHjKrUqxVDIYAAI/y+0c5SvYDczULx1J
   1a9fpJBhvQiQLwbI03cKJhggVO8Ml1X2Jd3Mxif55kJ21VsONH/vj/TLQ
   M2J7UpflNoB2qFNdXzdZqesG0wxRUM36CHcKImXubyyAMutWRDibztAMq
   lu+J13U3YuX6DdxWxHkr5vnr7OgCUHN4SrwfshqHsoPxZD3HrGGdLVZdA
   HtaAQQwKDZ+ay8ZkF4iaFZHwLiUBInd98zk95muQ8GtOOjwuv0dHhW4TG
   g==;
X-IronPort-AV: E=Sophos;i="5.56,250,1539619200"; 
   d="scan'208";a="96272449"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2018 11:51:40 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Nov 2018 19:34:38 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2018 19:51:38 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] block: Remove bio->bi_ioc
Date:   Mon, 19 Nov 2018 12:51:26 +0900
Message-Id: <20181119035131.11255-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119035131.11255-1-damien.lemoal@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio->bi_ioc is never set so always NULL. Remove references to it in
bio_disassociate_task() and in rq_ioc() and delete this field from
struct bio. With this change, rq_ioc() always returns
current->io_context without the need for a bio argument. Further
simplify the code and make it more readable by also removing this
helper, which also allows to simplify blk_mq_sched_assign_ioc() by
removing its bio argument.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/bio.c               |  4 ----
 block/blk-core.c          |  2 +-
 block/blk-mq-sched.c      |  4 ++--
 block/blk-mq-sched.h      |  2 +-
 block/blk-mq.c            |  4 ++--
 block/blk.h               | 16 ----------------
 include/linux/blk_types.h |  3 +--
 7 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4f4d9884443b..03895cc0d74a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2027,10 +2027,6 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
  */
 void bio_disassociate_task(struct bio *bio)
 {
-	if (bio->bi_ioc) {
-		put_io_context(bio->bi_ioc);
-		bio->bi_ioc = NULL;
-	}
 	if (bio->bi_css) {
 		css_put(bio->bi_css);
 		bio->bi_css = NULL;
diff --git a/block/blk-core.c b/block/blk-core.c
index d6e8ab9ca99d..492648c96992 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -813,7 +813,7 @@ unsigned int blk_plug_queued_count(struct request_queue *q)
 
 void blk_init_request_from_bio(struct request *req, struct bio *bio)
 {
-	struct io_context *ioc = rq_ioc(bio);
+	struct io_context *ioc = current->io_context;
 
 	if (bio->bi_opf & REQ_RAHEAD)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d084f731d104..13b8dc332541 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -31,10 +31,10 @@ void blk_mq_sched_free_hctx_data(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
 
-void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio)
+void blk_mq_sched_assign_ioc(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	struct io_context *ioc = rq_ioc(bio);
+	struct io_context *ioc = current->io_context;
 	struct io_cq *icq;
 
 	spin_lock_irq(&q->queue_lock);
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 7ff5671bf128..0f719c8532ae 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -8,7 +8,7 @@
 void blk_mq_sched_free_hctx_data(struct request_queue *q,
 				 void (*exit)(struct blk_mq_hw_ctx *));
 
-void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio);
+void blk_mq_sched_assign_ioc(struct request *rq);
 
 void blk_mq_sched_request_inserted(struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32b246ed44c0..636f80b96fa6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -389,8 +389,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	if (!op_is_flush(data->cmd_flags)) {
 		rq->elv.icq = NULL;
 		if (e && e->type->ops.prepare_request) {
-			if (e->type->icq_cache && rq_ioc(bio))
-				blk_mq_sched_assign_ioc(rq, bio);
+			if (e->type->icq_cache)
+				blk_mq_sched_assign_ioc(rq);
 
 			e->type->ops.prepare_request(rq, bio);
 			rq->rq_flags |= RQF_ELVPRIV;
diff --git a/block/blk.h b/block/blk.h
index 816a9abb87cd..610948157a5b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -254,22 +254,6 @@ void ioc_clear_queue(struct request_queue *q);
 
 int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, int node);
 
-/**
- * rq_ioc - determine io_context for request allocation
- * @bio: request being allocated is for this bio (can be %NULL)
- *
- * Determine io_context to use for request allocation for @bio.  May return
- * %NULL if %current->io_context doesn't exist.
- */
-static inline struct io_context *rq_ioc(struct bio *bio)
-{
-#ifdef CONFIG_BLK_CGROUP
-	if (bio && bio->bi_ioc)
-		return bio->bi_ioc;
-#endif
-	return current->io_context;
-}
-
 /**
  * create_io_context - try to create task->io_context
  * @gfp_mask: allocation mask
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dbdbfbd6a987..c0ba1a038ff3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -174,10 +174,9 @@ struct bio {
 	void			*bi_private;
 #ifdef CONFIG_BLK_CGROUP
 	/*
-	 * Optional ioc and css associated with this bio.  Put on bio
+	 * Optional css associated with this bio.  Put on bio
 	 * release.  Read comment on top of bio_associate_current().
 	 */
-	struct io_context	*bi_ioc;
 	struct cgroup_subsys_state *bi_css;
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
-- 
2.19.1

