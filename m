Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191C5C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353767AbiBKVlW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiBKVlV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE4CC65
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=f2o5ohPI2HuG5wRnh3mt12sAQPRqGLpu4c/5MftkwBY=;
        b=QJqSpxe+I1lv58tSoM3rVkbHMZ9E3UMwmrD3poozf9CQHUj91OoXymwDYhuEx2andze3JT
        QF05xC/Tz7wZdLxDMj95sFZouZBPOgNZ3NNKdH7AhB0Glg3a+tsxYKOz/hGow1JbSidZgR
        K8AcJntS+4vFwiqVYNy+pQqQZ+qH4uk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-06De6sREM0eGqmTecja5aA-1; Fri, 11 Feb 2022 16:41:17 -0500
X-MC-Unique: 06De6sREM0eGqmTecja5aA-1
Received: by mail-oo1-f71.google.com with SMTP id j18-20020a4ae852000000b003181c031d81so6287204ooj.22
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f2o5ohPI2HuG5wRnh3mt12sAQPRqGLpu4c/5MftkwBY=;
        b=k7/Qnkj0D5V7BHgioA6VmhoybWRWejOglmVzoQQv/M8jt1cR+lzk2PzoIKmUIgetDl
         ld7ttNE5FzLNDC8nS3RuqzT1g5kC6BlEm1yRLw80k9WFNVARNKn3+T8QAqvjCOaDOpOt
         JSPnuSyWAhRDOY1IyGXNnSCHqTL3AR4rUilLl2lJGhr84CDzg8R0img4FDNLCoFrzT3e
         +t7sm/wlK2T/tEPmJH8eQzg0lDF/M1pA1dNh/Aoxt2ElMN8n1SiUOdwebHx76DbmIkNX
         0DQV/GyZzqU+J82yWOuB/69E/Y5ewSourfslC/LYW9XODe9Aze2Btrnp6GpejX7KsROl
         U5wA==
X-Gm-Message-State: AOAM530OXmBSl3Ywbc19PAp0jxqkdhHCSV4tHJsfc0FJ5EWnSFNtZqQC
        xSBIYLzMp4mGoGK17jJMeHlOlWDnXEV/tL10Mb7+THAziE94hjVXyJeDrslUzAOhuxLBwfo5hWf
        dvvxhf7zogBjJlXE55DqPAw==
X-Received: by 2002:a05:6870:8784:: with SMTP id r4mr784939oam.274.1644615676697;
        Fri, 11 Feb 2022 13:41:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmRjUtja3RP0gsAIOMggI4AOA1jQTFBsYiSLmauHnRAgEORh5WQj00HCwcy/wmJj5xdWtFcQ==
X-Received: by 2002:a05:6870:8784:: with SMTP id r4mr784936oam.274.1644615676503;
        Fri, 11 Feb 2022 13:41:16 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id y3sm10183932oix.41.2022.02.11.13.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:16 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 07/14] dm: remove code only needed before submit_bio recursion
Date:   Fri, 11 Feb 2022 16:40:50 -0500
Message-Id: <20220211214057.40612-8-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 8615cb65bd63 ("dm: remove useless loop in
__split_and_process_bio") showcased that we no longer loop.

Remove the bio_advance() in __split_and_process_bio() that was only
needed when looping was possible.

Similarly there is no need to advance the bio, using ci->sector
cursor, in __send_duplicate_bios().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 137e578785f6..164cccf59297 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1176,12 +1176,6 @@ static void __map_bio(struct bio *clone)
 	}
 }
 
-static void bio_setup_sector(struct bio *bio, sector_t sector, unsigned len)
-{
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_iter.bi_size = to_bytes(len);
-}
-
 static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 				struct dm_target *ti, unsigned num_bios,
 				unsigned *len)
@@ -1224,14 +1218,14 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 	case 1:
 		clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
 		if (len)
-			bio_setup_sector(clone, ci->sector, *len);
+			clone->bi_iter.bi_size = to_bytes(*len);
 		__map_bio(clone);
 		break;
 	default:
 		alloc_multiple_bios(&blist, ci, ti, num_bios, len);
 		while ((clone = bio_list_pop(&blist))) {
 			if (len)
-				bio_setup_sector(clone, ci->sector, *len);
+				clone->bi_iter.bi_size = to_bytes(*len);
 			__map_bio(clone);
 		}
 		break;
@@ -1350,7 +1344,6 @@ static int __split_and_process_bio(struct clone_info *ci)
 	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
 
 	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
-	bio_advance(clone, to_bytes(ci->sector - clone->bi_iter.bi_sector));
 	clone->bi_iter.bi_size = to_bytes(len);
 	if (bio_integrity(clone))
 		bio_integrity_trim(clone);
-- 
2.15.0

