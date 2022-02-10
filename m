Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F73C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbiBJWiw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbiBJWiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 799D6267F
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=clg1j9AsWGf13nZ+cL57xlbQXn238yrRMLtUXnWXd9Q=;
        b=U8AyYiF5QJbPl4iNPt8CPHpfljTxFc6Q/p5P8htPqs32l+mzYtsNHwTksGR19tt+wWfRxw
        GuF39lGhgzGP4DjZOGUWnaT8Yt8dAc4j61sg4lHigaEsul0CbSMkACD8sB32plDD+NLyCi
        FlnpwH/H5EnWkBPV01pJuui33G1Be0w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-bkBE7R7VN6ieUV5dBD8J-g-1; Thu, 10 Feb 2022 17:38:49 -0500
X-MC-Unique: bkBE7R7VN6ieUV5dBD8J-g-1
Received: by mail-qv1-f69.google.com with SMTP id t3-20020a0562140c6300b00424a0fd3721so5014019qvj.12
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=clg1j9AsWGf13nZ+cL57xlbQXn238yrRMLtUXnWXd9Q=;
        b=cWVIh4Uz15TixlQaZ/fqxYNthQ3kvZnJpJDZoyKXPgjL06CLrtBvPGXBcrZWxIsTzl
         NKEFEW9vvB3BOGgr+nVvM2KCIZ5o2A3pBffY1fjjoGErbBH3RwWMBst1mg1hx5IYRmLf
         EjJHpEViZ77sKBFtD4k0fhBpXV7esMY1NnXKnr2UxRzcOCR5dmwF766ICieeeiiSAKbf
         Fr8/O/6Z4uMXtWaB+otxFYjUQJ+SIfFDMD5p28/T1fQjcYHqAUJxruAdEfwf3m/13BCD
         qIce21+d3+fXs5usDRocCcPTBfeMumwPlwl+0PIP26eQbFS8AbADLYUFYGER1ibnN+KO
         X3Sw==
X-Gm-Message-State: AOAM53031Npa0hTV7+2ibTrg/lfJJc+NZ0Zyme9QPEy+ts9uYffmEQSw
        T2DUPQoJhWsbEsiEarttG4Ulh7GbeVfrxTmkabIED+uTkgHn7mL2/dFJ4SPQeQsM7Gq29rmj4Po
        YdzbTySqJBQuW5UZReylKNA==
X-Received: by 2002:a37:61ca:: with SMTP id v193mr5007960qkb.177.1644532728446;
        Thu, 10 Feb 2022 14:38:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2IldN0gw3kZyxdPqUqit4+42CSSY2elFZp9qQdt60LjZzqSwEFWIWb3gl3fnkNs62ee8TQw==
X-Received: by 2002:a37:61ca:: with SMTP id v193mr5007952qkb.177.1644532728122;
        Thu, 10 Feb 2022 14:38:48 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w14sm12344783qtc.29.2022.02.10.14.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:47 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 10/14] dm: add dm_submit_bio_remap interface
Date:   Thu, 10 Feb 2022 17:38:28 -0500
Message-Id: <20220210223832.99412-11-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch from early bio-based IO accounting (at the time DM clones each
incoming bio) to late IO accounting just before each remapped bio is
issued to underlying device via submit_bio_noacct().

Allows more precise bio-based IO accounting for DM targets that use
their own workqueues to perform additional processing of each bio in
conjunction with their DM_MAPIO_SUBMITTED return from their map
function.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-core.h          |  1 +
 drivers/md/dm.c               | 93 +++++++++++++++++++++++++++++++++++++++----
 include/linux/device-mapper.h |  7 ++++
 3 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 8dd196aec130..3ecd6f294f53 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -230,6 +230,7 @@ struct dm_io {
 	atomic_t io_count;
 	struct bio *orig_bio;
 	unsigned long start_time;
+	unsigned long io_acct_time;
 	spinlock_t lock;
 	struct dm_stats_aux stats_aux;
 	/* last member of dm_target_io is 'struct bio' */
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8c0e96b8e1a5..ad512f40716e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -485,21 +485,54 @@ u64 dm_start_time_ns_from_clone(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(dm_start_time_ns_from_clone);
 
-static void start_io_acct(struct dm_io *io)
+static void __start_io_acct(struct dm_io *io, struct bio *bio)
 {
-	struct bio *bio = io->orig_bio;
+	unsigned long flags;
 
-	bio_start_io_acct_time(bio, io->start_time);
+	/* Ensure IO accounting is only ever started once */
+	spin_lock_irqsave(&io->lock, flags);
+	if (smp_load_acquire(&io->io_acct_time)) {
+		spin_unlock_irqrestore(&io->lock, flags);
+		return;
+	}
+	smp_store_release(&io->io_acct_time, jiffies);
+	spin_unlock_irqrestore(&io->lock, flags);
 
+	bio_start_io_acct_time(bio, io->start_time);
 	if (unlikely(dm_stats_used(&io->md->stats)))
 		dm_stats_account_io(&io->md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
 				    false, 0, &io->stats_aux);
 }
 
+static void start_io_acct(struct dm_io *io, struct bio *bio)
+{
+	/* Only start_io_acct() once for this IO */
+	if (smp_load_acquire(&io->io_acct_time))
+		return;
+
+	__start_io_acct(io, bio);
+}
+
+static void clone_and_start_io_acct(struct dm_io *io, struct bio *bio)
+{
+	struct bio io_acct_clone;
+
+	/* Only clone_and_start_io_acct() once for this IO */
+	if (smp_load_acquire(&io->io_acct_time))
+		return;
+
+	bio_init_clone(io->orig_bio->bi_bdev,
+		       &io_acct_clone, bio, GFP_NOIO);
+	__start_io_acct(io, &io_acct_clone);
+}
+
 static void end_io_acct(struct mapped_device *md, struct bio *bio,
 			unsigned long start_time, struct dm_stats_aux *stats_aux)
 {
+	if (!start_time)
+		return;
+
 	bio_end_io_acct(bio, start_time);
 
 	if (unlikely(dm_stats_used(&md->stats)))
@@ -529,6 +562,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	spin_lock_init(&io->lock);
 
 	io->start_time = jiffies;
+	io->io_acct_time = 0;
 
 	return io;
 }
@@ -818,7 +852,8 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 		}
 
 		io_error = io->status;
-		start_time = io->start_time;
+		if (io->io_acct_time)
+			start_time = io->start_time;
 		stats_aux = io->stats_aux;
 		free_io(io);
 		end_io_acct(md, bio, start_time, &stats_aux);
@@ -1099,6 +1134,43 @@ void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors)
 }
 EXPORT_SYMBOL_GPL(dm_accept_partial_bio);
 
