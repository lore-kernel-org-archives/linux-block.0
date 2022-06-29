Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB5BCCA47E
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiF2Xcb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiF2Xca (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:30 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC97398
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:26 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so999260pjj.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o10M6QoIFpUzuGq/5DC5TQebyG/SNCsaQwOMzghUt0Q=;
        b=d1Ov7Azxa4MJ/GA1+PFwDPx2vYFOe2Gjiz3CRSuFxjvkw4zoXnLX1pah5EAYp8aH7s
         6jU2TUxSVpZXb41eN3+FKowH14cQddMAKpCreh9Q/ACMeXnBP6rhztXWl0Z5eXfrGLYb
         v8NcNLLm+lvGWXDAr4H39RDJJ9tcRKoa6LA0NDHIiA1vXhymdv03IUY2VORwwONMX/Rt
         5CgCpNaSZdTniXw+RXA6zfnw5akeVIPIIHexwhEup5qhj8jH6VyYKzaO1faL0X3yn76m
         hrflJQTAVsD01rfaPaSOKrXB77ZOyzUedUshcm1KtTI8GDgAv6pemiss06zW3VWFkQNi
         28LQ==
X-Gm-Message-State: AJIora+rykx4mSgVfU28AICkSYKE3UXUSlODnzRxOMQfp7So2qGlpYL0
        Cmk2coF2bZlkzU/AHFMjcpE=
X-Google-Smtp-Source: AGRyM1sIRjEqIXz9m226f1+oLU5edNV58bFE12bS+JrlMZjXPqISPuwd6UmNqnIozgty/sJqADOlPA==
X-Received: by 2002:a17:902:7c0d:b0:16b:7dd2:626c with SMTP id x13-20020a1709027c0d00b0016b7dd2626cmr12555960pll.152.1656545546428;
        Wed, 29 Jun 2022 16:32:26 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 21/63] dm/core: Reduce the size of struct dm_io_request
