Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE6134CF
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604758; cv=none; b=Cm8hrxeFLtiOTeq12FHczq/3yWUTBkH9npPSViYmEOJjoEJ8BaULJp31hMeQsY9aX4pWfI5O+xKHTvO4WW/LMdyVh6pqCZ1jQEssnNcH6VivYyVsJe9jVkkQjwKUCPZKGEAajlvNRbs4O0OBgtqKyVG7Y/a7mEmFJSm6ZNYVpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604758; c=relaxed/simple;
	bh=Py7gwV5nJwef16fCU/CwzoX88xDsSUbfm/bLipqX82U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLKJkxYe9aOkeFweVTibAaFHbolWgD1Ioq3xfFmqT5uPRKxMBYgMad+U4mAjBxV6DodeNuXhAzAA0xIjNhGYcuy7V5Z+PVDDu/Xmp2mv2VmzGjox+D1Zeufh+K+/nmMdmkqEbr/yFDOkGtXKbHVr7DTqVD7xn+odw5OenH0tiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D81F368BEB; Fri, 25 Apr 2025 20:12:27 +0200 (CEST)
Date: Fri, 25 Apr 2025 20:12:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 09/20] block: simplify elevator reattachment for
 updating nr_hw_queues
Message-ID: <20250425181227.GA25925@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com> <20250424152148.1066220-10-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20250424152148.1066220-10-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2025 at 11:21:32PM +0800, Ming Lei wrote:
> +static int __elevator_change(struct request_queue *q,
> +			     const char *elevator_name)

There's still not good reason for this helper.

I'd suggest you add the two first attached patches before this one
(it'll need a bi of reabsing as all of them are after your entire
sweries right now) and then fold the third one into this, which will
give us less code and a cleaner interface.


--liOOAslEiF7prFVr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-block-look-up-the-elevator-type-in-elevator_switch.patch"

From 44da16a97ef758d1d9fe7c54c8360388f585d0c5 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 25 Apr 2025 07:01:39 -0700
Subject: block: look up the elevator type in elevator_switch

That makes the function nicely self-contained and can be used
to avoid code duplication.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index a637426da56d..773b8931d874 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -591,14 +591,18 @@ static bool use_default_elevator(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
-			   struct elv_change_ctx *ctx)
+static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 {
+	struct elevator_type *new_e;
 	int ret;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
+	new_e = elevator_find_get(ctx->name);
+	if (!new_e)
+		return -EINVAL;
+
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
@@ -621,6 +625,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 			new_e->elevator_name);
 	}
 
+	elevator_put(new_e);
 	return ret;
 }
 
@@ -686,8 +691,6 @@ static int __elevator_change(struct request_queue *q,
 			     struct elv_change_ctx *ctx)
 {
 	const char *elevator_name = ctx->name;
-	struct elevator_type *e;
-	int ret;
 
 	lockdep_assert_held(&q->tag_set->update_nr_hwq_sema);
 
@@ -701,12 +704,7 @@ static int __elevator_change(struct request_queue *q,
 		return 0;
 	}
 
-	e = elevator_find_get(elevator_name);
-	if (!e)
-		return -EINVAL;
-	ret = elevator_switch(q, e, ctx);
-	elevator_put(e);
-	return ret;
+	return elevator_switch(q, ctx);
 }
 
 static int elevator_change(struct request_queue *q,
-- 
2.47.2


--liOOAslEiF7prFVr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-block-fold-elevator_disable-into-elevator_switch.patch"

From 1bfce1a308b9e46734ed56196b4e9fe31b5a0036 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 25 Apr 2025 07:10:35 -0700
Subject: block: fold elevator_disable into elevator_switch

This removes duplicate code, and keeps the callers tidy.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 59 ++++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 773b8931d874..59ff0abde920 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -593,15 +593,17 @@ static bool use_default_elevator(struct request_queue *q)
  */
 static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 {
-	struct elevator_type *new_e;
-	int ret;
+	struct elevator_type *new_e = NULL;
+	int ret = 0;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
-	new_e = elevator_find_get(ctx->name);
-	if (!new_e)
-		return -EINVAL;
+	if (strncmp(ctx->name, "none", 4)) {
+		new_e = elevator_find_get(ctx->name);
+		if (!new_e)
+			return -EINVAL;
+	}
 
 	blk_mq_quiesce_queue(q);
 
@@ -610,12 +612,17 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 		__elevator_exit(q);
 	}
 
-	ret = blk_mq_init_sched(q, new_e);
-	if (ret)
-		goto out_unfreeze;
-
-	ctx->new = q->elevator;
-	blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
+	if (new_e) {
+		ret = blk_mq_init_sched(q, new_e);
+		if (ret)
+			goto out_unfreeze;
+		ctx->new = q->elevator;
+	} else {
+		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
+		q->elevator = NULL;
+		q->nr_requests = q->tag_set->queue_depth;
+	}
+	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
 
 out_unfreeze:
 	blk_mq_unquiesce_queue(q);
@@ -625,28 +632,11 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 			new_e->elevator_name);
 	}
 
