Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E21C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465BD206B6
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="djIibfsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465BD206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeLDXi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42729 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeLDXi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so4267293plp.9
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7QkOJIdwfAgSYahhwfwYvkmzaNCDGUD8Z2PwUSvN4TU=;
        b=djIibfsyBElfuwMuiHGfyhE2Lrff+914xqBrZqye1bAvmb1N5MAPnOFQatrmNCqsDz
         bOf1DfLNNl6grdz5Pq8yyullje7fWdsvj1O09q756OU//oyxjG+g6PRg4+NjztOoVPdu
         yXUQ65s6wErml1ekLbaHUChf+/HB5Ev8qiGiM1oTvZpefXfyEFxH0pkV8vB+r+ZH+zpL
         OgdX0rKqSbzQ4wI/Fc66gWYcwZW4wxwcgCWYnhafsjTro+BE9q8UZtBalfbfe62RcC31
         yOmsC6g0wvTagpcsuNtb27Mha5SdnkNFwzP1uIiBdbb7w2ogIxw9VyAJ/4lgCCQ0nNKl
         yuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7QkOJIdwfAgSYahhwfwYvkmzaNCDGUD8Z2PwUSvN4TU=;
        b=ZaodNy+1otIKL/3ZW5MsGPj2VT0g5S3I+RE76lEqgJw5tfIdfqlxzL1qXR5tUFwfLU
         PvgVa6kSVB/M0Xw1jbljCYGVmcbVNSvlbP9ccTr/Ecbqnlju7JOz1EWwXgC+4pIEl45i
         moWijE56OpXR9+d18bGrBsufBVoR08IxWZ0NkS40B8V9yffjpYfrnuI0YBX4r7e8VVL2
         //76yTsKOyUA/KZcx+j/autS3fV8jaFSGOy4DRlysBzZVMmVN734BBHEEZJbEiPFFgvx
         sYXbFT6t6B65Qle7XnEJesDZcux+KZx2SHy7KTA8Hsq1gCSO7SbAOubaYRK/41EShFQ3
         uuqA==
X-Gm-Message-State: AA+aEWb6ZC+PJA6MBhTdVA/177VuJ3DMDY49dY74S/m7DC+xTaM3Isks
        oC7npbTbmgj7b+EwgEvbdG7zyTYbyZ4=
X-Google-Smtp-Source: AFSGD/Xyz58/Dp/UjaBS0nA0vu9Pdfudz4SYcLlBKlTHA3dX6m0/+xK1df7t4zfbFZJ6VOr66mr0Ow==
X-Received: by 2002:a17:902:34a:: with SMTP id 68mr22536321pld.268.1543966706496;
        Tue, 04 Dec 2018 15:38:26 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 21/26] block: add BIO_HOLD_PAGES flag
Date:   Tue,  4 Dec 2018 16:37:24 -0700
Message-Id: <20181204233729.26776-22-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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
index 03895cc0d74a..ab174bce5436 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1635,7 +1635,8 @@ static void bio_dirty_fn(struct work_struct *work)
 		next = bio->bi_private;
 
 		bio_set_pages_dirty(bio);
-		bio_release_pages(bio);
+		if (!bio_flagged(bio, BIO_HOLD_PAGES))
+			bio_release_pages(bio);
 		bio_put(bio);
 	}
 }
@@ -1651,7 +1652,8 @@ void bio_check_pages_dirty(struct bio *bio)
 			goto defer;
 	}
 
-	bio_release_pages(bio);
+	if (!bio_flagged(bio, BIO_HOLD_PAGES))
+		bio_release_pages(bio);
 	bio_put(bio);
 	return;
 defer:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1d9c3da0f2a1..344e5b61aa4e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -227,6 +227,7 @@ struct bio {
 #define BIO_TRACE_COMPLETION 10	/* bio_endio() should trace the final completion
 				 * of this bio. */
 #define BIO_QUEUE_ENTERED 11	/* can use blk_queue_enter_live() */
+#define BIO_HOLD_PAGES	12	/* don't put O_DIRECT pages */
 
 /* See BVEC_POOL_OFFSET below before adding new flags */
 
-- 
2.17.1

