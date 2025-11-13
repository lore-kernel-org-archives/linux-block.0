Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B833D6C1
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024063; cv=none; b=alx+y2YTHxOcY0V7FDLmUaDMuPDmH28XQyKIydd6XGUeotaeRtS3Hwb29kDO6sj0QsMoRXtUWjeWPzGm4HWn6WDv/hTDKYjSBfw5YOuOwOZgVXg3zHKueua08UuDzfOYouljjOlUygQX3HJ6JyEGy3hiKiK5UF1aEid+IB3V3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024063; c=relaxed/simple;
	bh=y5chO6eZNUcGQ1oXa3IM8lhLcyNKzdnhsZT743HK2uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSMRT8npygVUH8QUVOAP+ZEljx5/zHGlIpSp+QuniE57c/88o933+NDOK0XWjBSLJQeLWIWP7FbJPz2raivzd5ca+RXY1UU/TKVXM5JdZbLVDzd6DYgt27MoJZShNcXcJCmV9M/NeeUzOs2QJKCtZaoPf2aXtFvF7WJhW+cH7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pb33KEiK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pb33KEiK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297f35be2ffso7989995ad.2
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 00:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763024061; x=1763628861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo+A8oOPC3UWLIlOsQTXHsFO0OGP2jdz/XNnWDqW4QI=;
        b=Pb33KEiKiVS1DcXN2npL3FU3NkClCu3CQOsNOIteW1ZNqD1aa8DHpUoaQvG1GFQ+WK
         9dDHYEM9HrEQXUlPhN20UtYZNe9VdbrL0KT88Pll8YXhU3LMjXwcLhFTBer5wyzRVF3K
         O/8eFyE3gQAinjgd8d86EspwaRRjmdbpyypZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024061; x=1763628861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eo+A8oOPC3UWLIlOsQTXHsFO0OGP2jdz/XNnWDqW4QI=;
        b=bSdsswH2LiHQcUZ1yuJTrvgeCvfvBO3bIl+qOvNBdC3dGYT1XOmGFvAwpJL3tkpYtv
         +qXv12goqj8QuZrV0a+A4XAbQBSpVmEoAAR/EdiiIqkxvKzKNoCPb61j8XXPXrB8cani
         gretEgggoiUH0etbCpiJfPySJqUlvlKrrinyt6jrXKsWUrHJA+SBalOTgGUJG1JM9PnD
         5ZZVsFqDV+jXKZ/1q5mIpbp78Qs3cJHs5Eo+xus4VirxQ55A3zpAKPgqy9dFQd80otCN
         L12GtJ/QNSADjDUE5v6vJ0Zs1oikdFpuyV5bLL2oX/8S2R7NPmCsN1p5f2U9WLF4mbjC
         f5sg==
X-Forwarded-Encrypted: i=1; AJvYcCWbxwjwUHBDkUT78TJSN4M/XzUIO5ONLZmq9QTAZ2rWe0LFO8vESMebFb8HEySjS2MczMMDH//U/QbJBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmLluiGAa2xkBhzY3Q7r2FQLW3UUi3objEhzMrNMcgYcIXXYn
	WDom1V7+JmbF8x2Oqlx5sl07vs9B/qypYIiFJIrJWdUdWWYqpENMOpNoDzNPBEcSVQ==
X-Gm-Gg: ASbGncus0D/xCHhezos2KSi2VjlHEYXCmgNoLDsOl88WRPOkbhQbmI29Wks/rn8BP9t
	abF1RtRfcLDswi9XtLb8hrSGynV3n3Piz19h/G1+Prf/0kHVyuce9T4GqAI2qFL8qpyt0M+tSMa
	JV2Do1QpehKwYnSQga4AFHCw5PgTOo1D09sAXjulykr7nWL3BEf40SdEcND+VFjNn114qNz36D5
	eS9wkPMDqx1Z+uTSWd3UD7eTMurPllmewJOBLzipjOg1gUOSMtxuOkeq8azQc4XM12RIMTlTigu
	JeHgyGcFUd2gL1t+DYE2Rl8Xy+J8H2CMz20tlizESlHW8os9VAWpi+1bSJNfI1b5qRcYJCqMmAn
	lm80NbIEnMry+E3/3B+Cbm0zaNezdlUwvv8vFtFFOeoN5BkiHXZOMGPofvDHDIAne0WB2TqyTe2
	WQAxxz9rKScEODetqE4FugeMICgo0=
X-Google-Smtp-Source: AGHT+IG/79RyzUI/zRKOb6Yb1TWU8Nd4GDC7ZHdVYbW9fmlOiTb68yTSSrfLfjj6XgeMlVxejFehkg==
X-Received: by 2002:a17:903:3d0b:b0:294:9699:74f6 with SMTP id d9443c01a7336-2984edddbafmr75229805ad.43.1763024060701;
        Thu, 13 Nov 2025 00:54:20 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm17486465ad.18.2025.11.13.00.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:54:20 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@google.com>
