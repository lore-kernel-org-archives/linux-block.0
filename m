Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B706392C56;
	Tue,  2 Jun 2026 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379212; cv=none; b=MgQyoJ9IUxkjoTJhFUNqfKH+GNP3QxDNksbtFRfFerYGYejDi8nvPTFCFCw+bPawkzMAMO+B7NYGeXdU4sHY8Zm4JsBFVNzpk5moATeZzAn/2wLFCVu0EQpyLS1xrOdYcPITXNhK4Nsr+bAb73yf7jIuxn2Xye++1PsDPOExqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379212; c=relaxed/simple;
	bh=cy8MT0rJq1aao8EZpJzGe96xWeqEOlCSXC+9s06XjNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekyRGb4WtNh3KIjgnwGY7LBTYZE1lUsEm/uZVcvuHzKIqxtnvPIdonDNNw9IBk+G2DqlSQDSqpbXUgGMpiTc2HikGeHQdj6ye/iiswMi/3t0w/oZrqjaNys3H9IpkRey19IwYFEdUbpFFNNJzbhVznWwaPJA6U9vorviLqw/lDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1VAZ0fUb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1VAZ0fUb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XKsUR21qtVEPkQCNssh7Hbtl/ycsW/+TbsYpbVhzrVg=; b=1VAZ0fUbv4Xo2aJA6FxnW6VKnC
	ce5VV969obEyxTrZsgSYaw+ogOllvaA8XeYpJUXK3tLNqEP898kVg2RbNOiQ/q7+lFC/jbbvVqWTc
	qY3KKta+zVcC6KJYLeOv5uQ8eTcZf2Zd/ylkx5SjGGuqp9194Gc1dRv8TOZw/mcRfKvHnvMiTxNcX
	QmwqKhQow8AyVCmdhFsoFh9PVCTLjmDzYmMNqWJ15eLCKXV7s5blMdJjYRgkjo0U8zjBx6i3NCwu0
	Yd6b803VOdbMJFvv+8C/pW5O8Lc4fB+6cuVcnMFwnUrWIoetP6Momvejsl0Yv/Tj9CcBBSU9kGOeW
	NzaeOdDg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUHxg-0000000CLC1-18eH;
	Tue, 02 Jun 2026 05:46:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 8/9] block: add configurable error injection
Date: Tue,  2 Jun 2026 07:45:40 +0200
Message-ID: <20260602054615.3788425-9-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602054615.3788425-1-hch@lst.de>
References: <20260602054615.3788425-1-hch@lst.de>
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
 block/Makefile                          |   1 +
 block/blk-core.c                        |   2 +
 block/blk-sysfs.c                       |   4 +
 block/blk.h                             |  15 ++
 block/error-injection.c                 | 299 ++++++++++++++++++++++++
 block/genhd.c                           |   4 +
 include/linux/blkdev.h                  |   5 +
 9 files changed, 390 insertions(+)
 create mode 100644 Documentation/block/error-injection.rst
 create mode 100644 block/error-injection.c

diff --git a/Documentation/block/error-injection.rst b/Documentation/block/error-injection.rst
new file mode 100644
index 000000000000..be87091b5330
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
+for ranges of a block device.  Error can be injected unconditional, or with a
+given probability.
+
+To use configurable error injection, CONFIG_FAIL_MAKE_REQUEST must be enabled.
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
diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c..d223b6b7d72f 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -11,6 +11,7 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
 			disk-events.o blk-ia-ranges.o early-lookup.o
 
+obj-$(CONFIG_FAIL_MAKE_REQUEST)	+= error-injection.o
 obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
 obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
