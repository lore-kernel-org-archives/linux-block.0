Received: from mta0.migadu.com (out-169.mta0.migadu.com [91.218.175.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBB126C02
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787788895; cv=none; b=BVny1UIdD7LJqCKK4sEnqlsBpok41ThF6ZavE7MgmpMkF1s4m7yszgErMYZR2V7m+xx6iwjjJHoUZD0LYxOau3GNTHtSmj2VNco7cwKGinnzVtZKN4GJ4y2xxZ2TuiUtQFsJVy0PqEc80NNdRBA53ptF30UMI6Re3QrHA00TI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787788895; c=relaxed/simple;
	bh=TvqWBTb479dLnNj7XyocETAhU2b6NUuFp6SZAzpJMuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mmzz4NVCl9xvPgRa1FOso3CRNVyZVBG3mTkrWP2S2f7DDEecSl/oZvnam4MO/DkWCiUNP7z3N/qnaGnF6yUR8vj88Cy+yUAHm/tIpq7mppWzLZhrRklSocrs7XSj8CrQlcJi2fOOSnW1YC192HMcXuMb+VtHkydbcm2ChZWVroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nfwScI9x; arc=none smtp.client-ip=91.218.175.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nfwScI9x"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TvqWBTb479dLnNj7XyocETAhU2b6NUuFp6SZAzpJMuQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787788891; v=1; x=1788393691;
 b=nfwScI9xTcsU9uL+MqNEbZDDK3Mx+1ycMdr9kC2gRPEfVHXHYE3YQhZOZLicEN2LIMnrVyY7
 pyrVJLDxy1rozlNb/3cgr8pQdMgMByft9Yj52LIN65kbxPT+BOUgAK1pq19GMOFOz9tTJY6HSxP
 zLQ/8XPRxXX5WLkgDI/V4Oc0=
X-Envelope-To: linux-block@vger.kernel.org
Received: from dragon-master.speedport.ip (2003:fc:df23:7abd:c598:7cec:94a0:927b)
	by smtp.migadu.com with ESMTPS id 98be105a5da1ca64;
	Thu, 27 Aug 2026 00:01:31 +0000
X-Mizu-Trace-ID: 98be105a5da1ca64
X-Migadu-Flow: FLOW_OUT
From: Md Haris Iqbal <haris.iqbal@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Md Haris Iqbal <haris.iqbal@linux.dev>,
	Christoph Hellwig <hch@lst.de>
Subject: [RFC for-next 2/3] block: allow error injection rules to delay bios
Date: Thu, 27 Aug 2026 02:01:14 +0200
Message-ID: <20260827000115.128093-3-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827000115.128093-1-haris.iqbal@linux.dev>
References: <20260827000115.128093-1-haris.iqbal@linux.dev>
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

The bio is submitted from a workqueue rather than from the timer, because
submitting a bio can sleep.  Bios with REQ_NOWAIT are never delayed, and
values above 600 seconds are rejected.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 block/blk-core.c        |  13 ++--
 block/blk.h             |   1 +
 block/error-injection.c | 147 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 142 insertions(+), 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 196bccf27f58..f28ccc4633d4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -759,11 +759,8 @@ static void __submit_bio_noacct_mq(struct bio *bio)
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
@@ -793,6 +790,14 @@ void submit_bio_noacct_nocheck(struct bio *bio, bool split)
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
index 50abfd932886..cdf6d8964da6 100644
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
index 47cdd8973adc..9b823edf3f8a 100644
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
@@ -18,14 +26,91 @@ struct blk_error_inject {
 
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
+		 * Submit below the injection hook.  Re-entering it would match
+		 * the same rule again and the bio would never be issued, so a
+		 * bio that was delayed once skips error injection entirely
+		 * from here on, including any other rule that covers it.
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
@@ -45,29 +130,38 @@ bool __blk_error_inject(struct bio *bio)
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
@@ -86,6 +180,7 @@ static int error_inject_add(struct gendisk *disk, enum req_op op,
 	inj->start = start;
 	inj->status = status;
 	inj->chance = chance;
+	inj->delay_us = delay_us;
 
 	pr_debug_ratelimited("%pg: adding %s injection for %s at sector %llu:%llu\n",
 			disk->part0, blk_status_to_str(status),
@@ -139,6 +234,7 @@ enum options {
 	Opt_nr_sectors		= (1u << 18),
 	Opt_status		= (1u << 19),
 	Opt_chance		= (1u << 20),
+	Opt_delay_us		= (1u << 21),
 
 	Opt_invalid,
 };
@@ -151,6 +247,7 @@ static const match_table_t opt_tokens = {
 	{ Opt_nr_sectors,		"nr_sectors=%u"		},
 	{ Opt_status,			"status=%s"		},
 	{ Opt_chance,			"chance=%u"		},
+	{ Opt_delay_us,			"delay_us=%u"		},
 	{ Opt_invalid,			NULL,			},
 };
 
@@ -189,7 +286,7 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 		char *options)
 {
 	enum { Unset, Add, Removeall } action = Unset;
-	unsigned int option_mask = 0, chance = 1;
+	unsigned int option_mask = 0, chance = 1, delay_us = 0;
 	enum req_op op = REQ_OP_LAST;
 	u64 start = 0, nr_sectors = 0;
 	blk_status_t status = BLK_STS_OK;
@@ -232,6 +329,9 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 			if (!error && chance == 0)
 				error = -EINVAL;
 			break;
+		case Opt_delay_us:
+			error = match_uint(args, &delay_us);
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s'\n", p);
 			error = -EINVAL;
@@ -243,7 +343,7 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 	switch (action) {
 	case Add:
 		return error_inject_add(disk, op, start, nr_sectors, status,
-				chance);
+				chance, delay_us);
 	case Removeall:
 		if (option_mask & ~Opt_removeall)
 			return -EINVAL;
@@ -279,10 +379,11 @@ static int blk_error_injection_show(struct seq_file *s, void *private)
 
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
@@ -317,3 +418,19 @@ void blk_error_injection_exit(struct gendisk *disk)
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
-- 
2.53.0