Date:   Wed, 29 Jun 2022 16:31:03 -0700
Message-Id: <20220629233145.2779494-22-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Combine the bi_op and bi_op_flags into the bi_opf member. Use the new
blk_opf_t type to improve static type checking. This patch does not
change any functionality.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-bufio.c           |  9 +++------
 drivers/md/dm-integrity.c       | 15 +++++----------
 drivers/md/dm-io.c              | 10 ++++++----
 drivers/md/dm-kcopyd.c          |  3 +--
 drivers/md/dm-log.c             |  6 ++----
 drivers/md/dm-raid1.c           | 12 +++++-------
 drivers/md/dm-snap-persistent.c |  3 +--
 drivers/md/dm-writecache.c      | 12 ++++--------
 include/linux/dm-io.h           |  4 ++--
 9 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 5ffa1dcf84cf..1b7acda45c78 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -582,8 +582,7 @@ static void use_dmio(struct dm_buffer *b, int rw, sector_t sector,
 {
 	int r;
 	struct dm_io_request io_req = {
-		.bi_op = rw,
-		.bi_op_flags = 0,
+		.bi_opf = rw,
 		.notify.fn = dmio_complete,
 		.notify.context = b,
 		.client = b->c->dm_io,
@@ -1341,8 +1340,7 @@ EXPORT_SYMBOL_GPL(dm_bufio_write_dirty_buffers);
 int dm_bufio_issue_flush(struct dm_bufio_client *c)
 {
 	struct dm_io_request io_req = {
-		.bi_op = REQ_OP_WRITE,
-		.bi_op_flags = REQ_PREFLUSH | REQ_SYNC,
+		.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC,
 		.mem.type = DM_IO_KMEM,
 		.mem.ptr.addr = NULL,
 		.client = c->dm_io,
@@ -1365,8 +1363,7 @@ EXPORT_SYMBOL_GPL(dm_bufio_issue_flush);
 int dm_bufio_issue_discard(struct dm_bufio_client *c, sector_t block, sector_t count)
 {
 	struct dm_io_request io_req = {
-		.bi_op = REQ_OP_DISCARD,
-		.bi_op_flags = REQ_SYNC,
+		.bi_opf = REQ_OP_DISCARD | REQ_SYNC,
 		.mem.type = DM_IO_KMEM,
 		.mem.ptr.addr = NULL,
 		.client = c->dm_io,
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 148978ad03a8..2ccc103dea1e 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -557,8 +557,7 @@ static int sync_rw_sb(struct dm_integrity_c *ic, int op, int op_flags)
 	struct dm_io_region io_loc;
 	int r;
 
-	io_req.bi_op = op;
-	io_req.bi_op_flags = op_flags;
+	io_req.bi_opf = op | op_flags;
 	io_req.mem.type = DM_IO_KMEM;
 	io_req.mem.ptr.addr = ic->sb;
 	io_req.notify.fn = NULL;
@@ -1067,8 +1066,7 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, int op, int op_flags,
 	pl_index = sector >> (PAGE_SHIFT - SECTOR_SHIFT);
 	pl_offset = (sector << SECTOR_SHIFT) & (PAGE_SIZE - 1);
 
-	io_req.bi_op = op;
-	io_req.bi_op_flags = op_flags;
+	io_req.bi_opf = op | op_flags;
 	io_req.mem.type = DM_IO_PAGE_LIST;
 	if (ic->journal_io)
 		io_req.mem.ptr.pl = &ic->journal_io[pl_index];
@@ -1188,8 +1186,7 @@ static void copy_from_journal(struct dm_integrity_c *ic, unsigned section, unsig
 	pl_index = sector >> (PAGE_SHIFT - SECTOR_SHIFT);
 	pl_offset = (sector << SECTOR_SHIFT) & (PAGE_SIZE - 1);
 
-	io_req.bi_op = REQ_OP_WRITE;
-	io_req.bi_op_flags = 0;
+	io_req.bi_opf = REQ_OP_WRITE;
 	io_req.mem.type = DM_IO_PAGE_LIST;
 	io_req.mem.ptr.pl = &ic->journal[pl_index];
 	io_req.mem.offset = pl_offset;
@@ -1516,8 +1513,7 @@ static void dm_integrity_flush_buffers(struct dm_integrity_c *ic, bool flush_dat
 	if (!ic->meta_dev)
 		flush_data = false;
 	if (flush_data) {
-		fr.io_req.bi_op = REQ_OP_WRITE,
-		fr.io_req.bi_op_flags = REQ_PREFLUSH | REQ_SYNC,
+		fr.io_req.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC,
 		fr.io_req.mem.type = DM_IO_KMEM,
 		fr.io_req.mem.ptr.addr = NULL,
 		fr.io_req.notify.fn = flush_notify,
@@ -2706,8 +2702,7 @@ static void integrity_recalc(struct work_struct *w)
 	if (unlikely(dm_integrity_failed(ic)))
 		goto err;
 
-	io_req.bi_op = REQ_OP_READ;
-	io_req.bi_op_flags = 0;
+	io_req.bi_opf = REQ_OP_READ;
 	io_req.mem.type = DM_IO_VMA;
 	io_req.mem.ptr.addr = ic->recalc_buffer;
 	io_req.notify.fn = NULL;
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index e4b95eaeec8c..0606e00d1817 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -489,7 +489,7 @@ static int dp_init(struct dm_io_request *io_req, struct dpages *dp,
 
 	case DM_IO_VMA:
 		flush_kernel_vmap_range(io_req->mem.ptr.vma, size);
-		if (io_req->bi_op == REQ_OP_READ) {
+		if ((io_req->bi_opf & REQ_OP_MASK) == REQ_OP_READ) {
 			dp->vma_invalidate_address = io_req->mem.ptr.vma;
 			dp->vma_invalidate_size = size;
 		}
@@ -519,11 +519,13 @@ int dm_io(struct dm_io_request *io_req, unsigned num_regions,
 
 	if (!io_req->notify.fn)
 		return sync_io(io_req->client, num_regions, where,
-			       io_req->bi_op, io_req->bi_op_flags, &dp,
+			       io_req->bi_opf & REQ_OP_MASK,
+			       io_req->bi_opf & ~REQ_OP_MASK, &dp,
 			       sync_error_bits);
 
-	return async_io(io_req->client, num_regions, where, io_req->bi_op,
-			io_req->bi_op_flags, &dp, io_req->notify.fn,
+	return async_io(io_req->client, num_regions, where,
+			io_req->bi_opf & REQ_OP_MASK,
+			io_req->bi_opf & ~REQ_OP_MASK, &dp, io_req->notify.fn,
 			io_req->notify.context);
 }
 EXPORT_SYMBOL(dm_io);
diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 37b03ab7e5c9..a99b994e2b62 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -549,8 +549,7 @@ static int run_io_job(struct kcopyd_job *job)
 {
 	int r;
 	struct dm_io_request io_req = {
-		.bi_op = job->rw,
-		.bi_op_flags = 0,
+		.bi_opf = job->rw,
 		.mem.type = DM_IO_PAGE_LIST,
 		.mem.ptr.pl = job->pages,
 		.mem.offset = 0,
diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index 0c6620e7b7bf..56ad13f9347b 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -293,8 +293,7 @@ static void header_from_disk(struct log_header_core *core, struct log_header_dis
 
 static int rw_header(struct log_c *lc, int op)
 {
-	lc->io_req.bi_op = op;
-	lc->io_req.bi_op_flags = 0;
+	lc->io_req.bi_opf = op;
 
 	return dm_io(&lc->io_req, 1, &lc->header_location, NULL);
 }
@@ -307,8 +306,7 @@ static int flush_header(struct log_c *lc)
 		.count = 0,
 	};
 
-	lc->io_req.bi_op = REQ_OP_WRITE;
-	lc->io_req.bi_op_flags = REQ_PREFLUSH;
+	lc->io_req.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	return dm_io(&lc->io_req, 1, &null_location, NULL);
 }
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 8811d484fdd1..06a38dc32025 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -260,8 +260,7 @@ static int mirror_flush(struct dm_target *ti)
 	struct dm_io_region io[MAX_NR_MIRRORS];
 	struct mirror *m;
 	struct dm_io_request io_req = {
-		.bi_op = REQ_OP_WRITE,
-		.bi_op_flags = REQ_PREFLUSH | REQ_SYNC,
+		.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC,
 		.mem.type = DM_IO_KMEM,
 		.mem.ptr.addr = NULL,
 		.client = ms->io_client,
@@ -535,8 +534,7 @@ static void read_async_bio(struct mirror *m, struct bio *bio)
 {
 	struct dm_io_region io;
 	struct dm_io_request io_req = {
-		.bi_op = REQ_OP_READ,
-		.bi_op_flags = 0,
+		.bi_opf = REQ_OP_READ,
 		.mem.type = DM_IO_BIO,
 		.mem.ptr.bio = bio,
 		.notify.fn = read_callback,
@@ -648,9 +646,9 @@ static void do_write(struct mirror_set *ms, struct bio *bio)
 	unsigned int i;
 	struct dm_io_region io[MAX_NR_MIRRORS], *dest = io;
 	struct mirror *m;
+	blk_opf_t op_flags = bio->bi_opf & (REQ_FUA | REQ_PREFLUSH);
 	struct dm_io_request io_req = {
-		.bi_op = REQ_OP_WRITE,
-		.bi_op_flags = bio->bi_opf & (REQ_FUA | REQ_PREFLUSH),
+		.bi_opf = REQ_OP_WRITE | op_flags,
 		.mem.type = DM_IO_BIO,
 		.mem.ptr.bio = bio,
 		.notify.fn = write_callback,
@@ -659,7 +657,7 @@ static void do_write(struct mirror_set *ms, struct bio *bio)
 	};
 
 	if (bio_op(bio) == REQ_OP_DISCARD) {
-		io_req.bi_op = REQ_OP_DISCARD;
+		io_req.bi_opf = REQ_OP_DISCARD | op_flags;
 		io_req.mem.type = DM_IO_KMEM;
 		io_req.mem.ptr.addr = NULL;
 	}
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 3bb5cff5d6fc..eaf969de3d3a 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -235,8 +235,7 @@ static int chunk_io(struct pstore *ps, void *area, chunk_t chunk, int op,
 		.count = ps->store->chunk_size,
 	};
 	struct dm_io_request io_req = {
-		.bi_op = op,
-		.bi_op_flags = op_flags,
+		.bi_opf = op | op_flags,
 		.mem.type = DM_IO_VMA,
 		.mem.ptr.vma = area,
 		.client = ps->io_client,
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index d74c5a7a0ab4..2b994b3e22a7 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -523,8 +523,7 @@ static void ssd_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
 
 		region.sector += wc->start_sector;
 		atomic_inc(&endio.count);
-		req.bi_op = REQ_OP_WRITE;
-		req.bi_op_flags = REQ_SYNC;
+		req.bi_opf = REQ_OP_WRITE | REQ_SYNC;
 		req.mem.type = DM_IO_VMA;
 		req.mem.ptr.vma = (char *)wc->memory_map + (size_t)i * BITMAP_GRANULARITY;
 		req.client = wc->dm_io;
@@ -562,8 +561,7 @@ static void ssd_commit_superblock(struct dm_writecache *wc)
 
 	region.sector += wc->start_sector;
 
-	req.bi_op = REQ_OP_WRITE;
-	req.bi_op_flags = REQ_SYNC | REQ_FUA;
+	req.bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_FUA;
 	req.mem.type = DM_IO_VMA;
 	req.mem.ptr.vma = (char *)wc->memory_map;
 	req.client = wc->dm_io;
@@ -592,8 +590,7 @@ static void writecache_disk_flush(struct dm_writecache *wc, struct dm_dev *dev)
 	region.bdev = dev->bdev;
 	region.sector = 0;
 	region.count = 0;
-	req.bi_op = REQ_OP_WRITE;
-	req.bi_op_flags = REQ_PREFLUSH;
+	req.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 	req.mem.type = DM_IO_KMEM;
 	req.mem.ptr.addr = NULL;
 	req.client = wc->dm_io;
@@ -981,8 +978,7 @@ static int writecache_read_metadata(struct dm_writecache *wc, sector_t n_sectors
 	region.bdev = wc->ssd_dev->bdev;
 	region.sector = wc->start_sector;
 	region.count = n_sectors;
-	req.bi_op = REQ_OP_READ;
-	req.bi_op_flags = REQ_SYNC;
+	req.bi_opf = REQ_OP_READ | REQ_SYNC;
 	req.mem.type = DM_IO_VMA;
 	req.mem.ptr.vma = (char *)wc->memory_map;
 	req.client = wc->dm_io;
diff --git a/include/linux/dm-io.h b/include/linux/dm-io.h
index a52c6580cc9a..8e1c4ab5df04 100644
--- a/include/linux/dm-io.h
+++ b/include/linux/dm-io.h
@@ -13,6 +13,7 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
+#include <linux/blk_types.h>
 
 struct dm_io_region {
 	struct block_device *bdev;
@@ -57,8 +58,7 @@ struct dm_io_notify {
  */
 struct dm_io_client;
 struct dm_io_request {
-	int bi_op;			/* REQ_OP */
-	int bi_op_flags;		/* req_flag_bits */
+	blk_opf_t	    bi_opf;	/* Request type and flags */
 	struct dm_io_memory mem;	/* Memory to use for io */
 	struct dm_io_notify notify;	/* Synchronous if notify.fn is NULL */
 	struct dm_io_client *client;	/* Client memory handler */
