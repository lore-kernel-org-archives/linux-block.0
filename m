Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B71C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 22:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiA0W44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:56:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235304AbiA0W44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 17:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643324215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=tQTNouHLD2pqrJUsY0rGuooqQ0qZGduHNcta+zU07XE=;
        b=Hy656/MPtbbDSXvaGv9sEUwLf8U8UijJgFTOO83RJBuuwSjnTKg7fFEH6xeEn+kMK64Ryf
        JhoheFQYnKo4hv4/7kr3vh+5Tr9G3zWDusHSo4cXIOIZ66ifNEtpWU9RVK+lLFYKo2A7ey
        tC0yvFCSbOe+f+uyJrGgU+TbrBdhoIY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-zzUAaXg0OyGZUmLir0lFnA-1; Thu, 27 Jan 2022 17:56:53 -0500
X-MC-Unique: zzUAaXg0OyGZUmLir0lFnA-1
Received: by mail-qk1-f198.google.com with SMTP id u17-20020a05620a431100b004765c0dc33cso3511454qko.14
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 14:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQTNouHLD2pqrJUsY0rGuooqQ0qZGduHNcta+zU07XE=;
        b=Y6Xe8Rsm/D3p+bU9xvZHEWLGvP426PvkRQwC4yrMF/0XXjb+eWYbrzKis5i2Pdu5M8
         FOhcMsxtw9Aur7uexVU6isAY8oMCqjsAdsUDyo4Z0ts5v4idxlcqzJkDeehfRoLwAWN6
         TmPi66iR1GFHrx7lq7V1P6SgQH9mq21v6iqbeKX2jP8fZFl79VwxWIEE6jb9btTPJUXo
         5KRb6MDnUb3xr4jXpF62uJjfjQDqaFqWyldZReoXLdIodU2ZZd1JWsrtlr72iUJKK5q1
         dm85FvLIXIiAtoP9Y3FKN9gc8od5k9nQSJKIU1tgB0nj/2yWlg7nVtA15pp/jqRz9P3W
         3jzA==
X-Gm-Message-State: AOAM531lRVeVpWEHhoyr/4ab58n44w81U+1Gbqgb9y6K/LS0XKh+xjnV
        H2n7XFsEUafAFfRCHRQtF0IYJKt06wQMS1nHerJc3G+d7t7oM2hJJIV7K3NryyXc1Cg+AudQeS7
        QWedT2JBD7jIdFXYFfRlkZQ==
X-Received: by 2002:a05:620a:103c:: with SMTP id a28mr4150249qkk.417.1643324212904;
        Thu, 27 Jan 2022 14:56:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL2H63eKsh0Qu7Yz6ytqgIu4GetPzYuDGznITAsL1ZAj2qOMKyljpt5v1X/OwIwEtcD0UfYw==
X-Received: by 2002:a05:620a:103c:: with SMTP id a28mr4150241qkk.417.1643324212703;
        Thu, 27 Jan 2022 14:56:52 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id p134sm2016512qke.29.2022.01.27.14.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 14:56:52 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v2 2/3] dm: revert partial fix for redundant bio-based IO accounting
Date:   Thu, 27 Jan 2022 17:56:47 -0500
Message-Id: <20220127225648.28729-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220127225648.28729-1-snitzer@redhat.com>
References: <20220127225648.28729-1-snitzer@redhat.com>
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

