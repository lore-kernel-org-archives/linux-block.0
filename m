Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB35CCA482
	for <linux-block@archiver.kernel.org>; Wed,  8 Jun 2022 06:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiFHGo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jun 2022 02:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245632AbiFHGeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2022 02:34:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8210EA53
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JtZTeBKBtokvesJWYsz6x12M8yRkrzCu2+a6flMSLUk=; b=AmsnAIsNcyG4GkpQ+lt/tM0vRQ
        /pVSpSwp7RL5oORwHBcGUnUe/0xqeQ+AWwECmKYW4tRhEG4DzopCBnavoofQEPE0I+SvLdzeXTbki
        mIJYzDtl+/fSnneokih8LV1dzOWXOTw27NGt+gqktkdZwwOl7ZEID76OuhCDC5ZB6eMKzmvvL9kb4
        kwpZsDr2mMsZirjCXFCLG5NIGZU5okqatVGnpVTY29tcpZp7iu8jllYXqH8xU9BSAKybHoSV9wJyY
        XnU8AU3gxXj9PScozR56T95H53MtfiKiYW3PUEbN5R4of/E3uFXLoubaMyseAnumEErWWnMNVHPj+
        fVyJIklA==;
Received: from [2001:4bb8:190:726c:66c4:f635:4b37:bdda] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nypGg-00BJTV-VQ; Wed, 08 Jun 2022 06:34:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 1/4] dm: fix bio_set allocation
Date:   Wed,  8 Jun 2022 08:34:06 +0200
Message-Id: <20220608063409.1280968-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608063409.1280968-1-hch@lst.de>
References: <20220608063409.1280968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The use of bioset_init_from_src mean that the pre-allocated pools weren't
used for anything except parameter passing, and the integrity pool
creation got completely lost for the actual live mapped_device.  Fix that
by assigning the actual preallocated dm_md_mempools to the mapped_device
and using that for I/O instead of creating new mempools.

