Received: from mta1.migadu.com (out-66.mta1.migadu.com [95.215.58.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A1502D62
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633821; cv=none; b=TLSj/NzjP2i9uGQ3DQFGDXaJjJFHVWBPM7teu8EZYlvFNyq6zn9tKWYw8iLq/E7YGELcLu4w3KhbvhLqt/SsIaVhN+RXYJaRfcvt1C8NYgiN7+1NpsjRly/yah8hXjgYxX0JNLV67iwiDMcahfrhZCbIJMI2uaOHT4gqGC2wUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633821; c=relaxed/simple;
	bh=GO9c39zwxNtHYM5ojU3Vm5kQid4mc4U4iWe7g+cxg9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5ktZxyIuhKcw8UDMYq6zO2d5UTO7eJXmBFssARfPO3sm4Cl4laoH+hlHSF+LRdlbxNOhz6UuG/tOH71WSms9wyT1a9Xdos6kFnZAoQWdI/jpL4FXeFf3esSo1NtKluiR9mCdg59TmbWA30sXH5JzchdH8qkL2RbL/Xw1mX+CgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hsZqj66V; arc=none smtp.client-ip=95.215.58.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hsZqj66V"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GO9c39zwxNtHYM5ojU3Vm5kQid4mc4U4iWe7g+cxg9w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790633816; v=1; x=1791238616;
 b=hsZqj66VNhUkqt2HNVZYObFaBE9+G2KJhwp8daEWoqrJnhOy3sfZWCIUZrSuy0blJzQF5wyr
 Q7yyfMIMCgRdGKhlEQedgg1ayQBJ5srCmeOQUuHod0VsX9eXNLvAtJ44UDY7WLM4EM9hLIKhxoQ
 BkMRnUKZpVJ3T7e0pJ9keL5w=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 343289c898e093dd;
	Mon, 28 Sep 2026 22:16:56 +0000
X-Mizu-Trace-ID: 343289c898e093dd
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
Subject: [v3 for-next 2/3] block: allow error injection rules to delay bios
Date: Tue, 29 Sep 2026 00:16:33 +0200
Message-ID: <20260928221634.43239-3-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928221634.43239-1-haris.iqbal@linux.dev>
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error injection can only fail a bio today. Add a delay_us option so that
a rule can hold a bio back first, to model a slow device.

If a matching rule has delay_us set, the bio is held for that long. It is
then failed if the rule also has a status, or resubmitted otherwise.

The resubmission is done through submit_bio_noacct_nocheck(), which is
where the injection hook sits. To avoid the same delay rule being applied
to it again, mark the bio with the BIO_ERROR_INJECTED flag before queueing
the work in blk_error_inject_delay(). This also prevents bios that are
split later and resubmitted from being evaluated for delay (or error
injection) again. __bio_clone() does not propagate the flag, so a clone a
stacking driver aims at a lower device is still evaluated.

The bio is submitted from a workqueue rather than from the timer, because
submitting a bio can sleep. Bios with REQ_NOWAIT are never delayed, and
values above 600 seconds are rejected.

Cc: Christoph Hellwig <hch@lst.de>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 block/error-injection.c   | 160 ++++++++++++++++++++++++++++++++++----
 block/error-injection.h   |   1 +
 include/linux/blk_types.h |   1 +
 3 files changed, 147 insertions(+), 15 deletions(-)

diff --git a/block/error-injection.c b/block/error-injection.c
index db543fe27630..a35fe41a43e4 100644
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
@@ -18,14 +26,104 @@ struct blk_error_inject {
 
 	/* only inject every 1 / chance times */
 	unsigned int			chance;
+
+	/* hold the bio for this long before submitting or failing it */
+	unsigned int			delay_us;
+};
+
+/*
+ * A bio held by a delay rule.  It does not point back at the rule, so rules
+ * can be removed while delayed bios are outstanding.  The submitter holds the
+ * bdev open until the bio completes, so the disk and queue stay allocated.
+ * A delayed bio holds no queue usage counter reference, so it does not hold
+ * up a queue freeze either.
+ */
+struct blk_error_inject_delay {
+	struct delayed_work		dwork;
+	struct bio			*bio;
+	blk_status_t			status;
 };
 
+static struct workqueue_struct *blk_error_inject_wq;
+
 DEFINE_STATIC_KEY_FALSE(blk_error_injection_enabled);
 
+static void blk_error_inject_delay_work(struct work_struct *work)
+{
+	struct blk_error_inject_delay *d = container_of(to_delayed_work(work),
+			struct blk_error_inject_delay, dwork);
+	struct bio *bio = d->bio;
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	blk_status_t status = d->status;
+
+	kfree(d);
+
+	if (status != BLK_STS_OK) {
+		pr_info_ratelimited("%pg: injecting %s error for %s at sector %llu:%u\n",
+				disk->part0, blk_status_to_str(status),
+				blk_op_str(bio_op(bio)), bio->bi_iter.bi_sector,
+				bio_sectors(bio));
+		bio->bi_status = status;
+		bio_endio(bio);
+	} else {
+		/*
+		 * Resubmit.  The BIO_ERROR_INJECTED flag ensures that a bio
+		 * that was delayed once skips error injection entirely from
+		 * here on, including any other rule that covers it.
+		 */
+		submit_bio_noacct_nocheck(bio, false);
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
@@ -45,29 +143,38 @@ bool __blk_error_inject(struct bio *bio)
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
@@ -86,6 +193,7 @@ static int error_inject_add(struct gendisk *disk, enum req_op op,
 	inj->start = start;
 	inj->status = status;
 	inj->chance = chance;
+	inj->delay_us = delay_us;
 
 	pr_debug_ratelimited("%pg: adding %s injection for %s at sector %llu:%llu\n",
 			disk->part0, blk_status_to_str(status),
@@ -139,6 +247,7 @@ enum options {
 	Opt_nr_sectors		= (1u << 18),
 	Opt_status		= (1u << 19),
 	Opt_chance		= (1u << 20),
+	Opt_delay_us		= (1u << 21),
 
 	Opt_invalid,
 };
@@ -151,6 +260,7 @@ static const match_table_t opt_tokens = {
 	{ Opt_nr_sectors,		"nr_sectors=%u"		},
 	{ Opt_status,			"status=%s"		},
 	{ Opt_chance,			"chance=%u"		},
+	{ Opt_delay_us,			"delay_us=%u"		},
 	{ Opt_invalid,			NULL,			},
 };
 
@@ -187,7 +297,7 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 		char *options)
 {
 	enum { Unset, Add, Removeall } action = Unset;
-	unsigned int option_mask = 0, chance = 1;
+	unsigned int option_mask = 0, chance = 1, delay_us = 0;
 	enum req_op op = REQ_OP_LAST;
 	u64 start = 0, nr_sectors = 0;
 	blk_status_t status = BLK_STS_OK;
@@ -230,6 +340,9 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 			if (!error && chance == 0)
 				error = -EINVAL;
 			break;
+		case Opt_delay_us:
+			error = match_uint(args, &delay_us);
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s'\n", p);
 			error = -EINVAL;
@@ -241,7 +354,7 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 	switch (action) {
 	case Add:
 		return error_inject_add(disk, op, start, nr_sectors, status,
-				chance);
+				chance, delay_us);
 	case Removeall:
 		if (option_mask & ~Opt_removeall)
 			return -EINVAL;
@@ -277,10 +390,11 @@ static int blk_error_injection_show(struct seq_file *s, void *private)
 
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
@@ -315,3 +429,19 @@ void blk_error_injection_exit(struct gendisk *disk)
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

