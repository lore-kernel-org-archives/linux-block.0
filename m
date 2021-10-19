Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A4C4332F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3902861373
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhJSV0w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhJSV0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E089C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so5646162wma.4
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ICDlpdHaMs6WzUPBmP4eN3qDpmvcW1LE/BZ0WZUx5Rg=;
        b=mlGdcTPb6zhfu1AmwUQbQIpdzrtm2cVcE8QINvTIAhGqvKQZT7xKXuB3XUz8HhJ+Lg
         nY2lKUeeH7L8D+mJImfbX0n99B70a77IAnCvEJEyMop/TiwDqsXbmn3P8YJWs3CDW5fS
         DM52TPnaGj41AHca3rFktM1U9M7gnmnOu5AEO/A+k7mGk4mnQIkYRWqqJ2qo0wf5gYvJ
         xehs2uC1HRDFRq6a/PHhw2O35CFkY9tQsYJwISm42MrvI5fr8NPKpnFwlWC6w8NJYA70
         19dKsRGhZHR6uvIsYK/cDEjQ8Y0nTA3YL6kRNGAegkSp21Drav3EL9fYXOE/rvY3COUC
         Dikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ICDlpdHaMs6WzUPBmP4eN3qDpmvcW1LE/BZ0WZUx5Rg=;
        b=HIdtF/zNgZH/Xw0H2YNHucoTdKrHSWUyIRmVM/TLoE8KXKpIY5tVOpjISMy4Aei9T/
         Ag7fzPTp87mxtLu12AiHydmt3J3joF6iBNP0F8lATfa1BKSEi0P45zJXPE8pbndzm1ip
         0sJfjdLJSfPyzJ2kY7t2flzDotCaMQYOCRRaxmt+Psqx6rpCzH23H5A5W4ZFkpXZUi3w
         xXHrX18XybicVwh++S8bl/G7EkwcH28TA8JeZDNGLzYOrgo33c058kvdCi/j8htKA+6q
         NGGIV2sJD4/pUfsUCBI3GApBt6G+9Pk3ZMLqqkLoY/MNnJsI7QeB2ksRnWNv1Pp/s7gH
         duoA==
X-Gm-Message-State: AOAM530kcBJNdfeV/YVC0xBIF95LWmnyGXG8bkf1mMUujmG12cFQ66Og
        EQXtZeOTYRbSi82rpyAwpQ0Ersz0Zoxksg==
X-Google-Smtp-Source: ABdhPJzBLAQtr2uRuy1FIBeGI2kIOoSTtYmUwBbtU5uOs2+d8CVEPIcgveU9td/VHIde1txTpTdWXw==
X-Received: by 2002:a05:600c:209:: with SMTP id 9mr8796730wmi.42.1634678676855;
        Tue, 19 Oct 2021 14:24:36 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:36 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 05/16] block: inline a part of bio_release_pages()
Date:   Tue, 19 Oct 2021 22:24:14 +0100
Message-Id: <c01c0d2c4d626eb1b63b196d98375a7e89d50db3.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inline BIO_NO_PAGE_REF check of bio_release_pages() to avoid function
call.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c         | 7 ++-----
 include/linux/bio.h | 8 +++++++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4f397ba47db5..46a87c72d2b4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1033,21 +1033,18 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
-void bio_release_pages(struct bio *bio, bool mark_dirty)
+void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct bvec_iter_all iter_all;
 	struct bio_vec *bvec;
 
-	if (bio_flagged(bio, BIO_NO_PAGE_REF))
-		return;
-
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
 		put_page(bvec->bv_page);
 	}
 }
-EXPORT_SYMBOL_GPL(bio_release_pages);
+EXPORT_SYMBOL_GPL(__bio_release_pages);
 
 static void __bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 {
diff --git a/include/linux/bio.h b/include/linux/bio.h
index b12453d7b8a8..c88700d1bdc3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -417,7 +417,7 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
-void bio_release_pages(struct bio *bio, bool mark_dirty);
+void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
 
@@ -428,6 +428,12 @@ extern void bio_free_pages(struct bio *bio);
 void guard_bio_eod(struct bio *bio);
 void zero_fill_bio(struct bio *bio);
 
+static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
+{
+	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+		__bio_release_pages(bio, mark_dirty);
+}
+
 extern const char *bio_devname(struct bio *bio, char *buffer);
 
 #define bio_dev(bio) \
-- 
2.33.1

