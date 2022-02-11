Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE23FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353774AbiBKVla (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiBKVl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFEF0C76
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ZTdCeP53ikFV1i4VLG05XOn5JwONyPZ0x07GjSF9VHQ=;
        b=IGmbk4LooHQHHyYqUhtRKCqYuZkQB7J7T41cn5W2FF9TYwxkKMQI7v9VYOXoD7Zryf2sD4
        NYgXz7OZCrsGmX+dRaWi8+b9KEgDOeHhD2g0kLdQwy6iCWj4GegnS65MtS4SxlkwrJ39Ah
        flIgi0UTietzhX9HMv8D4K0B/OwwTRQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-2ptUq0BlMCia_NqDUZ-ACA-1; Fri, 11 Feb 2022 16:41:24 -0500
X-MC-Unique: 2ptUq0BlMCia_NqDUZ-ACA-1
Received: by mail-oo1-f72.google.com with SMTP id a10-20020a4a988a000000b00318bdbe9370so16077ooj.2
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZTdCeP53ikFV1i4VLG05XOn5JwONyPZ0x07GjSF9VHQ=;
        b=r7Ii6OQjg4pWEJtsCD1Psj/dtHjOaInvj/gMDNaS79a/dGA6DJ9j+tXOT/27r2HoEk
         BhMutqg/H6+26m/8WnpV+vHZcTNEhqaiKZEXtgQKixEhEzU29ShDXG15/8284UeIf9/E
         qw91FmUPOVpU8fcSsXsZ+r3Fr6EtaJJiKYsVSc5q9s4L5wgNKrYPcC11V2pOAP8wtm2v
         c0pijHIBL3lCBYWgXmhzryI+x1PWsDbLz+HXSMu4Je0ANp6iyqM4oN0H/9ABj527NT7N
         Ea7Fpbd3dNg73HwxhsVIELntA4HLMXIaqJV78l7MezcuR++IourjzR8O0qyFilYKUCIv
         twCw==
X-Gm-Message-State: AOAM533rqxsmGRyM1y9IYQBf2bCisfvcg+dLLLo120AobasnjP1j8UcV
        I5UWepsxEQL5sei8BKDyoanFcbTGNpYURzLk0insezwInE/kD7TjmlHgB65TGU3HX2LlzYzyBn5
        zgk2RVH8EctBa8QQ3GcMO/A==
X-Received: by 2002:a05:6808:11c1:: with SMTP id p1mr1159596oiv.62.1644615683307;
        Fri, 11 Feb 2022 13:41:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8ln7pYpddkU+XGN8SlK6Ts0wx4XhZN7aKbGGMg2i3xg9XnfCEYd0cR8QavyaSl2+LXAwvAA==
X-Received: by 2002:a05:6808:11c1:: with SMTP id p1mr1159589oiv.62.1644615683084;
        Fri, 11 Feb 2022 13:41:23 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id x12sm9584980otq.6.2022.02.11.13.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:22 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 11/14] dm: add dm_submit_bio_remap interface
Date:   Fri, 11 Feb 2022 16:40:54 -0500
Message-Id: <20220211214057.40612-12-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch from early bio-based IO accounting (at the time DM clones each
incoming bio) to late IO accounting just before each remapped bio is
issued to underlying device via submit_bio_noacct().

Allows more precise bio-based IO accounting for DM targets that use
their own workqueues to perform additional processing of each bio in
conjunction with their DM_MAPIO_SUBMITTED return from their map
function. When a target is updated to use dm_submit_bio_remap() they
must also set ti->accounts_remapped_io to true.

Use xchg() in start_io_acct(), as suggested by Mikulas, to ensure each
IO is only started once.

Suggested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-core.h          |  1 +
 drivers/md/dm.c               | 59 ++++++++++++++++++++++++++++++++++++-------
 include/linux/device-mapper.h |  7 +++++
 include/uapi/linux/dm-ioctl.h |  4 +--
 4 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index f40be01cca81..7660ead3f744 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -230,6 +230,7 @@ struct dm_io {
 	atomic_t io_count;
 	struct bio *orig_bio;
 	unsigned long start_time;
+	int was_accounted;
 	spinlock_t endio_lock;
 	struct dm_stats_aux stats_aux;
 	/* last member of dm_target_io is 'struct bio' */
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c0177552b471..2461df65e2fe 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -485,9 +485,11 @@ u64 dm_start_time_ns_from_clone(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(dm_start_time_ns_from_clone);
 
-static void start_io_acct(struct dm_io *io)
+static void start_io_acct(struct dm_io *io, struct bio *bio)
 {
-	struct bio *bio = io->orig_bio;
+	/* Ensure IO accounting is only ever started once */
+	if (xchg(&io->was_accounted, 1) == 1)
+		return;
 
 	bio_start_io_acct_remapped(bio, io->start_time,
 				   io->orig_bio->bi_bdev);
@@ -530,6 +532,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	spin_lock_init(&io->endio_lock);
 
 	io->start_time = jiffies;
+	io->was_accounted = 0;
 
 	return io;
 }
@@ -786,6 +789,7 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 	blk_status_t io_error;
 	struct bio *bio;
 	struct mapped_device *md = io->md;
+	bool was_accounted = false;
 	unsigned long start_time = 0;
 	struct dm_stats_aux stats_aux;
 
@@ -819,10 +823,14 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 		}
 
 		io_error = io->status;
-		start_time = io->start_time;
-		stats_aux = io->stats_aux;
+		if (io->was_accounted) {
+			was_accounted = true;
+			start_time = io->start_time;
+			stats_aux = io->stats_aux;
+		}
 		free_io(io);
-		end_io_acct(md, bio, start_time, &stats_aux);
+		if (was_accounted)
+			end_io_acct(md, bio, start_time, &stats_aux);
 
 		/* nudge anyone waiting on suspend queue */
 		if (unlikely(wq_has_sleeper(&md->wait)))
@@ -1100,6 +1108,40 @@ void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors)
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
+	start_io_acct(io, clone);
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
@@ -1152,12 +1194,12 @@ static void __map_bio(struct bio *clone)
 	switch (r) {
 	case DM_MAPIO_SUBMITTED:
 		/* target has assumed ownership of this io */
+		if (!ti->accounts_remapped_io)
+			start_io_acct(io, clone);
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
@@ -1405,7 +1447,6 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	trace_block_split(b, bio->bi_iter.bi_sector);
 	submit_bio_noacct(bio);
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
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index c12ce30b52df..b6df4f6707b5 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -286,9 +286,9 @@ enum {
 #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	45
+#define DM_VERSION_MINOR	46
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2021-03-22)"
+#define DM_VERSION_EXTRA	"-ioctl (2022-02-11)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
-- 
2.15.0

