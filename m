Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91228F1
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392222; cv=none; b=Hdnb0WoZcQzt9vbdmAeMFIEgtKow6fLXghK8JNEEbYpIkSPQaZI1qja65g5Rvgt0IpDxFMQ3MLPFa8EqnoZ0JRm1vZrokGS1bb/L5Pc2mB9K1hNozZOPviFS2x9arEOui1mCF1IhIHU31bjWENXrkoJHjjMqPn4q5ePbwx3e+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392222; c=relaxed/simple;
	bh=0lUVOsENCGxVRM/+oxZBabVfGZxg3kxDOGRpKVT5A5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMg26OkbuhDoFKgyYsMIwP44kwM9U61oTeps+Nk/vfvGPORLrt6esvTpnosWOxp9SXbeYxUscxqh5unWYlxtKVIBvotsnC/HPMurA6ASumQt+6+nfeTeDEtcHgLAwxxSjtR4XD/R595gMIEfPCCDRsnpMwz29oFIFAlsOQxssdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2321168AFE; Wed, 23 Apr 2025 09:10:13 +0200 (CEST)
Date: Wed, 23 Apr 2025 09:10:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V2 12/20] block: add `struct elv_change_ctx` for
 unifying elevator_change
Message-ID: <20250423071012.GA24699@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com> <20250418163708.442085-13-ming.lei@redhat.com> <20250422070739.GC30990@lst.de> <aAdU-LSFxLTcwwnZ@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <aAdU-LSFxLTcwwnZ@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2025 at 04:36:08PM +0800, Ming Lei wrote:
> Please see the following patch of 'block: move elv_register[unregister]_queue out of elevator_lock'
> in which elevator_change_done() has to be added, then the context structure
> can't be kept as private any more.

It can.  See the attached first patch.  The second patch then cleans
things up further so that we don't need the force flag or
__elevator_change.

> > 
> > Also please use a flags value with named flags instead of the various
> > booleans.
> 
> 'struct elv_change_ctx' has to be parameter, so it doesn't matter to
> use flags value any more, and 'bool' should be easier.

It's still much more readable to have flags.  Especially to discover
and document how init and uevent are related, which seems rather
confusing at the moment.


--IS0zKkzwUGydFO0o
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-block-make-struct-elv_change_ctx-private-in-elevator.patch"

From a41e07a5c401f8a73d622e670881f79b7636baf6 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 23 Apr 2025 08:38:23 +0200
Subject: block: make struct elv_change_ctx private in elevator.c

And add a helper for the nr_hw_queues update instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c   | 23 ++---------------------
 block/blk.h      |  4 +---
 block/elevator.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 block/elevator.h | 13 -------------
 4 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5c9f7391af92..61d3349b3bb3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4968,27 +4968,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_map_swqueue(q);
 	}
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		/*
-		 * nr_hw_queues is changed and elevator data depends on
-		 * it, so we have to force to rebuild elevator
-		 */
-		struct elv_change_ctx ctx = {
-			.name	= "none",
-			.force	= true,
-			.uevent	= true,
-		};
-		int ret = -ENODEV;
-
-		mutex_lock(&q->elevator_lock);
-		if (q->elevator && !blk_queue_dying(q))
-			ctx.name = q->elevator->type->elevator_name;
-		ret = __elevator_change(q, &ctx);
-		mutex_unlock(&q->elevator_lock);
-		blk_mq_unfreeze_queue_nomemrestore(q);
-		if (!ret)
-			WARN_ON_ONCE(elevator_change_done(q, &ctx));
-	}
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		elv_update_nr_hw_queues(q);
 	memalloc_noio_restore(memflags);
 
 reregister:
diff --git a/block/blk.h b/block/blk.h
index 48cf6b1c36fe..6ba674d1ceba 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -12,7 +12,6 @@
 #include "blk-crypto-internal.h"
 
 struct elevator_type;
-struct elv_change_ctx;
 
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
 #define	BLK_MIN_SEGMENT_SIZE	4096
@@ -320,10 +319,9 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-int __elevator_change(struct request_queue *q, struct elv_change_ctx *ctx);
+void elv_update_nr_hw_queues(struct request_queue *q);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
-int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx);
 
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
diff --git a/block/elevator.c b/block/elevator.c
index 378553fce5d8..71329a73bb44 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -53,6 +53,19 @@ static LIST_HEAD(elv_list);
  */
 #define rq_hash_key(rq)		(blk_rq_pos(rq) + blk_rq_sectors(rq))
 
+/* Holding context data for changing elevator */
+struct elv_change_ctx {
+	const char *name;
+	bool force;
+	bool uevent;
+	bool init;
+
+	/* for unregistering old elevator */
+	struct elevator_queue *old;
+	/* for registering new elevator */
+	struct elevator_queue *new;
+};
+
 static int elevator_change(struct request_queue *q,
 			   struct elv_change_ctx *ctx);
 
@@ -682,7 +695,8 @@ static void elevator_disable(struct request_queue *q,
 	blk_mq_unquiesce_queue(q);
 }
 
