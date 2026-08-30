Received: from mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417252EB856
	for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052826; cv=none; b=enXRNvTXt36yxWLjvXEdGgnEUMdBH7MNdQdCY5X3qqLOhAdcgFHHudOJj8vc6Nyx9q5zyX1e3ynGs92yKbspuo7KrLew4wx7Uf20xQhHxnIzIPRqjnuqDfHn2SIg2v7iHy6UquOkImTqNIh0rCzxxDL9zJT60c4vb8YCDIS7ngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052826; c=relaxed/simple;
	bh=IFzXOFd5TrUmv1oJ69PwzfP7yslWZ8DlDbTIq3MMXdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adSXjEw3L0mtEDsMgtiu9/z9STG7W7pmu59VfjPdj1L8FIya/QeYTuEkBXm22LUEauGxaqs9cRXU3O5LF8Gzs1jf1KItn6G4BxNYRfg5+oPEqO7cS4eCVYT7jL+ND9qnXxHOll2wXcNH/1JzVnJ7t9Dr8H5M65Cchh1MToDSqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s5HbhGgt; arc=none smtp.client-ip=95.215.58.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s5HbhGgt"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IFzXOFd5TrUmv1oJ69PwzfP7yslWZ8DlDbTIq3MMXdg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788052821; v=1; x=1788657621;
 b=s5HbhGgtBWsr2grzryKEDqwSyrAWPu/WOzwtdylvlcwTZhf2uAs9FokVqbzqLVm3blYV4Fpf
 poUg9GH2eRmULbcIUHuJ2ysreZO+oYDPAlFeSopkSNlHTy4X+83qZRczu1LGeA9LVrONkQbgfoz
 ObQ0srXwy9GtGbFwcQKlkW2U=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ac1466028375361f;
	Sun, 30 Aug 2026 01:20:21 +0000
X-Mizu-Trace-ID: ac1466028375361f
X-Migadu-Flow: FLOW_OUT
From: Md Haris Iqbal <haris.iqbal@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Md Haris Iqbal <haris.iqbal@linux.dev>
Subject: [v2 for-next 2/3] block: allow error injection rules to delay bios
Date: Sun, 30 Aug 2026 03:20:01 +0200
Message-ID: <20260830012002.80275-3-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830012002.80275-1-haris.iqbal@linux.dev>
References: <20260830012002.80275-1-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error injection can only fail a bio today.  Add a delay_us option so that
a rule can hold a bio back first, to model a slow device.

If a matching rule has delay_us set, the bio is held for that long.  It is
then failed if the rule also has a status, or resubmitted below the
injection hook so that the rules are not applied to it again.

Submitting below the hook is not enough on its own.  A bio is split below
the hook, and bio_submit_split_bioset() resubmits the remainder through
submit_bio_noacct_nocheck(), which is above it.  bio_split() advances the
original bio and returns a clone of the front piece, so the remainder is
the same bio on a range the rule still covers and would be delayed once
per split.  Mark a delayed bio with BIO_ERROR_INJECTED instead and skip
the hook for a bio that has it.  __bio_clone() does not propagate the
flag, so the front pieces and the clones a stacking driver aims at a
lower device are still evaluated.

The bio is submitted from a workqueue rather than from the timer, because
submitting a bio can sleep.  Bios with REQ_NOWAIT are never delayed, and
values above 600 seconds are rejected.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 block/blk-core.c          |  13 +++-
 block/blk.h               |   1 +
 block/error-injection.c   | 158 ++++++++++++++++++++++++++++++++++----
 block/error-injection.h   |   1 +
 include/linux/blk_types.h |   1 +
 5 files changed, 155 insertions(+), 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 29c86addb8f2..6ba21fd37b6c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -757,11 +757,8 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 	current->bio_list = NULL;
 }
 
