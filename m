Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF13C352A3
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 03:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E749C20848
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 03:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bI24jqFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBODV4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:21:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28130 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727642AbgBODV4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 22:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581736915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RCO3qBRBZClLx/EzYQoiju5YHAvawKO9qGqCEWQMhiA=;
        b=bI24jqFDzlZE55Cabs+M7hsbk7WS/aTub11VjqonSVp5mjL6tlpPJFI/xhWrlnoJnQ2/aT
        rtC8+k1XhXqcS3VZzAlOAy9hcL/vKEB62W2KZ59jAJ1Y4LDVf3EYpdsG1FYDpb3ARyWs7l
        IEIJAHNhUfuMNtvIXr1pANHD7WX8adk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-mFNbtY18P6WQgae6eyfZBQ-1; Fri, 14 Feb 2020 22:21:51 -0500
X-MC-Unique: mFNbtY18P6WQgae6eyfZBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51D0C8017DF;
        Sat, 15 Feb 2020 03:21:50 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E42215C12E;
        Sat, 15 Feb 2020 03:21:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-mq: insert passthrough request into hctx->dispatch directly
Date:   Sat, 15 Feb 2020 11:21:40 +0800
Message-Id: <20200215032140.4093-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For some reason, device may be in one situation which can't handle
FS request, so STS_RESOURCE is always returned and the FS request
will be added to hctx->dispatch. However passthrough request may
be required at that time for fixing the problem. If passthrough
request is added to scheduler queue, there isn't any chance for
blk-mq to dispatch it given we prioritize requests in hctx->dispatch.
Then the FS IO request may never be completed, and IO hang is caused.

So passthrough request has to be added to hctx->dispatch directly.

Fix this issue by inserting passthrough request into hctx->dispatch
directly. Then it becomes consistent with original legacy IO request
path, in which passthrough request is always added to q->queue_head.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c    |  2 +-
 block/blk-mq-sched.c | 22 +++++++++++++++-------
 block/blk-mq.c       | 16 ++++++++++------
 block/blk-mq.h       |  3 ++-
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 3f977c517960..5cc775bdb06a 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -412,7 +412,7 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false);
+		blk_mq_request_bypass_insert(rq, false, false);
 		return;
 	}
=20
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ca22afd47b3d..856356b1619e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -361,13 +361,19 @@ static bool blk_mq_sched_bypass_insert(struct blk_m=
q_hw_ctx *hctx,
 				       bool has_sched,
 				       struct request *rq)
 {
-	/* dispatch flush rq directly */
-	if (rq->rq_flags & RQF_FLUSH_SEQ) {
-		spin_lock(&hctx->lock);
-		list_add(&rq->queuelist, &hctx->dispatch);
-		spin_unlock(&hctx->lock);
+	/*
+	 * dispatch flush and passthrough rq directly
+	 *
+	 * passthrough request has to be added to hctx->dispatch directly.
+	 * For some reason, device may be in one situation which can't
+	 * handle FS request, so STS_RESOURCE is always returned and the
+	 * FS request will be added to hctx->dispatch. However passthrough
+	 * request may be required at that time for fixing the problem. If
+	 * passthrough request is added to scheduler queue, there isn't any
+	 * chance to dispatch it given we prioritize requests in hctx->dispatch=
.
+	 */
+	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
 		return true;
-	}
=20
 	if (has_sched)
 		rq->rq_flags |=3D RQF_SORTED;
@@ -391,8 +397,10 @@ void blk_mq_sched_insert_request(struct request *rq,=
 bool at_head,
=20
 	WARN_ON(e && (rq->tag !=3D -1));
=20
-	if (blk_mq_sched_bypass_insert(hctx, !!e, rq))
+	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
+		blk_mq_request_bypass_insert(rq, at_head, false);
 		goto run;
+	}
=20
 	if (e && e->type->ops.insert_requests) {
 		LIST_HEAD(list);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a12b1763508d..5f5c43ae3792 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -735,7 +735,7 @@ static void blk_mq_requeue_work(struct work_struct *w=
ork)
 		 * merge.
 		 */
 		if (rq->rq_flags & RQF_DONTPREP)
-			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_request_bypass_insert(rq, false, false);
 		else
 			blk_mq_sched_insert_request(rq, true, false, false);
 	}
@@ -1677,12 +1677,16 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx=
 *hctx, struct request *rq,
  * Should only be used carefully, when the caller knows we want to
  * bypass a potential IO scheduler on the target device.
  */
-void blk_mq_request_bypass_insert(struct request *rq, bool run_queue)
+void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
+				  bool run_queue)
 {
 	struct blk_mq_hw_ctx *hctx =3D rq->mq_hctx;
=20
 	spin_lock(&hctx->lock);
-	list_add_tail(&rq->queuelist, &hctx->dispatch);
+	if (at_head)
+		list_add(&rq->queuelist, &hctx->dispatch);
+	else
+		list_add_tail(&rq->queuelist, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
=20
 	if (run_queue)
@@ -1849,7 +1853,7 @@ static blk_status_t __blk_mq_try_issue_directly(str=
uct blk_mq_hw_ctx *hctx,
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
=20
-	blk_mq_request_bypass_insert(rq, run_queue);
+	blk_mq_request_bypass_insert(rq, false, run_queue);
 	return BLK_STS_OK;
 }
=20
@@ -1876,7 +1880,7 @@ static void blk_mq_try_issue_directly(struct blk_mq=
_hw_ctx *hctx,
=20
 	ret =3D __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
 	if (ret =3D=3D BLK_STS_RESOURCE || ret =3D=3D BLK_STS_DEV_RESOURCE)
-		blk_mq_request_bypass_insert(rq, true);
+		blk_mq_request_bypass_insert(rq, false, true);
 	else if (ret !=3D BLK_STS_OK)
 		blk_mq_end_request(rq, ret);
=20
@@ -1910,7 +1914,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_h=
w_ctx *hctx,
 		if (ret !=3D BLK_STS_OK) {
 			if (ret =3D=3D BLK_STS_RESOURCE ||
 					ret =3D=3D BLK_STS_DEV_RESOURCE) {
-				blk_mq_request_bypass_insert(rq,
+				blk_mq_request_bypass_insert(rq, false,
 							list_empty(list));
 				break;
 			}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index eaaca8fc1c28..c0fa34378eb2 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -66,7 +66,8 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct=
 blk_mq_tags *tags,
  */
 void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request =
*rq,
 				bool at_head);
-void blk_mq_request_bypass_insert(struct request *rq, bool run_queue);
+void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
+				  bool run_queue);
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ct=
x *ctx,
 				struct list_head *list);
=20
--=20
2.20.1

