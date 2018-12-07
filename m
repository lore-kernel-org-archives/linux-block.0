Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D05C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE74720892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j7ai4T47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE74720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeLGWVG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:21:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41486 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeLGWVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:21:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so2569070pfi.8
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l+G2ayniAzRV+upTz48Z9LC9V1kcFWjPEF7AeVywtTI=;
        b=j7ai4T47xsc2iEqx8lmS22reuF8fx7v0qZWySNmTPh4FsAhHDy1oP75ErMu7FC+IXg
         xMfArmp7hiGZMllbAkEk9hY7AHaomkeJX0X+XANWMg6dDWo8Ztv6J3pbtI8GS0xT9Ow6
         XrEuaIhKJnJjqtRmACtn5aZuHdVS3XYXaYurr43uGXqs6ZfpS5Ri6VBB3y1XamPWgoJO
         PqC/xbR68UKCIXQ5RU+Js2OgJiQs5URB/64YCZ56VCef8VROnjwcF6rMRQnGF7Fe1vSf
         H1emvK8HZZaHQKg3WgGSLzapFSMd7W5WRcRxD2+2bex4wRcLP791P5rqHROJaCVNDtU6
         N0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l+G2ayniAzRV+upTz48Z9LC9V1kcFWjPEF7AeVywtTI=;
        b=pIjNLkK+ppzyHUiUuPk3GVulrmzcAmwpqTTIh6gj3N8c1bp5rUwLiQscirumXJ1uYe
         zJSqW0VP9oNSqmROTJvk9JkniZw26+PvDccol+IknS1MuuoFrnfEWz0qMELrNAzz8Y3W
         uUEcAAvvvhIBvm34mljSvGdlIq5c5/R7fQBUQggrpGqRVKgBUve9qGQV+ThL2EduAb1A
         0KSSA2W9+OcjrsCc0ovzgKWySiOQLdR/kTTkewJSEk5XmW5J5hOERcg6B3E7Dsu7LsHt
         qwFJvIKrpV3TOMqGsJFveiG3Pzg9oI345A+6eLGlSPiQnEtqa8dQfDf/KCk9ZHd4Nse0
         nY+w==
X-Gm-Message-State: AA+aEWb5uK4kpN+MwLNSd9K7UjM8qozK4lQb75BjsQQQUOWVrlTNNuDW
        zkVUAme//drLbb7OiUJTtDukExeTSUw=
X-Google-Smtp-Source: AFSGD/Wl6HGR/AtY5Hu5MJMTrwz9JfIZEW/HFZ4UcroV4d8aMJ2awWp5MRkgYO8aHs3ydznOTLoLAA==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr3998859pfb.55.1544221264625;
        Fri, 07 Dec 2018 14:21:04 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:21:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 22/26] block: implement bio helper to add iter bvec pages to bio
Date:   Fri,  7 Dec 2018 15:20:12 -0700
Message-Id: <20181207222016.29387-23-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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
index 3e45e5650265..8158edeb750e 100644
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