-void submit_bio_noacct_nocheck(struct bio *bio, bool split)
+void __submit_bio_noacct_nocheck(struct bio *bio, bool split)
 {
-	if (unlikely(blk_error_inject(bio)))
-		return;
-
 	blk_cgroup_bio_start(bio);
 
 	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
@@ -791,6 +788,14 @@ void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 	}
 }
 
+void submit_bio_noacct_nocheck(struct bio *bio, bool split)
+{
+	if (unlikely(blk_error_inject(bio)))
+		return;
+
+	__submit_bio_noacct_nocheck(bio, split);
+}
+
 static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
 						 struct bio *bio)
 {
diff --git a/block/blk.h b/block/blk.h
index 8a8ab961528d..389c9a487067 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -61,6 +61,7 @@ bool __blk_freeze_queue_start(struct request_queue *q,
 			      struct task_struct *owner);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio, bool split);
+void __submit_bio_noacct_nocheck(struct bio *bio, bool split);
 int bio_submit_or_kill(struct bio *bio, unsigned int flags);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
diff --git a/block/error-injection.c b/block/error-injection.c
index 41ee8f788bb5..db8384c7c6f9 100644
--- a/block/error-injection.c
+++ b/block/error-injection.c
@@ -6,9 +6,17 @@
 #include <linux/blkdev.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/workqueue.h>
 #include "blk.h"
 #include "error-injection.h"
 
