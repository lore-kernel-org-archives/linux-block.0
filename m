Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677F6C4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 07:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4610D6128A
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 07:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFWHnv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 03:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229918AbhFWHnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 03:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624434093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3XucCLPCUU7RQ4YHe2ZNoeU+PvNMsB7S1QNE631Ie8=;
        b=cb/zNXx8aih7VjAzXsWKV34GZoPjNxR8MdgZhobolgR40iW/0bD589EcBgYjoJg5qesI6s
        REMtOIbhWXE+YPL60qe4E4h0nEQfr/uzMzcpiNlSyE5TSS4oqkST5SIMuBAzxdmiOqkGlU
        3jmx0pr6MmYoa89aShKv+hP8nUIBrlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-UPXcWgGsP0a8VNeKbr97hg-1; Wed, 23 Jun 2021 03:41:30 -0400
X-MC-Unique: UPXcWgGsP0a8VNeKbr97hg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40A9219057A1;
        Wed, 23 Jun 2021 07:41:29 +0000 (UTC)
Received: from localhost (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0F7A5C1D1;
        Wed, 23 Jun 2021 07:41:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/3] dm: support bio polling
Date:   Wed, 23 Jun 2021 15:40:32 +0800
Message-Id: <20210623074032.1484665-4-ming.lei@redhat.com>
In-Reply-To: <20210623074032.1484665-1-ming.lei@redhat.com>
References: <20210623074032.1484665-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Support bio(REQ_POLLED) polling in the following approach:

1) only support io polling on normal READ/WRITE, and other abnormal IOs
still fallback on IRQ mode, so the target io is exactly inside the dm
io.

2) hold one refcnt on io->io_count after submitting this dm bio with
REQ_POLLED

3) support dm native bio splitting, any dm io instance associated with
current bio will be added into one list which head is bio->bi_end_io
which will be recovered before ending this bio

4) implement .poll_bio() callback, call bio_poll() on the single target
bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
dec_pending() after the target io is done in .poll_bio()

4) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
which is based on Jeffle's previous patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-table.c |  24 ++++++++
 drivers/md/dm.c       | 131 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ee47a332b462..b14b379442d2 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1491,6 +1491,12 @@ struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
 	return &t->targets[(KEYS_PER_NODE * n) + k];
 }
 
+static int device_not_poll_capable(struct dm_target *ti, struct dm_dev *dev,
+				   sector_t start, sector_t len, void *data)
+{
+	return !blk_queue_poll(bdev_get_queue(dev->bdev));
+}
+
 /*
  * type->iterate_devices() should be called when the sanity check needs to
  * iterate and check all underlying data devices. iterate_devices() will
@@ -1541,6 +1547,11 @@ static int count_device(struct dm_target *ti, struct dm_dev *dev,
 	return 0;
 }
 
+static int dm_table_supports_poll(struct dm_table *t)
+{
+	return !dm_table_any_dev_attr(t, device_not_poll_capable, NULL);
+}
+
 /*
  * Check whether a table has no data devices attached using each
  * target's iterate_devices method.
@@ -2078,6 +2089,19 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 
 	dm_update_keyslot_manager(q, t);
 	blk_queue_update_readahead(q);
+
+	/*
+	 * Check for request-based device is remained to
+	 * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
+	 * For bio-based device, only set QUEUE_FLAG_POLL when all underlying
+	 * devices supporting polling.
+	 */
+	if (__table_type_bio_based(t->type)) {
+		if (dm_table_supports_poll(t))
+			blk_queue_flag_set(QUEUE_FLAG_POLL, q);
+		else
+			blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
+	}
 }
 
 unsigned int dm_table_get_num_targets(struct dm_table *t)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 363f12a285ce..cfc2e1915ec4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -39,6 +39,8 @@
 #define DM_COOKIE_ENV_VAR_NAME "DM_COOKIE"
 #define DM_COOKIE_LENGTH 24
 
