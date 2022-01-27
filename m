Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D253DC433FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 19:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbiA0THw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:07:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239096AbiA0THu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 14:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643310470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=tQTNouHLD2pqrJUsY0rGuooqQ0qZGduHNcta+zU07XE=;
        b=FRFFPXXe6tbwdCYNEGkqUSyHvZfPRhUiOp2RVRFK9U24xm/dIWU65kfcnJghAntL476i7H
        2ZPORn4YP7ONm3/UujipAfSb5bI1EJr8+2x48rUankIb7dBpVgyAZyyYfR7SfVEqMx2iVA
        75HbP6GRG12OT4X42loDgtL//WER3ZM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-8tguTwWvN9Wi41PORefwrQ-1; Thu, 27 Jan 2022 14:07:48 -0500
X-MC-Unique: 8tguTwWvN9Wi41PORefwrQ-1
Received: by mail-qt1-f197.google.com with SMTP id d25-20020ac84e39000000b002d1cf849207so2910250qtw.19
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 11:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQTNouHLD2pqrJUsY0rGuooqQ0qZGduHNcta+zU07XE=;
        b=deCymPRBOyCv7+cWEQGoY3X6XfES4Yb7bzsWflRoeLz5BGHsxM3w+dfedLqYFfRMVF
         BzMjEdvDpCm1NRRtruXjHQpV1yrNvJDX0kXNlWuSHjebL9uFxy0It4R58ODfQ7hRAA2V
         lUnREHfT5JIqetl/qyPbHqK6JxNykZMuO1hvGCz7Ap/y3D82KVOdxv9e/VpVR4bVIiYz
         xehAd628P9wsnusTA2M3Do3wtl/vLkEuNokq5SvEWjyUXtxGgQesKb4fTC26T9nLsIi1
         Ik1dlZfZCRtQjoeOOO0MyVyJkmNOQl6/kwU8EN4spmTls0/QQvqZ5lDkEjGONbQW/syn
         foKA==
X-Gm-Message-State: AOAM531BIPfbQw3tpe9mThoCxdNalwiTb/y/iWP+jwxOd9T5iWmHrUIp
        TV9SgTvhR5IG++ZXf3g0rNGdm1Vg1fjlM5EmgLIfu76r27Hq7paZDMxt59h/dp1tmN2kPgz6hj5
        AEGN37fICeVxG2Ktj4fdn4g==
X-Received: by 2002:a05:6214:5283:: with SMTP id kj3mr4186782qvb.44.1643310467909;
        Thu, 27 Jan 2022 11:07:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLXfr5ejiKHZx1ikK0AjZiulBItlwcYvACwkbT0h4rgqFSKIcHUzV6pNWRSgRjrkRpIubxgg==
X-Received: by 2002:a05:6214:5283:: with SMTP id kj3mr4186766qvb.44.1643310467651;
        Thu, 27 Jan 2022 11:07:47 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r3sm1816610qkm.56.2022.01.27.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:07:47 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 2/3] dm: revert partial fix for redundant bio-based IO accounting
Date:   Thu, 27 Jan 2022 14:07:41 -0500
Message-Id: <20220127190742.12776-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220127190742.12776-1-snitzer@redhat.com>
References: <20220127190742.12776-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reverts a1e1cb72d9649 ("dm: fix redundant IO accounting for bios that
need splitting") because it was too narrow in scope (only addressed
redundant 'sectors[]' accounting and not ios, nsecs[], etc).

Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c0ae8087c602..9849114b3c08 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1442,9 +1442,6 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
 	ci->sector = bio->bi_iter.bi_sector;
 }
 
-#define __dm_part_stat_sub(part, field, subnd)	\
-	(part_stat_get(part, field) -= (subnd))
-
 /*
  * Entry point to split a bio into clones and submit them to the targets.
  */
@@ -1480,18 +1477,6 @@ static void __split_and_process_bio(struct mapped_device *md,
 						  GFP_NOIO, &md->queue->bio_split);
 			ci.io->orig_bio = b;
 
-			/*
-			 * Adjust IO stats for each split, otherwise upon queue
-			 * reentry there will be redundant IO accounting.
-			 * NOTE: this is a stop-gap fix, a proper fix involves
-			 * significant refactoring of DM core's bio splitting
-			 * (by eliminating DM's splitting and just using bio_split)
-			 */
-			part_stat_lock();
-			__dm_part_stat_sub(dm_disk(md)->part0,
-					   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
-			part_stat_unlock();
-
 			bio_chain(b, bio);
 			trace_block_split(b, bio->bi_iter.bi_sector);
 			submit_bio_noacct(bio);
-- 
2.15.0

