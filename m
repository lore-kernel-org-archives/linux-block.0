Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11340C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B0520870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Dm4qNKUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B0520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbeLMR5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:36 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38349 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbeLMR5e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:34 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so5188852ith.3
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHa/MPvMTJLNTvt1hlMIAttULRvBKDo+uAclgZHB28s=;
        b=Dm4qNKUT0UH2vQ0zBtXG2cBEU2EAp27PIVNpP6UBFQQxPxctxYSFI7GHI08Yho9U6p
         D8HGViWxhicHbdzOsplRvhk2pvXrMhe9Ck5u40an887MDEoRN4+VuIdXARGFK1DoumyD
         Zwpqsgen35Vdzauvt5uDSoinNaelZFAX8vreoHPGdxD7jtlJP+p5LskIfLdGDrO+kAIE
         D/0NHwaRUIsBwVfp41zM+KJZqvNJXSwe1cyYU2XW1nS3Z5D7gt6Dqj3SWHuWJjDr/Yai
         X1cMACLqj89BkC6c4k2mSGm7tTFeOwGmt7DHN46JpwlCWDtU0UoNtLO4IsY9lzKq5zts
         jR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHa/MPvMTJLNTvt1hlMIAttULRvBKDo+uAclgZHB28s=;
        b=E40BIWi/7dc0OpjOfCPdlbo05AgObbUGfD1JVqkC431YGt0vg9nRsrVdP8PFd7/Yb9
         UOGXlCw8G9hX6l0W356Fp2R1WOae1MZGPqS1nLM7nNkaPnJYK8TYbIFvezrMKztKu3TA
         Q73otEEukHNgq2vgIK7ptdrtVaYRa4jokP3I7SD3tStH0X2A9w1WjgpUeAWrgwnMvkmH
         Gneb0XLdYQ/Np3mqz+fmnL9lhI0Axg/YepEq3BEq4rC4PEa7MQtfYWhSAR8nQxLUwI4L
         YyTufutVZVGQJCebqR09z0uDrJIy0hsAhcqVkHjRx1hhwX1IGiH3Y4S9h/KEcZ3EdIx0
         JROg==
X-Gm-Message-State: AA+aEWb+x3Zfd7KCcEl1sAyASXnlU15yvqRBz2uTLBjx6sSZ1TafN6sT
        qwY2GR7L6cY+rxh3KO2/BXauws9xduVnRA==
X-Google-Smtp-Source: AFSGD/XSHKS8oYDn4yCAwOlKXKVM/dO/9w1qtH3SDCXdKhomNtsJpemgldAUrk5w8grqcYiNZPh6HQ==
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr302750ite.72.1544723853307;
        Thu, 13 Dec 2018 09:57:33 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:32 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/26] block: implement bio helper to add iter bvec pages to bio
Date:   Thu, 13 Dec 2018 10:56:42 -0700
Message-Id: <20181213175645.22181-24-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For an ITER_BVEC, we can just iterate the iov and add the pages
to the bio directly.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c         | 27 +++++++++++++++++++++++++++
 include/linux/bio.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 03dde1c03ae6..1da1391e8b1d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -904,6 +904,33 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
+/**
+ * bio_iov_bvec_add_pages - add pages from an ITER_BVEC to a bio
+ * @bio: bio to add pages to
+ * @iter: iov iterator describing the region to be added
+ *
+ * Iterate pages in the @iter and add them to the bio. We flag the
+ * @bio with BIO_HOLD_PAGES, telling IO completion not to free them.
+ */
+int bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
+{
+	unsigned short orig_vcnt = bio->bi_vcnt;
+	const struct bio_vec *bv;
+
+	do {
+		size_t size;
+
+		bv = iter->bvec + iter->iov_offset;
+		size = bio_add_page(bio, bv->bv_page, bv->bv_len, bv->bv_offset);
+		if (size != bv->bv_len)
+			break;
+		iov_iter_advance(iter, size);
+	} while (iov_iter_count(iter) && !bio_full(bio));
+
+	bio_set_flag(bio, BIO_HOLD_PAGES);
+	return bio->bi_vcnt > orig_vcnt ? 0 : -EINVAL;
+}
+
 static void submit_bio_wait_endio(struct bio *bio)
 {
 	complete(bio->bi_private);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7380b094dcca..ca25ea890192 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -434,6 +434,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+int bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter);
 struct rq_map_data;
 extern struct bio *bio_map_user_iov(struct request_queue *,
 				    struct iov_iter *, gfp_t);
-- 
2.17.1

