Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA735B148
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654893; cv=none; b=XyhZfa1xrBWkUuitz1g+w9ckLN+AB6HKoRShc32QmB2JEsD8MZmA1L0HGNQVHTYpVCKxbgo1qsI1aOuq+46yM/GxGjin6qV168sKMa5NQn+eWEjz4qm/1IlFoT78sfyqVPmFs13vyT+KwaoASa26finOo027j6pvVy9wRcCqe6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654893; c=relaxed/simple;
	bh=6yyeyGFmkkNRFIkYxA2N6zoZ84FpCAiyeO0mXxxkDWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl28TAL+DFVpHRQj+q2isQZO9QCFeNjjEoT6azOIKzYi2El1QrU3jXeFKphoi26sqOULbWbevvaVTM5AUC072Wz/BUHPp+2qc7N5Aim3arms88fgU1xtjItR+WSboPTf6OwuakmpH8M37c07hRhbVrZZF+B5oZ70/9aM2DB6YXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhfWBiA1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhfWBiA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763654876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2dNPZc9RqISba5HRVPDxozrpVbvhmyD1Vw11rb++d8=;
	b=RhfWBiA1ggF6SwXej6mhu8BUcUVfySS9gcxFPXNPk/uLgmynAgt7581oIVL+GakbFouf9W
	cLijkUy2LCGoKKV84YIMU8JjjMZszLakpJD4lK6I41ysZMlSa55j1SD5SBq1ZwSx6wpAcK
	nOOl9mMSd0HhDBJR3s6002eGlsMHKLU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-crRXJt5FN6WOmi4cvv28Zw-1; Thu,
 20 Nov 2025 11:07:52 -0500
X-MC-Unique: crRXJt5FN6WOmi4cvv28Zw-1
X-Mimecast-MFC-AGG-ID: crRXJt5FN6WOmi4cvv28Zw_1763654871
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B56311955F56;
	Thu, 20 Nov 2025 16:07:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2CBD19560A2;
	Thu, 20 Nov 2025 16:07:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/4] blk-mq: fix plug list corruption when queue_rq adds new requests
Date: Fri, 21 Nov 2025 00:07:20 +0800
Message-ID: <20251120160722.3623884-5-ming.lei@redhat.com>
In-Reply-To: <20251120160722.3623884-1-ming.lei@redhat.com>
References: <20251120160722.3623884-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When blk_mq_flush_plug_list() dispatches requests, stacking drivers
(like loop with NOWAIT support) may submit bios to backing devices
from within their queue_rq() callback. These backing device IOs can
add new requests back to the same plug->mq_list that's currently
being iterated, causing list corruption.

The corruption occurs in this call path:

  submit_bio() with active plug
    blk_mq_submit_bio()
      blk_add_rq_to_plug() - adds loop request
        if plug is full:
          blk_mq_flush_plug_list(plug, false)
            blk_mq_dispatch_list(&plug->mq_list, ...)
              rq_list_pop(&plug->mq_list)  # Iterating
                loop_queue_rq()
                  lo_rw_aio_nowait()
                    file->f_op->write_iter()  # Backing file IO
                      submit_bio()             # New bio!
                        blk_mq_submit_bio()
                          blk_add_rq_to_plug()
                            rq_list_add_tail(&plug->mq_list, rq)  # CORRUPTION!

Fix this by extracting the dispatch logic into __blk_mq_flush_plug_list()
and making blk_mq_flush_plug_list() loop:

1. Save plug state (rq_count, has_elevator, multiple_queues)
2. Reset plug state to allow new requests
3. Swap plug->mq_list to a local list
4. Dispatch the local list via __blk_mq_flush_plug_list()
5. Repeat if new requests were added during dispatch

This ensures:
- No list corruption: each iteration works on a detached copy
- Complete flush: keeps flushing until no new requests are added
- Handles nesting: recursive calls see rq_count=0 and return early

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 64 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2650c97a75e..128c2bc28d94 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2955,10 +2955,30 @@ static void blk_mq_dispatch_multiple_queue_requests(struct rq_list *rqs)
 	} while (!rq_list_empty(rqs));
 }
 
+static void __blk_mq_flush_plug_list(struct rq_list *list,
+				     unsigned int depth,
+				     bool has_elevator,
+				     bool multiple_queues,
+				     bool from_schedule)
+{
+	if (!has_elevator && !from_schedule) {
+		if (multiple_queues) {
+			blk_mq_dispatch_multiple_queue_requests(list);
+			return;
+		}
+
+		blk_mq_dispatch_queue_requests(list, depth);
+		if (rq_list_empty(list))
+			return;
+	}
+
+	do {
+		blk_mq_dispatch_list(list, from_schedule);
+	} while (!rq_list_empty(list));
+}
+
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
-	unsigned int depth;
-
 	/*
 	 * We may have been called recursively midway through handling
 	 * plug->mq_list via a schedule() in the driver's queue_rq() callback.
@@ -2968,23 +2988,35 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	 */
 	if (plug->rq_count == 0)
 		return;
-	depth = plug->rq_count;
-	plug->rq_count = 0;
 
-	if (!plug->has_elevator && !from_schedule) {
-		if (plug->multiple_queues) {
-			blk_mq_dispatch_multiple_queue_requests(&plug->mq_list);
-			return;
-		}
+	/*
+	 * Flush requests in a loop to handle cases where queue_rq() callback
+	 * adds new requests back to the plug (e.g., stacking drivers like loop
+	 * submitting bios to backing devices). Keep flushing until no new
+	 * requests are added.
+	 */
+	do {
+		struct rq_list reqs;
+		unsigned int depth;
+		bool has_elevator, multiple_queues;
 
-		blk_mq_dispatch_queue_requests(&plug->mq_list, depth);
-		if (rq_list_empty(&plug->mq_list))
-			return;
-	}
+		depth = plug->rq_count;
+		plug->rq_count = 0;
+		has_elevator = plug->has_elevator;
+		plug->has_elevator = false;
+		multiple_queues = plug->multiple_queues;
+		plug->multiple_queues = false;
 
-	do {
-		blk_mq_dispatch_list(&plug->mq_list, from_schedule);
-	} while (!rq_list_empty(&plug->mq_list));
+		/*
+		 * Swap plug->mq_list to a local list to allow new requests
+		 * being added to plug->mq_list during dispatching.
+		 */
+		reqs = plug->mq_list;
+		rq_list_init(&plug->mq_list);
+
+		__blk_mq_flush_plug_list(&reqs, depth, has_elevator,
+					 multiple_queues, from_schedule);
+	} while (plug->rq_count > 0);
 }
 
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
-- 
2.47.0