Subject: [PATCHv2 1/4] zram: introduce writeback bio batching support
Date: Thu, 13 Nov 2025 17:53:59 +0900
Message-ID: <20251113085402.1811522-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251113085402.1811522-1-senozhatsky@chromium.org>
References: <20251113085402.1811522-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuwen Chen <ywen.chen@foxmail.com>

Currently, zram writeback supports only a single bio writeback
operation, waiting for bio completion before post-processing
next pp-slot.  This works, in general, but has certain throughput
limitations.  Implement batched (multiple) bio writeback support
to take advantage of parallel requests processing and better
requests scheduling.

For the time being the writeback batch size (maximum number of
in-flight bio requests) is set to 1, so the behaviors is the
same as the previous single-bio writeback.  This is addressed
in a follow up patch, which adds a writeback_batch_size device
attribute.

Please refer to [1] and [2] for benchmarks.

[1] https://lore.kernel.org/linux-block/tencent_B2DC37E3A2AED0E7F179365FCB5D82455B08@qq.com
[2] https://lore.kernel.org/linux-block/tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com

[senozhatsky: significantly reworked the initial patch so that the
approach and implementation resemble current zram post-processing
code]

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Co-developed-by: Richard Chang <richardycc@google.com>
Suggested-by: Minchan Kim <minchan@google.com>
---
 drivers/block/zram/zram_drv.c | 343 +++++++++++++++++++++++++++-------
 1 file changed, 278 insertions(+), 65 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..a0a939fd9d31 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -734,20 +734,226 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	submit_bio(bio);
 }
 