-	elevator_put(new_e);
+	if (new_e)
+		elevator_put(new_e);
 	return ret;
 }
 
-static void elevator_disable(struct request_queue *q,
-			     struct elv_change_ctx *ctx)
-{
-	WARN_ON_ONCE(q->mq_freeze_depth == 0);
-	lockdep_assert_held(&q->elevator_lock);
-
-	blk_mq_quiesce_queue(q);
-
-	ctx->old = q->elevator;
-	__elevator_exit(q);
-	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
-	q->elevator = NULL;
-	q->nr_requests = q->tag_set->queue_depth;
-	blk_add_trace_msg(q, "elv switch: none");
-
-	blk_mq_unquiesce_queue(q);
-}
-
 static void elv_exit_and_release(struct request_queue *q)
 {
 	struct elevator_queue *e;
@@ -690,20 +680,11 @@ static int elevator_change_done(struct request_queue *q,
 static int __elevator_change(struct request_queue *q,
 			     struct elv_change_ctx *ctx)
 {
-	const char *elevator_name = ctx->name;
-
 	lockdep_assert_held(&q->tag_set->update_nr_hwq_sema);
 
 	/* Make sure queue is not in the middle of being removed */
 	if (!ctx->init && !blk_queue_registered(q))
 		return -ENOENT;
-
-	if (!strncmp(elevator_name, "none", 4)) {
-		if (q->elevator)
-			elevator_disable(q, ctx);
-		return 0;
-	}
-
 	return elevator_switch(q, ctx);
 }
 
-- 
2.47.2


--liOOAslEiF7prFVr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0003-block-remove-__elevator_change.patch"

From dcda3f508e5f938cb27d4b743226ca4d8af75e28 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 25 Apr 2025 07:18:42 -0700
Subject: block: remove __elevator_change

Not much of a point in sharing code between callers with very different
expectations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 59ff0abde920..b358858387a0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -674,25 +674,13 @@ static int elevator_change_done(struct request_queue *q,
 	return ret;
 }
 
-/*
- * Switch this queue to the given IO scheduler.
- */
-static int __elevator_change(struct request_queue *q,
-			     struct elv_change_ctx *ctx)
-{
-	lockdep_assert_held(&q->tag_set->update_nr_hwq_sema);
-
-	/* Make sure queue is not in the middle of being removed */
-	if (!ctx->init && !blk_queue_registered(q))
-		return -ENOENT;
-	return elevator_switch(q, ctx);
-}
-
 static int elevator_change(struct request_queue *q,
 			   struct elv_change_ctx *ctx)
 {
 	unsigned int memflags;
-	int ret = 0;
+	int ret;
+
+	lockdep_assert_held(&q->tag_set->update_nr_hwq_sema);
 
 	memflags = blk_mq_freeze_queue(q);
 	/*
@@ -706,14 +694,20 @@ static int elevator_change(struct request_queue *q,
 	 */
 	blk_mq_cancel_work_sync(q);
 	mutex_lock(&q->elevator_lock);
-	if (!q->elevator || !elevator_match(q->elevator->type, ctx->name))
-		ret = __elevator_change(q, ctx);
+	/* Make sure queue is not in the middle of being removed */
+	ret = -ENOENT;
+	if (!ctx->init && !blk_queue_registered(q))
+		goto out_unlock;
+	ret = 0;
+	if (q->elevator && elevator_match(q->elevator->type, ctx->name))
+		goto out_unlock;
+	ret = elevator_switch(q, ctx);
+out_unlock:
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	if (!ret)
-		ret = elevator_change_done(q, ctx);
-
-	return ret;
+	if (ret)
+		return ret;
+	return elevator_change_done(q, ctx);
 }
 
 /*
@@ -768,17 +762,18 @@ void elevator_set_none(struct request_queue *q)
 void elv_update_nr_hw_queues(struct request_queue *q)
 {
 	struct elv_change_ctx ctx = {
-		.name	= "none",
 		.uevent	= true,
 	};
-	int ret = -ENODEV;
+	int ret = -ENOENT;
 
+	lockdep_assert_held(&q->tag_set->update_nr_hwq_sema);
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
 	mutex_lock(&q->elevator_lock);
-	if (q->elevator && !blk_queue_dying(q))
+	if (blk_queue_registered(q) && !blk_queue_dying(q) && q->elevator) {
 		ctx.name = q->elevator->type->elevator_name;
-	ret = __elevator_change(q, &ctx);
+		ret = elevator_switch(q, &ctx);
+	}
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue_nomemrestore(q);
 
-- 
2.47.2


--liOOAslEiF7prFVr--
