Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01D9C64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A1C2083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HLYj8QAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A1C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLGWVE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:21:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43779 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeLGWVE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:21:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so2293121pgk.10
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qHGUyfMFPUHePmcCM/30R2Nq4Nobfnj5bVLJuuayYxs=;
        b=HLYj8QAKuvg6vFqQeQEjbn1uUwvS+3UwseMPUNQE3zRB2IuTFM27kHoHS83wKDo3Hf
         CtlmScrJoZfZDq0u/sFgDqnUYEdWxG0Bjt7glgz/OGOMPEXBZ4P7EtilTSThq9j+F+fU
         4jmf/GTkspYhOGGZSKg7h97vVOEhqiefG4tUbF8mfmzrTWERJHjsqbtLXquonwgLR0UL
         oVqgqTmeh1hO5n2HTH+jtGeX0FH6vlgv9BJf26X90f8uTx7URf0REFk41kEU/QoPYC1j
         hR5tD/0PE9/8sy1dYZDyjNq1SIm6k+EEi5VIp1+Ey+zMTNuB3DXrDL5mi5nVyahkTzB1
         wTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qHGUyfMFPUHePmcCM/30R2Nq4Nobfnj5bVLJuuayYxs=;
        b=cModdYGQ2oCPpRZnI5dOe47G17OZQK8JzqHht/n0rVeu+K3qwHBUYPxXppV0RBYcC8
         geS9daQ0X9e30meLIVunfHs2Iq3Ay/QfR7Z2q69fY1demcxXIY02Jt7c/XvdhCLrWRRj
         ZcaZmta97hJ8ESY0OdzuvN6GDEIBc49HYFP9XO57yx3vAFZNf4T0kSIgYUrszhNXmT5l
         hmD2slesILfefkwfTzrug6VsXu9nbxJ9KbMkmSuSUcKmo1k/UJtvUSUeTV2VWhWriv5Q
         Ofl4Leplo/uv7syXwYhPg26zJ3dPk71vQnoMO199uFyRWUi8P7Tgtc9fwYa/QKD/e5iN
         adOw==
X-Gm-Message-State: AA+aEWZF6bOigVmKJtCQMcayacvT8poFyygOylIdQvnhKKby+VRMirUr
        97blD9kF5Br/WTQiLXFuQ39e4z1zdHQ=
X-Google-Smtp-Source: AFSGD/UdNL9M+7tBMv1YOKzwTcKOdwgKr9dJ/Bk8jdy8STrmHXnTOVgxqL9MMwEBbqM/Usr7jgdGTQ==
X-Received: by 2002:a63:cf08:: with SMTP id j8mr3552907pgg.113.1544221262694;
        Fri, 07 Dec 2018 14:21:02 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:21:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 21/26] block: add BIO_HOLD_PAGES flag
Date:   Fri,  7 Dec 2018 15:20:11 -0700
Message-Id: <20181207222016.29387-22-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For user mapped IO, we do get_user_pages() upfront, and then do a
put_page() on each page at end_io time to release the page reference. In
preparation for having permanently mapped pages, add a BIO_HOLD_PAGES
flag that tells us not to release the pages, the caller will do that.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c               | 6 ++++--
 include/linux/blk_types.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 06760543ec81..3e45e5650265 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1636,7 +1636,8 @@ static void bio_dirty_fn(struct work_struct *work)
 		next = bio->bi_private;
 
 		bio_set_pages_dirty(bio);
-		bio_release_pages(bio);
+		if (!bio_flagged(bio, BIO_HOLD_PAGES))
+			bio_release_pages(bio);
 		bio_put(bio);
 	}
 }
@@ -1652,7 +1653,8 @@ void bio_check_pages_dirty(struct bio *bio)
 			goto defer;
 	}
 
-	bio_release_pages(bio);
+	if (!bio_flagged(bio, BIO_HOLD_PAGES))
+		bio_release_pages(bio);
 	bio_put(bio);
 	return;
 defer:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 921d734d6b5d..356a4c89b0d9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -228,6 +228,7 @@ struct bio {
 #define BIO_TRACE_COMPLETION 10	/* bio_endio() should trace the final completion
 				 * of this bio. */
 #define BIO_QUEUE_ENTERED 11	/* can use blk_queue_enter_live() */
+#define BIO_HOLD_PAGES	12	/* don't put O_DIRECT pages */
 
 /* See BVEC_POOL_OFFSET below before adding new flags */
 
-- 
2.17.1

