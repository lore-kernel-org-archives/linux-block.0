Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D74C3A5A5
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 23:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3266B21726
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 23:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=manuel-bentele.de header.i=@manuel-bentele.de header.b="IZ6CKjnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfHWXBv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:01:51 -0400
Received: from host1.nc.manuel-bentele.de ([92.60.37.180]:55826 "EHLO
        host1.nc.manuel-bentele.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbfHWXBu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 19:01:50 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: development@manuel-bentele.de)
        by host1.nc.manuel-bentele.de (Postcow) with ESMTPSA id A2198641F6;
        Sat, 24 Aug 2019 00:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manuel-bentele.de;
        s=dkim; t=1566600982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcIYAGtw/rOUox1fSz4DqEQBgc6OveGHBdNa7WquIpg=;
        b=IZ6CKjnFMk3A/3+7pcxMUbRPcm+1GKMfsaRa1gvtMHZnnossbr+RoKaEu74FtaoDvjelkp
        3y3dOaZvYU4KZXerggHs0rKPH6u/RrMAUw9GVRiKHTW/vDtu4sMW9Ok+xqmLTvy2Vcsuzg
        TX4xTtg/zGDLq8afBQW4TO0IYc13alBw0XP+DCYYWCWPoGKJu4dYCfW1LYqS7/f/4I5lVU
        NMo5IDtHl/svtzjDAlZVH3Xll8D/pKx5DbKjL7PrXUU12ay86JVfKTnYewjh1EeFvBtGlM
        jOe/cPQj7cdlMDBS0vm4WE12c6c6z/uFQKR870Gmqfa8c1XydjM+3X1HT6078w==
From:   development@manuel-bentele.de
To:     linux-block@vger.kernel.org
Cc:     Manuel Bentele <development@manuel-bentele.de>
Subject: [PATCH 4/5] block: loop: add QCOW2 loop file format driver (read-only)
Date:   Sat, 24 Aug 2019 00:56:18 +0200
Message-Id: <20190823225619.15530-5-development@manuel-bentele.de>
In-Reply-To: <20190823225619.15530-1-development@manuel-bentele.de>
References: <20190823225619.15530-1-development@manuel-bentele.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manuel-bentele.de; s=dkim; t=1566600982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcIYAGtw/rOUox1fSz4DqEQBgc6OveGHBdNa7WquIpg=;
        b=tIdOtXFnNjIoPJM/6JOoeg8Hea+VeqN9YawE0rsURTDsKjvrHEgaoN/sN0m2zT7FOlT2wX
        y/Ly38FyrVxASiZS7uWSwrDW4LaZMvkfBtM+FzR2YCoSjMLttGf3h0WEC6a7jV2jH/f9aa
        X2YUFdU8AKibn7LSP7acQJ8bl+8qm7Z4BeAJWsv27PrPOHbbcfjs0g+ezcSoPoJW/tYW6o
        QNpkqMwLr1aSFGyHlmQCSw6N71G9fJdKMToGKINsVqOjAwbGywQHD/4vCMNX4fv/YKlxeq
        76NlfTLjdfublx+UgW/yOAFZtuYoLGDZcM8oD3dHBsIQTs/5t4lxQh8/olhMhg==
ARC-Seal: i=1; s=dkim; d=manuel-bentele.de; t=1566600982; a=rsa-sha256;
        cv=none;
        b=QxQqBJb2iSfDVNRe4xCYuxxHSh0abtjLV7V+vqmHEQkK0jpfUbcSdJTmx6hk1QmsIZWR+L
        jJ4Sq0j6wu3ts7rLyWONH7JcRbT8VNRHPOA8hwLF6io6ocxYIsLyfsTMwUm2JQsMdWuesw
        kvGImtY5DIAP2hrLrkR2xTI7AbfgivQhYr5UeYxDS7KJtacmgf51A499rcsHthsvmZzotJ
        JJSS8+8AoIiBOwxpiYe+xGUxMWuKnHWJEFIEM3KcdK6a1XnPSV4dR9NUSW1xG70ew414Q7
        sRSqCN9jyc26OMnLE6g4D22mDdfHYvzuBjmXpQUiBsag932RtCroZWytUAfYLg==
ARC-Authentication-Results: i=1;
        host1.nc.manuel-bentele.de;
        auth=pass smtp.auth=development@manuel-bentele.de smtp.mailfrom=development@manuel-bentele.de
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Manuel Bentele <development@manuel-bentele.de>

The QCOW2 file format is added as a new file format driver module to the
existing loop device file format subsystem. The implementation of the QCOW2
file format is based on the original implementation from the QEMU project
and was ported to the Linux kernel space.

The current implementation of the QCOW2 file format supports the reading of
normal QCOW2 disk images as well as the reading of sparsed or compressed
QCOW2 images. Write support is missing and is not ported yet. Discard,
flush and reading or writing aio is missing, too, and can be implemented
together with QCOW version 1 support in the future.

Signed-off-by: Manuel Bentele <development@manuel-bentele.de>
---
 drivers/block/loop/Kconfig                    |   9 +
 drivers/block/loop/Makefile                   |   5 +
 drivers/block/loop/loop_file_fmt_qcow_cache.c | 218 ++++
 drivers/block/loop/loop_file_fmt_qcow_cache.h |  51 +
 .../block/loop/loop_file_fmt_qcow_cluster.c   | 270 +++++
 .../block/loop/loop_file_fmt_qcow_cluster.h   |  23 +
 drivers/block/loop/loop_file_fmt_qcow_main.c  | 945 ++++++++++++++++++
 drivers/block/loop/loop_file_fmt_qcow_main.h  | 417 ++++++++
 8 files changed, 1938 insertions(+)
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_cache.c
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_cache.h
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_cluster.c
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_cluster.h
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_main.c
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_main.h

diff --git a/drivers/block/loop/Kconfig b/drivers/block/loop/Kconfig
index 355f1554b848..a3fa6768c7d7 100644
--- a/drivers/block/loop/Kconfig
+++ b/drivers/block/loop/Kconfig
@@ -82,3 +82,12 @@ config BLK_DEV_LOOP_FILE_FMT_RAW
 	---help---
 	  Say Y or M here if you want to enable the binary (RAW) file format
 	  support of the loop device module.
+
+config BLK_DEV_LOOP_FILE_FMT_QCOW
+	tristate "Loop device QCOW file format support"
+	  select ZLIB_INFLATE
+	  select ZLIB_DEFLATE
+	  depends on BLK_DEV_LOOP
+	  ---help---
+	    Say Y or M here if you want to enable the QEMU's copy on write (QCOW)
+	    file format support of the loop device module.
diff --git a/drivers/block/loop/Makefile b/drivers/block/loop/Makefile
index 2cd69e878453..f2fe116c2954 100644
--- a/drivers/block/loop/Makefile
+++ b/drivers/block/loop/Makefile
@@ -6,3 +6,8 @@ obj-$(CONFIG_BLK_DEV_LOOP)               += loop.o
 obj-$(CONFIG_BLK_DEV_CRYPTOLOOP)         += cryptoloop.o
 
 obj-$(CONFIG_BLK_DEV_LOOP_FILE_FMT_RAW)  += loop_file_fmt_raw.o
