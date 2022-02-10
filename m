Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417DEC4332F
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiBJWil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345014AbiBJWil (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8588D267F
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Dmbgb58sJS1NVsv2MiEVE8minE/+DuIbbyXB20Z/ekE=;
        b=E/yt9Fb2ar5YRYAso2OWXKf9lhj2BK/UAkroMVEEBkCqSDHvtdRFqMar/RBTfdYOn7b2HS
        KngeCAV8dwDJXfNphN1odV32uDPeWNz4mVQjX4C0ea2ZGpIHp/jqB3+ALVStu3R4kTpsoW
        zRU6fFuxCl0xYqPNdTSzvBwNrKOQ1xw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-UaIb7MkANWycg3Mbx4ek4w-1; Thu, 10 Feb 2022 17:38:39 -0500
X-MC-Unique: UaIb7MkANWycg3Mbx4ek4w-1
Received: by mail-qt1-f198.google.com with SMTP id j6-20020ac85f86000000b002d9c2505d01so4593302qta.15
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dmbgb58sJS1NVsv2MiEVE8minE/+DuIbbyXB20Z/ekE=;
        b=dsqcYTzna7cX3MIOFXGpJabFEP3Lxh1/axt7n1QyezGi57zGamY8tUSALQm2y5lT6P
         oJosl9HCkezy3nWSAOpVrLTiEalv9Rnukgz7y1Hs4fbHdxC8OXtVZgxycQIG+aZ6sGYz
         jE3PSY/C9qnMz9ciZm1VPEmZTTXFivCM4YgRkXxx6hBG1DLg9UZOlRH5YH6DfvAmZfeN
         OWFmHBgB/YmwrOBBuXZ+UqNzg7p15CISRqL4kIlP5PNzvh452fyUh7ZxwoeTnYD7gbmY
         DAxfmybnh+pfsIRCOXxEquXtji7mqi1TJoXD46JuSNz7lIoZRh25n3zhatePkDPn/1l0
         vtSw==
X-Gm-Message-State: AOAM5309oX1ocfh79Ysi2vifVEn2GvhqB582KFbTtV3Uvd/oGNQXp6B7
        oGlsV9fs4SM6xMu1tfslvgsJuRiodyCv1Kpuvf1PtUSZZb74PmBSHl2fyd3OFNC37K5TmohhWOH
        SYExEJZCVJovIsUeAE8hF3A==
X-Received: by 2002:a37:aac9:: with SMTP id t192mr4866677qke.118.1644532718298;
        Thu, 10 Feb 2022 14:38:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTEaXKZxCVPUG1VrVNIHN3jO/XBixkQ3uTQnAxaqJnd5AV3P7OpyaOaqfg8/NSZ6NUsUbCKA==
X-Received: by 2002:a37:aac9:: with SMTP id t192mr4866671qke.118.1644532718037;
        Thu, 10 Feb 2022 14:38:38 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id f4sm10753431qko.72.2022.02.10.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:37 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 03/14] dm: refactor dm_split_and_process_bio a bit
Date:   Thu, 10 Feb 2022 17:38:21 -0500
Message-Id: <20220210223832.99412-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove needless branching. Leaves code to catch malformed
op_is_zone_mgmt bios (they shouldn't have a payload).

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 51 ++++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2f1942b61d48..56734aae718d 100644
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
@@ -1392,34 +1398,29 @@ static void dm_split_and_process_bio(struct mapped_device *md,
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
+		goto out;
+	}
 
-			bio_chain(b, bio);
-			trace_block_split(b, bio->bi_iter.bi_sector);
-			submit_bio_noacct(bio);
-		}
+	error = __split_and_process_bio(&ci);
+	if (ci.sector_count && !error) {
+		/*
+		 * Remainder must be passed to submit_bio_noacct()
+		 * so that it gets handled *after* bios already submitted
+		 * have been completely processed.
+		 * We take a clone of the original to store in
+		 * ci.io->orig_bio to be used by end_io_acct() and for
+		 * dm_io_dec_pending() to use for completion handling.
+		 */
+		struct bio *b = bio_split(bio, bio_sectors(bio) - ci.sector_count,
+					  GFP_NOIO, &md->queue->bio_split);
+		ci.io->orig_bio = b;
+
+		bio_chain(b, bio);
+		trace_block_split(b, bio->bi_iter.bi_sector);
+		submit_bio_noacct(bio);
 	}
+out:
 	start_io_acct(ci.io);
-
 	/* drop the extra reference count */
 	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
 }
-- 
2.15.0