diff --git a/block/blk-core.c b/block/blk-core.c
index 8bbc03ce924f..04a392849ab0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -765,6 +765,8 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 {
 	if (unlikely(may_fail_bio(bio))) {
+		if (blk_error_inject(bio))
+			return;
 		if (should_fail_request(bio->bi_iter.bi_size)) {
 			bio_io_error(bio);
 			return;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f22c1f253eb3..43f909c7f0c9 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -933,6 +933,8 @@ static void blk_debugfs_remove(struct gendisk *disk)
 
 	blk_debugfs_lock_nomemsave(q);
 	blk_trace_shutdown(q);
+	if (IS_ENABLED(CONFIG_FAIL_MAKE_REQUEST))
+		blk_error_injection_exit(disk);
 	debugfs_remove_recursive(q->debugfs_dir);
 	q->debugfs_dir = NULL;
 	q->sched_debugfs_dir = NULL;
@@ -963,6 +965,8 @@ int blk_register_queue(struct gendisk *disk)
 
 	memflags = blk_debugfs_lock(q);
 	q->debugfs_dir = debugfs_create_dir(disk->disk_name, blk_debugfs_root);
+	if (IS_ENABLED(CONFIG_FAIL_MAKE_REQUEST))
+		blk_error_injection_init(disk);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_register(q);
 	blk_debugfs_unlock(q, memflags);
diff --git a/block/blk.h b/block/blk.h
index 4857b899e2b6..19f925d8f39d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -781,4 +781,19 @@ static inline void blk_debugfs_unlock(struct request_queue *q,
 	memalloc_noio_restore(memflags);
 }
 
+void blk_error_injection_init(struct gendisk *disk);
+void blk_error_injection_exit(struct gendisk *disk);
+
+bool __blk_error_inject(struct bio *bio);
+static inline bool blk_error_inject(struct bio *bio)
+{
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+
+	if (!list_empty_careful(&disk->error_injection_list))
+		return __blk_error_inject(bio);
+#endif
+	return false;
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/error-injection.c b/block/error-injection.c
new file mode 100644
index 000000000000..dc0420c4eb58
--- /dev/null
+++ b/block/error-injection.c
@@ -0,0 +1,299 @@
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
+		    bio_end_sector(bio) >= inj->start &&
+		    bio_op(bio) == inj->op) {
+			blk_status_t status = inj->status;
+
+			if (inj->chance > 1 &&
+			    (get_random_u32() % inj->chance) != 0)
+				continue;
+
+			rcu_read_unlock();
+			pr_info_ratelimited("%pg: injecting %s error for %s at sector %llu:%u\n",
+					disk->part0,
+					blk_status_to_str(status),
+					blk_op_str(inj->op),
+					bio->bi_iter.bi_sector,
+					bio_sectors(bio));
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
+
+	if (op == REQ_OP_LAST)
+		return -EINVAL;
+	if (status == BLK_STS_OK)
+		return -EINVAL;
+	if (U64_MAX - nr_sectors < start)
+		return -EINVAL;
+
+	if (!nr_sectors)
+		nr_sectors = U64_MAX;
+
+	inj = kzalloc_obj(*inj);
+	if (!inj)
+		return -ENOMEM;
+
+	pr_debug_ratelimited("%pg: adding %s injection for %s at sector %llu:%llu\n",
+			disk->part0, blk_status_to_str(status),
+			blk_op_str(op),
+			start, nr_sectors);
+
+	inj->op = op;
+	inj->start = start;
+	inj->end = start + nr_sectors - 1;
+	inj->status = status;
+	inj->chance = chance;
+
+	/*
+	 * Add to the front of the list so that newer entries can partially
+	 * override other entries.  This also intentional allows duplicate
+	 * entries as there is no real reason to reject them.
+	 */
+	mutex_lock(&disk->error_injection_lock);
+	if (!disk_live(disk)) {
+		mutex_unlock(&disk->error_injection_lock);
+		return -EINVAL;
+	}
+	list_add(&inj->entry, &disk->error_injection_list);
+	mutex_unlock(&disk->error_injection_lock);
+
+	bdev_set_flag(disk->part0, BD_MAKE_IT_FAIL);
+	return 0;
+}
+
+static void error_inject_removall(struct gendisk *disk)
+{
+	struct blk_error_inject *inj;
+
+	mutex_lock(&disk->error_injection_lock);
+	while ((inj = list_first_entry_or_null(&disk->error_injection_list,
+			struct blk_error_inject, entry))) {
+		list_del_rcu(&inj->entry);
+		mutex_unlock(&disk->error_injection_lock);
+
+		kfree_rcu_mightsleep(inj);
+
+		mutex_lock(&disk->error_injection_lock);
+	}
+
+	mutex_unlock(&disk->error_injection_lock);
+
+	bdev_clear_flag(disk->part0, BD_MAKE_IT_FAIL);
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
+static ssize_t blk_error_injection_write(struct file *file,
+		const char __user *ubuf, size_t count, loff_t *pos)
+{
+	struct gendisk *disk = file_inode(file)->i_private;
+	enum { Unset, Add, Removeall } action = Unset;
+	unsigned int option_mask = 0, chance = 1;
+	enum req_op op = REQ_OP_LAST;
+	u64 start = 0, nr_sectors = 0;
+	blk_status_t status = BLK_STS_OK;
+	substring_t args[MAX_OPT_ARGS];
+	char *options, *o, *p;
+	ssize_t token, ret = 0;
+
+	options = memdup_user_nul(ubuf, count);
+	if (!options)
+		return -ENOMEM;
+
+	o = options;
+	while ((p = strsep(&o, ",\n")) != NULL) {
+		if (!*p)
+			continue;
+		token = match_token(p, opt_tokens, args);
+		option_mask |= token;
+		switch (token) {
+		case Opt_add:
+			if (action == Unset)
+				action = Add;
+			else
+				ret = -EINVAL;
+			break;
+		case Opt_removeall:
+			if (action == Unset)
+				action = Removeall;
+			else
+				ret = -EINVAL;
+			break;
+		case Opt_op:
+			ret = match_op(args, &op);
+			break;
+		case Opt_start:
+			ret = match_u64(args, &start);
+			break;
+		case Opt_nr_sectors:
+			ret = match_u64(args, &nr_sectors);
+			break;
+		case Opt_status:
+			ret = match_status(args, &status);
+			break;
+		case Opt_chance:
+			ret = match_uint(args, &chance);
+			if (!ret && chance == 0)
+				ret = -EINVAL;
+			break;
+		default:
+			pr_warn("unknown parameter or missing value '%s'\n", p);
+			ret = -EINVAL;
+			break;
+		}
+		if (ret)
+			goto out_free_options;
+	}
+
+	switch (action) {
+	case Add:
+		ret = error_inject_add(disk, op, start, nr_sectors, status,
+				chance);
+		break;
+	case Removeall:
+		if (option_mask & ~Opt_removeall)
+			return -EINVAL;
+		error_inject_removall(disk);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (!ret)
+		ret = count;
+out_free_options:
+	kfree(options);
+	return ret;
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
index 7d6854fd28e9..30f42461d895 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1485,6 +1485,10 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	lockdep_init_map(&disk->lockdep_map, "(bio completion)", lkclass, 0);
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	INIT_LIST_HEAD(&disk->slave_bdevs);
+#endif
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	mutex_init(&disk->error_injection_lock);
+	INIT_LIST_HEAD(&disk->error_injection_list);
 #endif
 	mutex_init(&disk->rqos_state_mutex);
 	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17270a28c66d..8743ad616b7f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -227,6 +227,11 @@ struct gendisk {
 	 */
 	struct blk_independent_access_ranges *ia_ranges;
 
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	struct mutex		error_injection_lock;
+	struct list_head	error_injection_list;
+#endif
+
 	struct mutex rqos_state_mutex;	/* rqos state change mutex */
 };
 
-- 
2.53.0

