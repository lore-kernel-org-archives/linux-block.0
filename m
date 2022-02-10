Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C89C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345022AbiBJWis (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345026AbiBJWir (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40146267F
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=IfXmk5i0i3prdNRYxcELXekeRQ6SpDfxxN4oTGtZnNk=;
        b=ZswXJv+i1jnRYtVHjd95iU7q1Xfdq1ijuJePIRMEzlVOw2/TDd8JV8dqI333T1yJJi/T4i
        1+lbGMSstf0vFGKcrjiOCOMPODS/c1KSlM4AdExDTo7yP+8Ehwcn0MalIiSOW1n43/dvqz
        GAVPRVkqrEVcxd3UY83Dat1iV7B8U2g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-Dwy0aWArOrCYaOrYS_eCKw-1; Thu, 10 Feb 2022 17:38:46 -0500
X-MC-Unique: Dwy0aWArOrCYaOrYS_eCKw-1
Received: by mail-qv1-f72.google.com with SMTP id eo11-20020ad4594b000000b0042151b7180aso5025197qvb.8
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IfXmk5i0i3prdNRYxcELXekeRQ6SpDfxxN4oTGtZnNk=;
        b=L1rT5MV1gie9aksuGUu5ygh14Q/Jui76+2j+huYOGM9tvc4tQMH+zEVfGK8Bi+XpDY
         Al34C5S1mUdeTUEn1y+DpWjr/H9p87I5SLXgw0mqGlAmvORm1tRCVh0Yu5dVd/UPaLMm
         2suf2RyJ78Mx3A6kGo82Jlig42By5kUDQHkkgHolK/eZgETA5O3Fgqu2SnBZ/RVCQFbV
         7foSYHbnFucXSr3VAUvMOLS8WLB5M9i9lEKUBs8O1qZ440ZLH1XHF94n4gDcq/aL5vHT
         PaqurUtl2RNH0/JfZL79jg7822T5EPgMlVPKN7KwT2tQgTC9WVkuhR0yt587Zc0Lso6a
         jw2w==
X-Gm-Message-State: AOAM530u8psdnxU4Bk5eFCR9Smx9p8z9b39xL1ekNhtsMSxM4qUzPE1e
        nrdXm8jBuKeulUByRx6zr5Z+46Tv+mfdVn/HMNFVE1lIKKfTJxZLtdVqQzrNW8r1XOkNyRi8BZ5
        EerCiND/DubxspduzbERj5A==
X-Received: by 2002:a05:620a:4012:: with SMTP id h18mr5121613qko.421.1644532725503;
        Thu, 10 Feb 2022 14:38:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/WuBM1MWf014PQYWdlKPzXr9gGf3iIEk91KFNZ30dmljK3pCiGA6TTM3Dqo0OPQkq2MwW1w==
X-Received: by 2002:a05:620a:4012:: with SMTP id h18mr5121607qko.421.1644532725259;
        Thu, 10 Feb 2022 14:38:45 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id c3sm6575052qkp.39.2022.02.10.14.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:44 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 08/14] dm: record old_sector in dm_target_io before calling map function
Date:   Thu, 10 Feb 2022 17:38:26 -0500
Message-Id: <20220210223832.99412-9-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220210223832.99412-1-snitzer@redhat.com>
References: <20220210223832.99412-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prep for being able to defer trace_block_bio_remap() until when the
bio is remapped and submitted by the DM target.

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
index 5950d518e544..3bd872b0e891 100644
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