-static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
-{
-	unsigned long blk_idx = 0;
-	struct page *page = NULL;
+struct zram_wb_ctl {
+	struct list_head idle_reqs;
+	struct list_head inflight_reqs;
+
+	atomic_t num_inflight;
+	struct completion done;
+	struct blk_plug plug;
+};
+
+struct zram_wb_req {
+	unsigned long blk_idx;
+	struct page *page;
 	struct zram_pp_slot *pps;
 	struct bio_vec bio_vec;
 	struct bio bio;
-	int ret = 0, err;
+
+	struct list_head entry;
+};
+
+static void release_wb_req(struct zram_wb_req *req)
+{
+	__free_page(req->page);
+	kfree(req);
+}
+
+static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
+{
+	/* We should never have inflight requests at this point */
+	WARN_ON(!list_empty(&wb_ctl->inflight_reqs));
+
+	while (!list_empty(&wb_ctl->idle_reqs)) {
+		struct zram_wb_req *req;
+
+		req = list_first_entry(&wb_ctl->idle_reqs,
+				       struct zram_wb_req, entry);
+		list_del(&req->entry);
+		release_wb_req(req);
+	}
+
+	kfree(wb_ctl);
+}
+
+/* XXX: should be a per-device sysfs attr */
+#define ZRAM_WB_REQ_CNT 1
+
+static struct zram_wb_ctl *init_wb_ctl(void)
+{
+	struct zram_wb_ctl *wb_ctl;
+	int i;
+
+	wb_ctl = kmalloc(sizeof(*wb_ctl), GFP_KERNEL);
+	if (!wb_ctl)
+		return NULL;
+
+	INIT_LIST_HEAD(&wb_ctl->idle_reqs);
+	INIT_LIST_HEAD(&wb_ctl->inflight_reqs);
+	atomic_set(&wb_ctl->num_inflight, 0);
+	init_completion(&wb_ctl->done);
+
+	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+		struct zram_wb_req *req;
+
+		/*
+		 * This is fatal condition only if we couldn't allocate
+		 * any requests at all.  Otherwise we just work with the
+		 * requests that we have successfully allocated, so that
+		 * writeback can still proceed, even if there is only one
+		 * request on the idle list.
+		 */
+		req = kzalloc(sizeof(*req), GFP_NOIO | __GFP_NOWARN);
+		if (!req)
+			break;
+
+		req->page = alloc_page(GFP_NOIO | __GFP_NOWARN);
+		if (!req->page) {
+			kfree(req);
+			break;
+		}
+
+		INIT_LIST_HEAD(&req->entry);
+		list_add(&req->entry, &wb_ctl->idle_reqs);
+	}
+
+	/* We couldn't allocate any requests, so writeabck is not possible */
+	if (list_empty(&wb_ctl->idle_reqs))
+		goto release_wb_ctl;
+
+	return wb_ctl;
+
+release_wb_ctl:
+	release_wb_ctl(wb_ctl);
+	return NULL;
+}
+
+static void zram_account_writeback_rollback(struct zram *zram)
+{
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable)
+		zram->bd_wb_limit +=  1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+}
+
+static void zram_account_writeback_submit(struct zram *zram)
+{
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+}
+
+static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
+{
 	u32 index;
+	int err;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	index = req->pps->index;
+	release_pp_slot(zram, req->pps);
+	req->pps = NULL;
+
+	err = blk_status_to_errno(req->bio.bi_status);
+	if (err) {
+		/*
+		 * Failed wb requests should not be accounted in wb_limit
+		 * (if enabled).
+		 */
+		zram_account_writeback_rollback(zram);
+		return err;
+	}
 
+	atomic64_inc(&zram->stats.bd_writes);
+	zram_slot_lock(zram, index);
+	/*
+	 * We release slot lock during writeback so slot can change under us:
+	 * slot_free() or slot_free() and zram_write_page(). In both cases
+	 * slot loses ZRAM_PP_SLOT flag. No concurrent post-processing can
+	 * set ZRAM_PP_SLOT on such slots until current post-processing
+	 * finishes.
+	 */
+	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
+		goto out;
+
+	zram_free_page(zram, index);
+	zram_set_flag(zram, index, ZRAM_WB);
+	zram_set_handle(zram, index, req->blk_idx);
+	atomic64_inc(&zram->stats.pages_stored);
+
+out:
+	zram_slot_unlock(zram, index);
+	return 0;
+}
+
+static void zram_writeback_endio(struct bio *bio)
+{
+	struct zram_wb_ctl *wb_ctl = bio->bi_private;
+
+	if (atomic_dec_return(&wb_ctl->num_inflight) == 0)
+		complete(&wb_ctl->done);
+}
+
+static void zram_submit_wb_request(struct zram *zram,
+				   struct zram_wb_ctl *wb_ctl,
+				   struct zram_wb_req *req)
+{
+	/*
+	 * wb_limit (if enabled) should be adjusted before submission,
+	 * so that we don't over-submit.
+	 */
+	zram_account_writeback_submit(zram);
+	atomic_inc(&wb_ctl->num_inflight);
+	list_add_tail(&req->entry, &wb_ctl->inflight_reqs);
+	submit_bio(&req->bio);
+}
+
+static struct zram_wb_req *select_idle_req(struct zram_wb_ctl *wb_ctl)
+{
+	struct zram_wb_req *req;
+
+	req = list_first_entry_or_null(&wb_ctl->idle_reqs,
+				       struct zram_wb_req, entry);
+	if (req)
+		list_del(&req->entry);
+	return req;
+}
+
+static int zram_wb_wait_for_completion(struct zram *zram,
+				       struct zram_wb_ctl *wb_ctl)
+{
+	int ret = 0;
+
+	if (atomic_read(&wb_ctl->num_inflight))
+		wait_for_completion_io(&wb_ctl->done);
+
+	reinit_completion(&wb_ctl->done);
+	while (!list_empty(&wb_ctl->inflight_reqs)) {
+		struct zram_wb_req *req;
+		int err;
+
+		req = list_first_entry(&wb_ctl->inflight_reqs,
+				       struct zram_wb_req, entry);
+		list_move(&req->entry, &wb_ctl->idle_reqs);
+
+		err = zram_writeback_complete(zram, req);
+		if (err)
+			ret = err;
+	}
+
+	return ret;
+}
+
+static int zram_writeback_slots(struct zram *zram,
+				struct zram_pp_ctl *ctl,
+				struct zram_wb_ctl *wb_ctl)
+{
+	struct zram_wb_req *req = NULL;
+	unsigned long blk_idx = 0;
+	struct zram_pp_slot *pps;
+	int ret = 0, err;
+	u32 index = 0;
+
+	blk_start_plug(&wb_ctl->plug);
 	while ((pps = select_pp_slot(ctl))) {
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
@@ -757,6 +963,26 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		}
 		spin_unlock(&zram->wb_limit_lock);
 
+		while (!req) {
+			req = select_idle_req(wb_ctl);
+			if (req)
+				break;
+
+			blk_finish_plug(&wb_ctl->plug);
+			err = zram_wb_wait_for_completion(zram, wb_ctl);
+			blk_start_plug(&wb_ctl->plug);
+			/*
+			 * BIO errors are not fatal, we continue and simply
+			 * attempt to writeback the remaining objects (pages).
+			 * At the same time we need to signal user-space that
+			 * some writes (at least one, but also could be all of
+			 * them) were not successful and we do so by returning
+			 * the most recent BIO error.
+			 */
+			if (err)
+				ret = err;
+		}
+
 		if (!blk_idx) {
 			blk_idx = alloc_block_bdev(zram);
 			if (!blk_idx) {
@@ -765,7 +991,6 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 			}
 		}
 
-		index = pps->index;
 		zram_slot_lock(zram, index);
 		/*
 		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
@@ -775,67 +1000,47 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		 */
 		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-		if (zram_read_from_zspool(zram, page, index))
+		if (zram_read_from_zspool(zram, req->page, index))
 			goto next;
 		zram_slot_unlock(zram, index);
 
-		bio_init(&bio, zram->bdev, &bio_vec, 1,
-			 REQ_OP_WRITE | REQ_SYNC);
-		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-		__bio_add_page(&bio, page, PAGE_SIZE, 0);
-
 		/*
-		 * XXX: A single page IO would be inefficient for write
-		 * but it would be not bad as starter.
+		 * From now on pp-slot is owned by the req, remove it from
+		 * its pps bucket.
 		 */
-		err = submit_bio_wait(&bio);
-		if (err) {
-			release_pp_slot(zram, pps);
-			/*
-			 * BIO errors are not fatal, we continue and simply
-			 * attempt to writeback the remaining objects (pages).
-			 * At the same time we need to signal user-space that
-			 * some writes (at least one, but also could be all of
-			 * them) were not successful and we do so by returning
-			 * the most recent BIO error.
-			 */
-			ret = err;
-			continue;
-		}
+		list_del_init(&pps->entry);
 
-		atomic64_inc(&zram->stats.bd_writes);
-		zram_slot_lock(zram, index);
-		/*
-		 * Same as above, we release slot lock during writeback so
-		 * slot can change under us: slot_free() or slot_free() and
-		 * reallocation (zram_write_page()). In both cases slot loses
-		 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
-		 * ZRAM_PP_SLOT on such slots until current post-processing
-		 * finishes.
-		 */
-		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
-			goto next;
+		req->blk_idx = blk_idx;
+		req->pps = pps;
+		bio_init(&req->bio, zram->bdev, &req->bio_vec, 1,
+			 REQ_OP_WRITE | REQ_SYNC);
+		req->bio.bi_iter.bi_sector = req->blk_idx * (PAGE_SIZE >> 9);
+		req->bio.bi_end_io = zram_writeback_endio;
+		req->bio.bi_private = wb_ctl;
+		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
 
-		zram_free_page(zram, index);
-		zram_set_flag(zram, index, ZRAM_WB);
-		zram_set_handle(zram, index, blk_idx);
+		zram_submit_wb_request(zram, wb_ctl, req);
 		blk_idx = 0;
-		atomic64_inc(&zram->stats.pages_stored);
-		spin_lock(&zram->wb_limit_lock);
-		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-		spin_unlock(&zram->wb_limit_lock);
+		req = NULL;
+		continue;
+
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
-
 		cond_resched();
 	}
 
