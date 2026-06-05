Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79763E9C0B;
	Fri,  5 Jun 2026 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685102; cv=none; b=l12HmpIpc1o+04/wK3I71mlwIfrHqdaar7RL1CKU34sp55P+PtaDsXhWa9YrXIkSYbsU1O8rffGwvl4dmUxCz85L+yMqT1k3Q+wA68NU7/0/r1S1FKCK1UPCQ/hBtMi84M8ZIQITes2zzhoi4at5d1cg0R1x/zzJcCVbtDEaUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685102; c=relaxed/simple;
	bh=ktcqGIH+PSLrGZRI8SI+X8Oy36Z9Tp2/RaGD8CW2WkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJmz9M9nsGMBJTsWOAq7cneqrGjdBPd1/d9lKvpJZnqqIE1aD4fTA2qHwgJcImKTRPVMe3OorRpbVHYkUGgRfNGQJYQ4p/UsAGdBP/E9k4mTNFt4h0Udmjub4LVKYPqkjzi1epj00jarxp0D8iB6IBjbX2okf1lSdn8lN9g7u8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VnC7EHDs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VnC7EHDs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6Pzg/Apm1SlZ/95S2LeRg+sxClzvty8azzAV3zZRpPw=; b=VnC7EHDshphDPFrUuTcZIiY5vX
	eGqzA/UUCyoQ89ZuZ0/grw89YGCaXiawVd3gKx57jbZtRtObZLBWShIV+ZJA38I9EBppZxHYwEMxd
	9V01GqGHIt8LJeaGy/d8mbqCBEF0jnBck1YsNxpEQv097RZUqkqIzPw6Tbm2qH5Ll06Rk8Lko0oz1
	Nt4E076K4IALiJWWqE0QKEMI0E6PuvbCUpq3A08WPKOtB5cavfroRT7t96vevS/R00U39YnSyP7Fr
	9Ai49cQ8xO+3cK2u0Xgw66mVal1h0Abk1ZOlCafWKxanKbhSzKWJ+cHQ7sBymw95iER7+9Wax0JLz
	gKvrW1WQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZXO-000000014Qk-304i;
	Fri, 05 Jun 2026 18:44:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 4/4] block: add configurable error injection
Date: Fri,  5 Jun 2026 20:44:30 +0200
Message-ID: <20260605184441.590927-5-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605184441.590927-1-hch@lst.de>
References: <20260605184441.590927-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a new block error injection interface that allows to inject specific
status code for specific ranges.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/block/error-injection.rst |  59 +++++
 Documentation/block/index.rst           |   1 +
 block/Kconfig                           |   7 +
 block/Makefile                          |   1 +
 block/blk-core.c                        |   3 +
 block/blk-sysfs.c                       |   4 +
 block/blk.h                             |  12 +
 block/error-injection.c                 | 308 ++++++++++++++++++++++++
 block/genhd.c                           |   4 +
 include/linux/blkdev.h                  |   6 +
 10 files changed, 405 insertions(+)
 create mode 100644 Documentation/block/error-injection.rst
 create mode 100644 block/error-injection.c

diff --git a/Documentation/block/error-injection.rst b/Documentation/block/error-injection.rst
new file mode 100644
index 000000000000..b2e2ab6add70
--- /dev/null
+++ b/Documentation/block/error-injection.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Configurable Error Injection
+============================
+
+Overview
+--------
+
+Configurable error injection allows injecting specific block layer status codes
+for ranges of a block device.  Errors can be injected unconditionally, or with a
+given probability.
+
+To use configurable error injection, CONFIG_BLK_ERROR_INJECTION must be enabled.
+
+The only interface is the error_injection debugfs file, which is created for
+each registered gendisk.  Writes to this file are used to create or delete rules
+and reads return a list of the current error injection sites.
+
+Options
+-------
+
+The following options specify the operations:
+
+===================	=======================================================
+add			add a new rule
+removeall		remove all existing rules
+===================	=======================================================
+
+The following options specify the details of the rule for the add operation:
+
+===================	=======================================================
+op=%s			block layer operation this rule applies to, e.g. READ
+			or WRITE.
+			Mandatory.
+start=%u		First block layer sector the rule applies to.
+			Optional, defaults to 0.
+nr_sectors=%u		Number of sectors this rule applies.
+			Optional, defaults to the remainder of the device.
+status=%s		Status to return.
+			Mandatory.
+chance=%u		Only return a failure with a likelihood of 1/chance.
+			Optional, defaults to 1 (always).
+===================	=======================================================
+
+Example
+-------
+
+Return BLK_STS_IOERR for one in 10 reads of sector 0 of /dev/nvme0n1:
+
+	$ echo 'add,op=READ,start=0,status=IOERR,chance=10' > /sys/kernel/debug/block/nvme0n1/error_injection
+
+Return BLK_STS_MEDIUM for every write to /dev/nvme0n1:
+
+	$ echo 'add,op=WRITE,start=0,status=MEDIUM' > /sys/kernel/debug/block/nvme0n1/error_injection
+
+Remove all rules for /dev/nvme0n1:
+
+	$ echo 'removeall' > /sys/kernel/debug/block/nvme0n1/error_injection
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 9fea696f9daa..bfa1bbd31ddf 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -22,3 +22,4 @@ Block
    switching-sched
    writeback_cache_control
    ublk
