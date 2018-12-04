Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36072C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED71720850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hKAhSJ7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED71720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeLDXia (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45984 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeLDXi3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so9065354plm.12
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H/nxDHAB/OPHiKU4vV61gL4I+W3NMxEoNevWsSgLfuE=;
        b=hKAhSJ7rdP9szqo4HDJXZNOVgveXC19Y2qvki9NytTk/WIpw0QhoOHTrRW9hjJy3pX
         iERJ1HzXfx9NWRMn6erEE2ezRU23tGuj5FG8JmT2jHjnrsOi9/JbKg6ESla32RiN2XIQ
         INaEe30+cTyLV2vuKBwnXLHSPbMhm8uk/pPY5qkuk6lBOUrpnR8NUeaozfF2fj9jU26Q
         YT2KJlGKUkMq+WT0IWMcDg+rBynPfJYpvE3ubzvpWQxcELzJJvy3h3k7YQ/HzVhDjj4k
         ljWY6OOT44fsGB/QZSQFbP2UJfB34SW1N0m+EQe5juZ8d8IBhsRuxqDXC19gCx8W5B6z
         QNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H/nxDHAB/OPHiKU4vV61gL4I+W3NMxEoNevWsSgLfuE=;
        b=JR0zAKF/iEpL3S+UMCBKYxDPgtu/njwP4wILeDRM+v24r/pbgr4095LvpJWfAlDuzd
         da/wGNTjsC1Ha/AN8P0p3nPkx/ZJqNGr6O6B9n54qqM/ymhwfHg1E7zFgTBTzhT+cUJ6
         p3QYy3tpwttY/ozDA0jZ/klewEKDXJYU41S3j6TeYSwKEIIFEmS12BiUcjY7f9wWGYMa
         vofFBEFAnkD8tGelRHYzdSxMMSxaLl6FT+KGU2CPyVfA2bFEVRoOxOwKQwr/lfGVVa6Z
         HjOvec5m3gBNztrFl19YRL3hLtJegF7CbsLvBjlKYQC7mKHsRQ93aT5ZmKtFC1O10q1I
         AP3g==
X-Gm-Message-State: AA+aEWYqRb6Lj0rDq6wiR3SqgG0m53iGkeU50CxG77bfOTchN/xfS0Sv
        ns03IyZuupWQcH6ZSOyH6h3qMWVmf08=
X-Google-Smtp-Source: AFSGD/Uytif9H5edEwA0CdsjuwdlEggcz/ayI7/UfSZNTPDUTEIgeIpihVZAgbsVT2+BV7TZOcmqDw==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr22178536plo.257.1543966708395;
        Tue, 04 Dec 2018 15:38:28 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:27 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 22/26] block: implement bio helper to add iter bvec pages to bio
Date:   Tue,  4 Dec 2018 16:37:25 -0700
Message-Id: <20181204233729.26776-23-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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
index ab174bce5436..0e466d06f748 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -903,6 +903,33 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
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
index 056fb627edb3..39ddb53e7e7f 100644
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

