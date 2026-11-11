Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434332;
	b=NO3iZnvoKhVTjTAr4vsvBud6XpRlekmXD05QW84e8vh63WDCyrMh6ED0wUE3w7741Tb4
	 eX93LI13IwWU8F8SCxRTUiifcfH2MOXDvXO9ERpBob5oGju5UwgfYXWLRTZZ0HQc8I8Av
	 zUAmji7Ezc+yM0K8x3Wl4+ynNK/V1+YsSaXzC6mtahx3NAHeSrngUl/8oyaV2VnQsWqPx
	 7zMkaCZS46l8kxw1yzy0XOxKsHmpNu+VanmsBrHLvsazBxgFllzwJNdWsOtVKZkS0lbr6
	 g0Q128EYGmZtNeToJC6ptkEUDgaG3jtgUliFI9oOMau/g4T220Ecb6ayEz6RBOGtmKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434332;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7is/EuGUyxJzrWCnl+bqzRKPbHplfvRNCrGUMaUa/8g=;
	b=IKAYhMuwGr5TCYq9aPmDYl22fziSCt5Vc19xJm+3dJc7y/i7fIT6DKCtuuK+LNE4Bz23
	 h2h7dz/nt5t2Ro2ZESRc7Fw98t4FqK+cmwKUjtjS04ujO9t87QLjD9M4DiD8QS7/MvHQj
	 Eis0OWnCGDzBD5QkqSOCZQ/fLyYLwPcPZ4/Dj7HTAYMNMWqLsBL9MyZTZy8733ScQd/xE
	 QYCifqZpBR1P04V1N5VGLbGyPtBfGw69sOvys75l61YLx6ZxccusWAMzYfdnxmszSitPa
	 ZfT7IdQgbuIRVGKkTZ6ENmSdoLn86F7bqnmUbXwSm96E4nuAUmwhsbyfW5d0T188kAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=niFKsA2X;
	arc=none smtp.remote-ip=91.218.175.68