+   error-injection
diff --git a/block/Kconfig b/block/Kconfig
index 15027963472d..7651b86eed56 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -221,6 +221,13 @@ config BLOCK_HOLDER_DEPRECATED
 config BLK_MQ_STACKING
 	bool
 
+config BLK_ERROR_INJECTION
+	bool "Enable block layer error injection"
+	help
+	  Enable inserting arbitrary block errors through a debugfs interface.
+
+	  See Documentation/block/error-injection.rst for details.
+
 source "block/Kconfig.iosched"
 
 endif # BLOCK
diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c..d0bb3e15a347 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -11,6 +11,7 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
 			disk-events.o blk-ia-ranges.o early-lookup.o
 
+obj-$(CONFIG_BLK_ERROR_INJECTION) += error-injection.o
 obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
 obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
diff --git a/block/blk-core.c b/block/blk-core.c
index aa90aad6da13..268735582ef1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -767,6 +767,9 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 
 void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 {
+	if (unlikely(blk_error_inject(bio)))
+		return;
+
 	blk_cgroup_bio_start(bio);
 
 	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f22c1f253eb3..8a0c2be48a31 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -933,6 +933,8 @@ static void blk_debugfs_remove(struct gendisk *disk)
 
 	blk_debugfs_lock_nomemsave(q);
 	blk_trace_shutdown(q);
+	if (IS_ENABLED(CONFIG_BLK_ERROR_INJECTION))
+		blk_error_injection_exit(disk);
 	debugfs_remove_recursive(q->debugfs_dir);
 	q->debugfs_dir = NULL;
 	q->sched_debugfs_dir = NULL;
@@ -963,6 +965,8 @@ int blk_register_queue(struct gendisk *disk)
 
 	memflags = blk_debugfs_lock(q);
 	q->debugfs_dir = debugfs_create_dir(disk->disk_name, blk_debugfs_root);
+	if (IS_ENABLED(CONFIG_BLK_ERROR_INJECTION))
+		blk_error_injection_init(disk);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_register(q);
 	blk_debugfs_unlock(q, memflags);
diff --git a/block/blk.h b/block/blk.h
index 93b30d1d0ec6..ec2639752e07 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -660,6 +660,18 @@ static inline bool should_fail_request(struct block_device *part,
 }
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
+void blk_error_injection_init(struct gendisk *disk);
+void blk_error_injection_exit(struct gendisk *disk);
+bool __blk_error_inject(struct bio *bio);
+static inline bool blk_error_inject(struct bio *bio)
+{
+	if (!IS_ENABLED(CONFIG_BLK_ERROR_INJECTION))
+		return false;
+	if (!test_bit(GD_ERROR_INJECT, &bio->bi_bdev->bd_disk->state))
+		return false;
+	return __blk_error_inject(bio);
+}
+
 /*
  * Optimized request reference counting. Ideally we'd make timeouts be more
  * clever, as that's the only reason we need references at all... But until
diff --git a/block/error-injection.c b/block/error-injection.c
new file mode 100644
index 000000000000..f35bce1d25cc
--- /dev/null
+++ b/block/error-injection.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Christoph Hellwig.
+ */
+#include <linux/debugfs.h>
+#include <linux/blkdev.h>
+#include <linux/parser.h>
+#include <linux/seq_file.h>
+#include "blk.h"
+
+struct blk_error_inject {
+	struct list_head		entry;
+	sector_t			start;
+	sector_t			end;
+	enum req_op			op;
+	blk_status_t			status;
+
+	/* only inject every 1 / chance times */
+	unsigned int			chance;
+};
+
+bool __blk_error_inject(struct bio *bio)
+{
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	struct blk_error_inject *inj;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(inj, &disk->error_injection_list, entry) {
+		if (bio->bi_iter.bi_sector <= inj->end &&
+		    bio_end_sector(bio) > inj->start &&
+		    bio_op(bio) == inj->op) {
+			blk_status_t status = inj->status;
+
+			if (inj->chance > 1 &&
+			    (get_random_u32() % inj->chance) != 0)
+				continue;
+
+			pr_info_ratelimited("%pg: injecting %s error for %s at sector %llu:%u\n",
+					disk->part0,
+					blk_status_to_str(status),
+					blk_op_str(inj->op),
+					bio->bi_iter.bi_sector,
+					bio_sectors(bio));
+			rcu_read_unlock();
+			bio_endio_status(bio, status);
+			return true;
+		}
+	}
+	rcu_read_unlock();
+	return false;
+}
+
+static int error_inject_add(struct gendisk *disk, enum req_op op,
+		sector_t start, u64 nr_sectors, blk_status_t status,
+		unsigned int chance)
+{
+	struct blk_error_inject *inj;
+	int error = -EINVAL;
+
+	if (op == REQ_OP_LAST)
+		return -EINVAL;
+	if (status == BLK_STS_OK)
+		return -EINVAL;
+
+	inj = kzalloc_obj(*inj);
+	if (!inj)
+		return -ENOMEM;
+
+	if (nr_sectors) {
+		if (U64_MAX - nr_sectors < start)
+			goto out_free_inj;
+		inj->end = start + nr_sectors - 1;
+	} else {
+		inj->end = U64_MAX;
+	}
+
+	inj->op = op;
+	inj->start = start;
+	inj->status = status;
+	inj->chance = chance;
+
+	pr_debug_ratelimited("%pg: adding %s injection for %s at sector %llu:%llu\n",
+			disk->part0, blk_status_to_str(status),
+			blk_op_str(op),
+			start, nr_sectors);
+
+	/*
+	 * Add to the front of the list so that newer entries can partially
+	 * override other entries.  This also intentional allows duplicate
+	 * entries as there is no real reason to reject them.
+	 */
+	mutex_lock(&disk->error_injection_lock);
+	if (!disk_live(disk)) {
+		mutex_unlock(&disk->error_injection_lock);
+		error = -ENODEV;
+		goto out_free_inj;
+	}
+	list_add_rcu(&inj->entry, &disk->error_injection_list);
+	set_bit(GD_ERROR_INJECT, &disk->state);
+	mutex_unlock(&disk->error_injection_lock);
+	return 0;
+
+out_free_inj:
+	kfree(inj);
+	return error;
+}
+
+static void error_inject_removall(struct gendisk *disk)
+{
+	struct blk_error_inject *inj;
+
+	mutex_lock(&disk->error_injection_lock);
+	clear_bit(GD_ERROR_INJECT, &disk->state);
+	while ((inj = list_first_entry_or_null(&disk->error_injection_list,
+			struct blk_error_inject, entry))) {
+		list_del_rcu(&inj->entry);
+		mutex_unlock(&disk->error_injection_lock);
+
+		kfree_rcu_mightsleep(inj);
+
+		mutex_lock(&disk->error_injection_lock);
+	}
+	mutex_unlock(&disk->error_injection_lock);
+}
+
+enum options {
+	Opt_add			= (1u << 0),
+	Opt_removeall		= (1u << 1),
+
+	Opt_op			= (1u << 16),
+	Opt_start		= (1u << 17),
+	Opt_nr_sectors		= (1u << 18),
+	Opt_status		= (1u << 19),
+	Opt_chance		= (1u << 20),
+
+	Opt_invalid,
+};
+
+static const match_table_t opt_tokens = {
+	{ Opt_add,			"add",			},
+	{ Opt_removeall,		"removeall",		},
+	{ Opt_op,			"op=%s",		},
+	{ Opt_start,			"start=%u"		},
+	{ Opt_nr_sectors,		"nr_sectors=%u"		},
+	{ Opt_status,			"status=%s"		},
+	{ Opt_chance,			"chance=%u"		},
+	{ Opt_invalid,			NULL,			},
+};
+
+static int match_op(substring_t *args, enum req_op *op)
+{
+	const char *tag;
+
+	tag = match_strdup(args);
+	if (!tag)
+		return -ENOMEM;
+	*op = str_to_blk_op(tag);
+	if (*op == REQ_OP_LAST)
+		pr_warn("invalid op '%s'\n", tag);
+	kfree(tag);
+	return 0;
+}
+
+static int match_status(substring_t *args, blk_status_t *status)
+{
+	const char *tag;
+
+	tag = match_strdup(args);
+	if (!tag)
+		return -ENOMEM;
+	*status = tag_to_blk_status(tag);
+	if (!*status)
+		pr_warn("invalid status '%s'\n", tag);
+	kfree(tag);
+	return 0;
+}
+
+static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
+		char *options)
+{
+	enum { Unset, Add, Removeall } action = Unset;
+	unsigned int option_mask = 0, chance = 1;
+	enum req_op op = REQ_OP_LAST;
+	u64 start = 0, nr_sectors = 0;
+	blk_status_t status = BLK_STS_OK;
+	substring_t args[MAX_OPT_ARGS];
+	char *p;
+
+	while ((p = strsep(&options, ",\n")) != NULL) {
+		int error = 0;
+		ssize_t token;
+
+		if (!*p)
+			continue;
+		token = match_token(p, opt_tokens, args);
+		option_mask |= token;
+		switch (token) {
+		case Opt_add:
+			if (action != Unset)
+				return -EINVAL;
+			action = Add;
+			break;
+		case Opt_removeall:
+			if (action != Unset)
+				return -EINVAL;
+			action = Removeall;
+			break;
+		case Opt_op:
+			error = match_op(args, &op);
+			break;
+		case Opt_start:
+			error = match_u64(args, &start);
+			break;
+		case Opt_nr_sectors:
+			error = match_u64(args, &nr_sectors);
+			break;
+		case Opt_status:
+			error = match_status(args, &status);
+			break;
+		case Opt_chance:
+			error = match_uint(args, &chance);
+			if (!error && chance == 0)
+				error = -EINVAL;
+			break;
+		default:
+			pr_warn("unknown parameter or missing value '%s'\n", p);
+			error = -EINVAL;
+		}
+		if (error)
+			return error;
+	}
+
+	switch (action) {
+	case Add:
+		return error_inject_add(disk, op, start, nr_sectors, status,
+				chance);
+	case Removeall:
+		if (option_mask & ~Opt_removeall)
+			return -EINVAL;
+		error_inject_removall(disk);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t blk_error_injection_write(struct file *file,
+		const char __user *ubuf, size_t count, loff_t *pos)
+{
+	struct gendisk *disk = file_inode(file)->i_private;
+	char *options;
+	int error;
+
+	options = memdup_user_nul(ubuf, count);
+	if (IS_ERR(options))
+		return PTR_ERR(options);
+	error = blk_error_injection_parse_options(disk, options);
+	kfree(options);
+
+	if (error)
+		return error;
+	return count;
+}
+
+static int blk_error_injection_show(struct seq_file *s, void *private)
+{
+	struct gendisk *disk = s->private;
+	struct blk_error_inject *inj;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(inj, &disk->error_injection_list, entry) {
+		seq_printf(s, "%llu:%llu status=%s,chance=%u",
+			inj->start, inj->end,
+			blk_status_to_tag(inj->status), inj->chance);
+		seq_putc(s, '\n');
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
+static int blk_error_injection_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, blk_error_injection_show, inode->i_private);
+}
+
+static int blk_error_injection_release(struct inode *inode, struct file *file)
+{
+	return single_release(inode, file);
+}
+
+static const struct file_operations blk_error_injection_fops = {
+	.owner		= THIS_MODULE,
+	.write		= blk_error_injection_write,
+	.read		= seq_read,
+	.open		= blk_error_injection_open,
+	.release	= blk_error_injection_release,
+};
+
+void blk_error_injection_init(struct gendisk *disk)
+{
+	debugfs_create_file("error_injection", 0600, disk->queue->debugfs_dir,
+			disk, &blk_error_injection_fops);
+}
+
+void blk_error_injection_exit(struct gendisk *disk)
+{
+	error_inject_removall(disk);
+}
diff --git a/block/genhd.c b/block/genhd.c
index 7d6854fd28e9..f84b6a355b57 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1485,6 +1485,10 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	lockdep_init_map(&disk->lockdep_map, "(bio completion)", lkclass, 0);
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	INIT_LIST_HEAD(&disk->slave_bdevs);
+#endif
+#ifdef CONFIG_BLK_ERROR_INJECTION
+	mutex_init(&disk->error_injection_lock);
+	INIT_LIST_HEAD(&disk->error_injection_list);
 #endif
 	mutex_init(&disk->rqos_state_mutex);
 	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17270a28c66d..d2adf2775920 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -176,6 +176,7 @@ struct gendisk {
 #define GD_SUPPRESS_PART_SCAN		5
 #define GD_OWNS_QUEUE			6
 #define GD_ZONE_APPEND_USED		7
+#define GD_ERROR_INJECT			8
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
@@ -227,6 +228,11 @@ struct gendisk {
 	 */
 	struct blk_independent_access_ranges *ia_ranges;
 
+#ifdef CONFIG_BLK_ERROR_INJECTION
+	struct mutex		error_injection_lock;
+	struct list_head	error_injection_list;
+#endif
+
 	struct mutex rqos_state_mutex;	/* rqos state change mutex */
 };
 
-- 
2.53.0

