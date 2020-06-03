Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E5FC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 09:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB2A20734
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 09:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiyPDehJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFCJoO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:44:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgFCJoN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jun 2020 05:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591177451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H5GMoVwW9/PtNyYjW/d2XWz/kblgOsyhCr48NNAtBpk=;
        b=JiyPDehJef/clYPc4AX6o7OnDxNsjvg032C7sgzePPGKuFfZVireVmWTyR8pn6KLnvFXUB
        iGlRKSB9vaWUUqGJkkbETQ0HaucMn11kY1UxmgErU491m3aMi5O5f3VBU7XilrsbzNipyR
        pZC6azYiWuiaDwrjteJu6Y7EV1a2aWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-mRxOU1H6OryxS48gjxwFyA-1; Wed, 03 Jun 2020 05:44:08 -0400
X-MC-Unique: mRxOU1H6OryxS48gjxwFyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8281DEC1AC;
        Wed,  3 Jun 2020 09:44:06 +0000 (UTC)
Received: from localhost (ovpn-12-230.pek2.redhat.com [10.72.12.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0A6260C47;
        Wed,  3 Jun 2020 09:44:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V5 3/6] blk-mq: move getting driver tag and budget into one helper
Date:   Wed,  3 Jun 2020 17:43:34 +0800
Message-Id: <20200603094337.2064181-4-ming.lei@redhat.com>
In-Reply-To: <20200603094337.2064181-1-ming.lei@redhat.com>
References: <20200603094337.2064181-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 block/blk-mq.c | 66 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 723bc39507fe..fbfdb455e613 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1233,18 +1233,50 @@ static void blk_mq_handle_zone_resource(struct request *rq,
 	__blk_mq_requeue_request(rq);
 }
 
+enum prep_dispatch {
+	PREP_DISPATCH_OK,
+	PREP_DISPATCH_NO_TAG,
+	PREP_DISPATCH_NO_BUDGET,
+};
+
+static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
+						  bool need_budget)
+{
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	if (need_budget && !blk_mq_get_dispatch_budget(rq->q)) {
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
@@ -1262,31 +1294,9 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
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
 
@@ -1339,6 +1349,10 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	 */
 	if (!list_empty(list)) {
 		bool needs_restart;
+		/* For non-shared tags, the RESTART check will suffice */
+		bool no_tag = prep == PREP_DISPATCH_NO_TAG &&
+                        (hctx->flags & BLK_MQ_F_TAG_SHARED);
+		bool no_budget_avail = prep == PREP_DISPATCH_NO_BUDGET;
 
 		/*
 		 * If we didn't flush the entire list, we could have told
-- 
2.25.2

