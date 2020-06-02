Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00C5C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 818922072F
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMS0S4/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBJPi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:15:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49737 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726174AbgFBJPh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 05:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591089336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xZKGNwP5mXr81tqlEZkGHDLI2cSCq0nCGaNkNgIV6I=;
        b=AMS0S4/WfccDEv0K/JV+5jJdfBq89GLcJeESB4VFj9cjfWkWCUA5Fpq1t7EdnTdhwqK7Tx
        cwYVSlNhG6TU30k+9N/k0hnuBtGFm8SEVy7Hn4RvuWoVlmtmxcyoN2fZv0q+2tjsJmYh/c
        4C0rdXV8oeJAnf9mkEcWwYQeGhiuqbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-lygVNbppMuWiy-xnlAA7Bg-1; Tue, 02 Jun 2020 05:15:34 -0400
X-MC-Unique: lygVNbppMuWiy-xnlAA7Bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D6B100CCC2;
        Tue,  2 Jun 2020 09:15:33 +0000 (UTC)
Received: from localhost (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 780C45C1C5;
        Tue,  2 Jun 2020 09:15:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V4 3/6] blk-mq: move getting driver tag and budget into one helper
Date:   Tue,  2 Jun 2020 17:14:59 +0800
Message-Id: <20200602091502.1822499-4-ming.lei@redhat.com>
In-Reply-To: <20200602091502.1822499-1-ming.lei@redhat.com>
References: <20200602091502.1822499-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move code for getting driver tag and budget into one helper, so
blk_mq_dispatch_rq_list gets a bit simplified, and easier to read.

Meantime move updating of 'no_tag' and 'no_budget_available' into
the branch for handling partial dispatch because that is exactly
consumer of the two local variables.

Also rename the parameter of 'got_budget' as 'ask_budget'.

No functional change.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 75 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 723bc39507fe..ee9342aac7be 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1233,18 +1233,51 @@ static void blk_mq_handle_zone_resource(struct request *rq,
 	__blk_mq_requeue_request(rq);
 }
 
+enum prep_dispatch {
+	PREP_DISPATCH_OK,
+	PREP_DISPATCH_NO_TAG,
+	PREP_DISPATCH_NO_BUDGET,
+};
+
+static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
+						  bool ask_budget)
+{
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	if (ask_budget && !blk_mq_get_dispatch_budget(rq->q)) {
+		blk_mq_put_driver_tag(rq);
+		return PREP_DISPATCH_NO_BUDGET;
+	}
+
+	if (!blk_mq_get_driver_tag(rq)) {
+		/*
+		 * The initial allocation attempt failed, so we need to
+		 * rerun the hardware queue when a tag is freed. The
+		 * waitqueue takes care of that. If the queue is run
+		 * before we add this entry back on the dispatch list,
+		 * we'll re-run it below.
+		 */
+		if (!blk_mq_mark_tag_wait(hctx, rq)) {
+			/* budget is always obtained before getting tag */
+			blk_mq_put_dispatch_budget(rq->q);
+			return PREP_DISPATCH_NO_TAG;
+		}
+	}
+
+	return PREP_DISPATCH_OK;
+}
+
 /*
  * Returns true if we did some work AND can potentially do more.
  */
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			     bool got_budget)
 {
+	enum prep_dispatch prep;
 	struct request_queue *q = hctx->queue;
 	struct request *rq, *nxt;
-	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
-	bool no_budget_avail = false;
 	LIST_HEAD(zone_list);
 
 	if (list_empty(list))
@@ -1262,31 +1295,9 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		WARN_ON_ONCE(hctx != rq->mq_hctx);
-		if (!got_budget && !blk_mq_get_dispatch_budget(q)) {
-			blk_mq_put_driver_tag(rq);
-			no_budget_avail = true;
+		prep = blk_mq_prep_dispatch_rq(rq, !got_budget);
+		if (prep != PREP_DISPATCH_OK)
 			break;
-		}
-
-		if (!blk_mq_get_driver_tag(rq)) {
-			/*
-			 * The initial allocation attempt failed, so we need to
-			 * rerun the hardware queue when a tag is freed. The
-			 * waitqueue takes care of that. If the queue is run
-			 * before we add this entry back on the dispatch list,
-			 * we'll re-run it below.
-			 */
-			if (!blk_mq_mark_tag_wait(hctx, rq)) {
-				blk_mq_put_dispatch_budget(q);
-				/*
-				 * For non-shared tags, the RESTART check
-				 * will suffice.
-				 */
-				if (hctx->flags & BLK_MQ_F_TAG_SHARED)
-					no_tag = true;
-				break;
-			}
-		}
 
 		list_del_init(&rq->queuelist);
 
@@ -1339,6 +1350,18 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	 */
 	if (!list_empty(list)) {
 		bool needs_restart;
+		bool no_tag = false;
+		bool no_budget_avail = false;
+
+		/*
+		 * For non-shared tags, the RESTART check
+		 * will suffice.
+		 */
+		if (prep == PREP_DISPATCH_NO_TAG &&
+				(hctx->flags & BLK_MQ_F_TAG_SHARED))
+			no_tag = true;
+		if (prep == PREP_DISPATCH_NO_BUDGET)
+			no_budget_avail = true;
 
 		/*
 		 * If we didn't flush the entire list, we could have told
-- 
2.25.2

