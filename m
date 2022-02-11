Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE99FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346319AbiBKVlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiBKVlR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39460C6C
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=91++qBctEBqt/WcCJjsVysQVehP+OlczjZE5uyGHky0=;
        b=hcnBSi9xU0zPxHOean9kci1IlQn/44vdaxmXA1+FeiNwWtpPOO1JRpts4yOLSwglJsRpqa
        S0mit0E8+vntHaPTY7NGE6A+GL+aDcj4UEb9usnRHFB4re1p4Q9yWJQDvAYKgIsbrIa7wN
        ciCP5i9RVxerLbeuLDYuyG/r9BWkXBQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-JK8pW2OTMEKtSns0E-NKsg-1; Fri, 11 Feb 2022 16:41:13 -0500
X-MC-Unique: JK8pW2OTMEKtSns0E-NKsg-1
Received: by mail-oo1-f71.google.com with SMTP id h7-20020a4aa287000000b002eb15de5797so6313847ool.23
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=91++qBctEBqt/WcCJjsVysQVehP+OlczjZE5uyGHky0=;
        b=jLGQCMvK1IA7P+IseDN49Dybp+9Qr7ZSMx7Wj2CM3RSa9iO5h+IrRROm3WHOCNFpLc
         CYe0iHm5BS5UzyFTogN09ZDqJZClbEalHA5k+X4158dBUzr1LqXmWQaDFFlFNG1YM7Lw
         7efq4nEYIW3XqTnr/gq7cZzHRJYZweUOYp19REtcJhKnSb9LE3CTWrIDHynlCh25BW42
         JhekQnuGvh76CBjxz0fqeZLRf0Rxb5GovG+B2fyhfZeOIu40IlYGn9IN/ovFAutKmk/9
         dotzLTsFL79jfs1e/vbRxTqIySiijl22SR9Ukm0Rv/OgrkkaJ8er37MShwsVoajGS00n
         1rtQ==
X-Gm-Message-State: AOAM5324bYgeaF9DQ4pv1Saww51lyCjxnROb3Zx/6ZHF3qOvpqOHl9BO
        JXCKGjBFSYAgZs0x7e8DbuKm+QWnuIhyAl8UEajrD0atyN0Bb5bAf6pfJ8MZFrtafpyo+9ytsvq
        dX9NaGq0qrnbMiRYG3cdnDQ==
X-Received: by 2002:a05:6808:bcb:: with SMTP id o11mr1188058oik.2.1644615670499;
        Fri, 11 Feb 2022 13:41:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjJHjKjIojAV77eZvxdta7gUDgvuGSRfVHpC7eifGNL5o3XbrHtskQjvhxdmdPuuAqN+mUCw==
X-Received: by 2002:a05:6808:bcb:: with SMTP id o11mr1188019oik.2.1644615669127;
        Fri, 11 Feb 2022 13:41:09 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id p5sm9852027oou.39.2022.02.11.13.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:08 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 03/14] dm: refactor dm_split_and_process_bio a bit
Date:   Fri, 11 Feb 2022 16:40:46 -0500
Message-Id: <20220211214057.40612-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove needless branching and indentation. Leaves code to catch
malformed op_is_zone_mgmt bios (they shouldn't have a payload).

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 54 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2f1942b61d48..60a047de620f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1375,7 +1375,13 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
 {
 	ci->map = map;
 	ci->io = alloc_io(md, bio);
+	ci->bio = bio;
 	ci->sector = bio->bi_iter.bi_sector;
+	ci->sector_count = bio_sectors(bio);
+
+	/* Shouldn't happen but sector_count was being set to 0 so... */
+	if (WARN_ON_ONCE(op_is_zone_mgmt(bio_op(bio)) && ci->sector_count))
+		ci->sector_count = 0;
 }
 
 /*
@@ -1385,6 +1391,7 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 				     struct dm_table *map, struct bio *bio)
 {
 	struct clone_info ci;
+	struct bio *b;
 	int error = 0;
 
 	init_clone_info(&ci, md, map, bio);
@@ -1392,34 +1399,29 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	if (bio->bi_opf & REQ_PREFLUSH) {
 		error = __send_empty_flush(&ci);
 		/* dm_io_dec_pending submits any data associated with flush */
-	} else if (op_is_zone_mgmt(bio_op(bio))) {
-		ci.bio = bio;
-		ci.sector_count = 0;
-		error = __split_and_process_bio(&ci);
-	} else {
-		ci.bio = bio;
-		ci.sector_count = bio_sectors(bio);
-		error = __split_and_process_bio(&ci);
-		if (ci.sector_count && !error) {
-			/*
-			 * Remainder must be passed to submit_bio_noacct()
-			 * so that it gets handled *after* bios already submitted
-			 * have been completely processed.
-			 * We take a clone of the original to store in
-			 * ci.io->orig_bio to be used by end_io_acct() and for
-			 * dm_io_dec_pending() to use for completion handling.
-			 */
-			struct bio *b = bio_split(bio, bio_sectors(bio) - ci.sector_count,
-						  GFP_NOIO, &md->queue->bio_split);
-			ci.io->orig_bio = b;
-
-			bio_chain(b, bio);
-			trace_block_split(b, bio->bi_iter.bi_sector);
-			submit_bio_noacct(bio);
-		}
+		goto out;
 	}
-	start_io_acct(ci.io);
 
+	error = __split_and_process_bio(&ci);
+	if (error || !ci.sector_count)
+		goto out;
+
+	/*
+	 * Remainder must be passed to submit_bio_noacct() so it gets handled
+	 * *after* bios already submitted have been completely processed.
+	 * We take a clone of the original to store in ci.io->orig_bio to be
+	 * used by end_io_acct() and for dm_io_dec_pending() to use for
+	 * completion handling.
+	 */
+	b = bio_split(bio, bio_sectors(bio) - ci.sector_count,
+		      GFP_NOIO, &md->queue->bio_split);
+	ci.io->orig_bio = b;
+
+	bio_chain(b, bio);
+	trace_block_split(b, bio->bi_iter.bi_sector);
+	submit_bio_noacct(bio);
+out:
+	start_io_acct(ci.io);
 	/* drop the extra reference count */
 	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
 }
-- 
2.15.0

