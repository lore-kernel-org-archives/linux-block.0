Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550AAC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079972145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cywvOdps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079972145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeLAEHY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:24 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42605 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeLAEHY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:24 -0500
Received: by mail-io1-f65.google.com with SMTP id x6so5060611ioa.9
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KTzMVdjW5NFmc+ni1z0AYs6SzISV9Szv/UKJuYhDmgM=;
        b=cywvOdps9izJS4wyu2a/6Vi+ryIpdgR6h2qtZGAAW5B0OBsEerT6be7yKT7QQhh8uQ
         9jGKVa4iVqKwcm7kdLrIo1wgmsSmD9FK9rgIdfGQ1RwN9fleMhIiXPo8DX/WdJZghy0l
         zzBdwjgalTExk714jbBtbg0VsU0fleKxJVQI+LpskhRLdTUS0mcE5p5Xe6YRc5fsO45L
         ahkaKeWSVMY5h/kKK5GH0m5zMyhBOXmQlCXKm/jOVXOCPdYPD3tZIKRobQKqCnYi/fj3
         DCqzKneZOW28xyeKxghUc3u0R4b0sLspyUe2fhXl4UPGCn2Yo/VsdCrygfcvMZkeTVb2
         85Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KTzMVdjW5NFmc+ni1z0AYs6SzISV9Szv/UKJuYhDmgM=;
        b=cvLcneDK1fcnQpDnan6bk/BtXqhOGxubZh6iP+G/VgBx2VjrTn+GmQNBAp5eFXN5+5
         3cjk/VJenS6BTbRuj0+fhaGu5/Ca98YiRLP2pgvO4e9Wj0CcKbMmZH5dTXAyYDA8OZKD
         atesiYAR8O4ADwhhJMBS40U3Or2CR+jvm3A4u+FdQeLoJtx/dQ+n2IcYcSYg7EhseZCK
         0KUfT7QuKUe2JITDaeX5oJeHvvpTmwvqUmNUSK0wLgenLcgPjwNk+MCfhVRAN4rFFUUD
         uQ0pYosI9Qgr8jzUyyvo4+9GpkN8T8uotHUHMheEwP6ByqTL8NeGIcqDebA0eItvJ0IT
         MTRQ==
X-Gm-Message-State: AA+aEWaJtJskTUZ0yiJmapBBtfDLa4O8CCukWRoXKkfeN9iCwNcrU0Bg
        lZVOsFNG2wm8cD6wXMJ5jJjWTYiZiVM=
X-Google-Smtp-Source: AFSGD/Xln4DhlHKpJ13gaxoheMc6RZwjWAd+PVZ6X1VhdC3IrOxkzslwk+z094NVyYcV1gcWAxy5bQ==
X-Received: by 2002:a6b:f70a:: with SMTP id k10mr4834429iog.270.1543597048182;
        Fri, 30 Nov 2018 08:57:28 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:27 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 24/27] block: implement bio helper to add iter kvec pages to bio
Date:   Fri, 30 Nov 2018 09:56:43 -0700
Message-Id: <20181130165646.27341-25-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For an ITER_KVEC, we can just iterate the iov and add the pages
to the bio directly.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c         | 30 ++++++++++++++++++++++++++++++
 include/linux/bio.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index ab174bce5436..7e59ef547ed4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -903,6 +903,36 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
+/**
+ * bio_iov_kvec_add_pages - add pages from an ITER_KVEC to a bio
+ * @bio: bio to add pages to
+ * @iter: iov iterator describing the region to be added
+ *
+ * Iterate pages in the @iter and add them to the bio. We flag the
+ * @bio with BIO_HOLD_PAGES, telling IO completion not to free them.
+ */
+int bio_iov_kvec_add_pages(struct bio *bio, struct iov_iter *iter)
+{
+	unsigned short orig_vcnt = bio->bi_vcnt;
+	const struct kvec *kv;
+
+	do {
+		struct page *page;
+		size_t size;
+
+		kv = iter->kvec + iter->iov_offset;
+		page = virt_to_page(kv->iov_base);
+		size = bio_add_page(bio, page, kv->iov_len,
+					offset_in_page(kv->iov_base));
+		if (size != kv->iov_len)
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
index 056fb627edb3..23ae8fb66b1e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -434,6 +434,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+int bio_iov_kvec_add_pages(struct bio *bio, struct iov_iter *iter);
 struct rq_map_data;
 extern struct bio *bio_map_user_iov(struct request_queue *,
 				    struct iov_iter *, gfp_t);
-- 
2.17.1

