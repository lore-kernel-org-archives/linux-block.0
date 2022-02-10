Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4302C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbiBJWit (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345026AbiBJWit (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E9BF2664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=NJDDntpX1bDz2HHZg4ERdrCl6N9td/COm3CwT3DXHyU=;
        b=ePhkOheqtvJLVchAgzAB6zuGalMH5BQu+swFoy8ewLziMmGVvnWnd8a1BWbbPTwU87rCcH
        EQkC1Y2QwouamgTwmFg+ndqVdfG4RdQ1M68xFePt3t6WhjNzrQDHY5Gd5iGw7sCW9ABNYH
        zM1YALZBblZYEd+8u1KDS2OKNNiOYNw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-u28ktMO6OGKGctNmkogoSg-1; Thu, 10 Feb 2022 17:38:47 -0500
X-MC-Unique: u28ktMO6OGKGctNmkogoSg-1
Received: by mail-qt1-f200.google.com with SMTP id j6-20020ac85f86000000b002d9c2505d01so4593527qta.15
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NJDDntpX1bDz2HHZg4ERdrCl6N9td/COm3CwT3DXHyU=;
        b=GYv6uHasZdNvNDKJuLBolSU+afpdGXoERUAaXuxG0pFR7aXDPdk8hhxD2ccBSyemKE
         uXUGT8NWMg+SdozTJn/PEVvrxyuv+m+CgML4t8TJBTQx6TiEIfn0X1LYI7X5C+YhanYq
         1iYbhk0NqpRMb70k0kbWLGMPe4wMdvqB5WXDwIRDBF8Q+vDwIkN6cvCLM2IoSHT156GS
         wUws42cDW1fpld52uBhLraT/EoAAkA6X9hSfTc4yVCuPYQAaXCrs2qGCQW/inaZU3uvj
         MuyHrNmsTMO8EW+TY1n5qdFEIPg0pLJfNz1d11mkmntCNCqBJh+xl/mkfj2x6IYfW61f
         twSQ==
X-Gm-Message-State: AOAM530/j1pexHkVv6km+vyXPolKisbVbSoIMVkF/jxSSo92Cs45Rsvs
        8YlqbRbL2JXTKLRcqzNx422exfhFtgkbERh7sHEl7G7UbrYKC9pOfc5g0nzBrtjivm6KfRZ80KV
        ibqfw0S5/ampxuhZa5tc/+Q==
X-Received: by 2002:a05:6214:2308:: with SMTP id gc8mr6697704qvb.108.1644532726814;
        Thu, 10 Feb 2022 14:38:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/swioXpnZqj/ggEJ7xdDFKsnoeOBasBsyZ13Up+u3iQ8ukuq5/OcxD8Z9zGj3LPPEVFxxxw==
X-Received: by 2002:a05:6214:2308:: with SMTP id gc8mr6697693qvb.108.1644532726554;
        Thu, 10 Feb 2022 14:38:46 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id z4sm12115514qtw.4.2022.02.10.14.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:46 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 09/14] dm: prep for following changes
Date:   Thu, 10 Feb 2022 17:38:27 -0500
Message-Id: <20220210223832.99412-10-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rename dm_io struct's 'endio_lock' member to 'lock' to reuse spinlock
to protect new member used to flag if IO accounting has been started.

Also move kicking of the suspend queue out to dm_io_dec_pending (the
only caller) since end_io_acct will soon only be called if IO
accounting was started.

Some comment tweaks and removal of local variables. No functional
change.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-core.h |  2 +-
 drivers/md/dm.c      | 32 ++++++++++++++------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index f40be01cca81..8dd196aec130 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -230,7 +230,7 @@ struct dm_io {
 	atomic_t io_count;
 	struct bio *orig_bio;
 	unsigned long start_time;
-	spinlock_t endio_lock;
+	spinlock_t lock;
 	struct dm_stats_aux stats_aux;
 	/* last member of dm_target_io is 'struct bio' */
 	struct dm_target_io tio;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3bd872b0e891..8c0e96b8e1a5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -487,12 +487,12 @@ EXPORT_SYMBOL_GPL(dm_start_time_ns_from_clone);
 
 static void start_io_acct(struct dm_io *io)
 {
-	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
 
 	bio_start_io_acct_time(bio, io->start_time);
-	if (unlikely(dm_stats_used(&md->stats)))
-		dm_stats_account_io(&md->stats, bio_data_dir(bio),
+
+	if (unlikely(dm_stats_used(&io->md->stats)))
+		dm_stats_account_io(&io->md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
 				    false, 0, &io->stats_aux);
 }
@@ -500,18 +500,12 @@ static void start_io_acct(struct dm_io *io)
 static void end_io_acct(struct mapped_device *md, struct bio *bio,
 			unsigned long start_time, struct dm_stats_aux *stats_aux)
 {
-	unsigned long duration = jiffies - start_time;
-
 	bio_end_io_acct(bio, start_time);
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
-				    true, duration, stats_aux);
-
-	/* nudge anyone waiting on suspend queue */
-	if (unlikely(wq_has_sleeper(&md->wait)))
-		wake_up(&md->wait);
+				    true, jiffies - start_time, stats_aux);
 }
 
 static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
@@ -532,7 +526,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	atomic_set(&io->io_count, 1);
 	io->orig_bio = bio;
 	io->md = md;
-	spin_lock_init(&io->endio_lock);
+	spin_lock_init(&io->lock);
 
 	io->start_time = jiffies;
 
@@ -796,10 +790,10 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 
 	/* Push-back supersedes any I/O errors */
 	if (unlikely(error)) {
-		spin_lock_irqsave(&io->endio_lock, flags);
+		spin_lock_irqsave(&io->lock, flags);
 		if (!(io->status == BLK_STS_DM_REQUEUE && __noflush_suspending(md)))
 			io->status = error;
-		spin_unlock_irqrestore(&io->endio_lock, flags);
+		spin_unlock_irqrestore(&io->lock, flags);
 	}
 
 	if (atomic_dec_and_test(&io->io_count)) {
@@ -829,6 +823,10 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 		free_io(io);
 		end_io_acct(md, bio, start_time, &stats_aux);
 
+		/* nudge anyone waiting on suspend queue */
+		if (unlikely(wq_has_sleeper(&md->wait)))
+			wake_up(&md->wait);
+
 		if (io_error == BLK_STS_DM_REQUEUE)
 			return;
 
@@ -1127,9 +1125,7 @@ static void __map_bio(struct bio *clone)
 	clone->bi_end_io = clone_endio;
 
 	/*
-	 * Map the clone.  If r == 0 we don't need to do
-	 * anything, the target has assumed ownership of
-	 * this io.
+	 * Map the clone.
 	 */
 	dm_io_inc_pending(io);
 	tio->old_sector = clone->bi_iter.bi_sector;
@@ -1154,6 +1150,7 @@ static void __map_bio(struct bio *clone)
 
 	switch (r) {
 	case DM_MAPIO_SUBMITTED:
+		/* target has assumed ownership of this io */
 		break;
 	case DM_MAPIO_REMAPPED:
 		/* the bio has been remapped so dispatch it */
@@ -1301,10 +1298,9 @@ static bool is_abnormal_io(struct bio *bio)
 static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
 				  int *result)
 {
-	struct bio *bio = ci->bio;
 	unsigned num_bios = 0;
 
-	switch (bio_op(bio)) {
+	switch (bio_op(ci->bio)) {
 	case REQ_OP_DISCARD:
 		num_bios = ti->num_discard_bios;
 		break;
-- 
2.15.0

