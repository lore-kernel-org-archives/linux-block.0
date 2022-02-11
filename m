Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304C1C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353778AbiBKVlY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiBKVlX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9622DC6C
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=faOHtfTWGQl15mu9cVGnYSzZzcsDZXq9izeb7DCgtfk=;
        b=KTAGOFt3WoO6Z2GCFCDOlDN4Cfl69Fvb2ArNcm3dAUCzIhUsek2k6+Q/w9lu74XPY+V3i3
        UpCgH7Cdf/csWEdNDxc1uJyzleJ/zK/Km/2PGenmUdhhTD1Swj+C4NWLup4pY2WCjtAIhk
        Vlrf+YcSXpU6egJ2iuApPjXkqFrvjQg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-fL-baxr_PuCUgmNwsTiVIw-1; Fri, 11 Feb 2022 16:41:19 -0500
X-MC-Unique: fL-baxr_PuCUgmNwsTiVIw-1
Received: by mail-oi1-f197.google.com with SMTP id r15-20020a056808210f00b002d0d8b35b4eso2862574oiw.23
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=faOHtfTWGQl15mu9cVGnYSzZzcsDZXq9izeb7DCgtfk=;
        b=plOLpLr0oXOQBzBMK1GIF7iTpm03GrhZUsqeQypFKpioUKjCRDZu8UXoNbngozF6Cz
         Hkm4wqxDI2kwEAxKT7iPMo0z59Tu2DF0T9YVduoOErGJdfuZrNZyaObs/Ea++qeHL+xs
         dh2OPRv2vL4n5HzNjbaNEeR0LOs9ZS0XXzfnynfHxrVu86RgieLnAF2TzQyIh8kA1NNA
         jDLhew8PXgDehXUvd/wlOXf3aY2kOaBkKxCHpcVzctY866cNJvzoJ5MMVsRpMQ+G2/zl
         H7tbjT5AzVhDS4Qj7oEW9Skq3rEOzsnF2NQnmwSzfIF2JEEZzDw0fD+/mehyNaQjYlPi
         rV1w==
X-Gm-Message-State: AOAM531MfxlH/Dz5pKCZc1yd+53q9uMW7Uh/KR9dJfxpmgx25Qhwh0jR
        gboqpOyReq+wMHp3aQza+UpVfdbZRv5ixf6+jax4fy+acFZxDxK3hW3iHVziWfF44DPx9kk2yjh
        AS2m5LFxbfNMz5mimaMfL4Q==
X-Received: by 2002:a05:6870:35c2:: with SMTP id c2mr769399oak.79.1644615678324;
        Fri, 11 Feb 2022 13:41:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHF2eI3D/fU3NXr6t8JQgauezM5zXIlCfv0BTpbFhkCXv0M5fjNT7muszxcaIOFb2OGolKWg==
X-Received: by 2002:a05:6870:35c2:: with SMTP id c2mr769396oak.79.1644615678110;
        Fri, 11 Feb 2022 13:41:18 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id k6sm9778837oop.28.2022.02.11.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:17 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 08/14] dm: record old_sector in dm_target_io before calling map function
Date:   Fri, 11 Feb 2022 16:40:51 -0500
Message-Id: <20220211214057.40612-9-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prep for being able to defer trace_block_bio_remap() until when the
bio is remapped and submitted by the DM target.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-core.h | 1 +
 drivers/md/dm.c      | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 72d18c3fbf1f..f40be01cca81 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -214,6 +214,7 @@ struct dm_target_io {
 	unsigned int target_bio_nr;
 	unsigned int *len_ptr;
 	bool inside_dm_io;
+	sector_t old_sector;
 	struct bio clone;
 };
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 164cccf59297..2f2002348b26 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -567,6 +567,7 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 	tio->ti = ti;
 	tio->target_bio_nr = target_bio_nr;
 	tio->len_ptr = len;
+	tio->old_sector = 0;
 
 	return &tio->clone;
 }
@@ -1120,7 +1121,6 @@ static void __map_bio(struct bio *clone)
 {
 	struct dm_target_io *tio = clone_to_tio(clone);
 	int r;
-	sector_t sector;
 	struct dm_io *io = tio->io;
 	struct dm_target *ti = tio->ti;
 
@@ -1132,7 +1132,7 @@ static void __map_bio(struct bio *clone)
 	 * this io.
 	 */
 	dm_io_inc_pending(io);
-	sector = clone->bi_iter.bi_sector;
+	tio->old_sector = clone->bi_iter.bi_sector;
 
 	if (unlikely(swap_bios_limit(ti, clone))) {
 		struct mapped_device *md = io->md;
@@ -1157,7 +1157,8 @@ static void __map_bio(struct bio *clone)
 		break;
 	case DM_MAPIO_REMAPPED:
 		/* the bio has been remapped so dispatch it */
-		trace_block_bio_remap(clone, bio_dev(io->orig_bio), sector);
+		trace_block_bio_remap(clone, bio_dev(io->orig_bio),
+				      tio->old_sector);
 		submit_bio_noacct(clone);
 		break;
 	case DM_MAPIO_KILL:
-- 
2.15.0

