Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2C4C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345021AbiBJWil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiBJWik (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 849B32664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Aelm5YgrbgtRcjh/7giXHAljK3Fp2NuUOh2H4+pquFs=;
        b=GIgTagNhNNphI2bEY0NykcUZQ1lHThK9mx4fz2vdZgSiGrYLudGJaQBR2gIsHPyNgGDM2K
        jzH+5MgxhusCDUczk4snc2aPp73Tz/ZYm+Ew8EYMLfysRK4dDehbHOfc1JeKVc1p6AijT6
        TXkxMxF9zRx8WxZwGLFJ+SG5HsrZUr0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-iZrtfFaZPY2dlw7hMjGONw-1; Thu, 10 Feb 2022 17:38:36 -0500
X-MC-Unique: iZrtfFaZPY2dlw7hMjGONw-1
Received: by mail-qv1-f71.google.com with SMTP id a12-20020a056214062c00b0042c2f3fca04so4592085qvx.21
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Aelm5YgrbgtRcjh/7giXHAljK3Fp2NuUOh2H4+pquFs=;
        b=y/Cw5EeszRuFn1ezQie5sllrSa0uTXbdtI7vy3sgaQxR4U78g6rqmpuUXRXJSrgOeC
         xBAbG7A0dHfCxk/ydjsNKvKRMAgtpMKmu1AtLfKlveKYukDMZbWJpaypgg0iqLZjcE+u
         KU9s1uu8eCehqTvCrl0vM3hvgEKQDBzDpsaJQuMULqLpoH2WsvCAU4FGjTqFSPyGMyRE
         u2MwIFEUY6m+XMOuS6QXsF0u3s0OVdoGI1SliLUH+RnDnWaR5gLkUCCx5MfE2hEPMu5H
         HWwUeR3eDyM6F5aJi73N+aJMfCxksCsLpmANINQWZMm47XlvhXq3m/eKJ0OSAB+GKUWL
         D6jA==
X-Gm-Message-State: AOAM531EpRrl1/DP6ySK1MdfP8PcFYCaJalNR+g23xR5Ns7mAvVqZ4WS
        1DPIpjSXaMEPW8jVvRG9+w3lcx6EE6uMh5HH7vhtRsLOm/WvpNOyvwuovnojfjQQVz8/XlZCRNM
        F/3HqRBrm9FQR6eMj9G6PeQ==
X-Received: by 2002:a37:aa08:: with SMTP id t8mr5051594qke.773.1644532715637;
        Thu, 10 Feb 2022 14:38:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQixOwmD12PZY5UkjFPZ06AUK+aTARpLaV0mdw92GohG9RThiH7FoXYWT3NRL1ycsq0RFu0w==
X-Received: by 2002:a37:aa08:: with SMTP id t8mr5051585qke.773.1644532715338;
        Thu, 10 Feb 2022 14:38:35 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w5sm10477933qko.34.2022.02.10.14.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:34 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 01/14] dm: rename split functions
Date:   Thu, 10 Feb 2022 17:38:19 -0500
Message-Id: <20220210223832.99412-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rename __split_and_process_bio to dm_split_and_process_bio.
Rename __split_and_process_non_flush to __split_and_process_bio.

Also fix a stale comment and whitespace.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ab9cc91931f9..2cecb8832936 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1359,7 +1359,7 @@ static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
 /*
  * Select the correct strategy for processing a non-flush bio.
  */
-static int __split_and_process_non_flush(struct clone_info *ci)
+static int __split_and_process_bio(struct clone_info *ci)
 {
 	struct dm_target *ti;
 	unsigned len;
@@ -1395,8 +1395,8 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
 /*
  * Entry point to split a bio into clones and submit them to the targets.
  */
-static void __split_and_process_bio(struct mapped_device *md,
-					struct dm_table *map, struct bio *bio)
+static void dm_split_and_process_bio(struct mapped_device *md,
+				     struct dm_table *map, struct bio *bio)
 {
 	struct clone_info ci;
 	int error = 0;
@@ -1409,19 +1409,19 @@ static void __split_and_process_bio(struct mapped_device *md,
 	} else if (op_is_zone_mgmt(bio_op(bio))) {
 		ci.bio = bio;
 		ci.sector_count = 0;
-		error = __split_and_process_non_flush(&ci);
+		error = __split_and_process_bio(&ci);
 	} else {
 		ci.bio = bio;
 		ci.sector_count = bio_sectors(bio);
-		error = __split_and_process_non_flush(&ci);
+		error = __split_and_process_bio(&ci);
 		if (ci.sector_count && !error) {
 			/*
 			 * Remainder must be passed to submit_bio_noacct()
 			 * so that it gets handled *after* bios already submitted
 			 * have been completely processed.
 			 * We take a clone of the original to store in
-			 * ci.io->orig_bio to be used by end_io_acct() and
-			 * for dec_pending to use for completion handling.
+			 * ci.io->orig_bio to be used by end_io_acct() and for
+			 * dm_io_dec_pending() to use for completion handling.
 			 */
 			struct bio *b = bio_split(bio, bio_sectors(bio) - ci.sector_count,
 						  GFP_NOIO, &md->queue->bio_split);
@@ -1470,7 +1470,7 @@ static void dm_submit_bio(struct bio *bio)
 	if (is_abnormal_io(bio))
 		blk_queue_split(&bio);
 
-	__split_and_process_bio(md, map, bio);
+	dm_split_and_process_bio(md, map, bio);
 out:
 	dm_put_live_table(md, srcu_idx);
 }
@@ -2283,11 +2283,11 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	/*
 	 * Here we must make sure that no processes are submitting requests
 	 * to target drivers i.e. no one may be executing
-	 * __split_and_process_bio from dm_submit_bio.
+	 * dm_split_and_process_bio from dm_submit_bio.
 	 *
-	 * To get all processes out of __split_and_process_bio in dm_submit_bio,
+	 * To get all processes out of dm_split_and_process_bio in dm_submit_bio,
 	 * we take the write lock. To prevent any process from reentering
-	 * __split_and_process_bio from dm_submit_bio and quiesce the thread
+	 * dm_split_and_process_bio from dm_submit_bio and quiesce the thread
 	 * (dm_wq_work), we set DMF_BLOCK_IO_FOR_SUSPEND and call
 	 * flush_workqueue(md->wq).
 	 */
-- 
2.15.0