+#define REQ_SAVED_END_IO             REQ_DRV
+
 static const char *_name = DM_NAME;
 
 static unsigned int major = 0;
@@ -72,6 +74,7 @@ struct clone_info {
 	struct dm_io *io;
 	sector_t sector;
 	unsigned sector_count;
+	bool	submit_as_polled;
 };
 
 /*
@@ -99,6 +102,8 @@ struct dm_io {
 	blk_status_t status;
 	atomic_t io_count;
 	struct bio *orig_bio;
+	void	*saved_bio_end_io;
+	struct hlist_node  node;
 	unsigned long start_time;
 	spinlock_t endio_lock;
 	struct dm_stats_aux stats_aux;
@@ -687,6 +692,8 @@ static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *t
 	tio->ti = ti;
 	tio->target_bio_nr = target_bio_nr;
 
+	WARN_ON_ONCE(ci->submit_as_polled && !tio->inside_dm_io);
+
 	return tio;
 }
 
@@ -938,8 +945,14 @@ static void dec_pending(struct dm_io *io, blk_status_t error)
 		end_io_acct(io);
 		free_io(md, io);
 
-		if (io_error == BLK_STS_DM_REQUEUE)
+		if (io_error == BLK_STS_DM_REQUEUE) {
+			/*
+			 * Upper layer won't help us poll split bio, so
+			 * clear REQ_POLLED in case of requeue
+			 */
+			bio->bi_opf &= ~REQ_POLLED;
 			return;
+		}
 
 		if ((bio->bi_opf & REQ_PREFLUSH) && bio->bi_iter.bi_size) {
 			/*
@@ -1366,6 +1379,9 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 
 	__bio_clone_fast(clone, bio);
 
+	/* REQ_SAVED_END_IO shouldn't be inherited */
+	clone->bi_opf &= ~REQ_SAVED_END_IO;
+
 	r = bio_crypt_clone(clone, bio, GFP_NOIO);
 	if (r < 0)
 		return r;
@@ -1574,6 +1590,46 @@ static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
 	return true;
 }
 
+/*
+ * Reuse ->bi_end_io as hlist head for storing all dm_io instances
+ * associated with this bio, and this bio's bi_end_io has to be
+ * stored in one of 'dm_io' instance first.
+ */
+static inline struct hlist_head *dm_get_bio_hlist_head(struct bio *bio)
+{
+	WARN_ON_ONCE(!(bio->bi_opf & REQ_SAVED_END_IO));
+	return (struct hlist_head *)&bio->bi_end_io;
+}
+
+static void dm_setup_polled_io(struct clone_info *ci)
+{
+	struct bio *bio = ci->bio;
+
+	/*
+	 * Only support bio polling for normal IO, and the target io is
+	 * exactly inside the dm io instance
+	 */
+	ci->submit_as_polled = bio->bi_opf & REQ_POLLED;
+	if (!ci->submit_as_polled)
+		return;
+
+	INIT_HLIST_NODE(&ci->io->node);
+	/*
+	 * Save .bi_end_io into dm_io, so that we can reuse .bi_end_io
+	 * for storing dm_io list
+	 */
+	if (bio->bi_opf & REQ_SAVED_END_IO) {
+		ci->io->saved_bio_end_io = NULL;
+	} else {
+		ci->io->saved_bio_end_io = bio->bi_end_io;
+		bio->bi_opf |= REQ_SAVED_END_IO;
+		INIT_HLIST_HEAD(dm_get_bio_hlist_head(bio));
+
+		/* tell block layer to poll me */
+		bio->bi_cookie = ~BLK_QC_T_NONE;
+	}
+}
+
 /*
  * Select the correct strategy for processing a non-flush bio.
  */
@@ -1590,6 +1646,8 @@ static int __split_and_process_non_flush(struct clone_info *ci)
 	if (__process_abnormal_io(ci, ti, &r))
 		return r;
 