-int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
+static int elevator_change_done(struct request_queue *q,
+		struct elv_change_ctx *ctx)
 {
 	int ret = 0;
 
@@ -712,7 +726,8 @@ int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
 /*
  * Switch this queue to the given IO scheduler.
  */
-int __elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
+static int __elevator_change(struct request_queue *q,
+		struct elv_change_ctx *ctx)
 {
 	const char *elevator_name = ctx->name;
 	struct elevator_type *e;
@@ -740,6 +755,31 @@ int __elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	return ret;
 }
 
+/*
+ * The I/O scheduler depends on the number of hardware queues, this forces a
+ * reattachment when nr_hw_queues changes.
+ *
+ * Note that this unfreezes the passed in queue.
+ */
+void elv_update_nr_hw_queues(struct request_queue *q)
+{
+	struct elv_change_ctx ctx = {
+		.name	= "none",
+		.force	= true,
+		.uevent	= true,
+	};
+	int ret;
+
+	mutex_lock(&q->elevator_lock);
+	if (q->elevator && !blk_queue_dying(q))
+		ctx.name = q->elevator->type->elevator_name;
+	ret = __elevator_change(q, &ctx);
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue_nomemrestore(q);
+	if (!ret)
+		WARN_ON_ONCE(elevator_change_done(q, &ctx));
+}
+
 static int elevator_change(struct request_queue *q,
 			   struct elv_change_ctx *ctx)
 {
diff --git a/block/elevator.h b/block/elevator.h
index b14c611c74b6..a07ce773a38f 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -124,19 +124,6 @@ struct elevator_queue
 #define ELEVATOR_FLAG_DYING		1
 #define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
 
-/* Holding context data for changing elevator */
-struct elv_change_ctx {
-	const char *name;
-	bool force;
-	bool uevent;
-	bool init;
-
-	/* for unregistering old elevator */
-	struct elevator_queue *old;
-	/* for registering new elevator */
-	struct elevator_queue *new;
-};
-
 /*
  * block elevator interface
  */
-- 
2.47.2


--IS0zKkzwUGydFO0o
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-block-remove-__elevator_change.patch"

From c0f7a6a6ed84a83ec4f1e7459b1715bcd612470f Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 23 Apr 2025 08:53:08 +0200
Subject: block: remove __elevator_change

elv_update_nr_hw_queues is very different from the other elevator
change cases, so open code the logic there.  Move the lookup of the
elevator type into elevator_switch to simplify this a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 73 ++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 71329a73bb44..e51f7b8bad16 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -56,7 +56,6 @@ static LIST_HEAD(elv_list);
 /* Holding context data for changing elevator */
 struct elv_change_ctx {
 	const char *name;
-	bool force;
 	bool uevent;
 	bool init;
 
@@ -644,11 +643,15 @@ void elevator_set_none(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
-			   struct elv_change_ctx *ctx)
+static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 {
+	struct elevator_type *new_e;
 	int ret;
 
+	new_e = elevator_find_get(ctx->name);
+	if (!new_e)
+		return -EINVAL;
+
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
@@ -674,6 +677,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 			new_e->elevator_name);
 	}
 
+	elevator_put(new_e);
 	return ret;
 }
 
@@ -723,38 +727,6 @@ static int elevator_change_done(struct request_queue *q,
 	return 0;
 }
 
-/*
- * Switch this queue to the given IO scheduler.
- */
-static int __elevator_change(struct request_queue *q,
-		struct elv_change_ctx *ctx)
-{
-	const char *elevator_name = ctx->name;
-	struct elevator_type *e;
-	int ret;
-
-	/* Make sure queue is not in the middle of being removed */
-	if (!ctx->init && !blk_queue_registered(q))
-		return -ENOENT;
-
-	if (!strncmp(elevator_name, "none", 4)) {
-		if (q->elevator)
-			elevator_disable(q, ctx);
-		return 0;
-	}
-
-	if (!ctx->force && q->elevator &&
-	    elevator_match(q->elevator->type, elevator_name))
-		return 0;
-
-	e = elevator_find_get(elevator_name);
-	if (!e)
-		return -EINVAL;
-	ret = elevator_switch(q, e, ctx);
-	elevator_put(e);
-	return ret;
-}
-
 /*
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
@@ -764,19 +736,25 @@ static int __elevator_change(struct request_queue *q,
 void elv_update_nr_hw_queues(struct request_queue *q)
 {
 	struct elv_change_ctx ctx = {
-		.name	= "none",
-		.force	= true,
 		.uevent	= true,
 	};
-	int ret;
+	bool done = false;
 
 	mutex_lock(&q->elevator_lock);
-	if (q->elevator && !blk_queue_dying(q))
+	if (!blk_queue_registered(q))
+		goto out_unlock;
+
+	if (q->elevator) {
 		ctx.name = q->elevator->type->elevator_name;
-	ret = __elevator_change(q, &ctx);
+		if (elevator_switch(q, &ctx) == 0)
+			done = true;
+	}
+
+out_unlock:
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue_nomemrestore(q);
-	if (!ret)
+
+	if (done)
 		WARN_ON_ONCE(elevator_change_done(q, &ctx));
 }
 
@@ -785,7 +763,7 @@ static int elevator_change(struct request_queue *q,
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	unsigned int memflags;
-	int ret, idx;
+	int ret = 0, idx;
 
 	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
 	if (set->updating_nr_hwq) {
@@ -805,7 +783,16 @@ static int elevator_change(struct request_queue *q,
 	 */
 	blk_mq_cancel_work_sync(q);
 	mutex_lock(&q->elevator_lock);
-	ret = __elevator_change(q, ctx);
+	/* Make sure queue is not in the middle of being removed */
+	if (!ctx->init && !blk_queue_registered(q)) {
+		ret = -ENOENT;
+	} else if (!strncmp(ctx->name, "none", 4)) {
+		if (q->elevator)
+			elevator_disable(q, ctx);
+	} else if (!q->elevator ||
+		   !elevator_match(q->elevator->type, ctx->name)) {
+		ret = elevator_switch(q, ctx);
+	}
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
-- 
2.47.2


--IS0zKkzwUGydFO0o--
