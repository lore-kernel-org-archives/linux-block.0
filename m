Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B55C43334
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 08:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiFBIMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiFBIMP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 04:12:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCE321A569
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5oapP+lsKtf4OHa7XoosHti47a87X58GzZN+HyBP5L0=; b=h7D3l6hfTyc1YcvYIh3q3dWEP+
        kleLBDRF8IgSvQk6e5kl3UAtyixGF2XIpJzEqcLe15uFrLl24lpF9YMMugTnrV6LZRv9emh9dmv8l
        t1XBnlk1WY8YURd2FmwA3vwXQrNV8+6FdF8pqDzCtoYZv+NxUHw6F4PzRWDUSgDNqnZMEM18RdXFf
        wQVNZxk6bR8FOy1tEYJiYa3PObYt1xCAeyaXnBe/GrmpzFTvqEp2dKdE5icrKQez9mWUUJNqqzwUU
        6HeyY2Csxq4afJ9PsLOcz3xwGRSL/asSiD5/wzH655qP6abcKs/MemL+szlfPWqEr/MpN1pqbmuEg
        nJkZwFgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwfwA-002Atb-MB; Thu, 02 Jun 2022 08:12:10 +0000
Date:   Thu, 2 Jun 2022 01:12:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, david@fromorbit.com
Subject: Re: bioset_exit poison from dm_destroy
Message-ID: <Yphw2n3ERoFsWgEe@infradead.org>
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com>
 <YpcBgY9MMgumEjTL@infradead.org>
 <Ypd0DnmjvCoWj+1P@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ypd0DnmjvCoWj+1P@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01, 2022 at 10:13:34AM -0400, Mike Snitzer wrote:
> Please take the time to look at the code and save your judgement until
> you do.  That said, I'm not in love with the complexity of how DM
> handles bioset initialization.  But both you and Jens keep taking
> shots at DM for doing things wrong without actually looking.

I'm not taking shots.  I'm just saying we should kill this API.  In
the worse case the caller can keep track of if a bioset is initialized,
but in most cases we should be able to deduct it in a nicer way.

> DM uses bioset_init_from_src().  Yet you've both assumed double frees
> and such (while not entirely wrong your glossing over the detail that
> there is intervening reinitialization of DM's biosets between the
> bioset_exit()s)

And looking at the code, that use of bioset_init_from_src is completely
broken.  It does not actually preallocated anything as intended by
dm (maybe that isn't actually needed) but just uses the biosets in
dm_md_mempools as an awkward way to carry parameters.  And completely
loses bringing over the integrity allocations.  And no, this is not
intended as a "cheap shot" against Jens who did that either..

This is what I think should fix this, and will allow us to remove
bioset_init_from_src which was a bad idea from the start:


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
index 0e833a154b31d..a8b016d6bf16e 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1044,11 +1044,6 @@ void dm_table_free_md_mempools(struct dm_table *t)
 	t->mempools = NULL;
 }
 
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
index 3f89664fea010..86642234d4adb 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -72,7 +72,6 @@ struct dm_target *dm_table_get_wildcard_target(struct dm_table *t);
 bool dm_table_bio_based(struct dm_table *t);
 bool dm_table_request_based(struct dm_table *t);
 void dm_table_free_md_mempools(struct dm_table *t);
-struct dm_md_mempools *dm_table_get_md_mempools(struct dm_table *t);
 
 void dm_lock_md_type(struct mapped_device *md);
 void dm_unlock_md_type(struct mapped_device *md);
