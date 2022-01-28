Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66750C4332F
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 15:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349817AbiA1P65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349786AbiA1P6s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643385528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=tQTNouHLD2pqrJUsY0rGuooqQ0qZGduHNcta+zU07XE=;
        b=FZtUa77uXrV0INRVKWvDwSVylDmoAcFP8Yw4ipfLS9rzHgTjERJnkxa8thVAar1lUJKeSe
        xYOcJ5HND69Ov5njDk3V5/ah6dx1NG5ZvgimJbNxam3NXPzZjclZHdrIL2W2rzVAXmdEx/
        dA8O0EcdOpR3G/kXleYNwFYQc5RGvRo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-RbTfwYyyP5alMs-oWNVrng-1; Fri, 28 Jan 2022 10:58:46 -0500
X-MC-Unique: RbTfwYyyP5alMs-oWNVrng-1
Received: by mail-qt1-f200.google.com with SMTP id c20-20020ac84e14000000b002d198444921so4784285qtw.23
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 07:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQTNouHLD2pqrJUsY0rGuooqQ0qZGduHNcta+zU07XE=;
        b=GUKw0sypuiCHeof58KAOp2hVVIfZubTyHxG+ciqwtIeuh+RldDNBmggZX/603Ewyd8
         TB/qaEgsitLBshxvpX+J3IqcCBel5q2gzsON3xsdJxiIHuCuO8KsPTV/Q1lDCREU+AOQ
         /1Z+M+na7TeQNSAYkmgMuOwyjGo6ReiDgAvUmjg0vOEC4mTqQTfBTjbT3g5JIeSLjvte
         LvBpeVMXga9PpvBU2koCjLGFIXCuOtFQHA2lUf5FEobuq/ulyOvmMxnA17tibqrUPo0f
         AjAvvmmeKjXjvbrtuZIY+V4gsCLz7GwZA6yOp4+JDYsWo4fxZG6/MnyGtv+a7PjiaKnq
         dOdQ==
X-Gm-Message-State: AOAM5311+Bk/IyDKn1Y7L7QVK4dz+E4esGPjCAdvEfqu8Vc2A0bIEmN4
        f4kZdULr8x2PoMlGt/sP+fRotxroUGiqPNk+2JmekUylN3Ewn3BkgYkHIsfQo1b6ZoTxu3ylhD7
        Cyu5XB3f9MxSHGxK2+gQ/eA==
X-Received: by 2002:a05:622a:1c3:: with SMTP id t3mr6038271qtw.351.1643385525968;
        Fri, 28 Jan 2022 07:58:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNHfNKSXr+1lep/iO1OnUsy2vGC9QMAcEvKoGaf9wMxmW0wA7F9StMPgHCj0D2VwKmmzABRA==
X-Received: by 2002:a05:622a:1c3:: with SMTP id t3mr6038262qtw.351.1643385525788;
        Fri, 28 Jan 2022 07:58:45 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w20sm3650313qkp.102.2022.01.28.07.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 07:58:45 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v4 2/3] dm: revert partial fix for redundant bio-based IO accounting
Date:   Fri, 28 Jan 2022 10:58:40 -0500
Message-Id: <20220128155841.39644-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220128155841.39644-1-snitzer@redhat.com>
References: <20220128155841.39644-1-snitzer@redhat.com>
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

