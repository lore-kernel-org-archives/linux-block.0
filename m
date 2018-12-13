Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D16FC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C03720870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ku6O3HCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C03720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbeLMR5e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:34 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51811 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbeLMR5d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:33 -0500
Received: by mail-it1-f194.google.com with SMTP id x19so5005869itl.1
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CR0GQaJdttUrCvsA2hUdnhy8fVojsRhLDnAew3KP2wg=;
        b=Ku6O3HCFQtfAlenUOcj0hJieZG7IDYte87OZqkkTXbbBzFkLIQgEoKKBU6ocBFghkG
         qq4pa/zP7pkEZMEDJs0cZ+Zz0otIY1V8phvrOk99qnZHLlLWbWKOFynptQvpeY0C/0tI
         +0mxSbbHyxvshiKhMv3K1F4LMciiajdVMP9Q6W68GdSd8qB5t+tBc7lO9DrA22SH12JN
         2uffHvkHza7uqTvTS0INUZTgHBYla7w9lsumyRUmkhw+M5HLpVjF5PikyC06ArVR1B0v
         mR2V4Qq2V4JzRtcMoDuKiN3EgFbLjdaMfEOJ1Y+ClY/umMj/m/X7V9rCnbGwyxrwdPgx
         6xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CR0GQaJdttUrCvsA2hUdnhy8fVojsRhLDnAew3KP2wg=;
        b=JFgrWAgFxp9s/K5A18j2fzLCXifOEij4bBN7WCrYzayOa0mIyQPI2m551/WukDOlvX
         jQPo3vLiE4pUEbgdBg9cTj2MHJ1JkYp0E0xCsfHsT8P15KnmJFoKhEWyFDB67f2WcpAh
         htqVS6dbkSVPwiOhBWWFctLHqCQnYvwxImXKrju/48g5o4vJYNebDj7PKNVdWiUFlJBj
         EAsulqTLno6SCTWhPMqKmdCM782xX20sFzApHuyVemIBMZN5nUTqkkL9kfhhy5ewFzcU
         bPYcmAcJGsn4R3RDBMIksOohSU7MYiAnA0293Af0sRVnLLVNzdCLwcPUwSlLEvVmK1SS
         zSZw==
X-Gm-Message-State: AA+aEWbmaMEQ1XFsafqJZJCH0EhOa6F00+bqQQOcf8+o9swXHXm/IE/V
        w34tS8OKRUE9kXXwqr2oOZECNE3lcyYdaQ==
X-Google-Smtp-Source: AFSGD/WbFkudTva/C+p514ysQSptG/WOx6953Lq/QII3vdZQ7NmaXhnwe4LXJG4pYvOoEHXZfGdeXQ==
X-Received: by 2002:a24:41ea:: with SMTP id b103mr303142itd.120.1544723851642;
        Thu, 13 Dec 2018 09:57:31 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:30 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 22/26] block: add BIO_HOLD_PAGES flag
Date:   Thu, 13 Dec 2018 10:56:41 -0700
Message-Id: <20181213175645.22181-23-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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

