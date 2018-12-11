Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5587FC04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C52B20870
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gRWJFGeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C52B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbeLKAQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39982 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbeLKAQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so5757816pgp.7
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHa/MPvMTJLNTvt1hlMIAttULRvBKDo+uAclgZHB28s=;
        b=gRWJFGeKm9AzTExGUtyQtCjMEldXDT3NyYLNKD9Y0gHc0NPSAdMbbJhLsqOHj+HLHT
         l8bKVBwIvs+LRibIwpt/0j6CRReCOVEeTaiHEq6NqECkJ31IdvPXTwmZ9JNG+vRefwua
         fYXtQKVSW7dnh/Hz0FTDmdiJ0wGwEkA1lPU0UZcVJXwoQXb0mpJt4Q5XkU/6xWu9BPes
         zh8A3Dbcb8cequbeqGkJ5MjvJcTOQ300oqs/nUGdr3t/5ChoFDYp2KPGgeaRzqMu08qh
         vf0T6A3WfEmHru4WmMYVCH3RvJDpdRqUxYAC+3r7THRml08t8SuRW1AxjCDYORHChvfb
         1BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHa/MPvMTJLNTvt1hlMIAttULRvBKDo+uAclgZHB28s=;
        b=U+8SldYCU9GlrDQq6/p0fQnyyWECj8JUMUj2kbcyhSXmwY4SgI70d5nDHHuRg68wxX
         YlxpLiTjtgO3BJxQ1Acnhf6jpyTc9pa294fEmiwxM1uiM0JjayMftrC49wrO2XkqvWZO
         uKGxu7aylU1lI1XdXZNFMPBEqJDsvQajU8HXuS+xYjA5rF0jWPyeI6SpaM5eFUQ8xlIA
         hE+f1i1m6lqkFxEOg5NsG8Rzecy+H0zcqSTJMMUV/9knBZegDkGve0V/jz2tCRpd6B0r
         fR/N/DoQI1NrH3ae/fuYHZBLpw5CLYLciJUGDGiARiQQOdQ64MvipyOowwlgUuJKFaf8
         0Iqw==
X-Gm-Message-State: AA+aEWYX6QvIGqezhVrfuXyi/0wOe7PUoj+2fguwUQ75RNayx9CaPwM6
        9gANc+Mlk/EHR7dz/bx7LtwAc5czkOXFIw==
X-Google-Smtp-Source: AFSGD/XlwranD+HfzGwVJYnVKfHNI9YDmCf+iaIH7ePV697JRmIY78pW90V8CWsjKdu2B+GrBRrG0g==
X-Received: by 2002:a62:938f:: with SMTP id r15mr14216577pfk.27.1544487399870;
        Mon, 10 Dec 2018 16:16:39 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 22/27] block: implement bio helper to add iter bvec pages to bio
Date:   Mon, 10 Dec 2018 17:15:44 -0700
Message-Id: <20181211001549.30085-23-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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