+/*
+ * Cap the delay so that a typo can't wedge a device for good.  This is still
+ * well beyond the default hung task timeout, which is one of the things a
+ * delay is useful for triggering.
+ */
+#define BLK_ERROR_INJECT_MAX_DELAY_US	(600 * USEC_PER_SEC)
+
 struct blk_error_inject {
 	struct list_head		entry;
 	sector_t			start;
@@ -18,14 +26,102 @@ struct blk_error_inject {
 
 	/* only inject every 1 / chance times */
 	unsigned int			chance;
+
+	/* hold the bio for this long before submitting or failing it */
+	unsigned int			delay_us;
 };
 
+/*
+ * A bio held by a delay rule.  This is self-contained on purpose: it does not
+ * point back at the rule, so rules can be removed while delayed bios are
+ * outstanding, and it does not point at the gendisk, so nothing has to be
+ * cleaned up when the disk goes away.  A delayed bio holds no queue usage
+ * counter reference either, so one that outlives its disk is failed by the
+ * GD_DEAD check in __bio_queue_enter() once it is finally submitted.
+ */
+struct blk_error_inject_delay {
+	struct delayed_work		dwork;
+	struct bio			*bio;
+	blk_status_t			status;
+};
+
+static struct workqueue_struct *blk_error_inject_wq;
+
 DEFINE_STATIC_KEY_FALSE(blk_error_injection_enabled);
 
+static void blk_error_inject_delay_work(struct work_struct *work)
+{
+	struct blk_error_inject_delay *d = container_of(to_delayed_work(work),
+			struct blk_error_inject_delay, dwork);
+	struct bio *bio = d->bio;
+	blk_status_t status = d->status;
+
+	kfree(d);
+
+	if (status != BLK_STS_OK) {
+		bio->bi_status = status;
+		bio_endio(bio);
+	} else {
+		/*
+		 * Submit below the injection hook.  Together with
+		 * BIO_ERROR_INJECTED, which also covers the resubmission of
+		 * the remainder of a split, this means a bio that was delayed
+		 * once skips error injection entirely from here on, including
+		 * any other rule that covers it.
+		 */
+		__submit_bio_noacct_nocheck(bio, false);
+	}
+}
+
+/*
+ * Hand the bio to a workqueue that submits or fails it once the delay has
+ * expired.  Both blk_mq_submit_bio() and ->submit_bio can sleep, so this can't
+ * be completed from the timer itself.
+ *
+ * Returns false if the bio can't be delayed, in which case the caller handles
+ * it immediately instead.
+ */
+static bool blk_error_inject_delay(struct gendisk *disk, struct bio *bio,
+		blk_status_t status, unsigned int delay_us)
+{
+	struct blk_error_inject_delay *d;
+
+	/* never block a bio that asked not to be blocked */
+	if (bio->bi_opf & REQ_NOWAIT)
+		return false;
+
+	d = kmalloc_obj(*d, GFP_NOIO);
+	if (!d)
+		return false;
+
+	pr_info_ratelimited("%pg: delaying %s at sector %llu:%u by %uus\n",
+			disk->part0, blk_op_str(bio_op(bio)),
+			bio->bi_iter.bi_sector, bio_sectors(bio), delay_us);
+
+	d->bio = bio;
+	d->status = status;
+	INIT_DELAYED_WORK(&d->dwork, blk_error_inject_delay_work);
+
+	/*
+	 * Mark the bio before queueing the work, which can complete it as soon
+	 * as it is queued.  Splitting happens below the injection hook, but
+	 * bio_submit_split_bioset() resubmits the remainder through the hook
+	 * again, and as bio_split() only advances the original bio that
+	 * remainder still matches the same rule.  Without this a bio would be
+	 * delayed once per split.
+	 */
+	bio_set_flag(bio, BIO_ERROR_INJECTED);
+	queue_delayed_work(blk_error_inject_wq, &d->dwork,
+			usecs_to_jiffies(delay_us));
+	return true;
+}
+
 bool __blk_error_inject(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 	struct blk_error_inject *inj;
+	blk_status_t status = BLK_STS_OK;
+	unsigned int delay_us = 0;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(inj, &disk->error_injection_list, entry) {
@@ -45,29 +141,38 @@ bool __blk_error_inject(struct bio *bio)
 		if (inj->chance > 1 && (get_random_u32() % inj->chance) != 0)
 			continue;
 
-		pr_info_ratelimited("%pg: injecting %s error for %s at sector %llu:%u\n",
-				disk->part0, blk_status_to_str(inj->status),
-				blk_op_str(inj->op), bio->bi_iter.bi_sector,
-				bio_sectors(bio));
-		bio->bi_status = inj->status;
-		rcu_read_unlock();
-		bio_endio(bio);
-		return true;
+		status = inj->status;
+		delay_us = inj->delay_us;
+		break;
 	}
 	rcu_read_unlock();
-	return false;
+
+	if (delay_us && blk_error_inject_delay(disk, bio, status, delay_us))
+		return true;
+	if (status == BLK_STS_OK)
+		return false;
+
+	pr_info_ratelimited("%pg: injecting %s error for %s at sector %llu:%u\n",
+			disk->part0, blk_status_to_str(status),
+			blk_op_str(bio_op(bio)), bio->bi_iter.bi_sector,
+			bio_sectors(bio));
+	bio->bi_status = status;
+	bio_endio(bio);
+	return true;
 }
 
 static int error_inject_add(struct gendisk *disk, enum req_op op,
 		sector_t start, u64 nr_sectors, blk_status_t status,
-		unsigned int chance)
+		unsigned int chance, unsigned int delay_us)
 {
 	struct blk_error_inject *inj;
 	int error = -EINVAL;
 
 	if (op == REQ_OP_LAST)
 		return -EINVAL;
-	if (status == BLK_STS_OK)
+	if (status == BLK_STS_OK && !delay_us)
+		return -EINVAL;
+	if (delay_us > BLK_ERROR_INJECT_MAX_DELAY_US)
 		return -EINVAL;
 
 	inj = kzalloc_obj(*inj);
@@ -86,6 +191,7 @@ static int error_inject_add(struct gendisk *disk, enum req_op op,
 	inj->start = start;
 	inj->status = status;
 	inj->chance = chance;
+	inj->delay_us = delay_us;
 
 	pr_debug_ratelimited("%pg: adding %s injection for %s at sector %llu:%llu\n",
 			disk->part0, blk_status_to_str(status),
@@ -139,6 +245,7 @@ enum options {
 	Opt_nr_sectors		= (1u << 18),
 	Opt_status		= (1u << 19),
 	Opt_chance		= (1u << 20),
+	Opt_delay_us		= (1u << 21),
 
 	Opt_invalid,
 };
@@ -151,6 +258,7 @@ static const match_table_t opt_tokens = {
 	{ Opt_nr_sectors,		"nr_sectors=%u"		},
 	{ Opt_status,			"status=%s"		},
 	{ Opt_chance,			"chance=%u"		},
+	{ Opt_delay_us,			"delay_us=%u"		},
 	{ Opt_invalid,			NULL,			},
 };
 
@@ -187,7 +295,7 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 		char *options)
 {
 	enum { Unset, Add, Removeall } action = Unset;
-	unsigned int option_mask = 0, chance = 1;
+	unsigned int option_mask = 0, chance = 1, delay_us = 0;
 	enum req_op op = REQ_OP_LAST;
 	u64 start = 0, nr_sectors = 0;
 	blk_status_t status = BLK_STS_OK;
@@ -230,6 +338,9 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 			if (!error && chance == 0)
 				error = -EINVAL;
 			break;
+		case Opt_delay_us:
+			error = match_uint(args, &delay_us);
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s'\n", p);
 			error = -EINVAL;
@@ -241,7 +352,7 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 	switch (action) {
 	case Add:
 		return error_inject_add(disk, op, start, nr_sectors, status,
-				chance);
+				chance, delay_us);
 	case Removeall:
 		if (option_mask & ~Opt_removeall)
 			return -EINVAL;
@@ -277,10 +388,11 @@ static int blk_error_injection_show(struct seq_file *s, void *private)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(inj, &disk->error_injection_list, entry) {
-		seq_printf(s, "%llu:%llu op=%s,status=%s,chance=%u",
+		seq_printf(s, "%llu:%llu op=%s,status=%s,chance=%u,delay_us=%u",
 			   inj->start, inj->end,
 			   blk_op_str(inj->op),
-			   blk_status_to_tag(inj->status), inj->chance);
+			   blk_status_to_tag(inj->status), inj->chance,
+			   inj->delay_us);
 		seq_putc(s, '\n');
 	}
 	rcu_read_unlock();
@@ -315,3 +427,19 @@ void blk_error_injection_exit(struct gendisk *disk)
 {
 	error_inject_removeall(disk);
 }
+
+static int __init blk_error_injection_init_wq(void)
+{
+	/*
+	 * WQ_MEM_RECLAIM so that a delayed bio on the reclaim path can still
+	 * find a worker under memory pressure.  Note that this only guarantees
+	 * a worker exists, not that it is free: submitting a bio can block on
+	 * a queue freeze or on tag allocation, so a delayed bio can still be
+	 * held up behind another one.
+	 */
+	blk_error_inject_wq = alloc_workqueue("blk_error_inject", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!blk_error_inject_wq)
+		panic("Failed to create blk_error_inject wq\n");
+	return 0;
+}
+subsys_initcall(blk_error_injection_init_wq);
diff --git a/block/error-injection.h b/block/error-injection.h
index 9821d773abab..8b3809d85e83 100644
--- a/block/error-injection.h
+++ b/block/error-injection.h
@@ -13,6 +13,7 @@ static inline bool blk_error_inject(struct bio *bio)
 {
 	if (IS_ENABLED(CONFIG_BLK_ERROR_INJECTION) &&
 	    static_branch_unlikely(&blk_error_injection_enabled) &&
+	    !bio_flagged(bio, BIO_ERROR_INJECTED) &&
 	    test_bit(GD_ERROR_INJECT, &bio->bi_bdev->bd_disk->state))
 		return __blk_error_inject(bio);
 	return false;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 98e21b4cbf32..50e28dc0f1f9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -323,6 +323,7 @@ enum {
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
 	BIO_COMPLETE_IN_TASK, /* complete bi_end_io() in task context */
+	BIO_ERROR_INJECTED, /* error injection rules already applied */
 	BIO_FLAG_LAST
 };
 
-- 
2.53.0

