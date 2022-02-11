Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F53C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349997AbiBKVnD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:43:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353752AbiBKVlK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 327EBC73
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pWHYMVDLAmByoRC12NPUdmnY+6Z0+I5UDqE1eD4oqHM=;
        b=LtbN58yIWpGy/g5c0vkZJpdZsOJK9gfmsD+7hh0fMNi0oy9FFYG1uWSNeGnsuCKx1lbcSf
        S1Hhbh8U2LSPl0LaLBMD4GUT/i4NE+fzRlrhPYzhmZYK3An9mS3JEgQTYxQIRTWIjsYXNH
        cxm4YXIOU/NHOx/yie4ISS1IXziabBs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-1XRDYDeHNjqsv96Ktq7JRw-1; Fri, 11 Feb 2022 16:41:06 -0500
X-MC-Unique: 1XRDYDeHNjqsv96Ktq7JRw-1
Received: by mail-ot1-f71.google.com with SMTP id h5-20020a9d5545000000b0059ecbfae94eso6010525oti.17
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pWHYMVDLAmByoRC12NPUdmnY+6Z0+I5UDqE1eD4oqHM=;
        b=4CTI1zp9I1IECYlh8qDomzYjyAhW67W9p+G11ezkubqs3AUxfP5j78vdTTDm8FLHHS
         iJ8lZdBOv0lKr1udti2r9hFiJjN/v6xDYzRdmf05kyMyjreStR2yyJXzLWB+9KOI6PvL
         iBrmXKdsqRt6lz9QA5sdbostXOCfyv6qzeeVuCMeogK31rXKm4QQ1mSRTo7szt+Gk0L8
         ybiKISCvlGEgUzNayMnQfONCkXBM7/sLBFVQwiE7b6gWNH/nmz5g4UGetEqx3Tk0ngdl
         dyU/6RVitN3Fne1t6EEEVjgLbNeMa8gf51swyJpwV+Sa7dhkwBFQr760RN0o+1jv7TzA
         0g+Q==
X-Gm-Message-State: AOAM531VodUrqMmt+y0JpSb+C4iW432jkOUvjvXBpPLGAGd3HyNfbxMq
        WWCDptFjUGX9dgFYnBKjx+nT5D8tdJB9QcpVHoddX6Jhh5BI9KoyqjNTqNtoh66eU3axW6sGNNk
        PIrWo1hnBK6rStbjvD+Reaw==
X-Received: by 2002:a05:6870:1318:: with SMTP id 24mr771263oab.28.1644615664761;
        Fri, 11 Feb 2022 13:41:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgWYNb7rgOCq30q5kQSDDFSZce9nmYQDDcneTKvKmUg8mfutDHI9Zx5YMSBZTnPEY38/Irbg==
X-Received: by 2002:a05:6870:1318:: with SMTP id 24mr771259oab.28.1644615664550;
        Fri, 11 Feb 2022 13:41:04 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id q4sm9500794otk.39.2022.02.11.13.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:03 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 01/14] dm: rename split functions
Date:   Fri, 11 Feb 2022 16:40:44 -0500
Message-Id: <20220211214057.40612-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rename __split_and_process_bio to dm_split_and_process_bio.
Rename __split_and_process_non_flush to __split_and_process_bio.

Also fix a stale comment and whitespace.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

