Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CEFC433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D75F2063A
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6Ok/+C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgE1IB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 04:01:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43506 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbgE1IB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 04:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590652888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlthS1hPQwFubQQ1Kucy5POA8qrNJJ9fE4EJ/8TLJKI=;
        b=Y6Ok/+C7lydJ5GHN8/pM8GEajKHignwnm1SUCH3aizSETS/N0H64aaiEUGusiNPNbGmCBf
        RJ0erdF4H6/wUWpZ7pHd9dVnUBxE05d9xXUHd36LSz8u+6EpC50VnA5WNSVIlL+ePuA7PA
        7VKmGKKj4k6BbmD4IvyG2PQTKosmiO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-PQhuz69ZO1uSZJ84v1KcBg-1; Thu, 28 May 2020 04:01:26 -0400
X-MC-Unique: PQhuz69ZO1uSZJ84v1KcBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C82A19200C1;
        Thu, 28 May 2020 08:01:25 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF45860C05;
        Thu, 28 May 2020 08:01:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V3 3/6] blk-mq: move getting driver tag and budget into one helper
Date:   Thu, 28 May 2020 16:00:50 +0800
Message-Id: <20200528080053.1062653-4-ming.lei@redhat.com>
In-Reply-To: <20200528080053.1062653-1-ming.lei@redhat.com>
References: <20200528080053.1062653-1-ming.lei@redhat.com>
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
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 75 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7a6832f2e107..d97403cb6229 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1196,18 +1196,51 @@ static void blk_mq_handle_zone_resource(struct request *rq,
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
@@ -1225,31 +1258,9 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
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
 
@@ -1302,6 +1313,18 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
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