Received: from mta0.migadu.com (out-68.mta0.migadu.com [91.218.175.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF3606A8AA
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 21:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFAF3606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=niFKsA2X
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3FhA4vWfPSmw7LsNUlTwxgLiHA4CFcE8Kepmszjn6cE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794434329; v=1; x=1795039129;
 b=niFKsA2Xy3Yl1NmhQMGmbtmCkM84vQLzMms9bgozmax9q8Sk+C3+DUInuyER0tKk/ZoCz07G
 MJgVHOKX/tbENW1gG8aK+sAXQ4Q7E2Wo+I3ppjF9wDtTLW8m8jy9wTjzZJ2xeDO+3DzHT8lGc5C
 CoOqx30pE5IenuiPVo7SOztE=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d8db100ecdc5fe7b;
	Wed, 11 Nov 2026 21:58:49 +0000
X-Mizu-Trace-ID: d8db100ecdc5fe7b
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
Subject: [v4 2/3] block: allow error injection rules to delay bios
Date: Wed, 11 Nov 2026 22:58:37 +0100
Message-ID: <20261111215838.103356-3-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111215838.103356-1-haris.iqbal@linux.dev>
References: <20261111215838.103356-1-haris.iqbal@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error injection can only fail a bio today. Add a delay_us option so that
a rule can hold a bio back first, to model a slow device.

If a matching rule has delay_us set, the bio is held for that long. It is
then failed if the rule also has a status, or resubmitted otherwise.

The resubmission is done through submit_bio_noacct_nocheck(), which is
where the injection hook sits. To avoid the same delay rule being applied
to it again, mark the bio with the BIO_ERROR_INJECTED flag as soon as a
rule matches. This also prevents bios that are split later and resubmitted
from being evaluated for delay (or error injection) again. __bio_clone()
does not propagate the flag, so a clone a stacking driver aims at a lower
device is still evaluated.

The bio is submitted from a workqueue rather than from the timer, because
submitting a bio can sleep. A REQ_NOWAIT bio is failed with BLK_STS_AGAIN
instead of being delayed. Values above 600 seconds are rejected.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 block/error-injection.c   | 143 ++++++++++++++++++++++++++++++++++----
 block/error-injection.h   |   1 +
 include/linux/blk_types.h |   1 +
 3 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/block/error-injection.c b/block/error-injection.c
index db543fe27630..a6de52229ef3 100644
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
@@ -18,14 +26,97 @@ struct blk_error_inject {
 
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
 
+static void blk_error_inject_fail(struct bio *bio, blk_status_t status)
+{
+	pr_info_ratelimited("%pg: injecting %s error for %s at sector %llu:%u\n",
+			bio->bi_bdev->bd_disk->part0, blk_status_to_str(status),
+			blk_op_str(bio_op(bio)), bio->bi_iter.bi_sector,
+			bio_sectors(bio));
+	bio_endio_status(bio, status);
+}
+
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
+		blk_error_inject_fail(bio, status);
+		return;
+	}
+
+	/*
+	 * Resubmit.  The BIO_ERROR_INJECTED flag ensures that a bio that was
+	 * delayed once skips error injection entirely from here on, including
+	 * any other rule that covers it.
+	 */
+	submit_bio_noacct_nocheck(bio, false);
+}
+
+static bool blk_error_inject_delay(struct gendisk *disk, struct bio *bio,
+		blk_status_t status, unsigned int delay_us)
+{
+	struct blk_error_inject_delay *d;
+
+	/* fail a bio that can't block, as a real queue would */
+	if (bio->bi_opf & REQ_NOWAIT) {
+		bio_wouldblock_error(bio);
+		return true;
+	}
+
+	d = kmalloc_obj(*d, GFP_NOIO);
+	if (!d) {
+		pr_warn_ratelimited("%pg: failed to delay %s at sector %llu:%u\n",
+				disk->part0, blk_op_str(bio_op(bio)),
+				bio->bi_iter.bi_sector, bio_sectors(bio));
+		return false;
+	}
+
+	pr_info_ratelimited("%pg: delaying %s at sector %llu:%u by %uus\n",
+			disk->part0, blk_op_str(bio_op(bio)),
+			bio->bi_iter.bi_sector, bio_sectors(bio), delay_us);
+
+	d->bio = bio;
+	d->status = status;
+	INIT_DELAYED_WORK(&d->dwork, blk_error_inject_delay_work);
+
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
@@ -45,29 +136,34 @@ bool __blk_error_inject(struct bio *bio)
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
+		bio_set_flag(bio, BIO_ERROR_INJECTED);
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
+	blk_error_inject_fail(bio, status);
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
@@ -86,6 +182,7 @@ static int error_inject_add(struct gendisk *disk, enum req_op op,
 	inj->start = start;
 	inj->status = status;
 	inj->chance = chance;
+	inj->delay_us = delay_us;
 
 	pr_debug_ratelimited("%pg: adding %s injection for %s at sector %llu:%llu\n",
 			disk->part0, blk_status_to_str(status),
@@ -139,6 +236,7 @@ enum options {
 	Opt_nr_sectors		= (1u << 18),
 	Opt_status		= (1u << 19),
 	Opt_chance		= (1u << 20),
+	Opt_delay_us		= (1u << 21),
 
 	Opt_invalid,
 };
@@ -151,6 +249,7 @@ static const match_table_t opt_tokens = {
 	{ Opt_nr_sectors,		"nr_sectors=%u"		},
 	{ Opt_status,			"status=%s"		},
 	{ Opt_chance,			"chance=%u"		},
+	{ Opt_delay_us,			"delay_us=%u"		},
 	{ Opt_invalid,			NULL,			},
 };
 
@@ -187,7 +286,7 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 		char *options)
 {
 	enum { Unset, Add, Removeall } action = Unset;
-	unsigned int option_mask = 0, chance = 1;
+	unsigned int option_mask = 0, chance = 1, delay_us = 0;
 	enum req_op op = REQ_OP_LAST;
 	u64 start = 0, nr_sectors = 0;
 	blk_status_t status = BLK_STS_OK;
@@ -230,6 +329,9 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 			if (!error && chance == 0)
 				error = -EINVAL;
 			break;
+		case Opt_delay_us:
+			error = match_uint(args, &delay_us);
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s'\n", p);
 			error = -EINVAL;
@@ -241,7 +343,7 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 	switch (action) {
 	case Add:
 		return error_inject_add(disk, op, start, nr_sectors, status,
-				chance);
+				chance, delay_us);
 	case Removeall:
 		if (option_mask & ~Opt_removeall)
 			return -EINVAL;
@@ -277,10 +379,11 @@ static int blk_error_injection_show(struct seq_file *s, void *private)
 
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
@@ -315,3 +418,13 @@ void blk_error_injection_exit(struct gendisk *disk)
 {
 	error_inject_removeall(disk);
 }
+
+static int __init blk_error_injection_init_wq(void)
+{
+	blk_error_inject_wq = alloc_workqueue("blk_error_inject",
+					      WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
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
index 0cc09b975d8f..1a5812fa4052 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -328,6 +328,7 @@ enum {
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
 	BIO_COMPLETE_IN_TASK, /* complete bi_end_io() in task context */
+	BIO_ERROR_INJECTED, /* error injection rules already applied */
 	BIO_FLAG_LAST
 };
 
-- 
2.53.0

