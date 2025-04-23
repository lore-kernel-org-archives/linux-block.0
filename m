Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E8426D4E1
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441496; cv=none; b=Dwrsgrxg2Kg5Tiek8w8ZYYeiyTp52t51P6UZTI+H4v7h6dOTupzywaMZBqgdIhlzYQ7JevYBVWFQrD19cJyI7MLoSpEu6RzK+M/HGrhE8wJXk1plpNrfuNq59LizkKOAFnK4osyPSwTVenkwi56NwBHbJ3UOMZzmwnhDYhaO6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441496; c=relaxed/simple;
	bh=ti5z4JVtSZzRIvZC6dUX4azsCUaOndsOm7qk1lMNfYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBS2mvqf28lzu+2fmXXriky55Xr9jdQvkJpeYckEbGM7ool03l6/DAPOPgc4OdmUQaFTLicMmsB6F0U51wSjefIZReX1yAVZBc7em3FkT5RUMe9pbyKs9srBq0pVFhEXkLS0+Rh0ENMkef2z7rtNRorHkPxBOt3VRLMVpHH0W5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MOAAfZN+; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MOAAfZN+"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-85df142374bso1353639f.1
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745441493; x=1746046293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io7FZ7jM2VblIMiViDDtGdBTQwQ9HPxFb0/zqdALMPI=;
        b=MOAAfZN+T+TEdN5yhZmCsvpA7+DybaWK/V/IZHRG6ImaubJSB9SAPrjkna60/+uHvG
         nsGdFQz24ARaYmKIYHAge0+BryN64kQ8ik3ODv3cpS/pNI/n35mZuyeJldfww3I3NR+V
         ruVoHTf5jp1pNAwdqR0fX9IBnU0WwqiWzpitEIEPq/2/7YVC9EFV5xw6yG8hCSJ3Xwhl
         GMxhoGXlQeI8IPeGFNViIZsDV/uI3tL9Lj5kr3PEGA3NKsQeAeHqWZWPoyzviREQ2z8p
         Yu1eQzJVS0NCWP9BZQT3py93xmllkNS07J3FTt8VVgSg1bIXexsqV3qjc95DET6CgxZu
         yTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441493; x=1746046293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io7FZ7jM2VblIMiViDDtGdBTQwQ9HPxFb0/zqdALMPI=;
        b=Hsize1CrMvjP+RUeuNzBTk190SY/t25OOX1s3dIUqPgt44Q08kHhK90lixHC6L17q1
         AWBgx8hSzAZqokmbvl6jolDuwDqQpvlFprXFIrJ4TxU/70LuqSYp+qqTyL1E/UtMT0CY
         SHRMwpc7Shr38vjepX8DP9h/1lBmHQywmOKVYDxWbt2dMdg8DINVUQKk3iSK71IdQbFH
         e4FV7CSEvLNTUbDYg3h4tTT9pBgFoHanHFgD+8YtP2eS5dj3IGW+E4cN5mP0pirqVGGo
         3DGKtoDsj1tvobpU0yuZd6XNkGCFvW24y2cJjJaf8Ad2vdvx6A5Ut6lWpRoN0eQQgHbf
         TFIQ==
X-Gm-Message-State: AOJu0YzE6liSPnh91Im/UfrW/BzPPh+3RvhKsa33hjx5DwYvMMrOAdED
	MK53TgF5i4OwpSmN/8rqiDMBkDe1ufhEOGGu00ii1f6Fs5FNHTm22dpbXAGag23M3Ibk0IBbakO
	7QcP4rQ3XJURFJlr8XoGYiAvv6oU4+vIoq6RAwM0Jh4miDixj
X-Gm-Gg: ASbGncv9WMB7rkwr/FF06bhmAe3c7vkSH/WOcvFK8mhph2yZlDpckYTMmvNkbqe9Hf6
	I4XpihzeagkitF3INeu/NMdGFRzEUQSPWfrg7kgieziZzONW0yPwzflPW6Eu2LfIbJtMi2ulyWq
	HB9YSmy0lwZP5v1S2zBueUz2v0qkupELQFB6renK86LbKxXcND0w+LzsPp8yKuuaUJ7pgys9Zkn
	hfcu0vwKxiBbnB6FY+mqX50dMZWhl+tXPMqhE372cGEaI931o0BN+K/ceLxO0pK8WU2CSDIp3CN
	rBA+b77e6batex0fdM5Soc9st4nUzA==
X-Google-Smtp-Source: AGHT+IH2QoG9AKfqv9dap7Sq/fd6X84H+flJOYdI2qKcxs5wCyuBiQ9DiPZiZOePpQ0Cj6W+5e0sHjw2hq4k
X-Received: by 2002:a05:6e02:17cd:b0:3d9:2d10:9dd2 with SMTP id e9e14a558f8ab-3d930481fefmr272895ab.7.1745441493683;
        Wed, 23 Apr 2025 13:51:33 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f6a39602d6sm496856173.65.2025.04.23.13.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:51:33 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 55BDA34058D;
	Wed, 23 Apr 2025 14:51:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 50B25E42828; Wed, 23 Apr 2025 14:51:33 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/3] block: take rq_list instead of plug in dispatch functions
