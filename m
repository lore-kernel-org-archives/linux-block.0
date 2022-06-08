Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4A2C43334
	for <linux-block@archiver.kernel.org>; Wed,  8 Jun 2022 06:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiFHGoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jun 2022 02:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiFHGe2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2022 02:34:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7344578B
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 23:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K+NAFYrqZWqm32DoEkXhJem4nw/Y+8UPZvD0lotRpPA=; b=YnYs6RUq90jHVBzO5WWEmq8W/I
        0d3OTz5rh5Tu5U9FDR7FI7mXcB5wj0CUq7Mxn+N7illyR43I9oSBSX1MpsrHkWh7SmRDLAoBliow9
        Q0mNyYT29vAPi6wYxXLRsy3+XYnKxFybnk/yjSSAXn46rBoPYbpo6FdXtfh5lEEZaW0GFVO+gMS02
        E6VwGxuUWsklT5bBk0LvpYOxUNtX96rjdPNyCUvWtK2Yit0L7rcznhHmFWZX8BYGdqxCc2gtKMAgu
        NbThiG9f0t19//7bgb6XPfR0CRoqjYT3inbPFb5WVfWgHGP/d+lhabSjH8YuW40R8wJ7duAdx82P0
        tR/WRATg==;
Received: from [2001:4bb8:190:726c:66c4:f635:4b37:bdda] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nypGo-00BJUc-RV; Wed, 08 Jun 2022 06:34:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 4/4] dm: refactor dm_md_mempool allocation
Date:   Wed,  8 Jun 2022 08:34:09 +0200
Message-Id: <20220608063409.1280968-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608063409.1280968-1-hch@lst.de>
References: <20220608063409.1280968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current split between dm_table_alloc_md_mempools and
dm_alloc_md_mempools is rather arbitrary, so merge the two
into one easy to follow function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-core.h  |  3 +++
 drivers/md/dm-table.c | 57 +++++++++++++++++++++++++++++++------------
 drivers/md/dm.c       | 52 ---------------------------------------
 drivers/md/dm.h       |  3 ---
 4 files changed, 44 insertions(+), 71 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 54c0473a51dde..eea3922f1abc6 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -230,6 +230,9 @@ struct dm_target_io {
 	sector_t old_sector;
 	struct bio clone;
 };
+#define DM_TARGET_IO_BIO_OFFSET (offsetof(struct dm_target_io, clone))
+#define DM_IO_BIO_OFFSET \
+	(offsetof(struct dm_target_io, clone) + offsetof(struct dm_io, tio))
 
 /*
  * dm_target_io flags
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index bd539afbfe88f..3f29b1113294e 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -6,6 +6,7 @@
  */
 
 #include "dm-core.h"
+#include "dm-rq.h"
 
 #include <linux/module.h>
 #include <linux/vmalloc.h>