Fixes: 2a2a4c510b76 ("dm: use bioset_init_from_src() to copy bio_set")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-core.h  | 11 ++++--
 drivers/md/dm-rq.c    |  2 +-
 drivers/md/dm-table.c | 11 ------
 drivers/md/dm.c       | 84 +++++++++++++------------------------------
 drivers/md/dm.h       |  2 --
 5 files changed, 35 insertions(+), 75 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index d21648a923ea9..54c0473a51dde 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -33,6 +33,14 @@ struct dm_kobject_holder {
  * access their members!
  */
 
+/*
+ * For mempools pre-allocation at the table loading time.
+ */
+struct dm_md_mempools {
+	struct bio_set bs;
+	struct bio_set io_bs;
+};
+
 struct mapped_device {
 	struct mutex suspend_lock;
 
@@ -110,8 +118,7 @@ struct mapped_device {
 	/*
 	 * io objects are allocated from here.
 	 */
-	struct bio_set io_bs;
-	struct bio_set bs;
+	struct dm_md_mempools *mempools;
 
 	/* kobject and completion */
 	struct dm_kobject_holder kobj_holder;
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 6087cdcaad46d..a83b98a8d2a99 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -319,7 +319,7 @@ static int setup_clone(struct request *clone, struct request *rq,
 {
 	int r;
 
-	r = blk_rq_prep_clone(clone, rq, &tio->md->bs, gfp_mask,
+	r = blk_rq_prep_clone(clone, rq, &tio->md->mempools->bs, gfp_mask,
 			      dm_rq_bio_constructor, tio);
 	if (r)
 		return r;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0e833a154b31d..bd539afbfe88f 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1038,17 +1038,6 @@ static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *
 	return 0;
 }
 
-void dm_table_free_md_mempools(struct dm_table *t)
-{
-	dm_free_md_mempools(t->mempools);
-	t->mempools = NULL;
-}
-
-struct dm_md_mempools *dm_table_get_md_mempools(struct dm_table *t)
-{
-	return t->mempools;
-}
-
 static int setup_indexes(struct dm_table *t)
 {
 	int i;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dfb0a551bd880..8b21155d3c4f5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -136,14 +136,6 @@ static int get_swap_bios(void)
 	return latch;
 }
 
-/*
- * For mempools pre-allocation at the table loading time.
- */
-struct dm_md_mempools {
-	struct bio_set bs;
-	struct bio_set io_bs;
-};
-
 struct table_device {
 	struct list_head list;
 	refcount_t count;
@@ -581,7 +573,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	struct dm_target_io *tio;
 	struct bio *clone;
 
-	clone = bio_alloc_clone(NULL, bio, GFP_NOIO, &md->io_bs);
+	clone = bio_alloc_clone(NULL, bio, GFP_NOIO, &md->mempools->io_bs);
 	/* Set default bdev, but target must bio_set_dev() before issuing IO */
 	clone->bi_bdev = md->disk->part0;
 
@@ -628,7 +620,8 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 	} else {
 		struct mapped_device *md = ci->io->md;
 
-		clone = bio_alloc_clone(NULL, ci->bio, gfp_mask, &md->bs);
+		clone = bio_alloc_clone(NULL, ci->bio, gfp_mask,
+					&md->mempools->bs);
 		if (!clone)
 			return NULL;
 		/* Set default bdev, but target must bio_set_dev() before issuing IO */
@@ -1876,8 +1869,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
 {
 	if (md->wq)
 		destroy_workqueue(md->wq);
-	bioset_exit(&md->bs);
-	bioset_exit(&md->io_bs);
+	dm_free_md_mempools(md->mempools);
 
 	if (md->dax_dev) {
 		dax_remove_host(md->disk);
@@ -2049,48 +2041,6 @@ static void free_dev(struct mapped_device *md)
 	kvfree(md);
 }
 
-static int __bind_mempools(struct mapped_device *md, struct dm_table *t)
-{
-	struct dm_md_mempools *p = dm_table_get_md_mempools(t);
-	int ret = 0;
-
-	if (dm_table_bio_based(t)) {
-		/*
-		 * The md may already have mempools that need changing.
-		 * If so, reload bioset because front_pad may have changed
-		 * because a different table was loaded.
-		 */
-		bioset_exit(&md->bs);
-		bioset_exit(&md->io_bs);
-
-	} else if (bioset_initialized(&md->bs)) {
-		/*
-		 * There's no need to reload with request-based dm
-		 * because the size of front_pad doesn't change.
-		 * Note for future: If you are to reload bioset,
-		 * prep-ed requests in the queue may refer
-		 * to bio from the old bioset, so you must walk
-		 * through the queue to unprep.
-		 */
-		goto out;
-	}
-
-	BUG_ON(!p ||
-	       bioset_initialized(&md->bs) ||
-	       bioset_initialized(&md->io_bs));
-
-	ret = bioset_init_from_src(&md->bs, &p->bs);
-	if (ret)
-		goto out;
-	ret = bioset_init_from_src(&md->io_bs, &p->io_bs);
-	if (ret)
-		bioset_exit(&md->bs);
-out:
-	/* mempool bind completed, no longer need any mempools in the table */
-	dm_table_free_md_mempools(t);
-	return ret;
-}
-
 /*
  * Bind a table to the device.
  */
@@ -2144,12 +2094,28 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 		 * immutable singletons - used to optimize dm_mq_queue_rq.
 		 */
 		md->immutable_target = dm_table_get_immutable_target(t);
-	}
 
-	ret = __bind_mempools(md, t);
-	if (ret) {
-		old_map = ERR_PTR(ret);
-		goto out;
+		/*
+		 * There is no need to reload with request-based dm because the
+		 * size of front_pad doesn't change.
+		 *
+		 * Note for future: If you are to reload bioset, prep-ed
+		 * requests in the queue may refer to bio from the old bioset,
+		 * so you must walk through the queue to unprep.
+		 */
+		if (!md->mempools) {
+			md->mempools = t->mempools;
+			t->mempools = NULL;
+		}
+	} else {
+		/*
+		 * The md may already have mempools that need changing.
+		 * If so, reload bioset because front_pad may have changed
+		 * because a different table was loaded.
+		 */
+		dm_free_md_mempools(md->mempools);
+		md->mempools = t->mempools;
+		t->mempools = NULL;
 	}
 
 	ret = dm_table_set_restrictions(t, md->queue, limits);
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 3f89664fea010..a8405ce305a96 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -71,8 +71,6 @@ struct dm_target *dm_table_get_immutable_target(struct dm_table *t);
 struct dm_target *dm_table_get_wildcard_target(struct dm_table *t);
 bool dm_table_bio_based(struct dm_table *t);
 bool dm_table_request_based(struct dm_table *t);
-void dm_table_free_md_mempools(struct dm_table *t);
-struct dm_md_mempools *dm_table_get_md_mempools(struct dm_table *t);
 
 void dm_lock_md_type(struct mapped_device *md);
 void dm_unlock_md_type(struct mapped_device *md);
-- 
2.30.2

