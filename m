Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840AA2D
	for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d8923fe26bso743089b3a.0
        for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 13:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702934054; x=1703538854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaCtVjkh9mRRgN4leLEKJEwOg3CZP8s0yWPlO2ojdSI=;
        b=BVdKN6ZrVUbE7MLfMVvf9Ls+GhGW90n2brXojQo3OGfV/bELhb9rNb7uPLKfZqJUhX
         u/nfgRQ0hQ6yaq0qTdFHZApU7bPtD8XIYkbytRTGnBEm5NUZVfHAaoz2CI8d0/eyE2lI
         tCllfkI+4Xcy9R2niWKAmdazJYrIASGlS68+E3f49Jxeq5KmjeWitHkAEZBod7IKYcRn
         A5VUpkBvFA+66jxodhFOPCeIpO70VwQjFnCdenm/zulv4LOqFTCw0YA3/bTPnkw2Mft2
         yoX78TQkLDxou19sr3jlzfzSDDciewz14fADoszMf/2/2Ba3gExE8FpFkWG1N2DW1S93
         idfQ==
X-Gm-Message-State: AOJu0YyxWK0NDrBdLNg6vHB9S4kBL2W9ihLI05ZWXNODk/Z6d09BvFMq
	IMFEIOXGidu/7sL++Ps+jGrgb4af1Jc=
X-Google-Smtp-Source: AGHT+IG8jDpf0zG23U72An4NnkSfdATr8q7DlKUbZAs/e1/ZdUDhvBXVd1N2pn9sfyk/zFIVfW5dVQ==
X-Received: by 2002:aa7:8881:0:b0:6cd:faa6:fc36 with SMTP id z1-20020aa78881000000b006cdfaa6fc36mr10511758pfe.30.1702934054259;
        Mon, 18 Dec 2023 13:14:14 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78811000000b006c320b9897fsm3371497pfo.126.2023.12.18.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:14:13 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 1/4] block/mq-deadline: Rename dd_rq_ioclass() and change its return type
Date: Mon, 18 Dec 2023 13:13:39 -0800
Message-ID: <20231218211342.2179689-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218211342.2179689-1-bvanassche@acm.org>
References: <20231218211342.2179689-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All dd_rq_ioclass() callers convert the return value into type enum
dd_prio. Move this conversion into dd_rq_ioclass() and rename this
function. Move the definition of this function. Introduce an additional
caller. No functionality is changed by this patch.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..8e5f71775cf1 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -119,15 +119,6 @@ deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
 	return &per_prio->sort_list[rq_data_dir(rq)];
 }
 
-/*
- * Returns the I/O priority class (IOPRIO_CLASS_*) that has been assigned to a
- * request.
- */
-static u8 dd_rq_ioclass(struct request *rq)
-{
-	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
-}
-
 /*
  * get the request before `rq' in sector-sorted order
  */
@@ -190,6 +181,15 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 	return res;
 }
 
+/*
+ * Returns the I/O priority class (IOPRIO_CLASS_*) that has been assigned to a
+ * request.
+ */
+static enum dd_prio dd_rq_ioprio(struct request *rq)
+{
+	return ioprio_class_to_prio[IOPRIO_PRIO_CLASS(req_get_ioprio(rq))];
+}
+
 static void
 deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
 {
@@ -228,8 +228,7 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
 			      enum elv_merge type)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(req);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	const enum dd_prio prio = dd_rq_ioprio(req);
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
 	/*
@@ -248,8 +247,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 			       struct request *next)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(next);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	const enum dd_prio prio = dd_rq_ioprio(next);
 
 	lockdep_assert_held(&dd->lock);
 
@@ -447,7 +445,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
 	enum dd_prio prio;
-	u8 ioprio_class;
 
 	lockdep_assert_held(&dd->lock);
 
@@ -545,8 +542,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching++;
 	deadline_move_request(dd, per_prio, rq);
 done:
-	ioprio_class = dd_rq_ioclass(rq);
-	prio = ioprio_class_to_prio[ioprio_class];
+	prio = dd_rq_ioprio(rq);
 	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
 	dd->per_prio[prio].stats.dispatched++;
 	/*
@@ -798,8 +794,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const enum dd_data_dir data_dir = rq_data_dir(rq);
-	u16 ioprio = req_get_ioprio(rq);
-	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
 
@@ -811,7 +805,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 */
 	blk_req_zone_write_unlock(rq);
 
-	prio = ioprio_class_to_prio[ioprio_class];
+	prio = dd_rq_ioprio(rq);
 	per_prio = &dd->per_prio[prio];
 	if (!rq->elv.priv[0]) {
 		per_prio->stats.inserted++;
@@ -920,8 +914,7 @@ static void dd_finish_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(rq);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	const enum dd_prio prio = dd_rq_ioprio(rq);
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
 	/*