@@ -1010,32 +1011,56 @@ static bool dm_table_supports_poll(struct dm_table *t);
 static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *md)
 {
 	enum dm_queue_mode type = dm_table_get_type(t);
-	unsigned per_io_data_size = 0;
-	unsigned min_pool_size = 0;
-	struct dm_target *ti;
-	unsigned i;
-	bool poll_supported = false;
+	unsigned int per_io_data_size = 0, front_pad, io_front_pad;
+	unsigned int min_pool_size = 0, pool_size;
+	struct dm_md_mempools *pools;
 
 	if (unlikely(type == DM_TYPE_NONE)) {
 		DMWARN("no table type is set, can't allocate mempools");
 		return -EINVAL;
 	}
 
-	if (__table_type_bio_based(type)) {
-		for (i = 0; i < t->num_targets; i++) {
-			ti = t->targets + i;
-			per_io_data_size = max(per_io_data_size, ti->per_io_data_size);
-			min_pool_size = max(min_pool_size, ti->num_flush_bios);
-		}
-		poll_supported = dm_table_supports_poll(t);
+	pools = kzalloc_node(sizeof(*pools), GFP_KERNEL, md->numa_node_id);
+	if (!pools)
+		return -ENOMEM;
+
+	if (type == DM_TYPE_REQUEST_BASED) {
+		pool_size = dm_get_reserved_rq_based_ios();
+		front_pad = offsetof(struct dm_rq_clone_bio_info, clone);
+		goto init_bs;
 	}
 
-	t->mempools = dm_alloc_md_mempools(md, type, per_io_data_size, min_pool_size,
-					   t->integrity_supported, poll_supported);
-	if (!t->mempools)
-		return -ENOMEM;
+	for (unsigned int i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = t->targets + i;
 
+		per_io_data_size = max(per_io_data_size, ti->per_io_data_size);
+		min_pool_size = max(min_pool_size, ti->num_flush_bios);
+	}
+	pool_size = max(dm_get_reserved_bio_based_ios(), min_pool_size);
+	front_pad = roundup(per_io_data_size,
+		__alignof__(struct dm_target_io)) + DM_TARGET_IO_BIO_OFFSET;
+
+	io_front_pad = roundup(per_io_data_size,
+		__alignof__(struct dm_io)) + DM_IO_BIO_OFFSET;
+	if (bioset_init(&pools->io_bs, pool_size, io_front_pad,
+			dm_table_supports_poll(t) ? BIOSET_PERCPU_CACHE : 0))
+		goto out_free_pools;
+	if (t->integrity_supported &&
+	    bioset_integrity_create(&pools->io_bs, pool_size))
+		goto out_free_pools;
+init_bs:
+	if (bioset_init(&pools->bs, pool_size, front_pad, 0))
+		goto out_free_pools;
+	if (t->integrity_supported &&
+	    bioset_integrity_create(&pools->bs, pool_size))
+		goto out_free_pools;
+
+	t->mempools = pools;
 	return 0;
+
+out_free_pools:
+	dm_free_md_mempools(pools);
+	return -ENOMEM;
 }
 
 static int setup_indexes(struct dm_table *t)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8b21155d3c4f5..ca390a8c9ae6f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -88,10 +88,6 @@ struct clone_info {
 	bool submit_as_polled:1;
 };
 
-#define DM_TARGET_IO_BIO_OFFSET (offsetof(struct dm_target_io, clone))
-#define DM_IO_BIO_OFFSET \
-	(offsetof(struct dm_target_io, clone) + offsetof(struct dm_io, tio))
-
 static inline struct dm_target_io *clone_to_tio(struct bio *clone)
 {
 	return container_of(clone, struct dm_target_io, clone);
@@ -2972,54 +2968,6 @@ int dm_noflush_suspending(struct dm_target *ti)
 }
 EXPORT_SYMBOL_GPL(dm_noflush_suspending);
 
-struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_queue_mode type,
-					    unsigned per_io_data_size, unsigned min_pool_size,
-					    bool integrity, bool poll)
-{
-	struct dm_md_mempools *pools = kzalloc_node(sizeof(*pools), GFP_KERNEL, md->numa_node_id);
-	unsigned int pool_size = 0;
-	unsigned int front_pad, io_front_pad;
-	int ret;
-
-	if (!pools)
-		return NULL;
-
-	switch (type) {
-	case DM_TYPE_BIO_BASED:
-	case DM_TYPE_DAX_BIO_BASED:
-		pool_size = max(dm_get_reserved_bio_based_ios(), min_pool_size);
-		front_pad = roundup(per_io_data_size, __alignof__(struct dm_target_io)) + DM_TARGET_IO_BIO_OFFSET;
-		io_front_pad = roundup(per_io_data_size,  __alignof__(struct dm_io)) + DM_IO_BIO_OFFSET;
-		ret = bioset_init(&pools->io_bs, pool_size, io_front_pad, poll ? BIOSET_PERCPU_CACHE : 0);
-		if (ret)
-			goto out;
-		if (integrity && bioset_integrity_create(&pools->io_bs, pool_size))
-			goto out;
-		break;
-	case DM_TYPE_REQUEST_BASED:
-		pool_size = max(dm_get_reserved_rq_based_ios(), min_pool_size);
-		front_pad = offsetof(struct dm_rq_clone_bio_info, clone);
-		/* per_io_data_size is used for blk-mq pdu at queue allocation */
-		break;
-	default:
-		BUG();
-	}
-
-	ret = bioset_init(&pools->bs, pool_size, front_pad, 0);
-	if (ret)
-		goto out;
-
-	if (integrity && bioset_integrity_create(&pools->bs, pool_size))
-		goto out;
-
-	return pools;
-
-out:
-	dm_free_md_mempools(pools);
-
-	return NULL;
-}
-
 void dm_free_md_mempools(struct dm_md_mempools *pools)
 {
 	if (!pools)
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index a8405ce305a96..62816b647f827 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -218,9 +218,6 @@ void dm_kcopyd_exit(void);
 /*
  * Mempool operations
  */
-struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_queue_mode type,
-					    unsigned per_io_data_size, unsigned min_pool_size,
-					    bool integrity, bool poll);
 void dm_free_md_mempools(struct dm_md_mempools *pools);
 
 /*
-- 
2.30.2

