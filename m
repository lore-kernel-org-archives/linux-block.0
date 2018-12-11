Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EF2C6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E161D2084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cUQCB794"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E161D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbeLKAQj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32794 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbeLKAQj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so6214756pfb.0
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CR0GQaJdttUrCvsA2hUdnhy8fVojsRhLDnAew3KP2wg=;
        b=cUQCB79426hxPMsE17jp8UQUOqBRG6YItq3O7GXGi5MqGxCietElMFnfYX+SaI+9Mc
         /ZZEO6BJlYqNQPWD1LcJ+1bYcy7cSAh7KK53RHGl3yIQN7WlsIPvMl1fPpw/kXjtbFc+
         bnLvIWHBQuS+NyyPaJ8MY6V6AZmNwG2rtBn4+pZgBv8+xgMy+0oRyJ/RqYpByyfPO8VX
         tN5KtFqk0TqLH1FWWhPf+rC1A8mIgezWcg6eL/BSnCxU8I5/8D6spLxLEGBxQGgeLssl
         mTs2Pkg4m6gD1JUeO5ZEuMSjylvTZhHjK6g9UufS5gSy+olUbyol5Bo48uI9iily+zOQ
         KEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CR0GQaJdttUrCvsA2hUdnhy8fVojsRhLDnAew3KP2wg=;
        b=Inqnfj7qmjiejSDCKLQ3Gw3AHPfKFfrkfKy+Jhfj/VBZcTyNaSzxYlG1rL83pUUt4p
         SAU/lPxELaYH8CvjkeRCXlpbqqy9DZeocqn0ElXGKx90KtVSa3EHzeBzEcj3am767NEg
         gPPmEDD2fV8n2jqnM8lY90/eDv9dFWcyN7QvghmfFbSvLa4jPfROyCv5S1qntvgF7waK
         1CKqqemV9lsUNjHcmxzgBm9AYkfvgWdb54yp0GqFLQ+GSvVkgV2CXlgmD65GA3gspuHK
         yNRFphsIAbUFGNKmv1kfrhjaiU0tK2qzJNlIYo139ep2D//ObSlROw9DHnFpQLxIVT4e
         5yDA==
X-Gm-Message-State: AA+aEWYvV1NF12F9xPls2bIdCfjvNZ6UR079PmSiTlPS/iMGhis+yR2n
        M1URXuXMUXTGL/n/LiIiAwvSjHiJGvqinA==
X-Google-Smtp-Source: AFSGD/XqR7YeQxAD2uhXDtX/fxk9igDsqWCS4i+JuyJQx3fkDEr62zyS96Hjd/TG6E+98pXe7jhv1w==
X-Received: by 2002:a62:ab0d:: with SMTP id p13mr14301892pff.211.1544487397836;
        Mon, 10 Dec 2018 16:16:37 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 21/27] block: add BIO_HOLD_PAGES flag
Date:   Mon, 10 Dec 2018 17:15:43 -0700
Message-Id: <20181211001549.30085-22-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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
index 036e3f0cc736..03dde1c03ae6 100644
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