Date: Wed, 23 Apr 2025 14:51:25 -0600
Message-ID: <20250423205127.2976981-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250423205127.2976981-1-csander@purestorage.com>
References: <20250423205127.2976981-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mq_plug_issue_direct(), __blk_mq_flush_plug_list(), and
blk_mq_dispatch_plug_list() take a struct blk_plug * but only use its
mq_list. Pass the struct rq_list * instead in preparation for calling
them with other lists of requests.

Drop "plug" from the function names as they are no longer plug-specific.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-mq.c      | 26 ++++++++++++--------------
 block/mq-deadline.c |  2 +-
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 554380bfd002..fb514fd41d76 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2788,19 +2788,19 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	if (!blk_mq_get_budget_and_tag(rq))
 		return BLK_STS_RESOURCE;
 	return __blk_mq_issue_directly(hctx, rq, last);
 }
 
-static void blk_mq_plug_issue_direct(struct blk_plug *plug)
+static void blk_mq_issue_direct(struct rq_list *rqs)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
 	struct request *rq;
 	int queued = 0;
 	blk_status_t ret = BLK_STS_OK;
 
-	while ((rq = rq_list_pop(&plug->mq_list))) {
-		bool last = rq_list_empty(&plug->mq_list);
+	while ((rq = rq_list_pop(rqs))) {
+		bool last = rq_list_empty(rqs);
 
 		if (hctx != rq->mq_hctx) {
 			if (hctx) {
 				blk_mq_commit_rqs(hctx, queued, false);
 				queued = 0;
@@ -2827,29 +2827,28 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 out:
 	if (ret != BLK_STS_OK)
 		blk_mq_commit_rqs(hctx, queued, false);
 }
 
-static void __blk_mq_flush_plug_list(struct request_queue *q,
-				     struct blk_plug *plug)
+static void __blk_mq_flush_list(struct request_queue *q, struct rq_list *rqs)
 {
 	if (blk_queue_quiesced(q))
 		return;
-	q->mq_ops->queue_rqs(&plug->mq_list);
+	q->mq_ops->queue_rqs(rqs);
 }
 
-static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
+static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
 {
 	struct blk_mq_hw_ctx *this_hctx = NULL;
 	struct blk_mq_ctx *this_ctx = NULL;
 	struct rq_list requeue_list = {};
 	unsigned int depth = 0;
 	bool is_passthrough = false;
 	LIST_HEAD(list);
 
 	do {
-		struct request *rq = rq_list_pop(&plug->mq_list);
+		struct request *rq = rq_list_pop(rqs);
 
 		if (!this_hctx) {
 			this_hctx = rq->mq_hctx;
 			this_ctx = rq->mq_ctx;
 			is_passthrough = blk_rq_is_passthrough(rq);
@@ -2858,13 +2857,13 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 			rq_list_add_tail(&requeue_list, rq);
 			continue;
 		}
 		list_add_tail(&rq->queuelist, &list);
 		depth++;
-	} while (!rq_list_empty(&plug->mq_list));
+	} while (!rq_list_empty(rqs));
 
-	plug->mq_list = requeue_list;
+	*rqs = requeue_list;
 	trace_block_unplug(this_hctx->queue, depth, !from_sched);
 
 	percpu_ref_get(&this_hctx->queue->q_usage_counter);
 	/* passthrough requests should never be issued to the I/O scheduler */
 	if (is_passthrough) {
@@ -2912,23 +2911,22 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		 * already know at this point that all requests belong to the
 		 * same queue, caller must ensure that's the case.
 		 */
 		if (q->mq_ops->queue_rqs) {
 			blk_mq_run_dispatch_ops(q,
-				__blk_mq_flush_plug_list(q, plug));
+				__blk_mq_flush_list(q, &plug->mq_list));
 			if (rq_list_empty(&plug->mq_list))
 				return;
 		}
 
-		blk_mq_run_dispatch_ops(q,
-				blk_mq_plug_issue_direct(plug));
+		blk_mq_run_dispatch_ops(q, blk_mq_issue_direct(&plug->mq_list));
 		if (rq_list_empty(&plug->mq_list))
 			return;
 	}
 
 	do {
-		blk_mq_dispatch_plug_list(plug, from_schedule);
+		blk_mq_dispatch_list(&plug->mq_list, from_schedule);
 	} while (!rq_list_empty(&plug->mq_list));
 }
 
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 754f6b7415cd..2edf1cac06d5 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -713,11 +713,11 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
 	}
 }
 
 /*
- * Called from blk_mq_insert_request() or blk_mq_dispatch_plug_list().
+ * Called from blk_mq_insert_request() or blk_mq_dispatch_list().
  */
 static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 			       struct list_head *list,
 			       blk_insert_t flags)
 {
-- 
2.45.2