+
+loop_file_fmt_qcow-y                     += loop_file_fmt_qcow_main.o \
+                                            loop_file_fmt_qcow_cluster.o \
+                                            loop_file_fmt_qcow_cache.o
+obj-$(CONFIG_BLK_DEV_LOOP_FILE_FMT_QCOW) += loop_file_fmt_qcow.o
diff --git a/drivers/block/loop/loop_file_fmt_qcow_cache.c b/drivers/block/loop/loop_file_fmt_qcow_cache.c
new file mode 100644
index 000000000000..7d3af7398f04
--- /dev/null
+++ b/drivers/block/loop/loop_file_fmt_qcow_cache.c
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * loop_file_fmt_qcow_cache.c
+ *
+ * QCOW file format driver for the loop device module.
+ *
+ * Ported QCOW2 implementation of the QEMU project (GPL-2.0):
+ * L2/refcount table cache for the QCOW2 format.
+ *
+ * The copyright (C) 2010 of the original code is owned by
+ * Kevin Wolf <kwolf@redhat.com>
+ *
+ * Copyright (C) 2019 Manuel Bentele <development@manuel-bentele.de>
+ */
+
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/types.h>
+#include <linux/limits.h>
+#include <linux/fs.h>
+#include <linux/vmalloc.h>
+
+#include "loop_file_fmt_qcow_main.h"
+#include "loop_file_fmt_qcow_cache.h"
+
+static inline void *__loop_file_fmt_qcow_cache_get_table_addr(
+	struct loop_file_fmt_qcow_cache *c, int table)
+{
+	return (u8 *) c->table_array + (size_t) table * c->table_size;
+}
+
+static inline int __loop_file_fmt_qcow_cache_get_table_idx(
+	struct loop_file_fmt_qcow_cache *c, void *table)
+{
+	ptrdiff_t table_offset = (u8 *) table - (u8 *) c->table_array;
+	int idx = table_offset / c->table_size;
+	ASSERT(idx >= 0 && idx < c->size && table_offset % c->table_size == 0);
+	return idx;
+}
+
+static inline const char *__loop_file_fmt_qcow_cache_get_name(
+	struct loop_file_fmt *lo_fmt, struct loop_file_fmt_qcow_cache *c)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+
+	if (c == qcow_data->refcount_block_cache) {
+		return "refcount block";
+	} else if (c == qcow_data->l2_table_cache) {
+		return "L2 table";
+	} else {
+		/* do not abort, because this is not critical */
+		return "unknown";
+	}
+}
+
+struct loop_file_fmt_qcow_cache *loop_file_fmt_qcow_cache_create(
+	struct loop_file_fmt *lo_fmt, int num_tables, unsigned table_size)
+{
+#ifdef CONFIG_DEBUG_DRIVER
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+#endif
+	struct loop_file_fmt_qcow_cache *c;
+
+	ASSERT(num_tables > 0);
+	ASSERT(is_power_of_2(table_size));
+	ASSERT(table_size >= (1 << QCOW_MIN_CLUSTER_BITS));
+	ASSERT(table_size <= qcow_data->cluster_size);
+
+	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	if (!c) {
+		return NULL;
+	}
+
+	c->size = num_tables;
+	c->table_size = table_size;
+	c->entries = vzalloc(sizeof(struct loop_file_fmt_qcow_cache_table) *
+		num_tables);
+	c->table_array = vzalloc(num_tables * c->table_size);
+
+	if (!c->entries || !c->table_array) {
+		vfree(c->table_array);
+		vfree(c->entries);
+		kfree(c);
+		c = NULL;
+	}
+
+	return c;
+}
+
+void loop_file_fmt_qcow_cache_destroy(struct loop_file_fmt *lo_fmt)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	struct loop_file_fmt_qcow_cache *c = qcow_data->l2_table_cache;
+	int i;
+
+	for (i = 0; i < c->size; i++) {
+		ASSERT(c->entries[i].ref == 0);
+	}
+
+	vfree(c->table_array);
+	vfree(c->entries);
+	kfree(c);
+}
+
+static int __loop_file_fmt_qcow_cache_entry_flush(
+	struct loop_file_fmt_qcow_cache *c, int i)
+{
+	if (!c->entries[i].dirty || !c->entries[i].offset) {
+		return 0;
+	} else {
+		printk(KERN_ERR "loop_file_fmt_qcow: Flush dirty cache tables "
+			"is not supported yet\n");
+		return -ENOSYS;
+	}
+}
+
+static int __loop_file_fmt_qcow_cache_do_get(struct loop_file_fmt *lo_fmt,
+	struct loop_file_fmt_qcow_cache *c, u64 offset, void **table,
+	bool read_from_disk)
+{
+	struct loop_device *lo = loop_file_fmt_get_lo(lo_fmt);
+	int i;
+	int ret;
+	int lookup_index;
+	u64 min_lru_counter = U64_MAX;
+	int min_lru_index = -1;
+	u64 read_offset;
+	size_t len;
+
+	ASSERT(offset != 0);
+
+	if (!IS_ALIGNED(offset, c->table_size)) {
+		printk_ratelimited(KERN_ERR "loop_file_fmt_qcow: Cannot get "
+			"entry from %s cache: offset %llx is unaligned\n",
+			__loop_file_fmt_qcow_cache_get_name(lo_fmt, c),
+			offset);
+		return -EIO;
+	}
+
+	/* Check if the table is already cached */
+	i = lookup_index = (offset / c->table_size * 4) % c->size;
+	do {
+		const struct loop_file_fmt_qcow_cache_table *t =
+			&c->entries[i];
+		if (t->offset == offset) {
+			goto found;
+		}
+		if (t->ref == 0 && t->lru_counter < min_lru_counter) {
+			min_lru_counter = t->lru_counter;
+			min_lru_index = i;
+		}
+		if (++i == c->size) {
+			i = 0;
+		}
+	} while (i != lookup_index);
+
+	if (min_lru_index == -1) {
+		BUG();
+		panic("Oops: This can't happen in current synchronous code, "
+			"but leave the check here as a reminder for whoever "
+			"starts using AIO with the QCOW cache");
+	}
+
+	/* Cache miss: write a table back and replace it */
+	i = min_lru_index;
+
+	ret = __loop_file_fmt_qcow_cache_entry_flush(c, i);
+	if (ret < 0) {
+		return ret;
+	}
+
+	c->entries[i].offset = 0;
+	if (read_from_disk) {
+		read_offset = offset;
+		len = kernel_read(lo->lo_backing_file,
+			__loop_file_fmt_qcow_cache_get_table_addr(c, i),
+			c->table_size, &read_offset);
+		if (len < 0) {
+			len = ret;
+			return ret;
+		}
+	}
+
+	c->entries[i].offset = offset;
+
+	/* And return the right table */
+found:
+	c->entries[i].ref++;
+	*table = __loop_file_fmt_qcow_cache_get_table_addr(c, i);
+
+	return 0;
+}
+
+int loop_file_fmt_qcow_cache_get(struct loop_file_fmt *lo_fmt, u64 offset,
+	void **table)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	struct loop_file_fmt_qcow_cache *c = qcow_data->l2_table_cache;
+
+	return __loop_file_fmt_qcow_cache_do_get(lo_fmt, c, offset, table,
+		true);
+}
+
+void loop_file_fmt_qcow_cache_put(struct loop_file_fmt *lo_fmt, void **table)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	struct loop_file_fmt_qcow_cache *c = qcow_data->l2_table_cache;
+	int i = __loop_file_fmt_qcow_cache_get_table_idx(c, *table);
+
+	c->entries[i].ref--;
+	*table = NULL;
+
+	if (c->entries[i].ref == 0) {
+		c->entries[i].lru_counter = ++c->lru_counter;
+	}
+
+	ASSERT(c->entries[i].ref >= 0);
+}
diff --git a/drivers/block/loop/loop_file_fmt_qcow_cache.h b/drivers/block/loop/loop_file_fmt_qcow_cache.h
new file mode 100644
index 000000000000..1abf9b2b7c09
--- /dev/null
+++ b/drivers/block/loop/loop_file_fmt_qcow_cache.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * loop_file_fmt_qcow_cache.h
+ *
+ * Ported QCOW2 implementation of the QEMU project (GPL-2.0):
+ * L2/refcount table cache for the QCOW2 format.
+ *
+ * The copyright (C) 2010 of the original code is owned by
+ * Kevin Wolf <kwolf@redhat.com>
+ *
+ * Copyright (C) 2019 Manuel Bentele <development@manuel-bentele.de>
+ */
+
+#ifndef _LINUX_LOOP_FILE_FMT_QCOW_CACHE_H
+#define _LINUX_LOOP_FILE_FMT_QCOW_CACHE_H
+
+#include "loop_file_fmt.h"
+
+struct loop_file_fmt_qcow_cache_table {
+	s64 offset;
+	u64 lru_counter;
+	int ref;
+	bool dirty;
+};
+
+struct loop_file_fmt_qcow_cache {
+	struct loop_file_fmt_qcow_cache_table *entries;
+	struct loop_file_fmt_qcow_cache *depends;
+	int size;
+	int table_size;
+	bool depends_on_flush;
+	void *table_array;
+	u64 lru_counter;
+	u64 cache_clean_lru_counter;
+};
+
+extern struct loop_file_fmt_qcow_cache *loop_file_fmt_qcow_cache_create(
+	struct loop_file_fmt *lo_fmt,
+	int num_tables,
+	unsigned table_size);
+
+extern void loop_file_fmt_qcow_cache_destroy(struct loop_file_fmt *lo_fmt);
+
+extern int loop_file_fmt_qcow_cache_get(struct loop_file_fmt *lo_fmt,
+					u64 offset,
+					void **table);
+
+extern void loop_file_fmt_qcow_cache_put(struct loop_file_fmt *lo_fmt,
+					 void **table);
+
+#endif
diff --git a/drivers/block/loop/loop_file_fmt_qcow_cluster.c b/drivers/block/loop/loop_file_fmt_qcow_cluster.c
new file mode 100644
index 000000000000..9c91a8b4aeb7
--- /dev/null
+++ b/drivers/block/loop/loop_file_fmt_qcow_cluster.c
@@ -0,0 +1,270 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * loop_file_fmt_qcow_cluster.c
+ *
+ * Ported QCOW2 implementation of the QEMU project (GPL-2.0):
+ * Cluster calculation and lookup for the QCOW2 format.
+ *
+ * The copyright (C) 2004-2006 of the original code is owned by Fabrice Bellard.
+ *
+ * Copyright (C) 2019 Manuel Bentele <development@manuel-bentele.de>
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include "loop_file_fmt.h"
+#include "loop_file_fmt_qcow_main.h"
+#include "loop_file_fmt_qcow_cache.h"
+#include "loop_file_fmt_qcow_cluster.h"
+
+/*
+ * Loads a L2 slice into memory (L2 slices are the parts of L2 tables
+ * that are loaded by the qcow2 cache). If the slice is in the cache,
+ * the cache is used; otherwise the L2 slice is loaded from the image
+ * file.
+ */
+static int __loop_file_fmt_qcow_cluster_l2_load(struct loop_file_fmt *lo_fmt,
+	u64 offset, u64 l2_offset, u64 **l2_slice)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+
+	int start_of_slice = sizeof(u64) * (
+		loop_file_fmt_qcow_offset_to_l2_index(qcow_data, offset) -
+		loop_file_fmt_qcow_offset_to_l2_slice_index(qcow_data, offset)
+	);
+
+	ASSERT(qcow_data->l2_table_cache != NULL);
+	return loop_file_fmt_qcow_cache_get(lo_fmt, l2_offset + start_of_slice,
+		(void **) l2_slice);
+}
+
+/*
+ * Checks how many clusters in a given L2 slice are contiguous in the image
+ * file. As soon as one of the flags in the bitmask stop_flags changes compared
+ * to the first cluster, the search is stopped and the cluster is not counted
+ * as contiguous. (This allows it, for example, to stop at the first compressed
+ * cluster which may require a different handling)
+ */
+static int __loop_file_fmt_qcow_cluster_count_contiguous(
+	struct loop_file_fmt *lo_fmt, int nb_clusters, int cluster_size,
+	u64 *l2_slice, u64 stop_flags)
+{
+	int i;
+	enum loop_file_fmt_qcow_cluster_type first_cluster_type;
+	u64 mask = stop_flags | L2E_OFFSET_MASK | QCOW_OFLAG_COMPRESSED;
+	u64 first_entry = be64_to_cpu(l2_slice[0]);
+	u64 offset = first_entry & mask;
+
+	first_cluster_type = loop_file_fmt_qcow_get_cluster_type(lo_fmt,
+		first_entry);
+	if (first_cluster_type == QCOW_CLUSTER_UNALLOCATED) {
+		return 0;
+	}
+
+	/* must be allocated */
+	ASSERT(first_cluster_type == QCOW_CLUSTER_NORMAL ||
+		first_cluster_type == QCOW_CLUSTER_ZERO_ALLOC);
+
+	for (i = 0; i < nb_clusters; i++) {
+		u64 l2_entry = be64_to_cpu(l2_slice[i]) & mask;
+		if (offset + (u64) i * cluster_size != l2_entry) {
+			break;
+		}
+	}
+
+	return i;
+}
+
+/*
+ * Checks how many consecutive unallocated clusters in a given L2
+ * slice have the same cluster type.
+ */
+static int __loop_file_fmt_qcow_cluster_count_contiguous_unallocated(
+	struct loop_file_fmt *lo_fmt, int nb_clusters, u64 *l2_slice,
+	enum loop_file_fmt_qcow_cluster_type wanted_type)
+{
+	int i;
+
+	ASSERT(wanted_type == QCOW_CLUSTER_ZERO_PLAIN ||
+		wanted_type == QCOW_CLUSTER_UNALLOCATED);
+
+	for (i = 0; i < nb_clusters; i++) {
+		u64 entry = be64_to_cpu(l2_slice[i]);
+		enum loop_file_fmt_qcow_cluster_type type =
+			loop_file_fmt_qcow_get_cluster_type(lo_fmt, entry);
+
+		if (type != wanted_type) {
+			break;
+		}
+	}
+
+	return i;
+}
+
+/*
+ * For a given offset of the virtual disk, find the cluster type and offset in
+ * the qcow2 file. The offset is stored in *cluster_offset.
+ *
+ * On entry, *bytes is the maximum number of contiguous bytes starting at
+ * offset that we are interested in.
+ *
+ * On exit, *bytes is the number of bytes starting at offset that have the same
+ * cluster type and (if applicable) are stored contiguously in the image file.
+ * Compressed clusters are always returned one by one.
+ *
+ * Returns the cluster type (QCOW2_CLUSTER_*) on success, -errno in error
+ * cases.
+ */
+int loop_file_fmt_qcow_cluster_get_offset(struct loop_file_fmt *lo_fmt,
+	u64 offset, unsigned int *bytes, u64 *cluster_offset)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	unsigned int l2_index;
+	u64 l1_index, l2_offset, *l2_slice;
+	int c;
+	unsigned int offset_in_cluster;
+	u64 bytes_available, bytes_needed, nb_clusters;
+	enum loop_file_fmt_qcow_cluster_type type;
+	int ret;
+
+	offset_in_cluster = loop_file_fmt_qcow_offset_into_cluster(qcow_data,
+		offset);
+	bytes_needed = (u64) *bytes + offset_in_cluster;
+
+	/* compute how many bytes there are between the start of the cluster
+	 * containing offset and the end of the l2 slice that contains
+	 * the entry pointing to it */
+	bytes_available = ((u64)(
+		qcow_data->l2_slice_size -
+		loop_file_fmt_qcow_offset_to_l2_slice_index(qcow_data, offset))
+	) << qcow_data->cluster_bits;
+
+	if (bytes_needed > bytes_available) {
+		bytes_needed = bytes_available;
+	}
+
+	*cluster_offset = 0;
+
+	/* seek to the l2 offset in the l1 table */
+	l1_index = loop_file_fmt_qcow_offset_to_l1_index(qcow_data, offset);
+	if (l1_index >= qcow_data->l1_size) {
+		type = QCOW_CLUSTER_UNALLOCATED;
+		goto out;
+	}
+
+	l2_offset = qcow_data->l1_table[l1_index] & L1E_OFFSET_MASK;
+	if (!l2_offset) {
+		type = QCOW_CLUSTER_UNALLOCATED;
+		goto out;
+	}
+
+	if (loop_file_fmt_qcow_offset_into_cluster(qcow_data, l2_offset)) {
+		printk_ratelimited(KERN_ERR "loop_file_fmt_qcow: L2 table "
+			"offset %llx unaligned (L1 index: %llx)", l2_offset,
+			l1_index);
+		return -EIO;
+	}
+
+	/* load the l2 slice in memory */
+	ret = __loop_file_fmt_qcow_cluster_l2_load(lo_fmt, offset, l2_offset,
+		&l2_slice);
+	if (ret < 0) {
+		return ret;
+	}
+
+	/* find the cluster offset for the given disk offset */
+	l2_index = loop_file_fmt_qcow_offset_to_l2_slice_index(qcow_data,
+		offset);
+	*cluster_offset = be64_to_cpu(l2_slice[l2_index]);
+
+	nb_clusters = loop_file_fmt_qcow_size_to_clusters(qcow_data,
+		bytes_needed);
+	/* bytes_needed <= *bytes + offset_in_cluster, both of which are
+	 * unsigned integers; the minimum cluster size is 512, so this
+	 * assertion is always true */
+	ASSERT(nb_clusters <= INT_MAX);
+
+	type = loop_file_fmt_qcow_get_cluster_type(lo_fmt, *cluster_offset);
+	if (qcow_data->qcow_version < 3 && (
+			type == QCOW_CLUSTER_ZERO_PLAIN ||
+			type == QCOW_CLUSTER_ZERO_ALLOC)) {
+		printk_ratelimited(KERN_ERR "loop_file_fmt_qcow: zero cluster "
+			"entry found in pre-v3 image (L2 offset: %llx, "
+			"L2 index: %x)\n", l2_offset, l2_index);
+		ret = -EIO;
+		goto fail;
+	}
+	switch (type) {
+	case QCOW_CLUSTER_COMPRESSED:
+		if (loop_file_fmt_qcow_has_data_file(lo_fmt)) {
+			printk_ratelimited(KERN_ERR "loop_file_fmt_qcow: "
+				"compressed cluster entry found in image with "
+				"external data file (L2 offset: %llx, "
+				"L2 index: %x)", l2_offset, l2_index);
+			ret = -EIO;
+			goto fail;
+		}
+		/* Compressed clusters can only be processed one by one */
+		c = 1;
+		*cluster_offset &= L2E_COMPRESSED_OFFSET_SIZE_MASK;
+		break;
+	case QCOW_CLUSTER_ZERO_PLAIN:
+	case QCOW_CLUSTER_UNALLOCATED:
+		/* how many empty clusters ? */
+		c = __loop_file_fmt_qcow_cluster_count_contiguous_unallocated(
+			lo_fmt, nb_clusters, &l2_slice[l2_index], type);
+		*cluster_offset = 0;
+		break;
+	case QCOW_CLUSTER_ZERO_ALLOC:
+	case QCOW_CLUSTER_NORMAL:
+		/* how many allocated clusters ? */
+		c = __loop_file_fmt_qcow_cluster_count_contiguous(lo_fmt,
+			nb_clusters, qcow_data->cluster_size,
+			&l2_slice[l2_index], QCOW_OFLAG_ZERO);
+		*cluster_offset &= L2E_OFFSET_MASK;
+		if (loop_file_fmt_qcow_offset_into_cluster(qcow_data,
+				*cluster_offset)) {
+			printk_ratelimited(KERN_ERR "loop_file_fmt_qcow: "
+				"cluster allocation offset %llx unaligned "
+				"(L2 offset: %llx, L2 index: %x)\n",
+				*cluster_offset, l2_offset, l2_index);
+			ret = -EIO;
+			goto fail;
+		}
+		if (loop_file_fmt_qcow_has_data_file(lo_fmt) &&
+			*cluster_offset != offset - offset_in_cluster) {
+			printk_ratelimited(KERN_ERR "loop_file_fmt_qcow: "
+				"external data file host cluster offset %llx "
+				"does not match guest cluster offset: %llx, "
+				"L2 index: %x)", *cluster_offset,
+				offset - offset_in_cluster, l2_index);
+			ret = -EIO;
+			goto fail;
+		}
+		break;
+	default:
+		BUG();
+	}
+
+	loop_file_fmt_qcow_cache_put(lo_fmt, (void **) &l2_slice);
+
+	bytes_available = (s64) c * qcow_data->cluster_size;
+
+out:
+	if (bytes_available > bytes_needed) {
+		bytes_available = bytes_needed;
+	}
+
+	/* bytes_available <= bytes_needed <= *bytes + offset_in_cluster;
+	 * subtracting offset_in_cluster will therefore definitely yield
+	 * something not exceeding UINT_MAX */
+	ASSERT(bytes_available - offset_in_cluster <= UINT_MAX);
+	*bytes = bytes_available - offset_in_cluster;
+
+	return type;
+
+fail:
+	loop_file_fmt_qcow_cache_put(lo_fmt, (void **) &l2_slice);
+	return ret;
+}
diff --git a/drivers/block/loop/loop_file_fmt_qcow_cluster.h b/drivers/block/loop/loop_file_fmt_qcow_cluster.h
new file mode 100644
index 000000000000..d62e3318f6ce
--- /dev/null
+++ b/drivers/block/loop/loop_file_fmt_qcow_cluster.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * loop_file_fmt_qcow_cluster.h
+ *
+ * Ported QCOW2 implementation of the QEMU project (GPL-2.0):
+ * Cluster calculation and lookup for the QCOW2 format.
+ *
+ * The copyright (C) 2004-2006 of the original code is owned by Fabrice Bellard.
+ *
+ * Copyright (C) 2019 Manuel Bentele <development@manuel-bentele.de>
+ */
+
+#ifndef _LINUX_LOOP_FILE_FMT_QCOW_CLUSTER_H
+#define _LINUX_LOOP_FILE_FMT_QCOW_CLUSTER_H
+
+#include "loop_file_fmt.h"
+
+extern int loop_file_fmt_qcow_cluster_get_offset(struct loop_file_fmt *lo_fmt,
+						 u64 offset,
+						 unsigned int *bytes,
+						 u64 *cluster_offset);
+
+#endif
diff --git a/drivers/block/loop/loop_file_fmt_qcow_main.c b/drivers/block/loop/loop_file_fmt_qcow_main.c
new file mode 100644
index 000000000000..4fb786b340f7
--- /dev/null
+++ b/drivers/block/loop/loop_file_fmt_qcow_main.c
@@ -0,0 +1,945 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * loop_file_fmt_qcow.c
+ *
+ * QCOW file format driver for the loop device module.
+ *
+ * Copyright (C) 2019 Manuel Bentele <development@manuel-bentele.de>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/types.h>
+#include <linux/limits.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+#include <linux/bvec.h>
+#include <linux/mutex.h>
+#include <linux/uio.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+#include <linux/zlib.h>
+
+#include "loop_file_fmt.h"
+#include "loop_file_fmt_qcow_main.h"
+#include "loop_file_fmt_qcow_cache.h"
+#include "loop_file_fmt_qcow_cluster.h"
+
+static int __qcow_file_fmt_header_read(struct loop_file_fmt *lo_fmt,
+	struct loop_file_fmt_qcow_header *header)
+{
+	struct loop_device *lo = loop_file_fmt_get_lo(lo_fmt);
+	ssize_t len;
+	loff_t offset;
+	int ret = 0;
+
+	/* read QCOW header */
+	offset = 0;
+	len = kernel_read(lo->lo_backing_file, header, sizeof(*header),
+		&offset);
+	if (len < 0) {
+		printk(KERN_ERR "loop_file_fmt_qcow: could not read QCOW "
+			"header");
+		return len;
+	}
+
+	header->magic = be32_to_cpu(header->magic);
+	header->version = be32_to_cpu(header->version);
+	header->backing_file_offset = be64_to_cpu(header->backing_file_offset);
+	header->backing_file_size = be32_to_cpu(header->backing_file_size);
+	header->cluster_bits = be32_to_cpu(header->cluster_bits);
+	header->size = be64_to_cpu(header->size);
+	header->crypt_method = be32_to_cpu(header->crypt_method);
+	header->l1_size = be32_to_cpu(header->l1_size);
+	header->l1_table_offset = be64_to_cpu(header->l1_table_offset);
+	header->refcount_table_offset =
+		be64_to_cpu(header->refcount_table_offset);
+	header->refcount_table_clusters =
+		be32_to_cpu(header->refcount_table_clusters);
+	header->nb_snapshots = be32_to_cpu(header->nb_snapshots);
+	header->snapshots_offset = be64_to_cpu(header->snapshots_offset);
+
+	/* check QCOW file format and header version */
+	if (header->magic != QCOW_MAGIC) {
+		printk(KERN_ERR "loop_file_fmt_qcow: image is not in QCOW "
+			"format");
+		return -EINVAL;
+	}
+
+	if (header->version < 2 || header->version > 3) {
+		printk(KERN_ERR "loop_file_fmt_qcow: unsupported QCOW version "
+			"%d", header->version);
+		return -ENOTSUPP;
+	}
+
+	/* initialize version 3 header fields */
+	if (header->version == 2) {
+		header->incompatible_features =  0;
+		header->compatible_features   =  0;
+		header->autoclear_features    =  0;
+		header->refcount_order        =  4;
+		header->header_length         = 72;
+	} else {
+		header->incompatible_features =
+			be64_to_cpu(header->incompatible_features);
+		header->compatible_features =
+			be64_to_cpu(header->compatible_features);
+		header->autoclear_features =
+			be64_to_cpu(header->autoclear_features);
+		header->refcount_order = be32_to_cpu(header->refcount_order);
+		header->header_length = be32_to_cpu(header->header_length);
+
+		if (header->header_length < 104) {
+			printk(KERN_ERR "loop_file_fmt_qcow: QCOW header too "
+				"short");
+			return -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static int __qcow_file_fmt_validate_table(struct loop_file_fmt *lo_fmt,
+	u64 offset, u64 entries, size_t entry_len, s64 max_size_bytes,
+	const char *table_name)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+
+	if (entries > max_size_bytes / entry_len) {
+		printk(KERN_INFO "loop_file_fmt_qcow: %s too large",
+			table_name);
+		return -EFBIG;
+	}
+
+	/* Use signed S64_MAX as the maximum even for u64 header fields,
+	 * because values will be passed to qemu functions taking s64. */
+	if ((S64_MAX - entries * entry_len < offset) || (
+		loop_file_fmt_qcow_offset_into_cluster(qcow_data, offset) != 0)
+	) {
+		printk(KERN_INFO "loop_file_fmt_qcow: %s offset invalid",
+			table_name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline loff_t __qcow_file_fmt_rq_get_pos(struct loop_file_fmt *lo_fmt,
+						struct request *rq)
+{
+	struct loop_device *lo = loop_file_fmt_get_lo(lo_fmt);
+	return ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
+}
+
+static int __qcow_file_fmt_compression_init(struct loop_file_fmt *lo_fmt)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	int ret = 0;
+
+	qcow_data->strm = kzalloc(sizeof(*qcow_data->strm), GFP_KERNEL);
+	if (!qcow_data->strm) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	qcow_data->strm->workspace = vzalloc(zlib_inflate_workspacesize());
+	if (!qcow_data->strm->workspace) {
+		ret = -ENOMEM;
+		goto out_free_strm;
+	}
+
+	return ret;
+
+out_free_strm:
+	kfree(qcow_data->strm);
+out:
+	return ret;
+}
+
+static void __qcow_file_fmt_compression_exit(struct loop_file_fmt *lo_fmt)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+
+	if (qcow_data->strm->workspace)
+		vfree(qcow_data->strm->workspace);
+
+	if (qcow_data->strm)
+		kfree(qcow_data->strm);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void __qcow_file_fmt_header_to_buf(struct loop_file_fmt *lo_fmt,
+	const struct loop_file_fmt_qcow_header *header)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	char *header_buf = qcow_data->dbgfs_file_qcow_header_buf;
+	ssize_t len = 0;
+
+	len += sprintf(header_buf + len, "magic: %d\n",
+		header->magic);
+	len += sprintf(header_buf + len, "version: %d\n",
+		header->version);
+	len += sprintf(header_buf + len, "backing_file_offset: %lld\n",
+		header->backing_file_offset);
+	len += sprintf(header_buf + len, "backing_file_size: %d\n",
+		header->backing_file_size);
+	len += sprintf(header_buf + len, "cluster_bits: %d\n",
+		header->cluster_bits);
+	len += sprintf(header_buf + len, "size: %lld\n",
+		header->size);
+	len += sprintf(header_buf + len, "crypt_method: %d\n",
+		header->crypt_method);
+	len += sprintf(header_buf + len, "l1_size: %d\n",
+		header->l1_size);
+	len += sprintf(header_buf + len, "l1_table_offset: %lld\n",
+		header->l1_table_offset);
+	len += sprintf(header_buf + len, "refcount_table_offset: %lld\n",
+		header->refcount_table_offset);
+	len += sprintf(header_buf + len, "refcount_table_clusters: %d\n",
+		header->refcount_table_clusters);
+	len += sprintf(header_buf + len, "nb_snapshots: %d\n",
+		header->nb_snapshots);
+	len += sprintf(header_buf + len, "snapshots_offset: %lld\n",
+		header->snapshots_offset);
+
+	if (header->version == 3) {
+		len += sprintf(header_buf + len,
+			"incompatible_features: %lld\n",
+			header->incompatible_features);
+		len += sprintf(header_buf + len,
+			"compatible_features: %lld\n",
+			header->compatible_features);
+		len += sprintf(header_buf + len,
+			"autoclear_features: %lld\n",
+			header->autoclear_features);
+		len += sprintf(header_buf + len,
+			"refcount_order: %d\n",
+			header->refcount_order);
+		len += sprintf(header_buf + len,
+			"header_length: %d\n",
+			header->header_length);
+	}
+
+	ASSERT(len < QCOW_HEADER_BUF_LEN);
+}
+
+static ssize_t __qcow_file_fmt_dbgfs_hdr_read(struct file *file,
+	char __user *buf, size_t size, loff_t *ppos)
+{
+	struct loop_file_fmt *lo_fmt = file->private_data;
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	char *header_buf = qcow_data->dbgfs_file_qcow_header_buf;
+
+	return simple_read_from_buffer(buf, size, ppos, header_buf,
+		strlen(header_buf));
+}
+
+static const struct file_operations qcow_file_fmt_dbgfs_hdr_fops = {
+	.open = simple_open,
+	.read = __qcow_file_fmt_dbgfs_hdr_read
+};
+
+static ssize_t __qcow_file_fmt_dbgfs_ofs_read(struct file *file,
+	char __user *buf, size_t size, loff_t *ppos)
+{
+	struct loop_file_fmt *lo_fmt = file->private_data;
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	unsigned int cur_bytes = 1;
+	u64 offset = 0;
+	u64 cluster_offset = 0;
+	s64 offset_in_cluster = 0;
+	ssize_t len = 0;
+	int ret = 0;
+
+	/* read the share debugfs offset */
+	ret = mutex_lock_interruptible(&qcow_data->dbgfs_qcow_offset_mutex);
+	if (ret)
+		return ret;
+
+	offset = qcow_data->dbgfs_qcow_offset;
+	mutex_unlock(&qcow_data->dbgfs_qcow_offset_mutex);
+
+	/* calculate and print the cluster offset */
+	ret = loop_file_fmt_qcow_cluster_get_offset(lo_fmt,
+		offset, &cur_bytes, &cluster_offset);
+	if (ret < 0)
+		return -EINVAL;
+
+	offset_in_cluster = loop_file_fmt_qcow_offset_into_cluster(qcow_data,
+		offset);
+
+	len = sprintf(qcow_data->dbgfs_file_qcow_cluster_buf,
+		"offset: %lld\ncluster_offset: %lld\noffset_in_cluster: %lld\n",
+		offset, cluster_offset, offset_in_cluster);
+
+	ASSERT(len < QCOW_CLUSTER_BUF_LEN);
+
+	return simple_read_from_buffer(buf, size, ppos,
+		qcow_data->dbgfs_file_qcow_cluster_buf, len);
+}
+
+static ssize_t __qcow_file_fmt_dbgfs_ofs_write(struct file *file,
+	const char __user *buf, size_t size, loff_t *ppos)
+{
+	struct loop_file_fmt *lo_fmt = file->private_data;
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	ssize_t len = 0;
+	int ret = 0;
+
+	if (*ppos > QCOW_OFFSET_BUF_LEN || size > QCOW_OFFSET_BUF_LEN)
+		return -EINVAL;
+
+	len = simple_write_to_buffer(qcow_data->dbgfs_file_qcow_offset_buf,
+		QCOW_OFFSET_BUF_LEN, ppos, buf, size);
+	if (len < 0)
+		return len;
+
+	qcow_data->dbgfs_file_qcow_offset_buf[len] = '\0';
+
+	ret = mutex_lock_interruptible(&qcow_data->dbgfs_qcow_offset_mutex);
+	if (ret)
+		return ret;
+
+	ret = kstrtou64(qcow_data->dbgfs_file_qcow_offset_buf, 10,
+		&qcow_data->dbgfs_qcow_offset);
+	if (ret < 0)
+		goto out;
+
+	ret = len;
+out:
+	mutex_unlock(&qcow_data->dbgfs_qcow_offset_mutex);
+	return ret;
+}
+
+static const struct file_operations qcow_file_fmt_dbgfs_ofs_fops = {
+	.open = simple_open,
+	.read = __qcow_file_fmt_dbgfs_ofs_read,
+	.write = __qcow_file_fmt_dbgfs_ofs_write
+};
+
+static int __qcow_file_fmt_dbgfs_init(struct loop_file_fmt *lo_fmt)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	struct loop_device *lo = loop_file_fmt_get_lo(lo_fmt);
+	int ret = 0;
+
+	qcow_data->dbgfs_dir = debugfs_create_dir("QCOW", lo->lo_dbgfs_dir);
+	if (IS_ERR_OR_NULL(qcow_data->dbgfs_dir)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	qcow_data->dbgfs_file_qcow_header = debugfs_create_file("header",
+		S_IRUGO, qcow_data->dbgfs_dir, lo_fmt,
+		&qcow_file_fmt_dbgfs_hdr_fops);
+	if (IS_ERR_OR_NULL(qcow_data->dbgfs_file_qcow_header)) {
+		ret = -ENODEV;
+		goto out_free_dbgfs_dir;
+	}
+
+	qcow_data->dbgfs_file_qcow_offset = debugfs_create_file("offset",
+		S_IRUGO | S_IWUSR, qcow_data->dbgfs_dir, lo_fmt,
+		&qcow_file_fmt_dbgfs_ofs_fops);
+	if (IS_ERR_OR_NULL(qcow_data->dbgfs_file_qcow_offset)) {
+		qcow_data->dbgfs_file_qcow_offset = NULL;
+		ret = -ENODEV;
+		goto out_free_dbgfs_hdr;
+	}
+
+	qcow_data->dbgfs_qcow_offset = 0;
+	mutex_init(&qcow_data->dbgfs_qcow_offset_mutex);
+
+	return ret;
+
+out_free_dbgfs_hdr:
+	debugfs_remove(qcow_data->dbgfs_file_qcow_header);
+	qcow_data->dbgfs_file_qcow_header = NULL;
+out_free_dbgfs_dir:
+	debugfs_remove(qcow_data->dbgfs_dir);
+	qcow_data->dbgfs_dir = NULL;
+out:
+	return ret;
+}
+
+static void __qcow_file_fmt_dbgfs_exit(struct loop_file_fmt *lo_fmt)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+
+	if (qcow_data->dbgfs_file_qcow_offset)
+		debugfs_remove(qcow_data->dbgfs_file_qcow_offset);
+
+	mutex_destroy(&qcow_data->dbgfs_qcow_offset_mutex);
+
+	if (qcow_data->dbgfs_file_qcow_header)
+		debugfs_remove(qcow_data->dbgfs_file_qcow_header);
+
+	if (qcow_data->dbgfs_dir)
+		debugfs_remove(qcow_data->dbgfs_dir);
+}
+#endif
+
+static int qcow_file_fmt_init(struct loop_file_fmt *lo_fmt)
+{
+	struct loop_file_fmt_qcow_data *qcow_data;
+	struct loop_device *lo = loop_file_fmt_get_lo(lo_fmt);
+	struct loop_file_fmt_qcow_header header;
+	u64 l1_vm_state_index;
+	u64 l2_cache_size;
+	u64 l2_cache_entry_size;
+	ssize_t len;
+	unsigned int i;
+	int ret = 0;
+
+	/* allocate memory for saving QCOW file format data */
+	qcow_data = kzalloc(sizeof(*qcow_data), GFP_KERNEL);
+	if (!qcow_data)
+		return -ENOMEM;
+
+	lo_fmt->private_data = qcow_data;
+
+	/* read the QCOW file header */
+	ret = __qcow_file_fmt_header_read(lo_fmt, &header);
+	if (ret)
+		goto free_qcow_data;
+
+	/* save information of the header fields in human readable format in
+	 * a file buffer to access it with debugfs */
+#ifdef CONFIG_DEBUG_FS
+	__qcow_file_fmt_header_to_buf(lo_fmt, &header);
+#endif
+
+	qcow_data->qcow_version = header.version;
+
+	/* Initialise cluster size */
+	if (header.cluster_bits < QCOW_MIN_CLUSTER_BITS
+		|| header.cluster_bits > QCOW_MAX_CLUSTER_BITS) {
+		printk(KERN_ERR "loop_file_fmt_qcow: unsupported cluster "
+			"size: 2^%d", header.cluster_bits);
+		ret = -EINVAL;
+		goto free_qcow_data;
+	}
+
+	qcow_data->cluster_bits = header.cluster_bits;
+	qcow_data->cluster_size = 1 << qcow_data->cluster_bits;
+	qcow_data->cluster_sectors = 1 <<
+		(qcow_data->cluster_bits - SECTOR_SHIFT);
+
+	if (header.header_length > qcow_data->cluster_size) {
+		printk(KERN_ERR "loop_file_fmt_qcow: QCOW header exceeds "
+			"cluster size");
+		ret = -EINVAL;
+		goto free_qcow_data;
+	}
+
+	if (header.backing_file_offset > qcow_data->cluster_size) {
+		printk(KERN_ERR "loop_file_fmt_qcow: invalid backing file "
+			"offset");
+		ret = -EINVAL;
+		goto free_qcow_data;
+	}
+
+	if (header.backing_file_offset) {
+		printk(KERN_ERR "loop_file_fmt_qcow: backing file support not "
+			"available");
+		ret = -ENOTSUPP;
+		goto free_qcow_data;
+	}
+
+	/* handle feature bits */
+	qcow_data->incompatible_features = header.incompatible_features;
+	qcow_data->compatible_features = header.compatible_features;
+	qcow_data->autoclear_features = header.autoclear_features;
+
+	if (qcow_data->incompatible_features & QCOW_INCOMPAT_DIRTY) {
+		printk(KERN_ERR "loop_file_fmt_qcow: image contains "
+			"inconsistent refcounts");
+		ret = -EACCES;
+		goto free_qcow_data;
+	}
+
+	if (qcow_data->incompatible_features & QCOW_INCOMPAT_CORRUPT) {
+		printk(KERN_ERR "loop_file_fmt_qcow: image is corrupt; cannot "
+			"be opened read/write");
+		ret = -EACCES;
+		goto free_qcow_data;
+	}
+
+	if (qcow_data->incompatible_features & QCOW_INCOMPAT_DATA_FILE) {
+		printk(KERN_ERR "loop_file_fmt_qcow: clusters in the external "
+			"data file are not refcounted");
+		ret = -EACCES;
+		goto free_qcow_data;
+	}
+
+	/* Check support for various header values */
+	if (header.refcount_order > 6) {
+		printk(KERN_ERR "loop_file_fmt_qcow: reference count entry "
+			"width too large; may not exceed 64 bits");
+		ret = -EINVAL;
+		goto free_qcow_data;
+	}
+	qcow_data->refcount_order = header.refcount_order;
+	qcow_data->refcount_bits = 1 << qcow_data->refcount_order;
+	qcow_data->refcount_max = U64_C(1) << (qcow_data->refcount_bits - 1);
+	qcow_data->refcount_max += qcow_data->refcount_max - 1;
+
+	qcow_data->crypt_method_header = header.crypt_method;
+	if (qcow_data->crypt_method_header) {
+		printk(KERN_ERR "loop_file_fmt_qcow: encryption support not "
+			"available");
+		ret = -ENOTSUPP;
+		goto free_qcow_data;
+	}
+
+	/* L2 is always one cluster */
+	qcow_data->l2_bits = qcow_data->cluster_bits - 3;
+	qcow_data->l2_size = 1 << qcow_data->l2_bits;
+	/* 2^(qcow_data->refcount_order - 3) is the refcount width in bytes */
+	qcow_data->refcount_block_bits = qcow_data->cluster_bits -
+		(qcow_data->refcount_order - 3);
+	qcow_data->refcount_block_size = 1 << qcow_data->refcount_block_bits;
+	qcow_data->size = header.size;
+	qcow_data->csize_shift = (62 - (qcow_data->cluster_bits - 8));
+	qcow_data->csize_mask = (1 << (qcow_data->cluster_bits - 8)) - 1;
+	qcow_data->cluster_offset_mask = (1LL << qcow_data->csize_shift) - 1;
+
+	qcow_data->refcount_table_offset = header.refcount_table_offset;
+	qcow_data->refcount_table_size = header.refcount_table_clusters <<
+		(qcow_data->cluster_bits - 3);
+
+	if (header.refcount_table_clusters == 0) {
+		printk(KERN_ERR "loop_file_fmt_qcow: image does not contain a "
+			"reference count table");
+		ret = -EINVAL;
+		goto free_qcow_data;
+	}
+
+	ret = __qcow_file_fmt_validate_table(lo_fmt,
+		qcow_data->refcount_table_offset,
+		header.refcount_table_clusters, qcow_data->cluster_size,
+		QCOW_MAX_REFTABLE_SIZE, "Reference count table");
+	if (ret < 0) {
+		goto free_qcow_data;
+	}
+
+	/* The total size in bytes of the snapshot table is checked in
+	 * qcow2_read_snapshots() because the size of each snapshot is
+	 * variable and we don't know it yet.
+	 * Here we only check the offset and number of snapshots. */
+	ret = __qcow_file_fmt_validate_table(lo_fmt, header.snapshots_offset,
+		header.nb_snapshots,
+		sizeof(struct loop_file_fmt_qcow_snapshot_header),
+		sizeof(struct loop_file_fmt_qcow_snapshot_header) *
+		QCOW_MAX_SNAPSHOTS, "Snapshot table");
+	if (ret < 0) {
+		goto free_qcow_data;
+	}
+
+	/* read the level 1 table */
+	ret = __qcow_file_fmt_validate_table(lo_fmt, header.l1_table_offset,
+		header.l1_size, sizeof(u64), QCOW_MAX_L1_SIZE,
+		"Active L1 table");
+	if (ret < 0) {
+		goto free_qcow_data;
+	}
+	qcow_data->l1_size = header.l1_size;
+	qcow_data->l1_table_offset = header.l1_table_offset;
+
+	l1_vm_state_index = loop_file_fmt_qcow_size_to_l1(qcow_data,
+		header.size);
+	if (l1_vm_state_index > INT_MAX) {
+		printk(KERN_ERR "loop_file_fmt_qcow: image is too big");
+		ret = -EFBIG;
+		goto free_qcow_data;
+	}
+	qcow_data->l1_vm_state_index = l1_vm_state_index;
+
+	/* the L1 table must contain at least enough entries to put header.size
+	 * bytes */
+	if (qcow_data->l1_size < qcow_data->l1_vm_state_index) {
+		printk(KERN_ERR "loop_file_fmt_qcow: L1 table is too small");
+		ret = -EINVAL;
+		goto free_qcow_data;
+	}
+
+	if (qcow_data->l1_size > 0) {
+		qcow_data->l1_table = vzalloc(round_up(qcow_data->l1_size *
+			sizeof(u64), 512));
+		if (qcow_data->l1_table == NULL) {
+			printk(KERN_ERR "loop_file_fmt_qcow: could not "
+				"allocate L1 table");
+			ret = -ENOMEM;
+			goto free_qcow_data;
+		}
+		len = kernel_read(lo->lo_backing_file, qcow_data->l1_table,
+			qcow_data->l1_size * sizeof(u64),
+			&qcow_data->l1_table_offset);
+		if (len < 0) {
+			printk(KERN_ERR "loop_file_fmt_qcow: could not read L1 "
+				"table");
+			ret = len;
+			goto free_l1_table;
+		}
+		for (i = 0; i < qcow_data->l1_size; i++) {
+			qcow_data->l1_table[i] =
+				be64_to_cpu(qcow_data->l1_table[i]);
+		}
+	}
+
+	/* Internal snapshots */
+	qcow_data->snapshots_offset = header.snapshots_offset;
+	qcow_data->nb_snapshots = header.nb_snapshots;
+
+	if (qcow_data->nb_snapshots > 0) {
+		printk(KERN_ERR "loop_file_fmt_qcow: snapshots support not "
+			"available");
+		ret = -ENOTSUPP;
+		goto free_l1_table;
+	}
+
+
+	/* create cache for L2 */
+	l2_cache_size =  qcow_data->size / (qcow_data->cluster_size / 8);
+	l2_cache_entry_size = min(qcow_data->cluster_size, (int)4096);
+
+	/* limit the L2 size to maximum QCOW_DEFAULT_L2_CACHE_MAX_SIZE */
+	l2_cache_size = min(l2_cache_size, (u64)QCOW_DEFAULT_L2_CACHE_MAX_SIZE);
+
+	/* calculate the number of cache tables */
+	l2_cache_size /= l2_cache_entry_size;
+	if (l2_cache_size < QCOW_MIN_L2_CACHE_SIZE) {
+		l2_cache_size = QCOW_MIN_L2_CACHE_SIZE;
+	}
+
+	if (l2_cache_size > INT_MAX) {
+		printk(KERN_ERR "loop_file_fmt_qcow: L2 cache size too big");
+		ret = -EINVAL;
+		goto free_l1_table;
+	}
+
+	qcow_data->l2_slice_size = l2_cache_entry_size / sizeof(u64);
+
+	qcow_data->l2_table_cache = loop_file_fmt_qcow_cache_create(lo_fmt,
+		l2_cache_size, l2_cache_entry_size);
+	if (!qcow_data->l2_table_cache) {
+		ret = -ENOMEM;
+		goto free_l1_table;
+	}
+
+	/* initialize compression support */
+	ret = __qcow_file_fmt_compression_init(lo_fmt);
+	if (ret < 0)
+		goto free_l2_cache;
+
+	/* initialize debugfs entries */
+#ifdef CONFIG_DEBUG_FS
+	ret = __qcow_file_fmt_dbgfs_init(lo_fmt);
+	if (ret < 0)
+		goto free_l2_cache;
+#endif
+
+	return ret;
+
+free_l2_cache:
+	loop_file_fmt_qcow_cache_destroy(lo_fmt);
+free_l1_table:
+	vfree(qcow_data->l1_table);
+free_qcow_data:
+	kfree(qcow_data);
+	lo_fmt->private_data = NULL;
+	return ret;
+}
+
+static void qcow_file_fmt_exit(struct loop_file_fmt *lo_fmt)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+
+#ifdef CONFIG_DEBUG_FS
+	__qcow_file_fmt_dbgfs_exit(lo_fmt);
+#endif
+
+	__qcow_file_fmt_compression_exit(lo_fmt);
+
+	if (qcow_data->l1_table) {
+		vfree(qcow_data->l1_table);
+	}
+
+	if (qcow_data->l2_table_cache) {
+		loop_file_fmt_qcow_cache_destroy(lo_fmt);
+	}
+
+	if (qcow_data) {
+		kfree(qcow_data);
+		lo_fmt->private_data = NULL;
+	}
+}
+
+static ssize_t __qcow_file_fmt_buffer_decompress(struct loop_file_fmt *lo_fmt,
+						 void *dest,
+						 size_t dest_size,
+						 const void *src,
+						 size_t src_size)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	int ret = 0;
+
+	qcow_data->strm->avail_in = src_size;
+	qcow_data->strm->next_in = (void *) src;
+	qcow_data->strm->avail_out = dest_size;
+	qcow_data->strm->next_out = dest;
+
+	ret = zlib_inflateInit2(qcow_data->strm, -12);
+	if (ret != Z_OK) {
+		return -1;
+	}
+
+	ret = zlib_inflate(qcow_data->strm, Z_FINISH);
+	if ((ret != Z_STREAM_END && ret != Z_BUF_ERROR)
+		|| qcow_data->strm->avail_out != 0) {
+		/* We approve Z_BUF_ERROR because we need @dest buffer to be
+		 * filled, but @src buffer may be processed partly (because in
+		 * qcow2 we know size of compressed data with precision of one
+		 * sector) */
+		ret = -1;
+	}
+
+	zlib_inflateEnd(qcow_data->strm);
+
+	return ret;
+}
+
+static int __qcow_file_fmt_read_compressed(struct loop_file_fmt *lo_fmt,
+					   struct bio_vec *bvec,
+					   u64 file_cluster_offset,
+					   u64 offset,
+					   u64 bytes,
+					   u64 bytes_done)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	struct loop_device *lo = loop_file_fmt_get_lo(lo_fmt);
+	int ret = 0, csize, nb_csectors;
+	u64 coffset;
+	u8 *in_buf, *out_buf;
+	ssize_t len;
+	void *data;
+	unsigned long irq_flags;
+	int offset_in_cluster = loop_file_fmt_qcow_offset_into_cluster(
+		qcow_data, offset);
+
+	coffset = file_cluster_offset & qcow_data->cluster_offset_mask;
+	nb_csectors = ((file_cluster_offset >> qcow_data->csize_shift) &
+		qcow_data->csize_mask) + 1;
+	csize = nb_csectors * QCOW_COMPRESSED_SECTOR_SIZE -
+		(coffset & ~QCOW_COMPRESSED_SECTOR_MASK);
+
+	in_buf = vmalloc(csize);
+	if (!in_buf) {
+		return -ENOMEM;
+	}
+
+	out_buf = vmalloc(qcow_data->cluster_size);
+	if (!out_buf) {
+		ret = -ENOMEM;
+		goto out_free_in_buf;
+	}
+
+	len = kernel_read(lo->lo_backing_file, in_buf, csize, &coffset);
+	if (len < 0) {
+		ret = len;
+		goto out_free_out_buf;
+	}
+
+	if (__qcow_file_fmt_buffer_decompress(lo_fmt, out_buf,
+		qcow_data->cluster_size, in_buf, csize) < 0) {
+		ret = -EIO;
+		goto out_free_out_buf;
+	}
+
+	ASSERT(bytes <= bvec->bv_len);
+	data = bvec_kmap_irq(bvec, &irq_flags) + bytes_done;
+	memcpy(data, out_buf + offset_in_cluster, bytes);
+	flush_dcache_page(bvec->bv_page);
+	bvec_kunmap_irq(data, &irq_flags);
+
+out_free_out_buf:
+	vfree(out_buf);
+out_free_in_buf:
+	vfree(in_buf);
+
+	return ret;
+}
+
+static int __qcow_file_fmt_read_bvec(struct loop_file_fmt *lo_fmt,
+				     struct bio_vec *bvec,
+				     loff_t *ppos)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	struct loop_device *lo = loop_file_fmt_get_lo(lo_fmt);
+	int offset_in_cluster;
+	int ret;
+	unsigned int cur_bytes; /* number of bytes in current iteration */
+	u64 bytes;
+	u64 cluster_offset = 0;
+	u64 bytes_done = 0;
+	void *data;
+	unsigned long irq_flags;
+	ssize_t len;
+	loff_t pos_read;
+
+	bytes = bvec->bv_len;
+
+	while (bytes != 0) {
+
+		/* prepare next request */
+		cur_bytes = bytes;
+
+		ret = loop_file_fmt_qcow_cluster_get_offset(lo_fmt, *ppos,
+			&cur_bytes, &cluster_offset);
+		if (ret < 0) {
+			goto fail;
+		}
+
+		offset_in_cluster = loop_file_fmt_qcow_offset_into_cluster(
+			qcow_data, *ppos);
+
+		switch (ret) {
+		case QCOW_CLUSTER_UNALLOCATED:
+		case QCOW_CLUSTER_ZERO_PLAIN:
+		case QCOW_CLUSTER_ZERO_ALLOC:
+			data = bvec_kmap_irq(bvec, &irq_flags) + bytes_done;
+			memset(data, 0, cur_bytes);
+			flush_dcache_page(bvec->bv_page);
+			bvec_kunmap_irq(data, &irq_flags);
+			break;
+
+		case QCOW_CLUSTER_COMPRESSED:
+			ret = __qcow_file_fmt_read_compressed(lo_fmt, bvec,
+				cluster_offset, *ppos, cur_bytes, bytes_done);
+			if (ret < 0) {
+				goto fail;
+			}
+
+			break;
+
+		case QCOW_CLUSTER_NORMAL:
+			if ((cluster_offset & 511) != 0) {
+				ret = -EIO;
+				goto fail;
+			}
+
+			pos_read = cluster_offset + offset_in_cluster;
+
+			data = bvec_kmap_irq(bvec, &irq_flags) + bytes_done;
+			len = kernel_read(lo->lo_backing_file, data, cur_bytes,
+				&pos_read);
+			flush_dcache_page(bvec->bv_page);
+			bvec_kunmap_irq(data, &irq_flags);
+
+			if (len < 0)
+				return len;
+
+			break;
+
+		default:
+			ret = -EIO;
+			goto fail;
+		}
+
+		bytes -= cur_bytes;
+		*ppos += cur_bytes;
+		bytes_done += cur_bytes;
+	}
+
+	ret = 0;
+
+fail:
+	return ret;
+}
+
+static int qcow_file_fmt_read(struct loop_file_fmt *lo_fmt,
+			      struct request *rq)
+{
+	struct bio_vec bvec;
+	struct req_iterator iter;
+	loff_t pos;
+	int ret = 0;
+
+	pos = __qcow_file_fmt_rq_get_pos(lo_fmt, rq);
+
+	rq_for_each_segment(bvec, rq, iter) {
+		ret = __qcow_file_fmt_read_bvec(lo_fmt, &bvec, &pos);
+		if (ret)
+			return ret;
+
+		cond_resched();
+	}
+
+	return ret;
+}
+
+static loff_t qcow_file_fmt_sector_size(struct loop_file_fmt *lo_fmt)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	struct loop_device *lo = loop_file_fmt_get_lo(lo_fmt);
+	loff_t loopsize;
+
+	if (qcow_data->size > 0)
+		loopsize = qcow_data->size;
+	else
+		return 0;
+
+	if (lo->lo_offset > 0)
+		loopsize -= lo->lo_offset;
+
+	if (lo->lo_sizelimit > 0 && lo->lo_sizelimit < loopsize)
+		loopsize = lo->lo_sizelimit;
+
+	/*
+	 * Unfortunately, if we want to do I/O on the device,
+	 * the number of 512-byte sectors has to fit into a sector_t.
+	 */
+	return loopsize >> 9;
+}
+
+static struct loop_file_fmt_ops qcow_file_fmt_ops = {
+	.init = qcow_file_fmt_init,
+	.exit = qcow_file_fmt_exit,
+	.read = qcow_file_fmt_read,
+	.write = NULL,
+	.read_aio = NULL,
+	.write_aio = NULL,
+	.discard = NULL,
+	.flush = NULL,
+	.sector_size = qcow_file_fmt_sector_size
+};
+
+static struct loop_file_fmt_driver qcow_file_fmt_driver = {
+	.name = "QCOW",
+	.file_fmt_type = LO_FILE_FMT_QCOW,
+	.ops = &qcow_file_fmt_ops,
+	.owner = THIS_MODULE
+};
+
+static int __init loop_file_fmt_qcow_init(void)
+{
+	printk(KERN_INFO "loop_file_fmt_qcow: init loop device QCOW file "
+		"format driver");
+	return loop_file_fmt_register_driver(&qcow_file_fmt_driver);
+}
+
+static void __exit loop_file_fmt_qcow_exit(void)
+{
+	printk(KERN_INFO "loop_file_fmt_qcow: exit loop device QCOW file "
+		"format driver");
+	loop_file_fmt_unregister_driver(&qcow_file_fmt_driver);
+}
+
+module_init(loop_file_fmt_qcow_init);
+module_exit(loop_file_fmt_qcow_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Manuel Bentele <development@manuel-bentele.de>");
+MODULE_DESCRIPTION("Loop device QCOW file format driver");
+MODULE_SOFTDEP("pre: loop");
diff --git a/drivers/block/loop/loop_file_fmt_qcow_main.h b/drivers/block/loop/loop_file_fmt_qcow_main.h
new file mode 100644
index 000000000000..9e4951fba079
--- /dev/null
+++ b/drivers/block/loop/loop_file_fmt_qcow_main.h
@@ -0,0 +1,417 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * loop_file_fmt_qcow.h
+ *
+ * QCOW file format driver for the loop device module.
+ *
+ * Ported QCOW2 implementation of the QEMU project (GPL-2.0):
+ * Declarations for the QCOW2 file format.
+ *
+ * The copyright (C) 2004-2006 of the original code is owned by Fabrice Bellard.
+ *
+ * Copyright (C) 2019 Manuel Bentele <development@manuel-bentele.de>
+ */
+
+#ifndef _LINUX_LOOP_FILE_FMT_QCOW_H
+#define _LINUX_LOOP_FILE_FMT_QCOW_H
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/zlib.h>
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
+
+#include "loop_file_fmt.h"
+
+#ifdef CONFIG_DEBUG_DRIVER
+#define ASSERT(x)  							\
+do {									\
+	if (!(x)) {							\
+		printk(KERN_EMERG "assertion failed %s: %d: %s\n",	\
+		       __FILE__, __LINE__, #x);				\
+		BUG();							\
+	}								\
+} while (0)
+#else
+#define ASSERT(x) do { } while (0)
+#endif
+
+#define KiB (1024)
+#define MiB (1024 * 1024)
+
+#define QCOW_MAGIC (('Q' << 24) | ('F' << 16) | ('I' << 8) | 0xfb)
+
+#define QCOW_CRYPT_NONE 0
+#define QCOW_CRYPT_AES  1
+#define QCOW_CRYPT_LUKS 2
+
+#define QCOW_MAX_CRYPT_CLUSTERS 32
+#define QCOW_MAX_SNAPSHOTS 65536
+
+/* Field widths in QCOW mean normal cluster offsets cannot reach
+ * 64PB; depending on cluster size, compressed clusters can have a
+ * smaller limit (64PB for up to 16k clusters, then ramps down to
+ * 512TB for 2M clusters).  */
+#define QCOW_MAX_CLUSTER_OFFSET ((1ULL << 56) - 1)
+
+/* 8 MB refcount table is enough for 2 PB images at 64k cluster size
+ * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
+#define QCOW_MAX_REFTABLE_SIZE (8 * MiB)
+
+/* 32 MB L1 table is enough for 2 PB images at 64k cluster size
+ * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
+#define QCOW_MAX_L1_SIZE (32 * MiB)
+
+/* Allow for an average of 1k per snapshot table entry, should be plenty of
+ * space for snapshot names and IDs */
+#define QCOW_MAX_SNAPSHOTS_SIZE (1024 * QCOW_MAX_SNAPSHOTS)
+
+/* Bitmap header extension constraints */
+#define QCOW_MAX_BITMAPS 65535
+#define QCOW_MAX_BITMAP_DIRECTORY_SIZE (1024 * QCOW_MAX_BITMAPS)
+
+/* indicate that the refcount of the referenced cluster is exactly one. */
+#define QCOW_OFLAG_COPIED     (1ULL << 63)
+/* indicate that the cluster is compressed (they never have the copied flag) */
+#define QCOW_OFLAG_COMPRESSED (1ULL << 62)
+/* The cluster reads as all zeros */
+#define QCOW_OFLAG_ZERO (1ULL << 0)
+
+#define QCOW_MIN_CLUSTER_BITS 9
+#define QCOW_MAX_CLUSTER_BITS 21
+
+/* Defined in the qcow2 spec (compressed cluster descriptor) */
+#define QCOW_COMPRESSED_SECTOR_SIZE 512U
+#define QCOW_COMPRESSED_SECTOR_MASK (~(QCOW_COMPRESSED_SECTOR_SIZE - 1))
+
+/* Must be at least 2 to cover COW */
+#define QCOW_MIN_L2_CACHE_SIZE 2 /* cache entries */
+
+/* Must be at least 4 to cover all cases of refcount table growth */
+#define QCOW_MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
+
+#define QCOW_DEFAULT_L2_CACHE_MAX_SIZE (32 * MiB)
+#define QCOW_DEFAULT_CACHE_CLEAN_INTERVAL 600  /* seconds */
+
+#define QCOW_DEFAULT_CLUSTER_SIZE 65536
+
+/* Buffer size for debugfs file buffer to display QCOW header information */
+#define QCOW_HEADER_BUF_LEN 1024
+
+/* Buffer size for debugfs file buffer to receive and display offset and
+ * cluster offset information */
+#define QCOW_OFFSET_BUF_LEN 32
+#define QCOW_CLUSTER_BUF_LEN 128
+
+struct loop_file_fmt_qcow_header {
+	u32 magic;
+	u32 version;
+	u64 backing_file_offset;
+	u32 backing_file_size;
+	u32 cluster_bits;
+	u64 size; /* in bytes */
+	u32 crypt_method;
+	u32 l1_size;
+	u64 l1_table_offset;
+	u64 refcount_table_offset;
+	u32 refcount_table_clusters;
+	u32 nb_snapshots;
+	u64 snapshots_offset;
+
+	/* The following fields are only valid for version >= 3 */
+	u64 incompatible_features;
+	u64 compatible_features;
+	u64 autoclear_features;
+
+	u32 refcount_order;
+	u32 header_length;
+} __attribute__((packed));
+
+struct loop_file_fmt_qcow_snapshot_header {
+	/* header is 8 byte aligned */
+	u64 l1_table_offset;
+
+	u32 l1_size;
+	u16 id_str_size;
+	u16 name_size;
+
+	u32 date_sec;
+	u32 date_nsec;
+
+	u64 vm_clock_nsec;
+
+	u32 vm_state_size;
+	/* for extension */
+	u32 extra_data_size;
+	/* extra data follows */
+	/* id_str follows */
+	/* name follows  */
+} __attribute__((packed));
+
+enum {
+	QCOW_FEAT_TYPE_INCOMPATIBLE    = 0,
+	QCOW_FEAT_TYPE_COMPATIBLE      = 1,
+	QCOW_FEAT_TYPE_AUTOCLEAR       = 2,
+};
+
+/* incompatible feature bits */
+enum {
+	QCOW_INCOMPAT_DIRTY_BITNR      = 0,
+	QCOW_INCOMPAT_CORRUPT_BITNR    = 1,
+	QCOW_INCOMPAT_DATA_FILE_BITNR  = 2,
+	QCOW_INCOMPAT_DIRTY            = 1 << QCOW_INCOMPAT_DIRTY_BITNR,
+	QCOW_INCOMPAT_CORRUPT          = 1 << QCOW_INCOMPAT_CORRUPT_BITNR,
+	QCOW_INCOMPAT_DATA_FILE        = 1 << QCOW_INCOMPAT_DATA_FILE_BITNR,
+
+	QCOW_INCOMPAT_MASK             = QCOW_INCOMPAT_DIRTY
+					| QCOW_INCOMPAT_CORRUPT
+					| QCOW_INCOMPAT_DATA_FILE,
+};
+
+/* compatible feature bits */
+enum {
+	QCOW_COMPAT_LAZY_REFCOUNTS_BITNR = 0,
+	QCOW_COMPAT_LAZY_REFCOUNTS       = 1 << QCOW_COMPAT_LAZY_REFCOUNTS_BITNR,
+
+	QCOW_COMPAT_FEAT_MASK            = QCOW_COMPAT_LAZY_REFCOUNTS,
+};
+
+/* autoclear feature bits */
+enum {
+	QCOW_AUTOCLEAR_BITMAPS_BITNR       = 0,
+	QCOW_AUTOCLEAR_DATA_FILE_RAW_BITNR = 1,
+	QCOW_AUTOCLEAR_BITMAPS             = 1 << QCOW_AUTOCLEAR_BITMAPS_BITNR,
+	QCOW_AUTOCLEAR_DATA_FILE_RAW       = 1 << QCOW_AUTOCLEAR_DATA_FILE_RAW_BITNR,
+
+	QCOW_AUTOCLEAR_MASK                = QCOW_AUTOCLEAR_BITMAPS |
+						QCOW_AUTOCLEAR_DATA_FILE_RAW,
+};
+
+struct loop_file_fmt_qcow_data {
+	u64 size;
+	int cluster_bits;
+	int cluster_size;
+	int cluster_sectors;
+	int l2_slice_size;
+	int l2_bits;
+	int l2_size;
+	int l1_size;
+	int l1_vm_state_index;
+	int refcount_block_bits;
+	int refcount_block_size;
+	int csize_shift;
+	int csize_mask;
+	u64 cluster_offset_mask;
+	u64 l1_table_offset;
+	u64 *l1_table;
+
+	struct loop_file_fmt_qcow_cache *l2_table_cache;
+	struct loop_file_fmt_qcow_cache *refcount_block_cache;
+
+	u64 *refcount_table;
+	u64 refcount_table_offset;
+	u32 refcount_table_size;
+	u32 max_refcount_table_index; /* Last used entry in refcount_table */
+	u64 free_cluster_index;
+	u64 free_byte_offset;
+
+	u32 crypt_method_header;
+	u64 snapshots_offset;
+	int snapshots_size;
+	unsigned int nb_snapshots;
+
+	u32 nb_bitmaps;
+	u64 bitmap_directory_size;
+	u64 bitmap_directory_offset;
+
+	int qcow_version;
+	bool use_lazy_refcounts;
+	int refcount_order;
+	int refcount_bits;
+	u64 refcount_max;
+
+	u64 incompatible_features;
+	u64 compatible_features;
+	u64 autoclear_features;
+
+	struct z_stream_s *strm;
+
+	/* debugfs entries */
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dbgfs_dir;
+	struct dentry *dbgfs_file_qcow_header;
+	char dbgfs_file_qcow_header_buf[QCOW_HEADER_BUF_LEN];
+	struct dentry *dbgfs_file_qcow_offset;
+	char dbgfs_file_qcow_offset_buf[QCOW_OFFSET_BUF_LEN];
+	char dbgfs_file_qcow_cluster_buf[QCOW_CLUSTER_BUF_LEN];
+	u64 dbgfs_qcow_offset;
+	struct mutex dbgfs_qcow_offset_mutex;
+#endif
+};
+
+struct loop_file_fmt_qcow_cow_region {
+	/**
+	 * Offset of the COW region in bytes from the start of the first
+	 * cluster touched by the request.
+	 */
+	unsigned offset;
+
+	/** Number of bytes to copy */
+	unsigned nb_bytes;
+};
+
+enum loop_file_fmt_qcow_cluster_type {
+	QCOW_CLUSTER_UNALLOCATED,
+	QCOW_CLUSTER_ZERO_PLAIN,
+	QCOW_CLUSTER_ZERO_ALLOC,
+	QCOW_CLUSTER_NORMAL,
+	QCOW_CLUSTER_COMPRESSED,
+};
+
+enum loop_file_fmt_qcow_metadata_overlap {
+	QCOW_OL_MAIN_HEADER_BITNR      = 0,
+	QCOW_OL_ACTIVE_L1_BITNR        = 1,
+	QCOW_OL_ACTIVE_L2_BITNR        = 2,
+	QCOW_OL_REFCOUNT_TABLE_BITNR   = 3,
+	QCOW_OL_REFCOUNT_BLOCK_BITNR   = 4,
+	QCOW_OL_SNAPSHOT_TABLE_BITNR   = 5,
+	QCOW_OL_INACTIVE_L1_BITNR      = 6,
+	QCOW_OL_INACTIVE_L2_BITNR      = 7,
+	QCOW_OL_BITMAP_DIRECTORY_BITNR = 8,
+
+	QCOW_OL_MAX_BITNR              = 9,
+
+	QCOW_OL_NONE             = 0,
+	QCOW_OL_MAIN_HEADER      = (1 << QCOW_OL_MAIN_HEADER_BITNR),
+	QCOW_OL_ACTIVE_L1        = (1 << QCOW_OL_ACTIVE_L1_BITNR),
+	QCOW_OL_ACTIVE_L2        = (1 << QCOW_OL_ACTIVE_L2_BITNR),
+	QCOW_OL_REFCOUNT_TABLE   = (1 << QCOW_OL_REFCOUNT_TABLE_BITNR),
+	QCOW_OL_REFCOUNT_BLOCK   = (1 << QCOW_OL_REFCOUNT_BLOCK_BITNR),
+	QCOW_OL_SNAPSHOT_TABLE   = (1 << QCOW_OL_SNAPSHOT_TABLE_BITNR),
+	QCOW_OL_INACTIVE_L1      = (1 << QCOW_OL_INACTIVE_L1_BITNR),
+	/* NOTE: Checking overlaps with inactive L2 tables will result in bdrv
+	 * reads. */
+	QCOW_OL_INACTIVE_L2      = (1 << QCOW_OL_INACTIVE_L2_BITNR),
+	QCOW_OL_BITMAP_DIRECTORY = (1 << QCOW_OL_BITMAP_DIRECTORY_BITNR),
+};
+
+/* Perform all overlap checks which can be done in constant time */
+#define QCOW_OL_CONSTANT \
+	(QCOW_OL_MAIN_HEADER | QCOW_OL_ACTIVE_L1 | QCOW_OL_REFCOUNT_TABLE | \
+		QCOW_OL_SNAPSHOT_TABLE | QCOW_OL_BITMAP_DIRECTORY)
+
+/* Perform all overlap checks which don't require disk access */
+#define QCOW_OL_CACHED \
+	(QCOW_OL_CONSTANT | QCOW_OL_ACTIVE_L2 | QCOW_OL_REFCOUNT_BLOCK | \
+		QCOW_OL_INACTIVE_L1)
+
+/* Perform all overlap checks */
+#define QCOW_OL_ALL \
+	(QCOW_OL_CACHED | QCOW_OL_INACTIVE_L2)
+
+#define L1E_OFFSET_MASK 0x00fffffffffffe00ULL
+#define L2E_OFFSET_MASK 0x00fffffffffffe00ULL
+#define L2E_COMPRESSED_OFFSET_SIZE_MASK 0x3fffffffffffffffULL
+
+#define REFT_OFFSET_MASK 0xfffffffffffffe00ULL
+
+#define INV_OFFSET (-1ULL)
+
+static inline bool loop_file_fmt_qcow_has_data_file(
+	struct loop_file_fmt *lo_fmt)
+{
+	/* At the moment, there is no support for copy on write! */
+	return false;
+}
+
+static inline bool loop_file_fmt_qcow_data_file_is_raw(
+	struct loop_file_fmt *lo_fmt)
+{
+	struct loop_file_fmt_qcow_data *qcow_data = lo_fmt->private_data;
+	return !!(qcow_data->autoclear_features &
+		QCOW_AUTOCLEAR_DATA_FILE_RAW);
+}
+
+static inline s64 loop_file_fmt_qcow_start_of_cluster(
+	struct loop_file_fmt_qcow_data *qcow_data, s64 offset)
+{
+	return offset & ~(qcow_data->cluster_size - 1);
+}
+
+static inline s64 loop_file_fmt_qcow_offset_into_cluster(
+	struct loop_file_fmt_qcow_data *qcow_data, s64 offset)
+{
+	return offset & (qcow_data->cluster_size - 1);
+}
+
+static inline s64 loop_file_fmt_qcow_size_to_clusters(
+	struct loop_file_fmt_qcow_data *qcow_data, u64 size)
+{
+	return (size + (qcow_data->cluster_size - 1)) >>
+		qcow_data->cluster_bits;
+}
+
+static inline s64 loop_file_fmt_qcow_size_to_l1(
+	struct loop_file_fmt_qcow_data *qcow_data, s64 size)
+{
+	int shift = qcow_data->cluster_bits + qcow_data->l2_bits;
+	return (size + (1ULL << shift) - 1) >> shift;
+}
+
+static inline int loop_file_fmt_qcow_offset_to_l1_index(
+	struct loop_file_fmt_qcow_data *qcow_data, u64 offset)
+{
+	return offset >> (qcow_data->l2_bits + qcow_data->cluster_bits);
+}
+
+static inline int loop_file_fmt_qcow_offset_to_l2_index(
+	struct loop_file_fmt_qcow_data *qcow_data, s64 offset)
+{
+	return (offset >> qcow_data->cluster_bits) & (qcow_data->l2_size - 1);
+}
+
+static inline int loop_file_fmt_qcow_offset_to_l2_slice_index(
+	struct loop_file_fmt_qcow_data *qcow_data, s64 offset)
+{
+	return (offset >> qcow_data->cluster_bits) &
+		(qcow_data->l2_slice_size - 1);
+}
+
+static inline s64 loop_file_fmt_qcow_vm_state_offset(
+	struct loop_file_fmt_qcow_data *qcow_data)
+{
+	return (s64)qcow_data->l1_vm_state_index <<
+		(qcow_data->cluster_bits + qcow_data->l2_bits);
+}
+
+static inline enum loop_file_fmt_qcow_cluster_type
+loop_file_fmt_qcow_get_cluster_type(struct loop_file_fmt *lo_fmt, u64 l2_entry)
+{
+	if (l2_entry & QCOW_OFLAG_COMPRESSED) {
+		return QCOW_CLUSTER_COMPRESSED;
+	} else if (l2_entry & QCOW_OFLAG_ZERO) {
+		if (l2_entry & L2E_OFFSET_MASK) {
+			return QCOW_CLUSTER_ZERO_ALLOC;
+		}
+		return QCOW_CLUSTER_ZERO_PLAIN;
+	} else if (!(l2_entry & L2E_OFFSET_MASK)) {
+		/* Offset 0 generally means unallocated, but it is ambiguous
+		 * with external data files because 0 is a valid offset there.
+		 * However, all clusters in external data files always have
+		 * refcount 1, so we can rely on QCOW_OFLAG_COPIED to
+		 * disambiguate. */
+		if (loop_file_fmt_qcow_has_data_file(lo_fmt) &&
+			(l2_entry & QCOW_OFLAG_COPIED)) {
+			return QCOW_CLUSTER_NORMAL;
+		} else {
+			return QCOW_CLUSTER_UNALLOCATED;
+		}
+	} else {
+		return QCOW_CLUSTER_NORMAL;
+	}
+}
+
+#endif
-- 
2.23.0