+	dm_setup_polled_io(ci);
+
 	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
 
 	r = __clone_and_map_data_bio(ci, ti, ci->sector, &len);
@@ -1608,6 +1666,7 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
 	ci->map = map;
 	ci->io = alloc_io(md, bio);
 	ci->sector = bio->bi_iter.bi_sector;
+	ci->submit_as_polled = false;
 }
 
 #define __dm_part_stat_sub(part, field, subnd)	\
@@ -1666,8 +1725,17 @@ static void __split_and_process_bio(struct mapped_device *md,
 		}
 	}
 
-	/* drop the extra reference count */
-	dec_pending(ci.io, errno_to_blk_status(error));
+	/*
+	 * Drop the extra reference count for non-POLLED bio, and hold one
+	 * reference for POLLED bio, which will be released in dm_poll_bio
+	 *
+	 * Add every dm_io instance into the hlist_head which is stored in
+	 * bio->bi_end_io, so that dm_poll_bio can poll them all.
+	 */
+	if (!ci.submit_as_polled)
+		dec_pending(ci.io, errno_to_blk_status(error));
+	else
+		hlist_add_head(&ci.io->node, dm_get_bio_hlist_head(bio));
 }
 
 static void dm_submit_bio(struct bio *bio)
@@ -1707,6 +1775,62 @@ static void dm_submit_bio(struct bio *bio)
 	dm_put_live_table(md, srcu_idx);
 }
 
+static bool dm_poll_dm_io(struct dm_io *io, unsigned int flags)
+{
+	WARN_ON_ONCE(!io->tio.inside_dm_io);
+
+	bio_poll(&io->tio.clone, flags);
+
+	/* bio_poll holds the last reference */
+	return atomic_read(&io->io_count) == 1;
+}
+
+static int dm_poll_bio(struct bio *bio, unsigned int flags)
+{
+	struct dm_io *io;
+	void *saved_bi_end_io = NULL;
+	struct hlist_head tmp = HLIST_HEAD_INIT;
+	struct hlist_head *head = dm_get_bio_hlist_head(bio);
+	struct hlist_node *next;
+
+	/* We only poll normal bio which was marked as REQ_SAVED_END_IO */
+	if (!(bio->bi_opf & REQ_SAVED_END_IO))
+		return 0;
+
+	WARN_ON_ONCE(hlist_empty(head));
+
+	hlist_move_list(head, &tmp);
+
+	hlist_for_each_entry(io, &tmp, node) {
+		if (io->saved_bio_end_io) {
+			saved_bi_end_io = io->saved_bio_end_io;
+			break;
+		}
+	}
+
+	/* restore .bi_end_io before completing dm io */
+	WARN_ON_ONCE(!saved_bi_end_io);
+	bio->bi_opf &= ~REQ_SAVED_END_IO;
+	bio->bi_end_io = saved_bi_end_io;
+
+	hlist_for_each_entry_safe(io, next, &tmp, node) {
+		if (dm_poll_dm_io(io, flags)) {
+			hlist_del_init(&io->node);
+			dec_pending(io, 0);
+		}
+	}
+
+	/* Not done, make sure at least one dm_io stores the .bi_end_io*/
+	if (!hlist_empty(&tmp)) {
+		io = hlist_entry(tmp.first, struct dm_io, node);
+		io->saved_bio_end_io = saved_bi_end_io;
+		bio->bi_opf |= REQ_SAVED_END_IO;
+		hlist_move_list(&tmp, head);
+		return 0;
+	}
+	return 1;
+}
+
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
@@ -3121,6 +3245,7 @@ static const struct pr_ops dm_pr_ops = {
 
 static const struct block_device_operations dm_blk_dops = {
 	.submit_bio = dm_submit_bio,
+	.poll_bio = dm_poll_bio,
 	.open = dm_blk_open,
 	.release = dm_blk_close,
 	.ioctl = dm_blk_ioctl,
-- 
2.31.1

