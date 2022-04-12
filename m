Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5113C3525B
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 10:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357413AbiDLKMA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354578AbiDLJy6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 05:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5584E69711
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649753852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AkmDzoOChf/Y0UeYgAZNrZe9pnkMx1X8Z2ccJB/XkG4=;
        b=DreEBLuzFJgbgeEg/mdTeZjUwjirCDCLDtnc/jOv7DOIleL6AQFta0UCKsRy9EJKnCihUl
        f204ZiYhmEgcq+zmdYv6srp8ULXBkoh/giURTR/VKoKS4ShT4rlEaOdbjGKY45lx3Uhntf
        iFu+CamxE2lXVmqE5QORaLG9EOd1na4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584--xn3_nRdP46RxcxkMJWqxw-1; Tue, 12 Apr 2022 04:57:28 -0400
X-MC-Unique: -xn3_nRdP46RxcxkMJWqxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F29B3C14851;
        Tue, 12 Apr 2022 08:57:28 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE96145BA42;
        Tue, 12 Apr 2022 08:57:27 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/8] dm: improve target io referencing
Date:   Tue, 12 Apr 2022 16:56:15 +0800
Message-Id: <20220412085616.1409626-8-ming.lei@redhat.com>
In-Reply-To: <20220412085616.1409626-1-ming.lei@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently target io's reference counter is grabbed before calling
__map_bio(), this way isn't efficient since we can move this grabbing
into alloc_io().

Meantime it becomes typical async io reference counter model: one is
for submission side, the other is for completion side, and the io won't
be completed until both two sides are done.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm.c | 51 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3c3ba6b4e19b..2987f7cf7b47 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -587,7 +587,9 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	io = container_of(tio, struct dm_io, tio);
 	io->magic = DM_IO_MAGIC;
 	io->status = 0;
-	atomic_set(&io->io_count, 1);
+
+	/* one is for submission, the other is for completion */
+	atomic_set(&io->io_count, 2);
 	this_cpu_inc(*md->pending_io);
 	io->orig_bio = bio;
 	io->md = md;
@@ -937,11 +939,6 @@ static inline bool dm_tio_is_normal(struct dm_target_io *tio)
 		!dm_tio_flagged(tio, DM_TIO_IS_DUPLICATE_BIO));
 }
 
-static void dm_io_inc_pending(struct dm_io *io)
-{
-	atomic_inc(&io->io_count);
-}
-
 /*
  * Decrements the number of outstanding ios that a bio has been
  * cloned into, completing the original io if necc.
@@ -1276,7 +1273,6 @@ static void __map_bio(struct bio *clone)
 	/*
 	 * Map the clone.
 	 */
-	dm_io_inc_pending(io);
 	tio->old_sector = clone->bi_iter.bi_sector;
 
 	if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1358,11 +1354,12 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 	}
 }
 
-static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
+static int __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 				  unsigned num_bios, unsigned *len)
 {
 	struct bio_list blist = BIO_EMPTY_LIST;
 	struct bio *clone;
+	int ret = 0;
 
 	switch (num_bios) {
 	case 0:
@@ -1371,15 +1368,19 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 		clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
 		dm_tio_set_flag(clone_to_tio(clone), DM_TIO_IS_DUPLICATE_BIO);
 		__map_bio(clone);
+		ret = 1;
 		break;
 	default:
 		alloc_multiple_bios(&blist, ci, ti, num_bios, len);
 		while ((clone = bio_list_pop(&blist))) {
 			dm_tio_set_flag(clone_to_tio(clone), DM_TIO_IS_DUPLICATE_BIO);
 			__map_bio(clone);
+			ret += 1;
 		}
 		break;
 	}
+
+	return ret;
 }
 
 static void __send_empty_flush(struct clone_info *ci)
@@ -1399,8 +1400,19 @@ static void __send_empty_flush(struct clone_info *ci)
 	ci->bio = &flush_bio;
 	ci->sector_count = 0;
 
-	while ((ti = dm_table_get_target(ci->map, target_nr++)))
-		__send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
+	while ((ti = dm_table_get_target(ci->map, target_nr++))) {
+		int bios;
+
+		atomic_add(ti->num_flush_bios, &ci->io->io_count);
+		bios = __send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
+		atomic_sub(ti->num_flush_bios - bios, &ci->io->io_count);
+	}
+
+	/*
+	 * alloc_io() takes one extra reference for submission, so the
+	 * reference won't reach 0 after the following subtraction
+	 */
+	atomic_sub(1, &ci->io->io_count);
 
 	bio_uninit(ci->bio);
 }
@@ -1409,6 +1421,7 @@ static void __send_changing_extent_only(struct clone_info *ci, struct dm_target
 					unsigned num_bios)
 {
 	unsigned len;
+	int bios;
 
 	len = min_t(sector_t, ci->sector_count,
 		    max_io_len_target_boundary(ti, dm_target_offset(ti, ci->sector)));
@@ -1420,7 +1433,13 @@ static void __send_changing_extent_only(struct clone_info *ci, struct dm_target
 	ci->sector += len;
 	ci->sector_count -= len;
 
-	__send_duplicate_bios(ci, ti, num_bios, &len);
+	atomic_add(num_bios, &ci->io->io_count);
+	bios = __send_duplicate_bios(ci, ti, num_bios, &len);
+	/*
+	 * alloc_io() takes one extra reference for submission, so the
+	 * reference won't reach 0 after the following subtraction
+	 */
+	atomic_sub(num_bios - bios + 1, &ci->io->io_count);
 }
 
 static bool is_abnormal_io(struct bio *bio)
@@ -1603,9 +1622,15 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	 * Add every dm_io instance into the hlist_head which is stored in
 	 * bio->bi_private, so that dm_poll_bio can poll them all.
 	 */
-	if (error || !ci.submit_as_polled)
+	if (error || !ci.submit_as_polled) {
+		/*
+		 * In case of submission failure, the extra reference for
+		 * submitting io isn't consumed yet
+		 */
+		if (error)
+			atomic_dec(&ci.io->io_count);
 		dm_io_dec_pending(ci.io, errno_to_blk_status(error));
-	else
+	} else
 		dm_queue_poll_io(bio, ci.io);
 }
 
-- 
2.31.1