+/*
+ * @clone: clone bio that DM core passed to target's .map function
+ * @tgt_clone: bio that target needs to submit (after DM_MAPIO_SUBMITTED)
+ *
+ * Targets should use this interface to submit bios they take
+ * ownership of when returning DM_MAPIO_SUBMITTED.
+ *
+ * Target should also enable ti->accounts_remapped_io
+ */
+void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone)
+{
+	struct dm_target_io *tio = clone_to_tio(clone);
+	struct dm_io *io = tio->io;
+	struct block_device *clone_bdev = clone->bi_bdev;
+
+	/* establish bio that will get submitted */
+	if (!tgt_clone)
+		tgt_clone = clone;
+
+	/*
+	 * account IO to DM device in terms of clone's
+	 * payload to avoid concern about late bio splitting.
+	 * - clone will reflect any dm_accept_partial_bio()
+	 * - any bio splitting is ultimately reflected in
+	 *   io->orig_bio so there is no IO imbalance in
+	 *   end_io_acct().
+	 */
+	clone->bi_bdev = io->orig_bio->bi_bdev;
+	start_io_acct(io, clone);
+	clone->bi_bdev = clone_bdev;
+
+	trace_block_bio_remap(tgt_clone, bio_dev(io->orig_bio),
+			      tio->old_sector);
+	submit_bio_noacct(tgt_clone);
+}
+EXPORT_SYMBOL_GPL(dm_submit_bio_remap);
+
 static noinline void __set_swap_bios_limit(struct mapped_device *md, int latch)
 {
 	mutex_lock(&md->swap_bios_lock);
@@ -1151,12 +1223,18 @@ static void __map_bio(struct bio *clone)
 	switch (r) {
 	case DM_MAPIO_SUBMITTED:
 		/* target has assumed ownership of this io */
+		if (!ti->accounts_remapped_io) {
+			/*
+			 * Any split isn't reflected in io->orig_bio yet. And bio
+			 * cannot be modified because target is submitting it.
+			 * Clone bio and account IO to DM device.
+			 */
+			clone_and_start_io_acct(io, clone);
+		}
 		break;
 	case DM_MAPIO_REMAPPED:
 		/* the bio has been remapped so dispatch it */
-		trace_block_bio_remap(clone, bio_dev(io->orig_bio),
-				      tio->old_sector);
-		submit_bio_noacct(clone);
+		dm_submit_bio_remap(clone, NULL);
 		break;
 	case DM_MAPIO_KILL:
 	case DM_MAPIO_REQUEUE:
@@ -1403,7 +1481,6 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 		submit_bio_noacct(bio);
 	}
 out:
-	start_io_acct(ci.io);
 	/* drop the extra reference count */
 	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
 }
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index b26fecf6c8e8..a3e397155bc9 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -362,6 +362,12 @@ struct dm_target {
 	 * zone append operations using regular writes.
 	 */
 	bool emulate_zone_append:1;
+
+	/*
+	 * Set if the target will submit IO using dm_submit_bio_remap()
+	 * after returning DM_MAPIO_SUBMITTED from its map function.
+	 */
+	bool accounts_remapped_io:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
@@ -465,6 +471,7 @@ int dm_suspended(struct dm_target *ti);
 int dm_post_suspending(struct dm_target *ti);
 int dm_noflush_suspending(struct dm_target *ti);
 void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors);
+void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone);
 union map_info *dm_get_rq_mapinfo(struct request *rq);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.15.0