-	if (blk_idx)
-		free_block_bdev(zram, blk_idx);
-	if (page)
-		__free_page(page);
+	/*
+	 * Selected idle req, but never submitted it due to some error or
+	 * wb limit.
+	 */
+	if (req)
+		release_wb_req(req);
+
+	blk_finish_plug(&wb_ctl->plug);
+	err = zram_wb_wait_for_completion(zram, wb_ctl);
+	if (err)
+		ret = err;
 
 	return ret;
 }
@@ -948,7 +1153,8 @@ static ssize_t writeback_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
 	unsigned long lo = 0, hi = nr_pages;
-	struct zram_pp_ctl *ctl = NULL;
+	struct zram_pp_ctl *pp_ctl = NULL;
+	struct zram_wb_ctl *wb_ctl = NULL;
 	char *args, *param, *val;
 	ssize_t ret = len;
 	int err, mode = 0;
@@ -970,8 +1176,14 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	ctl = init_pp_ctl();
-	if (!ctl) {
+	pp_ctl = init_pp_ctl();
+	if (!pp_ctl) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
+
+	wb_ctl = init_wb_ctl();
+	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
 	}
@@ -1000,7 +1212,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			break;
 		}
 
@@ -1011,7 +1223,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			break;
 		}
 
@@ -1022,7 +1234,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			continue;
 		}
 
@@ -1033,17 +1245,18 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			continue;
 		}
 	}
 
-	err = zram_writeback_slots(zram, ctl);
+	err = zram_writeback_slots(zram, pp_ctl, wb_ctl);
 	if (err)
 		ret = err;
 
 release_init_lock:
-	release_pp_ctl(zram, ctl);
+	release_pp_ctl(zram, pp_ctl);
+	release_wb_ctl(wb_ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
 
-- 
2.51.2.1041.gc1ab5b90ca-goog

